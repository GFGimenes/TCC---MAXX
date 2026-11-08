# Review leigo, eixo 5. Código

- Status: ok
- Tentativa: 1
- Commit avaliado: 2a7dad587e67aec8c45df37ce7b59c1f3eccfe2c (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 2c33c060-9f76-4bb3-aa1d-7761b08bbef0

Texto do revisor, sem edição:

---
# Revisão do eixo 5 (Código): produto `leigo`, commit `2a7dad587e67`

**Suíte de testes de referência:** não há resultado dela para este produto, então a nota foi dada sem ela. Os testes de fronteira de tier (30/31, 70/71, 100/101, 150/151) também não se aplicam, porque o produto não tem tiers. Esses testes ficam **ausentes**.

**Condições:** só li os arquivos. Não instalei dependências, não rodei `npm test` e não subi o app.

## Nota: 4

## Justificativa

O código é pequeno e legível. Os módulos têm papéis claros: `config`, `regras`, `pontos`, `feed`, `html`, `views`, `banca`, `senha`, `db` e `app`. As regras de pontuação ficam como dados num único arquivo (`src/regras.js`), e `src/pontos.js` faz um cálculo puro sobre elas. As entradas inválidas são tratadas de forma consistente:
- IDs de rota são validados.
- Textos são cortados no tamanho máximo.
- Cursos e papéis são conferidos contra uma lista fixa.
- O tipo de medalha é verificado.
- Uploads aceitam só alguns formatos e têm limite de tamanho.
- Redirecionamentos só vão para caminhos internos.
- Há um tratador de erros central.

Os testes próprios (`test/fluxo.test.js`) fazem o fluxo completo por HTTP, num banco temporário. Eles conferem pontos calculados à mão (114 e 6), a ordem do ranking, o ranking por curso, permissões por papel, XSS, open redirect e algumas entradas inválidas.

O que impede o 5:
- **Não há CI.** Não existe `.github/` nem outro pipeline.
- **Os testes são frágeis.** Há um único teste gigante, de cerca de 155 linhas, com asserções em regex sobre o HTML e IDs sequenciais fixos. Não há teste unitário de `calcular` nem de `posicionar`, e o empate no ranking não é testado.
- **`src/app.js` é monolítico.** São 483 linhas misturando rotas e SQL, e `src/views.js` tem cerca de 780 linhas.
- **Há duplicação pequena:**
  - A consulta dos tipos de medalha aparece duas vezes.
  - `SQL_STATS + ' AND u.id = ?'` também aparece duas vezes.
  - `p.nome.split(' ')[0]` se repete, embora o helper `primeiroNome` exista.
- **O cálculo de posição é ineficiente.** `statsDoAluno` recalcula o ranking inteiro duas vezes a cada perfil aberto.

Não encontrei lógica errada no que existe, nem import ou API inexistente. `node:sqlite` com `DatabaseSync` e o `--disable-warning` são compatíveis com o `engines` declarado (`node >=22.13`).

## Evidências

| Local | Descrição |
|---|---|
| `src/regras.js:4-29` | Pontos, conquistas e medalhas padrão ficam como dados declarativos num lugar só. Mudar uma regra é mudar só este arquivo. |
| `src/pontos.js:20-30` | `calcular` é pura: o total vem dos dados brutos, sem total gravado no banco, e se ajusta quando algo é apagado. |
| `src/pontos.js:33-39` | O ranking ordena por total decrescente e desempata por nome em pt-BR. Empatados dividem a posição (1,1,3). A ordem está correta. |
| `src/pontos.js:56-62` | `statsDoAluno` chama `ranking()` duas vezes, e cada chamada roda a consulta de todos os alunos. É ineficiente, mas não está errado. |
| `src/pontos.js:57` e `:69` | `SQL_STATS + ' AND u.id = ?'` aparece duas vezes. |
| `src/pontos.js:77-80` | A migração é feita à mão com `PRAGMA user_version`. Em `src/db.js:106-111` há outra, por checagem de coluna. Não há mecanismo único de migração. |
| `src/app.js:23-28`, `:466-480` | A classe `ErroUsuario` e o tratador de erros central também limpam o upload órfão. Bom padrão. |
| `src/app.js:99-106` | `caminhoSeguro`, `texto` (corta no tamanho máximo) e `idParam` (inteiro positivo, senão 404) validam a entrada. |
| `src/app.js:158-180` | O cadastro valida nome, formato e domínio do e-mail, curso da lista, senha de pelo menos 8 caracteres e e-mail duplicado. |
| `src/app.js:333-346` | A medalha valida o papel de quem dá, se o destino é aluno e o `tipo_id`. Não valida vínculo de turma entre professor e aluno. |
| `src/app.js:306` e `:380` | A mesma consulta `SELECT * FROM tipos_medalha ORDER BY pontos DESC` aparece duas vezes. |
| `src/app.js` (arquivo todo) | 483 linhas com rotas, SQL e regras pequenas juntos, sem camada de repositório ou serviço. |
| `src/html.js:1-33` | Mini motor de templates com escape automático. É um padrão que ajuda: protege contra XSS por padrão. |
| `src/views.js:333`, `:345`, `:470` vs `:548` | `split(' ')[0]` se repete, embora exista o helper `primeiroNome`. Em `:470` uma variável local tem o mesmo nome do helper. |
| `src/feed.js:16-27`, `:32-47` | O feed é montado com `UNION ALL` e carregado em lote via `json_each`, evitando N+1. Código cuidadoso. |
| `src/senha.js:3-15` | scrypt com sal, comparado com `timingSafeEqual`. |
| `test/fluxo.test.js:55-212` | Um único teste de ponta a ponta com dezenas de asserções. Uma falha no meio interrompe o resto e esconde as demais. |
| `test/fluxo.test.js:152-156` | Confere os totais calculados à mão (Ana 114, Bruno 6) e a ordem no ranking. |
| `test/fluxo.test.js:61-64`, `:70-72`, `:81-84`, `:98`, `:103`, `:109-111`, `:144` | Entradas inválidas testadas: domínio externo, e-mail repetido, arquivo que não é imagem, open redirect, aluno tentando ação de professor ou admin, medalha para professor. |
| `test/fluxo.test.js` (ausências) | Não testa empate no ranking, `tipo_id` inválido, senha curta, curso inválido, ID não numérico nem imagem acima de 5 MB. |
| `package.json:10` | `npm test` usa `node --test`, sem dependência extra. Não há CI no repositório. |
| `src/regras.js:5` + `src/app.js:217-226` | 10 pontos por post, sem limite nem conteúdo mínimo: um aluno sobe no ranking publicando posts de 1 caractere. É uma lacuna de regra de negócio no código. |

## Regras ausentes (não entram na nota)

- Tiers Bronze, Prata, Ouro e Diamante com faixas de 1–30, 31–70, 71–100 e 101–150 pontos. Por isso os testes de fronteira 30/31, 70/71, 100/101 e 150/151 ficam ausentes.
- Progressão da mesma conquista para o tier seguinte, até o Diamante.
- Nível de "encontrabilidade" dos prêmios.
- Troféus e medalhas como entidades distintas, com troféu valendo mais e cadastro pelo corpo da faculdade. As conquistas estão fixas no código.
- Login por RA. Só existe e-mail, e não há campo de RA.
- Esqueci minha senha.
- Ex-aluno que mantém posição mas não pontua mais.
- Semestre no perfil.
- Ranking all-time geral e all-time por curso, ou seja, sem noção de período.
- Professor só dá medalha a aluno que leciona ou orienta.
- Prova por foto, denúncia e revogação de prêmio.
- Seguidores e seguindo.
- Categorias do mural (Faculdade, Curso, Professores) com filtro por relevância.
- Log de leitura por aviso, com quem leu e quando. Só existe o marcador do último aviso visto.
- Compartilhar post.

## Decisões do agente (sem o prompt pedir, dentro do eixo Código)

- Usar `node:sqlite` (`DatabaseSync`) embutido, experimental, sem ORM. Por isso os scripts levam `--disable-warning=ExperimentalWarning`.
- Renderizar HTML no servidor com um motor próprio de templates (tagged template) e escape automático, em vez de um framework de front-end.
- Calcular os pontos sempre na hora, a partir dos dados brutos, sem gravar o total no banco.
- Definir as conquistas como tabela de dados em `src/regras.js`, com os campos `conta`, `meta` e `bonus`.
- Inventar a tabela de pontos: post 10, curtida recebida 2, comentário 3 (uma vez por post). Curtir o próprio post não conta.
- Desempatar o ranking por nome e fazer empatados dividirem a posição.
- Migrar o esquema à mão com `PRAGMA user_version` e checagem de coluna.
- Centralizar os erros na classe `ErroUsuario` e num middleware de erro.
- Escrever um único teste de integração HTTP com `node:test`, num banco temporário, sem testes unitários.
- Hash de senha com scrypt e token de sessão guardado como hash SHA-256.
- Criar o módulo "acesso da banca", com contas de teste ligadas por variável de ambiente.
- Montar o feed numa só consulta (`UNION ALL`) e carregar os itens em lote com `json_each`.

## Não verificado (só leitura)

- Se `npm install` e `npm test` passam no Node 22.13 ou superior.
- Se o app sobe e as rotas respondem como os testes descrevem.
- Que `node:sqlite` suporta `close()`, `json_each` e funções de janela na versão instalada.
- Como a suíte de testes de referência se sairia nos testes de entradas inválidas e de ordenação do ranking.
- Desempenho real de `statsDoAluno` e `ranking()` com muitos alunos.

```json
{
  "nota": 4,
  "justificativa": "Não há resultado da suíte de testes de referência para este produto; nota dada sem ela, e os testes de fronteira de tier ficam ausentes porque o produto não tem tiers. O código é pequeno, legível e bem modularizado (config, regras, pontos, feed, html, views, banca, senha, db, app). As regras de pontuação ficam como dados num único arquivo, e o cálculo é puro e feito na hora. A validação de entrada é consistente (idParam, texto com limite, listas fixas de curso e papel, tipo de medalha, upload restrito, redirecionamento seguro), com tratador de erros central. Os testes próprios fazem o fluxo completo por HTTP e conferem pontos calculados à mão, ordem do ranking, ranking por curso, permissões, XSS, open redirect e várias entradas inválidas. Não chega a 5 porque não há CI, a suíte é um único teste gigante e frágil (regex sobre HTML, IDs fixos), sem teste unitário de calcular ou posicionar nem de empate. Há também app.js monolítico (rotas e SQL juntos), pequenas duplicações e o ranking recalculado duas vezes por perfil. Não há lógica errada nem import ou API inexistente no que existe.",
  "evidencias": [
    {"local": "src/regras.js:4-29", "descricao": "Pontos, conquistas e medalhas padrão como dados declarativos num lugar só."},
    {"local": "src/pontos.js:20-30", "descricao": "calcular é pura: o total vem dos dados brutos e se ajusta quando algo é apagado."},
    {"local": "src/pontos.js:33-39", "descricao": "Ranking ordena por total decrescente com desempate por nome em pt-BR; empatados dividem a posição. Ordem correta."},
    {"local": "src/pontos.js:56-62", "descricao": "statsDoAluno chama ranking() duas vezes, e cada chamada roda a consulta de todos os alunos; ineficiente."},
    {"local": "src/pontos.js:57", "descricao": "SQL_STATS + ' AND u.id = ?' duplicado também na linha 69."},
    {"local": "src/pontos.js:77-80", "descricao": "Migração à mão via PRAGMA user_version; em src/db.js:106-111 há outra por checagem de coluna, sem mecanismo único."},
    {"local": "src/app.js:23-28", "descricao": "Classe ErroUsuario e tratador de erros central (linhas 466-480), que também apaga upload órfão."},
    {"local": "src/app.js:99-106", "descricao": "caminhoSeguro, texto (corte no tamanho máximo) e idParam (inteiro positivo, senão 404) validam a entrada."},
    {"local": "src/app.js:158-180", "descricao": "Cadastro valida nome, formato e domínio do e-mail, curso da lista, senha de pelo menos 8 caracteres e e-mail duplicado."},
    {"local": "src/app.js:333-346", "descricao": "Medalha valida papel de quem dá, aluno de destino e tipo_id; não valida vínculo de turma entre professor e aluno."},
    {"local": "src/app.js:306", "descricao": "Consulta de tipos_medalha duplicada na linha 380."},
    {"local": "src/app.js:1-483", "descricao": "Arquivo monolítico com rotas, SQL e regras pequenas juntos, sem camada de serviço ou repositório."},
    {"local": "src/html.js:1-33", "descricao": "Mini motor de templates com escape automático: padrão que ajuda e protege contra XSS por padrão."},
    {"local": "src/views.js:333", "descricao": "p.nome.split(' ')[0] repetido (também nas linhas 345 e 470), embora exista o helper primeiroNome na linha 548; em 470 uma variável local tem o mesmo nome do helper."},
    {"local": "src/feed.js:16-47", "descricao": "Feed montado com UNION ALL e carregado em lote via json_each, evitando N+1."},
    {"local": "src/senha.js:3-15", "descricao": "scrypt com sal e comparação com timingSafeEqual."},
    {"local": "test/fluxo.test.js:55-212", "descricao": "Um único teste de ponta a ponta com dezenas de asserções em regex sobre HTML e IDs sequenciais; frágil, e uma falha esconde as demais."},
    {"local": "test/fluxo.test.js:152-156", "descricao": "Confere totais calculados à mão (114 e 6) e a ordem do ranking."},
    {"local": "test/fluxo.test.js:61-111", "descricao": "Entradas inválidas testadas: domínio externo, e-mail repetido, arquivo que não é imagem, open redirect, aluno tentando ação de professor ou admin; medalha para professor na linha 144."},
    {"local": "test/fluxo.test.js", "descricao": "Não testa empate no ranking, tipo_id inválido, senha curta, curso inválido, ID não numérico nem imagem acima do limite."},
    {"local": "package.json:10", "descricao": "npm test com node --test; não há CI no repositório (sem .github nem outro pipeline)."},
    {"local": "src/regras.js:5", "descricao": "10 pontos por post sem limite nem conteúdo mínimo (src/app.js:217-226): posts de 1 caractere inflam o ranking. Lacuna de regra de negócio."}
  ],
  "regras_ausentes": [
    "Tiers Bronze, Prata, Ouro e Diamante com faixas 1-30, 31-70, 71-100 e 101-150 (testes de fronteira 30/31, 70/71, 100/101 e 150/151 ausentes)",
    "Progressão da mesma conquista para o tier seguinte até o Diamante",
    "Nível de encontrabilidade dos prêmios",
    "Troféus e medalhas como entidades distintas, com troféu valendo mais e cadastro pela faculdade",
    "Login por RA",
    "Esqueci minha senha",
    "Ex-aluno mantém posição mas não pontua",
    "Semestre no perfil",
    "Ranking all-time geral e all-time por curso (sem noção de período)",
    "Professor só dá medalha a aluno que leciona ou orienta",
    "Prova por foto, denúncia e revogação de prêmio",
    "Seguidores e seguindo",
    "Categorias do mural (Faculdade, Curso, Professores) com filtro por relevância",
    "Log de leitura por aviso (quem leu e quando)",
    "Compartilhar post"
  ],
  "decisoes_do_agente": [
    "Usar node:sqlite (DatabaseSync) embutido e experimental, sem ORM, suprimindo o ExperimentalWarning nos scripts",
    "Renderizar HTML no servidor com motor próprio de templates (tagged template) e escape automático",
    "Calcular os pontos sempre na hora a partir dos dados brutos, sem total gravado no banco",
    "Definir as conquistas como tabela de dados em src/regras.js (conta, meta, bonus)",
    "Inventar a tabela de pontos: post 10, curtida recebida 2, comentário 3 uma vez por post, sem contar curtida no próprio post",
    "Desempatar o ranking por nome e fazer empatados dividirem a posição",
    "Migrar o esquema à mão com PRAGMA user_version e checagem de coluna",
    "Centralizar os erros na classe ErroUsuario e num middleware de erro",
    "Escrever um único teste de integração HTTP com node:test em banco temporário, sem testes unitários",
    "Hash de senha com scrypt e token de sessão guardado como hash SHA-256",
    "Criar o módulo de acesso da banca com contas de teste ligadas por variável de ambiente",
    "Montar o feed numa só consulta UNION ALL com carregamento em lote via json_each"
  ],
  "nao_verificado": [
    "Se npm install e npm test passam no Node 22.13 ou superior",
    "Se o app sobe e as rotas respondem como os testes descrevem",
    "Suporte de node:sqlite a close(), json_each e funções de janela na versão instalada",
    "Como a suíte de testes de referência se sairia em entradas inválidas e ordenação do ranking",
    "Desempenho real de statsDoAluno e ranking() com muitos alunos"
  ]
}
```
