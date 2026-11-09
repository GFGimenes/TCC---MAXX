ID: eng_10_mural-r2
Trilha: engenheiro
Tela: passo 10 (resposta 2 do autor: revisão da etapa 1, publicar aviso)
Data: 2026-11-09
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1 entregue sem commit: domínio `Aviso` (título 3 a 120, texto 1 a 2.000, foto opcional, alvos em `AvisoTurma` e `AvisoCurso`), `POST /v1/avisos` com escopo conferido no banco, finalidade de upload `aviso`, trabalho `notificar-aviso-novo` com `INSERT ... SELECT ... ON CONFLICT DO NOTHING` e destinatários fixados na publicação, migration `Mural`, cliente regenerado, cinco mensagens novas no app; 540 testes de domínio, 12 de integração com prova reversa (condição "conta criada até a publicação" removida faz o teste falhar), suíte 1086.
- Dois pontos para conferir: (1) professor é notificado no aviso de faculdade porque quem vê recebe, instituição e autor nunca: aceito; (2) destinatários do aviso de curso lidos pelo curso atual, janela de segundos entre publicação e worker, limite conhecido: aceito.

---
Etapa 1 aprovada, com os dois pontos aceitos: quem vê recebe, sem notificar a instituição nem o autor; e o curso atual como fonte dos destinatários, com a janela de segundos registrada como limite conhecido. A prova reversa na condição da conta criada foi bem feita. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 2; para para a minha revisão no fim dela.
