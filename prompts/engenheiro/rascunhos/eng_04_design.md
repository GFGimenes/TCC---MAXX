ID: eng_04_design
Trilha: engenheiro
Tela: passo 4 do plano mestre (design system; primeira rodada com peso visual)
Data: a preencher no envio
Origem: rascunho do Cowork (Anthropic) no molde dos passos 1 a 3, a partir do plano mestre do repo em 05/11/2026 (`main` em `5b7cb45`). Antes do envio, conferir contra o plano mestre atualizado, porque passos anteriores podem ter acrescentado itens a este. Ao enviar, mover para `prompts/engenheiro/eng_04_design.md`, preencher a data e registrar o ambiente (`claude --version`, `/model`).

Notas de registro:
- Texto relembra o que fecha o passo pelo plano mestre, sem regra nova, mais a regra da CI verde por etapa fixada na `eng_03_auth-r13`.

---
Passo 4 do plano mestre: design system. Estamos na rodada/eng_04_design, saída da main com os passos 1 a 3 mergeados. Antes de qualquer código, me traga o plano de etapas, com entrega e critério de aceite por etapa, como combinamos no CLAUDE.md. Vale tudo que está lá: decisão que não está nos docs não foi tomada, então pergunte antes de assumir. Uma regra que fixei no passo 3 e vale daqui em diante: cada etapa só é dada como pronta depois de a CI do push dela passar, e o resultado da CI entra no relatório da etapa. Lembro o que fecha o passo: tokens.json tipado com tema claro e escuro e troca de tema; Archivo instanciada em largura óptica 112% e embarcada, mais Instrument Sans; os componentes listados no plano mestre (botão discreto e grande, campo com mostrar senha, controle segmentado, chip de filtro, navegação de cinco abas com realce e bolinha de novidade, medalhão com tier e raridade, selo de pílula do post, faixa de prêmio, trilha com cadeado, avatar de iniciais, estado vazio, estado de erro amigável); grade de 4 px, margem lateral de 16 e respiro de 24 antes da navegação; ícones e splash reais do app no lugar dos PNGs do template, como ficou anotado no passo 1. A referência visual é a pasta design/, com as pranchetas e o README. Eu reviso o plano e aí começamos a primeira etapa.
