# Testes de referência: leigo

- Commit avaliado: `2a7dad587e67aec8c45df37ce7b59c1f3eccfe2c` (Ref `main` de `.\maxx-leigo`)
- Data: 2026-11-08 23:12:20 -03:00
- Suíte: `avaliacoes/testes-referencia` no commit `c5705fa` do tcc, adaptador `leigo`
- Ambiente: SO Microsoft Windows 11 Pro 10.0.26200; PowerShell 5.1.26100.9278; node v22.18.0; npm 10.9.3; package-lock sha256 e761b52fc7fe0ae4; comando do produto node --disable-warning=ExperimentalWarning src/server.js; dados do produto pasta temporária nova (MAXX_DADOS), banco SQLite vazio; acesso da banca desligado (CODIGO_BANCA vazio)
- Porta do produto: 3100 (primeira porta livre a partir de 3100)
- Duração dos casos: 26 s

## Resumo

51 casos: 43 passou, 1 falhou, 7 ausente.

Critérios: o esperado vem só da regra declarada pelo produto (abaixo). Entrada inválida passa quando o produto recusa com 4xx e os pontos não mudam. Regra que o produto não tem sai "ausente", nunca como falha (rubrica, "Regra ausente").

## Regra declarada usada como esperado

- Fontes: `README.md:90-98 (tabela "Como funcionam os pontos")`, `src/regras.js:4-8 (PONTOS)`, `src/regras.js:12-20 (CONQUISTAS)`, `src/regras.js:23-29 (MEDALHAS_PADRAO)`, `src/pontos.js:1-3, 18, 32-34 (cálculo e ranking)`
- Ações: publicar 10, curtidaRecebida 2, comentarioEmPostAlheio 3
- Prêmios: Excelência acadêmica 50, Projeto destaque 40, Ideia brilhante 30, Ajudou os colegas 30, Participação em aula 20
- Metas: primeiro_post (posts >= 1, +20), fotografo (posts >= 10, +50), bom_de_papo (comentarios >= 10, +30), popular (curtidas >= 50, +50), estrela (curtidas >= 200, +100), medalhista (premios >= 1, +20), colecionador (premios >= 5, +60)
- Ranking: participa aluno; empate "mesma-posicao"; ordem no empate "nome"
- Tiers: não tem; ex-alunos: não tem
- Nota (F8): Ambiguidade: o README.md:94 diz "Comentar no post de um colega", e professor não é colega óbvio; o código (src/pontos.js:10-11) conta o post de qualquer outro autor, inclusive professor. O caso testa o que o código declara; a ambiguidade fica registrada, não é contada como falha. A curtida de professor em post de aluno é "curtida de outra pessoa" (README.md:93), sem ambiguidade.
- Capacidades informadas pelo adaptador: {"tiers":false,"exAlunos":false,"rankingPorCurso":true,"premios":true,"cursos":["Administração","Ciência da Computação","Inteligência Artificial","Medicina"],"evidenciaAusencia":{"tiers":"O produto não tem tiers: o código do commit avaliado não tem tier, Bronze, Prata nem Diamante (\"ouro\" só aparece como classe CSS em src/views.js:454); prêmios valem pontos fixos (src/regras.js:23-29). Conferido no ar: telas de ranking e perfil com 0 menção(ões) a tier.","exAlunos":"O produto não tem ex-alunos: usuarios.papel só admite aluno, professor e admin (src/db.js:25), sem status de formado."}}

## F. Regra de pontos (fronteiras)

| Caso | Descrição | Resultado | Evidência |
|---|---|---|---|
| F1-publicar | Publicar um post vale exatamente o declarado | passou | ok: antes: esperado 0 (nada), obtido 0<br>ok: depois de 1 post: esperado 30 (1 post(s) x 10 + meta primeiro_post +20), obtido 30 |
| F1-curtida | Curtida recebida de outra pessoa vale exatamente o declarado | passou | ok: autor antes da curtida: esperado 30 (1 post(s) x 10 + meta primeiro_post +20), obtido 30<br>ok: autor depois da curtida: esperado 32 (1 post(s) x 10 + 1 curtida(s) x 2 + meta primeiro_post +20), obtido 32<br>ok: quem curtiu: esperado 0 (nada), obtido 0 |
| F1-comentario | Comentar post alheio vale exatamente o declarado | passou | ok: quem comentou: esperado 3 (1 comentário(s) x 3), obtido 3<br>ok: autor do post (receber comentário não vale): esperado 30 (1 post(s) x 10 + meta primeiro_post +20), obtido 30 |
| F2-excelencia | Prêmio "Excelência acadêmica" vale exatamente 50 | passou | ok: depois do prêmio: esperado 70 (prêmio excelencia 50 + meta medalhista +20), obtido 70 |
| F2-projeto | Prêmio "Projeto destaque" vale exatamente 40 | passou | ok: depois do prêmio: esperado 60 (prêmio projeto 40 + meta medalhista +20), obtido 60 |
| F2-ideia | Prêmio "Ideia brilhante" vale exatamente 30 | passou | ok: depois do prêmio: esperado 50 (prêmio ideia 30 + meta medalhista +20), obtido 50 |
| F2-ajudou | Prêmio "Ajudou os colegas" vale exatamente 30 | passou | ok: depois do prêmio: esperado 50 (prêmio ajudou 30 + meta medalhista +20), obtido 50 |
| F2-participacao | Prêmio "Participação em aula" vale exatamente 20 | passou | ok: depois do prêmio: esperado 40 (prêmio participacao 20 + meta medalhista +20), obtido 40 |
| F3-primeiro_post | Meta "primeiro_post" (posts >= 1, +20): 0 sem bônus, 1 com bônus | passou | ok: posts = 0: esperado 0 (nada), obtido 0<br>ok: posts = 1: esperado 30 (1 post(s) x 10 + meta primeiro_post +20), obtido 30 |
| F3-fotografo | Meta "fotografo" (posts >= 10, +50): 9 sem bônus, 10 com bônus | passou | ok: posts = 9: esperado 110 (9 post(s) x 10 + meta primeiro_post +20), obtido 110<br>ok: posts = 10: esperado 170 (10 post(s) x 10 + meta primeiro_post +20 + meta fotografo +50), obtido 170 |
| F3-bom_de_papo | Meta "bom_de_papo" (comentarios >= 10, +30): 9 sem bônus, 10 com bônus | passou | ok: comentarios = 9: esperado 27 (9 comentário(s) x 3), obtido 27<br>ok: comentarios = 10: esperado 60 (10 comentário(s) x 3 + meta bom_de_papo +30), obtido 60 |
| F3-popular | Meta "popular" (curtidas >= 50, +50): 49 sem bônus, 50 com bônus | passou | ok: curtidas = 49: esperado 128 (1 post(s) x 10 + 49 curtida(s) x 2 + meta primeiro_post +20), obtido 128<br>ok: curtidas = 50: esperado 180 (1 post(s) x 10 + 50 curtida(s) x 2 + meta primeiro_post +20 + meta popular +50), obtido 180 |
| F3-estrela | Meta "estrela" (curtidas >= 200, +100): 199 sem bônus, 200 com bônus | passou | ok: curtidas = 199: esperado 478 (1 post(s) x 10 + 199 curtida(s) x 2 + meta primeiro_post +20 + meta popular +50), obtido 478<br>ok: curtidas = 200: esperado 580 (1 post(s) x 10 + 200 curtida(s) x 2 + meta primeiro_post +20 + meta popular +50 + meta estrela +100), obtido 580 |
| F3-medalhista | Meta "medalhista" (premios >= 1, +20): 0 sem bônus, 1 com bônus | passou | ok: premios = 0: esperado 0 (nada), obtido 0<br>ok: premios = 1: esperado 40 (prêmio participacao 20 + meta medalhista +20), obtido 40 |
| F3-colecionador | Meta "colecionador" (premios >= 5, +60): 4 sem bônus, 5 com bônus | passou | ok: premios = 4: esperado 100 (prêmio participacao 20 + prêmio participacao 20 + prêmio participacao 20 + prêmio participacao 20 + meta medalhista +20), obtido 100<br>ok: premios = 5: esperado 180 (prêmio participacao 20 + prêmio participacao 20 + prêmio participacao 20 + prêmio participacao 20 + prêmio participacao 20 + meta medalhista +20 + meta colecionador +60), obtido 180 |
| F4 | Ação sobre o próprio conteúdo segue a regra (curtir e comentar o próprio post) | passou | ok: curtiu e comentou o próprio post (regra: não vale): esperado 30 (1 post(s) x 10 + meta primeiro_post +20), obtido 30 |
| F5 | Ações fora da regra valem 0 (editar perfil, receber comentário, abrir páginas) | passou | ok: depois de editar perfil, receber comentário e abrir páginas: esperado 30 (1 post(s) x 10 + meta primeiro_post +20), obtido 30 |
| F6 | Desfazer a ação tira os pontos (descurtir, apagar post) | passou | ok: com a curtida: esperado 32 (1 post(s) x 10 + 1 curtida(s) x 2 + meta primeiro_post +20), obtido 32<br>ok: depois de descurtir: esperado 30 (1 post(s) x 10 + meta primeiro_post +20), obtido 30<br>ok: depois de apagar o post: esperado 0 (nada), obtido 0 |
| F7 | Total do perfil igual ao do ranking e à regra, com estado misto | passou | ok: perfil: esperado 90 (2 post(s) x 10 + 2 curtida(s) x 2 + 2 comentário(s) x 3 + prêmio participacao 20 + meta primeiro_post +20 + meta medalhista +20), obtido 90<br>ok: ranking geral: esperado 90, obtido 90 |
| F8 | Interação com quem não participa do ranking (professor) segue a regra | passou | ok: aluno que comentou post de professor: esperado 3 (1 comentário(s) x 3), obtido 3<br>ok: depois da curtida do professor (curtida de outra pessoa): esperado 35 (1 post(s) x 10 + 1 curtida(s) x 2 + 1 comentário(s) x 3 + meta primeiro_post +20), obtido 35<br>nota: Ambiguidade: o README.md:94 diz "Comentar no post de um colega", e professor não é colega óbvio; o código (src/pontos.js:10-11) conta o post de qualquer outro autor, inclusive professor. O caso testa o que o código declara; a ambiguidade fica registrada, não é contada como falha. A curtida de professor em post de aluno é "curtida de outra pessoa" (README.md:93), sem ambiguidade. |

## E. Entradas inválidas

| Caso | Descrição | Resultado | Evidência |
|---|---|---|---|
| E1-ausente | Prêmio com campo do tipo ausente (nulo) é recusado e não pontua | passou | ok: recusa com 4xx: status 400, Ops! Escolha uma medalha válida. Voltar<br>ok: aluno alvo: esperado 0 (nada), obtido 0 |
| E1-vazio | Prêmio com tipo vazio é recusado e não pontua | passou | ok: recusa com 4xx: status 400, Ops! Escolha uma medalha válida. Voltar<br>ok: aluno alvo: esperado 0 (nada), obtido 0 |
| E1-texto | Prêmio com tipo com texto onde se espera id é recusado e não pontua | passou | ok: recusa com 4xx: status 400, Ops! Escolha uma medalha válida. Voltar<br>ok: aluno alvo: esperado 0 (nada), obtido 0 |
| E1-decimal | Prêmio com tipo decimal é recusado e não pontua | passou | ok: recusa com 4xx: status 400, Ops! Escolha uma medalha válida. Voltar<br>ok: aluno alvo: esperado 0 (nada), obtido 0 |
| E1-negativo | Prêmio com tipo negativo é recusado e não pontua | passou | ok: recusa com 4xx: status 400, Ops! Escolha uma medalha válida. Voltar<br>ok: aluno alvo: esperado 0 (nada), obtido 0 |
| E1-inexistente | Prêmio com tipo com id inexistente é recusado e não pontua | passou | ok: recusa com 4xx: status 400, Ops! Escolha uma medalha válida. Voltar<br>ok: aluno alvo: esperado 0 (nada), obtido 0 |
| E2-inexistente | Prêmio para aluno inexistente é recusado | passou | ok: recusa com 4xx: status 400, Ops! Medalhas só podem ser dadas para alunos. Voltar |
| E2-idtexto | Prêmio para id de aluno em texto é recusado | passou | ok: recusa com 4xx: status 404, Ops! Página não encontrada. Voltar |
| E2-naoparticipa | Prêmio para quem não participa (professor) é recusado | passou | ok: recusa com 4xx: status 400, Ops! Medalhas só podem ser dadas para alunos. Voltar<br>ok: professor alvo fora do ranking: ok |
| E3 | Prêmio concedido por quem não tem permissão (aluno) é recusado | passou | ok: recusa com 4xx: status 403, Ops! Você não tem permissão para fazer isso. Voltar<br>ok: aluno alvo: esperado 0 (nada), obtido 0<br>ok: aluno que tentou: esperado 0 (nada), obtido 0 |
| E4-curtir-inexistente | Curtir post inexistente é recusado | passou | ok: recusa com 4xx: status 404, Ops! Esse post não existe mais. Voltar<br>ok: quem tentou: esperado 0 (nada), obtido 0 |
| E4-curtir-idtexto | Curtir post com id em texto é recusado | passou | ok: recusa com 4xx: status 404, Ops! Página não encontrada. Voltar<br>ok: quem tentou: esperado 0 (nada), obtido 0 |
| E4-comentar-inexistente | Comentar post inexistente é recusado | passou | ok: recusa com 4xx: status 404, Ops! Esse post não existe mais. Voltar<br>ok: quem tentou: esperado 0 (nada), obtido 0 |
| E5-post | Post vazio (sem foto e sem texto) é recusado e não pontua | passou | ok: recusa com 4xx: status 400, Novo post Adicione uma foto ou escreva algo. Foto (JPG, PNG, WEBP ou GIF, até 5 MB) Legenda Publicar Cada post vale 10 p<br>ok: quem tentou: esperado 0 (nada), obtido 0 |
| E5-comentario | Comentário vazio é recusado e não pontua | **falhou** | FALHA: recusa com 4xx: status 302, redirecionou para /posts/35#comentar<br>ok: quem tentou: esperado 0 (nada), obtido 0<br>ok: autor do post: esperado 30 (1 post(s) x 10 + meta primeiro_post +20), obtido 30 |
| E6-curtida | A mesma curtida repetida não soma duas vezes | passou | ok: sem erro de servidor: status 302<br>ok: autor com no máximo uma curtida (32, ou 30 se a repetição desfaz): obtido 30 (a repetição desfez a curtida) |
| E6-comentario | O mesmo post comentado duas vezes segue a regra declarada | passou | ok: dois comentários no mesmo post (regra: conta uma vez): esperado 3 (1 comentário(s) x 3), obtido 3 |
| E6-premio | O mesmo prêmio concedido duas vezes segue a regra declarada | passou | ok: prêmio repetido (regra: soma): esperado 60 (prêmio participacao 20 + prêmio participacao 20 + meta medalhista +20), obtido 60 |
| E7 | Filtro de ranking inválido não quebra | passou | ok: sem erro de servidor: status 200, 🏆 Ranking Todos os alunos da UniMax, pelos pontos ganhos no Maxx. Geral 246 Administração (meu curso) 246 Ciência da Co |

## R. Ranking

| Caso | Descrição | Resultado | Evidência |
|---|---|---|---|
| R1 | Ranking em ordem decrescente de pontos, no geral e no curso | passou | ok: geral: pontos em ordem decrescente (251 linhas): ok<br>ok: alunos montados na ordem esperada (Carla, os dois empatados, Bruno, Zélia): linhas 11, 18, 17, 29, 251<br>ok: curso Ciência da Computação: pontos em ordem decrescente (5 linhas): ok |
| R2 | Desempate pela política declarada | passou | ok: geral: posições pela política "mesma-posicao": ok<br>ok: geral: empatados em ordem de nome: ok<br>ok: pontos dos dois empatados montados: esperado 40, obtido 40<br>ok: empatados montados na mesma posição: esperado 14, obtido 14<br>ok: curso Ciência da Computação: posições pela política "mesma-posicao": ok<br>ok: curso Ciência da Computação: empatados em ordem de nome: ok<br>nota: política declarada: empate "mesma-posicao", ordem no empate "nome" |
| R3 | Quem não participa fica fora do ranking, no geral e no curso | passou | ok: geral sem não participantes: ok<br>ok: curso Administração sem não participantes: ok<br>ok: curso Ciência da Computação sem não participantes: ok<br>ok: curso Inteligência Artificial sem não participantes: ok<br>ok: curso Medicina sem não participantes: ok<br>nota: participa: aluno; 21 usuários não participantes criados pela suíte |
| R4 | Ranking por curso só tem alunos do curso e começa em 1 | passou | ok: curso Administração: só alunos do curso (247): ok<br>ok: curso Administração: primeira posição: esperado 1, obtido 1<br>ok: curso Ciência da Computação: só alunos do curso (5): ok<br>ok: curso Ciência da Computação: primeira posição: esperado 1, obtido 1<br>nota: curso Inteligência Artificial: vazio<br>nota: curso Medicina: vazio |
| R5 | Posição no perfil igual à do ranking | passou | ok: Ranking Carla: posição no perfil e no ranking: esperado 11, obtido 11<br>ok: Ranking Ícaro: posição no perfil e no ranking: esperado 14, obtido 14<br>ok: Ranking Bruno: posição no perfil e no ranking: esperado 21, obtido 21 |
| R6 | Ex-aluno mantém a posição e não pontua mais | ausente | O produto não tem ex-alunos: usuarios.papel só admite aluno, professor e admin (src/db.js:25), sem status de formado. |

## T. Tiers

| Caso | Descrição | Resultado | Evidência |
|---|---|---|---|
| T1 | Fronteira inferior: 0 recusado, 1 é o primeiro tier | ausente | O produto não tem tiers: o código do commit avaliado não tem tier, Bronze, Prata nem Diamante ("ouro" só aparece como classe CSS em src/views.js:454); prêmios valem pontos fixos (src/regras.js:23-29). Conferido no ar: telas de ranking e perfil com 0 menção(ões) a tier. |
| T2 | Fronteira 30/31 | ausente | O produto não tem tiers: o código do commit avaliado não tem tier, Bronze, Prata nem Diamante ("ouro" só aparece como classe CSS em src/views.js:454); prêmios valem pontos fixos (src/regras.js:23-29). Conferido no ar: telas de ranking e perfil com 0 menção(ões) a tier. |
| T3 | Fronteira 70/71 | ausente | O produto não tem tiers: o código do commit avaliado não tem tier, Bronze, Prata nem Diamante ("ouro" só aparece como classe CSS em src/views.js:454); prêmios valem pontos fixos (src/regras.js:23-29). Conferido no ar: telas de ranking e perfil com 0 menção(ões) a tier. |
| T4 | Fronteira 100/101 | ausente | O produto não tem tiers: o código do commit avaliado não tem tier, Bronze, Prata nem Diamante ("ouro" só aparece como classe CSS em src/views.js:454); prêmios valem pontos fixos (src/regras.js:23-29). Conferido no ar: telas de ranking e perfil com 0 menção(ões) a tier. |
| T5 | Fronteira superior: 150 aceito, 151 recusado | ausente | O produto não tem tiers: o código do commit avaliado não tem tier, Bronze, Prata nem Diamante ("ouro" só aparece como classe CSS em src/views.js:454); prêmios valem pontos fixos (src/regras.js:23-29). Conferido no ar: telas de ranking e perfil com 0 menção(ões) a tier. |
| T6 | Aluno não tem tier | ausente | O produto não tem tiers: o código do commit avaliado não tem tier, Bronze, Prata nem Diamante ("ouro" só aparece como classe CSS em src/views.js:454); prêmios valem pontos fixos (src/regras.js:23-29). Conferido no ar: telas de ranking e perfil com 0 menção(ões) a tier. |

## Pedidos HTTP por caso

Método, caminho e status de cada pedido do caso (os do meio omitidos quando passam de 12).

- **F1-publicar** (6 pedidos, 126 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `GET /u/3 -> 200`, `POST /posts -> 302`, `GET /u/3 -> 200`, `GET /u/3 -> 200`
- **F1-curtida** (10 pedidos, 169 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/4 -> 200`, `GET /u/4 -> 200`, `POST /posts/2/curtir -> 302`, `GET /u/4 -> 200`, `GET /u/5 -> 200`
- **F1-comentario** (9 pedidos, 165 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/6 -> 200`, `POST /posts/3/comentar -> 302`, `GET /u/7 -> 200`, `GET /u/6 -> 200`
- **F2-excelencia** (7 pedidos, 163 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `GET /u/9 -> 200`, `POST /u/9/medalha -> 302`, `GET /u/9 -> 200`
- **F2-projeto** (6 pedidos, 167 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/11/medalha -> 302`, `GET /u/11 -> 200`
- **F2-ideia** (6 pedidos, 170 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/13/medalha -> 302`, `GET /u/13 -> 200`
- **F2-ajudou** (6 pedidos, 167 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/15/medalha -> 302`, `GET /u/15 -> 200`
- **F2-participacao** (6 pedidos, 178 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/17/medalha -> 302`, `GET /u/17 -> 200`
- **F3-primeiro_post** (6 pedidos, 95 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `GET /u/18 -> 200`, `POST /posts -> 302`, `GET /u/18 -> 200`, `GET /u/18 -> 200`
- **F3-fotografo** (24 pedidos, 156 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/19 -> 200`, `(12 pedidos omitidos)`, `POST /posts -> 302`, `GET /u/19 -> 200`, `POST /posts -> 302`, `GET /u/19 -> 200`, `GET /u/19 -> 200`, `POST /posts -> 302`, `GET /u/19 -> 200`, `GET /u/19 -> 200`
- **F3-bom_de_papo** (36 pedidos, 312 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `(24 pedidos omitidos)`, `POST /posts/19/comentar -> 302`, `POST /posts/20/comentar -> 302`, `POST /posts/21/comentar -> 302`, `POST /posts/22/comentar -> 302`, `POST /posts/23/comentar -> 302`, `GET /u/20 -> 200`, `POST /posts/24/comentar -> 302`, `GET /u/20 -> 200`
- **F3-popular** (156 pedidos, 4598 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/22 -> 200`, `(144 pedidos omitidos)`, `POST /posts/25/curtir -> 302`, `POST /posts/25/curtir -> 302`, `POST /posts/25/curtir -> 302`, `POST /posts/25/curtir -> 302`, `POST /posts/25/curtir -> 302`, `GET /u/22 -> 200`, `POST /posts/25/curtir -> 302`, `GET /u/22 -> 200`
- **F3-estrela** (506 pedidos, 13973 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/73 -> 200`, `(494 pedidos omitidos)`, `POST /posts/26/curtir -> 302`, `POST /posts/26/curtir -> 302`, `POST /posts/26/curtir -> 302`, `POST /posts/26/curtir -> 302`, `POST /posts/26/curtir -> 302`, `GET /u/73 -> 200`, `POST /posts/26/curtir -> 302`, `GET /u/73 -> 200`
- **F3-medalhista** (7 pedidos, 191 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `GET /u/224 -> 200`, `POST /u/224/medalha -> 302`, `GET /u/224 -> 200`
- **F3-colecionador** (11 pedidos, 211 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/226/medalha -> 302`, `POST /u/226/medalha -> 302`, `POST /u/226/medalha -> 302`, `POST /u/226/medalha -> 302`, `GET /u/226 -> 200`, `POST /u/226/medalha -> 302`, `GET /u/226 -> 200`
- **F4** (7 pedidos, 121 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/228 -> 200`, `POST /posts/27/curtir -> 302`, `POST /posts/27/comentar -> 302`, `GET /u/228 -> 200`
- **F5** (11 pedidos, 224 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/229 -> 200`, `POST /posts/28/comentar -> 302`, `POST /perfil/editar -> 302`, `GET /ranking -> 200`, `GET /u/229 -> 200`, `GET /u/229 -> 200`
- **F6** (12 pedidos, 222 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/231 -> 200`, `POST /posts/29/curtir -> 302`, `GET /u/231 -> 200`, `POST /posts/29/curtir -> 302`, `GET /u/231 -> 200`, `POST /posts/29/apagar -> 302`, `GET /u/231 -> 200`
- **F7** (21 pedidos, 346 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `(9 pedidos omitidos)`, `GET /u/235 -> 200`, `POST /posts -> 302`, `GET /u/235 -> 200`, `POST /posts/31/comentar -> 302`, `POST /posts/32/comentar -> 302`, `POST /u/234/medalha -> 302`, `GET /u/234 -> 200`, `GET /ranking -> 200`
- **F8** (12 pedidos, 223 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/236 -> 200`, `POST /posts/33/comentar -> 302`, `GET /u/237 -> 200`, `POST /posts -> 302`, `GET /u/237 -> 200`, `POST /posts/34/curtir -> 302`, `GET /u/237 -> 200`
- **E1-ausente** (6 pedidos, 193 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/239/medalha -> 400`, `GET /u/239 -> 200`
- **E1-vazio** (6 pedidos, 220 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/241/medalha -> 400`, `GET /u/241 -> 200`
- **E1-texto** (6 pedidos, 187 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/243/medalha -> 400`, `GET /u/243 -> 200`
- **E1-decimal** (6 pedidos, 174 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/245/medalha -> 400`, `GET /u/245 -> 200`
- **E1-negativo** (6 pedidos, 214 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/247/medalha -> 400`, `GET /u/247 -> 200`
- **E1-inexistente** (6 pedidos, 191 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/249/medalha -> 400`, `GET /u/249 -> 200`
- **E2-inexistente** (3 pedidos, 110 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/999999/medalha -> 400`
- **E2-idtexto** (3 pedidos, 110 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/abc/medalha -> 404`
- **E2-naoparticipa** (6 pedidos, 189 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/253/medalha -> 400`, `GET /ranking -> 200`
- **E3** (7 pedidos, 177 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/255/medalha -> 403`, `GET /u/255 -> 200`, `GET /u/254 -> 200`
- **E4-curtir-inexistente** (4 pedidos, 103 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts/999999/curtir -> 404`, `GET /u/256 -> 200`
- **E4-curtir-idtexto** (4 pedidos, 120 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts/abc/curtir -> 404`, `GET /u/257 -> 200`
- **E4-comentar-inexistente** (4 pedidos, 84 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts/999999/comentar -> 404`, `GET /u/258 -> 200`
- **E5-post** (4 pedidos, 100 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 400`, `GET /u/259 -> 200`
- **E5-comentario** (9 pedidos, 216 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/260 -> 200`, `POST /posts/35/comentar -> 302`, `GET /u/261 -> 200`, `GET /u/260 -> 200`
- **E6-curtida** (9 pedidos, 204 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/262 -> 200`, `POST /posts/36/curtir -> 302`, `POST /posts/36/curtir -> 302`, `GET /u/262 -> 200`
- **E6-comentario** (9 pedidos, 171 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/264 -> 200`, `POST /posts/37/comentar -> 302`, `POST /posts/37/comentar -> 302`, `GET /u/265 -> 200`
- **E6-premio** (7 pedidos, 199 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /u/267/medalha -> 302`, `POST /u/267/medalha -> 302`, `GET /u/267 -> 200`
- **E7** (3 pedidos, 97 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `GET /ranking?curso=curso-que-nao-existe -> 200`
- **R1** (29 pedidos, 536 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `(17 pedidos omitidos)`, `GET /u/273 -> 200`, `POST /posts -> 302`, `GET /u/273 -> 200`, `POST /posts -> 302`, `GET /u/273 -> 200`, `POST /posts/45/curtir -> 302`, `GET /ranking -> 200`, `GET /ranking?curso=Ci%C3%AAncia%20da%20Computa%C3%A7%C3%A3o -> 200`
- **R2** (2 pedidos, 25 ms): `GET /ranking -> 200`, `GET /ranking?curso=Ci%C3%AAncia%20da%20Computa%C3%A7%C3%A3o -> 200`
- **R3** (12 pedidos, 211 ms): `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /cadastrar -> 302`, `GET /novo -> 200`, `POST /posts -> 302`, `GET /u/274 -> 200`, `POST /posts/46/curtir -> 302`, `GET /ranking -> 200`, `GET /ranking?curso=Administra%C3%A7%C3%A3o -> 200`, `GET /ranking?curso=Ci%C3%AAncia%20da%20Computa%C3%A7%C3%A3o -> 200`, `GET /ranking?curso=Intelig%C3%AAncia%20Artificial -> 200`, `GET /ranking?curso=Medicina -> 200`
- **R4** (4 pedidos, 31 ms): `GET /ranking?curso=Administra%C3%A7%C3%A3o -> 200`, `GET /ranking?curso=Ci%C3%AAncia%20da%20Computa%C3%A7%C3%A3o -> 200`, `GET /ranking?curso=Intelig%C3%AAncia%20Artificial -> 200`, `GET /ranking?curso=Medicina -> 200`
- **R5** (4 pedidos, 42 ms): `GET /ranking -> 200`, `GET /u/273 -> 200`, `GET /u/271 -> 200`, `GET /u/270 -> 200`
