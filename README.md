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
Mesma ideia (pitch; repos nascem vazios) ──▶ Trilha LEIGO      ──▶ deploy (URL 1)
                                         └─▶ Trilha ENGENHEIRO ──▶ deploy (URL 2)

Cada rodada, em cada trilha:
prompt da persona ──▶ Claude Code gera/evolui o código ──▶ review por agente de IA (rubrica)
              ──▶ review humano (valida a nota) ──▶ merge na main do repo da trilha
```

- **Trilha = repositório** (`maxx-leigo` e `maxx-engenheiro`), os dois nascendo do mesmo
  commit semente, vazio (README e `.gitattributes`; mesmo hash nos dois). A ideia está
  em `docs/contexto-comum.md`. Repos separados, e não branches, para o agente de uma
  trilha não ter como enxergar a outra nem por `git` (decidido em 10/10/2026).
- **A mesma ideia, conhecimento diferente.** A ideia é o pitch de corredor, igual nas
  duas trilhas, e chega ao agente pelo prompt de abertura de cada persona; nenhum
  arquivo de contexto vai no repositório. O engenheiro transforma o pitch em regras de
  produto e em requisitos técnicos antes de qualquer código (três definições: design,
  produto, técnica); o leigo entrega o pitch e segue, porque o corpus mostra que
  faria assim. O trabalho de definição não desaparece: ou a pessoa faz antes, ou o
  agente faz por ela, e isso é medido. Nunca se copia contexto, código ou decisão de
  uma trilha para a outra (decidido em 11/10/2026; antes, as duas trilhas recebiam o
  mesmo `CLAUDE.md`).
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
docs/            A ideia e as regras do produto, especificação por tela, linha do tempo
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
