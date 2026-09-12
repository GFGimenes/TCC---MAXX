# Orquestração (Orca)

Como disparar uma rodada em uma trilha: um worker Claude Code no worktree da trilha
executa o prompt; ao terminar, um worker revisor pontua com a rubrica.

```
prompts/<trilha>/<id>.md ──▶ worker Claude (worktree da branch da trilha)
                                    └──▶ worker revisor (rubrica) ──▶ avaliacoes/reviews/<id>.md
                                    └──▶ review humano ──▶ merge na branch da trilha
```

## Pré-requisitos (configurado em 15/08/2026, reorganizado em 12/09/2026)

1. Orchestration ativo no Orca (`orca status --json` responde com runtime ready).
2. Skill de orquestração instalada globalmente (`~\.agents\skills\orchestration`).
3. Projeto **Maxx** (`C:\Users\Guilherme Gimenes\Documents\Repos\tcc\Maxx`) no Orca, com as
   branches `main`, `leigo` e `engenheiro`, as três no commit do contexto comum.
4. Workspace **coordenador** (branch `GFGimenes/coordenador`) com Claude Code rodando;
   é nele que se cola o prompt de `coordenador.md` a cada rodada.

## Trilhas (branches)

```
leigo         engenheiro
```

Cada rodada vira um commit na branch da trilha (`rodada: <id>`), depois do review
humano. O diff acumulado de cada branch é o que as auditorias de milestone avaliam.

## Fluxo por rodada (supervisionado)

Por baixo, o coordenador executa algo como:

```
orca orchestration run-create --objective "Rodada <id>" --json
orca orchestration task-create --spec "<conteúdo de prompts/<trilha>/<id>.md>" --task-title "<id>" --json
orca orchestration worker-start --task <task> --worktree new-child --name <id> --agent claude --json
orca orchestration check --wait --types worker_done,escalation,question --timeout-ms 900000 --json
# quando o worker_done chegar:
orca orchestration task-create --spec "<prompt de review>" --task-title "<id>-review" --json
orca orchestration worker-start --task <taskReview> --worktree current --agent claude --json
```

O worktree `new-child` deve nascer da branch da trilha (`leigo` ou `engenheiro`), nunca
da `main` nem da outra trilha.

## Regras do experimento

1. **O prompt vai como está no arquivo.** Qualquer ajuste gera uma nova rodada (novo
   ID com sufixo `_v2`, `_v3`).
2. **Perguntas do worker não são respondidas com decisão de produto.** Se o agente
   perguntar, registrar a pergunta em `resultados/<trilha>/<id>.md` e responder no
   estilo da persona: o leigo responde vago ("faz do jeito que ficar melhor"); o
   engenheiro responde com a restrição técnica que ele daria.
3. **Revisor automático = rascunho, não nota final.** A pontuação que vale na planilha
   é a validada por humano. IA avaliando IA sem validação humana é exatamente o risco
   que o TCC aponta.
4. **Mesmo revisor para as duas trilhas.** Mesmo modelo, mesmo prompt, mesma rubrica.
5. **Trilha leigo: review observacional.** Falhas registradas, não corrigidas.
   **Trilha engenheiro: review corretivo.** Corrigir e refinar o prompt seguinte faz
   parte da persona; registrar o custo.
6. **Contexto por trilha.** O worker só enxerga o `CLAUDE.md` da própria branch. Se o
   log da sessão mostrar que o agente leu a outra branch (`git log`, `git show`,
   `checkout` de outra trilha), a rodada é descartada e refeita.
7. **Por rodada** avaliam-se Código e Segurança. **Arquitetura e Mantenabilidade** nos
   milestones; **UX** ao final de cada feature navegável.

## Referências

- Orchestration: https://www.onorca.dev/docs/cli/orchestration
- Scheduled automations: https://www.onorca.dev/docs/cli/automations
