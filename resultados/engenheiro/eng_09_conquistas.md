# Registro da rodada `eng_09_conquistas` (trilha do engenheiro)

Passo 9 do plano mestre: conquistas. Avaliador puro, reavaliação por fato no worker,
recálculo na anulação, fechamento de período e congelamento, leitura e tela de Troféus,
post de conquista, docs e e2e.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_09_conquistas` (saída da `main` em `7417ebe`); trabalho em `feat/passo-09-conquistas` |
| Sessão | `8f686629-a938-4c06-bdfd-bbf74ba41330`, aberta em 08/11/2026 22:01 UTC, encerrada em 09/11/2026 02:13 UTC |
| Modelo | `claude-opus-5-5` em todas as 736 mensagens do agente, esforço `medium`, auto mode; `claude --version` e `/model` conferidos antes do primeiro prompt |
| Versão do CLI | 2.1.316 do início ao fim |
| Interrupções | Nenhuma; sem compactação. Uma mensagem acidental do autor (uma vírgula) antes do PR, tratada pelo agente como envio acidental |
| Ambiente | Em paralelo com as últimas rodadas do leigo e com a execução do avaliador no produto do leigo; `maxx-engenheiro` tornado público durante a etapa 1 pelo limite de minutos do Actions (linha do tempo); job mobile com timeouts do Jest no runner nas etapas 1 e 2, resolvidos com `testTimeout` de 15 s em commit separado; suíte local com 3 falhas por disputa de recurso com a pilha do compose de pé, limpa com a pilha parada |
| Prompts do autor | `eng_09_conquistas` (abertura), `eng_09_conquistas-r1` (plano) a `r9` (fechamento): 10 textos, 10 envios |
| Turnos humanos | 10 mensagens de conteúdo, mais 1 acidental, `/model` e 9 `/export` |
| Mensagens do agente | 736; 401 usos de ferramenta |
| Tokens (da transcrição) | saída 844.164; cache criado 1.373.838; cache lido 317.869.200; entrada sem cache 1.510 |
| Tempo de relógio | 4 h 12 min de ponta a ponta (08/11 19:01 a 23:13 no horário de Brasília); 3 h 48 min de atividade |
| Commits do agente | 9: `52ad6c3`, `43d0f64`, `febe605` (fix do Jest), `92489e6`, `bc72a23`, `a6e356f`, `132a8dc`, `5e0e8f6`, `fb0e63c`; todos com CI verde ao fim (a do `52ad6c3` na segunda tentativa, a do `43d0f64` só depois do fix), sem rodapé de co-autoria |
| Commits do autor | Merge do PR #11 (`70961f7`) e `rodada/eng_09_conquistas` → `main` com `--no-ff` (`eda626c`) |
| Merge | PR #11 `feat/passo-09-conquistas` → `rodada/eng_09_conquistas`; `main` em `eda626c` |
| Resultado | API 1034 testes (6 da R2 ignorados); Jest 420; e2e com o fluxo de conquistas nos dois temas; três migrations (Conquista, FechamentoDePeriodo, PostDeConquista) |
| Export | `eng_09_conquistas-sessao.txt` (8.043 linhas) e `eng_09_conquistas-sessao.jsonl` (3.834 linhas) |

## O que saiu

`AvaliadorDeConquista` puro com as duas formas de contagem, alvo dinâmico por matérias
distintas, restrição de curso e vigência; `FatoContavel` (medalha ativa e prêmio
definitivo); conquista com evidências e congelamento de tier, pontos e versão; trabalho
`reavaliar-conquistas` disparado pela medalha, pelo fim da janela e pela confirmação da
contestação, com trava consultiva por aluno e índice como rede de segurança; recálculo
na anulação com remoção lógica; fechamento de período (`verificar-fechamentos` de hora
em hora, `fechar-periodo`, um trabalho por aluno) e reavaliação até o congelamento (30
dias depois do semestre); tipo de período como texto na carga da fila; leitura de
Troféus com instância e progresso (com unidade "matérias"), perfil sem progresso; tela
de Troféus com "Regra automática · critério", rótulo da instância e linha "2 de 3 neste
bimestre"; post de conquista com `conquistaId`; docs (produto.md 4.9 e 8,
regras-conquista.md, decisões, fluxos 03 e 04, plano mestre); e2e.

## Perguntas do agente e respostas do autor

- Plano: oito etapas (sete mais o post de conquista), D1 a D10 técnicas e quatro
  perguntas de produto, todas pela recomendação (`r1`): semestre do prêmio de
  participação pela data de início do evento; post de conquista agora; matérias
  distintas; linha de progresso sob o critério.
- Etapas 1 a 7: decisões técnicas do agente aceitas em cada relatório (`r2` a `r8`),
  com dois ajustes do autor: tipo de período como texto na carga (`r5`) e a unidade
  "matérias" feita na etapa da tela (`r7`).
- Fix do Jest aprovado em separado (`r4`).

## Decisões do agente sem o prompt pedir (declaradas)

Conquista de bimestre só conta medalha; teste por item no projeto de integração; evento
no recesso sem semestre seguinte espera o calendário; trava consultiva em vez de tratar
a violação do índice; notificação gravada pelo handler; ambos os tipos de notificação na
mesma migration; regra `customizada` sem gatilho por fato; anulação nunca concede;
mudança de catálogo não remove conquista; "fim mais 30 já congelado"; instância em
números com rótulo no cliente; sem progresso de bimestre e semestre no recesso; contagem
simples na leitura; critério na frase inteira do catálogo; post da conquista removida
pela regra da medalha anulada; `JsonIgnore` na propriedade calculada; `testTimeout`
global de 15 s.

## Observações

- Primeira rodada em que uma CI ficou vermelha três vezes sem código do agente envolvido
  (timeouts do runner); tratada com investigação, risco registrado e fix separado.
- O agente apontou duas lacunas dos docs (agendador do ADR 0008 nunca construído;
  notificação de conquista fora da seção 8) e as fechou no passo.
- Prova reversa do teste de concorrência (sem a trava, falha nas três rodadas) como
  padrão de verificação.
- Pendências herdadas: textos das notificações e bolinha de Troféus (10); recálculo de
  ranking pela conquista e semestre da instância (11); conquistas no seed completo e
  anulação pela área web (12); risco do tempo do primeiro teste de cada arquivo do Jest
  (13).
