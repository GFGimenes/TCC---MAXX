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

Resultado: (preencher: o que o Design propôs de pattern, o que foi aceito, o que foi
refeito). Tempo: (min, incluindo a preparação dos anexos).

### D02 · (data) · Perfil: ajustes

(prompt como enviado)

Resultado: (aceito / refeito). Tempo: (min).
