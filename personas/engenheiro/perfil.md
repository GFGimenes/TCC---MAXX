# Persona "engenheiro" — perfil de quem escreve o prompt

Este perfil descreve quem escreve os prompts da trilha `engenheiro`: o próprio autor
do TCC, engenheiro de software com quase 7 anos de carreira, quase toda em sistemas
de grande porte (bancos, e-commerce internacional, sistemas fiscais), com foco em
backend (.NET, C#, SQL, Node.js) e, no último ano, React e TypeScript no front. A
fonte primária não é suposição: são os documentos, prompts e convenções de um projeto
real em andamento em 2026 (sistema de estoque e separação para a Redutores São Paulo,
Gimenes Tech), o projeto do hackathon interno de IA da Avalara (Top 10) e o currículo
do autor. As respostas dos desenvolvedores do formulário do TCC (R02, R05, R16, R20 e
R27 em `personas/leigo/corpus-respostas.md`, mais os outliers técnicos R14 e R25)
entram como corroboração: são devs mais juniores (menos de 3 anos), então servem para
mostrar que os padrões abaixo não são idiossincrasia do autor, e sim comportamento
de quem entende o que está construindo.

Não confundir com as "personas das IAs" (seção 3.1 do TCC). Aqui é **quem pede**.

## Quem é

- Backend por formação prática, com passagem por front. Já operou sistemas com
  milhões de requisições por segundo e bancos com muitos acessos; por isso, infra e
  estrutura "precisam sempre ser muito bem produzidas" (palavras do autor), mesmo num
  MVP.
- Trabalha em inglês no dia a dia, mas escreve os prompts do experimento em
  português, para o TCC representar o que foi pedido sem tradução.
- Já usa IA como co-desenvolvedor em projeto real: um modelo produz o pacote de
  kickoff (cronograma, modelo de dados, stack, estrutura de repositório, exemplos de
  fluxo) e um segundo modelo revisa; o autor arbitra e registra o que foi "decisão
  confirmada" e o que é só "recomendação técnica" (ver
  `docs/kickoff/04_respostas_revisao_codex.md` do projeto Redutores). É o mesmo
  desenho do experimento: agente gera, agente revisa, humano valida.

## Ordem de trabalho (o padrão declarado pelo autor)

> "Meu padrão é sempre: fazer um plano, montar telas, definir stacks, definir
> arquitetura e só depois começar a desenvolver bancos e código."

No projeto Redutores essa ordem é visível nos artefatos: um rascunho à mão vira uma
conversa longa de entendimento do problema (`contexto/sumario_conversa.md`), que vira
memória do projeto e plano de execução; depois vêm os mockups (briefs e prompts para o
Claude Design, com um "bloco de consistência" colado em todo prompt para os dados
baterem entre telas); depois o pacote de kickoff com stack justificada camada a
camada e estrutura de pastas; só então o primeiro commit de código, já com auth,
permissões, auditoria e CI.

Corroboração no corpus: 4 dos 5 devs pedem plano antes de código (R02 "monte um
planejamento... depois me fale o passo a passo", R16 "não desenvolva nada ainda,
apenas me mostre um plano", R20 "defina o escopo inicial... depois elabore por etapas
um plano", R27 "não escreva todo o código de uma vez, primeiro apresente o plano").
R14 descreve exatamente o fluxo MVP em outra IA, spec em markdown, depois IA de
codificação.

## Vocabulário

Preciso e nomeado: camadas (rota, serviço, repositório), transação, idempotência,
auditoria, sessão revogável, menor privilégio, schema de validação, migration, seed,
CI, staging, definição de pronto. Cita ferramentas pelo nome e versão (Fastify 5,
Postgres 16, Node 22, Drizzle, Zod, Vitest, Playwright, Docker Compose, Caddy). Fala
em "invariantes" do modelo de dados e transforma exemplos de fluxo em testes de
integração. Nunca usa "código", "tal linguagem" ou "design clean" como placeholder.

Corroboração: R27 pede SOLID, Clean Code, separação de responsabilidades, baixo
acoplamento, interfaces; R25 abre já citando a stack (Spring Boot, Android Studio,
Volley); R05 e R20 dão papel técnico ao modelo ("aja como um engenheiro de
software", "você é um desenvolvedor de projetos, trabalhando em metodologia ágil").

## Nível de detalhe e estrutura do pedido

Os prompts e documentos do autor são longos e estruturados: tabelas com a decisão e o
"por quê" de cada camada, uma seção de convenções que o agente deve seguir, uma
definição de pronto e um checklist ordenado da primeira semana. A stack é
dimensionada ao problema, e o critério fica explícito no documento: no Redutores
(cliente pequeno, um desenvolvedor mantendo sozinho por anos) o kickoff lista até o
que foi deixado de fora naquele contexto (Redis, Kubernetes, microserviços, GraphQL,
Next.js, Prisma); no trabalho, o mesmo autor opera Kubernetes, Kafka, RabbitMQ, AWS
e Terraform em sistemas de alto volume. Não é aversão a ferramenta: é escolher pelo
tamanho do problema e pelo que ele domina, e registrar o porquê.

Quando o pedido é visual (mockups), a especificação inclui resolução, tema, fontes,
paleta em hexadecimal, dados de exemplo consistentes e a ordem das telas. O autor
constrói a referência visual antes de pedir código (Figma ou Claude Design), e
considera isso comportamento de engenheiro: "a maioria leiga não monta referência
visual antes de tentar construir algo".

Média de tamanho: a primeira mensagem de um dev no corpus tem 566 caracteres (3,4x a
de um leigo); os prompts do autor em projeto real ultrapassam isso com folga, porque
vêm acompanhados de arquivos de contexto que o agente deve ler antes de agir
("leia `docs/escopo_funcional.md` e `docs/kickoff/` antes de implementar um módulo").

## O que exige de saída (conteúdo da rodada `eng_00_contexto`)

Declarado pelo autor para o Maxx: testes, formatação, convenção e boas práticas de
git, Clean Code, SOLID, boas práticas de segurança de credenciais, encapsulamento,
herança e interfaces. No projeto Redutores isso aparece concretamente como:

- Regra de negócio nunca na rota; mudança de estado nunca fora do serviço; toda
  escrita grava entidade e auditoria na mesma transação.
- Schemas, enums e permissões numa única fonte compartilhada entre API e front.
- Toda entrada validada por schema antes de chegar ao serviço; nenhuma consulta SQL
  montada por concatenação; segredos fora do código e do repositório (`.env.example`
  versionado, `.env` não).
- Autorização por chave de permissão em cada rota; serializador que remove campos
  conforme o perfil; nenhuma rota devolve o registro cru.
- Testes: unitários para regra de negócio, integração contra banco real em
  container, ponta a ponta para 3 ou 4 fluxos críticos; exemplos de fluxo do
  documento viram testes.
- Git: `main` sempre deployável, branches curtas, squash merge, commits em inglês no
  imperativo, código e interface em português; CI com lint, typecheck, testes e build.
- Definição de pronto explícita (rota com schema e teste, tela funcional em staging,
  permissões verificadas com um usuário de cada perfil, auditoria gravada).

## Como valida

Processo declarado, sem TDD: desenvolve, testa em tela, escreve as validações dos
testes, roda os testes, nova rodada de teste em tela, confere o diff, testa em dev ou
QA, passa para o QA ou pesquisador responsável pelo último teste, só então deploy. Com
TDD, muda o começo: os testes nascem junto com as models, para fixar as regras de
negócio antes do código.

No experimento isso vira: ler o review do agente revisor, ler o diff, rodar os
testes de referência e o app, e corrigir **por prompt** (rodada `_v2`), nunca editando
o código à mão, senão a trilha deixa de ser vibe coding. O custo dessa correção
(tempo, iterações) é um dos resultados.

## Como responde às perguntas do agente

Declarado pelo autor: no meio de uma definição, debate e pede pesos ("me dá as
opções com prós e contras"); no fim, quando é só confirmação, responde direto ("use X
ou Y como está no documento; se necessário, valide em Z antes de implementar").
Documenta o que decidiu e separa de recomendação não aprovada. Corroboração: R16
fecha o prompt com "qualquer dúvida pode interromper e perguntar".

## Suposições típicas

- Que o agente vai ler os arquivos de contexto do repositório antes de agir, e que a
  disciplina de manter esses arquivos atualizados é do humano (o TCC já registra que
  contexto desatualizado é fonte de dívida técnica).
- Que revisão por um segundo modelo é barata e vale sempre.
- Que um MVP nasce com auth, permissões, auditoria, migrations e CI, mesmo que o
  cliente não tenha pedido nada disso.

## Lacunas típicas (o que o engenheiro tende a errar)

- Superespecificação: o prompt fixa tanto que o agente deixa de decidir, e o custo
  de escrever o prompt se aproxima do custo de escrever o código.
- Overengineering para o tamanho do problema (o kickoff do Redutores precisa listar
  explicitamente o que ficou de fora, sinal de que a tentação existe).
- Antecipar requisitos que o cliente não pediu (ex.: log de leitura dos avisos do
  mural). No experimento isso é registrado como feature emergente da persona, não
  como erro.

## Stack para o Maxx (decisão da persona)

Critério do autor: o que ele domina e mantém sozinho. Duas opções coerentes com o
histórico, a confirmar pelo autor antes da rodada `eng_00_contexto`:

- **A. API própria:** Expo (React Native + TypeScript) no cliente; API em Fastify +
  Zod + Drizzle + PostgreSQL; fotos em storage S3-compatível; Docker Compose numa VPS
  com Caddy; Vitest com testcontainers e Playwright. É a combinação usada nos dois
  projetos solo de 2026 (Redutores e hackathon), adaptada para celular; num projeto
  com mais gente ou mais volume o autor escalaria a infra (Kubernetes, fila, cache)
  como faz no trabalho.
- **B. Mais rápida para o MVP:** Expo no cliente e Supabase (Postgres, Auth, Storage,
  políticas RLS) no lugar da API própria. Menos código por rodada, com a segurança
  concentrada nas políticas do banco.

## O que isso significa para `prompts/engenheiro/`

1. Português, longo, estruturado em seções; pode mandar o agente ler arquivos do
   repositório antes de agir.
2. Abre a trilha com `eng_00_contexto`: pede plano, stack justificada, arquitetura,
   modelo de dados, convenções, definição de pronto e estrutura de pastas, e manda
   gravar isso como regras do projeto (`CLAUDE.md`) antes de qualquer código.
3. Referência visual entra como artefato do engenheiro (mockups feitos antes), com
   dados consistentes entre telas.
4. Cada tela é pedida com regras de negócio explícitas, restrições de segurança
   (quem pode o quê), casos de borda e os testes esperados.
5. Revisa criticamente: aponta o que está errado no review e no diff e pede correção
   por prompt (`_v2`), registrando o custo.
6. Responde perguntas do agente com decisão técnica; no meio de uma definição, pede
   opções com pesos antes de decidir.
