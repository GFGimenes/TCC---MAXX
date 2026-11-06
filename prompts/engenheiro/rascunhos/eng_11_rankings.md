ID: eng_11_rankings
Trilha: engenheiro
Tela: passo 11 do plano mestre (rankings)
Data: a preencher no envio
Origem: rascunho do Cowork (Anthropic) no molde dos passos 1 a 3, a partir do plano mestre do repo em 05/11/2026 (`main` em `5b7cb45`). Antes do envio, conferir contra o plano mestre atualizado, porque passos anteriores podem ter acrescentado itens a este. Ao enviar, mover para `prompts/engenheiro/eng_11_rankings.md`, preencher a data e registrar o ambiente (`claude --version`, `/model`).

Notas de registro:
- Texto relembra o que fecha o passo pelo plano mestre, sem regra nova, mais a regra da CI verde por etapa fixada na `eng_03_auth-r13`.

---
Passo 11 do plano mestre: rankings. Estamos na rodada/eng_11_rankings, saída da main com os passos 1 a 10 mergeados. Antes de qualquer código, me traga o plano de etapas, com entrega e critério de aceite por etapa, como combinamos no CLAUDE.md. Vale tudo que está lá: decisão que não está nos docs não foi tomada, então pergunte antes de assumir. Uma regra que fixei no passo 3 e vale daqui em diante: cada etapa só é dada como pronta depois de a CI do push dela passar, e o resultado da CI entra no relatório da etapa. Lembro o que fecha o passo: tabela das quatro visões escrita pelo worker com coalescência, como no ADR 0005; desempate pelo instante da última concessão que compõe a pontuação atual; congelamento do ranking semestral trinta dias após o fim do semestre; entrada pelo toque na própria posição no perfil e pelos atalhos da Busca; filtro entre semestre atual e histórico, com topo e linha do próprio aluno em destaque; ex-aluno só no histórico. O fluxo 05 é a referência. Eu reviso o plano e aí começamos a primeira etapa.
