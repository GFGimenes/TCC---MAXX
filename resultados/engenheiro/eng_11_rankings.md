# Registro da rodada `eng_11_rankings` (trilha do engenheiro)

Passo 11 do plano mestre: rankings. Domínio da pontuação por semestre, tabela das quatro
visões escrita pelo worker com coalescência, enfileiramento em todo evento que muda
pontos, leitura por cursor com a linha do próprio aluno, tela de Rankings com entrada
pelo perfil e pela Busca, posição no feed e em Troféus, docs e e2e.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_11_rankings` (saída da `main` em `d4ac193`); trabalho em `feat/passo-11-rankings` |
| Sessão | `0a34ed65-2d67-4d0c-b554-d0be9cee7633`, aberta em 09/11/2026 10:58 UTC, encerrada em 09/11/2026 15:25 UTC |
| Modelo | `claude-opus-5-5` em todas as 596 mensagens do agente, esforço `medium`, auto mode; `claude --version` e `/model` conferidos antes do primeiro prompt |
| Versão do CLI | 2.1.316 do início ao fim |
| Interrupções | Nenhuma; sem compactação. Pausa do autor de 1 h 04 min entre o relatório da etapa 1 (08h28 de Brasília) e a aprovação (09h32), com a sessão aberta esperando |
| Ambiente | Sessão aberta com o autor longe do PC e operando à distância (AnyDesk a partir do celular, com o Cowork acompanhando a tela pelo app, sem digitar) até a etapa 5; pilha do compose reconstruída pelo agente para as capturas, com contas de e2e antigas no banco |
| Alteração de protocolo | A partir da `r3` (etapa 2), cadência por grupo: o agente emenda etapas sem tela e sem pergunta de produto, cada uma com commit, push e CI verde próprios, e para antes de etapa com tela, em pergunta de produto e em CI vermelha depois do fix. Motivo: prazo de entrega no mesmo dia. Mantidos um commit por etapa, CI verde por etapa, fix separado e relatório por etapa; muda só a frequência do checkpoint do autor. Aplicada às etapas 2, 3 e 4 (41 min as três) |
| Prompts do autor | `eng_11_rankings` (abertura), `eng_11_rankings-r1` (plano) a `r6` (fechamento): 7 textos, 7 envios |
| Turnos humanos | 7 mensagens de conteúdo, `/model` e 6 `/export` |
| Mensagens do agente | 596; 333 usos de ferramenta |
| Tokens (da transcrição) | saída 606.350; cache criado 1.502.617; cache lido 223.846.151; entrada sem cache 1.232 |
| Tempo de relógio | 4 h 27 min de ponta a ponta (09/11 07:58 a 12:25 no horário de Brasília); 3 h 23 min de atividade (descontada a pausa do autor) |
| Commits do agente | 7: `9df9145`, `8851bd8`, `a53b88d`, `1681071`, `1857690` (CI vermelha nos jobs mobile e e2e), `3741da9` (fix), `f38df5e`; todos com CI verde ao fim, sem rodapé de co-autoria |
| Commits do autor | Merge do PR #13 (`3e135f8`) e `rodada/eng_11_rankings` → `main` com `--no-ff` (`e43a83a`) |
| Merge | PR #13 `feat/passo-11-rankings` → `rodada/eng_11_rankings`; `main` em `e43a83a` |
| Resultado | Domínio 581 testes; integração 598 (6 do R2 ignorados); Jest 489; e2e 77 local com o `rankings.spec` nos dois temas; uma migration (Ranking) |
| Export | `eng_11_rankings-sessao.txt` (5.337 linhas) e `eng_11_rankings-sessao.jsonl` (3.203 linhas) |

## O que saiu

`Maxx.Domain.Ranking` com `ParcelaDoRanking` (o que pontua, em que semestre e com que
instante), `Classificacao` (soma, ordem por pontos, instante mais antigo e id do aluno;
aluno sem pontos sem linha; ex-aluno só no histórico; curso atual) e
`SemestresDoRanking` (atual, congelado reaproveitando o congelamento do passo 9,
abertos); migration `Ranking` com `posicao_no_ranking` (checagens por visão, dois
índices únicos, cascata); `RecalculoDoRanking` no modelo do recálculo de raridade, com
coalescência de 10 s e reescrita do histórico e dos semestres abertos numa transação;
ponto único `fila.PedirRecalculos()` substituindo o pedido de raridade em 11 lugares;
`GET /v1/rankings` com escopo, período, seguidos e cursor de 20, linha própria, 403 e
400 por regra de visão; `posicao` no perfil e no autor do post; tela de Rankings com
chips por quem vê, card "Sua posição", "Todos / Quem eu sigo", lista com destaque e
marca de ex-aluno; entrada pelo perfil, pela Busca e por Troféus; posição na linha do
autor no feed; e2e; produto.md 4.9, 5 e 6.5 com as seis respostas; decisões, fluxos 02 a
05 e plano mestre com pendências para o 12 e o 13.

## Perguntas do agente e respostas do autor

- Plano: seis etapas, propostas A a G e seis perguntas de produto, todas pela
  recomendação (`r1`): conquista de ano no segundo semestre do ano e a de curso no
  semestre da concessão; desempate por fonte com o id como último critério; aluno sem
  pontos fora da tabela; perfil com a posição do histórico geral; "Todos / Quem eu sigo"
  da prancheta entra; aluno vê o curso atual, ex-aluno só o histórico do último curso,
  professor e instituição só Geral e Histórico.
- Etapa 1 (`r2`): prêmio de evento no recesso sem semestre seguinte pontua só no
  histórico até o calendário ganhar o semestre, aceito; respostas no produto.md ficam
  na etapa 6.
- Etapa 2 (`r3`): tempo esgotado com o contêiner de armazenamento na solução inteira
  aceito como ocorrência de ambiente; cadência por grupo declarada.
- Etapas 2 a 4 (`r4`): quatro decisões de detalhe aceitas (o próprio aluno em "Quem eu
  sigo", sem ETag até o k6, parâmetros em texto, ausência checada no endpoint).
- Etapa 5 (`r5`): capturas conferidas, três diferenças declaradas aceitas (sem navegação
  inferior, rótulo acima do segmentado, curso pela sigla); o "#" do feed e de Troféus,
  que o código dava para o passo 11, incluído na etapa com API e cliente no mesmo commit.
- Etapa 6 (`r6`): capturas de feed e Troféus conferidas; commit antes da revisão aceito
  como ocorrência, sem correção.

## Decisões do agente sem o prompt pedir (declaradas)

Trabalho separado do de raridade com a mesma coalescência; semestre atual é o último que
já começou; congelados intocados e histórico nunca congela; lista por cursor de 20 com
card fixo; worker já respeita ex-aluno e troca de curso com o enfileiramento desses atos
pendente para o 12; sem p95 neste passo; seed base pede o recálculo quando o calendário
muda; `MundoDeConquistas.AprovadoAsync` com início opcional; "Quem eu sigo" com a linha
própria; sem ETag; parâmetros em texto; validação de ausência no endpoint; `posicao`
nula nas filas de comprovação e contestação; captura do "Todos" com contas do e2e e
telas da turma por "Quem eu sigo"; teste da etapa 2 avançando 10 s pela coalescência.

## Observações

- Primeira rodada com a cadência por grupo de etapas: as etapas 2, 3 e 4 saíram em 41
  min sem fix e sem pergunta, contra 20 min de mediana por etapa na cadência anterior.
- CI vermelha na etapa 5 por testes antigos (e2e procurando "30 pts" exato; Jest lendo
  antes dos dados no runner), depois de o agente ter rodado localmente só o teste novo;
  fix separado, regra respeitada.
- O agente commitou e pushou a etapa 6 antes da revisão do autor e declarou o desvio
  sozinho, oferecendo correção por commit novo; o autor não teve correção a pedir.
- O agente publicou a `rodada/eng_11_rankings` no remoto para o GitHub aceitar o PR,
  como no passo 10, e declarou.
- Pendências herdadas: marcar ex-aluno, trocar de curso e concessão direta pedindo o
  recálculo (12); p95 do ranking e da posição no perfil e no feed, saúde do worker (13).
