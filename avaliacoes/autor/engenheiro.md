# Avaliação do autor: engenheiro

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
- Commit que o autor avaliou (o do registro da execução usada): `076549bbea15649813d347c2618a4b51377e6bdd` (`main`, fim do passo 12)
- Data do preenchimento: 09/11/2026 (eixos 2, 4, 5 e 6); UX a completar com o produto no ar; Infraestrutura sobre a `main` final após o passo 13
- Preenchido antes de abrir os reviews (sim ou não): sim

## 1. Experiência do usuário

Nota (1 a 5): 

Observações objetivas:

- 

Regras ausentes:

- 

## 2. Segurança

Nota (1 a 5): 5

Observações objetivas:

- Autenticação própria com sessão e refresh (`apps/api/src/Maxx.Api/Autenticacao/`, ADR 0006), limite de tentativas de login por IP, senha com hash; autorização por papel e por escopo nos endpoints (professor só premia aluno com quem tem aula; atos da instituição em rotas próprias), com testes de integração de recusa por papel em `apps/api/tests/Maxx.Api.IntegrationTests`.
- Segredos fora do código: chave JWT, banco, SMTP e armazenamento só por variável de ambiente (`docker-compose.yml`, `.env.example`); job `seguranca` da CI com gitleaks no histórico inteiro e varredura de dependências vulneráveis (`.github/workflows/ci.yml`).
- Fotos por URL pré-assinada direto no bucket, com limite de tamanho e tipo (`Maxx.Infrastructure/Fotos/ArmazenamentoS3.cs`, ADR 0002); validação de entrada em todas as rotas com códigos de erro próprios no contrato OpenAPI.

Regras ausentes:

- Nenhuma identificada.


## 3. Infraestrutura

Nota (1 a 5): 

Observações objetivas:

- Não pontuada neste commit: deploy, compose de produção, backup e carga são do passo 13. Nota e observações serão dadas sobre a `main` final, junto com a reavaliação do revisor deste eixo, como declarado no diário.

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

| Tipo | Declaradas | Silenciosas |
|---|---|---|
| Regra de produto |  |  |
| Stack e arquitetura |  |  |
| Modelo de dados |  |  |
| Segurança |  |  |
| UX e visual |  |  |
| Testes e processo |  |  |
| Hospedagem e deploy |  |  |

Total: 

Lista:

- 

## Perguntas sem resposta

Perguntas que o agente fez e que ficaram sem resposta na sessão.

Total: 

Lista:

- 

## Depois de abrir os reviews

Uma linha por eixo em que a nota do autor e a do revisor diferem em 2 pontos ou mais,
explicando a diferença (rubrica, "Como preencher", passo 4).

- 
