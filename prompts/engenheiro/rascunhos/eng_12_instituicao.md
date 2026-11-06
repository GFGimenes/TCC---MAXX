ID: eng_12_instituicao
Trilha: engenheiro
Tela: passo 12 do plano mestre (área web da instituição e seed completo)
Data: a preencher no envio
Origem: rascunho do Cowork (Anthropic) no molde dos passos 1 a 3, a partir do plano mestre do repo em 05/11/2026 (`main` em `5b7cb45`). Antes do envio, conferir contra o plano mestre atualizado, porque passos anteriores podem ter acrescentado itens a este. Ao enviar, mover para `prompts/engenheiro/eng_12_instituicao.md`, preencher a data e registrar o ambiente (`claude --version`, `/model`).

Notas de registro:
- Texto relembra o que fecha o passo pelo plano mestre, sem regra nova, mais a regra da CI verde por etapa fixada na `eng_03_auth-r13`.

---
Passo 12 do plano mestre: área web da instituição. Estamos na rodada/eng_12_instituicao, saída da main com os passos 1 a 11 mergeados. Antes de qualquer código, me traga o plano de etapas, com entrega e critério de aceite por etapa, como combinamos no CLAUDE.md. Vale tudo que está lá: decisão que não está nos docs não foi tomada, então pergunte antes de assumir. Uma regra que fixei no passo 3 e vale daqui em diante: cada etapa só é dada como pronta depois de a CI do push dela passar, e o resultado da CI entra no relatório da etapa. Lembro o que fecha o passo: fila de comprovações e fila de contestações com aprovar, reprovar, confirmar e revogar; conceder prêmio de participação já aprovado; publicar aviso de faculdade e de curso; anular medalha, corrigir e-mail de aluno e marcar ex-aluno; purgar dados de demonstração por lote, em uma transação, pelo procedimento registrado no passo 3; seed de demonstração completo com 150 alunos, 120 ativos distribuídos por semestres e 30 ex-alunos, quatro cursos, turmas, matérias, professores, posts com foto, prêmios distribuídos de modo que as quatro raridades apareçam, avisos, eventos passados e futuros, duas comprovações pendentes e uma contestação aberta. Eu reviso o plano e aí começamos a primeira etapa.
