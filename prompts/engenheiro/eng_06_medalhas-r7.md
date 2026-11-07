ID: eng_06_medalhas-r7
Trilha: engenheiro
Tela: passo 6 (resposta 7 do autor: revisão da etapa 6, notificação e raridade no worker)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 5 fechada em `dab5094`, CI verde.
- Etapa 6: tabela `notificacao` com índice único por usuário, tipo e referência (handler idempotente; medalha anulada ou purgada não notifica; texto montado no cliente no passo 10); `Raridades.De` no domínio com faixas em inteiros e fronteiras estritas; tabela `raridade_do_item` (numerador: alunos distintos com medalha ativa, ex-alunos incluídos; divisor da decisão J; item restrito só com o curso atual); coalescência com linha travada em `recalculo`, pedidos pendentes apagados e janela de 10 s via `Enfileirar` com instante de disponibilidade; purga ganha `notificacao`; 550 testes (15 de domínio, 5 de integração novos), fronteiras em 3.200 alunos, rajada de 5 concessões virando um recálculo.
- Decisão nova do agente confirmada pelo autor: numerador limitado ao divisor nos itens restritos quando o aluno trocou de curso.

---
Etapa 6 aprovada. Confirmo o numerador limitado ao divisor nos itens restritos quando o aluno trocou de curso; registra isso nos docs no fechamento. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 7; para para a minha revisão no fim dela.
