# Orquestração (Orca)

Como disparar 1 prompt para os dois agentes (Claude Code e Codex), cada um em seu
worktree/branch, com review pontuado automático ao final — o fluxo do diagrama:

```
Prompt ──▶ Codex  (worktree/branch próprio) ──┐
      └──▶ Claude (worktree/branch próprio) ──┴─▶ Agente Revisor (rubrica) ──▶ avaliacoes/
```

## Pré-requisitos — ✅ CONFIGURADO em 15/08/2026

1. ✅ Orchestration ativo (nesta versão do Orca já vem integrado — Settings →
   Orchestration mostra a skill "Up to date"; não há mais toggle Experimental).
2. ✅ CLI ok: `orca status --json` responde com runtime ready.
3. ✅ Skill de orquestração instalada **globalmente** (`~\.agents\skills\orchestration`,
   symlink para Claude Code), via `npx skills add https://github.com/stablyai/orca
   --skill orchestration`. Escopo global = repo Maxx fica limpo.
4. ✅ Projeto **Maxx** (`C:\Users\Guilherme Gimenes\Documents\Repos\Maxx`) adicionado ao
   Orca, com as branches `main` + 4 trilhas (`leigo/claude`, `leigo/codex`,
   `eng/claude`, `eng/codex`), todas no Initial commit.
5. ✅ Workspace **coordenador** criado no projeto Maxx (branch
   `GFGimenes/coordenador`) com Claude Code rodando — é nele que você cola o prompt
   de `coordenador.md` a cada rodada.

## Estrutura de trilhas (branches)

4 trilhas independentes, uma por combinação persona × agente. Cada rodada vira um
commit (ou branch filha) dentro da trilha:

```
leigo/claude      leigo/codex      eng/claude      eng/codex
```

Assim o diff acumulado de cada trilha fica auditável nos milestones.

## Fluxo por rodada (supervisionado)

O jeito mais prático: abrir um agente **coordenador** no Orca (qualquer agente com a
skill de orquestração) e instruí-lo. Por baixo, ele executa algo como:

```
orca orchestration run-create --objective "Rodada <id>: comparar Codex x Claude" --json
orca orchestration task-create --spec "<conteúdo de prompts/<persona>/<id>.md>" --task-title "<id>-codex" --json
orca orchestration task-create --spec "<mesmo conteúdo>" --task-title "<id>-claude" --json
orca orchestration worker-start --task <taskCodex>  --worktree new-child --name <id>-codex  --agent codex  --json
orca orchestration worker-start --task <taskClaude> --worktree new-child --name <id>-claude --agent claude --json
orca orchestration check --wait --types worker_done,escalation,question --timeout-ms 900000 --json
# quando os dois worker_done chegarem:
orca orchestration task-create --spec "<prompt de review>" --task-title "<id>-review" --json
orca orchestration worker-start --task <taskReview> --worktree current --agent claude --json
```

### Prompt do agente revisor (modelo)

> Você é um revisor técnico. Avalie os dois diffs da rodada `<id>` (worktrees
> `<id>-codex` e `<id>-claude`) usando exatamente a rubrica em
> `tcc/avaliacoes/rubrica.md`. Para cada agente, dê nota 1-5 nos eixos Código e
> Segurança, com justificativa objetiva por nota (arquivo e linha quando possível).
> Não corrija nada. Salve o resultado em
> `tcc/avaliacoes/reviews/<id>-<agente>.md`.

## Regras do experimento

1. **O mesmo prompt, sem alterações, para os dois agentes.** Qualquer ajuste gera uma
   nova rodada (novo ID).
2. **Revisor automático = rascunho, não nota final.** A pontuação que vale na planilha
   (`avaliacoes/registro-avaliacoes.xlsx`) é a validada por humano. IA avaliando IA sem
   validação humana é exatamente o risco que o TCC aponta.
3. **Trilhas do leigo: revisão observacional.** Falhas encontradas são registradas mas
   NÃO corrigidas — o leigo real não as teria percebido. Deixe o efeito se compor entre
   rodadas e documente a degradação.
4. **Trilhas do engenheiro: revisão corretiva.** Corrigir e refinar o prompt seguinte
   faz parte da persona. Registre o custo (tempo/iterações) da correção.
5. **Por rodada** avaliam-se Código e Segurança. **Arquitetura e Mantenabilidade** são
   avaliadas nos milestones (ver linha do tempo); **UX** ao final de cada feature
   navegável.

## Automations (aba da sidebar) — quando usar

Automations são execuções agendadas/recorrentes (headless), não o pipeline acima. Útil
apenas se você quiser reexecutar a bateria completa de prompts periodicamente (ex.:
quando sair uma nova versão dos modelos) e comparar com os resultados anteriores.

## Referências

- Orchestration: https://www.onorca.dev/docs/cli/orchestration
- Scheduled automations: https://www.onorca.dev/docs/cli/automations
- Recipe "Race three agents on the same task": https://www.onorca.dev/docs/recipes/parallel-agents
