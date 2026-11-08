ID: eng_07_posts-r9
Trilha: engenheiro
Tela: passo 7 (resposta 9 do autor: revisão da etapa 8, feed, post, comentários e deep link no cliente)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor conferiu as capturas do feed ao lado da prancheta; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 7 fechada em `35d1a2a`, CI verde.
- Etapa 8: feed na Home com cabeçalho e "+" só para aluno, cartão pela prancheta (avatar, curso e semestre, selo, foto, ações, faixa, curtidas, legenda, comentários, tempo), rolagem infinita e puxar para atualizar; curtida otimista com reversão; menu "..." para autor e instituição com confirmação; enviar com folha de compartilhamento ou cópia do link; comentários do mais antigo ao mais novo com apagar e remover; deep link `/post/:id` com retorno após login restrito a `/post/:id` e seus comentários (o agente restringiu por segurança depois de aceitar qualquer caminho); aba Perfil provisória até a etapa 9; 358 Jest (24 novos), 60 mais 4 e2e na pilha isolada; lint barrou setState em useEffect, trocado por estado derivado; faixa do prêmio corrigida pela comparação com a prancheta.
- Diferenças de propósito: sem sininho (passo 10), sem posição (passo 11), sem salvar, nome de usuário sem arroba e sem sufixo, medalha no lugar do troféu da prancheta. Caso de medalha no e2e estourou 30 s uma vez em paralelo, anotado para a etapa 11.

---
Etapa 8 aprovada. O retorno do login restrito a /post/:id fica, boa decisão. O nome de usuário no cartão sem arroba e sem sufixo fica como está, registra. A aba Perfil provisória até a etapa 9 está certa. O caso de medalha que estourou 30 s em paralelo fica anotado para a etapa 11 olhar o tempo. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 9; para para a minha revisão no fim dela, com capturas do perfil próprio e do perfil de outro aluno ao lado da prancheta.
