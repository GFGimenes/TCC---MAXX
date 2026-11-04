ID: eng_03_auth-r5
Trilha: engenheiro
Tela: passo 3 (resposta 5 do autor: revisão da E4, migration de usuário, sessão e recuperação de senha)
Data: 2026-11-03
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Primeira entrega da E4 veio sem os testes de integração rodados porque o Docker Desktop não estava de pé; o agente declarou e pediu o Docker. O autor subiu o Docker e mandou uma mensagem curta de retomada (não contada como prompt numerado: "Docker de pé. Roda os testes, aplica a migration no migrator e traz a E4 para revisão. A tabela prefixo_reservado no lugar de arroba está certa.").
- E4: `IdentidadeConfiguration` (usuario com índice único em cadastro_elegivel_id, checks de prefixo, papéis e EX, nome_de_exibicao varchar(60); prefixo_reservado com prefixo citext como chave primária; familia_sessao; refresh_token e recuperacao_senha com hash único e xmin como token de concorrência), migration `Identidade` aplicada pelo migrator; 92 testes de integração, 17 novos, provando concorrência (xmin), corrida do prefixo e unicidades.
- Desvio declarado e aceito: tabela `prefixo_reservado` em vez de `arroba`, porque a unicidade é do prefixo.

---
E4 aprovada. Commita com a mensagem proposta, push, e segue para a E5; para para a minha revisão no fim dela.
