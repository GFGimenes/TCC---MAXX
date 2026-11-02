# Registro da rodada `eng_01_fundacao` (trilha do engenheiro)

Passo 1 do plano mestre: esqueleto do monorepo. Primeira rodada com código e a primeira
sessão sustentada só pelo `CLAUDE.md` (o prompt de abertura é curto de propósito).

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_01_fundacao` (saída da `main` em `af80558`); trabalho em `chore/passo-01-esqueleto-monorepo` |
| Sessão | `5efbaa63-035b-4a13-b2ea-213317a92040`, aberta em 02/11/2026 00:18 UTC, encerrada em 02/11/2026 03:47 UTC |
| Modelo | `claude-opus-5-5` em todas as 655 mensagens do agente (jsonl), esforço `medium`, auto mode. Mudou em relação à `eng_00` (`claude-opus-5`, `high`) sem ação do autor: mesma opção "Opus (1M context)" no `/model`, sessão aberta cinco minutos depois do fim da anterior. Ver "Ambiente" abaixo |
| Versão do CLI | 2.1.308 do início ao fim, `DISABLE_AUTOUPDATER=1` |
| Interrupções | Nenhuma |
| Prompts do autor | `eng_01_fundacao` (abertura), `eng_01_fundacao-r1` (plano) a `r9` (etapa 8 e PR), mensagem de encerramento: 11 textos, 11 envios |
| Turnos humanos | 11 mensagens de conteúdo, mais 9 `/export` |
| Mensagens do agente | 469 (inclui uso de ferramenta); 224 resultados de ferramenta |
| Tokens (da transcrição) | saída 657.493; cache criado 901.863; cache lido 111.056.919; entrada sem cache 980 |
| Tempo de relógio | 3 h 29 min, numa noite (01/11 21:18 a 02/11 00:47 no horário de Brasília) |
| Commits do agente | 8, um por etapa (`5dbff8c`, `a175f48`, `a6e105f`, `a045303`, `99bec8e`, `84b8dd1`, `0b75fa4`, `31f7784`), sem rodapé de co-autoria |
| Commits do autor | 2 merges: PR #2 (`b30c6fb`) e `rodada/eng_01_fundacao` → `main` com `--no-ff` (`3d1e91f`) |
| Merge | PR #2 `chore/passo-01-esqueleto-monorepo` → `rodada/eng_01_fundacao`, 8 commits, CI verde nos seis jobs; depois `main` |
| Resultado | 88 arquivos, 22.881 linhas (20.066 do `package-lock.json`) |
| Export | `eng_01_fundacao-sessao.txt` (5.896 linhas) e `eng_01_fundacao-sessao.jsonl` (2.190 linhas) nesta pasta |

## Ambiente

A transcrição `.jsonl` grava o modelo e o esforço em cada mensagem do agente. Na `eng_00`
as 216 mensagens trazem `claude-opus-5` e `high` (11/10 a 02/11 00:14 UTC). Nesta rodada
as 655 trazem `claude-opus-5-5` e `medium` (02/11 00:19 UTC em diante). O autor escolheu
a mesma opção nas duas sessões ("Opus (1M context)", gravada em `settings.json`) e não
mexeu em esforço; a troca veio do CLI ou do serviço entre uma sessão e outra, sem aviso.
Decisão (02/11): o ambiente desta rodada (`claude-opus-5-5`, `medium`, auto, 2.1.308)
passa a ser o ambiente fixo de todas as sessões restantes, nas duas trilhas; a `eng_00`
fica como exceção declarada (sem código). Antes do primeiro prompt de cada sessão nova,
o autor confere `/model` e o Cowork confere contra este registro; no fim, o jsonl
confirma. A trilha do leigo roda inteira num dia só.

## O que saiu

Monorepo com `.NET 10` (API em quatro projetos, `/api/health` e `/api/ready`, migration
inicial, subcomando `migrate` com advisory lock, testes de domínio, arquitetura e
integração com Testcontainers), `packages/api-client` (OpenAPI 3.1.1 gerado sob demanda,
`schema.d.ts`, openapi-fetch), `apps/mobile` (Expo SDK 58 com Expo Router, tela de
estado da API, moldura de celular na web, 7 testes Jest, proxy de `/api` no Metro só em
desenvolvimento), `docker-compose.yml` (Postgres 18, migrador, duas réplicas, Caddy),
`e2e/` (Playwright em quatro projetos), CI com seis jobs, `docs/fluxos/` com cinco
diagramas de sequência, `CLAUDE.md` com `infra/` e `e2e/` no mapa. Correções em
`docs/produto.md` 4.7 (reenvio é post novo), `docs/plano-mestre.md` e ADR 0005 (eventos
que enfileiram o recálculo).

## Perguntas do agente e respostas do autor

- Plano: 5 perguntas (gerenciador de pacotes, escopo do job de segurança, forma do
  migrador, prefixo de rotas, medidas da moldura). `r1`.
- Etapa 1: 6 desvios declarados. `r2`. Etapa 2: 4 correções. `r3`. Etapa 3: 5 decisões.
  `r4`. Etapa 4: 3 decisões (proxy, moldura em tablet, ícones). `r5`. Etapa 5: 2
  decisões (pasta `infra/`, porta 443) e 3 correções. `r6`. Etapa 6: nenhuma. `r7`.
  Etapa 7: 1 decisão (gatilho da CI). `r8`. Etapa 8: 2 decisões, uma delas uma
  ambiguidade real do `produto.md` que o agente se recusou a resolver sozinho. `r9`.

## Decisões do agente sem o prompt pedir (declaradas)

`Architecture.Tests` separado e teste de pureza do Domain; `--ignore-exit-code 8`
provisório; `MSBuildTreatWarningsAsErrors`; `to_regclass` no ready; geração do cliente
só sob demanda; `JsonNumberHandling.Strict`; duas versões de TypeScript; remoção de
`AGENTS.md`, LICENSE e `.claude/settings.json` do template do Expo; `testID` no lugar
de XPath; validação da CI com branches descartáveis em três cenários; filtro com `jq`
para o `dotnet list package --vulnerable` (sai com 0 mesmo com achado); remoção dos
códigos HTTP não fixados nos diagramas; dois eventos extras no ADR 0005.

## Observações

- Um `rm -rf` do agente foi bloqueado pela proteção do Claude Code; refeito arquivo
  por arquivo.
- O agente foi além dos critérios na etapa 5 (resiliência: réplica parada, rodízio,
  as duas paradas, dados sobrevivendo à recriação do Postgres) e na etapa 7 (CI
  validada de verdade antes do commit).
- `npm audit`: 46 moderados e 1 baixo em ferramentas de build e teste, abaixo do
  corte do job de segurança.
- Itens deixados para passos futuros: remoção do `--ignore-exit-code 8` e primeiros
  testes de domínio (passo 2); ícones e splash reais (passo 4); Node 24, porta 443,
  HSTS e CSP (passo 13).
