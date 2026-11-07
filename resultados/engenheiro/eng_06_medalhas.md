# Registro da rodada `eng_06_medalhas` (trilha do engenheiro)

Passo 6 do plano mestre: medalhas, fila e worker. Primeira infraestrutura assíncrona do
produto e primeiro ciclo completo de uma regra de negócio, da concessão pelo professor
à tela do aluno.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_06_medalhas` (saída da `main` em `9115368`); trabalho em `feat/passo-06-medalhas` |
| Sessão | `31e8808d-0a36-4342-8599-977d5e0ccc1e`, aberta em 07/11/2026 20:27 UTC, encerrada em 07/11/2026 23:32 UTC |
| Modelo | `claude-opus-5-5` em todas as 573 mensagens do agente, esforço `medium`, auto mode; `claude --version` e `/model` conferidos antes do primeiro prompt |
| Versão do CLI | 2.1.316 do início ao fim |
| Interrupções | Nenhuma; sem compactação; disco compactado antes da rodada |
| Prompts do autor | `eng_06_medalhas` (abertura), `eng_06_medalhas-r1` (plano) a `r11` (PR e encerramento): 12 textos, 12 envios |
| Turnos humanos | 12 mensagens de conteúdo, mais `/model` e 11 `/export` |
| Mensagens do agente | 573 (inclui uso de ferramenta); 324 resultados de ferramenta |
| Tokens (da transcrição) | saída 858.569; cache criado 1.194.878; cache lido 222.717.885; entrada sem cache 1.180 |
| Tempo de relógio | 3 h 04 min, numa sessão (07/11 17:27 a 20:32 no horário de Brasília), a mais rápida por etapa até aqui |
| Commits do agente | 11: docs inicial (`be3f634`) e dez etapas (`4ff1d2d`, `9cbf9f7`, `f129e21`, `e9abe4f`, `dab5094`, `1b44566`, `50ee7b7`, `e389889`, `e9971ff`, `a29482d`), todos com CI verde, sem rodapé de co-autoria |
| Commits do autor | Merge do PR #8 (`bd2b044`) e `rodada/eng_06_medalhas` → `main` com `--no-ff` (`a225e29`) |
| Merge | PR #8 `feat/passo-06-medalhas` → `rodada/eng_06_medalhas`, 11 commits verdes; `main` em `a225e29` |
| Resultado | Domínio 278, arquitetura 4, integração 275, Jest 317, e2e 61; cinco migrations (Fila, TokenEmitidoNoWorker, Medalha, MedalhaVersao, Notificacao e Raridade) |
| Export | `eng_06_medalhas-sessao.txt` (7.263 linhas) e `eng_06_medalhas-sessao.jsonl` (3.130 linhas) |

## O que saiu

Fila de trabalhos no Postgres com `FOR UPDATE SKIP LOCKED`, handler na transação do
trabalho, ponto de salvamento, recuo exponencial e estado falho; worker como comando
sem HTTP em contêiner próprio; e-mail migrado para a fila com o token emitido no worker;
domínio da medalha com snapshot do item, limite por período, ocorrência pela menor vaga
livre e chave de deduplicação; rotas do professor (turmas, alunos, catálogo, concessão)
com escopo no banco, oito recusas com código e concorrência sem 500; comando
`anular-medalha` com concorrência pelo xmin; notificação idempotente; raridade por
escassez em tabela própria com coalescência de 10 s, recalculada também no cadastro;
`GET /v1/eu/premios`; telas do professor (turmas, alunos, modal de concessão), tela de
Troféus pela prancheta e navegação de cinco abas; e2e de ponta a ponta (professora criada
por execução, concessão pela tela, anulação pelo comando); docs do passo e a troca de
"banca presencial" por avaliação remota em todos os docs.

## Perguntas do agente e respostas do autor

- Plano: dez etapas e doze decisões A a L, todas pela recomendação; regra F (aluno sem
  conta não recebe medalha) registrada no produto. `r1`.
- Etapas 1 a 9: sem decisão nova salvo a validade do token contada do envio (`r3`), o
  numerador limitado ao divisor (`r7`), item restrito fora da lista e recálculo no
  cadastro (`r8`), trilha mista nas duas abas (`r10`). `r2` a `r10`.
- PR: `r11`.

## Decisões do agente sem o prompt pedir (declaradas)

Regra F adiada para o commit da etapa 4; limite de 60 s por handler; tipo sem handler
conta como falha; validade do token de recuperação contada do envio; tipo `Proibido` na
Application; releitura única na corrida de vagas; xmin na medalha; purga ampliada
(medalha, notificação); seed base pedindo o primeiro recálculo; numerador limitado ao
divisor; recálculo no cadastro e na demonstração; `nomeDeExibicao` no `/v1/eu`;
`Cabecalho`, ícones novos, `accessibilityLabel`; teste de mensagens lendo todos os
`Codigos*.cs`; correções visuais antes das capturas (caixa alta, switch verde da web,
polegar escuro, rótulo dos passos da trilha).

## Observações

- Rodada sem nenhuma falha de CI, sem interrupção e sem bug achado depois do commit;
  todas as correções do agente vieram antes do commit (testes e capturas).
- O agente adiou a regra F para o commit onde ela passa a valer no código, decisão
  própria aceita; e apontou um ponto fora da lista do ADR 0005 (cadastro muda o divisor
  da raridade), que o autor decidiu incluir.
- Pendências para passos futuros: texto das notificações e bolinha de novidade (passo
  10); posição no ranking (passo 11); alerta de trabalho falho (passo 13); conquistas
  e prêmios de participação na raridade (passos 8 e 9).
