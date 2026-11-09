# Adaptador do engenheiro (desenho, não implementado)

Desenho do adaptador do `maxx-engenheiro` (.NET, Postgres, docker compose), lido na
`main` em `7417ebe` (rodada `eng_08_premios`, 08/11/2026). A trilha ainda está em curso:
reler as rotas no commit avaliado antes de implementar.

Este diretório não tem `subir.ps1` de propósito: sem ele, o `rodar.ps1` recusa o
adaptador e não grava nada em `avaliacoes/reviews/`. O `adaptador.js` tem a interface
inteira, e cada verbo lança "não implementado"; o teste `testes/nucleo.test.js` confere
que nenhum verbo ficou de fora.

## O que muda em relação ao leigo

| Ponto | Leigo | Engenheiro |
|---|---|---|
| Interface | HTML e formulários | JSON em `/api/v1`, token `Bearer` |
| Usuários | Cadastro público por domínio | Sem cadastro público; usuários vêm do seed (`data/demo/mundo.json`) |
| Pontos | Ações sociais e medalhas | Itens de catálogo (`data/catalogo/*.json`) com tier e pontos fixos |
| Tiers | Não tem (ausente) | `Maxx.Domain/Catalogo/Tier.cs`: Bronze 1-30, Prata 31-70, Ouro 71-100, Diamante 101-150 |
| Prêmio | Qualquer professor, qualquer aluno | Medalha por turma: `POST /api/v1/professor/turmas/{turmaId}/medalhas` |
| Ranking | Calculado na hora | Recalculado por worker (ADR 0005); só no passo 11 |
| Ids | Inteiros | GUID (rotas com `{id:guid}`) |

## Subida (`subir.ps1` e `derrubar.ps1`, a escrever)

1. **Projeto isolado.** `docker compose -p maxx-testes-ref-<carimbo> -f <checkout>\docker-compose.yml -f <adaptador>\compose.testes.yml --env-file <temp>\.env --profile armazenamento-local up --build -d`.
   O `.env` é gerado na pasta temporária, a partir do `.env.example` do checkout, nunca
   gravado no checkout.
2. **Nada colide com a pilha do autor.** O override (`compose.testes.yml`, fora do
   checkout) troca:
   - a imagem `maxx-api:local` por `maxx-api:testes-ref`, para não sobrescrever a
     imagem que o autor usa;
   - as portas publicadas, por variável: `MAXX_HTTP_PORT` (Caddy, a porta escolhida
     pelo `rodar.ps1`), `MAXX_MAILPIT_PORT`, `MAXX_ARMAZENAMENTO_PORT` (livres a partir
     de 3200);
   - os volumes, que já ficam isolados pelo nome do projeto.
3. **Dados.** `docker compose run --rm seeder seed demo` para o mundo de demonstração, e
   `Demo__Habilitada` e `Demo__Lote` ligados só no projeto de teste (decisão 2).
4. **Pronto.** Espera `GET /ready` (Caddy na porta escolhida) responder 200, com limite de
   5 minutos (o build da imagem .NET demora).
5. **Derrubar.** `docker compose -p <projeto> down -v --remove-orphans` e
   `docker image rm maxx-api:testes-ref`. O `rodar.ps1` chama o `derrubar.ps1` também
   quando algo falha no meio.
6. **Ambiente no relatório.** Versões de `docker` e `docker compose`, o digest da imagem
   construída e o hash do `.env.example`.

## Verbos

| Verbo | Rota no engenheiro |
|---|---|
| login de cada usuário | `POST /api/v1/auth/login` (RA ou e-mail e senha), guarda o access; em 401, entra de novo |
| `criarAluno`, `criarProfessor` | Professores e turmas do `seed demo`; alunos novos pela entrada da demonstração (decisão 2) |
| `publicar` | `POST /api/v1/posts` (a foto passa por `POST /api/v1/uploads`) |
| `curtir`, `descurtir` | `PUT` e `DELETE /api/v1/posts/{id}/curtida` |
| `comentar` | `POST /api/v1/posts/{id}/comentarios` |
| `apagarPost` | `DELETE /api/v1/posts/{id}` |
| `editarPerfil` | `PATCH /api/v1/eu/perfil` |
| `concederPremio` | `GET /api/v1/professor/turmas`, achar a turma do aluno, `POST /api/v1/professor/turmas/{turmaId}/medalhas` com `alunoId` e `item` |
| `pontos`, `posicao` | `GET /api/v1/perfis/{id}` (a posição chega no passo 11) |
| `ranking` | Rota do passo 11; o adaptador espera o worker (repete a leitura até estabilizar, com limite) |
| `tierDoAluno` | `GET /api/v1/perfis/{id}`: confere que não há tier do aluno |
| `pedidoInvalido` | Mesmos tipos do leigo; ids inexistentes como GUID novo, id em texto como `abc` (a restrição `:guid` deve dar 404) |

## Regra declarada (`regra.js`, a escrever)

- **Fontes:** `docs/produto.md` (seção 4.9), `docs/regras-conquista.md`,
  `data/catalogo/medalhas.json`, `premios-participacao.json` e `conquistas.json`, e
  `Maxx.Domain/Catalogo/Tier.cs`.
- **Ações sociais:** se publicar, curtir e comentar não valem pontos no engenheiro, `acoes`
  fica vazio e os casos F1 saem ausentes. F5 continua valendo: essas ações devem dar 0.
- **Prêmios:** os itens de medalha do catálogo, com o código, o tier e os pontos.
- **Metas:** as conquistas usam `contagem` e `contagemDistinta`, com `filtroItens` e
  `agruparPor`. O modelo do núcleo (`nucleo/regra.js`) só tem contagem simples; ele precisa
  ganhar filtro por item e contagem distinta antes do F3 do engenheiro.
- **Ranking:** quem participa, a política de empate e a ordem no empate, lidas na doc do
  passo 11.

## Quando implementar

Só quando a `main` do `maxx-engenheiro` estiver final, depois do passo 13 (decisão do
autor, 08/11/2026). Até lá o adaptador fica desenhado como está, e as rotas acima são
relidas no commit avaliado antes de implementar.

## Decisões do autor (08/11/2026)

Os números seguem os itens que o esqueleto (`adaptador.js`) cita como "decisão pendente".

1. **Fronteiras de tier (T1 a T5): pelos itens que o catálogo já tem, sem criar prêmio
   pela API.** O catálogo é arquivo, validado no seed (`CatalogoValidator.cs:88-91`), e
   não há rota para criar um prêmio de 30, 31 ou 151 pontos. T1 a T5 conferem os itens do
   catálogo que a API expõe: cada item fica dentro da faixa do seu tier. Uma fronteira
   (0/1, 30/31, 70/71, 100/101, 150/151) só é testada nos valores que algum item tem; o
   valor que nenhum item tem fica registrado na evidência como não exercitado. Fica
   descartada a saída de rodar o seeder com um catálogo de teste, que sairia da
   caixa-preta por HTTP.
2. **Usuários: pelo seeder de demonstração do produto e pela entrada da
   demonstração.** O `seed demo` (`docker compose run --rm seeder seed demo`) cria o
   mundo de demonstração, com professores e turmas. Os alunos novos que cada caso pede
   entram pela rota de demonstração (`/api/v1/demo/alunos` e `/api/v1/demo/entrar`),
   com `Demo__Habilitada` e `Demo__Lote` ligados só no projeto de teste, pelo `.env`
   gerado na pasta temporária. Isso substitui o passo 3 da subida, que deixava a
   demonstração desligada.
3. **Caso novo na suíte: "professor premia aluno fora da turma".** Entra no grupo E
   (item 9 do inventário), com a capacidade própria. No leigo sai "ausente", porque
   qualquer professor premia qualquer aluno. No engenheiro passa quando a concessão é
   recusada com 4xx e os pontos do aluno não mudam. O caso é escrito junto com o
   adaptador do engenheiro, e o leigo é rodado de novo nesse momento para ganhar a linha
   "ausente".
4. **Ranking assíncrono: espera pelo worker de até 30 s.** O adaptador lê o ranking a
   cada 1 s até ele refletir o estado esperado ou passar de 30 s. Passado o limite, vale o
   que foi lido, e o caso falha com o tempo esperado na evidência.

## Prompt único (`eng_pu`, `leigo_pu`)

Pela regra do pedido, cada prompt único usa o adaptador da trilha se a stack coincidir
(`rodar.ps1 -Produto leigo_pu -Adaptador leigo ...`). Antes, conferir rotas e marcação
no commit avaliado. A `regra.js` é sempre do produto avaliado, nunca da trilha: se a stack
coincidir e a regra não, o adaptador ganha um `regra.js` próprio numa pasta nova.
