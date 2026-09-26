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

### D01 · (data) · Identidade visual

(prompt como enviado)

Resultado: (aceito / refeito). Tempo: (min).
