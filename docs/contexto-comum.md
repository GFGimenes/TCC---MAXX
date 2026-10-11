# A ideia (semente das duas trilhas)

Até 10/10/2026 este arquivo era copiado, idêntico, como `CLAUDE.md` e `AGENTS.md` na
raiz dos dois repositórios. Em 11/10/2026 isso mudou: **os repositórios nascem vazios**
(só `README.md` e `.gitattributes`) e a ideia chega ao agente pelo prompt de abertura
de cada persona, cada uma do seu jeito. O motivo está no diário e no capítulo 3:
entregar ao leigo uma especificação que ele nunca escreveria fazia o experimento medir
só técnica de prompt; sem o arquivo, ele mede o fenômeno inteiro, e transformar a
ideia em regras passa a fazer parte do que se mede.

## O que é "a mesma ideia"

A ideia é o pitch de corredor, igual nas duas trilhas:

> Uma rede social para a UniMax, parecida com o Instagram mas sem stories e sem
> mensagens, onde os alunos ganham pontos por prêmios e medalhas dadas pelos
> professores, e esses pontos os colocam em rankings geral e por curso. Só alunos e
> professores usam. Tem um mural onde os coordenadores dos cursos publicam avisos.

Tudo que transforma o pitch em algo construível (atores formais, telas, tipos de
prêmio, tiers e pontos, progressão, login só institucional, comprovação por foto,
ex-alunos) é engenharia de requisitos, e só uma das personas faz isso antes do código.

## Conhecimento de produto por persona

- **Engenheiro**: define as regras do produto antes de qualquer código, no prompt
  `eng_00_produto` (a versão dele das regras abaixo, na voz dele), seguido na mesma
  sessão do `eng_00_tecnica` (projeção, stack, arquitetura, segurança, testes, deploy
  e jeito de trabalhar). Três definições antes do código: design, produto, técnica.
- **Leigo**: o conhecimento de produto do leigo é o prompt de abertura, e nada mais.
  Daí em diante ele não introduz regra nova: reage ao que vê, aceita o que o agente
  propõe e reclama do que quebra ou contradiz o que pediu, nas palavras do corpus. O
  que o leigo nunca pede, e o agente nunca oferece, é resultado do experimento
  ("regra ausente"), não defeito da persona. A política de reação está em
  `personas/leigo/perfil.md`; a abertura e os prompts por tela são escritos antes do
  piloto e não mudam depois de nenhum resultado.

O trabalho de definição não desaparece: ou a pessoa faz antes, ou o agente faz por
ela, com os padrões dele. Quanto cada agente decidiu sozinho é medido nas duas
trilhas.

## O que fica constante nas duas trilhas

Nome (Maxx), faculdade (UniMax, rede UniEduk), as seis telas na mesma ordem de rodadas
(`docs/especificacao-telas.md`), os números dos tiers quando aparecerem, modelo e
versão do Claude Code, revisor, rubrica e testes de referência. Nunca se copia
contexto, código ou decisão de uma trilha para a outra.

## Regras completas do produto (referência do autor; base do `eng_00_produto`)

Este é o texto que foi o `CLAUDE.md` comum de 12/09 a 10/10/2026. Continua sendo a
referência do que o produto é; o engenheiro o reescreve na voz dele no
`eng_00_produto`, e o leigo não o recebe.

---

# Maxx

Maxx é um aplicativo de engajamento acadêmico gamificado para os alunos da rede
UniEduk (UniMax e UniFaj). A ideia é transformar a participação na vida da faculdade
(aulas, provas, seminários, feiras, techdays, atividades complementares) em prêmios e
pontos, com um feed social onde os alunos compartilham suas conquistas.

## Quem usa

- **Aluno**: tem RA (registro acadêmico), curso e semestre. Ganha prêmios, acumula
  pontos, aparece nos rankings, publica no feed e lê o mural de avisos.
- **Professor**: vinculado aos cursos e turmas em que leciona. Pode conceder medalhas
  aos alunos com quem tem aula e publicar avisos no mural.
- **Instituição** (coordenação/secretaria): cadastra os prêmios disponíveis e publica
  avisos institucionais.

## O que o app tem

- Login e cadastro somente com e-mail institucional ou RA (aluno por RA ou e-mail
  institucional; professor com e-mail institucional). Não existe login social, para
  que ninguém de fora da faculdade consiga entrar.
- Feed social no estilo Instagram, com posts que podem estar ligados a um prêmio
  conquistado.
- Perfil do aluno com pontos totais, posição no ranking e seus prêmios.
- Mural de avisos da faculdade, do curso e dos professores.
- Tela de troféus e medalhas, com o que já foi obtido e o que ainda falta.
- Rankings de alunos por pontos.

## Como funcionam os prêmios e os pontos

- Existem dois tipos de prêmio: **troféus** e **medalhas**. Medalhas podem ser dadas
  por professores; troféus são concedidos pela instituição ou por regras automáticas
  (por exemplo, assiduidade, participação em eventos, acúmulo de medalhas).
- Cada prêmio tem um **tier**, que define quantos pontos ele vale:

  | Tier do prêmio | Pontos |
  |---|---|
  | Bronze | 1 a 30 |
  | Prata | 31 a 70 |
  | Ouro | 71 a 100 |
  | Diamante | 101 a 150 |

- Os alunos **não têm tier**. Um aluno acumula vários prêmios; a soma dos pontos dos
  prêmios é a pontuação dele, e os rankings classificam os alunos apenas pela posição
  numérica (1º, 2º, 3º...).
- Um professor só pode dar medalha a aluno com quem tem aula.
- Alguns prêmios têm **progressão**: a mesma conquista repetida (por exemplo, média
  10 em uma matéria, em semestres diferentes) rende um novo prêmio de tier acima do
  anterior, valendo mais pontos, até chegar ao Diamante. O aluno guarda todos os
  prêmios da progressão.
- Alguns prêmios exigem comprovação por foto, e podem ser revogados se a comprovação
  for contestada.
- Ex-alunos mantêm o acesso e a posição no ranking, mas não pontuam mais.
