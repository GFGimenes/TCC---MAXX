ID: eng_07_posts-r2
Trilha: engenheiro
Tela: passo 7 (resposta 2 do autor: revisão da etapa 1, bucket de fotos compatível com S3 e emulador local)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1: `IArmazenamentoDeFotos` (assinar PUT, HEAD, remover em lote, URL de leitura) e `ArmazenamentoS3` com AWSSDK.S3, content-type e content-length nos cabeçalhos assinados; dois endereços (interno e público); API e worker não sobem fora de desenvolvimento sem o bucket; VersityGW v1.10.0 e `armazenamento-init` (AWS CLI 2.38.0) num perfil do compose ligado só pelo `.env.example`; 11 testes de integração contra o emulador real via Testcontainers (568 no total); pilha completa testada em projeto isolado.
- O agente não alterou o `.env` local do autor e avisou que o próximo `docker compose up` recusaria sem as variáveis novas; o autor mandou ele mesmo copiar o bloco do `.env.example`.

---
Etapa 1 aprovada. Copia você mesmo o bloco novo do .env.example para o meu .env local (MAXX_ARMAZENAMENTO_* e COMPOSE_PROFILES), com os valores do emulador, e me diz o que entrou. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 2; para para a minha revisão no fim dela.
