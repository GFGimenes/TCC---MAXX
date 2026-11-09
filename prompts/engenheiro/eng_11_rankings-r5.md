ID: eng_11_rankings-r5
Trilha: engenheiro
Tela: passo 11 (resposta 5 do autor: revisão da etapa 5, cliente, e decisão sobre o "#29" no feed e em Troféus)
Data: 2026-11-09
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor conferiu as 14 capturas (rankings geral, histórico, histórico com "Quem eu sigo", curso com "Quem eu sigo", sem posição, perfil, busca; claro e escuro) contra as pranchetas de rankings e perfil; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapas 2, 3 e 4 em `8851bd8`, `a53b88d`, `1681071`, CI verde nos seis jobs cada.
- Etapa 5 entregue sem commit: tela de Rankings (`/rankings?visao=`) com chips por quem vê, card "Sua posição" (e "Sem posição ainda", "Ex-aluno aparece só no histórico"), segmentado "Todos / Quem eu sigo", lista de 20 em 20 com a linha própria destacada e marca de ex-aluno, estados; perfil com "pts · #N ›" (histórico geral) e toque abrindo o ranking; Busca com os dois atalhos; Jest 488 (16 novos). Capturas da pilha local reconstruída, com nomes de contas do e2e no topo do "Todos" (por isso as telas da turma usam "Quem eu sigo"); roteiro temporário apagado.
- Diferenças declaradas contra a prancheta: sem navegação inferior (tela na pilha, decisão do passo 7); rótulo acima do segmentado por corte a 390 px; curso pela sigla como no feed. Capturas conferidas pelo autor: fiéis, só essas três.
- Pergunta: o "#29" na linha do autor no feed (acréscimo na API) e no cabeçalho de Troféus (só cliente), que os comentários do código desde os passos 6 e 7 davam para o passo 11. Autor decidiu incluir os dois nesta etapa, com API e cliente no mesmo commit como nos passos anteriores, e capturas de feed e Troféus.

---
Etapa 5 aprovada nas capturas, só as três diferenças que você declarou. Sobre o "#29": inclui os dois nesta etapa, a posicao no autor do post como acréscimo nulável na API e o cabeçalho de Troféus lendo do próprio perfil, com o toque abrindo o ranking no Histórico, com a API e o cliente no mesmo commit como nos passos anteriores. Me traz capturas do feed e de Troféus em claro e escuro, e aí commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 6; no fim dela, para para a minha revisão com o relatório de fechamento do passo.
