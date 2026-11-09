# Review leigo_pu, eixo 6. Projeto e arquitetura

- Status: ok
- Tentativa: 1
- Commit avaliado: ce76942b7aa1ebb3a016df705972fc32483cf98f (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 8eb58f88-645a-48ea-83fc-48e0cb8aec3c

Texto do revisor, sem edição:

---
# Revisão do eixo 6, Projeto e arquitetura: `leigo_pu` (commit `ce76942b7aa1`)

## Nota: 4 de 5

Ficou mais perto do 3 do que do 5.

## Justificativa

**Camadas.** O backend está dividido por responsabilidade, de forma coerente com a stack escolhida (Node + Express 5, PostgreSQL ou PGlite, JavaScript puro numa PWA):
- `config.js` guarda a configuração lida do ambiente.
- `db.js` é um adaptador único para PGlite (local) ou PostgreSQL, com o mesmo SQL nos dois.
- `auth.js` cuida de sessão e senha.
- `rules.js` é o catálogo de pontos, medalhas e troféus.
- `services.js` concentra as regras de negócio: publicar, curtir, medalha, troféus, ranking.
- `index.js` tem as rotas.

**Onde as regras vivem.** As regras de pontuação estão quase todas em `rules.js`, e o próprio README diz que é ali que se mudam. O modelo de pontos em extrato (`points`), em que o ranking é a soma dos lançamentos, foi uma boa escolha. Ele dá o ranking "Sempre" e "Este mês" e o estorno de medalha ou curtida sem nenhum campo de total para manter em dia. No frontend, uma tabela de rotas e uma função `layout` comum deixam acrescentar telas sem retrabalho. O agente também justificou as decisões por escrito em `DECISOES.md`.

**Por que não é 5, e o que segura no limite do 4:**
1. **A camada de serviços cobre só metade do domínio.** `index.js` faz SQL direto e tem regra de negócio em vários pontos:
   - o cadastro e a validação do código de professor;
   - quem vê qual aviso;
   - só a secretaria fixa aviso;
   - a montagem de conquistas e do perfil;
   - a consulta do feed.

   Mudar uma regra do mural ou do cadastro exige mexer na rota, não no serviço.
2. **Há acoplamentos evitáveis.** `auth.js` importa `HttpError` de `services.js`. Algumas regras ficam fora de `rules.js`: `MEDALS_PER_DAY` e os limites de imagem estão em `services.js`. O frontend escreve "+10 pts" fixo no texto, embora a API já envie `postPoints`. O texto "de +20 a +100" também está escrito à mão em `rules.js`.
3. **O modelo de dados não representa as regras da ideia.**
   - Tiers, troféus e medalhas existem só como constantes no código. As tabelas guardam `code`/`type` em TEXT, sem chave estrangeira.
   - O tier é só um rótulo: não determina os pontos. Há troféu Prata valendo 80 e Ouro valendo 200.
   - Medalha não tem tier.
   - Não existe vínculo professor–turma–aluno, nem período letivo, nem estado de ex-aluno.
4. **Escala pensada para um TCC, não para o campus inteiro.** O ranking é recalculado inteiro a cada consulta. `positions()` roda o ranking completo a cada visita a um perfil. As fotos ficam em BYTEA no banco. O limite de tentativas fica na memória do processo, então não vale com mais de uma instância. O agente reconhece isso em `DECISOES.md:68`, mas não projetou para isso.
5. **O frontend é um arquivo só.** `public/app.js` tem cerca de 1.030 linhas misturando estado, chamadas à API, templates e eventos. Está organizado por seções, o que é coerente com a decisão de não ter etapa de build, mas é um ponto único de manutenção.

**Fidelidade à ideia.** O pitch está coberto, com lacunas (listadas abaixo como ausentes, sem descontar da nota): feed estilo Instagram com curtir e comentar, perfil com pontos e posição, mural, troféus e medalhas, ranking geral e por curso, cada um em "sempre" e "do mês".

## Evidências

- `server/rules.js:1-44`: catálogo central de pontos, medalhas e troféus. As regras de pontuação ficam localizadas aqui.
- `server/rules.js:22-36`: o tier é só rótulo (bronze, prata, ouro; não há diamante). Os pontos não seguem faixa por tier: `popular` é Prata e vale 80; `lenda` é Ouro e vale 200.
- `server/rules.js:42-43`: o texto "de +20 a +100" e "de +15 a +200" está fixo e não sai do catálogo.
- `server/schema.sql:82-92`: tabela `points` em extrato. O ranking é a soma, e o mensal sai de `created_at`.
- `server/schema.sql:65-80`: `medals.type` e `user_trophies.code` são TEXT sem chave estrangeira. O catálogo não está no banco.
- `server/schema.sql:17-29`: não há RA, período, estado de ex-aluno nem relação de turma. Os papéis estão num CHECK com aluno, professor e admin.
- `server/db.js:12-44`: adaptador único para PGlite e PostgreSQL.
- `server/services.js:162-186`: `MEDALS_PER_DAY` fica fora de `rules.js`, e qualquer professor (ou o admin) dá medalha a qualquer aluno.
- `server/services.js:200-222`: o ranking é agregado na hora, e `positions()` recalcula o ranking inteiro para achar uma posição.
- `server/index.js:104-135`: a regra de cadastro (domínio do e-mail, código de professor) está na rota.
- `server/index.js:360-387`: as regras do mural (quem vê o quê, só o admin fixa) estão na rota, com SQL direto.
- `server/index.js:42-55` e `203-219`: a consulta do feed está na camada de rotas.
- `server/auth.js:4`: `auth.js` depende de `services.js` só por causa do `HttpError`.
- `server/auth.js:73-88`: o limite de tentativas fica num Map em memória, o que não escala para várias instâncias.
- `public/app.js:474`: "+10 pts" escrito à mão, duplicando `POINTS.post`, que já vem em `/api/config` (`server/index.js:90`).
- `public/app.js:976-1011`: o roteador por tabela facilita incluir telas novas.
- `public/app.js:208-214`: a navegação de baixo tem Feed, Avisos, botão + (publicar ou dar medalha), Ranking e Conquistas. Não há Busca, e o Perfil fica no avatar do topo.
- `DECISOES.md:7-68`: as decisões estão justificadas, incluindo o limite de escala no item 12.
- `test/api.test.js:44-134`: são só 5 testes de API, ponta a ponta.

## Regras ausentes

Estas não entraram na nota:
- Login por RA; o cadastro não guarda RA.
- "Esqueci minha senha".
- Ex-aluno que mantém acesso e posição no ranking, mas não pontua mais.
- Tier Diamante.
- Tier determinando a pontuação (Bronze 1–30, Prata 31–70, Ouro 71–100, Diamante 101–150).
- Tier em medalhas.
- Progressão da mesma conquista para o tier de cima, com a trilha de progressão na tela.
- Professor dar medalha só a aluno que leciona ou orienta.
- Cadastro de troféus e medalhas pelo corpo da faculdade; o catálogo está fixo no código.
- Troféus por assiduidade, techdays e feiras, e prêmios concedidos por seminários e provas.
- Prova por foto, denúncia e revogação de prêmio marcado errado.
- Categorias Faculdade, Curso e Professores no mural, com filtro.
- Colapso e semi-colapso dos avisos, bolinha de não lido e "ler todos".
- Log de leitura dos avisos (ausência esperada pelo desenho do experimento).
- Notificações (o sino).
- Seguidores, seguindo e "followed by".
- "Último troféu" em destaque no perfil.
- Compartilhar post.
- Selo de conquista associado a um post de foto; as conquistas viram posts separados.
- Busca geral na navegação.
- Filtro "mostrar não obtidos".

## Decisões do agente sem o prompt pedir

1. Uma PWA em JavaScript puro, sem framework nem etapa de build, servida pelo próprio Express.
2. Um monólito Express com o código em camadas: config, db, auth, services, rules e rotas.
3. Um adaptador de banco duplo: PGlite local e PostgreSQL ou Neon quando há `DATABASE_URL`.
4. Fotos em BYTEA no banco, reduzidas no navegador para 1080 px antes do envio.
5. Pontos guardados como extrato, e o ranking como soma recalculada a cada consulta.
6. Ranking mensal pelo horário de Brasília com UTC-3 fixo, interpretando "geral" e "all-time" como "este mês" e "sempre".
7. Catálogo de medalhas (7 tipos) e troféus (13, automáticos por estatística) no código, não no banco.
8. Conquistas viram posts do feed, com `kind` igual a medalha ou troféu.
9. Só alunos publicam fotos e aparecem no ranking.
10. Papel admin, a secretaria, que pode moderar e fixar avisos.
11. Contas de visitante para a banca, com `is_guest`, um código no link e sessão de 7 dias.
12. Código de professor exigido no cadastro de professor.
13. Limites diários fixos: só as 3 primeiras fotos do dia pontuam, e cada professor dá até 30 medalhas por dia.
14. Retirar uma medalha estorna os pontos dela e os das curtidas no post da medalha. Troféu ganho nunca se perde.
15. Sessão guardada em tabela no banco, e limite de tentativas em memória.
16. Roteamento no navegador por hash (`#/`).
17. `render.yaml` para deploy no Render e o caminho alternativo pelo Cloudflare Tunnel.

## O que não pôde ser verificado

Só tive leitura, sem executar nada:
- Se o app sobe e se `npm test` passa.
- Se o mesmo SQL funciona de fato no PostgreSQL do Neon. O próprio agente diz que não testou (`DECISOES.md:59`).
- Como o ranking recalculado a cada consulta e as fotos em BYTEA se comportam com muitos usuários.
- Como as telas aparecem no navegador e se a navegação funciona de ponta a ponta.
- Se o deploy pelo `render.yaml` funciona.

```json
{
  "nota": 4,
  "justificativa": "Backend em camadas coerentes com a stack (config.js, db.js como adaptador PGlite/PostgreSQL, auth.js, rules.js como catálogo de regras, services.js com a lógica de negócio, index.js com as rotas), pontos em extrato (tabela points) que dá o ranking 'sempre' e 'do mês' e o estorno sem total para manter, regras de pontuação quase todas em rules.js, roteador por tabela no front e decisões justificadas em DECISOES.md. Fica no limite do 4 e longe do 5 porque: index.js faz SQL direto e tem regra de negócio (cadastro, visibilidade e fixação de avisos, montagem de perfil e conquistas, consulta do feed), então a camada de serviços cobre só metade do domínio; há acoplamentos evitáveis (auth.js importa HttpError de services.js; MEDALS_PER_DAY e limites de imagem fora de rules.js; '+10 pts' fixo no front); o modelo de dados não representa tiers, períodos nem o vínculo professor-aluno (catálogo só no código, tier como rótulo sem relação com os pontos, TEXT sem chave estrangeira); a escala é de TCC (ranking recalculado inteiro por consulta, positions() recalcula tudo a cada perfil, fotos em BYTEA, limite de tentativas em memória); o front é um arquivo único de cerca de 1.030 linhas. O pitch está coberto, com lacunas listadas como ausentes.",
  "evidencias": [
    {"local": "server/rules.js:1-44", "descricao": "Catálogo central de pontos, medalhas e troféus; as regras de pontuação ficam localizadas aqui."},
    {"local": "server/rules.js:22-36", "descricao": "Tier é só rótulo (bronze, prata, ouro; sem diamante) e não determina os pontos: 'popular' é Prata e vale 80, 'lenda' é Ouro e vale 200."},
    {"local": "server/rules.js:42-43", "descricao": "Textos 'de +20 a +100' e 'de +15 a +200' escritos à mão, sem sair do catálogo."},
    {"local": "server/schema.sql:82-92", "descricao": "Tabela points em extrato; o ranking é a soma e o mensal sai de created_at."},
    {"local": "server/schema.sql:65-80", "descricao": "medals.type e user_trophies.code em TEXT sem chave estrangeira; o catálogo não está no banco."},
    {"local": "server/schema.sql:17-29", "descricao": "users sem RA, período, estado de ex-aluno ou relação de turma; papéis num CHECK com aluno, professor e admin."},
    {"local": "server/db.js:12-44", "descricao": "Adaptador único para PGlite e PostgreSQL com o mesmo SQL."},
    {"local": "server/services.js:162-186", "descricao": "MEDALS_PER_DAY fora de rules.js; qualquer professor ou o admin dá medalha a qualquer aluno."},
    {"local": "server/services.js:200-222", "descricao": "Ranking agregado na hora; positions() recalcula o ranking inteiro para achar uma posição."},
    {"local": "server/index.js:104-135", "descricao": "Regra de cadastro (domínio do e-mail, código de professor) na camada de rotas."},
    {"local": "server/index.js:360-387", "descricao": "Regras do mural (visibilidade por curso, só o admin fixa) com SQL direto na rota."},
    {"local": "server/index.js:42-55", "descricao": "Consulta do feed (FEED_SELECT) definida na camada de rotas, fora de services.js."},
    {"local": "server/auth.js:4", "descricao": "auth.js depende de services.js só para usar HttpError."},
    {"local": "server/auth.js:73-88", "descricao": "Limite de tentativas num Map em memória; não vale com várias instâncias."},
    {"local": "public/app.js:474", "descricao": "'+10 pts' fixo no texto, duplicando POINTS.post, que já vem em /api/config (server/index.js:90)."},
    {"local": "public/app.js:976-1011", "descricao": "Roteador por tabela de rotas; incluir tela nova não exige retrabalho."},
    {"local": "public/app.js:208-214", "descricao": "Navegação de baixo com Feed, Avisos, +, Ranking e Conquistas; sem Busca, e o Perfil fica no avatar do topo."},
    {"local": "DECISOES.md:7-68", "descricao": "Decisões justificadas, incluindo o limite de escala reconhecido no item 12."},
    {"local": "test/api.test.js:44-134", "descricao": "Só 5 testes de API ponta a ponta."}
  ],
  "regras_ausentes": [
    "Login por RA; o cadastro não guarda RA",
    "Esqueci minha senha",
    "Ex-aluno que mantém acesso e posição no ranking, mas não pontua mais",
    "Tier Diamante",
    "Tier determinando a pontuação (Bronze 1-30, Prata 31-70, Ouro 71-100, Diamante 101-150)",
    "Tier em medalhas",
    "Progressão da mesma conquista para o tier de cima, com a trilha de progressão na tela",
    "Professor dar medalha só a aluno que leciona ou orienta",
    "Cadastro de troféus e medalhas pelo corpo da faculdade",
    "Troféus por assiduidade, techdays e feiras, e prêmios concedidos por seminários e provas",
    "Prova por foto, denúncia e revogação de prêmio marcado errado",
    "Categorias Faculdade, Curso e Professores no mural, com filtro",
    "Colapso e semi-colapso dos avisos, marcador de não lido e 'ler todos'",
    "Log de leitura dos avisos",
    "Notificações (sino)",
    "Seguidores, seguindo e 'followed by'",
    "'Último troféu' em destaque no perfil",
    "Compartilhar post",
    "Selo de conquista associado a um post de foto",
    "Busca geral na navegação",
    "Filtro 'mostrar não obtidos'"
  ],
  "decisoes_do_agente": [
    "PWA em JavaScript puro, sem framework nem etapa de build, servida pelo Express",
    "Monólito Express com o código em camadas: config, db, auth, services, rules e rotas",
    "Adaptador de banco duplo: PGlite local e PostgreSQL/Neon quando há DATABASE_URL",
    "Fotos em BYTEA no banco, reduzidas no navegador para 1080 px",
    "Pontos guardados como extrato, com ranking recalculado a cada consulta",
    "Ranking mensal pelo horário de Brasília (UTC-3 fixo), interpretando geral e all-time como 'este mês' e 'sempre'",
    "Catálogo de 7 medalhas e 13 troféus automáticos por estatística no código, não no banco",
    "Conquistas viram posts do feed (kind igual a medalha ou troféu)",
    "Só alunos publicam fotos e aparecem no ranking",
    "Papel admin (secretaria) com moderação e fixação de avisos",
    "Contas de visitante para a banca (is_guest), com código no link e sessão de 7 dias",
    "Código de professor exigido no cadastro de professor",
    "Limites diários fixos: 3 fotos pontuam por dia e cada professor dá até 30 medalhas por dia",
    "Retirar medalha estorna os pontos dela e das curtidas no post; troféu ganho nunca se perde",
    "Sessão em tabela no banco e limite de tentativas em memória",
    "Roteamento no navegador por hash",
    "render.yaml para deploy no Render e alternativa pelo Cloudflare Tunnel"
  ],
  "nao_verificado": [
    "Se o app sobe e se npm test passa",
    "Se o mesmo SQL funciona no PostgreSQL do Neon (o agente diz que não testou)",
    "Como o ranking recalculado por consulta e as fotos em BYTEA se comportam com muitos usuários",
    "Como as telas aparecem no navegador e se a navegação funciona de ponta a ponta",
    "Se o deploy pelo render.yaml funciona"
  ]
}
```
