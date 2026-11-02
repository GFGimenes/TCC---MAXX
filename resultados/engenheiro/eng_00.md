# Registro da rodada `eng_00` (trilha do engenheiro)

Rodada de abertura: definição de produto (`eng_00_produto`), definição técnica
(`eng_00_tecnica`) e passo 0 do plano mestre (fundação documental), sem código.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_00` (saída da semente `1577ae9` com o commit do design `9412465`) |
| Sessão | `e358b13d-a55a-4eb9-b495-1ea2122799fb`, aberta em 11/10/2026 20:18 UTC, encerrada em 02/11/2026 00:14 UTC |
| Modelo | `claude-opus-5[1m]`, esforço high, auto mode |
| Versão do CLI | 2.1.270 em 11/10 (produto e primeira resposta), 2.1.296 em 12/10 (`r1` e resposta), 2.1.308 de 22/10 em diante (`r2` até o fim). Duas atualizações automáticas, sem ação do autor; `DISABLE_AUTOUPDATER=1` só a partir de 22/10 |
| Interrupções | Reinício do computador em 11/10 (retomada com `--resume` em 12/10); "Connection lost mid-response" em 22/10 ao receber a `r2`, reenviada em 23/10 |
| Prompts do autor | `eng_00_produto`, `eng_00_produto-r1` a `r4`, `eng_00_tecnica`, `eng_00_tecnica-r1` a `r9`, mensagem de encerramento: 16 textos distintos, 17 envios (a `r2` duas vezes) |
| Turnos humanos | 17 mensagens de conteúdo, mais comandos de barra (`/model`, `/login`, `/context`, `/export` duas vezes) |
| Mensagens do agente | 137 (inclui mensagens de uso de ferramenta); 66 resultados de ferramenta |
| Tokens (da transcrição) | saída 477.820; cache criado 1.217.397; cache lido 30.253.226; entrada sem cache 272 |
| Tempo de relógio | 11/10 a 02/11 (22 dias corridos, cinco dias de trabalho: 11/10, 12/10, 22/10, 23/10, 01/11 a 02/11) |
| Commits do agente | 7 (`133f129` a `9a7e751`), reescritos sem rodapé de co-autoria a pedido do autor |
| Commits do autor | 2 (`9412465` design, antes da sessão; `561cc2a` README do design) |
| Merge | PR #1 `docs/passo-00-fundacao` → `rodada/eng_00` (`a6f93fa`); `rodada/eng_00` → `main` com `--no-ff` (`af80558`) |
| Export | `eng_00-sessao.txt` (4.194 linhas) e `eng_00-sessao.jsonl` (1.020 linhas) nesta pasta |

## O que saiu

Sem código. No repositório da trilha: `docs/produto.md` (regras de produto, 541 linhas,
13 seções), `data/catalogo/` (11 medalhas, 17 prêmios de participação, 18 conquistas,
8 famílias de trilha, com regra declarativa de conquista em duas formas de contagem),
`docs/regras-conquista.md`, `docs/decisoes/` (8 ADRs com Mermaid e índice de todas as
decisões), `docs/plano-mestre.md` (13 passos, definição de pronto, protocolo de
trabalho, fase 2, riscos) e `CLAUDE.md` (regras operacionais da trilha). Mais o
`design/README.md` do autor.

## Perguntas do agente e respostas do autor

- Resposta ao `eng_00_produto`: 8 bloqueadores, cerca de 40 lacunas em 10 áreas, 4
  contradições. Respondidos na `produto-r1`.
- Resposta à `r1`: modelo revisado, 20 decisões pendentes com sugestão, 4
  inconsistências nos exemplos do autor. Respondidos na `r2` (14 sugestões aceitas, 6
  decisões próprias).
- Resposta à `r2`: catálogo proposto (48 itens) e 8 decisões novas. `r3` (5 aceites, 3
  próprias). Catálogo congelado em 46; 2 pontos finais na `r4`.
- Resposta ao `eng_00_tecnica`: 8 contradições entre design e produto, 4
  contraindicações da stack, 15 decisões técnicas com pesos, modelo de dados, seed,
  pipeline, 4 riscos, plano mestre de 13 passos, 6 bloqueantes e 8 importantes.
  `tecnica-r1`.
- Plano do passo 0: 3 consequências, 8 perguntas. `tecnica-r2`.
- Etapas E0.1 a E0.5: cada uma com perguntas ou decisões declaradas; `tecnica-r3` a
  `r9`.

## Decisões do agente sem o prompt pedir (declaradas)

Termo de uso versionado; tabela de estatística de raridade escrita pelo worker;
campos `tipoDeEvento` e `formaDoEvento` no catálogo; limites de repetição por item
(depois substituídos pela estrutura real de avaliação dada pelo autor); duas formas de
contagem em vez de três; oito famílias em vez de sete; inversão dos passos 7 a 9 do
plano por dependência; identificadores sem acento; snake_case no Postgres; glossário
com proibição de sinônimos; instância do período `curso` igual ao aluno; literal 4 na
C14; os 18 nomes das conquistas (2 trocados pelo autor); os 3 princípios do catálogo;
uso de `git filter-branch` para reescrever commits.

## Decisões do autor contra a sugestão do agente

Raridade pela escassez (agente dava peso 5; 9 à fixa no catálogo); ex-alunos nos dois
lados da conta de raridade; sem plano B local de rede; sem rodapé de co-autoria nos
commits; barra de navegação mantida com rankings pelo perfil e pela Busca; medalhas
discricionárias fora; arroba com sufixo de curso; aluno nunca acumula papel.

## Regras ausentes

Não se aplica nesta rodada: o produto ainda não existe. A lista de regras do produto
para o inventário de cobertura sai de `docs/produto.md` e de `docs/contexto-comum.md`.

## Observações

- O agente cumpriu "nada de código" durante toda a rodada e pediu permissão antes de
  ler o repositório ("prefiro não sair fuçando").
- Três correções do próprio agente sobre a própria proposta (formas de contagem, ordem
  dos passos, dependência post antes de prêmio) e uma correção do autor sobre decisão
  anterior (acúmulo de papéis).
- A rodada é longa por desenho: é a definição inteira do produto e da técnica. A
  contagem de turnos e tokens entra na tabela de custo de entrada do engenheiro.
