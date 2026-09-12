# Prompts

Um arquivo por rodada, nomeado `<persona>_<qualidade>_<tela-ou-feature>.md`
(ex.: `leigo_ruim_cadastro.md`, `engenheiro_bom_feed.md`). O mesmo arquivo é enviado,
sem alterações, para Claude Code e para Codex — é isso que torna a comparação entre
agentes válida.

- `leigo/` — prompts escritos a partir do perfil em `personas/leigo/`.
- `engenheiro/` — prompts escritos a partir do perfil em `personas/engenheiro/`.

Cada arquivo de prompt deve registrar, no topo, o ID da rodada — o mesmo ID usado em
`resultados/` e na planilha `avaliacoes/registro-avaliacoes.xlsx`.
