# Registro da rodada `eng_08_premios` (trilha do engenheiro)

Passo 8 do plano mestre: prêmios de participação. Eventos, reivindicação como post com
foto, fila de comprovações, contestação e decisão da instituição, telas do aluno e do
professor.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_08_premios` (saída da `main` em `f28f404`); trabalho em `feat/passo-08-premios` |
| Sessão | `eda7b978-0adb-4556-9470-43140c532640`, aberta em 08/11/2026 18:55 UTC, encerrada às 21:57 UTC |
| Modelo | `claude-opus-5-5` em todas as 889 mensagens do agente, esforço `medium`, auto mode; `claude --version` e `/model` conferidos antes do primeiro prompt |
| Versão do CLI | 2.1.316 do início ao fim |
| Interrupções | Nenhuma; sem compactação. Narração em inglês em trechos das etapas 1 e 2, sem compactação, corrigida depois do pedido na `r2` |
| Ambiente | Em paralelo com a trilha do leigo (rodadas 0 a 7), por decisão de prazo (diário de 08/11); a pilha do engenheiro subiu primeiro; nenhum conflito observado nas duas trilhas |
| Prompts do autor | `eng_08_premios` (abertura), `eng_08_premios-r1` (plano) a `r9` (fechamento): 10 textos, 10 envios (a `r3` é escolha em menu) |
| Turnos humanos | 10 de conteúdo (9 mensagens e 1 escolha em menu), mais `/model` e 9 `/export` |
| Mensagens do agente | 889; 485 usos de ferramenta |
| Tokens (da transcrição) | saída 1.405.319; cache criado 2.063.373; cache lido 441.369.009; entrada sem cache 1.814 |
| Tempo de relógio | 3 h 01 min, numa sessão (08/11 15:55 a 18:57 no horário de Brasília), sem pausas |
| Commits do agente | 10: `78e2112`, `ba4c40a` (fix da CI), `b093836`, `9ec311a` (docs), `1777b8a`, `39ecd1c`, `12bc2a1`, `247e611`, `f3a9414`; todos com CI verde ao fim (a do `78e2112` falhou no job mobile e a do `b093836` foi cancelada pelo concurrency), sem rodapé de co-autoria |
| Commits do autor | Merge do PR #10 (`f48e9d9`) e `rodada/eng_08_premios` → `main` com `--no-ff` (`7417ebe`) |
| Merge | PR #10 `feat/passo-08-premios` → `rodada/eng_08_premios`; `main` em `7417ebe` |
| Resultado | API 892 testes (886 aprovados, 6 ignorados de antes); Jest 414; e2e 69; quatro migrations (Evento, PremioParticipacao, DecisaoDaComprovacao, Contestacao) |
| Export | `eng_08_premios-sessao.txt` (11.065 linhas) e `eng_08_premios-sessao.jsonl` (4.558 linhas) |

## O que saiu

Evento semeado (com itens aceitos e curso) e em texto livre; `data/demo/eventos.json`
com 8 eventos; `GET /v1/eventos`; reivindicação como post com foto numa transação, chave
de deduplicação pelo catálogo, corrida em 409; fila de comprovações por cursor com
escopo no banco, marca de 7 dias, aprovação enfileirando notificação, raridade e o
trabalho dos 15 dias, reprovação com motivo; contestação, fila da instituição,
confirmação e revogação; remoção pela instituição resolvendo o prêmio no mesmo ato;
`GET /v1/eu/reivindicacoes`; pontos e raridade contando prêmios válidos e definitivos;
app com modo "Reivindicar prêmio" no novo post, marcas no cartão, seção Reivindicações
em Troféus, tela Comprovações do professor com chips e folha de motivo, "Contestar
prêmio" no menu do post; e2e de prêmios; docs (decisões, produto.md 4.6, 4.7 e 8,
fluxos 02 e 04, plano mestre).

## Perguntas do agente e respostas do autor

- Plano: sete etapas e D1 a D13 pela recomendação, com acréscimo do autor na D3
  (`r1`); D3 corrigida pelo próprio autor depois de o agente apontar o recesso (`r2`).
- Menu interativo: apagar post de reivindicação, opção 1, bloqueio até definitivo
  (`r3`).
- Etapa 2: trava na remoção pela instituição aceita só até a etapa 4, quando passou a
  resolver o prêmio no mesmo ato (`r4`); matéria do P17 pela matrícula no semestre da
  data.
- Etapa 4: três pontos pela leitura do agente, com `PremioRevogado` na seção 8 (`r6`).
- Etapas 5 e 6: capturas conferidas pelo autor, sem prancheta (`r7`, `r8`).

## Decisões do agente sem o prompt pedir (declaradas)

Limite inferior da D3 no fim do último semestre encerrado (proposta depois do furo
apontado); `[Range(1, 8)]` removido da busca; P17 nunca semeado; nome do evento de 3 a
120; `exigeMateria` no item e `GET /v1/eu/materias`; handler `tornar-premio-definitivo`
e raridade adiantados da etapa 4 para a 3; lista de prêmios recolhida com "Trocar
prêmio" depois da primeira captura; folha de motivo compartilhada; conta de instituição
por teste no e2e por causa do limite de recuperações; branch de rodada enviada como
base do PR; spec temporário de capturas apagando reivindicações pendentes do compose
local.

## Observações

- Duas falhas de processo do agente, as duas declaradas e corrigidas pela regra do fix
  separado: CI vermelha na etapa 1 por não rodar o Jest do app antes do push; commit da
  etapa 2 enviado antes de ver que a edição do `produto.md` tinha falhado.
- O autor achou na revisão o furo da própria D3 (recesso) só porque o agente o
  levantou; e a etapa 1 pegou um teto `[Range(1, 8)]` que a revisão do passo 7 não
  tinha visto na API.
- Instabilidade de e2e sob carga paralela observada uma vez, não reproduzida,
  registrada no risco do plano mestre sem paliativo.
- Pendências: reavaliação de conquistas (passo 9); textos das notificações (10);
  recálculo de ranking e semestre do prêmio (11); telas da instituição, concessão direta
  e eventos no seed completo (12); instabilidade do e2e (13).
