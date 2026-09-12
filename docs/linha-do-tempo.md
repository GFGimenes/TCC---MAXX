# Linha do Tempo do Experimento

Fases do experimento descrito nas seções 3.1 a 3.3 do TCC, organizadas para execução.
Cada fase lista entregável, pastas envolvidas e critério de "pronto". Datas ficam em
aberto; a ordem e as dependências entre fases é o que importa manter.

| # | Fase | O que é feito | Pastas envolvidas | Entregável / critério de pronto | Status |
|---|------|----------------|--------------------|----------------------------------|--------|
| 0 | Fundamentação já escrita | Contextualização, objetivos, teoria (vibe coding, LLMs, gamificação) | (já no PDF do TCC) | Seções 1 e 2 do TCC | Feito |
| 1 | Contexto comum (semente das trilhas) | Escrever a ideia central do Maxx e as regras de prêmios/pontos, sem stack, dados, segurança ou testes; colocar como `CLAUDE.md` e `AGENTS.md` na `main` do repo Maxx e criar as branches `leigo` e `engenheiro` a partir dela | `docs/contexto-comum.md`, repo Maxx | Branches `leigo` e `engenheiro` no mesmo commit, com o contexto | Feito (12/09/2026) |
| 2 | Pesquisa das personas de usuário | Perfil de como cada persona formula prompts para as mesmas telas | `personas/leigo/`, `personas/engenheiro/` | Perfil de cada persona com vocabulário, nível de detalhe e lacunas típicas | Leigo feito (N=28); engenheiro feito em 12/09/2026 (stack a confirmar) |
| 3 | Especificação funcional por tela | Consolidar as telas (login, feed, perfil, mural, troféus, rankings) como escopo de referência | `docs/especificacao-telas.md` | Lista de telas/features com regras de negócio | Em consolidação |
| 4 | Escrita dos prompts | Um prompt por rodada e por trilha, escrito a partir do perfil da persona | `prompts/leigo/`, `prompts/engenheiro/` | 1 arquivo por rodada, ID rastreável (ex.: `leigo_login.md`) | A fazer |
| 5 | Orquestração | Disparo de uma rodada no Orca: worker Claude Code no worktree da trilha + worker revisor ao final | `orquestracao/` | Fluxo documentado e validado com uma rodada piloto ponta a ponta | Configurado; piloto a fazer |
| 6 | Execução das rodadas | Rodar cada prompt na sua trilha; registrar a sessão | branches do Maxx, `resultados/<trilha>/` | Registro de cada rodada salvo | A fazer |
| 7 | Validação técnica (testes) | Testes unitários de referência sobre a lógica crítica gerada (pontuação dos prêmios por tier, ranking), seção 3.2 do TCC | dentro da branch da trilha | Suíte de referência rodada por rodada, resultado registrado | A fazer |
| 8 | Review por rodada | Agente revisor pontua Código e Segurança; humano valida a nota antes de registrar | `avaliacoes/rubrica.md`, `avaliacoes/reviews/`, `avaliacoes/registro-avaliacoes.xlsx` | 1 linha por rodada na planilha, validada por humano | A fazer |
| 8b | Auditorias de milestone | Ao fechar cada camada (Autenticação, Banco de Dados, Gamificação, Frontend), avaliar Arquitetura e Mantenabilidade sobre o diff acumulado da trilha; UX ao final de cada feature navegável | `avaliacoes/`, branches | 4 auditorias por trilha (8 no total) | A fazer |
| 9 | Deploy por trilha | Cada trilha no ar em uma URL própria (2 deploys), atualizada a cada rodada mergeada. O deploy é pedido pela persona, como qualquer outra rodada | branches do Maxx | 2 URLs navegáveis | A fazer |
| 10 | Consolidação comparativa | Cruzar leigo x engenheiro por eixo e por tela; features emergentes; custo de correção | aba "Resumo" da planilha | Tabela/gráficos comparativos | A fazer |
| 11 | Documentação final do TCC | Atualizar 3.1 (contexto comum, um agente), 3.2 (teste de referência sobre pontos do prêmio) e 3.3 (Análise Comparativa) com os dados | PDF do TCC | Versão final do TCC | A fazer |

## Regra de review por trilha

- Trilha **leigo**: review **observacional**. Falhas encontradas são registradas, não
  corrigidas, para medir o efeito composto da falta de validação técnica.
- Trilha **engenheiro**: review **corretivo**. Corrigir e refinar prompts faz parte da
  persona; registrar o custo (tempo/iterações).

## Regra de contexto por trilha

O contexto comum (`CLAUDE.md`) é idêntico no commit inicial das duas branches e não é
editado à mão depois disso. Cada trilha evolui o próprio contexto apenas por meio dos
próprios prompts (o engenheiro tende a fazê-lo; o leigo, não). Nunca copiar contexto,
código ou decisão entre trilhas.

## Dependências entre fases

- Fase 4 (prompts) depende da fase 2 (personas) e da fase 3 (especificação por tela).
- Fase 6 (execução) depende da fase 5 estar validada com uma rodada piloto ponta a
  ponta (sugestão: `login`, nas duas trilhas).
- Fase 8 (pontuação) só começa depois da fase 7 (testes): o eixo Código usa o
  resultado dos testes como critério objetivo.
- Fase 9 (deploy) depende da primeira feature navegável (login) estar mergeada.
- Fases 10 e 11 dependem de todas as telas terem rodado nas duas trilhas.

## Convenção de nomenclatura

Mesmo ID em prompt, resultado, review e planilha:

```
prompts/leigo/leigo_login.md
resultados/leigo/leigo_login.md
avaliacoes/reviews/leigo_login.md
avaliacoes/registro-avaliacoes.xlsx  (linha com ID = leigo_login)
```

Rodadas extras da mesma tela (correção na trilha do engenheiro, repetição de pedido
na trilha do leigo) recebem sufixo: `eng_login_v2`, `leigo_login_v2`.
