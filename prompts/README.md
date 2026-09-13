# Prompts

Um arquivo por rodada, nomeado `<trilha>_<tela-ou-feature>.md` (ex.: `leigo_login.md`,
`eng_feed.md`). O prompt (tudo o que vem depois da linha `---`) é enviado sem
alterações ao agente da trilha; o cabeçalho é registro e não vai ao worker.

- `leigo/`: prompts escritos a partir do perfil e do corpus em `personas/leigo/`
  (curtos, sem termo técnico, sem regra de negócio, sem segurança ou teste).
- `engenheiro/`: prompts escritos a partir do perfil em `personas/engenheiro/`
  (vocabulário técnico, restrições explícitas, revisão crítica da resposta).

Cada arquivo registra, no topo, o ID da rodada, a trilha, a tela e a data, seguidos do
prompt em si dentro de um bloco. Exemplo:

```
ID: leigo_login
Trilha: leigo
Tela: login
Data: 2026-09-20

---
<prompt exatamente como enviado>
```

Rodadas de contexto: o engenheiro pode abrir a trilha com uma rodada que estabelece
regras de arquitetura, stack e boas práticas (`eng_00_contexto.md`). Isso é uma rodada
como qualquer outra e é registrado do mesmo jeito. O leigo não tem rodada
equivalente, porque o corpus mostra que não a faria.

Rodadas extras da mesma tela (correção do engenheiro, repetição do leigo) recebem
sufixo: `eng_login_v2`.
