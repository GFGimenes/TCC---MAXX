ID: eng_02_dados
Trilha: engenheiro
Tela: passo 2 do plano mestre (modelo acadêmico, catálogo e seeder; sem tela)
Data: 2026-11-02
Origem: texto do Cowork (Anthropic) no molde do `eng_01_fundacao`, aprovado pelo autor. Sessão nova na `rodada/eng_02_dados` (saída da `main` em `3d1e91f`). Ambiente conferido com `/model` antes do primeiro prompt: Claude Code 2.1.308, "Opus 5.5 (1M context)", esforço medium, auto mode; a lista do `/model` agora nomeia a opção como "Opus 5.5" (em 11/10 era "Opus (1M context)").

Notas de registro:
- O prompt relembra o que fecha o passo pelo plano mestre, incluindo os dois itens que o agente deixou anotados no fim do passo 1 (primeiros testes de domínio e remoção do `--ignore-exit-code 8`).

---
Passo 2 do plano mestre: modelo acadêmico, catálogo e seeder. Estamos na rodada/eng_02_dados, saída da main com o passo 1 mergeado. Antes de qualquer código, me traga o plano de etapas, com entrega e critério de aceite por etapa, como combinamos no CLAUDE.md. Vale tudo que está lá: decisão que não está nos docs não foi tomada, então pergunte antes de assumir. Lembro o que fecha o passo: migrations de curso, ano letivo, semestre, bimestre, matéria, turma, vínculo de professor, matrícula, cadastro elegível e catálogo; seeder idempotente por comando, com perfis base e demo, carregando os 46 itens de data/catalogo/ pelo código; calendário de 2026 com datas reais; validação do catálogo na CI; testes de integração com Postgres real; e os primeiros testes de domínio em Maxx.Domain.Tests, com a remoção do --ignore-exit-code 8 que ficou anotada no passo 1. Eu reviso o plano e aí começamos a primeira etapa.
