# Review leigo_pu, eixo 1. Experiência do usuário

- Status: ok
- Tentativa: 1
- Commit avaliado: ce76942b7aa1ebb3a016df705972fc32483cf98f (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 6f8babf1-6967-4538-a32d-65a6d58b0669

Texto do revisor, sem edição:

---
# Revisão independente: eixo 1, Experiência do usuário (produto `leigo_pu`, commit `ce76942b`)

## Nota: 4 de 5

## Justificativa

Avaliei só pela leitura do código. O front-end inteiro está em `public/app.js`, um app de página única em JavaScript puro; as rotas da API estão em `server/index.js`.

**Por que não é 3.** As seis telas pedidas existem e se encadeiam: login/cadastro, feed, perfil, mural ("Avisos"), troféus ("Conquistas") e ranking. Os estados de interface são tratados de forma consistente:
- **Carregamento:** há um indicador de carregamento padrão em toda tela.
- **Erro:** mensagens em português, exibidas em aviso flutuante ou na própria tela.
- **Vazio:** cada lista tem um texto próprio.
- **Envio:** o botão fica travado com "Aguarde…" enquanto o pedido é enviado.
- **Curtida:** é otimista e volta atrás se der erro.
- **Sessão:** se ela expira, o app manda para o login.
- **Ações destrutivas:** pedem confirmação.

A coerência visual vem de um layout único (barra superior, navegação inferior com 5 itens, cards) e de uma folha de estilo só, com modo escuro automático.

**Por que não é 5.** Há divergências de detalhe nas partes que existem:
- A navegação inferior não segue a estrutura pedida. O botão central é "+", não o Mural. Não há Busca. O Perfil só é acessível pelo avatar no canto superior.
- Login e cadastro são telas separadas, não abas.
- O ícone do mural é um megafone, não um jornal.
- A tela de Conquistas tem uma terceira aba, "Pontos".
- Alguns erros são mascarados como estado vazio.

Muitas regras da especificação estão ausentes; conforme a rubrica, só foram marcadas e não reduziram a nota.

## Evidências

| Local | Observação |
|---|---|
| `public/app.js:156-170` | `onSubmit`: trava o botão com "Aguarde…", mostra o erro em aviso flutuante e restaura o botão. Usado em todos os formulários. |
| `public/app.js:30-50` | `api()`: mensagem "Sem conexão. Confira sua internet." em falha de rede; 401 leva ao login; mensagem genérica de reserva. |
| `public/app.js:1019-1026` | Falha no carregamento inicial mostra uma tela com o botão "Tentar de novo". |
| `public/app.js:278-295` | Curtida otimista, desfeita se der erro. Curtida por dois toques na foto em `:308-322`. |
| `public/app.js:326`, `:557`, `:708`, `:835` | Confirmação antes de apagar post, comentário ou aviso e antes de retirar medalha, avisando o efeito nos pontos. |
| `public/app.js:507`, `:545`, `:705`, `:746`, `:812`, `:864` | Estados vazios com texto próprio em feed, comentários, avisos, ranking e medalhas. |
| `public/app.js:190-216` | Layout único com 5 itens: Feed, Avisos, +/Medalha, Ranking, Conquistas. Diverge da especificação (Home, Busca, Mural central, Troféus, Perfil). |
| `public/app.js:339-367` | Login só por e-mail e senha. Sem abas Entrar/Cadastrar (o cadastro fica em `#/cadastro`, `:392`). Sem "esqueci minha senha". |
| `public/app.js:392-425` | Cadastro alterna entre Aluno e Professor. Para aluno, mostra curso e semestre; para professor, pede um código. |
| `public/app.js:231-276` | Card de post: autor, curso, tempo relativo, foto/medalha/troféu, curtir, comentar e legenda. Não há compartilhar. O selo de conquista é um post à parte, não um selo sobre a foto. |
| `public/app.js:875-931` | Perfil: pontos, posição geral e no curso com link para o ranking já filtrado (`:927-930`), prêmios em faixa e grade 3×3 de fotos. Sem seguidores/seguindo e sem "último troféu" em destaque. |
| `public/app.js:664-715` | Mural: lista simples, ordenada por fixado e depois por data, com selo de curso. Sem categorias, sem comportamento de colapso, sem marcador de não lido. |
| `server/index.js:360-374` | O aluno só vê avisos gerais e os do próprio curso (atende "vê só o que lhe diz respeito"). |
| `public/app.js:718-766` | Ranking: Geral ou Por curso × Sempre ou Este mês (4 visões), pódio dos 3 primeiros e barra com "#posição Você". |
| `public/app.js:780-840` | Conquistas com abas Troféus, Medalhas e Pontos. Troféus bloqueados aparecem com cadeado e barra de progresso. Não há filtro "mostrar não obtidos". |
| `server/rules.js:22-36` | Tiers de troféu só bronze, prata e ouro (sem Diamante). Medalhas não têm tier. |
| `public/app.js:842-845` | Inconsistência: se `/api/medals/given` falhar, aparece o aviso de erro, mas a tela mostra "Você ainda não deu nenhuma medalha" (erro disfarçado de estado vazio). |
| `public/app.js:890` | O erro ao buscar as fotos do perfil é engolido e a tela diz "Nenhuma foto ainda". |
| `public/app.js:576` | "Até ${3} fotos por dia" com o número fixo no código, enquanto a regra vive em `server/rules.js:6`. Pode ficar inconsistente se a regra mudar. |
| `public/app.js:785` | A tela de conquistas vinda de `#/conquistas/<id próprio>` mostra o botão Voltar e o título "Minhas conquistas" ao mesmo tempo. Detalhe menor. |
| `public/app.js:842-872` | Para professor, a aba "Conquistas" abre uma tela intitulada "Medalhas". O rótulo da navegação não bate com o título. |
| `public/styles.css:21`, `:129` | Modo escuro via `prefers-color-scheme`, sem alternância manual. |

## Regras ausentes (marcadas, sem reduzir a nota)

- **Login:** entrar por RA; RA no cadastro; "esqueci minha senha"; abas Entrar/Cadastrar; alternância manual de tema claro/escuro.
- **Contas:** vínculo pelo portal da instituição (há só a checagem do domínio do e-mail, e o domínio padrão é `@unimax.edu.br`, não `@unimax.com.br`); ex-aluno que mantém acesso e posição mas não pontua.
- **Feed e navegação:** sino de notificações; aba Busca; compartilhar post; selo de conquista associado a um post de foto; Mural como botão central com ícone de jornal; Perfil na navegação inferior.
- **Perfil:** seguidores e seguindo; "followed by xxxx and yyyy"; "último troféu" em destaque.
- **Mural:** categorias Faculdade/Curso/Professores; aviso mais recente semi-colapsado, expansão quase em tela cheia com botão voltar; marcador amarelo de não lido; botão "ler todos"; registro de leitura (quem leu e quando).
- **Troféus e medalhas:**
  - tier Diamante e as faixas de pontos por tier (Bronze 1-30, Prata 31-70, Ouro 71-100, Diamante 101-150);
  - tier nas medalhas;
  - nível de "encontrabilidade";
  - filtro "mostrar não obtidos";
  - trilha de progressão da mesma conquista para o tier seguinte;
  - prova por foto;
  - denúncia e revogação de prêmio marcado errado;
  - cadastro de troféus e medalhas pelo corpo da faculdade;
  - restrição de que o professor só dá medalha a quem leciona ou orienta.
- **Ranking:** visão "do curso global" distinta de "por curso" (o produto tem 2 escopos × 2 períodos, com "Este mês" no lugar de "Geral" não all-time).

## Decisões do agente (tomadas sem o prompt pedir, dentro deste eixo)

- **"Acesso da banca":** login de visitante só com o nome, escolhendo entre Aluno e Professor, com selo "Banca", conta válida por 7 dias, código no link (`?banca=`) e um cartão de boas-vindas com dicas que pode ser fechado.
- **Aplicativo instalável no celular (PWA):** manifesto, service worker e ícones.
- **Navegação inferior própria:** Feed, Avisos, botão central "+" (publicar foto, para aluno) ou "Dar medalha" (para professor), Ranking e Conquistas. Perfil pelo avatar no topo; sair pelo ícone no próprio perfil.
- **Feed:** curtida por dois toques na foto com animação de coração; filtro "Toda a UniMax" / "Meu curso"; rolagem infinita com botão "Carregar mais" e "Você viu tudo ✨".
- **Posts:** medalhas e troféus viram posts próprios no feed, que podem ser curtidos e comentados; tela de detalhe do post com comentários e opção de apagá-los.
- **Celebração:** janela "Troféu desbloqueado!" ao ganhar um troféu.
- **Publicação:** a foto é reduzida no próprio celular antes do envio, com prévia; o botão mostra os pontos ("Publicar · +10 pts").
- **Fluxo de dar medalha:** 3 passos (aluno com busca, tipo, motivo obrigatório), com o aluno pré-selecionado quando se vem do perfil dele.
- **Aba "Pontos" em Conquistas:** explica as regras de pontuação. Professores têm uma tela "Medalhas" própria.
- **Ranking:** pódio dos 3 primeiros e barra "Você #posição"; o filtro "Sempre / Este mês" substitui "all-time".
- **Mural:** aviso para todos os cursos ou para um só; fixar no topo só para a conta da secretaria (admin); selo "Oficial UniMax".
- **Modo escuro:** automático, seguindo o sistema; identidade visual em gradiente roxo → laranja.
- **Edição de perfil:** foto, bio, curso e semestre, com dica do troféu "Cartão de visitas".
- **Linguagem:** mensagens de erro e textos em português amigável, com tempo relativo ("há 3 min").

## O que não pude verificar (só leitura, sem executar)

- A renderização real das telas, o layout em celular, o contraste e a aparência no modo escuro.
- Se os fluxos funcionam de ponta a ponta em execução (cadastro, login, publicar, curtir, comentar, dar e retirar medalha, avisos, ranking).
- O tempo real de carregamento e o comportamento do indicador e do aviso flutuante.
- A curtida por dois toques e a rolagem infinita em aparelho de toque.
- A instalação como app (PWA) e o comportamento do service worker sem conexão.
- O conteúdo visual dos dados de exemplo (o app não abrir vazio).
- Acessibilidade com leitor de tela, além da presença de atributos `aria-*`.
- O deploy público e a URL.

```json
{
  "nota": 4,
  "justificativa": "As seis telas (login/cadastro, feed, perfil, mural 'Avisos', troféus 'Conquistas', ranking) existem e se encadeiam por um layout único com barra superior e navegação inferior. Os estados são tratados de forma consistente: indicador de carregamento em toda tela, erros em português (sem conexão, 401 que leva ao login, tela de nova tentativa no carregamento inicial), estados vazios com texto próprio, botão travado com 'Aguarde…' no envio, curtida otimista com reversão e confirmação antes de ações destrutivas. A coerência visual vem de uma folha de estilo única com modo escuro automático. Não chega a 5 por divergências de detalhe nas partes que existem: navegação inferior diferente da especificação (sem Busca, Mural fora do centro, Perfil só pelo avatar), login e cadastro em telas separadas e não em abas, ícone de megafone em vez de jornal, aba extra 'Pontos', e erros mascarados como estado vazio (medalhas dadas e fotos do perfil). As regras ausentes foram marcadas sem reduzir a nota.",
  "evidencias": [
    {"local": "public/app.js:156-170", "descricao": "onSubmit trava o botão com 'Aguarde…', mostra o erro em aviso flutuante e restaura o botão; usado em todos os formulários."},
    {"local": "public/app.js:30-50", "descricao": "Wrapper da API: mensagem de sem conexão, 401 leva ao login, mensagem genérica de reserva."},
    {"local": "public/app.js:1019-1026", "descricao": "Falha no carregamento inicial mostra tela com botão 'Tentar de novo'."},
    {"local": "public/app.js:278-322", "descricao": "Curtida otimista com reversão em caso de erro e curtida por dois toques na foto."},
    {"local": "public/app.js:326", "descricao": "Confirmação antes de apagar post (também em :557, :708, :835 para comentário, aviso e medalha)."},
    {"local": "public/app.js:507", "descricao": "Estado vazio do feed; equivalentes em comentários (:545), avisos (:705), ranking (:746) e medalhas (:812, :864)."},
    {"local": "public/app.js:190-216", "descricao": "Navegação inferior Feed/Avisos/+/Ranking/Conquistas, diferente da especificação (Home, Busca, Mural central, Troféus, Perfil)."},
    {"local": "public/app.js:339-367", "descricao": "Login só por e-mail e senha, sem abas Entrar/Cadastrar e sem 'esqueci minha senha'."},
    {"local": "public/app.js:231-276", "descricao": "Card de post com autor, curso, tempo, mídia, curtir, comentar e legenda; sem compartilhar."},
    {"local": "public/app.js:875-931", "descricao": "Perfil com pontos e posição geral e no curso levando ao ranking filtrado; sem seguidores e sem último troféu em destaque."},
    {"local": "public/app.js:664-715", "descricao": "Mural em lista simples; sem categorias, sem colapso, sem marcador de não lido."},
    {"local": "server/index.js:360-374", "descricao": "Aluno vê só avisos gerais e do próprio curso."},
    {"local": "public/app.js:718-766", "descricao": "Ranking Geral/Por curso × Sempre/Este mês com pódio e barra da posição do usuário."},
    {"local": "public/app.js:780-840", "descricao": "Conquistas com abas Troféus/Medalhas/Pontos; troféus bloqueados com cadeado e progresso; sem filtro 'mostrar não obtidos'."},
    {"local": "server/rules.js:22-36", "descricao": "Troféus só com tiers bronze, prata e ouro; sem Diamante; medalhas sem tier."},
    {"local": "public/app.js:842-845", "descricao": "Erro ao carregar medalhas dadas aparece em aviso, mas a tela mostra 'Você ainda não deu nenhuma medalha'."},
    {"local": "public/app.js:890", "descricao": "Erro ao buscar fotos do perfil é engolido e exibido como 'Nenhuma foto ainda'."},
    {"local": "public/app.js:576", "descricao": "Limite de 3 fotos por dia fixo no texto, enquanto a regra vive em server/rules.js:6."},
    {"local": "public/app.js:842-872", "descricao": "Para professor, a aba 'Conquistas' abre tela intitulada 'Medalhas'; rótulo e título não batem."},
    {"local": "public/styles.css:21", "descricao": "Modo escuro automático via prefers-color-scheme, sem alternância manual."}
  ],
  "regras_ausentes": [
    "Login por RA e RA no cadastro",
    "Esqueci minha senha",
    "Abas Entrar/Cadastrar na mesma tela",
    "Alternância manual de tema claro/escuro",
    "Vínculo de conta via portal da instituição (domínio @unimax.com.br)",
    "Ex-aluno que mantém acesso e posição mas não pontua",
    "Sino de notificações no header do feed",
    "Aba Busca na navegação",
    "Compartilhar post",
    "Selo de conquista associado ao post de foto",
    "Mural como botão central com ícone de jornal; Perfil na navegação inferior",
    "Seguidores/seguindo e 'followed by' no perfil",
    "Último troféu em destaque no perfil",
    "Categorias Faculdade/Curso/Professores no mural",
    "Comportamento de colapso e semi-colapso e abertura quase em tela cheia do aviso",
    "Marcador amarelo de não lido e botão 'ler todos'",
    "Registro de leitura de avisos (quem leu e quando)",
    "Tier Diamante e faixas de pontos por tier (1-30, 31-70, 71-100, 101-150)",
    "Tier em medalhas",
    "Nível de encontrabilidade",
    "Filtro 'mostrar não obtidos'",
    "Trilha de progressão da mesma conquista para tier superior",
    "Prova por foto, denúncia e revogação de prêmio marcado errado",
    "Cadastro de troféus e medalhas pelo corpo da faculdade",
    "Professor só dá medalha a alunos que leciona ou orienta",
    "Visão de ranking 'do curso global' distinta de 'por curso'"
  ],
  "decisoes_do_agente": [
    "Acesso da banca: login de visitante só com nome, papel Aluno ou Professor, selo 'Banca', 7 dias, código no link e cartão de boas-vindas com dicas",
    "App instalável no celular (PWA) com manifesto, service worker e ícones",
    "Navegação inferior própria com botão central '+' (publicar foto) para aluno ou 'Dar medalha' para professor; Perfil pelo avatar no topo; sair no perfil",
    "Curtida por dois toques na foto com animação de coração",
    "Filtro do feed 'Toda a UniMax' / 'Meu curso' e rolagem infinita com 'Carregar mais'",
    "Medalhas e troféus viram posts próprios no feed, que podem ser curtidos e comentados",
    "Janela de celebração 'Troféu desbloqueado!'",
    "Redução da foto no próprio celular antes do envio, com prévia, e pontos no botão de publicar",
    "Fluxo de dar medalha em 3 passos com busca de aluno e motivo obrigatório; aluno pré-selecionado vindo do perfil",
    "Aba 'Pontos' explicando as regras e tela de 'Medalhas' própria para professores",
    "Ranking com pódio dos 3 primeiros, barra 'Você #posição' e período 'Este mês' no lugar de all-time",
    "Aviso direcionado a todos ou a um curso; fixar no topo e selo 'Oficial' só para a conta admin",
    "Modo escuro automático pelo sistema e identidade visual em gradiente roxo → laranja",
    "Tela de edição de perfil com dica do troféu 'Cartão de visitas'",
    "Mensagens e tempo relativo em português amigável"
  ],
  "nao_verificado": [
    "Renderização real das telas, layout em celular, contraste e aparência no modo escuro",
    "Funcionamento dos fluxos de ponta a ponta em execução",
    "Tempos reais de carregamento e comportamento do indicador e do aviso flutuante",
    "Curtida por dois toques e rolagem infinita em aparelho de toque",
    "Instalação PWA e comportamento do service worker sem conexão",
    "Conteúdo visual dos dados de exemplo",
    "Acessibilidade com leitor de tela além da presença de atributos aria",
    "Deploy público e URL acessível"
  ]
}
```
