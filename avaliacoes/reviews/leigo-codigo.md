# Review leigo, eixo 5. Código

- Status: ok
- Tentativa: 2
- Commit avaliado: 2a7dad587e67aec8c45df37ce7b59c1f3eccfe2c (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: f1d20e03-644e-4213-964b-e282ce39b68e

Texto do revisor, sem edição:

---
# Revisão do eixo 5. Código: produto `leigo`, commit `2a7dad587e67`

## Nota: 4 de 5

O código é pequeno (cerca de 1.500 linhas em `src/`), legível e organizado por responsabilidade. Na suíte de referência passou em todas as fronteiras de pontos que o produto declara e em 18 dos 19 casos de entrada inválida. As únicas duas dependências são reais, e não há sinal de alucinação. A nota não sobe para 5 por quatro motivos:
- não há CI;
- os testes próprios são um único teste de fluxo longo, sem testes de unidade da regra de pontos;
- falhou um caso de entrada inválida (comentário vazio);
- há duplicações pequenas e efeitos colaterais na hora do `require`.

A nota também não cai para 3: as fronteiras passam, quase todas as entradas inválidas são recusadas com 4xx, os testes próprios conferem a lógica de negócio com números exatos e não há duplicação relevante.

## Critério objetivo: suíte de referência

51 casos: 43 passaram, 1 falhou e 7 ficaram como ausentes.

- **Fronteiras de pontos (F1 a F8): 19 de 19 passaram.** Cobrem o valor de cada ação, os 5 prêmios, as 7 metas no limite exato (por exemplo 9→10 posts, 49→50 e 199→200 curtidas, 4→5 prêmios), a ação sobre o próprio conteúdo, o desfazer e a igualdade entre perfil, ranking e regra.
- **Entradas inválidas (E1 a E7): 18 de 19 passaram.** Falhou **E5-comentario**: `POST /posts/:id/comentar` com texto vazio responde 302 em vez de 4xx. A causa está em `src/app.js:257-264`: com o texto vazio, o `if (t)` simplesmente não grava nada e redireciona. Os pontos não mudam, mas a entrada inválida não é recusada.
- **Ranking (R1 a R5): 5 de 5 passaram.** Ordem decrescente, empatados na mesma posição e ordenados pelo nome, só alunos participam, ranking por curso começando em 1, posição do perfil igual à do ranking. R6 (ex-aluno) ficou ausente.
- **Tiers (T1 a T6): todos ausentes.** O produto não tem tiers, então as fronteiras 30/31, 70/71, 100/101 e 150/151 da rubrica não se aplicam.

## Justificativa e evidências

**Pontos fortes**
- **Regra de pontos num lugar só.** As constantes estão em `src/regras.js:4-29`. O cálculo é uma função pura, `calcular`, em `src/pontos.js:20-30`, e a ordenação e o desempate ficam em `posicionar`, em `src/pontos.js:33-39`. Os pontos são derivados dos dados, não acumulados num contador, então desfazer uma ação corrige o total sozinho (`src/pontos.js:2-3`). É uma escolha simples e correta, e o caso F6 confirma.
- **Escape automático de HTML.** O mini-template `html\`\`` com escape automático (`src/html.js:1-33`) usa padrão de projeto onde ajuda: o XSS fica protegido por construção, e o teste confere isso (`test/fluxo.test.js:75,86-90`).
- **Validação centralizada.**
  - Os erros mostrados ao usuário passam por uma classe própria, `ErroUsuario` (`src/app.js:23-28`), e por um único tratador de erro (`src/app.js:466-480`).
  - O id da rota é validado num só helper, `idParam` (`src/app.js:102-106`).
  - O redirecionamento só aceita caminhos internos, via `caminhoSeguro` (`src/app.js:99`).
- **Entradas validadas.** O tipo de medalha e o aluno são conferidos no banco (`src/app.js:334-337`), o curso contra uma lista branca (`src/app.js:170,372`) e o upload por tipo e tamanho (`src/app.js:31-42`).
- **Consultas sem N+1 no feed.** O feed carrega os itens em lote com `json_each` e `ROW_NUMBER` (`src/feed.js:32-47`).
- **Nomes consistentes em português** e comentários que explicam o porquê, por exemplo `src/db.js:11-12` e `src/feed.js:15`.

**Pontos fracos**
- **Testes próprios.** São 3 casos em `test/fluxo.test.js`, e um deles, "fluxo completo", tem cerca de 160 linhas (`:55-212`) e depende de ids fixos, como `/u/2` e `/admin/usuarios/4` (`:109,116,143`).
  - Não há testes de unidade de `calcular` nem de `posicionar`.
  - Empate no ranking, fronteiras das metas e comentário vazio não são testados.
  - A variável `psico` (`:183`) sobrou de uma lista de cursos antiga.
- **Sem CI.** Não existe `.github/` nem outra configuração de pipeline; a suíte só roda à mão com `npm test` (`package.json:10`).
- **Comentário vazio aceito em silêncio**, com resposta 302 (`src/app.js:258`). Era o único caso de entrada inválida que falhou na referência.
- **Entrada longa é cortada sem aviso** em vez de recusada (`src/app.js:101`, `texto = ... .slice(0, max)`), por exemplo legenda com mais de 2.200 caracteres ou comentário com mais de 500.
- **Efeitos colaterais na hora do `require`.**
  - `src/db.js:8-130` cria o schema, as tabelas e o admin ao ser importado.
  - `src/pontos.js:77-80` roda uma migração quando o módulo é carregado.
  - As migrações seguem dois mecanismos diferentes: `PRAGMA user_version` em `pontos.js` e checagem de `table_info` em `db.js:106`.
  - Na prática, o teste precisa definir as variáveis de ambiente antes de importar o app (`test/fluxo.test.js:8-13`).
- **Duplicações pequenas.**
  - `nome.split(' ')[0]` aparece em `src/views.js:196,214,333,345,470`, embora exista o helper `primeiroNome` em `src/views.js:548`.
  - A mesma consulta de tipos de medalha está repetida em `src/app.js:306,380`.
  - O teste "meta atingida" (`s[c.conta] >= c.meta`) está repetido em `src/pontos.js:21` e `src/views.js:437,471-472`, em vez de usar o `stats.conquistas` que já vem calculado.
- **Custo redundante.** `statsDoAluno` recalcula o ranking inteiro duas vezes a cada perfil aberto (`src/pontos.js:60-61`), embora `rankings()` (`:48-54`) já resolva os dois de uma vez.
- **`src/views.js` concentra todas as telas** num arquivo de cerca de 780 linhas. Continua legível porque está dividido em funções por componente, mas é o maior ponto de manutenção.
- **Troca de papel sem checar o usuário.** `/admin/usuarios/:id/papel` não confere se o usuário existe: o `UPDATE` não afeta nenhuma linha e a resposta é 302 (`src/app.js:454-460`).

## Regras ausentes (não entram na nota)
- Tiers Bronze, Prata, Ouro e Diamante com faixas de 1–30, 31–70, 71–100 e 101–150 pontos; por isso as fronteiras de tier da suíte ficaram ausentes.
- Progressão da mesma conquista para o tier seguinte.
- Distinção entre troféus e medalhas com peso diferente e cadastro de prêmios pelo corpo da faculdade. Os tipos de medalha são fixos no código (`src/regras.js:23-29`), e as conquistas são metas automáticas.
- Ex-aluno que mantém a posição no ranking mas não pontua mais.
- Professor que só dá medalha a quem leciona ou orienta. Hoje qualquer professor dá medalha a qualquer aluno (`src/app.js:333-346`).
- Rankings all-time, geral e por curso, separados dos rankings do período.
- Login por RA. Só existe login por e-mail (`src/app.js:143-151`), e o RA não está no modelo (`src/db.js:20-30`).
- Prova por foto e denúncia ou revogação de prêmio.
- Log de leitura do mural (quem leu e quando). Há só um marcador de último aviso visto por usuário (`src/db.js:106-110`).
- Mural com categorias Faculdade, Curso e Professores e filtro por público.
- Seguidores e seguindo.
- "Esqueci minha senha".

## Decisões do agente neste eixo (fora da nota)
- Calcular os pontos sempre a partir dos dados (posts, curtidas, comentários e medalhas), sem gravar um saldo.
- Conquistas automáticas com metas e bônus fixos (`src/regras.js:12-20`) e registro delas numa tabela à parte, só para o feed.
- Comentário vale pontos uma vez por post alheio (`COUNT(DISTINCT post_id)`), e curtir ou comentar o próprio post não pontua.
- Empate no ranking deixa os alunos na mesma posição, ordenados pelo nome (`src/pontos.js:33-39`).
- Mini-engine de templates própria com escape automático, em vez de usar uma biblioteca.
- Usar `node:sqlite` (`DatabaseSync`, Node 22.13 ou mais novo) sem ORM, com SQL escrito à mão.
- Migrações ad hoc com `PRAGMA user_version` e `ALTER TABLE` condicional.
- Suíte de integração ponta a ponta com `node:test` e `fetch`, sobre um banco temporário, em vez de testes de unidade.
- Truncar textos longos em silêncio e ignorar comentário vazio, em vez de recusar.
- Paginação do feed misturando posts, medalhas e conquistas numa consulta `UNION`.
- Módulo de acesso da banca (`src/banca.js`) com limite de tentativas por IP guardado em memória.

## O que não foi possível verificar só pela leitura
- Se `npm test` passa neste commit: não rodei a suíte própria.
- Se o app sobe sem erro. Só há a evidência indireta da suíte de referência, que subiu o produto.
- A cobertura real dos testes.
- O comportamento de `localeCompare('pt-BR')` com acentos no desempate do ranking, em outros runtimes.
- O desempenho de `statsDoAluno` e `rankings` com muitos alunos.
- Se `scripts/demo.js` e os scripts de publicação rodam sem erro.

```json
{
  "nota": 4,
  "justificativa": "Na suíte de referência, passou em 19/19 casos de fronteira da regra de pontos declarada, 18/19 entradas inválidas e 5/5 casos de ranking (ordem, empate, só alunos, por curso, perfil igual ao ranking); os 7 casos de tier e ex-aluno são ausentes. A regra de pontos vive num lugar só (regras.js) e é calculada por função pura (pontos.js:calcular/posicionar); a validação é centralizada (ErroUsuario, idParam, caminhoSeguro) e os templates escapam HTML automaticamente. As dependências são reais e não há sinal de alucinação. Não chega a 5 porque não há CI, os testes próprios são um único teste de integração longo com ids fixos e sem testes de unidade de calcular/posicionar, falhou o caso de comentário vazio (302 em vez de 4xx), há efeitos colaterais e migrações em dois mecanismos na hora do require, e há duplicações pequenas (primeiroNome, consulta de tipos de medalha, teste de meta atingida).",
  "evidencias": [
    {"local": "testes-referencia.md (resumo)", "descricao": "51 casos: 43 passaram, 1 falhou (E5-comentario), 7 ausentes (T1-T6 tiers, R6 ex-aluno). Todas as fronteiras F1-F8 e o ranking R1-R5 passaram."},
    {"local": "src/app.js:255-265", "descricao": "Comentário vazio: com 'if (t)' falso não grava nada e redireciona com 302 em vez de recusar com 4xx; único caso de entrada inválida que falhou na referência."},
    {"local": "src/regras.js:4-29", "descricao": "Constantes de pontos, conquistas e medalhas centralizadas num único módulo."},
    {"local": "src/pontos.js:20-39", "descricao": "calcular() é função pura; posicionar() ordena por total e depois nome e dá a mesma posição aos empatados; pontos derivados dos dados, então desfazer corrige o total (F6 passou)."},
    {"local": "src/html.js:1-33", "descricao": "Template tag com escape automático contra XSS: padrão usado onde ajuda; testado em test/fluxo.test.js:86-90."},
    {"local": "src/app.js:23-28,99-106,466-480", "descricao": "Erro do usuário tipado, validação de id e de redirecionamento e tratador de erro únicos: validação consistente."},
    {"local": "src/app.js:333-337", "descricao": "Medalha valida o papel, se o aluno existe e o tipo no banco; E1-E3 passaram com 400/403/404."},
    {"local": "test/fluxo.test.js:55-212", "descricao": "Testes próprios: 3 casos, um deles com cerca de 160 linhas e ids fixos (/u/2, /admin/usuarios/4); confere totais exatos (114 pts) e ordem do ranking, mas não testa unidades, empate, fronteiras de meta nem comentário vazio."},
    {"local": "test/fluxo.test.js:183", "descricao": "Variável 'psico' sobrando de uma lista de cursos antiga; nome inconsistente com o curso testado (Administração)."},
    {"local": "package.json:10", "descricao": "Script npm test existe, mas não há configuração de CI no repositório (sem .github/ nem pipeline)."},
    {"local": "src/db.js:8-130 e src/pontos.js:77-80", "descricao": "Schema, seed e migração executados ao importar o módulo; migrações por dois mecanismos diferentes (table_info em db.js:106 e PRAGMA user_version em pontos.js:77)."},
    {"local": "src/views.js:196,214,333,345,470 vs 548", "descricao": "nome.split(' ')[0] repetido cinco vezes embora exista o helper primeiroNome."},
    {"local": "src/app.js:306,380", "descricao": "Mesma consulta 'SELECT * FROM tipos_medalha ORDER BY pontos DESC' duplicada."},
    {"local": "src/pontos.js:21 e src/views.js:437,471-472", "descricao": "Teste de meta atingida (s[c.conta] >= c.meta) repetido na view em vez de usar stats.conquistas já calculado."},
    {"local": "src/pontos.js:56-63", "descricao": "statsDoAluno recalcula o ranking inteiro duas vezes por perfil aberto, embora rankings() já resolva os dois de uma vez."},
    {"local": "src/app.js:101", "descricao": "texto() corta entradas longas sem avisar (legenda acima de 2200, comentário acima de 500) em vez de recusar."},
    {"local": "src/app.js:454-460", "descricao": "Troca de papel não confere se o usuário existe; UPDATE sem efeito e resposta 302."}
  ],
  "regras_ausentes": [
    "Tiers Bronze/Prata/Ouro/Diamante com faixas 1-30, 31-70, 71-100, 101-150 (fronteiras de tier da suíte ausentes)",
    "Progressão da mesma conquista para o tier seguinte até Diamante",
    "Distinção troféu x medalha com peso diferente e cadastro de prêmios pelo corpo da faculdade",
    "Ex-aluno que mantém posição no ranking e não pontua mais",
    "Professor só dá medalha a alunos que leciona ou orienta",
    "Rankings all-time geral e all-time por curso",
    "Login por RA",
    "Prova por foto e denúncia/revogação de prêmio",
    "Log de leitura do mural (quem leu e quando)",
    "Categorias do mural (Faculdade, Curso, Professores) com filtro por público",
    "Seguidores e seguindo",
    "Esqueci minha senha"
  ],
  "decisoes_do_agente": [
    "Pontos calculados sempre a partir dos dados, sem saldo gravado",
    "Conquistas automáticas por meta com bônus fixos (regras.js:12-20) e tabela de registro para o feed",
    "Comentário pontua uma vez por post alheio; curtir ou comentar o próprio post não pontua",
    "Empate no ranking na mesma posição, ordenado pelo nome",
    "Mini-engine de templates própria com escape automático em vez de biblioteca",
    "node:sqlite (DatabaseSync) sem ORM, SQL escrito à mão",
    "Migrações ad hoc com PRAGMA user_version e ALTER TABLE condicional",
    "Suíte própria de integração ponta a ponta com node:test e fetch sobre banco temporário, sem testes de unidade",
    "Truncar textos longos sem avisar e ignorar comentário vazio em vez de recusar",
    "Feed paginado misturando posts, medalhas e conquistas numa consulta UNION",
    "Módulo de acesso da banca com limite de tentativas por IP em memória"
  ],
  "nao_verificado": [
    "Se npm test (suíte própria) passa neste commit",
    "Cobertura real dos testes",
    "Inicialização do app além da evidência indireta da suíte de referência",
    "Comportamento de localeCompare('pt-BR') com acentos no desempate em outros runtimes",
    "Desempenho de statsDoAluno e rankings com muitos alunos",
    "Execução de scripts/demo.js e dos scripts de publicação"
  ]
}
```
