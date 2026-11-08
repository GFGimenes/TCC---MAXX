ID: eng_07_posts-r10
Trilha: engenheiro
Tela: passo 7 (resposta 10 do autor: revisão da etapa 9, perfil, seguir e menu no cliente)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor conferiu as capturas do perfil ao lado da prancheta; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 8 fechada em `ed78c95`, CI verde.
- Etapa 9: perfil próprio (anel dourado, pontos, contadores, RA só no próprio, abas por ícone, grade de três colunas com medalhão no canto ou sobre o metal do tier, "Editar perfil" provisório) e de outro (`/usuarios/:id` fora das abas, Seguir e Seguindo pelas regras do banco); professor concede pelo perfil do aluno com escolha de turma; perfil do professor com turmas e medalhas concedidas; menu com tema (pendência do passo 4 fechada), Minhas turmas e Sair; falha de contrato da etapa 6 corrigida (`Produces<PerfilResponse>()`); três defeitos achados por teste e captura corrigidos (menu antes de carregar, grade vazia sem onLayout, lista do teste de gradiente); 370 Jest (11 novos), 61 mais 4 e2e; `test.slow()` no caso de medalha como paliativo declarado.
- Capturas conferidas pelo autor e pelo Cowork contra a prancheta do perfil (próprio, claro e escuro, e perfil de outro): estrutura, anel, caixa de pontos, abas e grade fiéis; nada a corrigir.
- Diferenças de propósito: sem bio, "Seguida por", Compartilhar, posição, sininho e "Último troféu"; arroba sob o nome incluído sem prancheta. Autor aceitou todas.

---
Etapa 9 aprovada. O arroba sob o nome fica; o perfil de outro fora das abas, com voltar, fica. O ajuste de contrato da etapa 6 no mesmo commit está certo. O test.slow() no caso de medalha é paliativo aceito, com a causa investigada na etapa 11. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 10; para para a minha revisão no fim dela, com capturas da busca e do editar perfil.
