ID: eng_07_posts-r3
Trilha: engenheiro
Tela: passo 7 (resposta 3 do autor: revisão da etapa 2, pedido de upload, limite e limpeza)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1 fechada em `7c9f29f`, CI verde. O agente copiou o bloco de armazenamento para o `.env` local do autor e listou o que entrou.
- Etapa 2: `POST /v1/uploads` com duas URLs assinadas (15 min), regras no domínio `UploadPendente` (só JPEG, feed até 1 MiB, grade até 200 KiB, matriz de papéis por finalidade), ULID próprio, limite `UploadPorUsuario` aplicado (30 por hora contando recusas), trabalho `limpar-upload-abandonado` adiado 24 h na mesma transação, corrida com a confirmação pelo xmin, migration `UploadPendente`; 41 testes de domínio e 25 de integração novos (634 no total), com PUTs reais no VersityGW.
- O agente avisou que o SQL da purga ficaria quebrado para usuário de demonstração com upload até a etapa 11; o autor mandou corrigir já neste commit, com a tabela na purga e o teste criando um upload, e fixou a regra de cada tabela entrar na purga na etapa em que nascer.

---
Etapa 2 aprovada, com um ajuste neste commit: acrescenta upload_pendente ao SQL da purga no README de decisões agora, e o teste da purga passa a criar um upload para o usuário do lote, para o documento não ficar errado até a etapa 11; as outras tabelas do passo entram na purga nas etapas em que nascerem. A migration na minha base local entra no próximo compose up, sem problema. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 3; para para a minha revisão no fim dela.
