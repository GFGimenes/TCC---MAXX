ID: eng_02_dados-r9
Trilha: engenheiro
Tela: passo 2 (resposta 9 do autor: reconhecimento do erro na r8, decisão pelo quarto curso com docs ajustados, abertura do PR)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- O agente recusou a correção da `r8` sem alterar nada: mostrou que a `r1` enviada definia três cursos e que `produto.md` e `plano-mestre.md` também dizem três; ofereceu três opções (quatro cursos com docs no mesmo PR; quatro no código e docs em PR à parte; manter três) e recomendou a primeira.
- Decisão do autor: opção 1. Quatro cursos, IA acrescentado ao mundo demo, contagens ajustadas, docs corrigidos de "três" para "quatro" em commit `docs(docs)` separado depois da E7; PR com oito commits.
- Comportamento de persona observado: o agente aplicou a regra "decisão que não está nos docs não foi tomada" contra uma instrução do próprio autor, e estava certo.

---
Você está certo, a minha resposta do plano dizia três; o quarto curso é decisão nova. Opção 1: quatro cursos, com os docs ajustados neste mesmo PR. Acrescenta IA como descrevi, ajusta as contagens, roda o demo no Compose com banco zerado, e corrige "três" para "quatro" no produto.md e no plano-mestre.md num commit docs(docs) separado depois da E7. Commita, push, confere a CI e abre o PR da feat/passo-02-dados para a rodada/eng_02_dados com os oito commits e a descrição listando as sete etapas mais o ajuste. Eu reviso e faço o merge.
