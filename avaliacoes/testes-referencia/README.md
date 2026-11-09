# Testes de referência

Suíte única, igual para os quatro produtos do experimento (`leigo`, `engenheiro`,
`leigo_pu`, `eng_pu`). É o critério objetivo do eixo Código da rubrica
(`avaliacoes/rubrica.md`, seção 5). Ela verifica três coisas:

- a regra de pontos que o produto tiver: cada ação ou item vale exatamente o que a
  regra declara, e nada vale fora dela;
- o tratamento de entradas inválidas: nulo, tipo errado, id inexistente, repetição;
- a ordenação do ranking: ordem, desempate, exclusão de quem não participa.

Quando o produto não tem a regra (tiers, ex-alunos), o caso sai **ausente**, nunca
como falha, como manda a rubrica ("Regra ausente").

A suíte é caixa-preta por HTTP. Ela sobe o produto num checkout limpo do commit
avaliado (`avaliacoes/avaliador/lib/checkout.ps1`) e não altera nada no repositório do
produto.

## Como rodar

No Windows PowerShell 5.1, a partir da raiz do `tcc`, com Node 22 ou mais novo no PATH:

```powershell
cd "C:\Users\Guilherme Gimenes\Documents\Repos\tcc"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\avaliacoes\testes-referencia\rodar.ps1 -Produto leigo -Repo .\maxx-leigo -Ref main
```

Saída: `avaliacoes/reviews/<produto>-testes-referencia.md` e `.json`. Reexecutar
sobrescreve os dois arquivos; o histórico fica no git.

Opções:

- `-Porta <n>`: porta do produto. Sem ela, o script procura uma porta livre a partir
  de 3100.
- `-Saida <pasta>`: grava em outra pasta, em vez de `avaliacoes/reviews/` (usado nos
  ensaios).
- `-Manter`: não apaga a pasta temporária (checkout, banco e log do produto).

Testes da própria suíte, sem produto real:

```powershell
node avaliacoes\testes-referencia\testes\nucleo.test.js
powershell -ExecutionPolicy Bypass -File avaliacoes\testes-referencia\testes\ensaio-rodar.ps1
```

## Peças

```
rodar.ps1                    orquestra: origem fotografada, checkout limpo, sobe, roda, grava, derruba
nucleo/casos.js              catálogo de casos em linguagem neutra
nucleo/executor.js           roda os casos e devolve passou, falhou ou ausente com evidência
nucleo/relatorio.js          grava o .md e o .json
nucleo/cli.js                ponto de entrada chamado pelo rodar.ps1
adaptadores/<produto>/
  regra.js                   regra declarada pelo produto, como dado, com a fonte (arquivo:linha)
  adaptador.js               verbos neutros traduzidos para as rotas do produto
  subir.ps1                  instala e sobe o produto a partir do checkout
adaptadores/falso/           produto falso em memória, para testar a suíte sem produto real
testes/                      testes da própria suíte
```

Estado dos adaptadores:

| Produto | Adaptador | Estado |
|---|---|---|
| `leigo` | `adaptadores/leigo` | Implementado; resultado em `avaliacoes/reviews/leigo-testes-referencia.md` |
| `engenheiro` | `adaptadores/engenheiro` | Desenhado, não implementado (`README.md` da pasta, com as decisões pendentes) |
| `leigo_pu`, `eng_pu` | o da trilha, com `-Adaptador`, se a stack coincidir | A conferir quando os produtos existirem; `regra.js` sempre do produto avaliado |

## Isolamento

- O repositório do produto é só lido. O `rodar.ps1` fotografa o estado da origem
  (`Get-EstadoOrigem`) antes e depois; se mudar, nada é gravado.
- O produto roda a partir de um clone `--no-hardlinks` do commit avaliado, numa pasta
  em `%TEMP%\avaliador-tcc\`. Dependências são instaladas nesse clone (`npm ci`, no
  leigo), com rede. O código do clone não é alterado.
- Os dados do produto (banco, uploads) ficam numa pasta temporária fora do clone, nova
  a cada execução. Toda execução começa do zero.
- No fim, o processo do produto é encerrado e a pasta temporária é apagada.

## Regra declarada e valor esperado

O valor esperado de cada caso nunca vem do produto. Cada adaptador traz `regra.js`, a
regra de pontos que o próprio produto declara (README, código de regras, tela), escrita
como dado e com a fonte de cada número. O núcleo calcula o esperado a partir dessa
regra. Se a regra declarada e o comportamento divergem, o caso falha e a evidência
mostra os dois números.

Forma da regra (`regra.js`):

```js
{
  fontes: ['README.md:89', 'src/regras.js:4'],
  acoes: { publicar: 10, curtidaRecebida: 2, comentarioEmPostAlheio: 3 },
  limites: { comentarioUmaVezPorPost: true, acaoSobreProprioConteudoVale: false,
             interacaoComNaoParticipanteVale: true },
  premios: [{ id: 'tipo', nome: '...', pontos: 50 }],   // itens com valor declarado
  premioRepetidoSoma: true,
  desfazer: 'recalcula',   // desfazer a ação tira os pontos
  notas: { F8: 'ambiguidade da regra, vai para a evidência do caso' },
  metas: [{ id: 'primeiro_post', conta: 'posts', meta: 1, bonus: 20 }],
  ranking: { participa: ['aluno'], empate: 'mesma-posicao', ordemNoEmpate: 'nome' },
  tiers: null,          // ou [{ nome: 'Bronze', min: 1, max: 30 }, ...]
  exAlunos: false,
}
```

## Interface do adaptador

Cada verbo é assíncrono. Usuários são objetos opacos que o adaptador devolve e recebe
de volta (`{ id, nome, curso, papel, ... }`).

| Verbo | O que faz |
|---|---|
| `capacidades()` | `{ tiers, exAlunos, rankingPorCurso, premios, cursos: [...] }` |
| `criarAluno({ curso, nome })` | Cria e autentica um aluno |
| `criarProfessor({ nome })` | Cria e autentica um professor (quem concede prêmios) |
| `publicar(usuario, { texto })` | Cria um post e devolve `{ id }` |
| `curtir(usuario, post)` / `descurtir(usuario, post)` | |
| `comentar(usuario, post, texto)` | |
| `apagarPost(usuario, post)` | |
| `editarPerfil(usuario)` | Ação sem valor na regra |
| `concederPremio(professor, aluno, premioId)` | Concede um item da regra |
| `pontos(aluno)` | Total exibido no perfil |
| `posicao(aluno)` | Posição exibida no perfil (geral) |
| `ranking({ curso })` | Lista exibida, na ordem da tela: `[{ id, pontos, posicao }]` |
| `bruto(usuario, pedido)` | Pedido cru para entradas inválidas; devolve `{ status, corpo }` |
| `pedidoInvalido(tipo, contexto)` | Traduz um caso neutro de entrada inválida no pedido cru do produto |
| `premioPorTier(professor, pontos)` | Só com tiers: cria ou acha um prêmio com esse valor e devolve o tier |
| `tierDoAluno(aluno)` | Só com tiers: tier exibido do aluno, ou `null` |
| `formarAluno(aluno)` | Só com ex-alunos: torna o aluno ex-aluno |
| `historico` | Lista de `{ metodo, caminho, status }` de cada pedido, para a evidência |

Ação válida recusada pelo produto (5xx, 4xx inesperado) é lançada pelo adaptador como
`ErroProduto` (`nucleo/erros.js`) e vira falha do caso. Qualquer outro erro do
adaptador é tratado como defeito da suíte e aborta a execução.

## Casos

Cada caso usa usuários próprios, criados por ele. Entrada inválida passa quando o
produto recusa com 4xx e os pontos não mudam; 5xx, sucesso ou pontos alterados contam
como falha.

### F. Regra de pontos (fronteiras)

| Id | Caso |
|---|---|
| F1 | Cada ação pontuável vale exatamente o declarado, isolada (o bônus de meta disparado pela ação é somado pelo modelo da regra) |
| F2 | Cada item de prêmio vale exatamente o declarado, cada um num aluno novo |
| F3 | Toda meta declarada: em meta-1 o bônus ainda não vale; em meta, vale |
| F4 | Ação sobre o próprio conteúdo não vale, se a regra a exclui |
| F5 | Ações fora da regra valem 0 (editar perfil, receber comentário, abrir páginas) |
| F6 | Desfazer a ação tira os pontos (descurtir, apagar post) |
| F7 | Total do perfil igual ao total do ranking, e igual à regra aplicada ao estado |
| F8 | Interação com quem não participa do ranking (professor) segue o que a regra declara; ambiguidade anotada na evidência |

### E. Entradas inválidas

| Id | Caso |
|---|---|
| E1 | Prêmio com tipo ausente, vazio, texto, decimal, negativo, inexistente |
| E2 | Prêmio para aluno inexistente, id texto, alvo que não participa (professor) |
| E3 | Prêmio concedido por quem não tem permissão (aluno) |
| E4 | Curtir ou comentar post inexistente, ou com id inválido |
| E5 | Conteúdo vazio (post vazio, comentário vazio) não pontua |
| E6 | Repetição: a mesma curtida e o mesmo comentário não somam duas vezes; prêmio repetido segue a regra declarada |
| E7 | Filtro de ranking inválido não quebra (sem 5xx) |

### R. Ranking

| Id | Caso |
|---|---|
| R1 | Ordem decrescente de pontos, no geral e no curso |
| R2 | Desempate pela política declarada |
| R3 | Quem não participa fica de fora, no geral e no curso |
| R4 | O ranking por curso só tem alunos do curso, e as posições começam em 1 |
| R5 | A posição exibida no perfil é a mesma do ranking |
| R6 | Ex-aluno mantém a posição e não pontua mais |

### T. Tiers

| Id | Caso |
|---|---|
| T1 | Fronteira inferior: 0 recusado, 1 é o primeiro tier |
| T2 | 30 e 31 em tiers diferentes, conforme a regra |
| T3 | 70 e 71 |
| T4 | 100 e 101 |
| T5 | 150 aceito e 151 recusado |
| T6 | Aluno não tem tier |

Sem tiers (`capacidades().tiers = false`), T1 a T6 saem ausentes, com a evidência que o
adaptador registra.

## Estados e erros

- **passou**, **falhou**, **ausente**. Cada linha traz a evidência: pedidos feitos,
  status, pontos antes e depois, esperado e obtido.
- Erro da própria suíte (adaptador quebrado, exceção do núcleo) aborta a execução e
  nada é gravado: defeito da suíte não vira falha do produto.
- Produto que não sobe: grava a saída com o cabeçalho e a causa, sem linhas de caso.
- 5xx do produto num caso é falha do produto.

## Etapas e critério de aceite

| # | Etapa | Critério de aceite |
|---|---|---|
| 1 | Este README (plano) | Aprovado pelo autor; o diff tem só este arquivo |
| 2 | Núcleo e adaptador falso | O falso correto passa em tudo; o falso com defeitos plantados gera exatamente as falhas esperadas; tiers ausentes saem ausentes |
| 3 | `rodar.ps1` | Com o falso, grava .md e .json numa pasta de ensaio; origem idêntica antes e depois; pasta temporária apagada; nenhum processo sobra |
| 4 | Adaptador do leigo | `rodar.ps1 -Produto leigo -Repo .\maxx-leigo -Ref main` termina; toda linha com estado e evidência; tiers ausentes; `git status` do maxx-leigo inalterado |
| 5 | Execução real | `avaliacoes/reviews/leigo-testes-referencia.md` e `.json` commitados, nada mais em `reviews/`; conferência manual de duas linhas que passaram e de todas que falharam |
| 6 | Desenho do adaptador do engenheiro | Esqueleto com a interface inteira; README de como subir e autenticar |
