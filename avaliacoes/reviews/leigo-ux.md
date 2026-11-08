# Review leigo, eixo 1. Experiência do usuário

- Status: ok
- Tentativa: 1
- Commit avaliado: 2a7dad587e67aec8c45df37ce7b59c1f3eccfe2c (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: d071c03a-0c79-45eb-bb17-4c7e10b09221

Texto do revisor, sem edição:

---
# Revisão do eixo 1 (Experiência do usuário): produto `leigo`, commit `2a7dad5`

## Nota: 4 de 5

## Justificativa

As seis telas da especificação existem e funcionam de ponta a ponta pela leitura do código: entrar/cadastrar, feed, perfil, mural, troféus e ranking. O produto é um app Express renderizado no servidor, sem JavaScript no cliente. O visual é coerente entre as telas: uma folha de estilo só (`public/estilo.css`), o mesmo componente de cartão, botões, selos e cores, e tema escuro automático. A navegação inferior é fixa e marca a aba ativa.

Os estados vazios e de erro estão bem tratados:
- Os formulários voltam com a mensagem de erro e com os dados já digitados.
- Há uma página de erro padrão para 403, 404 e 500.
- Imagem grande demais ou em formato não aceito gera uma mensagem clara.
- Os textos de "nenhum post" e "nenhum aviso" vêm com um botão para a próxima ação.

O agente também resolveu de forma sensata vários pontos que a especificação não cobre. Exemplos: "faltam N pontos para passar Fulano", a próxima conquista com barra de progresso, o extrato "De onde vêm os pontos" e o contador de avisos novos no ícone do Mural.

Não dei 5 porque há divergências em funções que existem e porque o estado de carregamento não é tratado:
- O Mural não é o botão central da navegação; o centro é "Postar".
- Troféus não aparece na navegação e só se chega a ele pelo perfil.
- No perfil, clicar nos pontos ou na posição não abre o ranking, embora a especificação peça isso.
- Troféus e medalhas aparecem como seções empilhadas, não como abas.
- O tema claro e escuro não tem botão; segue só a preferência do sistema.
- Não há indicação de carregamento nem bloqueio de duplo envio, inclusive no upload de foto.
- Quando o upload falha, a legenda digitada se perde.

São divergências de detalhe que não impedem o uso. As regras da ideia que não foram implementadas estão listadas como ausentes e não reduziram a nota.

## Evidências

**Entrar e cadastrar**
- `src/views.js:113-126`: o login é só por e-mail e senha. Não há RA nem "esqueci minha senha". Entrar e Cadastrar são duas páginas ligadas por link (`:123`, `:142`), não abas.
- `src/views.js:132` e `src/config.js:9`: a dica do cadastro lista três domínios, `@unimax.edu.br ou @al.unieduk.com.br ou @prof.unieduk.com.br`, misturando duas marcas. A especificação fala em `@unimax.com.br`, e o `README.md:8` diz que só `@unimax.edu.br` funciona. Isso confunde o usuário.
- `src/views.js:137,141` e `src/app.js:177`: o professor precisa escolher um curso obrigatório para se cadastrar. A dica manda "pedir à faculdade para liberar", mas e-mails `@prof.unieduk.com.br` já entram como professor. A mensagem é inconsistente com o comportamento.
- `src/app.js:147`, `src/app.js:173`: em caso de erro, os formulários voltam preenchidos com a mensagem. O login usa a mensagem genérica "E-mail ou senha incorretos.".

**Navegação**
- `src/views.js:84-90`: os itens são Início, Mural, Postar (no centro), Ranking e Perfil. Na especificação são Home, Busca, Mural (no centro), Troféus e Perfil.
- `src/views.js:60-63`: o Mural mostra uma bolinha com o número de avisos não vistos e tem `aria-label` descritivo.

**Feed**
- `src/views.js:148-192`: o cartão do post tem autor e curso, foto ou texto, curtir/descurtir, comentar, contagem de curtidas, legenda, os dois últimos comentários e um campo "Adicione um comentário…" no próprio feed. Falta o botão de compartilhar.
- `src/app.js:252,263`: depois de curtir ou comentar, a página recarrega e volta para a âncora do post (`#post-id`). Sem JavaScript, isso preserva a posição de rolagem de forma razoável.
- `src/views.js:195-225`: cartões de "ganhou medalha" e "desbloqueou conquista" no feed. É a aproximação possível do "selo de conquista associado ao post".
- `src/views.js:242`, `src/views.js:245-248`: estado vazio com chamada para a ação, e paginação "Mais recentes" e "Mais antigos".
- `src/views.js:253` com `:169-170`: na página de detalhe do post, o cartão mostra o link "Ver N comentários" apontando para a própria página, logo acima da lista de comentários. É redundante.

**Perfil**
- `src/views.js:310-316`: mostra pontos e posição no geral e no curso, mas como `<div>` sem link para o ranking. O único link é "prêmios", que leva aos troféus.
- `src/views.js:353-361`: a grade de posts em 3 colunas segue o estilo Instagram. Os prêmios ficam numa seção separada (`:385-414`), não na grade.
- `src/views.js:330-343`: o formulário de dar medalha só aparece para professor no perfil de aluno. Depois da entrega, aparece a mensagem "Medalha entregue! 🎉" (`src/app.js:294`).

**Mural**
- `src/views.js:688-737`: a lista é plana, sem categorias e sem colapso.
- `src/app.js:399-413`: abrir o mural marca tudo como lido. Os avisos não lidos aparecem com o selo "Novo" e uma borda colorida (`estilo.css:285`).
- `src/views.js:697-711`: o formulário de publicar fica recolhido num `<details>` e reabre sozinho se der erro.

**Troféus**
- `src/views.js:468-525`: há placar, a próxima conquista com barra de progresso e "Faltam N…", e as conquistas e medalhas obtidas aparecem antes das que faltam. Não há abas nem tiers.
- `src/views.js:479`: link "‹ Meu perfil" para voltar.

**Ranking**
- `src/views.js:552-561`: abas Geral e uma por curso, com "(meu curso)" primeiro e `aria-current`.
- `src/views.js:564-595`: o quadro "sua posição" diz quantos pontos faltam para passar o colega da frente e trata empate e liderança.
- `src/views.js:605-618`: pódio dos três primeiros.
- `src/views.js:621-641`: líderes de cada curso.
- `src/views.js:663-678`: seção "Como ganhar pontos".
- `src/views.js:565`: para professor e faculdade, explica que só alunos participam.

**Erros e carregamento**
- `src/app.js:466-480` e `src/views.js:768-770`: página de erro com mensagem amigável e botão Voltar (`history.back`).
- `src/app.js:475`: imagem acima do limite gera mensagem clara, mas numa página de erro solta. O formulário e a legenda se perdem.
- `src/views.js:285-290`: o envio de foto não tem indicação de progresso nem bloqueio de duplo clique. Nenhum formulário tem.
- `src/views.js:256`, `:731`: pede confirmação antes de apagar post e aviso.

**Visual e acessibilidade**
- `public/estilo.css:1-32`: variáveis de cor e tema escuro por `prefers-color-scheme`, sem botão para trocar.
- `public/estilo.css:106-107`: `.alerta` e `.sucesso` usam cores claras fixas também no tema escuro. Continuam legíveis, mas destoam do resto.
- `src/views.js:427`: barras com `role="progressbar"`.
- `src/views.js:159`: botão de curtir com `aria-label` Curtir/Descurtir.
- `public/estilo.css:61`: layout em coluna de no máximo 560px, pensado para celular.

## Regras ausentes (não reduziram a nota)
- Login por RA; RA no cadastro.
- "Esqueci minha senha".
- Botão para alternar entre tema claro e escuro (o tema escuro existe, mas só automático).
- Semestre no perfil e no cartão de post.
- Status de ex-aluno (mantém acesso e ranking, mas não pontua).
- Sino de notificações no topo.
- Busca na navegação.
- Compartilhar post.
- Seguidores, seguindo e "followed by".
- "Último troféu" em destaque no perfil.
- Prêmios e fotos de troféus misturados na grade do perfil.
- Categorias do mural (Faculdade, Curso, Professores) e filtro por categoria.
- Colapso e semi-colapso dos avisos com tela quase cheia e botão voltar.
- Mural mostrando a cada aluno só o que lhe diz respeito.
- Log de leitura de avisos (quem leu e quando). É a diferença de escopo esperada para a trilha leiga.
- Abas Troféus | Medalhas.
- Tiers Bronze, Prata, Ouro e Diamante, com as faixas de pontos.
- Nível de "encontrabilidade".
- Filtro "mostrar não obtidos".
- Progressão de tier da mesma conquista.
- Prêmios com prova por foto, denúncia e revogação.
- Medalha só entre professor e aluno que têm aula juntos.
- Cadastro de troféus e medalhas pela faculdade pela interface.
- Rankings all-time (geral e por curso).
- Abrir o ranking ao clicar nos pontos ou na posição do perfil.

## Decisões do agente
Dentro deste eixo, tomadas sem o prompt pedir:
- Caixa "Banca do TCC" na tela de entrar, com código de acesso e escolha entre Aluno(a), Professor(a) e Faculdade.
- "Postar" como botão central da navegação; Ranking na navegação no lugar de Troféus.
- Cartões automáticos de "ganhou medalha" e "desbloqueou conquista" misturados aos posts no feed.
- Comentar direto no feed, mostrando os dois últimos comentários.
- Posts só de texto com fundo em degradê.
- Faixa do aviso fixado no topo do feed.
- Paginação do feed com "Mais recentes" e "Mais antigos".
- Avatar com a inicial do nome e cor derivada do id.
- Extrato "De onde vêm os pontos" no perfil.
- Card "Sua próxima conquista" com barra de progresso e "Faltam N…".
- No ranking: frase "faltam N pontos para passar Fulano", pódio, líderes de cada curso e seção "Como ganhar pontos".
- Empatados na mesma posição do ranking.
- Selo "Você" no ranking e na tela de administração.
- Contador de avisos não vistos no ícone do Mural; abrir o Mural marca tudo como lido.
- Selos "Novo" e "📌 Fixado"; só a faculdade fixa avisos.
- Tela de Administração para definir papéis, acessível pelo topo.
- Professor definido automaticamente pelo domínio do e-mail.
- Tema escuro automático por preferência do sistema.
- Datas relativas ("há 3 h").
- Confirmação antes de apagar post e aviso.
- Página de erro padrão "Ops!" com botão Voltar.

## Não verificado (só leitura)
- A renderização real das telas no navegador: layout, contraste no tema escuro, quebra de linha das abas e do pódio em telas estreitas.
- Se o fluxo completo roda sem erro. O `test/fluxo.test.js` existe, mas não pude executá-lo.
- O comportamento de rolagem até a âncora depois de curtir ou comentar.
- O tempo de resposta e a falta de retorno visual durante o upload de imagens no deploy do Azure. O README cita uma espera de 20 a 30 segundos quando o plano gratuito "cochila".
- Se o deploy em `maxx-guilherme.azurewebsites.net` está no ar e corresponde a este commit.
- A acessibilidade real com leitor de tela.

```json
{
  "nota": 4,
  "justificativa": "As seis telas existem e são utilizáveis de ponta a ponta pela leitura do código (SSR em Express, sem JS no cliente). Visual coerente com uma folha de estilo única, componentes repetidos, tema escuro automático e navegação inferior fixa com aba ativa. Estados vazios e de erro bem tratados: formulários re-renderizados com mensagem e dados preservados, página de erro padrão, mensagens claras de upload, estados vazios com chamada para a ação. O agente resolveu com bom senso o que a especificação não diz (quanto falta para passar o colega, próxima conquista com progresso, extrato de pontos, contador de avisos novos). Não chega a 5 por divergências em funções existentes: Mural não é o botão central (é 'Postar'), Troféus fora da navegação, pontos e posição do perfil não abrem o ranking, troféus e medalhas como seções e não abas, tema escuro sem botão, cadastro listando três domínios de marcas diferentes, professor obrigado a escolher curso. Também não há indicação de carregamento nem bloqueio de duplo envio, e a legenda se perde quando o upload falha. As regras ausentes não reduziram a nota.",
  "evidencias": [
    {"local": "src/views.js:113-126", "descricao": "Login só por e-mail e senha; sem RA e sem 'esqueci minha senha'; Entrar e Cadastrar são páginas separadas ligadas por link, não abas."},
    {"local": "src/views.js:132 / src/config.js:9", "descricao": "Dica do cadastro lista '@unimax.edu.br ou @al.unieduk.com.br ou @prof.unieduk.com.br', misturando marcas; diverge da especificação (@unimax.com.br) e do README.md:8."},
    {"local": "src/views.js:137,141 / src/app.js:177", "descricao": "Professor precisa escolher curso obrigatório; a dica manda pedir liberação à faculdade, mas o domínio prof já entra como professor automaticamente."},
    {"local": "src/app.js:147,173", "descricao": "Erros de login e cadastro re-renderizam o formulário com mensagem e valores preservados."},
    {"local": "src/views.js:84-90", "descricao": "Navegação: Início, Mural, Postar (centro), Ranking, Perfil. Especificação: Home, Busca, Mural (centro), Troféus, Perfil."},
    {"local": "src/views.js:60-63", "descricao": "Bolinha com contagem de avisos não vistos no ícone do Mural, com aria-label descritivo."},
    {"local": "src/views.js:148-192", "descricao": "Cartão de post com autor e curso, foto ou texto, curtir/descurtir, comentar, contagem de curtidas, legenda, últimos comentários e campo de comentário no feed; sem compartilhar."},
    {"local": "src/app.js:252,263", "descricao": "Curtir e comentar fazem POST com redirect para a âncora do post, mantendo a posição no feed sem JavaScript."},
    {"local": "src/views.js:195-225", "descricao": "Cartões de medalha e conquista no feed, aproximando o selo de conquista do post."},
    {"local": "src/views.js:242,245-248", "descricao": "Estado vazio do feed com botão 'Faça o primeiro post' e paginação Mais recentes / Mais antigos."},
    {"local": "src/views.js:253 + 169-170", "descricao": "Na página do post, o link 'Ver N comentários' aponta para a própria página, acima da lista de comentários: redundante."},
    {"local": "src/views.js:310-316", "descricao": "Perfil mostra pontos e posição geral e no curso como <div> sem link; clicar não abre o ranking, como a especificação pede."},
    {"local": "src/views.js:353-361", "descricao": "Grade de posts em 3 colunas estilo Instagram; prêmios ficam em seção separada (385-414)."},
    {"local": "src/views.js:330-343 / src/app.js:294", "descricao": "Formulário de medalha visível só para professor no perfil de aluno; mensagem de sucesso após a entrega."},
    {"local": "src/views.js:688-737", "descricao": "Mural como lista plana, sem categorias e sem colapso; selos Novo e Fixado; formulário de publicar recolhido que reabre em caso de erro."},
    {"local": "src/app.js:399-413", "descricao": "Abrir o mural marca todos os avisos como lidos (mural_visto_id)."},
    {"local": "src/views.js:468-525", "descricao": "Troféus: placar, próxima conquista com barra e 'Faltam N', obtidos antes dos que faltam, link de voltar ao perfil; seções empilhadas em vez de abas Troféus | Medalhas."},
    {"local": "src/views.js:552-595", "descricao": "Ranking com abas Geral e por curso (meu curso primeiro, aria-current) e quadro 'sua posição' com pontos para passar o colega da frente, tratando empate e liderança."},
    {"local": "src/views.js:605-678", "descricao": "Pódio dos três primeiros, líderes de cada curso e seção 'Como ganhar pontos'."},
    {"local": "src/app.js:466-480 / src/views.js:768-770", "descricao": "Tratamento de erro central com mensagem amigável e botão Voltar; erro de tamanho de imagem descarta o formulário e a legenda."},
    {"local": "src/views.js:285-290", "descricao": "Upload de foto sem indicação de progresso e sem bloqueio de duplo envio, como os demais formulários."},
    {"local": "src/views.js:256,731", "descricao": "Confirmação antes de apagar post e aviso."},
    {"local": "public/estilo.css:1-32", "descricao": "Variáveis de cor com tema escuro automático por prefers-color-scheme, sem botão para alternar."},
    {"local": "public/estilo.css:106-107", "descricao": ".alerta e .sucesso com cores claras fixas também no tema escuro; destoam do restante."},
    {"local": "src/views.js:159,427", "descricao": "Cuidados de acessibilidade: aria-label Curtir/Descurtir e role=progressbar nas barras."}
  ],
  "regras_ausentes": [
    "Login por RA e RA no cadastro",
    "Esqueci minha senha",
    "Botão para alternar tema claro e escuro (só automático)",
    "Semestre no perfil e no cartão de post",
    "Status de ex-aluno que mantém acesso e ranking sem pontuar",
    "Sino de notificações no topo",
    "Busca na navegação inferior",
    "Compartilhar post",
    "Seguidores, seguindo e 'followed by'",
    "Último troféu em destaque no perfil",
    "Prêmios e fotos de troféus na grade do perfil",
    "Categorias do mural (Faculdade, Curso, Professores) e filtro por categoria",
    "Colapso e semi-colapso dos avisos com visão quase em tela cheia",
    "Mural mostrando a cada aluno só o que lhe diz respeito",
    "Log de leitura de avisos (quem leu e quando)",
    "Abas Troféus | Medalhas",
    "Tiers Bronze, Prata, Ouro e Diamante com faixas de pontos",
    "Nível de encontrabilidade",
    "Filtro 'mostrar não obtidos'",
    "Progressão de tier da mesma conquista",
    "Prêmios com prova por foto, denúncia e revogação",
    "Medalha restrita a professor que dá aula ao aluno",
    "Cadastro de troféus e medalhas pela faculdade via interface",
    "Rankings all-time geral e por curso",
    "Abrir o ranking ao clicar nos pontos ou na posição do perfil"
  ],
  "decisoes_do_agente": [
    "Caixa 'Banca do TCC' na tela de entrar, com código de acesso e escolha de perfil (Aluno, Professor, Faculdade)",
    "'Postar' como botão central da navegação e Ranking no lugar de Troféus",
    "Cartões automáticos de medalha e conquista misturados aos posts no feed",
    "Comentar direto no feed, mostrando os dois últimos comentários",
    "Posts só de texto com fundo em degradê",
    "Faixa do aviso fixado no topo do feed",
    "Paginação do feed com Mais recentes / Mais antigos",
    "Avatar com a inicial do nome e cor derivada do id",
    "Extrato 'De onde vêm os pontos' no perfil",
    "Card 'Sua próxima conquista' com barra de progresso e 'Faltam N'",
    "Frase 'faltam N pontos para passar Fulano' no ranking",
    "Pódio dos três primeiros, líderes de cada curso e seção 'Como ganhar pontos' no ranking",
    "Empatados na mesma posição do ranking",
    "Selo 'Você' no ranking e na tela de administração",
    "Contador de avisos não vistos no ícone do Mural e marcação de tudo como lido ao abrir",
    "Selos Novo e Fixado no mural, com fixação restrita à faculdade",
    "Tela de Administração para definir papéis, acessível pelo topo",
    "Papel de professor definido automaticamente pelo domínio do e-mail",
    "Tema escuro automático por prefers-color-scheme",
    "Datas relativas ('há 3 h')",
    "Confirmação antes de apagar post e aviso",
    "Página de erro padrão 'Ops!' com botão Voltar"
  ],
  "nao_verificado": [
    "Renderização real no navegador (layout, contraste no tema escuro, quebra das abas e do pódio em telas estreitas)",
    "Execução do fluxo completo: test/fluxo.test.js não pôde ser rodado",
    "Rolagem até a âncora após curtir ou comentar",
    "Tempo de resposta e falta de retorno durante upload no deploy Azure, incluindo a espera de 20 a 30 s do plano gratuito",
    "Se o deploy em maxx-guilherme.azurewebsites.net está no ar e corresponde a este commit",
    "Acessibilidade real com leitor de tela"
  ]
}
```
