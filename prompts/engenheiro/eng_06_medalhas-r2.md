ID: eng_06_medalhas-r2
Trilha: engenheiro
Tela: passo 6 (resposta 2 do autor: revisão da etapa 1, fila de trabalhos no Postgres e worker)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Commit de docs `be3f634` (avaliação remota nos READMEs, ADRs e produto), CI verde. "Banca" ficou só onde designa o órgão avaliador. Regra F adiada para o commit da etapa 4, decisão do agente aceita.
- Etapa 1: `IFilaDeTrabalhos.Enfileirar` na unidade de trabalho de quem chama; tabela `trabalho` (migration `Fila`) com índice parcial nos pendentes; consumidor com `FOR UPDATE SKIP LOCKED` rodando o handler na mesma transação, ponto de salvamento na falha, recuo 10/20/40/80 s, falho na quinta, erro sem carga, limite de 60 s por handler, tipo sem handler conta como falha; comando `worker` sem HTTP, serviço no compose com uma réplica; 14 testes novos (4 consumidores sobre 40 trabalhos, três rodadas), 489 no total.
- Ruído declarado: no teste do worker hospedado, um log "relation trabalho does not exist" antes da migração do teste; só ali.

---
Etapa 1 aprovada. A regra F na etapa 4 está certo. O ruído do "relation trabalho does not exist" no teste do worker hospedado pode ficar, registrado. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 2; para para a minha revisão no fim dela.
