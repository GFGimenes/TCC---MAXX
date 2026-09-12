# Especificação Funcional por Tela (App Maxx)

Consolidação dos rascunhos/desenhos do autor. Este documento é a **referência de
escopo** para os prompts: as duas personas pedem estas mesmas features — o leigo em
linguagem básica, o engenheiro com restrições técnicas.

Rascunhos originais arquivados:

- `docs/rascunhos/fluxo-prompts.png` — fluxo desenhado do experimento (prompt →
  Codex/Claude → agent review com pontuação → documentar). Desenho anterior à
  simplificação de 12/09/2026: hoje são duas trilhas (leigo e engenheiro) e um único
  agente, ver `README.md`.
- `LOGIN.png` e `paigna de dashboard.png` (raiz do repo) — mockups de login e feed.
- `docs/rascunhos/excalidraw-perfil.png`, `excalidraw-mural.png`,
  `excalidraw-trofeus.png` — wireframes do Excalidraw com anotações.
- `docs/rascunhos/caderno-filosofia-dashboard.png` e `caderno-login-mural.png` —
  fotos do caderno (filosofia do app + dashboard/troféus; login/cadastro + mural).

> Status: rascunho em consolidação. O autor ainda vai enviar descritivos
> complementares por feature.

## 1. Login / Cadastro (`login`)

- Abas "Entrar" e "Cadastrar"; logo MAXX; tema claro e escuro.
- Login por **RA ou e-mail** + senha; "esqueci minha senha"; botão Login.
- Cadastro: alunos e professores vinculam a conta via portal da instituição
  (@unimax.com.br); possibilidade de vincular login social (Google/Apple/outros) para
  acesso posterior.
- Alunos: RA no cadastro, curso/semestre vinculados ao perfil. Ex-aluno mantém acesso
  e posição nos rankings, mas não pontua mais.
- Professores: login de professor atrelado ao perfil.

## 2. Feed / Home (`feed`)

- Estilo Instagram: header MAXX + sino de notificações.
- Card de post: autor (nome, curso/semestre), selo de conquista associado ao post
  (ex.: "Pássaro Raro no Campus" com ícone de troféu), foto, like/comentário/share,
  contagem de likes, legenda, comentários, "add a comment", timestamp.
- Posts podem ser relacionados a prêmio/troféu/medalha conquistado.
- Navegação inferior: Home, Busca, Mural (ícone de jornal, botão central), Troféus,
  Perfil.

## 3. Perfil (`perfil`)

- Header: avatar, **pontos totais + posição no ranking** (ex.: "15020 pts #29"),
  seguidores, seguindo.
- Ao clicar nos pontos/posição: abre visão de rankings — **geral, all-time, do curso e
  do curso global**.
- Username, bio, "último troféu" em destaque (ex.: "top 2% integrativa (ouro)"),
  "followed by xxxx and yyyy".
- Grade estilo Instagram: podem ser **fotos, troféus e conquistas ou fotos de
  troféus**.
- Pontos visíveis para quem visita o perfil.

## 4. Mural / Informativos (`mural`)

- Botão central da navegação (ícone de jornal).
- Categorias no topo com hover/seleção: **Faculdade, Curso, Professores**.
- Avisos publicados pela instituição/coordenação/professores do curso.
- Comportamento de colapso: o aviso mais recente fica "semi-colapsado" (maior que os
  demais) por default; clicar em outro colapsa o inicial e semi-colapsa o clicado;
  clicar no semi-colapsado abre quase fullscreen com botão de voltar no canto superior
  esquerdo. Colapsados mostram só o título; bolinha amarela sinaliza não lido.
- Pode ter botão "ler todos".
- Alunos podem filtrar por categoria e veem apenas o que lhes diz respeito.
- **Log de leitura (feature emergente da persona):** ao ler um aviso, salvar log de
  leitura (quem leu e quando), dando respaldo ao professor. Não é exceção de escopo:
  é um requisito que **o engenheiro antecipa por experiência** (sabe que o cliente
  pediria), enquanto o leigo nem pensaria nele. A presença/ausência dessa feature
  entre as trilhas é um **achado esperado do experimento** — evidência de como a
  experiência técnica altera a completude do produto, mesmo com o mesmo objetivo
  funcional. Registrar no eixo de avaliação como diferença de escopo emergente, não
  como falha do agente.

## 5. Troféus / Medalhas (`trofeus`)

- Duas abas com hover: **Troféus | Medalhas**.
- Cada item: descrição da tarefa (ex.: "tirar mais de 1.8 integrativa"), nível de
  **"encontrabilidade"** (ex.: Comum) e **tier: Bronze, Prata, Ouro, Diamante** (vale
  para troféus e medalhas), que determina a pontuação: Bronze 1 a 30, Prata 31 a 70,
  Ouro 71 a 100, Diamante 101 a 150 pontos. O tier é do prêmio, não do aluno: o aluno
  acumula prêmios e os rankings o classificam só pela posição numérica.
- Filtro "mostrar não obtidos".
- Concessão: participar de seminários, provas, atividades extra complementares, ou
  dados por professores (professores dão **somente medalhas**). Troféus têm peso maior
  que medalhas. Há troféus por assiduidade (não faltar), techdays, feiras, estudo
  relacionado, e troféus de acúmulo ("x medalhas" / "x troféus"). Cadastro de
  troféus/medalhas feito pelo corpo da faculdade.
- Alguns prêmios exigem prova por foto; podem ser denunciados e revogados se
  marcados errado.
- Medalhas: professor ↔ aluno somente quando têm aula juntos; professor só pontua
  alunos que leciona/orienta.

## 6. Rankings (`ranking`)

- 4 visões por tipo de usuário: Geral, por curso, All-time geral, All-time por curso.
- Condensam pontos de prêmios/troféus e medalhas.
- Acessível a partir do perfil (clique nos pontos/posição).

## IDs de rodada

Combinação `<trilha>_<tela>`:

```
leigo_login    leigo_feed    leigo_perfil    leigo_mural    leigo_trofeus    leigo_ranking
eng_login      eng_feed      eng_perfil      eng_mural      eng_trofeus      eng_ranking
```

6 telas × 2 trilhas = **12 rodadas** (mais `eng_00_contexto`, se o engenheiro abrir a
trilha estabelecendo regras, e as rodadas `_v2` de correção/repetição). Se for muito
volume, priorizar: `login`, `feed`, `trofeus` (cobrem autenticação, social e
gamificação, as camadas críticas do TCC).

## Mapeamento telas × camadas (milestones)

| Camada (milestone) | Telas que a exercitam |
|---|---|
| Autenticação | login |
| Banco de Dados | todas (modelo de dados: usuários, posts, troféus, medalhas, pontos, avisos) |
| Gamificação | trofeus, ranking, perfil |
| Frontend | feed, mural, perfil |
