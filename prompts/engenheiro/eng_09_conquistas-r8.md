ID: eng_09_conquistas-r8
Trilha: engenheiro
Tela: passo 9 (resposta 8 do autor: revisão da etapa do post de conquista)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 6 em `132a8dc` (com a unidade "matérias"), CI verde na primeira tentativa. Verificação local da etapa 6 teve 3 falhas na suíte da API com a pilha do compose de pé (disputa de recurso; o teste do migrador levou 1 min 24 s); com a pilha parada a suíte passou limpa antes do commit. Ocorrência de ambiente na máquina de 4 GB de teto do WSL.
- Etapa do post de conquista entregue sem commit: migration `PostDeConquista` (coluna, índice único por conquista ativa, checks ampliados), `POST /v1/posts` com `conquistaId` e dois códigos novos (`conquista-removida`, `mais-de-um-premio`), leitura do post com prêmio do tipo conquista, `postId` em Troféus, purga reordenada com teste, novo post oferecendo a conquista obtida sem post; 6 testes de integração e Jest 420; suíte 1034.
- Decisão para aval: conquista removida com post segue a regra da medalha anulada (produto.md 4.8) por analogia: o post perde o vínculo e fica comum, o que era só a conquista é apagado, o já removido pela instituição fica. Aceita; registrar em 4.9 na etapa de docs.

---
Etapa do post de conquista aprovada, com a regra por analogia à medalha anulada aceita; registra em 4.9 na etapa de docs. O commit único com API, cliente e app está certo. A disputa de recurso com a pilha de pé fica anotada como ocorrência de ambiente; para a suíte local, pilha parada. Commita com a mensagem proposta, push, acompanha a CI e segue para a última etapa, docs e e2e; para para a minha revisão no fim dela, com o relatório de fechamento do passo e o que ficou para os passos seguintes.
