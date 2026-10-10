# A Mesma Ideia, Dois Construtores

**Título do TCC (decidido em 13/09/2026):** A Mesma Ideia, Dois Construtores: o que muda
em um produto de software quando quem conduz a IA entende, ou não, de engenharia de
software.

**Title (EN):** Same Idea, Two Builders: what changes in a software product when the
person directing the AI does, or does not, understand software engineering.

**Pergunta de pesquisa:** o que muda no produto, nos cinco eixos avaliados
(arquitetura, segurança, código, UX e mantenabilidade), quando a mesma ideia é
construída com IA por um usuário leigo e por um engenheiro de software?

Título original da entrega parcial (junho/2026): "Desenvolvimento de um Produto de
Software com IA e Vibe Coding: análise dos benefícios, limitações e pontos críticos". A
troca de título acompanha a mudança de método (duas trilhas, uma variável) e precisa
ser alinhada com o orientador.

Este repositório organiza o experimento prático do TCC: construir o mesmo aplicativo
gamificado (Maxx, rede UniEduk) a partir da mesma ideia central, em duas trilhas
independentes, uma conduzida por prompts de um usuário leigo e outra por prompts de um
engenheiro de software, ambas executadas pelo mesmo agente de IA (Claude Code). O que
varia entre as trilhas é quem pede e como pede; o que se mede é o produto que cada uma
constrói, avaliado com a mesma rubrica em 5 eixos de qualidade de software.

## Desenho do experimento

```
Ideia central (contexto comum, idêntico) ──▶ Trilha LEIGO      ──▶ deploy (URL 1)
                                         └─▶ Trilha ENGENHEIRO ──▶ deploy (URL 2)

Cada rodada, em cada trilha:
prompt da persona ──▶ Claude Code gera/evolui o código ──▶ review por agente de IA (rubrica)
              ──▶ review humano (valida a nota) ──▶ merge na main do repo da trilha
```

- **Trilha = repositório** (`maxx-leigo` e `maxx-engenheiro`), os dois nascendo do mesmo
  commit (`e32107d`, mesmo hash nos dois) com o mesmo `CLAUDE.md` (o contexto comum,
  ver `docs/contexto-comum.md`). Repos separados, e não branches, para o agente de uma
  trilha não ter como enxergar a outra nem por `git` (decidido em 10/10/2026).
- **Contexto preservado por trilha.** O contexto comum é a semente das duas. A partir
  daí, cada trilha só evolui o próprio contexto pelos próprios prompts: o engenheiro
  pode abrir com uma rodada que estabelece regras de arquitetura e boas práticas; o
  leigo não faz isso, porque o corpus mostra que não faria. Nunca se copia contexto,
  código ou decisão de uma trilha para a outra.
- **Um único agente** (Claude Code) nas duas trilhas, e **um único revisor** (mesmo
  modelo, mesmo prompt, mesma rubrica) para as duas. Assim a diferença observada é
  atribuível ao prompt e à validação do usuário, não à ferramenta.
- **Review humano por persona.** Na trilha do leigo o review é observacional: falhas
  são registradas, não corrigidas, porque o leigo real não as veria. Na trilha do
  engenheiro o review é corretivo, e o custo da correção (tempo, iterações) é
  registrado como resultado.
- **Qualidade do prompt está embutida na persona.** Não há trilha "prompt ruim" à
  parte: o prompt leigo é escrito como o corpus de `personas/leigo/` mostra que leigos
  escrevem, e o do engenheiro como um engenheiro pleno escreveria.

## Estrutura

```
docs/            Contexto comum, especificação por tela, linha do tempo do experimento
personas/        Perfis leigo/engenheiro que orientam como cada prompt é escrito
prompts/         Prompts efetivamente enviados, um arquivo por rodada (<trilha>_<tela>.md)
protocolo-de-rodada.md   Como uma rodada é executada (sessão nova do Claude Code, revisor, checklist)
resultados/      Registro de cada rodada (resumo da sessão, decisões, avisos), por trilha
avaliacoes/      Rubrica (5 eixos), reviews do agente revisor e planilha de registro
```

O código gerado vive nos repos `maxx-leigo` e `maxx-engenheiro` (`Repos\tcc\`), os
únicos que os agentes tocam; esta pasta é o caderno do autor durante a execução (nada
daqui entra nos repos das trilhas enquanto as rodadas correm, para nenhuma trilha ver
o material da outra). Ela tem repositório próprio, privado (`GFGimenes/TCC---MAXX`),
que é o repositório do TCC; as duas pastas de trilha ficam fora dele pelo
`.gitignore`. Não há mais orquestrador: o fluxo está em `protocolo-de-rodada.md`. Ver `docs/linha-do-tempo.md` para as fases e o critério de pronto de cada
uma.
