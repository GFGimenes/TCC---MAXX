# Linha do Tempo do Experimento

Fases do experimento descrito nas seções 3.1 a 3.3 do TCC, organizadas para execução.
Cada fase lista entregável, pastas envolvidas e critério de "pronto". Datas ficam em
aberto; a ordem e as dependências entre fases é o que importa manter.

| # | Fase | O que é feito | Pastas envolvidas | Entregável / critério de pronto | Status |
|---|------|----------------|--------------------|----------------------------------|--------|
| 0 | Fundamentação já escrita | Contextualização, objetivos, teoria (vibe coding, LLMs, gamificação) | (já no PDF do TCC) | Seções 1 e 2 do TCC | Feito |
| 1 | A ideia (semente das trilhas) | Fixar a ideia como pitch, igual nas duas trilhas, e as regras completas como referência do autor; os repos nascem vazios (README e `.gitattributes`), sem `CLAUDE.md`; a ideia chega pelo prompt de abertura de cada persona | `docs/contexto-comum.md`, repos `maxx-leigo` e `maxx-engenheiro` | Os dois repos no mesmo commit semente vazio (`1577ae9`, 10/10/2026 22:59, README e `.gitattributes`); ideia, conhecimento por persona e política de reação do leigo documentados | Feito (12/09/2026 com `CLAUDE.md`; refeito em 11/10/2026 sem) |
| 2 | Pesquisa das personas de usuário | Perfil de como cada persona formula prompts para as mesmas telas | `personas/leigo/`, `personas/engenheiro/` | Perfil de cada persona com vocabulário, nível de detalhe e lacunas típicas | Feito (leigo N=28; engenheiro em 12/09/2026) |
| 3 | Especificação funcional por tela | Consolidar as telas (login, feed, perfil, mural, troféus, rankings) como escopo de referência | `docs/especificacao-telas.md` | Lista de telas/features com regras de negócio | Em consolidação |
| 4 | Escrita dos prompts | Um prompt por rodada e por trilha, escrito a partir do perfil da persona | `prompts/leigo/`, `prompts/engenheiro/` | 1 arquivo por rodada, ID rastreável (ex.: `leigo_login.md`) | Aberturas feitas (11/10/2026): `eng_00_produto`, `eng_00_tecnica`, `leigo_00_abertura`; respostas do autor dentro da rodada registradas como `eng_00_produto-r1..r4`; prompts de tela do leigo a fazer |
| 5 | Protocolo de rodada | Sessão nova do Claude Code (CLI) na pasta do repo da trilha, branch da rodada, export da sessão, segunda sessão como revisor, review humano, merge na `main`; ambiente conferido (modelo, versão, memória automática desligada, nenhum `CLAUDE.md` em lugar nenhum) | `protocolo-de-rodada.md` | Fluxo documentado e validado com uma rodada piloto ponta a ponta; modelo e versão registrados aqui | Protocolo escrito (10/10/2026); Orca abandonado; ambiente conferido em 11/10 (abaixo); piloto `eng_00` em andamento desde 11/10 |
| 6 | Execução das rodadas | Rodar cada prompt na sua trilha; registrar a sessão | repos das trilhas, `resultados/<trilha>/` | Registro de cada rodada salvo | `eng_00` em andamento (produto fechado em quatro respostas, catálogo congelado em 23/10; técnica a enviar); leigo a iniciar |
| 7 | Validação técnica (testes) | Testes unitários de referência sobre a lógica crítica gerada (pontuação dos prêmios por tier, ranking), seção 3.2 do TCC | dentro do repo da trilha | Suíte de referência rodada por rodada, resultado registrado | A fazer |
| 7b | Validação de carga | Teste de carga sintético (k6 ou autocannon), idêntico contra os dois deploys, com 200 e 2.000 usuários virtuais no feed, mural e upload de foto; registrar latência p95 e taxa de erro por trilha | `avaliacoes/carga/` | 1 relatório por trilha com os mesmos cenários e números | A fazer (depois do feed mergeado nas duas trilhas) |
| 8 | Review por rodada | Agente revisor pontua Código e Segurança; humano valida a nota antes de registrar | `avaliacoes/rubrica.md`, `avaliacoes/reviews/`, `avaliacoes/registro-avaliacoes.xlsx` | 1 linha por rodada na planilha, validada por humano | A fazer |
| 8b | Auditorias de milestone | Ao fechar cada camada (Autenticação, Banco de Dados, Gamificação, Frontend), avaliar Arquitetura e Mantenabilidade sobre o diff acumulado da trilha; UX ao final de cada feature navegável | `avaliacoes/`, repos das trilhas | 4 auditorias por trilha (8 no total) | A fazer |
| 9 | Deploy por trilha | Cada trilha no ar em uma URL própria (2 deploys), atualizada a cada rodada mergeada. O deploy é pedido pela persona, como qualquer outra rodada | repos das trilhas | 2 URLs navegáveis | A fazer |
| 10 | Consolidação comparativa | Cruzar leigo x engenheiro por eixo e por tela; features emergentes; custo de correção | aba "Resumo" da planilha | Tabela/gráficos comparativos | A fazer |
| 11 | Documentação final do TCC | Novo título ("A Mesma Ideia, Dois Construtores...", ver README) e nova pergunta de pesquisa, alinhados com o orientador; atualizar resumo/abstract, objetivos, 3.1 (contexto comum, um agente), 3.2 (teste de referência sobre pontos do prêmio) e 3.3 (Análise Comparativa) com os dados | PDF do TCC | Versão final do TCC | A fazer |

## Regra de review por trilha

- Trilha **leigo**: review **observacional**. Falhas encontradas são registradas, não
  corrigidas, para medir o efeito composto da falta de validação técnica.
- Trilha **engenheiro**: review **corretivo**. Corrigir e refinar prompts faz parte da
  persona; registrar o custo (tempo/iterações).

## Regra de contexto por trilha

Os repos nascem vazios. A ideia (o pitch de `docs/contexto-comum.md`) chega ao agente
pelo prompt de abertura de cada persona. O engenheiro transforma a ideia em regras de
produto e requisitos técnicos antes do código e pode mandar o agente gravar isso como
`CLAUDE.md` do repo dele; o leigo entrega o pitch e segue a política de reação. Cada
trilha evolui o próprio contexto apenas por meio dos próprios prompts. Nunca copiar
contexto, código ou decisão entre trilhas.

## Ambiente fixado para as rodadas (conferido em 11/10/2026)

Igual nas duas trilhas, do piloto até a última rodada; nenhum item muda no meio.

- Claude Code (CLI) 2.1.270, Windows, PowerShell.
- Modelo: `claude-opus-5[1m]` (Opus 5, 1M de contexto), escolhido por nome com
  `/model` (opção "Opus (1M context)", não a "Default", que segue o padrão do momento
  e poderia mudar). Esforço: high (padrão). Motivo: é o modelo padrão que uma pessoa
  sem repertório técnico recebe ao abrir o CLI, e o custo e o contexto sustentam as
  rodadas longas; o modelo mais capaz (Fable 5.1) foi descartado por ser o caso
  limite de preenchimento de lacunas, não o caso representativo.
- Memória automática desligada (`CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` na janela de
  cada sessão). Nenhum `CLAUDE.md` ou `AGENTS.md` no usuário, nos ancestrais da pasta
  nem nos repos das trilhas (conferido com `Get-ChildItem` antes de abrir o CLI).
- `/context` ao abrir a sessão do engenheiro: 37,8k tokens (sistema 2,4k, ferramentas
  31,9k, skills 3,3k, mensagens 167), sem arquivo de memória e sem `CLAUDE.md`.
  Skills visíveis ao agente (`/context all`, 26 no total, 3,7k tokens): 9 do usuário
  (`orchestration`, `orca-cli`, `maestri`, `maestri-manager`, `maestri-workspace`,
  `maestri-portal`, `maestri-portal-devices`, `maestri-routines`, `computer-use`) e
  17 embutidas no CLI (`dataviz`, `claude-api`, `code-review`, `security-review`,
  `simplify`, `init`, `artifact-*`, `claude-in-chrome`, `schedule`, `run`, `loop`,
  `workflow-authoring`, `update-config`, `keybindings-help`, `fewer-permission-prompts`).
  Iguais nas duas trilhas; `orca-cli` é o orquestrador abandonado em 10/10 e continua
  instalado. O uso de qualquer skill por iniciativa do agente é registrado no review
  da rodada.
- Conectores MCP da conta (claude.ai), visíveis depois do login: Atlassian Rovo (41
  ferramentas), Claude Docs (8), Expedia (3), Kiwi.com (2), lastminute.com (8); 49
  ferramentas carregadas sob demanda, 672 tokens. Nenhum tem relação com o projeto;
  iguais nas duas trilhas. Depois do login o `/context` mostrou 26 skills (3,7k) e
  ferramentas do sistema em 23k; o total antes do primeiro prompt ficou em torno de
  30k tokens.
- Modo de permissão: "auto mode" (o agente executa sem pedir aprovação a cada ação),
  o mesmo nas duas trilhas.
- Versão do CLI: a atualização automática trocou a versão duas vezes dentro da `eng_00`,
  sem ação do autor (conferido na transcrição `.jsonl`): 2.1.270 em 11/10 (produto e
  primeira resposta), 2.1.296 em 12/10 (`r1` e resposta), 2.1.308 de 22/10 em diante.
  Decisão (22/10): 2.1.308 passa a ser a versão fixa de todas as rodadas, com
  `DISABLE_AUTOUPDATER=1` em toda janela. Mesma sessão, mesmo modelo, mesmo histórico.
  A trilha do leigo roda inteira na 2.1.308.
- Modelo e esforço (conferido nos `.jsonl` em 02/11/2026): a opção "Opus (1M
  context)" entregou `claude-opus-5` com esforço `high` em toda a `eng_00` (até 02/11
  00:14 UTC) e `claude-opus-5-5` com esforço `medium` na `eng_01_fundacao` (sessão
  aberta cinco minutos depois), sem ação do autor e sem aviso do CLI. Decisão
  (02/11): `claude-opus-5-5`, `medium`, auto, 2.1.308 é o ambiente fixo de todas as
  sessões restantes, nas duas trilhas. A `eng_00` (só documentação) fica como exceção
  declarada. Antes do primeiro prompt de cada sessão, `/model` conferido contra o
  registro; no fim, o `.jsonl` confirma. A trilha do leigo roda inteira num dia só.
  Na abertura da `eng_02_dados` (02/11) o `/model` passou a nomear a opção como
  "Opus 5.5 (1M context)", com "Medium effort (default)"; conferido por captura de tela
  antes do primeiro prompt.
- Versão do CLI, de novo (04/11): a `eng_03_auth` abriu na 2.1.316, apesar de
  `DISABLE_AUTOUPDATER=1` (provável instalação por uma janela sem a variável). Modelo e
  esforço iguais. Declarada a partir da `eng_03_auth`; conferir `claude --version`
  antes de cada sessão e registrar a versão no registro da rodada.
- Condição de prompt único pré-registrada (08/11): `docs/tcc/pre-registro-prompt-unico.md`,
  prompts `eng_pu` e `leigo_pu` congelados, repositórios próprios e vazios
  (`maxx-engenheiro-pu`, `maxx-leigo-pu`), mesmo ambiente das rodadas desde a
  `eng_03_auth` (2.1.316, `claude-opus-5-5`, `medium`, auto). Executada entre os
  passos 7 e 8 da trilha do engenheiro, `eng_pu` antes de `leigo_pu`, no mesmo dia.
  Commit de pré-registro: `4d4cc4b` (08/11/2026, 04:10 UTC).

## Dependências entre fases

- Fase 4 (prompts) depende da fase 2 (personas) e da fase 3 (especificação por tela).
- Fase 6 (execução) depende da fase 5 estar validada com uma rodada piloto ponta a
  ponta (sugestão: `login`, nas duas trilhas).
- Fase 8 (pontuação) só começa depois da fase 7 (testes): o eixo Código usa o
  resultado dos testes como critério objetivo.
- Fase 9 (deploy) depende da primeira feature navegável (login) estar mergeada. A
  infra do deploy é a mínima nas duas trilhas (a carga real do TCC é de 10 a 20
  pessoas); a projeção de escala é decisão de persona, não de infra.
- Fase 7b (carga) depende do feed e do upload de foto mergeados nas duas trilhas, e
  roda os mesmos cenários contra os dois deploys.
- Fases 10 e 11 dependem de todas as telas terem rodado nas duas trilhas.

## Convenção de nomenclatura

Mesmo ID em prompt, resultado, review e planilha:

```
prompts/leigo/leigo_login.md
resultados/leigo/leigo_login.md
avaliacoes/reviews/leigo_login.md
avaliacoes/registro-avaliacoes.xlsx  (linha com ID = leigo_login)
```

Rodadas extras da mesma tela (correção na trilha do engenheiro, repetição de pedido
na trilha do leigo) recebem sufixo: `eng_login_v2`, `leigo_login_v2`.
