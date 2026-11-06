ID: eng_07_posts
Trilha: engenheiro
Tela: passo 7 do plano mestre (posts, upload e feed)
Data: a preencher no envio
Origem: rascunho do Cowork (Anthropic) no molde dos passos 1 a 3, a partir do plano mestre do repo em 05/11/2026 (`main` em `5b7cb45`). Antes do envio, conferir contra o plano mestre atualizado, porque passos anteriores podem ter acrescentado itens a este. Ao enviar, mover para `prompts/engenheiro/eng_07_posts.md`, preencher a data e registrar o ambiente (`claude --version`, `/model`).

Notas de registro:
- Texto relembra o que fecha o passo pelo plano mestre, sem regra nova, mais a regra da CI verde por etapa fixada na `eng_03_auth-r13`.

---
Passo 7 do plano mestre: posts, upload e feed. Estamos na rodada/eng_07_posts, saída da main com os passos 1 a 6 mergeados. Antes de qualquer código, me traga o plano de etapas, com entrega e critério de aceite por etapa, como combinamos no CLAUDE.md. Vale tudo que está lá: decisão que não está nos docs não foi tomada, então pergunte antes de assumir. Uma regra que fixei no passo 3 e vale daqui em diante: cada etapa só é dada como pronta depois de a CI do push dela passar, e o resultado da CI entra no relatório da etapa. Lembro o que fecha o passo: assinatura de upload com tipo e tamanho presos, duas derivadas geradas no cliente e limpeza de upload abandonado pela fila; post com ao menos um entre prêmio, foto e legenda, e um prêmio rende um post; feed por cursor com índice, intercalando seguidos e recomendação com semente de sessão; curtida, comentário e remoção de comentário por autor e por instituição; seguir e deixar de seguir; perfil com grade de três colunas, abas por ícone, pontos e prêmios; busca de alunos por nome de exibição e arroba com filtros de curso e semestre; editar perfil com foto, nome de exibição e prefixo do arroba; deep link /post/:id atrás do login; e o limite de taxa de upload, que ficou só declarado no passo 3, aplicado e testado aqui. Eu reviso o plano e aí começamos a primeira etapa.
