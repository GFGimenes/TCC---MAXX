# Review leigo_pu, eixo 5. Código

- Status: ok
- Tentativa: 1
- Commit avaliado: ce76942b7aa1ebb3a016df705972fc32483cf98f (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: dd87a1ed-8b4a-4556-916b-c0075a24ce55

Texto do revisor, sem edição:

---
# Revisão do eixo 5 (Código): produto `leigo_pu`, commit `ce76942b7aa1`

**Nota: 3 de 5**

Este produto não tem resultado da suíte de testes de referência (fronteiras 30/31, 70/71, 100/101, 150/151, entradas inválidas e ordem do ranking). A nota se apoia só na leitura dos arquivos. Não compilei, não rodei `npm test` nem subi o app.

## Justificativa

O código é limpo e fácil de ler, e não há sinal de alucinação. As dependências declaradas (`express` 5, `pg`, `@electric-sql/pglite`) batem com o que é importado. As camadas estão razoavelmente separadas:
- `server/rules.js` guarda as regras como dados: pontos, 7 tipos de medalha e 13 troféus com `stat` e `target`.
- `server/services.js` tem a lógica de negócio e um `HttpError` único.
- `server/index.js` tem as rotas.
- `server/auth.js` cuida de sessão e senha.
- `server/db.js` é um adaptador que serve tanto para Postgres quanto para PGlite.

Os pontos ficam num extrato (tabela `points`, com `ref`). Isso torna o estorno simples e verificável: descurtir, apagar post e revogar medalha retiram os pontos certos. O SQL usa parâmetros em todas as consultas, e a concessão de troféu se protege de corrida com `ON CONFLICT ... RETURNING`.

Motivos para não dar 4:
1. **Poucos testes.** Há 5 testes de integração em `test/api.test.js`, todos dependentes do mesmo banco com seed e da ordem de execução. Nenhum teste de unidade cobre limiar de troféu (target−1, target), o teto de 3 posts pontuados por dia, o limite de 30 medalhas por dia, a ordem do ranking com empate, o filtro "este mês" ou `positions()`.
2. **Entradas inválidas tratadas de forma desigual.** Alguns casos viram erro 500 em vez de 400 (detalhes nas evidências).
3. **Sem transações.** Operações de várias escritas, como `giveMedal`, `createPost`, `revokeMedal` e `deletePost`, podem deixar o estado pela metade, e o teto diário de posts pode ser burlado por concorrência.
4. **Sem CI.** Não existe `.github/`.
5. **Frontend num arquivo só.** `public/app.js` tem mais de 1000 linhas e mistura todas as telas.

Motivos para não dar 2: os testes que existem verificam regra de negócio de verdade, com o total exato de 162 pontos e o estorno para 60. A duplicação é pequena e a organização é coerente.

### Faixas de tier da especificação

A especificação define Bronze 1–30, Prata 31–70, Ouro 71–100 e Diamante 101–150. O produto não implementa essa regra: cada troféu tem um valor fixo e não há função que ligue tier a faixa. Por isso marquei a regra como ausente e não penalizei. Mesmo assim, os rótulos de tier que o produto usa contradizem as faixas:
- Ouro com 120, 150 e 200 pontos.
- Prata com 75 e 80 pontos.
- Não existe Diamante, e medalhas não têm tier.

Se os testes de fronteira fossem aplicados ao rótulo de tier, falhariam.

## Evidências

| Local | Achado |
|---|---|
| `server/rules.js:4-44` | As regras estão concentradas em dados declarativos. Mudar pontos ou criar troféu mexe num lugar só. |
| `server/rules.js:25,27,28,32,34` | Valores fora das faixas da especificação: `lente_de_ouro` (ouro, 120), `popular` (prata, 80), `celebridade` (ouro, 150), `colecionador` (prata, 75), `lenda` (ouro, 200). Não há tier Diamante. |
| `server/services.js:62-80` | `checkTrophies` é genérico e orientado por dados (`stats[t.stat] >= t.target`), com `ON CONFLICT DO NOTHING RETURNING` contra concessão duplicada. |
| `server/services.js:91-96` | O teto de 3 posts pontuados por dia lê e depois escreve sem transação. Requisições simultâneas podem passar do teto. Apagar o post apaga o ponto (`:106`), o que reabre a cota do dia. |
| `server/services.js:165-186` | `giveMedal` faz 3 a 4 escritas sem transação. `Number(student_id)` com valor ausente gera `NaN`, que segue para o SQL e provavelmente vira erro 500, não 400. |
| `server/services.js:188-197` | `revokeMedal` estorna os pontos da medalha e das curtidas do post gerado, em 4 a 5 comandos sem transação. |
| `server/services.js:200-213` | A ordem do ranking está correta e é determinística (`ORDER BY points DESC, u.name ASC`). Não há tratamento de posição compartilhada em empate. |
| `server/services.js:215-222` | `positions()` carrega o ranking inteiro em memória a cada visita de perfil, uma passada O(n) por requisição. |
| `server/index.js:376-387` | `POST /api/notices` aceita `course_id` sem verificar se o curso existe. Um id inexistente quebra a FK e cai no handler genérico como 500 ("Erro interno"), não como 400. |
| `server/index.js:124,157,186` | A mesma checagem `SELECT id FROM courses WHERE id = $1` aparece em três rotas. É uma duplicação pequena que caberia num helper. |
| `server/index.js:20-24` | Os helpers `int` e `clean` normalizam a entrada de forma consistente nas rotas, com limite de tamanho em todos os textos. |
| `server/index.js:415-422` | Há um handler de erro centralizado. O 500 não vaza detalhes e fica registrado no log. |
| `server/index.js:42-61` | `FEED_SELECT` e `decoratePost` são reaproveitados no feed e no detalhe do post, sem duplicar a consulta. |
| `server/db.js:12-44` | Um adaptador com a mesma interface (`query`, `exec`, `close`) para Postgres e PGlite. É um padrão usado onde ajuda. |
| `test/api.test.js:75-132` | O teste de integração verifica soma exata de pontos (162), estorno (60), bloqueio de SVG, aluno sem permissão para dar medalha (403), professor sem permissão para publicar (403) e post alheio que não pode ser apagado (403). |
| `test/api.test.js` (arquivo todo) | São só 5 cenários, sem testes de unidade de `rules` e `services`, sem fronteira de limiar de troféu e sem ordem do ranking com empate. Os testes dependem do seed e da ordem de execução. |
| Raiz do repositório | Sem `.github/workflows` nem outra configuração de CI, e sem lint configurado. Há só um comentário `eslint-disable` em `index.js:414`. |
| `public/app.js:1-1013+` | O frontend é um único arquivo com todas as telas, roteador e helpers. Os nomes são bons e há `esc()` centralizado, mas o arquivo é grande para manter. |

## Regras ausentes

- Tier que determina a pontuação por faixa (Bronze 1–30, Prata 31–70, Ouro 71–100, Diamante 101–150). Os pontos são fixos por troféu e não há Diamante.
- Tier para medalhas.
- Progressão da mesma conquista para o tier acima.
- Nível de "encontrabilidade" dos prêmios.
- Restrição de que o professor só dá medalha a alunos que leciona ou orienta.
- Ex-aluno que mantém posição no ranking mas não pontua mais.
- Login por RA. Só existe login por e-mail.
- Rankings all-time por curso e "curso global". Existem geral e por curso, com filtro "sempre" ou "este mês".
- Cadastro de troféus e medalhas pelo corpo da faculdade, pela interface. Hoje estão fixos no código.
- Troféus por assiduidade, techdays e feiras.
- Prova por foto, denúncia e revogação de troféu.
- Log de leitura dos avisos e marcação de "não lido".

## Decisões do agente

- Modelar os pontos como extrato de lançamentos (tabela `points` com `ref`) e calcular o ranking como soma, o que permite estornar.
- Concentrar todas as regras de pontos, medalhas e troféus em dados declarativos em `server/rules.js`.
- Criar um adaptador de banco com a mesma interface para PGlite (local e testes em memória) e Postgres (`DATABASE_URL`).
- Usar uma classe `HttpError` com handler de erro centralizado no Express 5.
- Escrever testes de integração HTTP com `node:test`, sem biblioteca externa, subindo o app com banco em memória.
- Limitar a pontuação a 3 posts por dia e as medalhas a 30 por professor por dia.
- Não pontuar curtida na própria foto e retirar os pontos ao descurtir.
- Fazer troféus e medalhas gerarem posts automáticos no feed.
- Não retirar troféu quando o aluno apaga fotos depois de ganhá-lo.
- Desempatar o ranking pelo nome.
- Usar JavaScript puro no frontend, sem framework nem build, num único `app.js`.
- Guardar as imagens como BYTEA no banco, com validação de MIME e tamanho máximo de 4 MB.
- Criar o endpoint `/api/auth/banca`, que gera contas de visitante.

## O que não pôde ser verificado

- Se `npm test` passa: os 5 testes não foram executados.
- Se o servidor sobe e se as dependências instalam sem erro.
- Como `pg` e PGlite tratam `NaN` passado como parâmetro inteiro em `giveMedal`. Inferi erro 500, mas não confirmei.
- A corrida no teto diário de posts e o estado parcial sem transação, que só aparecem com concorrência real.
- O comportamento das telas no navegador (`public/app.js`).
- Os testes de referência de fronteira, entradas inválidas e ordem do ranking: não há resultado disponível para este produto.

```json
{
  "nota": 3,
  "justificativa": "Não há resultado da suíte de testes de referência para este produto; a nota se apoia só na leitura dos arquivos. O código é limpo, legível e sem sinais de alucinação. As regras estão concentradas em dados declarativos (server/rules.js), a lógica de negócio está em services.js com HttpError único, há um adaptador de banco Postgres/PGlite, SQL parametrizado, extrato de pontos que permite estorno correto e troféus protegidos contra concessão duplicada com ON CONFLICT. Não chega a 4 porque os testes próprios são escassos (5 cenários de integração dependentes do seed e da ordem, sem teste de unidade de limiar de troféu, teto diário ou ordem do ranking com empate), porque entradas inválidas são tratadas de forma desigual (course_id inexistente em avisos e student_id ausente em medalha caem em 500), porque não há transações em operações de várias escritas, porque não há CI e porque o frontend é um único arquivo de mais de 1000 linhas. Não cai para 2 porque os testes que existem verificam regra de negócio com valores exatos e a duplicação é pequena. As faixas de tier da especificação não estão implementadas (pontos fixos por troféu); a regra foi marcada como ausente, mas os rótulos usados contradizem as faixas (ouro 120/150/200, prata 75/80).",
  "evidencias": [
    {"local": "server/rules.js:4-44", "descricao": "Regras de pontos, medalhas e troféus concentradas em dados declarativos; mudar uma regra mexe num lugar só."},
    {"local": "server/rules.js:25,27,28,32,34", "descricao": "Valores fora das faixas da especificação: lente_de_ouro ouro 120, popular prata 80, celebridade ouro 150, colecionador prata 75, lenda ouro 200; não há Diamante."},
    {"local": "server/services.js:62-80", "descricao": "checkTrophies genérico orientado por stat/target, com ON CONFLICT DO NOTHING RETURNING contra concessão duplicada."},
    {"local": "server/services.js:91-96", "descricao": "Teto de 3 posts pontuados por dia lê e depois escreve sem transação (corrida possível); apagar o post (linha 106) reabre a cota do dia."},
    {"local": "server/services.js:165-186", "descricao": "giveMedal faz várias escritas sem transação; Number(student_id) ausente vira NaN, segue para o SQL e provavelmente gera 500 em vez de 400."},
    {"local": "server/services.js:188-197", "descricao": "revokeMedal estorna pontos da medalha e das curtidas do post gerado em vários comandos sem transação."},
    {"local": "server/services.js:200-213", "descricao": "Ranking ordenado corretamente (points DESC, name ASC); sem tratamento de posição compartilhada em empate."},
    {"local": "server/services.js:215-222", "descricao": "positions() carrega o ranking inteiro em memória a cada visita de perfil."},
    {"local": "server/index.js:376-387", "descricao": "POST /api/notices aceita course_id sem verificar existência; id inexistente quebra a FK e vira 500 genérico."},
    {"local": "server/index.js:124,157,186", "descricao": "Mesma checagem de curso existente repetida em três rotas (duplicação pequena)."},
    {"local": "server/index.js:20-24", "descricao": "Helpers int/clean normalizam a entrada com limite de tamanho de forma consistente."},
    {"local": "server/index.js:415-422", "descricao": "Handler de erro centralizado, sem vazar detalhes no 500."},
    {"local": "server/db.js:12-44", "descricao": "Adaptador de banco com a mesma interface para Postgres e PGlite, padrão usado onde ajuda."},
    {"local": "test/api.test.js:75-132", "descricao": "Teste de integração verifica soma exata de pontos (162), estorno (60) e as permissões principais (403)."},
    {"local": "test/api.test.js", "descricao": "Só 5 cenários; sem testes de unidade, sem fronteira de limiar de troféu, sem ordem do ranking com empate; dependem do seed e da ordem de execução."},
    {"local": "raiz do repositório", "descricao": "Sem .github/workflows ou outra configuração de CI; sem lint configurado."},
    {"local": "public/app.js:1-1013+", "descricao": "Frontend inteiro (telas, roteador, helpers) num único arquivo de mais de 1000 linhas."}
  ],
  "regras_ausentes": [
    "Tier que determina a pontuação por faixa (Bronze 1-30, Prata 31-70, Ouro 71-100, Diamante 101-150); pontos fixos por troféu e sem Diamante",
    "Tier para medalhas",
    "Progressão da mesma conquista para o tier acima",
    "Nível de encontrabilidade dos prêmios",
    "Professor só dá medalha a alunos que leciona ou orienta",
    "Ex-aluno mantém posição no ranking mas não pontua mais",
    "Login por RA",
    "Rankings all-time por curso e curso global (existem geral e por curso, com filtro sempre/este mês)",
    "Cadastro de troféus e medalhas pelo corpo da faculdade pela interface",
    "Troféus por assiduidade, techdays e feiras",
    "Prova por foto, denúncia e revogação de troféu",
    "Log de leitura dos avisos e marcação de não lido"
  ],
  "decisoes_do_agente": [
    "Modelar pontos como extrato de lançamentos (tabela points com ref) e calcular o ranking como soma, permitindo estorno",
    "Concentrar todas as regras de pontos, medalhas e troféus em dados declarativos em server/rules.js",
    "Criar adaptador de banco com a mesma interface para PGlite (local e testes em memória) e Postgres (DATABASE_URL)",
    "Usar classe HttpError com handler de erro centralizado no Express 5",
    "Escrever testes de integração HTTP com node:test, sem biblioteca externa, com banco em memória",
    "Limitar a pontuação a 3 posts por dia e as medalhas a 30 por professor por dia",
    "Não pontuar curtida na própria foto e retirar os pontos ao descurtir",
    "Troféus e medalhas geram posts automáticos no feed",
    "Não retirar troféu quando o aluno apaga fotos depois",
    "Desempatar o ranking pelo nome",
    "JavaScript puro no frontend, sem framework nem build, num único app.js",
    "Guardar imagens como BYTEA no banco, com validação de MIME e limite de 4 MB",
    "Criar o endpoint /api/auth/banca, que gera contas de visitante"
  ],
  "nao_verificado": [
    "Se npm test passa (os 5 testes não foram executados)",
    "Se o servidor sobe e se as dependências instalam sem erro",
    "Como pg e PGlite tratam NaN como parâmetro inteiro em giveMedal (inferido erro 500, não confirmado)",
    "Corrida no teto diário de posts e estado parcial sem transação, que só aparecem com concorrência real",
    "Comportamento das telas no navegador (public/app.js)",
    "Testes de referência de fronteira, entradas inválidas e ordem do ranking: não há resultado disponível para este produto"
  ]
}
```
