# Prompts de design (trilha do engenheiro, passo 1)

Registro de todo prompt usado para produzir a identidade visual e os mockups das seis
telas (Claude Design ou Figma), na ordem em que foram enviados, com data e tempo gasto.
É trabalho da persona do engenheiro fora do agente do experimento, e por isso entra no
TCC como custo e como evidência do fluxo (identidade visual antes de qualquer prompt
de código). Os mockups exportados ficam nesta pasta como PNG (`login.png`, `feed.png`,
`perfil.png`, `mural.png`, `trofeus.png`, `ranking.png`) e são anexados nas rodadas por
tela da trilha `engenheiro`. A trilha `leigo` não recebe estes arquivos.

Regra de registro: o prompt vai como foi enviado, sem correção; ajustes viram um novo
prompt numerado. Anotar o que foi aceito, o que foi refeito e quanto tempo levou.

## Bloco de consistência (colar junto com todo prompt)

Rascunho a partir de `docs/especificacao-telas.md` e do `CLAUDE.md` comum, a validar
pelo autor antes do primeiro prompt.

```
REGRAS DE CONSISTÊNCIA: estes mockups são telas do mesmo app e os dados devem bater
entre todas.

- Produto: Maxx, app de engajamento acadêmico gamificado da rede UniEduk (UniMax e
  UniFaj). Logo MAXX no topo. Tema claro e tema escuro.
- Navegação inferior fixa: Home (feed), Busca, Mural (botão central, ícone de
  jornal), Troféus, Perfil.
- Tiers de prêmio e pontos: Bronze 1 a 30, Prata 31 a 70, Ouro 71 a 100, Diamante
  101 a 150. Aluno não tem tier; ranking é posição numérica.
- Progressão: a mesma conquista repetida rende um novo prêmio de tier acima do
  anterior. Exemplo demo: "Média 10 em uma matéria" (Bronze 5 pts no 1º semestre,
  Prata 35 pts no 2º, Ouro 75 pts no 3º; próximo: Diamante). A tela de troféus
  mostra a trilha de cada conquista, com os tiers obtidos e o próximo.
- Login: somente e-mail institucional ou RA. Sem botões de login social.
- Alunos demo: Ana Souza (RA 2023001, ADS 3º semestre, 15.020 pts, #29 no geral),
  João Lima (RA 2022110, Engenharia de Produção 5º semestre, 9.870 pts, #112),
  Maria Costa (RA 2023045, Psicologia 2º semestre, 21.400 pts, #4),
  Pedro Alves (RA 2021088, ADS 7º semestre, ex-aluno, 18.300 pts, #15, não pontua mais).
- Professores demo: Prof. Carla Mendes (ADS), Prof. Ricardo Nunes (Engenharia).
- Prêmios demo: troféu "Techday 2026" (Ouro, 80 pts, Raro), troféu "Assiduidade
  semestral" (Prata, 50 pts, Comum), troféu "Top 2% Integrativa" (Ouro, 95 pts,
  Raro), medalha "Participação no seminário" (Prata, 40 pts, Comum, dada por
  professor), medalha "Apresentação de TCC" (Diamante, 120 pts, Épico), troféu de
  acúmulo "10 medalhas" (Bronze, 25 pts, Comum), troféu "Pássaro Raro no Campus"
  (Diamante, 150 pts, Lendário, exige foto).
- Mural demo: aviso da Faculdade "Matrícula do 2º semestre até 30/07" (não lido),
  aviso do Curso ADS "Techday: inscrições abertas", aviso da Prof. Carla "Prova
  integrativa remarcada para 14/08". Bolinha amarela em não lido.
- Feed demo: post da Ana com foto e selo "Pássaro Raro no Campus" (troféu), 128
  curtidas, 12 comentários; post do João com selo "Techday 2026".
- Rankings: Geral, Por curso, All-time geral, All-time por curso.
- Datas: semestre 2/2026.
```

## Prompts

### D01 · 2026-09-26 · Identidade visual e as seis telas (abertura, Claude Design)

Anexos enviados junto: logo MAXX e logo UniMax com paleta e pills de tier (print do
Figma), telas prontas de login e feed (claro e escuro), rascunhos do caderno
(login/cadastro, mural, filosofia e dashboard) e wireframes do Excalidraw (perfil com
referência do Instagram, mural, troféus).

Prompt como enviado:

```
Quero fechar a identidade visual e as seis telas de um aplicativo mobile chamado MAXX.

O que é: uma rede social gamificada para alunos e professores da UniMax (Indaiatuba),
inspirada no Instagram, mas com menos peso em posts comuns e mais peso em conquistas.
Existem dois tipos de prêmio. Troféus são dados pela instituição ou por regras
automáticas: presença de 100% no semestre, participação em techday, olimpíadas e
feiras, ou conquistas do dia a dia com foto de prova, como fotografar um pássaro raro
no campus. Medalhas são dadas por professores: nota 10 em um trabalho, participação
em aula. Cada prêmio tem um tier, Bronze, Prata, Ouro ou Diamante, que define quantos
pontos ele vale. Algumas conquistas têm progressão: a mesma conquista repetida (média
10 em uma matéria, em semestres diferentes) rende um novo prêmio de tier acima do
anterior, valendo mais pontos. O aluno acumula prêmios e aparece em rankings; o aluno
não tem tier, só posição.

Público: alunos e professores da faculdade. Login somente por e-mail
institucional ou RA, sem nenhum login social; a tela de login atual tem botões de
Facebook, Twitter e Google e eles devem sair.

Identidade: em anexo vão o logo MAXX, o logo da UniMax, os pills de tier e duas telas
já feitas (login e feed). a paleta azul-marinho e dourado são as cores
atuais do logo da UniMax, e quero tema claro e tema escuro em toda tela. O design
pattern do sistema (tipografia, espaçamento, cards, botões, estados) eu quero que
você proponha, coerente com essas duas telas mas podendo ter alguns outros tons que você julgar pertinentes para a UI e UX. Navegação inferior fixa com cinco itens:
Home (feed), Busca, Mural (botão central, ícone de jornal), Troféus, Perfil.

Entrega: seis telas mobile (390 x 844), uma por mensagem, nesta ordem: perfil, mural,
troféus e medalhas, rankings, e por fim a padronização de login e feed no pattern que
você propuser. Os rascunhos em anexo mostram a mecânica de cada tela; siga o que
está neles e resolva o que estiver em aberto de forma consistente com o resto. Use os
dados de exemplo abaixo em todas as telas, para elas baterem entre si.

REGRAS DE CONSISTÊNCIA (valem para todas as telas)
- Produto: MAXX, app da rede UniEduk (UniMax e UniFaj). Logo MAXX no topo.
- Tiers e pontos: Bronze 1 a 30, Prata 31 a 70, Ouro 71 a 100, Diamante 101 a 150.
- Progressão demo: "Média 10 em uma matéria": Bronze 5 pts (1º semestre), Prata 35
  pts (2º), Ouro 75 pts (3º), próximo Diamante. A tela de troféus mostra a trilha de
  cada conquista, com os tiers obtidos e o próximo.
- Alunos demo: Ana Souza (RA 2023001, ADS 3º semestre, 15.020 pts, #29 no geral);
  João Lima (RA 2022110, Engenharia de Produção 5º semestre, 9.870 pts, #112);
  Maria Costa (RA 2023045, Psicologia 2º semestre, 21.400 pts, #4); Pedro Alves
  (RA 2021088, ADS 7º semestre, ex-aluno, 18.300 pts, #15, não pontua mais).
- Professores demo: Prof. Carla Mendes (ADS), Prof. Ricardo Nunes (Engenharia).
- Prêmios demo: troféu "Techday 2026" (Ouro, 80 pts, Raro); troféu "Assiduidade
  semestral" (Prata, 50 pts, Comum); troféu "Top 2% Integrativa" (Ouro, 95 pts,
  Raro); medalha "Participação no seminário" (Prata, 40 pts, Comum, dada pela
  Prof. Carla); medalha "Apresentação de TCC" (Diamante, 120 pts, Épico); troféu de
  acúmulo "10 medalhas" (Bronze, 25 pts, Comum); troféu "Pássaro Raro no Campus"
  (Diamante, 150 pts, Lendário, exige foto).
- Mural demo: aviso da Faculdade "Matrícula do 2º semestre até 30/07" (não lido,
  bolinha amarela); aviso do curso ADS "Techday: inscrições abertas"; aviso da
  Prof. Carla "Prova integrativa remarcada para 14/08". O mais recente fica
  semi-expandido; os outros mostram só o título.
- Feed demo: post da Ana com foto e selo "Pássaro Raro no Campus" (troféu), 128
  curtidas, 12 comentários; post do João com selo "Techday 2026".
- Rankings: Geral, Por curso, All-time geral, All-time por curso.
- Semestre 2/2026.

Comece pelo perfil.
```

Nota do autor sobre o texto: rascunho revisado no Cowork contra a documentação
oficial do Claude Design antes do envio; o autor retirou a faixa etária do público e
reescreveu o trecho da paleta (sugere azul-marinho e dourado por serem as cores do
logo da UniMax, mas deixa o design pattern e tons complementares a cargo da
ferramenta). Quatro mudanças de conteúdo em relação à primeira versão: progressão de
prêmios descrita como regra (entrou no contexto comum no mesmo dia), login só
institucional (botões sociais do mockup devem sair), vocabulário troféu x medalha
alinhado ao contexto comum, e entrega explícita (seis telas, uma por mensagem, ordem
definida).

Resultado (canvas "MAXX", 26/09): o Design entregou três pranchetas de uma vez: Perfil
claro, Perfil escuro e uma prancheta "Padrão visual" (proposta v1). Padrão proposto:

- Cores, tema claro: fundo #FFFFFF, superfície #F0F3F8, linha #DCE2EB, marinho de
  ação #022D57, texto #0B1D33, texto 2 #4D5B70, dourado de marca #FAB301, dourado
  para texto #8A5A00, link #2F6FBF. Tema escuro: fundo #022D57, superfície #0A3867,
  linha #1D5188, dourado de ação #FAB301, texto #F2F5FA, texto 2 #A8B8CE, link
  #8DBBEE. Curtida e erro #E0243A.
- Tipografia: Archivo semi-expandida para números, nomes e títulos (dialoga com o
  logo); Instrument Sans para o resto. Escala: display 28/32, título 20/24, seção
  16/22, corpo 14/20, legenda 13/18, rótulo 11/14.
- Tiers e raridade: o tier é a única coisa colorida (gradientes bronze, prata, ouro,
  diamante, como os pills do Figma); a raridade é neutra, pontos de 1 a 4 (Comum,
  Raro, Épico, Lendário). Ícone de troféu para troféu, de medalha para medalha.
- Botões em pill (primário marinho, secundário superfície, no escuro primário
  dourado), estados padrão, pressionado, foco e desativado; filtros do mural como
  chips; bolinha dourada de não lido.
- Espaçamento 4/8/12/16/24/32 (margem 16); raios 8 (selo, avatar mini), 12 (campo,
  aviso), 16 (card), pill (botão, tier). Sem sombra em cards (profundidade por
  superfície tonal); sombra só no botão central do Mural; alvos de toque de 44 px.
- Perfil: avatar com anel dourado; bloco "pts · #29" clicável para os rankings;
  seguidores e seguindo; nome, curso, semestre e RA; bio; card "Último troféu" com
  tier e raridade; "Seguida por João Lima e Maria Costa"; botões Editar perfil e
  Compartilhar; abas Tudo, Troféus, Medalhas (acréscimo do Design, não estava no
  rascunho); grade 3 colunas misturando foto e prêmios; navegação inferior com o
  Mural como botão central elevado. Dados do bloco de consistência respeitados.

Pendências para o D02: a última linha da grade fica escondida atrás da navegação na
prancheta de 844 px (falta um respiro no fim da lista); decidir se as abas do perfil
ficam; o menu hambúrguer no topo substitui o "status" do rascunho.

Tempo: incluído no total do passo 1 (ver Fechamento).

## Anexos usados nos prompts (identificador e procedência)

| ID | Arquivo | Origem | Usado em |
|---|---|---|---|
| A01 | logo MAXX (dourado e branco) | autor, Figma | D01, D02, D03 |
| A02 | logo UniMax e paleta marinho e dourado com pills de tier | autor, Figma | D01, D02 |
| A03 | login claro e escuro | autor, Figma (ago/2026) | D01, D02, D03 |
| A04 | feed claro e escuro | autor, Figma (ago/2026) | D01, D02, D03 |
| A05 | rascunhos do caderno (login e mural; filosofia e dashboard) | autor, caderno | D01, D02, D03 |
| A06 | wireframes Excalidraw (perfil com referência do Instagram, mural, troféus) | autor, Excalidraw | D01, D02, D03 |
| A07 | prancheta "Padrão visual v1" | gerado, canvas 1, resultado do D01 | D02 |
| A08 | tela de conquistas (medalhões metálicos, trilha de progressão) | gerado, canvas 3 | D05 |
| A09 | login e cadastro (bloco marinho e card sobreposto) | gerado, canvas 3 | D05 |
| A10 | feed com card descritivo do prêmio abaixo da foto | gerado, canvas 3 | D05 |
| A11 | design system "Marinho & Ouro, institucional, metal de verdade": `anexos/A11-marinho-ouro-tokens.json` (paleta, tipografia, espaçamento e raios em valores) e `anexos/A11-marinho-ouro-README.md` (regras de uso) | gerado, artefato "MAXX · exploração de identidade 3" (tipo Design System), resultado do D03/D04 | D05 |

Os arquivos ficam em `docs/referencias-visuais/anexos/` com o ID no nome
(`A08-conquistas-canvas3.png`). Anexo gerado por IA é reaproveitado como referência
com a origem anotada; nunca é apresentado como mockup do autor.

## Sessões (canvases) e prompts

Quatro sessões do Claude Design, em paralelo, com propósitos diferentes. O design
final saiu do canvas 1, que recebeu de volta o melhor de cada uma das outras.

| Canvas | Propósito | Prompts | Resultado aproveitado |
|---|---|---|---|
| 1 | Modelo propõe o padrão visual a partir da identidade do autor | D01, D05, D06 | Padrão v1, perfil; depois a convergência final (12 telas + cadastro + padrão) |
| 2 | Padrão fixo por valores e regra "na dúvida, o componente do Instagram" | D02 | Seis telas de referência para a regra do Instagram (botões baixos, grade sem legenda, abas só com ícone) |
| 3 | Exploração de identidade que virou um design system publicado ("MAXX · exploração de identidade 3", com README, tokens e as sete telas como componentes) | D03 | Medalhões metálicos, card do prêmio abaixo da foto, estilo de login e cadastro; a paleta Marinho & Ouro em valores |
| 4 | Exploração livre: três direções de design system, sem cores fixadas | D04 | Paleta "Marinho & Ouro, institucional, metal de verdade" |

### D02 · 2026-09-26 · Canvas 2: seis telas com padrão fixo e regra do Instagram

Texto como enviado: (a confirmar pelo autor; rascunho do Cowork abaixo)

```
Quero as seis telas de um aplicativo mobile chamado MAXX, com identidade e padrão
visual já decididos. Não proponha outro padrão; aplique este.

O que é: uma rede social gamificada para alunos e professores da UniMax (Indaiatuba).
A referência de UX é o Instagram: em toda tela, na dúvida entre um componente de app
e o equivalente do Instagram, use o do Instagram (botões de perfil baixos e
secundários, grade sem legendas e sem fundo, abas só com ícone, cabeçalho com nome
de usuário, cards de post, comentários). A identidade MAXX entra pela cor, pelos
tiers e pela navegação, não por componentes maiores ou mais coloridos.

Regras do produto: troféus são dados pela instituição ou por regras automáticas
(presença, techday, olimpíadas, feiras, conquistas com foto de prova); medalhas são
dadas por professores. Cada prêmio tem um tier, Bronze, Prata, Ouro ou Diamante, que
define os pontos. Algumas conquistas têm progressão: a mesma conquista repetida rende
um novo prêmio de tier acima do anterior. O aluno acumula prêmios e aparece em
rankings; o aluno não tem tier, só posição. Login somente por e-mail institucional
ou RA, sem login social.

Padrão visual (fixo, ver print em anexo):
- Tema claro: fundo #FFFFFF, superfície #F0F3F8, linha #DCE2EB, marinho de ação
  #022D57, texto #0B1D33, texto secundário #4D5B70, dourado de marca #FAB301,
  dourado em texto #8A5A00, link #2F6FBF. Tema escuro: fundo #022D57, superfície
  #0A3867, linha #1D5188, dourado de ação #FAB301, texto #F2F5FA, texto secundário
  #A8B8CE, link #8DBBEE. Curtida e erro #E0243A.
- Tipografia: Archivo semi-expandida para números, nomes e títulos; Instrument Sans
  para o resto. Display 28/32, título 20/24, seção 16/22, corpo 14/20, legenda
  13/18, rótulo 11/14.
- Tier é a única coisa colorida (gradientes bronze, prata, ouro, diamante, como os
  pills em anexo); raridade é neutra, pontos de 1 a 4 (Comum, Raro, Épico,
  Lendário). Ícone de troféu para troféu, de medalha para medalha.
- Espaçamento 4/8/12/16/24/32, margem 16; raios 8 (selo, avatar), 12 (campo,
  aviso), 16 (card), pill só em tier e no botão de login. Sem sombra em cards;
  sombra só no botão central do Mural. Áreas de toque de 44 px, sem inflar o
  tamanho visual dos componentes.
- Navegação inferior fixa: Home (feed), Busca, Mural (botão central, ícone de
  jornal), Troféus, Perfil.

Entrega: as seis telas, 390 x 844, cada uma em tema claro e escuro, uma prancheta
por tela e tema, nesta ordem: login, feed, perfil, mural, troféus e medalhas,
rankings. Login e feed já existem (anexos) e só precisam entrar no padrão; no login,
remover os botões de login social. As outras quatro seguem os rascunhos em anexo.
Deixe um respiro no fim de toda lista ou grade para nada ficar atrás da navegação.
Use os dados abaixo em todas as telas. Não pergunte antes de gerar; decida e
registre as suposições na resposta.

[bloco de consistência, igual ao do D01, com os acréscimos: usuário ana.souza,
1.234 seguidores, 231 seguindo; último troféu da Ana: Pássaro Raro no Campus;
filtros do mural; lista de ranking com a Ana em destaque]
```

Resultado: doze pranchetas (seis telas, claro e escuro) numa só resposta. Perfil
corrigido para o padrão do Instagram (nome de usuário no cabeçalho, botões baixos e
secundários, abas só com ícone, grade sem legenda), mural fiel ao rascunho, trilha
de progressão legível na tela de troféus, rankings com lacunas comprimidas. Problemas
apontados: quatro números na linha do avatar não cabiam em 390 px; última aba dos
rankings cortada; avatares quadrados (o Instagram usa círculo).

### D03 · 2026-09-26 · Canvas 3: exploração de identidade (design system)

Texto como enviado: (a confirmar pelo autor)

Resultado: um artefato do tipo Design System, "MAXX · exploração de identidade 3",
com README, `tokens.json` e as sete telas (login, feed, perfil, mural, troféus,
medalhas, rankings) em claro e escuro. O que foi aproveitado no canvas 1: medalhões
metálicos (gradiente base, brilho e sombra por tier, com o glifo em tom escuro);
raridade como ornamento em volta do medalhão, na cor primária, nunca na cor do
tier (sem anel, anel simples, anel duplo, anel com raios); card descritivo do
prêmio abaixo da foto do post; login e cadastro com faixa marinho no topo, card
sobreposto com abas, primeiro acesso pelo Portal UniMax e rodapé da rede. A paleta
está em valores em `anexos/A11-marinho-ouro-tokens.json`: claro com fundo #FFFFFF,
superfície #F3F5F9, linha #DDE3EC, texto #0B1B33, texto secundário #52627A, primário
#0B2A55, acento #F5B400, destaque #FFF3CC, link #1D4F9C; escuro com fundo #06142A,
superfície #0D2142, linha #1E355A, texto #F1F4F9, texto secundário #9FB1CA, primário
#F5B400 (texto sobre ele #0B1B33), link #8DB8F2; tiers bronze #C07A3E, prata
#A5AEB8, ouro #E8AE00, diamante #56C2E6, cada um com variantes de brilho, sombra e
texto. Tipografia dessa exploração: Archivo ExtraBold itálico para títulos e
números, Figtree para o resto (o canvas 1 manteve Instrument Sans no corpo).

### D04 · 2026-09-26 · Canvas 4: exploração livre em três direções

Texto como enviado: (a confirmar pelo autor; rascunho do Cowork: prompt "Quero
explorar a identidade visual..." com duas etapas, três direções de design system
com perfil e feed aplicados, sem cores fixadas, bloco de consistência igual ao D02)

Resultado aproveitado: a direção "Marinho & Ouro, institucional, metal de verdade"
(paleta e intenção: "a UniMax entrega o prêmio; o marinho dá confiança, o ouro
aparece só onde há conquista, e os selos são medalhões metálicos como os de uma
colação"). As demais direções foram descartadas.

### D05 · 2026-09-26 · Canvas 1: convergência

Texto como enviado: (a confirmar pelo autor; rascunho do Cowork "Fechando o design
hoje..." com seis itens: paleta Marinho & Ouro no lugar da v1; tiers como
medalhões metálicos; selo do prêmio no cabeçalho do post mais card descritivo abaixo
da foto; login e cadastro no estilo do canvas 3, sem login social; posição no
ranking ao lado do nome de usuário; navegação com a tela atual marcada e bolinhas
de notificação)

Resultado: doze pranchetas refeitas na paleta nova, mais duas de cadastro e a
prancheta "Padrão visual" atualizada. Desvio observado: o círculo elevado da
navegação virou indicador de tela ativa e passou a mudar de lugar (Home no feed,
Troféus na tela de troféus), em vez de o Mural ficar fixo no centro; filtros do
mural todos marcados por padrão; selo do prêmio no cabeçalho do post cortando a
linha de curso e semestre; última aba dos rankings cortada.

### D06 · 2026-09-27 · Canvas 1: ajustes finais e exportação

Texto como enviado: (a confirmar pelo autor; rascunho do Cowork com três ajustes:
Mural como único botão elevado e fixo; filtros do mural como fileira leve com
"Todos"; selo do prêmio numa segunda linha do cabeçalho do post e abas dos rankings
com rótulos curtos)

Resultado: (a preencher). Exportação: (lista de PNGs).

## Fechamento do passo 1

- Sessões: 4. Prompts de abertura ou de convergência: 6 (D01 a D06), mais
  comentários inline não registrados individualmente: (quantidade, a preencher).
- Tempo do autor: cerca de 6 horas nas sessões de design (26 e 27/09/2026), incluindo
  preparação de anexos, comparação entre canvases e exportação; mais 3 a 4 horas nos
  rascunhos manuais feitos antes (caderno e Excalidraw, agosto de 2026), para
  colocar a ideia no papel. Total do passo 1: entre 9 e 10 horas. Os tempos por
  prompt não foram medidos individualmente.
- Entregáveis: `docs/referencias-visuais/*.png` (login, cadastro, feed, perfil,
  mural, trofeus, ranking, cada um em claro e escuro) e `padrao-visual.png`.
- Decisões de produto que nasceram no design e entraram no contexto comum antes de
  qualquer rodada: progressão de prêmios; login somente institucional. Decisões que
  ficaram só no design do engenheiro (escopo emergente da persona, a registrar na
  análise): abas do perfil (tudo, troféus, medalhas); filtro "quem eu sigo" nos
  rankings; log de leitura do mural ("quem publicou vê que você leu e quando");
  raridade como pontos neutros de 1 a 4; posição no ranking ao lado do nome.
