ID: eng_04_design
Trilha: engenheiro
Tela: passo 4 do plano mestre (design system; primeira rodada com peso visual)
Data: 2026-11-05
Origem: texto do Cowork (Anthropic) no molde dos passos 1 a 3, conferido contra o plano mestre em `5b7cb45`, aprovado pelo autor. Sessão nova na `rodada/eng_04_design` (saída da `main` em `5b7cb45`). Ambiente conferido antes do primeiro prompt: Claude Code 2.1.316 (`claude --version`), `/model` com Opus 5.5 e esforço medium, auto mode, `DISABLE_AUTOUPDATER=1` e `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` na janela.

Notas de registro:
- Texto relembra o que fecha o passo pelo plano mestre, sem regra nova, mais a regra da CI verde por etapa fixada na `eng_03_auth-r13`.

---
Passo 4 do plano mestre: design system. Estamos na rodada/eng_04_design, saída da main com os passos 1 a 3 mergeados. Antes de qualquer código, me traga o plano de etapas, com entrega e critério de aceite por etapa, como combinamos no CLAUDE.md. Vale tudo que está lá: decisão que não está nos docs não foi tomada, então pergunte antes de assumir. Uma regra que fixei no passo 3 e vale daqui em diante: cada etapa só é dada como pronta depois de a CI do push dela passar, e o resultado da CI entra no relatório da etapa. Lembro o que fecha o passo: tokens.json tipado com tema claro e escuro e troca de tema; Archivo instanciada em largura óptica 112% e embarcada, mais Instrument Sans; os componentes listados no plano mestre (botão discreto e grande, campo com mostrar senha, controle segmentado, chip de filtro, navegação de cinco abas com realce e bolinha de novidade, medalhão com tier e raridade, selo de pílula do post, faixa de prêmio, trilha com cadeado, avatar de iniciais, estado vazio, estado de erro amigável); grade de 4 px, margem lateral de 16 e respiro de 24 antes da navegação; ícones e splash reais do app no lugar dos PNGs do template, como ficou anotado no passo 1. A referência visual é a pasta design/, com as pranchetas e o README. Eu reviso o plano e aí começamos a primeira etapa.
