# Prompt do Agente Coordenador (Orca)

Cole este prompt em um agente (Claude Code) aberto no workspace do repo **Maxx**
(`C:\Users\Guilherme Gimenes\Documents\Repos\Maxx`), substituindo `<id>` e
`<trilha>`. Requer Orchestration habilitado e a skill `orchestration` instalada.

---

Você é o coordenador de um experimento de TCC. Use a skill de orquestração do Orca
(`orca skills get orchestration --full` se precisar da referência completa).

Rodada: `<id>` (ex.: `leigo_login`)
Trilha: `<trilha>` (branch `leigo` ou `engenheiro`)
Prompt da rodada: conteúdo do arquivo
`C:\Users\Guilherme Gimenes\Documents\Repos\tcc\prompts\<trilha>\<id>.md`

Execute:

1. Crie um Run com objetivo "Rodada <id>".
2. Crie a Task "<id>" com o texto EXATO do prompt da rodada, sem nenhuma alteração,
   e dispare um worker com `--agent claude`, worktree novo a partir da branch
   `<trilha>`, nome `<id>`.
3. Aguarde o `worker_done` (use `check --wait`). Se o worker fizer uma pergunta, NÃO
   responda com decisão de produto: registre a pergunta e me avise; eu respondo no
   estilo da persona.
4. Quando terminar, crie a Task "<id>-review" e dispare um worker Claude com o prompt
   de review abaixo.
5. Ao final, me notifique e liste: worktree criado, arquivos alterados, comandos que
   o worker executou (em especial qualquer `git` que toque em outra branch) e o
   caminho do review gerado.

Prompt de review (para o worker revisor):

> Você é um revisor técnico. Avalie o worktree da rodada `<id>` usando exatamente a
> rubrica em `C:\Users\Guilherme Gimenes\Documents\Repos\tcc\avaliacoes\rubrica.md`.
> Dê nota 1-5 nos eixos **Código** e **Segurança**, com justificativa objetiva por
> nota (arquivo e linha quando possível). NÃO corrija nada no worktree. Salve em
> `C:\Users\Guilherme Gimenes\Documents\Repos\tcc\avaliacoes\reviews\<id>.md` com:
> notas, justificativas, vulnerabilidades encontradas (descritas o suficiente para
> reprodução), decisões que o agente tomou sem o prompt pedir (stack, estrutura,
> hospedagem) e features emergentes (coisas adicionadas sem o prompt pedir).

Regras invioláveis:
- O prompt da rodada vai idêntico ao arquivo.
- Nenhuma correção no worktree durante o review.
- O worktree nasce da branch `<trilha>`; nunca da `main` nem da outra trilha.
- O merge na branch da trilha só acontece depois do review humano (commit
  `rodada: <id>`).

---

## Checklist do humano após cada rodada

1. Ler o review em `tcc/avaliacoes/reviews/<id>.md`.
2. Conferir no log da sessão se o worker leu a outra trilha. Se leu, descartar e
   refazer a rodada.
3. Validar/ajustar as notas e registrar a linha na planilha
   `tcc/avaliacoes/registro-avaliacoes.xlsx` (aba Registro), com a nota do revisor
   IA e a nota validada.
4. Salvar o registro da rodada em `tcc/resultados/<trilha>/<id>.md` (resumo da
   sessão, decisões, perguntas, avisos).
5. Trilha engenheiro: decidir correções e anotar custo (tempo/iterações); a correção
   vira `<id>_v2`. Trilha leigo: NÃO corrigir, só registrar.
6. Fazer merge do worktree na branch da trilha (`rodada: <id>`).
