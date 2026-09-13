# Capítulo 3 (rascunho): o experimento

Rascunho em Markdown do texto que vai substituir a metodologia parcial (seções 3.1 a
3.3 da entrega de junho de 2026) na versão final do TCC. Escrever aqui conforme as
rodadas acontecem; a formatação final (ABNT, Word) é feita depois, a partir deste
arquivo. Regras de estilo: português, sem travessões, modelos de IA referidos pelo
nome da empresa (Anthropic), nunca por versão; afirmações sobre resultado só com a
rodada correspondente registrada.

## 3.1 Desenho do experimento

Título de trabalho: A Mesma Ideia, Dois Construtores: o que muda em um produto de
software quando quem conduz a IA entende, ou não, de engenharia de software.

Pergunta de pesquisa: o que muda no produto, em arquitetura, segurança, código,
experiência do usuário e mantenabilidade, quando a mesma ideia é construída com IA por
um usuário leigo e por um engenheiro de software?

O experimento constrói o mesmo aplicativo (Maxx, plataforma gamificada de engajamento
acadêmico da rede UniEduk) em duas trilhas independentes, a partir de um contexto
comum idêntico. Em uma trilha os prompts são escritos como um usuário sem formação
técnica escreveria; na outra, como um engenheiro de software pleno escreveria. O
agente de IA é o mesmo nas duas trilhas (Claude Code, da Anthropic), o revisor
automático é o mesmo (mesmo modelo, mesmo prompt, mesma rubrica) e a validação técnica
é a mesma (testes de referência e teste de carga). O que varia é quem pede e como
pede; o que se mede é o produto que cada trilha constrói.

[A completar: justificativa da simplificação em relação ao desenho da entrega parcial
(quatro famílias de modelos e personas por modelo); por que um agente e um revisor.]

### 3.1.1 Contexto comum

[A completar a partir de `docs/contexto-comum.md`: o que o contexto fixa (ideia,
atores, telas, regras de prêmios e pontos) e o que deliberadamente deixa de fora
(stack, dados, segurança, testes), e por quê.]

### 3.1.2 Personas de quem escreve o prompt

[A completar a partir de `personas/leigo/perfil.md` (N=28, números do corpus) e
`personas/engenheiro/perfil.md` (autor como persona, corroboração pelos devs do
corpus). Incluir as limitações da amostra.]

### 3.1.3 Trilhas, rodadas e orquestração

[A completar a partir de `README.md`, `docs/linha-do-tempo.md` e `orquestracao/`:
branches, worktrees, rodada como unidade (com diálogo registrado), review automático
e humano, regra observacional x corretiva, isolamento entre trilhas.]

## 3.2 Validação do código gerado

[A completar: testes de referência (fronteiras da pontuação por tier: 30/31, 70/71,
100/101, 150/151; entradas inválidas; ordenação do ranking), aplicados igualmente às
duas trilhas; teste de carga com 200 e 2.000 usuários virtuais nos dois deploys.
Substitui o exemplo `calcularTierAluno` da entrega parcial.]

## 3.3 Rubrica e registro

[A completar a partir de `avaliacoes/rubrica.md` e da planilha: cinco eixos, escala 1 a
5, nota do revisor IA ao lado da nota validada por humano, divergência como dado.]

## 3.4 Resultados por rodada

Preencher uma linha por rodada validada (mesmos IDs da planilha).

| ID | Trilha | Tela | Data | Turnos humanos | Segurança | Código | Observações principais |
|---|---|---|---|---|---|---|---|
| | | | | | | | |

## 3.5 Auditorias de milestone

| Milestone | Trilha | Arquitetura | Mantenabilidade | UX | Observações |
|---|---|---|---|---|---|
| Autenticação | leigo | | | | |
| Autenticação | engenheiro | | | | |
| Banco de dados | leigo | | | | |
| Banco de dados | engenheiro | | | | |
| Gamificação | leigo | | | | |
| Gamificação | engenheiro | | | | |
| Frontend | leigo | | | | |
| Frontend | engenheiro | | | | |

## 3.6 Teste de carga

| Cenário | Usuários virtuais | Trilha | p95 (ms) | Erros (%) | Observações |
|---|---|---|---|---|---|
| | | | | | |

## 3.7 Análise comparativa

[A escrever ao final: leigo x engenheiro por eixo e por tela; decisões silenciosas da
IA em cada trilha; features emergentes da persona; custo (turnos, tempo, rodadas de
correção); divergência entre revisor IA e humano; resultados que não confirmam a
hipótese, registrados como achado.]
