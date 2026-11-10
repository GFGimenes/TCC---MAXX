# Review engenheiro, eixo 1. Experiência do usuário

- Status: ok
- Tentativa: 1
- Commit avaliado: 8910b51ae7b0ca10582517ead72ee832746683a3 (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: e8093f31-1dfa-4a52-a082-41c59edde8f1

Texto do revisor, sem edição:

---
# Revisão: eixo 1, Experiência do usuário (produto `engenheiro`, commit `8910b51a`)

**Nota: 4 de 5.** As seis telas existem e estão ligadas à API. A navegação é clara e os estados de carregamento, erro e vazio são tratados do mesmo jeito em todas elas. A identidade visual é consistente nos dois temas e o código segue de perto os mockups do engenheiro em `design/telas/`. Não chega a 5 porque o Perfil se afasta da especificação e do próprio mockup em pontos visíveis, e porque há pequenas incoerências entre telas.

## Justificativa

**O que sustenta o 4:**
- **Login e cadastro.** Há o seletor Entrar/Cadastrar, o campo "RA ou e-mail", "Esqueci minha senha", nenhum login social e erros mostrados no campo certo. Ver `apps/mobile/src/autenticacao/LoginScreen.tsx:78-129` e `SegmentadoDeAcesso.tsx:7-28`.
- **Feed.** Segue o mockup: autor com curso e semestre, selo do prêmio, foto, curtir/comentar/enviar, faixa do prêmio com tier, raridade e pontos, curtidas, legenda, "Ver todos os comentários" e tempo (`feed/CartaoDePost.tsx:136-277`). A curtida aparece na hora e volta atrás com mensagem se a API falhar (`CartaoDePost.tsx:106-121`).
- **Mural.** Tem os chips Todos, Faculdade, Curso e Professores, o botão "Ler todos" (desabilitado quando não há o que ler), a bolinha dourada nos não lidos, o card recolhido só com o título e o aviso aberto em tela própria com voltar (`mural/MuralScreen.tsx:31-158`, `CartaoDeAviso.tsx:26-112`, `AvisoScreen.tsx:54`).
- **Troféus.** Abas Troféus/Medalhas, chave "Mostrar não obtidos", trilha de progressão Bronze → Diamante com o próximo nível marcado por cadeado, e pontos com posição que levam ao ranking (`trofeus/TrofeusScreen.tsx:77-151`, `premios/TrilhaFamilia.tsx`).
- **Rankings.** As quatro visões em chips, o card "Sua posição", o filtro "Quem eu sigo" e a linha do próprio aluno destacada (`rankings/RankingsScreen.tsx:113-144`). Abre a partir dos pontos no Perfil (`PerfilScreen.tsx:384-388`) e em Troféus.
- **Estados.** Todas as listas tratam carregando, erro com "Tentar de novo" e vazio com texto que explica (por exemplo `FeedScreen.tsx:91-131` e `MuralScreen.tsx:182-213`). Os erros da API viram mensagens em português a partir de um catálogo de códigos, com uma mensagem padrão e um caso próprio para falta de conexão (`api/erros.ts:4-151`). A sessão trata os casos restaurando, anônimo e sem conexão (`app/(app)/_layout.tsx:18-36`).

**O que impede o 5:**
- **Perfil sem quatro itens pedidos.** Faltam a bio, o "último troféu" em destaque, o "Seguida por…" e o botão Compartilhar. Os três primeiros estão na especificação e todos os quatro aparecem no mockup `design/telas/perfil-claro.png`. A remoção foi deliberada e está registrada como "D10" em `docs/decisoes/README.md:361`, mas contraria a referência. Ver `perfil/PerfilScreen.tsx:395-419`.
- **Sino de notificações só em três telas.** Feed, Mural e Rankings têm o sino. Troféus (`TrofeusScreen.tsx:70-72`) e Perfil (`PerfilScreen.tsx:79-91`) não têm, embora os mockups `trofeus-claro.png` e `perfil-claro.png` o mostrem.
- **Card lido do Mural não recolhe de novo.** Depois de aberto no lugar, só volta ao estado recolhido recarregando a tela (`CartaoDeAviso.tsx:23-24,33`).
- **Mensagem de vazio em Troféus.** Diz "Ligue Mostrar não obtidos…" mesmo com a chave já ligada (`TrofeusScreen.tsx:153-162`).
- **Erro ao carregar mais no Rankings.** Se falhar o carregamento da página seguinte, não aparece mensagem nem botão para tentar de novo, ao contrário de Feed e Mural (`RankingsScreen.tsx:188-200`).
- **Mural diferente da especificação.** Em vez de só o aviso mais recente ficar "semi-colapsado", com um aviso aberto por vez, todos os não lidos ficam abertos e os lidos recolhidos. Bate com o mockup, não com o texto da especificação.

## Regras ausentes (não pesam na nota)

- Tela para o professor ou a coordenação consultar quem leu cada aviso. A leitura é gravada (`PUT /avisos/{id}/leitura` em `AvisoEndpoints.cs:39` e `POST /mural/leitura` em `:51`), mas não há tela para consultá-la.
- Bio no perfil.
- "Último troféu" em destaque no perfil.
- "Followed by xxxx and yyyy" no perfil.
- Campo "add a comment" dentro do card do feed. O comentário é feito numa tela separada, `posts/ComentariosScreen.tsx`.
- Grade do perfil mostrando troféus e conquistas como células. As abas de troféus e medalhas usam lista, não grade.

## Decisões do agente (não pedidas, dentro deste eixo)

- Remover do Perfil a bio, o "Seguida por" e o Compartilhar (D10, `docs/decisoes/README.md:361`).
- Mural: não lidos abertos e lidos recolhidos. Tocar no card recolhido o abre ali sem contar leitura; só "Abrir" grava a leitura. "Ler todos" marca o mural inteiro, não só o filtro ativo.
- Sem botão de salvar no post ("fase 1").
- Filtro "Quem eu sigo" no Rankings.
- Card "Sua posição" com o link "Ver prêmios".
- Botão "Entrar na demonstração", que só aparece quando a API habilita, e a tela de demonstração.
- Mensagem orientando o primeiro acesso do professor por "Esqueci minha senha".
- Cadastro em três passos: dados, arroba e termo de uso.
- Tema Sistema/Claro/Escuro no menu do Perfil.
- Instituição não curte nem comenta. Troféus mostra uma mensagem de vazio própria para quem não é aluno.
- Seção "Reivindicações" na aba Troféus. Contestação e remoção pelo menu "…" do post.
- Busca de alunos com chips de curso e semestre e atalhos para o ranking.
- Bolinhas de novidade nas abas Mural e Troféus, consultadas a cada 60 s.
- Acessibilidade: rótulos de leitor de tela, áreas de toque mínimas, `role` e `aria-*`, e "não lido" anunciado em voz e não só pela cor.

## O que não pude verificar (só leitura)

- A renderização real das telas, nos temas claro e escuro, e a fidelidade em pixels aos mockups.
- O comportamento no Android, no iOS e na web, incluindo teclado, área segura e rolagem.
- A execução da suíte de testes do app (`*.test.tsx`) e da CI.
- Se os fluxos funcionam de ponta a ponta contra a API e o banco, inclusive com os dados de exemplo.
- O tempo de resposta e o carregamento das imagens.
- O deploy em `app.maxx-unimax.com`.

```json
{
  "nota": 4,
  "justificativa": "As seis telas existem e estão ligadas à API, com navegação inferior de cinco abas e pilha para as telas internas. Estados de carregamento, erro (com tentar de novo e mensagens amigáveis por código) e vazio são tratados de forma consistente, há tema claro e escuro, acessibilidade cuidada e alta fidelidade aos mockups do engenheiro no Feed, no Mural, em Troféus e em Rankings. Não chega a 5 porque o Perfil omite bio, último troféu em destaque, 'Seguida por' e Compartilhar, presentes na especificação e no próprio mockup (decisão D10 do agente); o sino falta em Troféus e Perfil, ao contrário dos mockups; e há pequenas incoerências: card lido do mural que não recolhe de novo, texto de vazio em Troféus que manda ligar uma chave já ligada, e Rankings sem mensagem de erro ao carregar a página seguinte.",
  "evidencias": [
    {"local": "apps/mobile/src/autenticacao/LoginScreen.tsx:78-129", "descricao": "Login com 'RA ou e-mail', senha, 'Esqueci minha senha', erros no campo ou abaixo do botão e orientação de primeiro acesso; sem login social."},
    {"local": "apps/mobile/src/autenticacao/SegmentadoDeAcesso.tsx:7-28", "descricao": "Seletor Entrar/Cadastrar, cada lado em rota própria."},
    {"local": "apps/mobile/src/feed/CartaoDePost.tsx:136-277", "descricao": "Card do post fiel ao mockup feed-claro.png: autor com curso e semestre, selo, foto, curtir/comentar/enviar, faixa do prêmio, curtidas, legenda, comentários e tempo."},
    {"local": "apps/mobile/src/feed/CartaoDePost.tsx:106-121", "descricao": "Curtida aplicada na hora, desfeita com mensagem se a API falhar."},
    {"local": "apps/mobile/src/feed/FeedScreen.tsx:91-131", "descricao": "Carregando, erro com tentar de novo, vazio com ação e erro na paginação."},
    {"local": "apps/mobile/src/mural/MuralScreen.tsx:31-158", "descricao": "Chips Todos/Faculdade/Curso/Professores e 'Ler todos' desabilitado quando não há não lidos; fiel a mural-claro.png."},
    {"local": "apps/mobile/src/mural/CartaoDeAviso.tsx:23-24", "descricao": "Card lido expandido não volta a recolher: só existe setExpandido(true)."},
    {"local": "apps/mobile/src/mural/AvisoScreen.tsx:39-79", "descricao": "Aviso aberto em tela própria com voltar, registro de leitura e estados de inexistente e de erro."},
    {"local": "apps/mobile/src/trofeus/TrofeusScreen.tsx:77-151", "descricao": "Abas Troféus/Medalhas, 'Mostrar não obtidos', trilha de progressão e pontos que abrem o ranking."},
    {"local": "apps/mobile/src/trofeus/TrofeusScreen.tsx:70-72", "descricao": "Topo de Troféus sem o sino, que aparece no mockup trofeus-claro.png."},
    {"local": "apps/mobile/src/trofeus/TrofeusScreen.tsx:153-162", "descricao": "Texto de vazio manda ligar 'Mostrar não obtidos' mesmo com a chave já ligada."},
    {"local": "apps/mobile/src/rankings/RankingsScreen.tsx:113-144", "descricao": "Quatro visões em chips, card 'Sua posição' e filtro 'Quem eu sigo'; fiel a rankings-claro.png."},
    {"local": "apps/mobile/src/rankings/RankingsScreen.tsx:188-200", "descricao": "Erro ao carregar a página seguinte não é mostrado, ao contrário de Feed e Mural."},
    {"local": "apps/mobile/src/perfil/PerfilScreen.tsx:384-388", "descricao": "Pontos e posição no próprio perfil abrem /rankings?visao=historico, como pede a especificação."},
    {"local": "apps/mobile/src/perfil/PerfilScreen.tsx:395-419", "descricao": "Perfil sem bio, sem último troféu em destaque e sem 'Seguida por', itens da especificação e do mockup perfil-claro.png."},
    {"local": "apps/mobile/src/perfil/PerfilScreen.tsx:79-91", "descricao": "Topo do próprio perfil sem o sino, que aparece no mockup."},
    {"local": "docs/decisoes/README.md:361", "descricao": "Decisão D10 registra a remoção de bio, 'Seguida por' e Compartilhar."},
    {"local": "apps/mobile/src/api/erros.ts:4-151", "descricao": "Catálogo de códigos de erro da API em mensagens em português, com mensagem padrão e caso de falta de conexão."},
    {"local": "apps/mobile/src/app/(app)/_layout.tsx:18-36", "descricao": "Sessão restaurando, anônimo (vai ao login e depois volta) e sem conexão com tentar de novo."}
  ],
  "regras_ausentes": [
    "Consulta do log de leitura de avisos pelo professor ou pela coordenação (a leitura é gravada, mas não há tela para consultá-la)",
    "Bio no perfil",
    "'Último troféu' em destaque no perfil",
    "'Followed by xxxx and yyyy' no perfil",
    "Campo 'add a comment' dentro do card do feed (comentário só em tela separada)",
    "Grade do perfil com troféus e conquistas como células (abas de prêmios em lista)"
  ],
  "decisoes_do_agente": [
    "Remover do Perfil a bio, o 'Seguida por' e o Compartilhar (D10)",
    "Mural com não lidos abertos e lidos recolhidos; tocar abre no lugar sem contar leitura; só 'Abrir' grava a leitura",
    "'Ler todos' marca o mural inteiro, não só o filtro ativo",
    "Sem botão de salvar no post na fase 1",
    "Filtro 'Quem eu sigo' no Rankings",
    "Card 'Sua posição' com o link 'Ver prêmios' no Rankings",
    "Botão e tela de demonstração habilitados pela API",
    "Orientação de primeiro acesso do professor por 'Esqueci minha senha'",
    "Cadastro em três passos: dados, arroba e termo de uso",
    "Tema Sistema/Claro/Escuro no menu do Perfil",
    "Instituição não curte nem comenta; Troféus com mensagem de vazio própria para quem não é aluno",
    "Seção 'Reivindicações' em Troféus e contestação ou remoção pelo menu '…' do post",
    "Busca de alunos com chips de curso e semestre e atalhos para o ranking",
    "Bolinhas de novidade nas abas Mural e Troféus, consultadas a cada 60 s",
    "Acessibilidade: rótulos de leitor de tela, áreas de toque mínimas, role e aria, e 'não lido' anunciado em voz e não só pela cor"
  ],
  "nao_verificado": [
    "Renderização real das telas e fidelidade em pixels aos mockups nos temas claro e escuro",
    "Comportamento no Android, no iOS e na web (teclado, área segura, rolagem)",
    "Execução dos testes do app e da CI",
    "Fluxos de ponta a ponta contra a API e o banco, inclusive com os dados de exemplo",
    "Tempo de resposta e carregamento de imagens",
    "Deploy em app.maxx-unimax.com"
  ]
}
```
