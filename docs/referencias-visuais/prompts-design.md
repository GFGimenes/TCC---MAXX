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

### D1.1 · 2026-09-26 · Canvas 1, abertura: identidade visual e as seis telas

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
| A01 | logo MAXX (dourado e branco) | autor, Figma | D1.1, D2.1, D3.1 |
| A02 | logo UniMax e paleta marinho e dourado com pills de tier | autor, Figma | D1.1, D2.1 |
| A03 | login claro e escuro | autor, Figma (ago/2026) | D1.1, D2.1, D3.1 |
| A04 | feed claro e escuro | autor, Figma (ago/2026) | D1.1, D2.1, D3.1 |
| A05 | rascunhos do caderno (login e mural; filosofia e dashboard) | autor, caderno | D1.1, D2.1, D3.1 |
| A06 | wireframes Excalidraw (perfil com referência do Instagram, mural, troféus) | autor, Excalidraw | D1.1, D2.1, D3.1 |
| A07 | prancheta "Padrão visual v1" | gerado, canvas 1, resultado do D1.1 | D2.1 |
| A08 | tela de conquistas (medalhões metálicos, trilha de progressão) | gerado, canvas 3 | D1.3 |
| A09 | login e cadastro (bloco marinho e card sobreposto) | gerado, canvas 3 | D1.3 |
| A10 | feed com card descritivo do prêmio abaixo da foto | gerado, canvas 3 | D1.3 |
| A11 | design system "Marinho & Ouro, institucional, metal de verdade": `anexos/A11-marinho-ouro-tokens.json` (paleta, tipografia, espaçamento e raios em valores) e `anexos/A11-marinho-ouro-README.md` (regras de uso); o print "fase 2a Marinho & Ouro" | gerado, canvas 3 (artefato "MAXX · exploração de identidade 3", tipo Design System), resultado de D3.1 a D3.4 | D1.3 |
| A12 | tiers e raridade com menos brilho; fundo dos prêmios sem foto na grade do perfil | gerado, canvas 3 | D1.4 |
| A13 | login escuro (modelo) | gerado, canvas 3 | D1.6 |
| A14 | dois prints da barra de navegação do Instagram (ícone ativo sobre realce arredondado) | autor, print do celular; usado só na revisão do rascunho no Cowork, não anexado no Claude Design | D1.8 |

Os arquivos ficam em `docs/referencias-visuais/anexos/` com o ID no nome
(`A08-conquistas-canvas3.png`). Anexo gerado por IA é reaproveitado como referência
com a origem anotada; nunca é apresentado como mockup do autor.

## Sessões (canvases) e prompts

Três sessões do Claude Design, em paralelo, com propósitos diferentes. O design final
saiu do canvas 1, que recebeu de volta o melhor das outras duas. Os textos abaixo
foram recuperados pedindo a cada sessão a lista dos prompts enviados, na ordem, e
conferidos pelo autor. Comentários inline nas pranchetas: nenhum registrado pelas
sessões.

| Canvas | Artefato | Propósito | Prompts | Aproveitado no resultado final |
|---|---|---|---|---|
| 1 | "MAXX" (Design) | O modelo propõe o padrão visual a partir da identidade do autor; depois recebe a convergência e, após o fechamento, a correção da navegação | D1.1 a D1.8 | Tudo: 14 pranchetas (7 telas, claro e escuro) e o padrão visual |
| 2 | "MAXX" (Design) | Padrão fixo por valores e regra "na dúvida, o componente do Instagram" | D2.1 e D2.2 | Referência da regra do Instagram (botões baixos, grade sem legenda, abas só com ícone, nome de usuário no cabeçalho) |
| 3 | "MAXX · exploração de identidade 3" (Design System) | Exploração livre em três direções, sem cores fixadas | D3.1 a D3.4 | Paleta Marinho & Ouro em valores; medalhões metálicos; raridade como ornamento; card do prêmio abaixo da foto; estilo de login e cadastro |

O D1.1 está registrado acima. Os demais seguem como enviados.

### D1.2 · 2026-09-26 · Canvas 1: as outras cinco telas no padrão v1 (sem imagens)

```
Aprovo o padrão visual v1. Agora quero as outras cinco telas no mesmo padrão, para
fechar o conjunto: login, feed, mural, troféus e medalhas, rankings. Cada uma em tema
claro e escuro, 390 x 844, uma prancheta por tela e tema.

Ajustes que valem para todas as telas, inclusive o perfil já feito:
- A referência de UX é o Instagram. Botões menores e discretos: secundários com 32 px
  de altura, raio 8, texto 13; a área de toque de 44 px fica na área clicável, não no
  tamanho visual. Pill só nos selos de tier e no botão de entrar do login.
- Grades e listas terminam com um respiro para nada ficar atrás da navegação.
- Avatares redondos, com anel dourado no perfil.

Por tela:
- Login: entrar e cadastrar, RA ou e-mail institucional e senha, esqueci minha senha,
  sem botões de login social; aviso de que o primeiro acesso é pelo Portal do Aluno.
- Feed: posts como no Instagram (cabeçalho com avatar, nome de usuário, curso e
  semestre, selo do prêmio, foto, curtir, comentar, compartilhar, salvar, curtidas,
  legenda, comentários, tempo). Post da Ana com o Pássaro Raro no Campus e post do
  João com o Techday 2026.
- Mural: filtros Faculdade, Curso e Professores no topo, botão "ler todos"; o aviso
  mais recente semi-expandido, os demais só com título; bolinha dourada em não lido;
  ao tocar no semi-expandido, abre quase em tela cheia com botão de voltar.
- Troféus e medalhas: abas Troféus e Medalhas, filtro "mostrar não obtidos"; cada
  item com nome, tier, pontos e raridade; a trilha de progressão de "Média 10 em uma
  matéria" com Bronze, Prata e Ouro obtidos e Diamante como próximo.
- Rankings: Geral, Por curso, All-time geral, All-time por curso; lista com posição,
  avatar, nome, curso e pontos, a Ana em destaque na posição #29, o Pedro marcado como
  ex-aluno.

Use os mesmos dados de exemplo que já mandei. Não pergunte antes de gerar; decida e
registre as suposições na resposta.
```

Resultado: as cinco telas no padrão v1, claro e escuro, com os botões do perfil
reduzidos ao padrão do Instagram.

### D1.3 · 2026-09-26 · Canvas 1: convergência (anexos A08, A09, A10, A11)

Observação: o texto foi enviado com o marcador "[cole aqui a lista de cores...]" sem
preenchimento; a paleta chegou ao modelo pelo print A11, não por valores. O rascunho
original começava com "Fechando o design hoje.", frase retirada pelo autor.

```
Aplique tudo abaixo em todas as pranchetas já feitas (as seis
telas, claro e escuro) e atualize a prancheta "Padrão visual" para refletir o
resultado. O que não está listado fica como está.

1. Paleta. Substitua a paleta v1 pela direção "Marinho & Ouro, institucional, metal
   de verdade" (anexo/valores abaixo), nos dois temas. Mantenha os papéis de cada
   cor (fundo, superfície, linha, ação, texto, texto secundário, link, curtida e
   erro) e refaça o contraste onde precisar.
   [cole aqui a lista de cores da direção, com os hexadecimais, se tiver]

2. Tiers como metal de verdade. Refaça os selos de tier como no print de
   conquistas em anexo: medalhão redondo com gradiente metálico radial (brilho no
   alto, sombra embaixo), anel externo fino, ícone de troféu ou medalha em tom
   escuro dentro. Bronze, prata e ouro metálicos; diamante em azul-gelo com brilho
   branco. Use o mesmo medalhão em todo lugar em que o tier aparece: lista de
   troféus, grade e destaques do perfil, selo do feed e trilha de progressão. Na
   trilha de progressão, os medalhões obtidos ligados por uma linha, e o próximo
   tier como medalhão tracejado com cadeado, mostrando a faixa de pontos.

3. Feed. Mantenha o selo com o nome do prêmio no cabeçalho do post, ao lado do
   nome, e acrescente, logo abaixo da foto e acima das curtidas, o card descritivo
   como no print em anexo: medalhão do tier à esquerda, nome do prêmio, "tier ·
   raridade" embaixo e, à direita, "+150" com "foto validada" quando o prêmio
   exigir foto. Vale para os dois posts (Pássaro Raro no Campus e Techday 2026).

4. Login e cadastro no estilo do print em anexo: bloco marinho no topo com o logo
   MAXX e a frase "A rede de conquistas da UniMax"; card branco sobreposto ao bloco,
   com as abas Entrar e Cadastrar; campos "RA ou e-mail institucional" e "Senha"
   com mostrar senha; "Esqueci minha senha" alinhado à direita; botão primário
   "Entrar" (marinho no claro, dourado no escuro); abaixo, "Primeiro acesso? Alunos
   e professores vinculam a conta pelo Portal UniMax com o RA"; rodapé com o selo
   da UniMax e "Rede UniEduk · UniMax e UniFaj". Sem nenhum login social. Se couber,
   uma prancheta extra com a aba Cadastrar ativa.

5. Posição no ranking ao lado do nome de usuário: onde o nome aparece com curso e
   semestre (cabeçalho do post, perfil, rankings), acrescente "#29" discreto, em
   texto secundário, na mesma linha.

6. Navegação inferior. O ícone da tela atual é o que fica marcado (preenchido, cor
   de texto); hoje todas as telas marcam o Mural. O botão central do Mural continua
   elevado, mas só aparece ativo na tela do Mural. Bolinha pequena, dourada, no
   canto superior direito do ícone com novidade: nas pranchetas, no Mural (aviso
   não lido) e nos Troféus (prêmio novo).

Mantenha: botões baixos e secundários, avatares redondos com anel dourado no
perfil, grade sem legenda, respiro no fim das listas, os mesmos dados de exemplo em
todas as telas. Não pergunte antes de gerar; decida e registre as suposições na
resposta.
```

Resultado: doze pranchetas refeitas na paleta nova, mais duas de cadastro e a
prancheta "Padrão visual" atualizada.

### D1.4 · 2026-09-26 · Canvas 1: correção em linguagem do autor (anexo A12)

```
Nos premios, pode usar menos brilho/metalico, estou te mandando outro print E esse efeito que você concentrou no icon do mural, é pra estar no que esta aberto, dele ficar maior esse icone. estou te mandando também o estilo de fundo dos premios no perfil quando não tiverem foto
```

Resultado: medalhões com menos brilho; o círculo elevado da navegação passou a
marcar a tela aberta (Home no feed, Troféus na tela de troféus), o que o autor
reverteu no D1.5; fundo em gradiente suave do tier nas células da grade do perfil
sem foto. Este prompt é o único do passo 1 escrito inteiramente pelo autor, sem
rascunho do Cowork, e mostra o registro real da persona quando corrige: curto,
direto, com print, sem termo técnico.

### D1.5 · 2026-09-27 · Canvas 1: ajustes finais (sem imagens)

```
Três ajustes finais e exportar:
1. Navegação: o Mural volta a ser o único botão elevado, fixo no centro, em todas as
   telas. A tela ativa é indicada só pelo ícone preenchido e na cor de texto (e, no
   Mural, pelo preenchimento do círculo). Nada de círculo elevado nos outros itens.
2. Mural: filtros como uma fileira leve, "Todos" ativo por padrão e Faculdade, Curso
   e Professores como chips de contorno, sem ícone de check.
3. Feed: o selo do prêmio no cabeçalho do post vai para uma segunda linha, abaixo do
   nome, para "ADS · 3º semestre · #29" não cortar. Rankings: abas com rótulos curtos
   (Geral, Curso, Histórico, Histórico do curso) para a última não cortar.
```

### D1.6 · 2026-09-27 · Canvas 1: login e cadastro no modelo escuro (anexo A13)

```
Pode mudar a questão do Login/cadastro para esse tipo de modelo
```

Resultado: versão do canvas 1 dada como final em 27/09 (versão `1790468301-6a7f`),
exportada. Reaberta no mesmo dia para a correção da navegação (D1.7 e D1.8).

### D1.7 · 2026-09-27 · Canvas 1: navegação inferior sem botão elevado (sem imagens)

Motivo: ao revisar os PNGs exportados, o autor notou que o botão do Mural, elevado
com sombra e anel em todas as telas (pedido no item 1 do D1.5), parecia o item
selecionado mesmo com outra tela aberta. O D1.7 desfaz esse item do D1.5. Rascunho
revisado no Cowork; a alternativa de manter o botão elevado só quando o Mural está
aberto foi descartada porque mantinha uma regra própria para uma aba.

```
Ajuste na navegação inferior, em todas as 14 telas (claro e escuro) e na prancheta "Padrão visual MAXX".

Problema: o botão do Mural é um círculo elevado com sombra e anel em todas as telas, então parece o item selecionado mesmo quando a tela aberta é outra. No Feed, por exemplo, o Home está preenchido, mas o destaque visual está no círculo do Mural.

O que fazer:

1. Tirar o botão elevado. O Mural vira uma aba igual às outras quatro: mesma altura, mesmo alinhamento, sem círculo, sem sombra, sem anel e sem deslocamento para cima.

2. Uma única regra de estado ativo para as cinco abas: a tela aberta mostra o ícone preenchido na cor ink; as outras mostram o ícone em contorno na cor ink-2. No Perfil, o estado ativo é um anel de 2px em ink em volta do avatar. Aplicar tela por tela: Feed marca Home; Mural marca Mural; Troféus marca Troféus; Perfil marca Perfil. Login e Cadastro não têm navegação.

3. Novidade continua sendo a bolinha dourada pequena no canto superior direito do ícone (Mural com aviso não lido, Troféus com prêmio novo), em qualquer estado, sem mudar o tamanho do ícone.

4. Ordem e ícones não mudam: Home, Busca, Mural (jornal), Troféus (taça), Perfil (avatar). Barra de 84px com borda superior em line, como está.

5. Na prancheta "Padrão visual MAXX", refazer o bloco "Navegação, novidades e forma": remover o par "Mural em outra tela / Mural aberto" e a frase sobre o botão elevado; mostrar os três estados de uma aba (inativa, inativa com novidade, ativa) e a frase nova: "As cinco abas seguem a mesma regra: ícone preenchido em ink na tela ativa, contorno em ink-2 nas outras. Bolinha dourada = novidade."

Manter todo o resto como está. Não mexer em cores, tipografia, cards, selos ou conteúdo das telas.
```

### D1.8 · 2026-09-27 · Canvas 1: realce atrás do ícone ativo, como no Instagram (anexo A14 só no Cowork)

Motivo: depois do D1.7 o autor quis o realce suave atrás do ícone ativo, como na
barra do Instagram (A14). Rascunho revisado no Cowork a partir dos prints.

```
Complemento ao ajuste da navegação inferior, em todas as telas com barra (claro e escuro) e na prancheta "Padrão visual MAXX".

Na aba ativa, além do ícone preenchido em ink, colocar um realce atrás do ícone, como no Instagram: um quadrado de cantos bem arredondados (44 x 44, raio 14) centralizado no ícone, sem sombra projetada, sem borda e sem elevação. Cor do realce: surface no tema claro e line no tema escuro. É um realce discreto, um tom acima do fundo da barra; se no claro ficar fraco demais, escurecer um passo, sem passar de line. O ícone continua com 26px e centralizado dentro do realce.

Abas inativas seguem sem realce: ícone em contorno, cor ink-2.

Na aba Perfil, o estado ativo usa o mesmo realce atrás do avatar, no lugar do anel.

A bolinha dourada de novidade continua no canto superior direito do ícone, por cima do realce quando a aba estiver ativa.

Na prancheta "Padrão visual MAXX", atualizar os três estados da aba (inativa, inativa com novidade, ativa) para mostrar o realce no estado ativo, e completar a frase: "A tela ativa ganha o ícone preenchido em ink sobre um realce arredondado em surface (claro) ou line (escuro). Contorno em ink-2 nas outras. Bolinha dourada = novidade."

Manter todo o resto como está.
```

Resultado (versão `1790471156-05a5`, a final): as cinco abas com a mesma regra;
realce de 44 x 44 e raio 14 em `#E6EAF1` no claro (um passo acima de surface, como
o prompt permitia) e `#1E3560` (line) no escuro; avatar do Perfil sobre o realce,
sem anel; prancheta de padrão com os três estados da aba. Aceito pelo autor sem
novo ajuste. Esta é a versão exportada em `design/canvas-1/` e nos PNGs.

### D2.1 · 2026-09-26 · Canvas 2, abertura: padrão fixo e regra do Instagram (anexos A01 a A07)

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

REGRAS DE CONSISTÊNCIA (valem para todas as telas)
- Produto: MAXX, app da rede UniEduk (UniMax e UniFaj). Logo MAXX no feed e no login;
  no perfil, o nome de usuário no cabeçalho, como no Instagram.
- Tiers e pontos: Bronze 1 a 30, Prata 31 a 70, Ouro 71 a 100, Diamante 101 a 150.
- Progressão demo: "Média 10 em uma matéria": Bronze 5 pts (1º semestre), Prata 35
  pts (2º), Ouro 75 pts (3º), próximo Diamante. A tela de troféus mostra a trilha de
  cada conquista, com os tiers obtidos e o próximo.
- Alunos demo: Ana Souza, usuário ana.souza (RA 2023001, ADS 3º semestre, 15.020
  pts, #29 no geral, 1.234 seguidores, 231 seguindo); João Lima (RA 2022110,
  Engenharia de Produção 5º semestre, 9.870 pts, #112); Maria Costa (RA 2023045,
  Psicologia 2º semestre, 21.400 pts, #4); Pedro Alves (RA 2021088, ADS 7º
  semestre, ex-aluno, 18.300 pts, #15, não pontua mais).
- Professores demo: Prof. Carla Mendes (ADS), Prof. Ricardo Nunes (Engenharia).
- Prêmios demo: troféu "Techday 2026" (Ouro, 80 pts, Raro); troféu "Assiduidade
  semestral" (Prata, 50 pts, Comum); troféu "Top 2% Integrativa" (Ouro, 95 pts,
  Raro); medalha "Participação no seminário" (Prata, 40 pts, Comum, dada pela
  Prof. Carla); medalha "Apresentação de TCC" (Diamante, 120 pts, Épico); troféu de
  acúmulo "10 medalhas" (Bronze, 25 pts, Comum); troféu "Pássaro Raro no Campus"
  (Diamante, 150 pts, Lendário, exige foto). Último troféu da Ana: Pássaro Raro no
  Campus.
- Mural demo: aviso da Faculdade "Matrícula do 2º semestre até 30/07" (não lido,
  bolinha dourada); aviso do curso ADS "Techday: inscrições abertas"; aviso da
  Prof. Carla "Prova integrativa remarcada para 14/08". O mais recente fica
  semi-expandido; os outros mostram só o título. Filtros no topo: Faculdade, Curso,
  Professores.
- Feed demo: post da Ana com foto e selo "Pássaro Raro no Campus" (troféu), 128
  curtidas, 12 comentários; post do João com selo "Techday 2026".
- Rankings: Geral, Por curso, All-time geral, All-time por curso; lista com posição,
  avatar, nome, curso e pontos; a Ana em destaque na posição #29.
- Semestre 2/2026.
```

Resultado: doze pranchetas (seis telas, claro e escuro) numa só resposta, com o
perfil no padrão do Instagram (nome de usuário no cabeçalho, botões baixos e
secundários, abas só com ícone, grade sem legenda), mural fiel ao rascunho, trilha
de progressão legível e rankings com lacunas comprimidas. Problemas apontados na
revisão: quatro números na linha do avatar não cabiam em 390 px; última aba dos
rankings cortada; avatares quadrados.

### D2.2 · 2026-09-26 · Canvas 2: prancheta de padrão visual

```
Adicione uma prancheta "Padrão visual MAXX" (1280 de largura, altura livre) documentando
o sistema que você aplicou nas seis telas, para servir de referência de implementação:

- Cores do tema claro e do tema escuro, com nome, uso e valor hexadecimal (fundo,
  superfície, linha, ação, texto, texto secundário, link, curtida e erro, dourado de
  marca e dourado em texto).
- Tipografia: famílias, pesos e a escala usada (display, título, seção, corpo,
  legenda, rótulo), com um exemplo real de cada, tirado das telas.
- Tiers e raridade: os quatro gradientes de tier com as faixas de pontos, os pontos
  de raridade de 1 a 4, e os ícones de troféu e medalha.
- Componentes como estão nas telas: botões primário e secundário com estados
  (padrão, pressionado, foco, desativado), chips de filtro, selo de tier, card de
  aviso semi-expandido e colapsado, item de ranking, item de troféu, trilha de
  progressão, barra de navegação com o botão central do Mural.
- Espaçamento, raios e regras (respiro no fim das listas, sombras, áreas de toque).
- Uma seção "Desvios e suposições": tudo o que você decidiu que não estava no meu
  prompt (por exemplo, o formato dos avatares e do botão central).

Sem inventar nada novo: a prancheta descreve o que já está nas telas.
```

### D3.1 · 2026-09-26 · Canvas 3, abertura: exploração livre em três direções (anexos A01, A03 a A06; sem o print de paleta e sem o padrão v1, de propósito)

```
Quero explorar a identidade visual de um aplicativo mobile chamado MAXX antes de
fechar o design. Nesta sessão você tem liberdade de propor cores, paleta,
tipografia e design system; quero comparar direções, não receber uma só.

O que é: uma rede social gamificada para alunos e professores da UniMax
(Indaiatuba). A referência de UX é o Instagram: a estrutura das telas, os componentes
e o tamanho das coisas devem lembrar o Instagram (botões de perfil baixos e
discretos, grade sem legendas, abas só com ícone, cards de post, comentários). O
que diferencia o MAXX são as conquistas: troféus, dados pela instituição ou por
regras automáticas (presença, techday, olimpíadas, feiras, conquistas com foto de
prova), e medalhas, dadas por professores. Cada prêmio tem um tier, Bronze, Prata,
Ouro ou Diamante, que define os pontos. Algumas conquistas têm progressão: a mesma
conquista repetida rende um novo prêmio de tier acima. O aluno acumula prêmios e
aparece em rankings; o aluno não tem tier, só posição. Login somente por e-mail
institucional ou RA, sem login social.

Identidade: em anexo, o logo MAXX, o logo da UniMax e duas telas antigas (login e
feed) que mostram a direção anterior. O azul-marinho e o dourado do logo são
referência, não obrigação: você pode propor outra paleta, desde que o logo
conviva bem com ela. Tema claro e escuro em toda tela. Navegação inferior fixa:
Home (feed), Busca, Mural (botão central, ícone de jornal), Troféus, Perfil.

Entrega, em duas etapas:

1. Três direções de design system, uma prancheta cada: paleta clara e escura,
   tipografia, tratamento dos tiers e da raridade, componentes principais (botão,
   chip, selo de tier, card de post, item de lista) e uma frase sobre a intenção da
   direção. Para cada direção, o perfil e o feed aplicados, em tema claro (390 x
   844), para eu comparar as três lado a lado. Se conseguir, também o mural.
2. Depois que eu escolher uma direção, as seis telas completas nela, claro e
   escuro: login, feed, perfil, mural, troféus e medalhas, rankings.

Os rascunhos em anexo mostram a mecânica de cada tela; siga o que está neles e
resolva o que estiver em aberto de forma consistente. Use os dados de exemplo
abaixo em todas as telas. Não pergunte antes de gerar; decida e registre as
suposições na resposta.

[REGRAS DE CONSISTÊNCIA: idênticas às do D2.1]

Comece pela etapa 1.
```

### D3.2 a D3.4 · 2026-09-26 · Canvas 3: continuação, em linguagem do autor

```
Pode seguir com as outras telas, e faz as pranchetas separadas pra eu poder dar zoom
```

```
continue
```

```
Me dê somente os designs do marinho e ouro
```

Resultado do canvas 3: três direções na etapa 1; a "Marinho & Ouro, institucional,
metal de verdade" foi escolhida e a sessão a publicou como design system (README,
`tokens.json`, sete telas em claro e escuro). Ver anexo A11 e a descrição da paleta
na seção de fechamento.

## Fechamento do passo 1

- Sessões: 3 canvases. Prompts: 14 (8 no canvas 1, 2 no canvas 2, 4 no canvas 3).
  Dos 14, 11 partiram de rascunhos revisados no Cowork contra a documentação oficial
  do Claude Design e a especificação das telas, e 3 são texto livre do autor (D1.4,
  D1.6 e as continuações do canvas 3, que somam 3 mensagens curtas: D3.2 a D3.4).
  Comentários inline: nenhum. Dos 14, 2 (D1.7 e D1.8) vieram depois do fechamento
  de 27/09, quando a revisão dos PNGs exportados mostrou que a navegação pedida no
  D1.5 lia errado; o passo 1 foi reaberto e fechado no mesmo dia.
- Tempo do autor: cerca de 6 horas nas sessões de design (26 e 27/09/2026), incluindo
  preparação de anexos, comparação entre canvases e exportação; mais 3 a 4 horas nos
  rascunhos manuais feitos antes (caderno e Excalidraw, agosto de 2026), para
  colocar a ideia no papel. Total do passo 1: entre 9 e 10 horas. Os tempos por
  prompt não foram medidos individualmente. A reabertura para D1.7 e D1.8 não está
  contada; o autor estima o tempo dela.
- Paleta final (canvas 1, "Marinho & Ouro"): claro com fundo #FFFFFF, superfície
  #F3F5F9, linha #DDE2EA, texto #0B1B33, texto secundário #556070, primário #0B2A55,
  dourado #F5B400, dourado em texto #8A6200, link #245AA8, destaque #FFF5D6, curtida
  #E0243A; escuro com fundo #06142A, superfície #0D2142, linha #1E3560, texto
  #F2F5FA, texto secundário #A4ADBB, primário #F5B400 sobre #06142A, link #81ABE1,
  curtida #FF5468. Tipografia: Archivo semi-expandida (títulos e números, pontos em
  itálico) e Instrument Sans (corpo). Tiers como medalhões metálicos (bronze, prata,
  ouro, diamante azul-gelo), raridade como ornamento em volta do medalhão (Comum sem
  anel, Raro anel simples, Épico anel duplo, Lendário anel com raios).
- Entregáveis: `docs/referencias-visuais/*.png` (login, cadastro, feed, perfil,
  mural, trofeus, rankings, cada um em claro e escuro) e `padrao-visual.png`,
  renderizados a partir do canvas 1; e `docs/referencias-visuais/design/`, a
  exportação completa das três sessões (código-fonte das pranchetas, `canvas.json`,
  `tokens.json`, `README.md` do design system, componentes, fontes e imagens), com
  um README de procedência e a versão exportada de cada canvas.
- Decisões de produto que nasceram no design: progressão de prêmios; login somente
  institucional. Entraram no contexto comum em 26/09 e, com a mudança de 11/10
  (repositórios vazios, ideia como pitch), passaram a regras do `eng_00_produto`, só
  do engenheiro. Decisões que
  ficaram só no design do engenheiro (escopo emergente da persona, a registrar na
  análise): abas do perfil (tudo, troféus, medalhas); filtro "quem eu sigo" nos
  rankings; log de leitura do mural ("quem publicou vê que você leu e quando");
  raridade como ornamento neutro; posição no ranking ao lado do nome; tela de
  cadastro separada.
