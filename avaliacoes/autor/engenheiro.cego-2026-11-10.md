# Avaliação do autor: engenheiro (cópia congelada do formulário cego, 10/11/2026, antes da segunda passagem do revisor e antes de o autor abrir qualquer review; commit 32d45c9)

> Preencha este formulário ANTES de abrir os reviews em `avaliacoes/reviews/` (os
> arquivos `engenheiro-<eixo>.md` e `.json`). Pontue cada eixo pela rubrica
> (`avaliacoes/rubrica.md`), sem ver a nota do revisor, com observações objetivas: o
> que motivou a nota, não impressão geral. O registro da execução
> (`engenheiro-registro.md`) não mostra notas e pode ser lido.
>
> Nota: um inteiro de 1 a 5, na linha "Nota (1 a 5):". Regras ausentes não reduzem a
> nota; ficam listadas à parte. Este arquivo é lido pelo `consolidar.ps1`: mantenha os
> títulos e os rótulos como estão.

- Commit na criação do formulário: `076549bbea15649813d347c2618a4b51377e6bdd` (`main`)
- Commit que o autor avaliou (o do registro da execução usada): `076549bbea15649813d347c2618a4b51377e6bdd` (`main`, fim do passo 12) para Segurança, Documentação, Código e Arquitetura; `8910b51` (`main` final, fim do passo 13) para Experiência do usuário e Infraestrutura, como o revisor
- Data do preenchimento: 09/11/2026 (eixos 2, 4, 5 e 6) e 10/11/2026 (eixos 1 e 3, depois do ensaio no produto no ar)
- Preenchido antes de abrir os reviews (sim ou não): sim

## 1. Experiência do usuário

Nota (1 a 5): 5

Observações objetivas:

- Avaliado no produto no ar (`main` final, `8910b51`), no iPhone 12 com Safari e no computador, durante o ensaio de 10/11: entrada pela demonstração com foto, post com foto, curtir, comentar, seguir, Troféus, rankings, Mural, sininho, reivindicação, concessão pela professora, fila de comprovações e área da instituição, tudo de ponta a ponta sem explicação.
- Identidade visual própria e consistente entre telas: paleta, tipografia e componentes definidos em `design/identidade-visual.md`, `design/tokens.json` e `design/telas/`, aplicados no app nos temas claro e escuro; sem gradientes ou elementos genéricos de gerador.
- Estados tratados: carregamento, listas vazias, recusas da API como mensagem em tela (`dominio-nao-aceito`, limites de login), retorno pela lembrança do aparelho; posição no ranking atualizada em 2 s após a medalha. Único achado do ensaio (trocar o prêmio selecionado na folha de reivindicação) corrigido no mesmo dia (`060f0b4`), com Jest.

Regras ausentes:

- Nenhuma identificada.


## 2. Segurança

Nota (1 a 5): 5

Observações objetivas:

- Autenticação própria com sessão e refresh (`apps/api/src/Maxx.Api/Autenticacao/`, ADR 0006), limite de tentativas de login por IP, senha com hash; autorização por papel e por escopo nos endpoints (professor só premia aluno com quem tem aula; atos da instituição em rotas próprias), com testes de integração de recusa por papel em `apps/api/tests/Maxx.Api.IntegrationTests`.
- Segredos fora do código: chave JWT, banco, SMTP e armazenamento só por variável de ambiente (`docker-compose.yml`, `.env.example`); job `seguranca` da CI com gitleaks no histórico inteiro e varredura de dependências vulneráveis (`.github/workflows/ci.yml`).
- Fotos por URL pré-assinada direto no bucket, com limite de tamanho e tipo (`Maxx.Infrastructure/Fotos/ArmazenamentoS3.cs`, ADR 0002); validação de entrada em todas as rotas com códigos de erro próprios no contrato OpenAPI.

Regras ausentes:

- Nenhuma identificada.


## 3. Infraestrutura

Nota (1 a 5): 5

Observações objetivas:

- Deploy reproduzível e simples: `docker-compose.producao.yml` com imagens publicadas no GHCR pela CI (`job publicar`), `infra/deploy.sh` com dump antes do migrator, configuração só por variável de ambiente (`.env.producao.example` com nomes), banco em contêiner separado da API, Caddy com HTTPS automático em `https://app.maxx-unimax.com`; roteiro em `docs/operacao.md`.
- Estrutura para crescer: API sem estado em duas réplicas, fotos fora da API (R2 com CDN, ADR 0002), fila no Postgres com worker (ADR 0008) e ranking pré-calculado (ADR 0005), e-mail transacional por SMTP próprio; saúde do worker em `/api/health/worker` com alerta 503 conferido na VPS.
- Backup previsto e testado: `infra/backup/` com dump noturno, rotação de 14 dias e restauração conferida em 46 tabelas; carga executada com k6 (9.488 pedidos, 0 falha, p95 43 ms), ainda que reduzida a 50 usuários dentro da VPS, com o cenário de 2.000 registrado como pendência; tempo até a tela de login de 4 s no 5G com cache limpo.

Regras ausentes:

- Nenhuma identificada.


## 4. Documentação

Nota (1 a 5): 5

Observações objetivas:

- `docs/produto.md` com as regras do produto por seção, `docs/plano-mestre.md` com os 13 passos e pendências, `docs/regras-conquista.md`, `docs/fluxos/` e `design/` (identidade visual, tokens, telas); README por app.
- Oito ADRs em `docs/decisoes/0001` a `0008` com contexto, alternativas e consequências, mais o índice de decisões em `docs/decisoes/README.md`, atualizado em cada passo com os limites conhecidos.
- Documentação coerente com o código no commit avaliado: as seções do produto.md citam a configuração e os endpoints que existem, e cada passo que mudou regra atualizou produto.md, decisões e plano mestre no mesmo PR.

Regras ausentes:

- Nenhuma identificada.


## 5. Código

Nota (1 a 5): 5

Observações objetivas:

- Suíte em quatro camadas no repositório: `Maxx.Domain.Tests`, `Maxx.Api.IntegrationTests` (com prova reversa nas regras), `Maxx.Architecture.Tests` (dependências entre camadas) e Jest no `apps/mobile`, mais e2e Playwright em `e2e/tests` nos dois temas; tudo roda nos seis jobs da CI a cada push.
- Regras de negócio no projeto de domínio, sem lógica de regra em endpoint ou tela; lint, tipos, formato e contrato OpenAPI conferidos na CI; cliente da API gerado do contrato (`packages/api-client`).
- Testes de referência de fronteira de pontos ainda não executados contra este produto (falta o adaptador); nota dada pelos demais critérios, a conferir quando a suíte rodar.

Regras ausentes:

- Nenhuma identificada.


## 6. Projeto e arquitetura

Nota (1 a 5): 5

Observações objetivas:

- Camadas explícitas em `apps/api/src` (Domain, Application, Infrastructure, Api) com teste de arquitetura impedindo dependência invertida; cada regra de produto vive num lugar só e as telas dos passos 10 a 12 entraram sem retrabalho nas camadas de baixo.
- Modelo de dados representa as regras do produto (tiers, semestres com congelamento, papéis, lotes de demonstração) com migrations por passo, sem tabela ou campo de contorno.
- Decisões de escala justificadas nos ADRs e presentes no código: API sem estado, fotos fora da API (0002), fila no Postgres com worker (0008), ranking pré-calculado pelo worker (0005), derivadas no cliente (0003); produto fiel ao pitch e às regras do produto.md.

Regras ausentes:

- Nenhuma identificada.


## Decisões sem perguntar

Decisões que o agente construtor tomou sem perguntar, contadas pelo autor a partir do
export da sessão e do diff da branch. A lista do revisor de decisões e as decisões
apontadas pelos seis revisores são insumo, não a contagem. Forma: declarada, quando o
agente escreveu que decidiu; silenciosa, quando só aparece no que ele fez.

Na trilha do engenheiro o `CLAUDE.md` exige que toda decisão fora dos documentos seja
declarada no relatório da etapa; a contagem abaixo vem das seções "Decisões do agente sem o
prompt pedir (declaradas)" dos 14 registros de rodada (`resultados/engenheiro/eng_*.md`),
classificadas pelo autor. A coluna de silenciosas é preenchida a partir do revisor de
decisões rodado sobre os 14 exports (`engenheiro-decisoes.md`), depois de aberto.

| Tipo | Declaradas | Silenciosas |
|---|---|---|
| Regra de produto | 39 |  |
| Stack e arquitetura | 38 |  |
| Modelo de dados | 17 |  |
| Segurança | 13 |  |
| UX e visual | 26 |  |
| Testes e processo | 56 |  |
| Hospedagem e deploy | 8 |  |

Total: 197

Lista (por rodada; D = declarada, S = silenciosa):

- eng_00: Termo de uso versionado (produto, D); tabela de estatística de raridade escrita pelo worker (stack, D); campos `tipoDeEvento` e `formaDoEvento` no catálogo (modelo de dados, D); limites de repetição por item (depois substituídos pela estrutura real de avaliação dada pelo autor) (produto, D); duas formas de contagem em vez de três (produto, D); oito famílias em vez de sete (produto, D); inversão dos passos 7 a 9 do plano por dependência (testes e processo, D); identificadores sem acento (stack, D); snake_case no Postgres (modelo de dados, D); glossário com proibição de sinônimos (testes e processo, D); instância do período `curso` igual ao aluno (produto, D); literal 4 na C14 (produto, D); os 18 nomes das conquistas (2 trocados pelo autor) (produto, D); os 3 princípios do catálogo (produto, D); uso de `git filter-branch` para reescrever commits (testes e processo, D).
- eng_01_fundacao: `Architecture.Tests` separado e teste de pureza do Domain (testes e processo, D); `--ignore-exit-code 8` provisório (testes e processo, D); `MSBuildTreatWarningsAsErrors` (stack, D); `to_regclass` no ready (stack, D); geração do cliente só sob demanda (stack, D); `JsonNumberHandling.Strict` (stack, D); duas versões de TypeScript (stack, D); remoção de `AGENTS.md`, LICENSE e `.claude/settings.json` do template do Expo (testes e processo, D); `testID` no lugar de XPath (testes e processo, D); validação da CI com branches descartáveis em três cenários (testes e processo, D); filtro com `jq` para o `dotnet list package --vulnerable` (sai com 0 mesmo com achado) (testes e processo, D); remoção dos códigos HTTP não fixados nos diagramas (testes e processo, D); dois eventos extras no ADR 0005 (stack, D).
- eng_02_dados: Bimestres numerados de 1 a 4 no ano (produto, D); semestre sem datas próprias (produto, D); `Papeis` como enum de combinação (modelo de dados, D); sigla só em maiúsculas sem acento (modelo de dados, D); Guid v7 no domínio (modelo de dados, D); leitor de JSON estrito (stack, D); `citext` no e-mail (modelo de dados, D); checks no banco repetindo invariantes (modelo de dados, D); `Set<T>` sem `DbSet` (stack, D); `Restrict` entre agregados (modelo de dados, D); `codigo` como chave primária do catálogo (modelo de dados, D); enumerações em camelCase no banco (modelo de dados, D); `restricao_curso` sem FK (modelo de dados, D); calendário e mundo demo como arquivos de dados (stack, D); comparação campo a campo por reflexão (testes e processo, D); demo que só acrescenta (produto, D); publicação da `rodada/eng_02_dados` no remoto para o PR ter base (testes e processo, D).
- eng_03_auth: Etapa inicial só de docs (testes e processo, D); unicidade do arroba pelo prefixo (produto, D); `prefixo_reservado` com o prefixo como chave primária (modelo de dados, D); xmin como token de concorrência (modelo de dados, D); ProblemDetails com `codigo` em kebab-case (stack, D); cabeçalho `X-Maxx-Cliente` (stack, D); refresh simultâneo contado como reuso (segurança, D); `/v1` fechado no grupo em vez de FallbackPolicy (segurança, D); `/v1/eu` lendo do banco (stack, D); rotas de teste no host de teste (testes e processo, D); token de recuperação no fragmento do link (segurança, D); rotas de demonstração não mapeadas com a flag desligada (segurança, D); `docker-compose.demo.yml` (deploy, D); limite por filtro de endpoint (segurança, D); `.gitleaksignore` delimitado (testes e processo, D); dois itens extras no passo 5 do plano mestre (testes e processo, D); publicação da `rodada/eng_03_auth` no remoto para o PR ter base (testes e processo, D).
- eng_04_design: Ícones próprios em vez do pacote Lucide (glossário e bundle) (UX, D); vitrine em `__DEV__` (testes e processo, D); cor literal como erro de lint (testes e processo, D); `FontGate` (UX, D); `detailColor` nos ícones preenchidos (UX, D); `aboveNav` no `Screen` (UX, D); `outline-style: none` por cima do anel de foco (UX, D); teste de regra de gradiente e sombra (testes e processo, D); `StateMessage` compartilhado (UX, D); tolerância do teste de fontes (testes e processo, D); `.gitattributes` para TTF (testes e processo, D); remoção do `android-icon-background.png` (UX, D); reinício do Docker Desktop na etapa 5 (testes e processo, D); dezenas de medidas estimadas pela prancheta, todas listadas e aceitas (UX, D).
- eng_05_login: Texto do termo redigido só a partir do `produto.md` (produto, D); dados do cadastro só em memória (segurança, D); token do fragmento capturado uma vez no carregamento do bundle (segurança, D); `/redefinir-senha` fora dos grupos de rota (stack, D); renovação antecipada a 30 s do vencimento (segurança, D); `Object.hasOwn` na tabela de mensagens (stack, D); cliente de teste sem coleta de cache (testes e processo, D); `check` do Lucide (UX, D); papel `radio` no `FilterChip` (UX, D); leitura do Mailpit adiada para a etapa 6 (testes e processo, D); CI em duas passadas (testes e processo, D); linha "Etapa pronta" no README de decisões (testes e processo, D); correção do próprio relatório da etapa 7 (testes e processo, D).
- eng_06_medalhas: Regra F adiada para o commit da etapa 4 (testes e processo, D); limite de 60 s por handler (stack, D); tipo sem handler conta como falha (stack, D); validade do token de recuperação contada do envio (segurança, D); tipo `Proibido` na Application (stack, D); releitura única na corrida de vagas (stack, D); xmin na medalha (modelo de dados, D); purga ampliada (medalha, notificação) (produto, D); seed base pedindo o primeiro recálculo (stack, D); numerador limitado ao divisor (produto, D); recálculo no cadastro e na demonstração (stack, D); `nomeDeExibicao` no `/v1/eu` (stack, D); `Cabecalho`, ícones novos, `accessibilityLabel` (UX, D); teste de mensagens lendo todos os `Codigos*.cs` (testes e processo, D); correções visuais antes das capturas (caixa alta, switch verde da web, polegar escuro, rótulo dos passos da trilha) (UX, D).
- eng_07_posts: Troca do MinIO pelo VersityGW (menu) (deploy, D); retorno do login restrito a `/post/:id` (UX, D); arroba sob o nome no perfil (UX, D); perfil de outro fora das abas com voltar (UX, D); `test.slow()` como paliativo declarado, depois removido com a causa achada (`docker compose run seeder` reiniciava o migrator (testes e processo, D); passou a `exec` no worker) (testes e processo, D); `(app)` vira Stack sem cabeçalho para as abas não desmontarem (UX, D); `router.replace("/")` vira `dismissTo("/")` (UX, D); verificação manual do R2 atrás de flag (testes e processo, D); foto da demonstração de melhor esforço (produto, D); branch temporária para a CI do fix (testes e processo, D); push da `rodada/eng_07_posts` como base do PR (testes e processo, D); pilha deixada de pé depois do reinício do Docker (testes e processo, D).
- eng_08_premios: Limite inferior da D3 no fim do último semestre encerrado (proposta depois do furo apontado) (produto, D); `[Range(1, 8)]` removido da busca (stack, D); P17 nunca semeado (produto, D); nome do evento de 3 a 120 (produto, D); `exigeMateria` no item e `GET /v1/eu/materias` (stack, D); handler `tornar-premio-definitivo` e raridade adiantados da etapa 4 para a 3 (testes e processo, D); lista de prêmios recolhida com "Trocar prêmio" depois da primeira captura (UX, D); folha de motivo compartilhada (UX, D); conta de instituição por teste no e2e por causa do limite de recuperações (testes e processo, D); branch de rodada enviada como base do PR (testes e processo, D); spec temporário de capturas apagando reivindicações pendentes do compose local (testes e processo, D).
- eng_09_conquistas: Conquista de bimestre só conta medalha (produto, D); teste por item no projeto de integração (testes e processo, D); evento no recesso sem semestre seguinte espera o calendário (produto, D); trava consultiva em vez de tratar a violação do índice (modelo de dados, D); notificação gravada pelo handler (stack, D); ambos os tipos de notificação na mesma migration (modelo de dados, D); regra `customizada` sem gatilho por fato (produto, D); anulação nunca concede (produto, D); mudança de catálogo não remove conquista (produto, D); "fim mais 30 já congelado" (produto, D); instância em números com rótulo no cliente (UX, D); sem progresso de bimestre e semestre no recesso (produto, D); contagem simples na leitura (stack, D); critério na frase inteira do catálogo (produto, D); post da conquista removida pela regra da medalha anulada (produto, D); `JsonIgnore` na propriedade calculada (stack, D); `testTimeout` global de 15 s (testes e processo, D).
- eng_10_mural: Quem vê recebe a notificação, instituição e autor nunca (produto, D); destinatários do aviso de curso lidos pelo curso atual na hora do worker (janela de segundos como limite conhecido) (produto, D); uma migration por etapa (três no passo) (modelo de dados, D); `ate` na leitura do sininho contra a corrida entre abrir e marcar (stack, D); aluno novo vê a bolinha do Mural pelos avisos antigos (produto, D); prêmio de participação acende Troféus só na aprovação (produto, D); ajuste de relógio no helper de teste (testes e processo, D); "Ler todos" desativado por filtro até a etapa 6 (UX, D); conta professora e instituição publicam só para turmas pelo app até o passo 12 (produto, D); "Remover foto" sem "Trocar foto" (UX, D); texto genérico para tipo de notificação desconhecido (UX, D); teste lendo o enum C# para falhar se um tipo ficar sem texto (testes e processo, D); página da professora em contexto separado e login com 15 s no e2e (testes e processo, D); falha local do `medalhas.spec` registrada como ocorrência de ambiente (testes e processo, D); limite aceito da conquista aparecendo entre as medalhas no sininho (produto, D).
- eng_11_rankings: Trabalho separado do de raridade com a mesma coalescência (stack, D); semestre atual é o último que já começou (produto, D); congelados intocados e histórico nunca congela (produto, D); lista por cursor de 20 com card fixo (UX, D); worker já respeita ex-aluno e troca de curso com o enfileiramento desses atos pendente para o 12 (produto, D); sem p95 neste passo (testes e processo, D); seed base pede o recálculo quando o calendário muda (stack, D); `MundoDeConquistas.AprovadoAsync` com início opcional (stack, D); "Quem eu sigo" com a linha própria (produto, D); sem ETag (stack, D); parâmetros em texto (stack, D); validação de ausência no endpoint (stack, D); `posicao` nula nas filas de comprovação e contestação (stack, D); captura do "Todos" com contas do e2e e telas da turma por "Quem eu sigo" (testes e processo, D); teste da etapa 2 avançando 10 s pela coalescência (testes e processo, D).
- eng_12_instituicao: Contas do seed com data retroativa e notificações pelo worker (produto, D); e-mails do seed em domínio reservado `.invalid` (segurança, D); fila de remoção para as fotos purgadas (stack, D); e2e esperando a fila drenar (testes e processo, D); dois endpoints aditivos para a ficha (stack, D); formulário do aviso compartilhado entre professor e instituição (UX, D); prazo de 90 s nos e2e de vários papéis (testes e processo, D); ambiente local recriado com o seed demo para as capturas (testes e processo, D); capturas tiradas sem confirmar nenhum ato (testes e processo, D); push da `rodada/eng_12_instituicao` para o remoto para o GitHub aceitar o PR, como nos passos anteriores (testes e processo, D).
- eng_13_endurecimento: Renomear as imagens no GHCR para nomes próprios do repositório (deploy, D); publicar sem atestado de proveniência para o `GITHUB_TOKEN` gravar o manifesto (deploy, D); desligar a assinatura em pedaços do SDK da AWS para o R2 (provado por teste reverso na VPS) (deploy, D); `style-src 'unsafe-inline'` na CSP pelo react-native-web (segurança, D); limites da saúde do worker (2 min, 5 min, 24 h) (deploy, D); `apt-get upgrade` no estágio final da imagem da API (segurança, D); `--ignore-unfixed` no Trivy (segurança, D); k6 rodando como root no contêiner (deploy, D); `auto_explain` só numa rodada curta (deploy, D); gravação de log e `docker stats` durante o ensaio (testes e processo, D); correção do passo 6 estendida à concessão da instituição por ser o mesmo componente (UX, D); publicação da `rodada/eng_13_endurecimento` no remoto para o GitHub aceitar o PR (testes e processo, D).

## Perguntas sem resposta

Perguntas que o agente fez e que ficaram sem resposta na sessão.

Total: 0

Lista:

- Nenhuma. Pelo protocolo da trilha, toda pergunta do agente foi respondida na rodada seguinte antes da etapa continuar (planos com até dez perguntas por passo, todas respondidas nas `r1`); ofertas do tipo "se quiser, ajusto" (por exemplo, o `CLAUDE.md` no passo 13) também receberam resposta.

## Depois de abrir os reviews

Uma linha por eixo em que a nota do autor e a do revisor diferem em 2 pontos ou mais,
explicando a diferença (rubrica, "Como preencher", passo 4).

- 
