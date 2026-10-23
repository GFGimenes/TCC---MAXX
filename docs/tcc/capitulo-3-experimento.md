# Capítulo 3 (rascunho): o experimento

Rascunho em Markdown do texto que vai substituir a metodologia parcial (seções 3.1 a
3.3 da entrega de junho de 2026) na versão final do TCC. Escrever aqui conforme as
rodadas acontecem; a formatação final (ABNT, Word) é feita depois, a partir deste
arquivo. Regras de estilo: português, sem travessões, modelos de IA referidos pelo
nome da empresa (Anthropic), nunca por versão; afirmações sobre resultado só com a
rodada correspondente registrada.

## 3.1 Desenho do experimento

Título de trabalho: A Mesma Ideia, Dois Construtores: o que muda em um produto de
software quando quem conduz a IA entende, ou não, de engenharia e arquitetura de
software.

Pergunta de pesquisa: o que muda no produto, em arquitetura, segurança, código,
experiência do usuário e mantenabilidade, quando a mesma ideia é construída com IA por
um usuário leigo e por um engenheiro de software?

O experimento constrói o mesmo aplicativo (Maxx, plataforma gamificada de engajamento
acadêmico da rede UniEduk) em duas trilhas independentes, a partir da mesma ideia,
entregue a cada trilha pelo prompt de abertura da própria persona, em repositórios que
nascem vazios. Em uma trilha os prompts são escritos como um usuário sem formação
técnica escreveria; na outra, como um engenheiro de software pleno escreveria. O
agente de IA é o mesmo nas duas trilhas (Claude Code, da Anthropic), o revisor
automático é o mesmo (mesmo modelo, mesmo prompt, mesma rubrica) e a validação técnica
é a mesma (testes de referência e teste de carga). O que varia é quem pede e como
pede; o que se mede é o produto que cada trilha constrói.

[A completar: justificativa da simplificação em relação ao desenho da entrega parcial
(quatro famílias de modelos e personas por modelo); por que um agente e um revisor.]

### 3.1.1 A ideia e o conhecimento de cada persona

[A completar a partir de `docs/contexto-comum.md`. A ideia é o pitch de corredor,
igual nas duas trilhas: uma rede social para a UniMax, parecida com o Instagram, com
pontos por prêmios e medalhas, rankings geral e por curso, mural de avisos. Tudo que
transforma o pitch em algo construível é engenharia de requisitos, e só o engenheiro
faz antes do código. Registrar a mudança de 11/10/2026: até então as duas trilhas
recebiam o mesmo `CLAUDE.md` com as regras completas; isso entregava ao leigo uma
especificação que ele nunca escreveria e fazia o experimento medir só técnica de
prompt. Sem o arquivo, o experimento mede o fenômeno inteiro.

O que a tese afirma e o que não afirma: não afirma que o engenheiro tem ideias
melhores; afirma que a disciplina de engenharia de software (requisitos, design,
arquitetura, segurança, testes, operação) muda o que é construído a partir da mesma
ideia. Uma pessoa sem formação técnica pode ter a ideia melhor; o que ela não tem é a
disciplina de transformá-la, e é isso que se mede. O desenho com um autor único é a
força do experimento, não a fraqueza: a mesma pessoa, a mesma ideia, mudando só o
conhecimento aplicado.

Engenheiro: três definições antes de qualquer código (design, em 9 a 10 horas e 14
prompts; produto, no `eng_00_produto`; técnica, no `eng_00_tecnica`). Leigo: o pitch
na abertura e nada mais, com política de reação pré-registrada (aceita o que o agente
propõe, reclama só do que vê quebrado ou feio, não introduz regra nova), escrita antes
do piloto a partir do corpus. O trabalho de definição não desaparece: ou a pessoa faz
antes, ou o agente faz por ela, com os padrões dele; quanto cada agente decidiu
sozinho é medido nas duas trilhas.

Tabela 3.x, custo de entrada, por trilha: horas antes do primeiro código; artefatos
produzidos antes do primeiro código (telas, tokens, linhas de prompt); decisões de
produto e técnicas tomadas pela pessoa antes de o agente agir; decisões tomadas pelo
agente sem pedido (somadas ao longo das rodadas).

Limitações a declarar: um autor único não consegue não saber o que sabe, e a política
de reação do leigo é o controle disso; os padrões assumidos pelo agente são os deste
modelo nesta versão, e outro modelo assumiria outros.]

### 3.1.2 Personas de quem escreve o prompt

[A completar a partir de `personas/leigo/perfil.md` (N=28, números do corpus) e
`personas/engenheiro/perfil.md` (autor como persona, corroboração pelos devs do
corpus). Incluir as limitações da amostra.]

### 3.1.3 Trilhas, rodadas e protocolo de execução

[A completar a partir de `README.md`, `docs/linha-do-tempo.md` e
`protocolo-de-rodada.md`: um repositório por trilha, nascidos do mesmo commit semente
(mesmo hash), em vez de duas branches de um repositório, porque o agente executa `git`
e poderia ler a outra branch; rodada como unidade (sessão nova do Claude Code, com
diálogo registrado e exportado); sem orquestrador entre a persona e o agente, para
que o único texto que chega ao agente seja o da persona; review
automático e humano, regra observacional x corretiva; ambiente constante nas duas
trilhas (mesmo modelo, mesma versão, mesma interface, memória automática desligada,
nenhum arquivo de contexto, nem no repositório). Registrar que o fluxo com Orca foi
configurado em 12/09 e abandonado em 10/10, e por quê.]

### 3.1.4 Identidade visual da trilha do engenheiro

Antes de escrever qualquer prompt de código, a persona do engenheiro produziu a
identidade visual e as telas de referência do Maxx. Esse passo existe porque é assim
que o autor trabalha em projetos reais (plano, telas, stack e arquitetura antes de
código) e porque o corpus da pesquisa mostra que a persona leiga não o faz: o leigo
usa um aplicativo existente como referência ("parecido com o Instagram") e pede a
tela direto. A diferença entre as trilhas começa, portanto, antes da primeira linha
de código.

O trabalho foi feito em duas etapas. Na primeira, em agosto de 2026, o autor colocou a
ideia no papel: rascunhos à mão no caderno (filosofia do aplicativo, login e cadastro,
mural, dashboard) e wireframes anotados no Excalidraw (perfil com a referência do
Instagram, mural, troféus), além de duas telas de alta fidelidade no Figma (login e
feed) e a prancha de identidade com o logo, a paleta azul-marinho e dourado do logo
da UniMax e os pills de tier. Essa etapa consumiu entre 3 e 4 horas. Na segunda, em
26 e 27 de setembro de 2026, o autor usou a ferramenta de design da Anthropic
(Claude Design) para transformar os rascunhos em seis telas finais, em tema claro e
escuro, mais a tela de cadastro e uma prancheta de padrão visual. Essa etapa consumiu
cerca de 6 horas, em três sessões paralelas com propósitos distintos.

A primeira sessão recebeu a identidade do autor e a pediu que o modelo propusesse o
padrão visual (tipografia, espaçamento, componentes, estados). A segunda recebeu o
padrão já fixado em valores e uma regra de experiência ("na dúvida entre um
componente de aplicativo e o equivalente do Instagram, use o do Instagram"), para
testar o quanto a regra sozinha corrigia o peso visual da primeira proposta. A
terceira foi uma exploração livre, sem cores fixadas, que devolveu três direções de
sistema de design; a direção escolhida, "Marinho & Ouro, institucional, metal de
verdade", foi publicada como um sistema de design com paleta, tipografia e regras de
uso em valores. A convergência aconteceu de volta na primeira sessão, que recebeu a
paleta da terceira, os medalhões metálicos de tier e o card descritivo do prêmio
abaixo da foto do post, e a regra do Instagram da segunda. Ao todo foram 14 prompts,
11 deles rascunhados com apoio do assistente da Anthropic no Cowork e revisados
contra a documentação oficial da ferramenta (objetivo, layout, conteúdo e público no
primeiro prompt; referências anexadas; uma tela por mensagem), e 3 escritos livremente
pelo autor como correções curtas com print. Os dois últimos vieram depois de o passo
ter sido dado como encerrado: ao revisar as telas exportadas, o autor percebeu que o
botão central do Mural, elevado e com sombra em todas as telas (pedido por ele mesmo
num prompt anterior), parecia o item selecionado mesmo com outra tela aberta, e
reabriu a sessão para uniformizar a regra de estado ativo das cinco abas, com o
realce arredondado atrás do ícone ativo, como na barra do Instagram. O registro
completo, prompt a prompt, com cada anexo identificado e sua procedência (insumo do
autor ou resultado gerado em outra sessão e reaproveitado como referência), está no
apêndice (`docs/referencias-visuais/prompts-design.md`); a exportação integral das
três sessões (código-fonte das pranchetas, tokens, componentes, fontes e imagens)
está em `docs/referencias-visuais/design/`.

Três observações de método. A identidade visual do engenheiro também foi produzida
com IA; o engenheiro atuou como diretor de arte, explorando alternativas em paralelo,
comparando e convergindo, e essa forma de trabalhar é parte do que se está medindo.
A revisão do resultado exportado, fora da ferramenta, pegou um defeito de uso que
passou na tela da própria ferramenta, e o pedido de correção desfez uma instrução
anterior do próprio autor: revisar o que a IA entregou, inclusive contra o que se
pediu antes, faz parte do trabalho da persona.
E o passo teve custo: entre 9 e 10 horas de trabalho da persona antes de qualquer
código, contra zero da persona leiga. Esse custo entra na análise comparativa junto
com o que ele comprou. Duas decisões de produto nasceram no design: a progressão de
prêmios e o login exclusivamente institucional. De 26/09 a 10/10 elas estiveram no
contexto comum das duas trilhas; com a mudança de 11/10 (repositórios vazios, ideia
como pitch) passaram a ser regras que só o engenheiro declara, no `eng_00_produto`, e
que o leigo só terá se pedir ou se o agente oferecer. As demais escolhas feitas no
design (abas no perfil, filtro "quem eu sigo" no ranking, log de leitura no mural,
raridade como ornamento) ficaram apenas na trilha do engenheiro e são tratadas como
escopo emergente da persona.

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
