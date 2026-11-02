ID: eng_00_tecnica-r9
Trilha: engenheiro
Tela: abertura (resposta 9 do autor: revisão da E0.5, `CLAUDE.md`, e organização do git para o fechamento do passo 0)
Data: 2026-11-01
Origem: leitura do Cowork (Anthropic) do `CLAUDE.md` no repo; decisão do autor sobre autoria dos commits; redigida pelo Cowork, o autor revisou.

Notas de registro:
- O agente entregou o `CLAUDE.md` (157 linhas: mapa de leitura, protocolo de trabalho, definição de pronto, stack, mapa do repo, camadas, idioma, glossário com proibição de sinônimos, segurança inviolável, testes, git, interface, padrão de texto) e fixou três convenções próprias (identificadores sem acento, snake_case no Postgres, glossário com proibição explícita), aceitas.
- Decisão de persona do autor: sem rodapé `Co-Authored-By` nos commits da trilha do engenheiro ("aqui você é a ferramenta, não o autor"); o agente removeu a linha, escreveu uma proibição explícita no `CLAUDE.md` e reescreveu os cinco commits anteriores. Na trilha do leigo o rodapé fica como o agente fizer. Autoria declarada nos commits passa a ser item de comparação entre trilhas.
- Fechamento do passo 0: branch `docs/passo-00-fundacao` com os sete commits (E0.1 a E0.5), `rodada/eng_00` de volta ao commit do design (`9412465`), as duas publicadas na origin, PR #1 aberto (`docs/passo-00-fundacao` → `rodada/eng_00`, 17 arquivos, 2.531 linhas). O agente usou `git filter-branch` porque rebase interativo não roda no ambiente dele.

---
E0.5 aprovada. As três convenções aceitas: identificadores sem acento e sem cedilha, snake_case no Postgres mapeado do PascalCase do C#, e o glossário com a proibição explícita de Award, Prize, Badge, Reward e Trophy no código. Sobre o rodapé Co-Authored-By: remove a linha do CLAUDE.md e não use o rodapé nos commits deste repositório. Aqui você é a ferramenta, não o autor; os commits são meus, revisados por mim antes de existirem. Reescreve os commits desta rodada sem o rodapé (rebase interativo na branch, antes de dar push), e commita a E0.5.

Depois, antes do PR, organiza o git como vamos trabalhar daqui em diante: cria a branch docs/passo-00-fundacao a partir do estado atual (os commits do passo 0 vão nela), volta a rodada/eng_00 para o commit do design (9412465), dá push das duas para a origin (git push -u origin) e abre o PR da docs/passo-00-fundacao contra a rodada/eng_00, com a descrição listando as seis etapas. Eu reviso e faço o merge. A partir do passo 1, toda etapa nasce numa branch por tipo saída da rodada/eng_00, com commit e push a cada etapa e um PR por assunto.
