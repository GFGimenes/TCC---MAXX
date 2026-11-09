ID: eng_11_rankings-r3
Trilha: engenheiro
Tela: passo 11 (resposta 3 do autor: revisão da etapa 2, tabela e worker; mudança de cadência)
Data: 2026-11-09
Origem: leitura do Cowork (Anthropic) do export da sessão; sem capturas nesta etapa; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1 em commit próprio com CI verde (relatado pelo agente antes da etapa 2).
- Etapa 2 entregue sem commit: tipo de trabalho `recalcular-ranking`; migration `Ranking` com `posicao_no_ranking` (checagens de semestre e curso por visão, posição e pontos positivos; dois índices únicos com NULLS NOT DISTINCT; cascata de aluno, semestre e curso); `RecalculoDoRanking` no modelo do recálculo de raridade (linha própria em `recalculo` com FOR UPDATE, coalescência de 10 s com pedido adiado, reescrita do histórico e dos semestres abertos numa transação, congelados intocados); seed base pede o recálculo quando o calendário é novo ou mudou ou quando nunca calculou, idempotente; 12 testes de integração novos e 1 no seed; integração sozinha 563 aprovados, 6 ignorados; format e build limpos.
- Instabilidade declarada: solução inteira com 2 falhas numa rodada (nomes perdidos pelo filtro) e 1 na seguinte (tempo esgotado de HTTP com o contêiner de armazenamento em `ContestacoesTests`), fora do caminho da etapa, passando na rodada só da integração; o agente tomou como carga do ambiente sem confirmar. Autor aceitou, com o registro.
- Alteração de protocolo declarada pelo autor, por prazo (entrega no mesmo dia): a partir desta resposta, o agente emenda etapas sem tela e sem pergunta de produto, parando antes de etapa com captura, em qualquer pergunta de produto e em CI vermelha. Mantidos: um commit por etapa, CI verde por etapa antes de seguir, fix separado, relatório por etapa. Registrada também no diário e na linha do tempo.

---
Etapa 2 aprovada. A falha do tempo esgotado com o contêiner de armazenamento na solução inteira fica registrada como ocorrência de ambiente, como você fez; o caminho não é desta etapa e passou sozinho. Commita com a mensagem proposta, push e acompanha a CI. Mudança de cadência daqui em diante, por prazo: com a CI da etapa 2 verde, emenda as etapas 3 e 4 sem parar para mim, cada uma com o próprio commit, o próprio push e a própria CI verde antes de seguir, fix separado se a CI falhar, e o relatório de cada etapa no fim. Para só se aparecer pergunta de produto que não está nos docs, se uma CI ficar vermelha depois do fix, ou antes da etapa 5, que tem tela e eu preciso conferir as capturas. Me traz então os relatórios das etapas 2, 3 e 4 juntos, com os commits e as CIs.
