ID: eng_07_posts-r6
Trilha: engenheiro
Tela: passo 7 (resposta 6 do autor: revisão da etapa 5, feed por cursor)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 4 fechada em `686847a`, CI verde.
- Etapa 5: `GET /v1/feed` com páginas de 12 no ritmo 3 para 1 (`Feed.Intercalar` no domínio), trecho que acaba cede a vez; seguidos por cursor no índice; recomendações por `md5(semente || id)` (D8, opção A, sem índice na ordenação, aval do autor); semente sorteada na primeira página e levada no cursor opaco; `COLLATE "C"`; leitura em lote; post removido fora; visão por papel; 6 de domínio e 11 de integração novos (715 na API).
- Três ressalvas declaradas e aceitas: teste do índice com `enable_seqscan = off` (escolha do planejador com volume fica para o k6); seguir ou deixar de seguir no meio da sessão pode repetir ou sumir post, sem estado no servidor; constantes do `MundoSocial` renomeadas e relógio de teste avançando 100 ms por causa da tolerância do JWT.

---
Etapa 5 aprovada. As três ressalvas ficam registradas: o teste do índice com seqscan desligado e a pergunta para o k6 do passo 13; a repetição possível ao seguir no meio da sessão, sem estado no servidor, resolvida ao atualizar; os ajustes do MundoSocial. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 6; para para a minha revisão no fim dela.
