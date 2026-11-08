ID: eng_09_conquistas-r3
Trilha: engenheiro
Tela: passo 9 (resposta 3 do autor: revisão da etapa 2, reavaliação por fato no worker)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1 fechada em `52ad6c3`; CI verde só na segunda tentativa do job mobile (três timeouts de 5 s do Jest em arquivos não tocados, lentidão do runner; nova tentativa sem commit). Os 6 testes ignorados confirmados como `VerificacaoDoR2Tests`.
- Etapa 2 entregue sem commit: migration `Conquista` (três tabelas, índice parcial, check de notificação ampliado), trabalho `reavaliar-conquistas` com os três gatilhos na transação do fato, pontos e raridade contando conquista ativa, purga estendida com teste; 10 testes de integração (concorrência com três consumidores provada por teste reverso) e testes de domínio; suíte 995.
- Cinco decisões do agente para aval: (1) D2 virou trava consultiva por aluno (`pg_advisory_xact_lock`), índice como rede de segurança, porque violação de unicidade aborta a transação do trabalho; (2) notificação gravada pelo próprio handler; (3) os dois tipos de notificação já nesta migration; (4) regra `customizada` nunca disparada por fato, limite registrado; (5) estado intermediário até a etapa 5. Aceitas as cinco. O autor pede que os timeouts do runner entrem como risco no plano mestre se repetirem.

---
Etapa 2 aprovada, com as cinco decisões aceitas: a trava consultiva por aluno com o índice de rede de segurança (a prova reversa fecha o assunto), a notificação gravada pelo handler, os dois tipos já na migration, o limite da regra customizada registrado e o estado intermediário até a etapa 5. Os timeouts do runner no job mobile: se acontecerem de novo neste passo, registra como risco no plano mestre. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 3; para para a minha revisão no fim dela.
