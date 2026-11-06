ID: eng_06_medalhas
Trilha: engenheiro
Tela: passo 6 do plano mestre (medalhas, fila e worker)
Data: a preencher no envio
Origem: rascunho do Cowork (Anthropic) no molde dos passos 1 a 3, a partir do plano mestre do repo em 05/11/2026 (`main` em `5b7cb45`). Antes do envio, conferir contra o plano mestre atualizado, porque passos anteriores podem ter acrescentado itens a este. Ao enviar, mover para `prompts/engenheiro/eng_06_medalhas.md`, preencher a data e registrar o ambiente (`claude --version`, `/model`).

Notas de registro:
- Texto relembra o que fecha o passo pelo plano mestre, sem regra nova, mais a regra da CI verde por etapa fixada na `eng_03_auth-r13`.

---
Passo 6 do plano mestre: medalhas, fila e worker. Estamos na rodada/eng_06_medalhas, saída da main com os passos 1 a 5 mergeados. Antes de qualquer código, me traga o plano de etapas, com entrega e critério de aceite por etapa, como combinamos no CLAUDE.md. Vale tudo que está lá: decisão que não está nos docs não foi tomada, então pergunte antes de assumir. Uma regra que fixei no passo 3 e vale daqui em diante: cada etapa só é dada como pronta depois de a CI do push dela passar, e o resultado da CI entra no relatório da etapa. Lembro o que fecha o passo: lista de turmas e alunos do professor e modal de concessão a partir do catálogo; concessão gravando matéria, bimestre, tier e pontos do momento, respeitando limite por período e chave de deduplicação; auditoria de concessão e de anulação; fila na tabela do Postgres com worker consumindo por SKIP LOCKED, como no ADR 0008, e o envio de e-mail migrando da fila em memória para ela; notificação de medalha recebida gravada no banco; tela de Troféus com o catálogo, o que falta, o critério e a raridade por escassez recalculada no worker; anulação de medalha pela instituição por comando administrativo. A posição no ranking fica para o passo 11. Eu reviso o plano e aí começamos a primeira etapa.
