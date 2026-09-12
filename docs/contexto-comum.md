# Contexto Comum do Projeto (arquivo de contexto das 4 trilhas)

Este é o texto que vai, **idêntico e sem nenhum acréscimo**, para as quatro trilhas do
experimento (`leigo/claude`, `leigo/codex`, `eng/claude`, `eng/codex`), como
`CLAUDE.md` e `AGENTS.md` na raiz do repo Maxx. Ele é a constante do experimento: a
"ideia central" que todo prompt parte. Tudo o que não está aqui (stack, modelo de
dados, arquitetura, segurança, testes, convenções) chega apenas pelos prompts, ou não
chega. Isso é proposital: a diferença entre trilhas deve ser atribuível ao prompt.

Regra de manutenção: este arquivo não muda durante o experimento. Se precisar mudar,
todas as rodadas anteriores ficam marcadas como executadas com a versão anterior.

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

- Login e cadastro (aluno por RA ou e-mail; professor com login próprio).
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
- Alguns prêmios exigem comprovação por foto, e podem ser revogados se a comprovação
  for contestada.
- Ex-alunos mantêm o acesso e a posição no ranking, mas não pontuam mais.
