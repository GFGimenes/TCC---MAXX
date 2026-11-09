ID: eng_09_conquistas-r7
Trilha: engenheiro
Tela: passo 9 (resposta 7 do autor: revisão da etapa 6, tela de Troféus)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor conferiu as quatro capturas (Troféus com conquista obtida e com progresso, claro e escuro); decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 5 em `a6e356f`, CI verde na primeira tentativa; o worker novo fechou os bimestres 1 a 3 e o semestre 2026/1 no compose local.
- Etapa 6 entregue sem commit: linha "Regra automática · critério" e linha de progresso por período ("2 de 3 neste bimestre", "no curso"), rótulo da instância na obtida com " · n vezes"; 5 testes (419 Jest); capturas com roteiro temporário apagado.
- Três pontos: (1) "3 de 4 matérias" não entrou porque a API não diz a unidade do alvo; autor pede o campo opcional `unidade` no progresso nesta etapa, acréscimo aditivo, como no passo 8; (2) critério na frase inteira do catálogo, aceito (encurtar exigiria campo novo no catálogo); (3) "0% dos alunos" na captura é a coalescência de 10 s da raridade, aceito.
- Capturas conferidas pelo autor: identidade mantida.

---
Etapa 6 aprovada, capturas conferidas. Sobre os três pontos: faz o "matérias" nesta etapa, com o campo opcional unidade no progresso da API e o texto "3 de 4 matérias" no app, acréscimo aditivo como fizemos no passo 8; o critério fica na frase inteira do catálogo, sem campo novo; o 0% da raridade na captura está explicado. Com o cliente e a API verdes, commita com a mensagem proposta, push, acompanha a CI e segue para a etapa do post de conquista; para para a minha revisão no fim dela.
