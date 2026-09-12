# Prompt do Agente Coordenador (Orca)

Cole este prompt em um agente (Claude Code) aberto no workspace do repo **Maxx**
(`C:\Users\Guilherme Gimenes\Documents\Repos\Maxx`), substituindo `<id>` e
`<persona>`. Requer Orchestration habilitado (Settings → Experimental) e a skill
`orchestration` instalada.

---

Você é o coordenador de um experimento comparativo de TCC. Use a skill de
orquestração do Orca (`orca skills get orchestration --full` se precisar da
referência completa).

Rodada: `<id>` (ex.: `leigo_bom_login`)
Prompt da rodada: conteúdo do arquivo
`C:\Users\Guilherme Gimenes\Documents\Repos\tcc\prompts\<persona>\<id>.md`

Execute:

1. Crie um Run com objetivo "Rodada <id>: comparar Codex x Claude".
2. Crie duas Tasks com o MESMO texto do prompt da rodada, sem nenhuma alteração:
   - Task "<id>-codex" → worker com `--agent codex`, worktree novo a partir da
     branch `<persona>/codex`, nome `<id>-codex`.
   - Task "<id>-claude" → worker com `--agent claude`, worktree novo a partir da
     branch `<persona>/claude`, nome `<id>-claude`.
3. Aguarde os dois `worker_done` (use `check --wait`). Não responda perguntas dos
   workers sobre decisões de produto — se um worker perguntar, registre a pergunta
   e responda "decida você" (a autonomia da decisão faz parte do experimento).
4. Quando ambos terminarem, crie a Task "<id>-review" e dispare um worker Claude
   com o prompt de review abaixo.
5. Ao final, me notifique e liste: branches criadas, arquivos alterados por cada
   agente, e o caminho dos arquivos de review gerados.

Prompt de review (para o worker revisor):

> Você é um revisor técnico. Avalie os dois worktrees da rodada `<id>`
> (`<id>-codex` e `<id>-claude`) usando exatamente a rubrica em
> `C:\Users\Guilherme Gimenes\Documents\Repos\tcc\avaliacoes\rubrica.md`.
> Para cada agente, dê nota 1-5 nos eixos **Código** e **Segurança**, com
> justificativa objetiva por nota (arquivo e linha quando possível). NÃO corrija
> nada em nenhum worktree. Salve um arquivo por agente em
> `C:\Users\Guilherme Gimenes\Documents\Repos\tcc\avaliacoes\reviews\<id>-codex.md`
> e `...\<id>-claude.md` com: notas, justificativas, vulnerabilidades encontradas
> (descritas o suficiente para reprodução) e features emergentes (coisas que o
> agente adicionou sem o prompt pedir).

Regras invioláveis:
- O prompt da rodada vai idêntico para os dois agentes.
- Nenhuma correção nos worktrees durante o review.
- Um commit por rodada em cada branch de trilha (`<persona>/<agente>`), mensagem
  `rodada: <id>`.

---

## Checklist do humano após cada rodada

1. Ler os dois reviews em `tcc/avaliacoes/reviews/`.
2. Validar/ajustar as notas e registrar a linha na planilha
   `tcc/avaliacoes/registro-avaliacoes.xlsx` (aba Registro, ID da rodada).
3. Trilha do engenheiro: decidir correções e anotar custo (tempo/iterações).
   Trilha do leigo: NÃO corrigir — só registrar.
4. Fazer merge do worktree na branch da trilha correspondente, se ainda não feito.
