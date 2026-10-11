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

Rodadas de abertura: cada trilha começa com uma rodada que entrega a ideia ao agente,
registrada como qualquer outra (`Tela: abertura`). A do engenheiro são dois prompts
enviados em sequência na mesma sessão (`eng_00_produto.md`, definição de produto, e
`eng_00_tecnica.md`, definição técnica), depois do pacote de design já commitado no
repo da trilha. A do leigo é uma mensagem só (`leigo_00_abertura.md`), no estilo do
corpus; ela e os seis prompts de tela são escritos antes do piloto e não mudam depois
(política de reação em `personas/leigo/perfil.md`).

Rodadas extras da mesma tela (correção do engenheiro, repetição do leigo) recebem
sufixo: `eng_login_v2`.
