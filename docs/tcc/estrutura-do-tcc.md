# Estrutura do TCC: capítulos, cobertura e lacunas

Documento de planejamento da versão final do TCC "A Mesma Ideia, Dois Construtores: o
que muda em um produto de software quando quem conduz a IA entende, ou não, de
engenharia de software". Para cada capítulo e seção traz o que ela contém, quais
documentos do experimento já cobrem o conteúdo, o que ainda não existe e uma
estimativa de tamanho. Não é texto do TCC; é o mapa para escrevê-lo.

Versão de 23/10/2026. Fontes: documentos da pasta `experimento/` do projeto "tcc" no
claude.ai e, para o estado depois de 11/10, as versões locais mais novas de
`docs/tcc/diario-do-experimento.md` (entrada de 12/10 e 22/10) e
`docs/linha-do-tempo.md` (seção "Ambiente fixado para as rodadas" e hash da semente),
que ainda não estão sincronizadas no projeto.

> **Decisão do autor (23/10/2026), posterior a este rascunho:** o corpo do TCC terá no
> máximo 25 páginas (introdução 2, fundamentação 5, metodologia 8, resultados 5,
> discussão 3, conclusão 1). As estimativas de páginas abaixo (72 a 96) ficam como
> registro do rascunho e não valem. Prompts, respostas, exports, reviews e planilhas
> ficam no repositório público do TCC, referenciado pelo hash do commit; só o essencial
> vai como apêndice no fim do documento (prompts da condição de prompt único com
> diffs, um prompt de exemplo por trilha, trechos de sessão e quadros das planilhas).
> Os itens "a confirmar com o autor" foram resolvidos no
> `docs/tcc/descritivo-capitulos-tcc.docx` (documento para o orientador).

## 1 Como ler este documento

Cada seção do TCC aparece com quatro partes: um parágrafo sobre o conteúdo; **Já
existe**, com os documentos que cobrem o conteúdo (caminhos como estão no repositório
`tcc`); **Falta**, com o que ainda não foi escrito ou não foi produzido; e **Tamanho**,
em páginas no formato ABNT (fonte 12, espaçamento 1,5, A4). As estimativas são minhas
e servem para distribuir esforço; o limite de páginas e o modelo de documento da
UniMax estão marcados como "a confirmar com o autor".

Tudo que é afirmado sobre o experimento está nos documentos citados. O que não está
aparece como **a confirmar com o autor**. Propostas minhas (de estrutura, de redação,
de procedimento) aparecem como **proposta**.

Normas de referência para a forma: ABNT NBR 14724 (trabalhos acadêmicos), NBR 6024
(numeração progressiva), NBR 6027 (sumário), NBR 6028 (resumo), NBR 10520 (citações) e
NBR 6023 (referências). Se a UniMax tiver modelo próprio, ele prevalece (a confirmar
com o autor).

## 2 Visão geral e tamanho

| Parte | Conteúdo | Páginas estimadas |
|---|---|---|
| Pré-textuais | Capa a sumário | 10 a 14 (não contam no corpo) |
| Capítulo 1 | Introdução | 6 a 8 |
| Capítulo 2 | Fundamentação teórica | 16 a 22 |
| Capítulo 3 | Metodologia e desenho do experimento | 24 a 30 |
| Capítulo 4 | Resultados | 14 a 20 |
| Capítulo 5 | Discussão | 9 a 12 |
| Capítulo 6 | Conclusão e trabalhos futuros | 3 a 4 |
| Referências | Lista ABNT | 3 a 5 |
| Apêndices | A a J | 40 a 80 impressas; exports integrais em mídia digital |
| Anexos | Material de terceiros | 0 a 5 |
| **Corpo textual** | Capítulos 1 a 6 | **72 a 96** |

O capítulo 3 é o maior de propósito: o experimento é a contribuição do trabalho, e um
desenho bem descrito é o que permite que outra pessoa o repita. Limite mínimo ou
máximo de páginas exigido pelo curso: a confirmar com o autor.

## 3 Elementos pré-textuais

Capa, folha de rosto, ficha catalográfica, folha de aprovação, dedicatória e
agradecimentos (opcionais), epígrafe (opcional), resumo com palavras-chave, abstract
com keywords, listas de figuras, quadros, tabelas e siglas, e sumário.

- **Já existe:** título em português e em inglês e pergunta de pesquisa
  (`README.md`, decididos em 13/09/2026); nome do orientador (Prof. Luiz Cláudio
  Chiavini Oliveira Júnior). A entrega parcial de junho de 2026 tem resumo e abstract
  com o título antigo ("Desenvolvimento de um Produto de Software com IA e Vibe
  Coding: análise dos benefícios, limitações e pontos críticos").
- **Falta:** resumo e abstract novos, escritos por último, com os resultados (fase 11
  da linha do tempo); palavras-chave; aprovação do título novo pelo orientador
  (`README.md` e `plano-de-inicio.md` registram que precisa ser alinhado); lista de
  siglas (CLI, LLM, MCP, MVP, RA, ORM, CI, CDN, VPS, p95, entre outras).
- **Tamanho:** resumo e abstract com uma página cada (NBR 6028: 150 a 500 palavras); o
  conjunto, 10 a 14 páginas.

## 4 Elementos textuais

### Capítulo 1 Introdução

#### 1.1 Contextualização

Apresenta o cenário: modelos de linguagem que escrevem código, agentes de
codificação que executam tarefas inteiras e o *vibe coding*, em que a pessoa conduz a
construção por linguagem natural. Fecha com a observação que motiva o trabalho: a
mesma ferramenta passa a estar na mão de quem tem formação em engenharia de software
e de quem não tem, e não se sabe o que muda no produto entre um caso e outro.

- **Já existe:** contextualização da entrega parcial (fase 0 da linha do tempo:
  "Contextualização, objetivos, teoria", marcada como feita).
- **Falta:** reescrever com o enquadramento novo (duas pessoas conduzindo a mesma IA,
  em vez de benefícios e limitações do vibe coding em geral). O conteúdo exato da
  contextualização da entrega parcial não está nos documentos do projeto: a confirmar
  com o autor o que aproveitar.
- **Tamanho:** 2 a 3 páginas.

#### 1.2 Problema e pergunta de pesquisa

Formula o problema e a pergunta: o que muda no produto, em arquitetura, segurança,
código, experiência do usuário e mantenabilidade, quando a mesma ideia é construída
com IA por um usuário leigo e por um engenheiro de software. Explicita a premissa que
o experimento põe à prova: o trabalho de definição (requisitos, design, arquitetura,
segurança, testes) não desaparece quando a IA escreve o código; ou a pessoa faz antes,
ou o agente faz por ela, com os padrões dele.

- **Já existe:** pergunta de pesquisa (`README.md`, `capitulo-3-experimento.md` §3.1);
  a premissa do trabalho de definição (`contexto-comum.md`, diário de 11/10).
- **Falta:** o texto em si; hipóteses formuladas de maneira explícita no capítulo 1
  (hoje estão implícitas no desenho). **Proposta:** declarar aqui a hipótese principal
  e remeter as hipóteses da condição de prompt único para a §3.1.5.
- **Tamanho:** 1 página.

#### 1.3 Objetivos

Objetivo geral e objetivos específicos, alinhados ao método de duas trilhas.

- **Já existe:** objetivos da entrega parcial, com o título antigo; a linha do tempo
  (fase 11) registra que precisam ser atualizados.
- **Falta:** os objetivos novos. **Proposta**, derivada dos documentos, a validar com
  o autor e o orientador:
  - Geral: comparar o produto de software construído por um mesmo agente de IA, a
    partir da mesma ideia, quando conduzido por um usuário leigo e por um engenheiro
    de software, nos cinco eixos da rubrica.
  - Específicos: (a) caracterizar como pessoas sem formação técnica pedem software a
    uma IA, a partir de uma pesquisa com 28 respondentes; (b) construir as duas
    trilhas sob protocolo controlado (mesmo agente, mesmo modelo, mesma versão, mesmo
    revisor); (c) avaliar cada produto com rubrica, testes de referência e teste de
    carga; (d) medir quem fez o trabalho de definição, a pessoa ou o agente (custo de
    entrada, decisões do agente sem pedido, regras ausentes); (e) medir o custo de
    cada trilha (turnos humanos, tempo, rodadas de correção, tokens); (f) medir a
    concordância entre o revisor de IA e a validação humana; (g) verificar, com a
    condição de prompt único, se a diferença entre as trilhas está no conteúdo do que
    a pessoa entrega ao agente ou na quantidade de mensagens.
- **Tamanho:** 1 página.

#### 1.4 Justificativa

Por que a pergunta importa: agentes de codificação tornam possível a quem não programa
publicar um aplicativo com login, fotos e dados pessoais; se o que separa um produto
seguro e mantenível de um frágil é a disciplina de quem conduz, isso tem consequência
para quem usa esses produtos, para quem ensina engenharia de software e para quem
avalia código gerado por IA. Inclui a justificativa do recorte (um autor, uma ideia,
um agente) como força do desenho.

- **Já existe:** argumentos espalhados: o risco de "IA avaliando IA sem validação
  humana" (`protocolo-de-rodada.md`, regra 3); contexto desatualizado como fonte de
  dívida técnica, já registrado no TCC segundo `persona-engenheiro.md`; o autor único
  como força do desenho (diário de 11/10, `capitulo-3-experimento.md` §3.1.1);
  dados sensíveis do produto (RA, e-mail, fotos-prova, notas e pontos, em
  `rubrica.md`).
- **Falta:** o texto e a sustentação bibliográfica (dados sobre adoção de agentes de
  codificação, estudos sobre segurança de código gerado por IA). Nenhuma referência
  bibliográfica desse tipo está nos documentos do projeto: a levantar.
- **Tamanho:** 1 a 2 páginas.

#### 1.5 Escopo e delimitação

O que a tese afirma e o que não afirma: não afirma que o engenheiro tem ideias
melhores; afirma que a disciplina de engenharia de software muda o que é construído a
partir da mesma ideia. Delimita: um agente (Claude Code, da Anthropic), um modelo, um
produto (Maxx), um autor que atua nas duas personas, uma execução por condição.

- **Já existe:** `capitulo-3-experimento.md` §3.1.1 (notas), diário de 11/10.
- **Falta:** o texto.
- **Tamanho:** 0,5 a 1 página.

#### 1.6 Organização do trabalho

Um parágrafo por capítulo.

- **Já existe:** nada específico.
- **Falta:** escrever por último.
- **Tamanho:** 0,5 página.

### Capítulo 2 Fundamentação teórica

O capítulo dá a base para os conceitos que o capítulo 3 usa sem explicar. A linha do
tempo marca como feita a teoria sobre vibe coding, LLMs e gamificação (fase 0); o
experimento novo pede três blocos que não existiam na entrega parcial: agentes de
codificação, engenharia de requisitos e qualidade de software (base da rubrica), e
avaliação por LLM.

#### 2.1 Inteligência artificial generativa e modelos de linguagem

Funcionamento em alto nível dos modelos de linguagem, janela de contexto, não
determinismo da geração, alucinação. Os três últimos são usados diretamente no
experimento (contexto de 1M, uma execução por condição, critério de "sinais de
alucinação" no eixo Código).

- **Já existe:** seção da entrega parcial (fase 0).
- **Falta:** ligar explicitamente não determinismo e alucinação às ameaças à validade
  e à rubrica. O conteúdo exato da seção existente: a confirmar com o autor.
- **Tamanho:** 3 a 4 páginas.

#### 2.2 Vibe coding e desenvolvimento assistido por IA

Definição, origem do termo, espectro entre autocompletar e agente autônomo, quem
pratica.

- **Já existe:** seção da entrega parcial (fase 0).
- **Falta:** revisão para o enquadramento leigo x engenheiro.
- **Tamanho:** 2 a 3 páginas.

#### 2.3 Agentes de codificação

O que é um agente de codificação e como o Claude Code funciona no que importa para o
experimento: ferramentas (ler, escrever, executar comandos, `git`), modos de
permissão, arquivos de contexto carregados automaticamente (`CLAUDE.md` em várias
pastas), memória automática, skills e conectores visíveis ao agente, sessões e
transcrições. É a base para justificar os controles do protocolo (repositórios
separados, memória desligada, nenhum `CLAUDE.md` acima dos repositórios).

- **Já existe:** ordem de carregamento de contexto e expiração das transcrições
  (`protocolo-de-rodada.md`, "Antes da primeira rodada"); ambiente fixado, skills e
  conectores visíveis, modo de permissão (versão local de `docs/linha-do-tempo.md`);
  motivo da troca de branches por repositórios (diário de 10/10).
- **Falta:** o texto, com citação da documentação oficial do Claude Code como fonte.
- **Tamanho:** 2 a 3 páginas.

#### 2.4 Engenharia de requisitos e o trabalho de definição

O que é transformar uma ideia em algo construível: atores, regras de negócio,
requisitos não funcionais, casos de borda, critérios de aceite. É o conceito que
separa as personas no desenho (o engenheiro faz três definições antes do código; o
leigo entrega o pitch) e que sustenta as métricas de "decisões do agente" e "regra
ausente".

- **Já existe:** a aplicação ao experimento (`contexto-comum.md`,
  `persona-engenheiro.md`, diário de 11/10).
- **Falta:** a seção inteira, com bibliografia de engenharia de requisitos (a
  levantar).
- **Tamanho:** 2 a 3 páginas.

#### 2.5 Qualidade de software: os cinco eixos

Fundamenta cada eixo da rubrica: arquitetura, segurança, código (correção e testes),
experiência do usuário e mantenabilidade. **Proposta:** ancorar os eixos em um modelo
de qualidade reconhecido (por exemplo, ISO/IEC 25010) e o eixo de segurança em uma
referência de vulnerabilidades comuns de aplicações web (por exemplo, OWASP Top 10),
mostrando o mapeamento entre o modelo e a rubrica. As duas referências são sugestão
minha, não constam dos documentos.

- **Já existe:** a rubrica operacional (`rubrica.md`), sem fundamentação teórica.
- **Falta:** a seção inteira e o quadro de mapeamento entre o modelo de qualidade e
  os cinco eixos.
- **Tamanho:** 3 a 4 páginas.

#### 2.6 Engenharia de prompt e de contexto

Como a forma e o conteúdo do pedido afetam o resultado de um agente; a orientação da
Anthropic para prompts consultada em 13/09 (menor conjunto de tokens de alto sinal,
contexto carregado automaticamente, explorar, planejar e só então codificar).
Distingue técnica de prompt de conhecimento do domínio, distinção que motivou a
mudança de 11/10.

- **Já existe:** resumo da pesquisa no diário de 13/09; a justificativa da mudança
  de 11/10 (o contexto comum fazia o experimento "medir só técnica de prompt").
- **Falta:** o texto e as referências (documentação da Anthropic e literatura).
- **Tamanho:** 2 páginas.

#### 2.7 Avaliação de código por modelos de linguagem

O uso de um modelo como revisor (o "LLM como juiz"), seus vieses conhecidos e por que
o experimento trata a nota do revisor como rascunho e a nota humana como a que vale.

- **Já existe:** a regra no protocolo (regra 3) e a divergência como dado
  (`capitulo-3-experimento.md` §3.3).
- **Falta:** a seção inteira e a bibliografia (a levantar).
- **Tamanho:** 1 a 2 páginas.

#### 2.8 Gamificação no ensino

Base do domínio do produto (prêmios, pontos, rankings). Aqui a gamificação é o
assunto do aplicativo, não o objeto da pesquisa.

- **Já existe:** seção da entrega parcial (fase 0).
- **Falta:** **proposta:** reduzir ao necessário para entender as regras do Maxx.
- **Tamanho:** 1 a 2 páginas.

#### 2.9 Trabalhos relacionados

Estudos que comparam desenvolvedores experientes e iniciantes usando IA, que medem
segurança e qualidade de código gerado por IA, ou que estudam pessoas sem formação
técnica construindo software com IA. Fecha com um quadro comparativo e a lacuna que o
TCC ocupa.

- **Já existe:** nada nos documentos do projeto.
- **Falta:** levantamento bibliográfico e quadro comparativo.
- **Tamanho:** 2 a 3 páginas.

### Capítulo 3 Metodologia e desenho do experimento

O capítulo existe como rascunho (`capitulo-3-experimento.md`), com a numeração 3.1 a
3.7. Na estrutura completa, ele fica com o desenho, os instrumentos e os controles; as
tabelas de resultado (3.4 a 3.6) vão para o capítulo 4 e a análise comparativa (3.7)
vai para o capítulo 5. As mudanças estão detalhadas na seção 6 deste documento. As
seções 3.1 a 3.3 mantêm a numeração atual.

#### 3.1 Desenho do experimento

Visão geral: o mesmo aplicativo (Maxx, rede UniEduk) construído em duas trilhas
independentes a partir do mesmo pitch, com o mesmo agente, o mesmo revisor e a mesma
validação; varia quem pede e como pede. Inclui a figura do desenho e a justificativa
da simplificação em relação à entrega parcial.

- **Já existe:** texto de abertura da §3.1; figura do desenho (`README.md`); a
  simplificação de quatro trilhas (2 personas x 2 agentes) para duas, com um agente e
  um revisor (diário de 12/09).
- **Falta:** o parágrafo "[A completar: justificativa da simplificação...]"; a figura
  redesenhada para incluir a condição de prompt único (proposta: quadro 2 x 2, persona
  por condição).
- **Tamanho:** 2 páginas.

#### 3.1.1 A ideia e o conhecimento de cada persona

O pitch igual nas duas trilhas, o que é engenharia de requisitos e quem a faz, a
mudança de 11/10 (fim do `CLAUDE.md` comum), as três definições do engenheiro, a
política de reação do leigo e a definição da tabela de custo de entrada (o
instrumento; os valores vão para o capítulo 4).

- **Já existe:** notas detalhadas na própria §3.1.1; `contexto-comum.md`; diário de
  11/10, incluindo o ajuste de contestação de prêmio para "em averiguação"; o
  conteúdo dos prompts `eng_00_produto` e `eng_00_tecnica` e o registro de
  `leigo_00_abertura` (481 caracteres, 2,6 vezes a média de 165 dos não devs do
  corpus), descritos no diário de 11/10.
- **Falta:** passar as notas a texto corrido; incluir as limitações já listadas nas
  notas na nova §3.4.
- **Tamanho:** 3 a 4 páginas.

#### 3.1.2 Personas de quem escreve o prompt

Perfil do leigo a partir do corpus (N=28: 10 nunca trabalharam com tecnologia, 13 em
função próxima, 5 com desenvolvimento; 165 contra 566 caracteres na primeira
mensagem; 8 de 23 citam algum dos três elementos do cenário; 0 de 23 mencionam
segurança, teste, hospedagem ou publicação) e perfil do engenheiro (o autor, com os
desenvolvedores do corpus como corroboração), com as limitações da amostra.

- **Já existe:** `persona-leigo.md` e `persona-engenheiro.md`, completos.
- **Falta:** a síntese em texto; um quadro comparando as duas personas (vocabulário,
  tamanho, ordem de trabalho, como respondem ao agente, como validam).
- **Tamanho:** 3 a 4 páginas.

#### 3.1.3 Trilhas, rodadas e protocolo de execução

Um repositório por trilha a partir da mesma semente, rodada como unidade, sem
orquestrador, revisor e review humano (observacional e corretivo), ambiente constante
e o histórico das decisões de ambiente (Orca configurado em 12/09 e abandonado em
10/10). Inclui um quadro de ambiente.

- **Já existe:** `README.md`, `protocolo-de-rodada.md`, `plano-de-inicio.md`, diário
  de 10/10; na versão local da linha do tempo, o hash da semente (`1577ae9`, 10/10/2026
  22:59), a versão do CLI (2.1.270, depois 2.1.308 fixada em 22/10 com
  `DISABLE_AUTOUPDATER=1`), o modelo escolhido por nome, o esforço, o modo de
  permissão ("auto mode"), as skills e os conectores visíveis e o `/context` de
  abertura.
- **Falta:** o texto; o quadro de ambiente; o registro do desvio da `eng_00` (sessão
  retomada com `claude --resume` depois do reinício do computador, quando o protocolo
  diz "nunca `--continue` ou `--resume`", e mudança de versão do CLI no meio da mesma
  sessão, ambos no diário de 12/10 e 22/10).
- **Tamanho:** 3 a 4 páginas.

#### 3.1.4 Identidade visual da trilha do engenheiro

Já escrita: o trabalho de design antes do código, em duas etapas (3 a 4 horas de
rascunhos em agosto, cerca de 6 horas no Claude Design em 26 e 27/09), três sessões
paralelas, 14 prompts, o defeito do botão do Mural achado na revisão do exportado, e
o custo de 9 a 10 horas contra zero do leigo.

- **Já existe:** a seção completa; `prompts-design.md`; exportação em
  `docs/referencias-visuais/design/`.
- **Falta:** ajustes pequenos (ver seção 6): corrigir "e a pediu que o modelo
  propusesse" e trocar o caminho do apêndice pela letra do apêndice.
- **Tamanho:** 2 a 3 páginas (como está).

#### 3.1.5 Condição de prompt único

Condição nova: cada persona entrega tudo em um prompt só, numa sessão nova, sem turno
humano depois, e o agente vai até onde consegue. Isola o conteúdo do pedido da
quantidade de mensagens.

- **Já existe:** o texto proposto no documento separado
  `docs/tcc/condicao-prompt-unico.md`.
- **Falta:** decisões do autor listadas no fim daquele documento; o pré-registro;
  os arquivos de prompt `leigo_pu` e `eng_pu`.
- **Tamanho:** 3 a 4 páginas.

#### 3.2 Validação do código gerado

Os testes de referência (fronteiras 30/31, 70/71, 100/101 e 150/151 da pontuação por
tier; entradas inválidas; ordenação do ranking), aplicados igualmente às trilhas e à
regra de pontos que cada produto tiver, com "ausente" quando não houver regra; e o
teste de carga (k6 ou autocannon, 200 e 2.000 usuários virtuais, feed, mural e upload
de foto, latência p95 e taxa de erro, mesmos cenários nos dois deploys).

- **Já existe:** especificação em `plano-de-inicio.md`, linha do tempo (fases 7 e 7b) e
  `rubrica.md` (regra ausente aplicada aos testes).
- **Falta:** o texto; a suíte de testes em si; os scripts de carga e a escolha entre
  k6 e autocannon; como a suíte de referência é adaptada a um produto cuja regra de
  pontos difere da referência (a confirmar com o autor); se a condição de prompt único
  entra no teste de carga (ela não tem deploy; ver o documento da condição).
- **Tamanho:** 2 a 3 páginas.

#### 3.3 Rubrica e registro

Os cinco eixos, a escala de 1 a 5, quando cada eixo é avaliado (Código e Segurança por
rodada; Arquitetura e Mantenabilidade nos milestones; UX ao fim de cada feature
navegável), o estado "regra ausente", a nota do revisor ao lado da nota validada e a
divergência como dado; a planilha de registro.

- **Já existe:** `rubrica.md`; prompt do revisor por rodada em
  `protocolo-de-rodada.md`; a planilha `avaliacoes/registro-avaliacoes.xlsx` é citada
  no plano, mas não está entre os documentos do projeto.
- **Falta:** o texto; o prompt do revisor para os milestones (o protocolo descreve,
  não transcreve); a forma de avaliar UX na trilha do leigo, que não tem telas de
  referência, já que a rubrica fala em "fiel ao desenho/telas de referência" (a
  confirmar com o autor; proposta: usar `docs/especificacao-telas.md` como referência
  nas duas trilhas e os mockups só como referência adicional do engenheiro);
  atualizar o critério 3 do eixo Código, que ainda cita "o exemplo de teste da seção
  3.2" da entrega parcial.
- **Tamanho:** 2 a 3 páginas, com a rubrica completa no apêndice G.

#### 3.4 Pré-registro e ameaças à validade (seção nova)

**Proposta.** Reúne o que hoje está espalhado: o que foi fixado antes de rodar e
quando (política de reação do leigo, prompts de abertura, prompts de tela do leigo,
condição de prompt único), com data e hash de commit; e as ameaças à validade do
experimento todo, por tipo (interna, de construto, externa, de conclusão), cada uma
com o controle adotado. As ameaças específicas do prompt único ficam na §3.1.5 e são
apenas referenciadas aqui.

- **Já existe:** limitações nas notas da §3.1.1 (autor único que não consegue não saber
  o que sabe; padrões assumidos pelo agente são os deste modelo); limitações da
  amostra (`persona-leigo.md`); lacunas típicas do engenheiro (superespecificação,
  overengineering, `persona-engenheiro.md`); resíduo de versão do CLI na `eng_00`
  (linha do tempo local).
- **Falta:** a seção; um registro único de pré-registro com datas e hashes; ameaças
  ainda não escritas que encontrei ao ler os documentos (a confirmar com o autor se
  entram): o nome da pasta e do remoto (`maxx-leigo`, `maxx-engenheiro`) é visível ao
  agente e revela a trilha; os repositórios das trilhas ficam dentro da pasta `tcc`,
  que contém os prompts e as personas das duas trilhas (o checklist humano confere
  acesso, mas não impede); o revisor e o validador humano sabem qual trilha avaliam.
- **Tamanho:** 2 a 3 páginas.

#### 3.5 Aspectos éticos (seção nova)

**Proposta.** A pesquisa com 28 respondentes coletou respostas de pessoas; a seção
registra como foi o consentimento, o anonimato (os respondentes aparecem como R01 a
R28) e se houve ou não submissão a comitê de ética.

- **Já existe:** a identificação por código no corpus (`persona-leigo.md`).
- **Falta:** tudo sobre consentimento, data e meio de coleta e comitê de ética (a
  confirmar com o autor e o orientador).
- **Tamanho:** 0,5 a 1 página.

### Capítulo 4 Resultados

Só dados, sem interpretação. Recebe as tabelas que hoje estão em 3.4 a 3.6 do
rascunho, mais os resultados que o desenho já prevê e que ainda não têm tabela.

#### 4.1 Execução do experimento

O que rodou, quando, com qual versão, e todos os desvios do protocolo (rodadas
descartadas por acesso fora do repositório, retomadas de sessão, mudança de versão).

- **Já existe:** diário (12/10 e 22/10: `eng_00` em andamento, retomada com
  `--resume`, CLI atualizado para 2.1.308).
- **Falta:** tudo a partir das rodadas seguintes. O estado de `leigo_00_abertura` (o
  piloto estava marcado para 12/10, e o diário de 12/10 só fala da `eng_00`): a
  confirmar com o autor.
- **Tamanho:** 1 a 2 páginas.

#### 4.2 Custo de entrada por trilha

A tabela definida na §3.1.1: horas antes do primeiro código, artefatos antes do
primeiro código, decisões de produto e técnicas tomadas pela pessoa, decisões tomadas
pelo agente sem pedido.

- **Já existe:** valores parciais: engenheiro, 9 a 10 horas de design e 14 prompts
  (§3.1.4), dois prompts de abertura e a `r1` com respostas a 8 bloqueadores (diário
  de 12/10); o agente devolveu 20 decisões pendentes com sugestão. Leigo: zero horas
  antes do código, abertura de 481 caracteres.
- **Falta:** tempo de escrita dos prompts de abertura do engenheiro; contagem de
  decisões; os valores do leigo depois da abertura.
- **Tamanho:** 1 a 2 páginas.

#### 4.3 Resultados por rodada

Tabela que hoje é a §3.4 do rascunho (ID, trilha, tela, data, turnos humanos,
Segurança, Código, observações), com a nota do revisor e a validada.

- **Já existe:** a tabela vazia.
- **Falta:** os dados. **Proposta:** acrescentar colunas de tempo e de tokens por
  rodada, necessárias para comparar custo com o prompt único.
- **Tamanho:** 2 a 3 páginas.

#### 4.4 Testes de referência

Resultado da suíte por trilha e por rodada, incluindo os casos "ausente".

- **Já existe:** a especificação (§3.2).
- **Falta:** os dados.
- **Tamanho:** 1 a 2 páginas.

#### 4.5 Auditorias de milestone

Tabela que hoje é a §3.5 (Autenticação, Banco de dados, Gamificação, Frontend, por
trilha, com Arquitetura, Mantenabilidade e UX).

- **Já existe:** a tabela vazia.
- **Falta:** os dados.
- **Tamanho:** 1 a 2 páginas.

#### 4.6 Teste de carga

Tabela que hoje é a §3.6 (cenário, usuários virtuais, trilha, p95, erros).

- **Já existe:** a tabela vazia.
- **Falta:** os dados e os relatórios em `avaliacoes/carga/`.
- **Tamanho:** 1 a 2 páginas.

#### 4.7 Decisões do agente, features emergentes e regras ausentes

Lista e contagem, por trilha, das decisões tomadas pelo agente sem o prompt pedir
(stack, estrutura, hospedagem, regra de produto), das features emergentes (do agente
e da persona) e das regras do produto nunca pedidas e nunca oferecidas.

- **Já existe:** a seção do review que registra decisões e features emergentes
  (prompt do revisor); o estado "regra ausente" (`rubrica.md`); as escolhas do design
  tratadas como escopo emergente da persona (§3.1.4).
- **Falta:** os dados; **proposta:** uma lista fixa de regras do produto, tirada de
  `contexto-comum.md`, usada como inventário igual para todos os produtos.
- **Tamanho:** 2 a 3 páginas.

#### 4.8 Condição de prompt único

Os quatro produtos lado a lado (leigo e engenheiro, iterativo e prompt único): notas
por eixo, inventário de cobertura, decisões do agente, o que ficou quebrado ou
ausente, custo.

- **Já existe:** o plano em `docs/tcc/condicao-prompt-unico.md` (§3.1.5.7).
- **Falta:** a execução e os dados.
- **Tamanho:** 2 a 3 páginas.

#### 4.9 Revisor de IA e validação humana

Divergência entre a nota do revisor e a nota validada, por eixo e por trilha.

- **Já existe:** a divergência calculada na planilha (segundo o plano).
- **Falta:** os dados.
- **Tamanho:** 1 página.

### Capítulo 5 Discussão

Interpreta os resultados à luz da pergunta e da fundamentação. Recebe o que hoje é a
§3.7 do rascunho ("Análise comparativa"), dividido em seções.

#### 5.1 Leigo e engenheiro, eixo a eixo

Onde as trilhas diferem e onde não diferem, por eixo e por tela.

- **Já existe:** a pauta na §3.7.
- **Falta:** os resultados.
- **Tamanho:** 2 a 3 páginas.

#### 5.2 Quem fez o trabalho de definição

O que o engenheiro decidiu antes e o que o agente decidiu pelo leigo; que padrões o
agente assumiu; o que nunca foi decidido (regras ausentes).

- **Já existe:** a premissa (`contexto-comum.md`); as notas de limitação sobre os
  padrões serem deste modelo (§3.1.1).
- **Falta:** os resultados.
- **Tamanho:** 1 a 2 páginas.

#### 5.3 Conteúdo ou quantidade de mensagens

A leitura da condição de prompt único, pelas regras de interpretação pré-registradas.

- **Já existe:** as regras de interpretação propostas em
  `docs/tcc/condicao-prompt-unico.md` (§3.1.5.7).
- **Falta:** os resultados.
- **Tamanho:** 1 a 2 páginas.

#### 5.4 O custo do conhecimento e o que ele comprou

Custo de entrada, turnos, correções e tokens de cada trilha contra a diferença de
qualidade obtida; inclui as lacunas típicas do engenheiro (superespecificação,
overengineering) como possíveis custos sem retorno.

- **Já existe:** o custo do design (§3.1.4); as lacunas típicas
  (`persona-engenheiro.md`).
- **Falta:** os resultados.
- **Tamanho:** 1 a 2 páginas.

#### 5.5 IA avaliando IA

O que a divergência entre revisor e humano diz sobre usar um modelo para avaliar
código de modelo.

- **Já existe:** a pauta (§3.7, regra 3 do protocolo).
- **Falta:** os resultados.
- **Tamanho:** 1 página.

#### 5.6 Resultados que não confirmam a hipótese

Registro explícito, como achado, de tudo que contrariar a hipótese.

- **Já existe:** a regra na §3.7.
- **Falta:** os resultados.
- **Tamanho:** 0,5 a 1 página.

#### 5.7 Limitações

As ameaças da §3.4 e da §3.1.5 revisitadas: quais se materializaram e como afetam a
leitura.

- **Já existe:** as ameaças (ver §3.4).
- **Falta:** a avaliação depois dos dados.
- **Tamanho:** 1 a 2 páginas.

### Capítulo 6 Conclusão e trabalhos futuros

#### 6.1 Resposta à pergunta de pesquisa

A resposta direta, eixo a eixo, com o grau de confiança que o desenho permite.

- **Já existe:** nada.
- **Falta:** tudo, depois dos resultados.
- **Tamanho:** 1 página.

#### 6.2 Contribuições

O desenho experimental (mesma pessoa, mesma ideia, conhecimento diferente), o corpus
de 28 respostas sobre como leigos pedem software, a rubrica com "regra ausente" e o
pacote reproduzível (prompts, exports, reviews).

- **Já existe:** os artefatos.
- **Falta:** o texto.
- **Tamanho:** 0,5 a 1 página.

#### 6.3 Trabalhos futuros

Desdobramentos que os próprios documentos apontam: outros modelos e agentes (os
padrões assumidos "são os deste modelo nesta versão, e outro modelo assumiria
outros"); o modelo mais capaz, descartado aqui por ser "o caso limite de
preenchimento de lacunas"; leigos sem familiaridade com IA, que o corpus não capturou;
personas conduzidas por pessoas reais em vez de um autor único; repetições do prompt
único para medir variabilidade.

- **Já existe:** as limitações citadas em §3.1.1, `persona-leigo.md` e linha do tempo
  local.
- **Falta:** o texto.
- **Tamanho:** 1 página.

## 5 Elementos pós-textuais

### 5.1 Referências

Lista em ABNT NBR 6023.

- **Já existe:** referências da entrega parcial; fontes citadas nos documentos sem
  referência formal: documentação do Claude Code (carregamento de `CLAUDE.md`,
  memória automática, `/export`, transcrições), documentação do Claude Design
  (§3.1.4) e orientação da Anthropic para prompts (diário de 13/09).
- **Falta:** referências de engenharia de requisitos, qualidade de software,
  segurança, LLM como juiz e trabalhos relacionados; datas de acesso das páginas da
  documentação.
- **Tamanho:** 3 a 5 páginas.

### 5.2 Glossário (opcional)

Termos do experimento: trilha, rodada, turno humano, review observacional e
corretivo, regra ausente, feature emergente, custo de entrada, prompt único.

- **Tamanho:** 1 página.

### 5.3 Apêndices

Pela NBR 14724, apêndice é material produzido pelo autor. Os exports e os registros
são extensos; **proposta:** imprimir trechos representativos e entregar o conjunto
integral em mídia digital ou no repositório do TCC, com o hash do commit citado no
texto (forma de entrega aceita pela UniMax: a confirmar com o autor).

| Apêndice | Conteúdo | Origem no repositório `tcc` | Estado |
|---|---|---|---|
| A | Pesquisa com 28 respondentes: formulário, corpus etiquetado (R01 a R28) e contagens que sustentam a persona leiga | `personas/leigo/formulario-persona-leiga.md`, `personas/leigo/corpus-respostas.md`, `personas/leigo/perfil.md` | Existe; faltam data e meio de coleta e termo de consentimento (a confirmar) |
| B | Perfis das personas | `personas/leigo/perfil.md`, `personas/engenheiro/perfil.md` | Existe |
| C | Prompts de cada rodada, por trilha, com cabeçalho; prompts de design; prompts únicos | `prompts/leigo/`, `prompts/engenheiro/` (hoje `leigo_00_abertura`, `eng_00_produto`, `eng_00_produto-r1`, `eng_00_produto-r2`, `eng_00_tecnica`), `docs/referencias-visuais/prompts-design.md` | Parcial; prompts de tela do leigo ainda não estão na pasta; prompts únicos a escrever |
| D | Registros das rodadas (resumo, decisões, perguntas e respostas, turnos, tempo) | `resultados/<trilha>/<id>.md` | A produzir |
| E | Exports das sessões | `resultados/<trilha>/<id>-sessao.txt` | A produzir; trechos impressos, integral em mídia digital |
| F | Avaliações do revisor de IA e planilha de registro | `avaliacoes/reviews/<id>.md`, `avaliacoes/registro-avaliacoes.xlsx` | A produzir |
| G | Protocolo de rodada, prompts do revisor e rubrica completa | `protocolo-de-rodada.md`, `avaliacoes/rubrica.md` | Existe; falta o prompt do revisor de milestone |
| H | Referências visuais do engenheiro (telas em tema claro e escuro, prancheta de padrão) | `docs/referencias-visuais/` | Existe |
| I | Registro de pré-registro (o que foi fixado, data, hash do commit) | a criar | A produzir |
| J | Suíte de testes de referência e relatórios de carga | `avaliacoes/carga/`, repos das trilhas | A produzir |

Sobre o arquivo `eng_00_produto-r2.md`: ele existe na pasta `prompts/engenheiro/`,
mas o diário só descreve a `r1`. O que é a `r2` e se ela já foi enviada: a confirmar
com o autor.

### 5.4 Anexos

Material de terceiros. **Proposta:** trechos da documentação oficial do Claude Code
usados para configurar o ambiente (carregamento de contexto, memória, atualização
automática), com data de acesso, já que o protocolo depende deles. Opcional; se a
banca aceitar a citação com link, o anexo pode ser dispensado.

- **Tamanho:** 0 a 5 páginas.

## 6 O que muda no capítulo 3 para caber na estrutura

As seções 3.1, 3.1.1 a 3.1.4, 3.2 e 3.3 mantêm número e conteúdo. As mudanças:

1. **3.4 a 3.6 saem do capítulo 3.** "Resultados por rodada" vira 4.3, "Auditorias de
   milestone" vira 4.5 e "Teste de carga" vira 4.6. As tabelas vão como estão. A
   "Tabela 3.x, custo de entrada" das notas da §3.1.1 fica definida no capítulo 3 como
   instrumento, e os valores vão para 4.2.
2. **3.7 sai do capítulo 3.** "Análise comparativa" vira o capítulo 5, dividido nas
   seções 5.1 a 5.6.
3. **Entra a §3.1.5**, condição de prompt único (documento separado).
4. **Entra uma §3.4 nova**, pré-registro e ameaças à validade, reunindo as
   limitações das notas da §3.1.1 e as ameaças listadas na seção 4 deste documento.
5. **Entra uma §3.5 nova**, aspectos éticos (a confirmar com o autor se é exigida).
6. **§3.1:** escrever o parágrafo de justificativa da simplificação (diário de 12/09)
   e atualizar a figura do desenho para o quadro 2 x 2.
7. **§3.1.1:** passar as notas a texto; incluir o ajuste de averiguação de prêmio do
   `eng_00_produto` (diário de 11/10).
8. **§3.1.3:** incluir o quadro de ambiente (a partir da linha do tempo local), o
   hash da semente `1577ae9` e o desvio da `eng_00` (`--resume` depois do reinício,
   troca de versão do CLI dentro da sessão). O protocolo diz "nunca `--continue` ou
   `--resume`"; ou o protocolo ganha uma regra para interrupção externa, ou o texto
   declara o desvio como tal (a confirmar com o autor).
9. **§3.1.4:** corrigir "A primeira sessão recebeu a identidade do autor e a pediu
   que o modelo propusesse" (sobra o "a"); trocar
   `docs/referencias-visuais/prompts-design.md` por "Apêndice C" e a exportação por
   "Apêndice H".
10. **§3.2:** escrever; dizer como os testes de referência se aplicam a um produto
    com regra de pontos diferente e se a condição de prompt único entra no teste de
    carga.
11. **§3.3:** escrever; definir a referência de UX para a trilha do leigo; registrar o
    prompt do revisor de milestone.
12. **Regra de estilo do rascunho.** O cabeçalho manda referir modelos "pelo nome da
    empresa (Anthropic), nunca por versão", mas a reprodutibilidade pede o
    identificador exato do modelo e a versão do CLI, que a linha do tempo já registra.
    **Proposta:** corpo do texto com "modelo da Anthropic"; identificador exato só no
    quadro de ambiente da §3.1.3. A confirmar com o autor.
13. **Nota de abertura do rascunho.** Diz que o capítulo "vai substituir a metodologia
    parcial (seções 3.1 a 3.3 da entrega de junho)"; com a reorganização, o rascunho
    passa a alimentar também os capítulos 4 e 5.

## 7 Inconsistências encontradas nos documentos

Não corrigi nenhuma; ficam para o autor decidir.

1. **Nome da rodada de abertura do engenheiro.** `plano-de-inicio.md` (versão do
   projeto, itens 6 e 7) fala em `eng_00_contexto` e `eng_00_contexto_v2`; os demais
   documentos e a versão local do plano usam `eng_00_produto`, `eng_00_tecnica` e
   `eng_00_v2`. A versão do projeto está desatualizada.
2. **Carga real do TCC.** `persona-engenheiro.md` diz "de 10 a 20 pessoas";
   `linha-do-tempo.md` (dependências) diz "de 10 a 15 pessoas".
3. **Número de rodadas.** O plano fala em "as 12 rodadas"; a especificação tem seis
   telas; a ordem de execução lista cinco módulos (login, feed, troféus, perfil e
   ranking, mural); o leigo tem abertura mais seis prompts de tela, e o engenheiro tem
   `eng_00`, `eng_00_v2` e as telas, mais as correções `_v2`. A contagem e o que
   conta como rodada: a confirmar com o autor.
4. **Semente.** O diário de 10/10 cita o commit `e32107d`; a semente órfã de 11/10 é
   outra. A versão local da linha do tempo registra `1577ae9` com data de 10/10/2026
   22:59, enquanto o diário diz que a semente órfã foi feita em 11/10. Qual data vale:
   a confirmar com o autor.
5. **Contexto do agente.** O diário de 10/10 fala em "`/context` mostrando só o
   `CLAUDE.md` do repo" e em "o prompt dela mais o `CLAUDE.md`"; isso foi superado em
   11/10 (repositórios vazios). O texto do TCC deve seguir 11/10.
6. **Fase 11 da linha do tempo.** Ainda menciona "3.1 (contexto comum, um agente)" e
   "3.3 (Análise Comparativa)"; o contexto comum como arquivo deixou de existir e a
   análise comparativa vai para o capítulo 5.
7. **Política de reação e prompts de tela do leigo.** `persona-leigo.md` e o plano
   dizem que a abertura e os seis prompts de tela são escritos antes do piloto; a
   pasta `prompts/leigo/` só tem `leigo_00_abertura.md`. Se o piloto do leigo já
   rodou, os prompts de tela foram escritos depois dele: a confirmar com o autor.
8. **Modo de permissão.** O protocolo e as regras falam em responder perguntas e
   aprovar, mas a linha do tempo local fixa "auto mode" (o agente executa sem pedir
   aprovação a cada ação). O protocolo deve registrar o modo.
9. **Rubrica, eixo Código, nota 3.** Cita "o exemplo de teste da seção 3.2", que é o
   `calcularTierAluno` da entrega parcial, substituído segundo o plano.
10. **Cópias no projeto.** `diario-do-experimento.md`, `linha-do-tempo.md` e
    `plano-de-inicio.md` no projeto do claude.ai estão atrás das versões locais.

## 8 Itens a confirmar com o autor

1. Modelo de documento, limite de páginas e forma de entrega de apêndices digitais
   exigidos pela UniMax.
2. Conteúdo exato das seções 1 e 2 da entrega parcial que será aproveitado.
3. Aprovação do título e dos objetivos novos pelo orientador.
4. Consentimento, data e meio de coleta da pesquisa com 28 respondentes; necessidade
   de comitê de ética.
5. Estado da rodada `leigo_00_abertura` e dos seis prompts de tela do leigo.
6. O que é `eng_00_produto-r2.md`.
7. Como tratar o `--resume` da `eng_00` (desvio declarado ou regra nova no protocolo).
8. Referência de UX para a trilha do leigo.
9. Regra de estilo sobre nome e versão do modelo.
10. Se entram na §3.4 as três ameaças novas (nome da pasta revela a trilha, repos
    dentro da pasta `tcc`, avaliação sem cegamento).
11. **Urgente: transcrições da `eng_00`.** O protocolo registra que as transcrições
    automáticas são apagadas depois de `cleanupPeriodDays` (padrão: 30 dias), e o
    `/export` é a cópia que vale. O `/export` em texto não deve trazer o uso de
    tokens por mensagem; se o custo em tokens for comparado entre condições, vale
    copiar o `.jsonl` da sessão `eng_00` (iniciada em 12/10) antes do prazo ou aumentar
    `cleanupPeriodDays`, e incluir a cópia do `.jsonl` no protocolo de todas as
    rodadas. Conferir na documentação do Claude Code como a contagem de dias é feita.
