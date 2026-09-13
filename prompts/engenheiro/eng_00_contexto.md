ID: eng_00_contexto
Trilha: engenheiro
Tela: nenhuma (rodada de contexto: plano, stack, arquitetura, modelo de dados, convenções e fundação do repositório)
Data: 2026-09-12

---

# Maxx: kickoff técnico

Leia o `CLAUDE.md` na raiz do repositório antes de qualquer coisa. Ele descreve o produto
(Maxx, rede UniEduk), quem usa, o que o app tem e como funcionam prêmios e pontos. Nada
dele muda nesta rodada. O que eu faço aqui é fixar como esse produto vai ser construído:
projeção, stack, arquitetura, modelo de dados, convenções, testes, git e definição de
pronto. Nesta rodada não existe tela nem funcionalidade. Quero plano, documentos, as
regras gravadas como contexto do projeto e a fundação do repositório pronta e verde.

## 1. Como trabalhar comigo

- Ordem de trabalho: primeiro os documentos (plano, arquitetura, modelo de dados),
  depois as regras no `CLAUDE.md`, depois a estrutura do repositório e a fundação
  (tooling, banco, migration inicial, seed, CI). Não escreva código de funcionalidade
  nesta rodada.
- O que está decidido neste documento é decisão, não sugestão. Não me peça para
  confirmar o que já está aqui.
- Se encontrar um conflito real entre duas decisões daqui, ou uma decisão que você
  considera inviável, pare e me pergunte com as opções, os prós e os contras de cada
  uma. Não escolha por mim nesses casos.
- O que você achar que eu deveria reconsiderar, registre na seção "Recomendações não
  aprovadas" do plano, sem implementar.
- Documentação, identificadores de domínio (entidades, campos, rotas) e textos de
  interface em português. Mensagens de commit em inglês, no imperativo.
- Cite ferramenta e versão pelo nome. Nada de "um ORM" ou "um framework de testes".
- Ao terminar, rode lint, typecheck, testes e build e me mostre a saída. Não encerre
  com algo quebrado.

## 2. Projeção e requisitos não funcionais

O campus tem cerca de 3.200 alunos. O pico realista é de 2.000 usuários simultâneos
(nunca todas as turmas de todos os períodos ao mesmo tempo). A infra do primeiro deploy
é a mínima (uma VPS), mas a arquitetura é dimensionada para a projeção, não para o
deploy inicial. Concretamente, seis requisitos não funcionais que valem desde o
primeiro módulo:

| # | Requisito | O que isso obriga |
|---|---|---|
| RNF1 | Fotos nunca passam pela API | Upload direto do cliente para o bucket por URL pré-assinada; leitura pela CDN, também com URL assinada e expiração. A API só grava metadados. |
| RNF2 | API sem estado | Nenhuma sessão, cache ou arquivo em memória de processo. Subir uma segunda réplica tem que ser uma linha a mais no Compose. |
| RNF3 | Feed paginado por cursor | Cursor por (data de criação, id), com índice composto. Nunca `OFFSET`. |
| RNF4 | Ranking pré-calculado | View materializada ou tabela de ranking atualizada por job. A leitura do ranking nunca soma pontos em tempo real. |
| RNF5 | Pool de conexões e limite de taxa | Pool dimensionado e documentado; limite de taxa por usuário nas rotas de upload e de escrita. |
| RNF6 | Jobs em fila no Postgres | Recálculo de ranking, notificações e regras automáticas de troféu rodam fora da requisição, numa fila no próprio Postgres (`FOR UPDATE SKIP LOCKED`), sem Redis nem broker. |

Verificação: vou rodar teste de carga com k6 nos cenários de leitura do feed, leitura do
mural e upload de foto, com 200 e com 2.000 usuários virtuais. Meta: p95 abaixo de 500 ms
nas leituras e taxa de erro abaixo de 1%. Registre no documento de arquitetura como cada
RNF é atendido e onde o teste de carga tende a doer primeiro.

## 3. Stack (decisão por camada)

| Camada | Decisão | Por quê |
|---|---|---|
| Cliente | Expo (React Native + TypeScript) com Expo Router, build web habilitado | Um código para Android, iOS e web; tipos compartilhados com a API; o build web serve para os testes ponta a ponta e para demonstração |
| API | Node 22 LTS, Fastify 5, TypeScript em modo estrito | Baixo custo por requisição, plugins com escopo, validação por schema integrada; é o que eu domino em Node |
| Contratos | Zod num pacote compartilhado (`packages/shared`) | Schemas, enums e chaves de permissão numa única fonte, usados pela API para validar e pelo cliente para tipar |
| Banco | PostgreSQL 16 | Transações, constraints, índices e views materializadas resolvem auditoria, invariantes e ranking sem serviço extra |
| Acesso a dados | Drizzle ORM com drizzle-kit (migrations versionadas) | Schema em TypeScript, SQL explícito quando precisa, nenhuma query montada por string |
| Fotos | Storage S3-compatível: MinIO no desenvolvimento, bucket S3-compatível com CDN em produção | Atende o RNF1 sem a API carregar bytes |
| Jobs | Fila no Postgres, worker como processo separado no Compose | Atende o RNF6 sem infra nova |
| Deploy | Docker Compose numa VPS, Caddy na frente (TLS automático), Postgres em volume com backup diário | Infra mínima para o volume real de agora; a API sem estado permite escalar horizontalmente depois |
| Testes | Vitest (unitário e integração), testcontainers (Postgres real), Playwright (ponta a ponta sobre o build web) | Regra de negócio testada isolada; persistência testada contra o banco de verdade; fluxos críticos testados de ponta a ponta |
| Qualidade | ESLint, Prettier, `tsc --noEmit`, CI no GitHub Actions | lint, typecheck, testes e build em todo push e pull request |
| Monorepo | pnpm workspaces: `apps/mobile`, `apps/api`, `packages/shared` | Compartilhar tipos e schemas sem publicar pacote |

Fora do escopo por enquanto, dimensionado para o problema: Redis, Kubernetes,
microserviços, GraphQL, Next.js, Prisma, broker de mensagens, notificação push. Se algum
RNF não fechar sem um deles, me diga onde e por quê antes de adicionar.

## 4. Arquitetura da API

Três camadas, com dependência numa direção só:

```
rota  ->  serviço  ->  repositório  ->  Postgres
```

- **Rota**: recebe a requisição, valida a entrada com o schema Zod do pacote
  compartilhado, verifica a permissão exigida, chama o serviço, serializa a saída.
  Nenhuma regra de negócio na rota.
- **Serviço**: dono da regra de negócio e da transação. Toda mudança de estado acontece
  aqui, e toda escrita grava a entidade e o registro de auditoria na mesma transação.
  Um serviço depende da interface do repositório, nunca da implementação.
- **Repositório**: acesso a dados via Drizzle, atrás de uma interface. Sem regra de
  negócio. É o que os testes unitários do serviço substituem por implementação em
  memória.
- **Serializador**: por entidade e por perfil de quem pede. Nenhuma rota devolve o
  registro cru do banco.
- **Plugins do Fastify**: autenticação, autorização por chave de permissão, banco,
  storage, tratamento de erros, limite de taxa. Cada rota autenticada declara a
  permissão que exige.
- Autenticação por sessão revogável no servidor (os detalhes eu fecho na rodada do
  login). Autorização por chave de permissão (por exemplo `medalha.conceder`,
  `aviso.publicar`, `premio.cadastrar`), com a matriz perfil x permissão no pacote
  compartilhado.
- Erros de domínio são tipados (classe por erro) e mapeados para HTTP num único lugar.

## 5. Modelo de dados inicial

Modele a partir do `CLAUDE.md`. Entidades mínimas: usuário (com perfil aluno, professor
ou instituição), aluno (RA, curso, semestre, situação: ativo ou ex-aluno), professor,
curso, turma (e o vínculo professor, turma, aluno, por período letivo), prêmio (tipo:
troféu ou medalha; tier; pontos; se exige comprovação por foto; se é concedido por regra
automática), concessão de prêmio (prêmio, aluno, quem concedeu, foto de comprovação,
situação: ativa, contestada ou revogada), post (autor, foto, legenda, concessão opcional),
curtida, comentário, seguidor, aviso (categoria: faculdade, curso ou professor, e o
escopo a que se aplica), leitura de aviso (quem leu e quando; a coordenação vai pedir
isso para cobrar os professores, então já nasce no modelo), notificação, auditoria (quem,
quando, entidade, id, ação, estado antes e depois em JSON), job da fila, e a tabela ou
view do ranking.

Invariantes, que valem no schema Zod, no banco (constraint quando der) e no serviço, e
cada uma vira teste:

1. Os pontos de um prêmio ficam dentro da faixa do tier: Bronze 1 a 30, Prata 31 a 70,
   Ouro 71 a 100, Diamante 101 a 150. Fora da faixa é erro de validação, não ajuste
   silencioso.
2. Aluno não tem tier. A pontuação do aluno é a soma dos pontos das concessões ativas.
   Concessão contestada ou revogada não pontua.
3. Professor só concede medalha, nunca troféu, e só a aluno com quem tem turma em comum
   no período letivo vigente. Troféu é concedido pela instituição ou por regra
   automática.
4. Prêmio que exige comprovação não é concedido sem foto.
5. Ex-aluno mantém acesso e posição no ranking, mas não recebe concessão nova.
6. Ranking ordena por pontos em ordem decrescente. Desempate por quem atingiu a
   pontuação primeiro: compara-se a data da concessão ativa mais recente de cada aluno,
   e a mais antiga fica na frente; persistindo o empate, RA crescente. O critério fica
   documentado e testado; ranking instável é bug.
7. Um post referencia no máximo uma concessão, e só do próprio autor.
8. Toda escrita grava auditoria na mesma transação. Escrita sem auditoria é bug.

Dados sensíveis: RA, e-mail, fotos de comprovação. RA e e-mail nunca saem para outros
alunos; a foto de comprovação só é visível para quem concedeu, para a instituição e para
o próprio aluno. Isso vale no serializador e nas URLs assinadas.

O corte de período dos rankings "geral" e "por curso" (em oposição a "all-time") eu defino
na rodada do ranking. Modele a concessão com data e período letivo para permitir os dois
cortes sem migration nova.

Documente no modelo de dados: entidades com campos e tipos, relações, constraints,
índices previstos (ao menos: cursor do feed, ranking, avisos por escopo, concessões por
aluno) e quais invariantes viram teste unitário, quais viram teste de integração.

## 6. Fluxos de exemplo (viram testes de integração quando o módulo entrar)

Use estes dados de exemplo no seed de desenvolvimento e mantenha os nomes consistentes;
os mockups que vou anexar nas próximas rodadas usam os mesmos.

- **Fluxo A, medalha.** A professora Ana leciona Banco de Dados para a turma ADS-3
  (noturno). Concede a medalha "Participação no seminário" (Prata, 40 pontos) ao aluno
  João (RA 2023001), que está na turma. Resultado: concessão ativa, João soma 40 pontos,
  auditoria com professora, aluno, prêmio e data na mesma transação, notificação
  enfileirada para João. Contra-exemplo: Ana tenta conceder a mesma medalha ao Pedro
  (RA 2023045, Engenharia de Produção, sem turma em comum): 403, nenhuma concessão
  gravada, tentativa registrada na auditoria.
- **Fluxo B, post ligado a prêmio.** João publica uma foto com legenda ligada à concessão
  do Fluxo A. O post aparece no feed com o selo do prêmio. Contra-exemplo: João tenta
  ligar o post a uma concessão da Maria (RA 2022110, ADS-3): 403.
- **Fluxo C, troféu com comprovação e revogação.** A instituição concede o troféu
  "Techday 2026" (Ouro, 80 pontos) à Maria com foto de comprovação. Maria sobe no
  ranking com 80 pontos. Um professor contesta; a instituição revoga; a concessão fica
  revogada e Maria perde os 80 pontos no próximo recálculo. O que acontece com o post
  ligado a essa concessão você propõe e registra como recomendação.
- **Fluxo D, mural.** A coordenação publica um aviso do curso ADS. Alunos de ADS veem o
  aviso; Pedro (Engenharia de Produção) não vê. Quando João abre o aviso, a leitura é
  registrada (quem e quando) e o aviso deixa de aparecer como não lido para ele.

Seed de desenvolvimento: 1 instituição, 2 cursos (ADS e Engenharia de Produção), 3
professores, 30 alunos (ao menos 2 ex-alunos), catálogo de prêmios com pelo menos 2
prêmios de cada tier (troféus e medalhas), algumas concessões, posts, avisos das três
categorias. Tudo em português.

## 7. Convenções (valem para todas as rodadas)

- Toda entrada validada por schema Zod antes de chegar ao serviço. Schemas, enums e
  chaves de permissão vivem em `packages/shared` e são usados pela API e pelo cliente.
- Regra de negócio nunca na rota. Mudança de estado nunca fora do serviço.
- Toda escrita grava entidade e auditoria na mesma transação.
- Nenhuma consulta SQL montada por concatenação de string. Drizzle ou `sql` tagged
  template com parâmetros.
- Segredos fora do código e do repositório: `.env.example` versionado com todas as
  chaves e valores de exemplo, `.env` no `.gitignore`. Configuração lida uma vez na
  subida, validada com Zod; falha de configuração derruba o processo na subida, não na
  primeira requisição.
- Senhas com argon2id. Tokens de sessão nunca em log.
- Autorização por chave de permissão em cada rota autenticada. Serializador por perfil.
  Nenhuma rota devolve registro cru.
- Repositórios atrás de interface; serviços dependem da interface. Composição por
  injeção explícita (sem container mágico).
- Módulo por domínio (`login`, `feed`, `premios`, `perfil`, `ranking`, `mural`), cada
  um com rota, serviço, repositório, serializador e testes ao lado.
- Cliente: telas por módulo, estado de servidor separado do estado de interface,
  chamadas à API num único cliente HTTP tipado pelos schemas do pacote compartilhado.
  Tema claro e escuro desde o início. Estados de carregamento, vazio e erro em toda
  tela.
- TypeScript estrito nos três pacotes, sem `any` e sem `@ts-ignore` sem justificativa
  em comentário. ESLint e Prettier com a mesma configuração nos três.
- Comentário só onde a regra não é óbvia (a regra de pontuação por tier e o desempate
  do ranking são exemplos de onde eu quero comentário).

## 8. Testes

- **Unitário** (Vitest): toda regra de negócio do serviço, com repositório em memória.
  Obrigatórios desde já: fronteiras da pontuação por tier (30/31, 70/71, 100/101,
  150/151 e fora da faixa), entradas inválidas (nulo, tipo errado, string vazia,
  negativo) e a ordenação do ranking com empate.
- **Integração** (Vitest + testcontainers com PostgreSQL 16): repositórios e os fluxos
  de exemplo da seção 6, contra banco real, com migrations aplicadas do zero em cada
  suíte. Sem mock de banco.
- **Ponta a ponta** (Playwright sobre o build web do Expo): três ou quatro fluxos
  críticos quando existirem (login, publicar post, conceder medalha, ler aviso).
- Convenção de nomes: `*.test.ts` unitário, `*.integration.test.ts` integração,
  `e2e/*.spec.ts` ponta a ponta. Os três rodam em scripts separados e todos rodam na
  CI.
- Nesta rodada: a suíte já existe e roda verde com o que houver (validação dos schemas
  do pacote compartilhado, invariante 1, configuração da API, migration e seed contra
  o container).

## 9. Git e CI

- `main` sempre deployável. Branches curtas por módulo, squash merge, sem commit direto
  na `main`.
- Commits em inglês, no imperativo, uma mudança por commit (`Add prize schema and tier
  constraint`). Código, documentação e interface em português.
- CI (GitHub Actions) em todo push e pull request: instalar, lint, typecheck, testes
  unitários e de integração (com serviço Postgres), build da API e do cliente web. CI
  vermelha bloqueia merge.
- `.gitattributes` com `* text=auto eol=lf`. `.editorconfig` na raiz.

## 10. Definição de pronto (para toda rodada a partir desta)

Uma rodada só está pronta quando:

1. Toda rota nova tem schema de entrada e saída, permissão declarada e teste.
2. Toda regra de negócio nova tem teste unitário; todo fluxo de exemplo do módulo tem
   teste de integração.
3. A tela nova funciona no Expo (Android ou web) com estados de carregamento, vazio e
   erro.
4. As permissões foram verificadas com um usuário de cada perfil do seed (aluno,
   professor, instituição).
5. Toda escrita nova grava auditoria.
6. Lint, typecheck, testes e build passam localmente e na CI.
7. `CLAUDE.md` e os documentos em `docs/` foram atualizados se alguma decisão mudou.

## 11. Estrutura do repositório

Crie esta estrutura. Se precisar mudar algum nome, justifique no documento de
arquitetura.

```
apps/
  mobile/                    Expo + Expo Router, telas por módulo
    app/                     rotas do Expo Router
    src/
      modulos/<modulo>/      telas, componentes e hooks do módulo
      api/                   cliente HTTP tipado
      tema/                  tema claro e escuro
  api/
    src/
      app.ts                 monta o Fastify e registra plugins e módulos
      server.ts              sobe o processo
      config.ts              configuração validada com Zod
      plugins/               auth, permissoes, db, storage, erros, rate-limit
      modulos/<modulo>/
        <modulo>.rotas.ts
        <modulo>.servico.ts
        <modulo>.repositorio.ts
        <modulo>.serializador.ts
        <modulo>.test.ts
        <modulo>.integration.test.ts
      db/
        schema/              Drizzle, um arquivo por agregado
        migrations/
        seed/
      jobs/                  fila e workers
      auditoria/
    test/                    helpers (container, fábrica de dados)
    e2e/                     Playwright
packages/
  shared/
    src/
      schemas/               Zod por entidade
      enums/
      permissoes/            chaves e matriz perfil x permissão
infra/
  docker-compose.yml         desenvolvimento: postgres, minio
  docker-compose.prod.yml    produção: api, worker, postgres, caddy
  Caddyfile
.github/workflows/ci.yml
docs/
  kickoff/
    01_plano.md
    02_arquitetura.md
    03_modelo_de_dados.md
.env.example
.editorconfig
CLAUDE.md
AGENTS.md
```

## 12. Entregáveis desta rodada, na ordem

1. `docs/kickoff/01_plano.md`: plano por módulo na ordem login, feed, troféus e
   medalhas, perfil e ranking, mural, e por fim deploy. Para cada módulo: rotas, telas,
   jobs, testes esperados e dependências. Inclua a seção "Recomendações não aprovadas"
   e uma seção "Perguntas em aberto" com o que você precisa de mim antes de cada módulo.
2. `docs/kickoff/02_arquitetura.md`: a tabela da stack com o "por quê" de cada camada,
   as camadas da API, o caminho de uma requisição de escrita (rota, validação,
   permissão, serviço, transação com auditoria, serialização), o desenho do deploy e
   como cada RNF da seção 2 é atendido. Liste o que ficou de fora e por quê.
3. `docs/kickoff/03_modelo_de_dados.md`: conforme a seção 5.
4. `CLAUDE.md`: acrescente ao final, sem alterar o que já existe, uma seção
   `## Regras do projeto` com stack, arquitetura, convenções, testes, git e definição de
   pronto, de forma resumida e prescritiva (o que fazer e o que não fazer). A
   fundamentação fica nos documentos de `docs/kickoff/`; o `CLAUDE.md` aponta para
   eles. Ao final, `AGENTS.md` deve ser uma cópia idêntica do `CLAUDE.md`.
5. Estrutura da seção 11 criada, com os três pacotes compilando, ESLint e Prettier
   configurados, scripts `lint`, `typecheck`, `test`, `test:integration`, `build` na
   raiz.
6. `infra/docker-compose.yml` subindo PostgreSQL 16 e MinIO; `.env.example` completo.
7. Schema Drizzle e a migration inicial com o modelo de dados do documento 03,
   incluindo as constraints das invariantes que o banco consegue garantir; seed de
   desenvolvimento da seção 6 rodando do zero.
8. Pacote compartilhado com os schemas Zod, enums e chaves de permissão do modelo.
9. API subindo com os plugins de configuração, banco, erros e rate-limit, e uma rota
   `GET /saude` que verifica banco e storage. Nenhuma rota de negócio ainda.
10. Cliente Expo subindo com o tema, a navegação inferior (Home, Busca, Mural, Troféus,
    Perfil) com telas vazias e o cliente HTTP apontando para `/saude`.
11. CI configurada e passando com a suíte da seção 8.
12. Commits pequenos, em inglês no imperativo, ao longo do trabalho.

Se alguma coisa aqui conflitar com o `CLAUDE.md` atual, o `CLAUDE.md` vence no que é
produto e este documento vence no que é técnica; me avise do conflito. Qualquer dúvida
que não seja coberta por este documento, pare e pergunte antes de seguir.
