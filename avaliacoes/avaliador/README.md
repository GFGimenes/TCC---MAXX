# Avaliador

Scripts que aplicam a rubrica (`avaliacoes/rubrica.md`) a um produto inteiro do
experimento, com seis revisores de IA independentes (um por eixo), um revisor de
decisões opcional e a consolidação das notas com as hipóteses H1, H2, H3 e a
exploratória. Este README basta para rodar tudo numa janela nova, sem memória.

Tudo roda no Windows PowerShell 5.1, a partir da raiz do repositório `tcc`, nesta
ordem de abertura:

```powershell
cd "C:\Users\Guilherme Gimenes\Documents\Repos\tcc"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

O `Set-ExecutionPolicy -Scope Process` vale só para essa janela. Os comandos abaixo
chamam os scripts dentro da própria janela (`.\avaliacoes\avaliador\...`), e não com
`powershell -File`, porque com `-File` uma lista como `-Export a,b` chega ao script
como um texto só.

## O que cada peça faz

| Arquivo | Papel |
|---|---|
| `avaliar.ps1` | Checkout limpo do produto, uma sessão `claude -p` isolada por eixo, revisor de decisões, registro da execução e formulário do autor. |
| `consolidar.ps1` | `avaliacoes/notas.csv` e `avaliacoes/notas.md`, com H1, H2, H3 e a exploratória. Não preenche a planilha `.xlsx`. |
| `prompts/revisor.md`, `prompts/decisoes.md` | Textos dos prompts, com os marcadores `{{...}}` que o script preenche. |
| `lib/` | Funções: checkout, sessão do revisor, registro e formulário, revisor de decisões, consolidação. |
| `exemplo/` | Repositório de exemplo descartável (empréstimo de livros), com um `CLAUDE.md` isca. Só para o ensaio. |
| `ensaio/ensaio-sessao.txt` | Export fictício para o ensaio do revisor de decisões. |
| `ensaio/saida/` | Saída dos ensaios. Não é versionada. |
| `testes/` | Testes sem sessão (custo zero), conferidores dos ensaios com sessão e a contraprova da isca. |

## Como o isolamento funciona

- **Origem só lida.** O repositório do produto é só lido. O script faz um clone
  `--no-hardlinks` do commit pedido numa pasta temporária (`%TEMP%\avaliador-tcc\`),
  tira o remoto, as branches e o reflog, e confere que HEAD é o hash pedido.
- **Origem conferida antes e depois.** O estado da origem (HEAD, refs, worktrees,
  status, objetos, índice e config) é fotografado antes e depois. Se mudar durante o
  checkout, nada é avaliado.
- **O que fica de fora.** Arquivo não rastreado, alteração não commitada e outras
  branches nunca chegam ao revisor.
- **Uma sessão por eixo.** Cada eixo roda numa sessão nova:
  `claude -p --model claude-opus-5-5 --effort medium`.
  - Ferramentas: só `Read`, `Grep` e `Glob`, com `--restricted`,
    `--strict-mcp-config` e `--permission-prompts none`.
  - Pasta de trabalho: uma pasta de sessão em `%TEMP%`, fora de qualquer repositório,
    com cópias da rubrica, da especificação e dos encaixes. O checkout entra por
    `--add-dir`.
  - Ambiente: `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` e `DISABLE_AUTOUPDATER=1`.
  - O revisor não vê os reviews dos outros eixos.
- **Conferência pela transcrição.** Depois de cada sessão, o script lê a transcrição e
  a saída e confere:
  - que o modelo e o esforço usados são os fixados;
  - que as ferramentas são exatamente as três e que nenhum MCP foi carregado;
  - que nenhum caminho fora das pastas liberadas foi acessado;
  - que nenhuma ferramenta foi negada e que o contexto não foi compactado;
  - que nenhum arquivo de instrução (CLAUDE.md e afins) foi carregado.

  Qualquer desvio deixa o eixo "a conferir".
- **Nota escondida nas trilhas, visível no prompt único.** Na avaliação real de `leigo`
  e `engenheiro`, a nota dos revisores não aparece no terminal nem no registro: o autor
  pontua antes de ver. Em `leigo_pu` e `eng_pu` não há nota cega (pré-registro, §7,
  alteração de 09/11/2026): a nota aparece no terminal e no registro, e o autor a valida
  ou ajusta depois de ler o review (seção "Depois: formulário, reviews e consolidação").

## Contraprova da isca: refazer a cada versão do Claude Code

**O que a contraprova mostra.** A conferência de que nenhum `CLAUDE.md` foi carregado
procura, na transcrição da sessão, a marca que o CLI deixa quando carrega um arquivo
de instrução. Na versão 2.1.316 essa marca é um anexo do tipo "instructions". A marca
pode mudar de uma versão para outra, e aí a conferência ficaria cega sem avisar. A
contraprova é a prova de que ela enxerga.

**Como ela faz isso.** A contraprova abre de propósito uma sessão com o `CLAUDE.md`
isca do exemplo carregado, e confere duas coisas:
- que a sessão obedece à isca (a resposta é "ABACAXI");
- que o detector acusa o arquivo.

O custo é de cerca de US$ 0,45 (medido em 08/11/2026).

**Quando refazer.** Sempre que a versão do Claude Code mudar. A versão usada em cada
avaliação fica no registro da execução, e a versão atual sai de `claude --version`.
Refaça antes de avaliar um produto real com uma versão nova:

```powershell
claude --version
powershell -ExecutionPolicy Bypass -File avaliacoes\avaliador\testes\contraprova-isca.ps1
```

**Resultado esperado** (versão 2.1.316, 08/11/2026):

```
Versão: 2.1.316 (Claude Code)
Resposta da sessão com o CLAUDE.md carregado: ABACAXI
Instruções detectadas: C:\...\repo\CLAUDE.md
Custo da sessão: US$ 0.45...
Contraprova: o detector acusa o CLAUDE.md carregado. Ok.
```

**Se terminar com "Contraprova FALHOU",** não avalie produto nenhum com essa versão. A
função `Get-InstrucoesCarregadas`, em `lib/revisor.ps1`, precisa ser ajustada à marca
nova antes.

Na mesma troca de versão, refaça também os dois ensaios com sessão da seção seguinte:
- o de um eixo confirma modelo e esforço pela transcrição;
- o do revisor de decisões confirma o formato das leituras que a conferência de
  "export lido inteiro" usa.

## Ensaio, antes de avaliar produto real

O ensaio usa só o repositório de exemplo, criado numa pasta temporária a cada
execução, e grava em `avaliacoes/avaliador/ensaio/saida/`. Os produtos do experimento
não são tocados.

1. **Testes sem sessão (custo zero).** São os testes das etapas 1 a 5: checkout,
   leitura do bloco JSON, auditoria de caminhos, `-SemClaude`, registro, formulário,
   revisor de decisões com um claude falso e consolidação com dados fictícios. As
   etapas 3 e 5 cobrem os dois modos de nota, com um produto falso de cada tipo.

   ```powershell
   powershell -ExecutionPolicy Bypass -File avaliacoes\avaliador\testes\rodar-testes.ps1
   ```

   Esperado: `Testes sem sessão: os 5 passaram.`

2. **Contraprova da isca** (seção anterior), se a versão do CLI mudou desde a última.

3. **Prompts dos seis eixos sem sessão.** Grava os seis prompts, o registro e o
   formulário em `ensaio\saida\sem-claude\` e `ensaio\saida\autor\`, sem chamar o
   modelo. Os dois avisos de encaixe ausente (Código e Infraestrutura) são esperados.

   ```powershell
   .\avaliacoes\avaliador\avaliar.ps1 -Ensaio -SemClaude
   ```

4. **Um eixo com sessão de verdade**, cerca de US$ 0,26 e 1 minuto. O padrão é o eixo
   Documentação; para outro, use `-Eixos codigo`, por exemplo. O conferidor roda 16
   critérios:
   - status ok;
   - modelo e esforço confirmados pela transcrição;
   - ferramentas e acessos;
   - a isca lida como arquivo e não obedecida;
   - nenhuma das armadilhas do repositório de origem na sessão.

   ```powershell
   .\avaliacoes\avaliador\avaliar.ps1 -Ensaio
   powershell -ExecutionPolicy Bypass -File avaliacoes\avaliador\testes\conferir-ensaio.ps1
   ```

   Para conferir outro eixo, passe `-Eixo <eixo>` ao conferidor.

5. **Revisor de decisões com sessão de verdade**, sobre o export fictício (cerca de
   US$ 0,12). O conferidor roda 19 critérios:
   - as 3 decisões plantadas, com tipo e forma;
   - as 2 perguntas, 1 respondida;
   - os pedidos da persona fora da lista;
   - a instrução escondida no export ignorada;
   - export lido inteiro;
   - nenhum acesso ao repositório.

   ```powershell
   .\avaliacoes\avaliador\avaliar.ps1 -Ensaio -Eixos decisoes
   powershell -ExecutionPolicy Bypass -File avaliacoes\avaliador\testes\conferir-decisoes.ps1
   ```

Rodar o mesmo ensaio de novo não apaga nada: o review anterior vira `-t<n>`.

## Antes de avaliar um produto real

Para cada produto, deixe pronto:

1. **Testes de referência (eixo Código).** Rode a suíte de testes de referência no
   produto e grave o resultado em `avaliacoes/reviews/<produto>-testes-referencia.md`.
   O script copia o arquivo para a sessão, e o prompt manda usá-lo como critério
   objetivo. Sem o arquivo, o script avisa e segue, e o prompt pede ao revisor que
   declare a ausência e pontue sem ele.
2. **Relatório de carga (eixo Infraestrutura), se houver teste de carga.** Os arquivos
   ficam em `avaliacoes/carga/<produto>-<qualquer coisa>` (por exemplo
   `avaliacoes/carga/engenheiro-k6.md`). Valem só os nomes `<produto>-*` ou
   `<produto>.<ext>`, para que os do `leigo_pu` não entrem no `leigo`. Sem o
   relatório, a regra é a mesma do item anterior.
3. **Exports das sessões, para o revisor de decisões.** São os `/export` de cada sessão
   do agente construtor:
   - trilhas iterativas: um por rodada, `resultados/<trilha>/<id>-sessao.txt`;
   - prompt único: `resultados/engenheiro/eng_pu-sessao.txt` e
     `resultados/leigo/leigo_pu-sessao.txt`.

   O revisor de decisões roda uma sessão por export. Ele só lê uma cópia do export,
   na pasta da sessão, e não tem acesso ao repositório do produto.
4. **A Ref final de cada produto, e a origem sem trabalho por commitar.** O script
   avalia o commit, e o que não estiver commitado não entra.
5. **A contraprova da isca e os ensaios**, se a versão do CLI mudou.

## Avaliar um produto real

Os quatro produtos, com os repositórios na raiz do `tcc`:

| Produto | `-Repo` | `-Ref` | Exports |
|---|---|---|---|
| `leigo` | `.\maxx-leigo` | `main` | `resultados\leigo\leigo_*-sessao.txt`, menos `leigo_pu-sessao.txt` |
| `engenheiro` | `.\maxx-engenheiro` | `main` | `resultados\engenheiro\eng_*-sessao.txt`, menos `eng_pu-sessao.txt` |
| `leigo_pu` | `.\maxx-leigo-pu` | `main` | `resultados\leigo\leigo_pu-sessao.txt` |
| `eng_pu` | `.\maxx-engenheiro-pu` | `main` | `resultados\engenheiro\eng_pu-sessao.txt` |

O prefixo `leigo_*` da trilha do leigo segue o padrão da trilha do engenheiro.
Confira os nomes em `resultados\leigo\` antes de rodar.

Comando completo, com os seis eixos e o revisor de decisões. O exemplo é do
engenheiro:

```powershell
$exports = (Get-ChildItem resultados\engenheiro\eng_*-sessao.txt | Where-Object Name -ne 'eng_pu-sessao.txt').FullName
.\avaliacoes\avaliador\avaliar.ps1 -Produto engenheiro -Repo .\maxx-engenheiro -Ref main -Export $exports
```

Prompt único do engenheiro:

```powershell
.\avaliacoes\avaliador\avaliar.ps1 -Produto eng_pu -Repo .\maxx-engenheiro-pu -Ref main -Export resultados\engenheiro\eng_pu-sessao.txt
```

Variações:

- **Conferir os prompts sem gastar:** acrescente `-SemClaude`. Os prompts e o registro
  vão para `avaliacoes\reviews\sem-claude\`, e o formulário do autor é criado se não
  existir.
- **Só alguns eixos**, por exemplo para refazer um que ficou "a conferir":
  `-Eixos codigo,seguranca`. O review anterior do eixo vira `-t<n>` e não é apagado.
- **Só o revisor de decisões:** `-Eixos decisoes -Export ...`.
- **Tempo limite por sessão:** `-TempoLimiteMin 90`. O padrão é 60. Se estourar, o
  eixo fica "falhou" e o script segue.
- **Inspecionar a pasta temporária:** `-Manter`.

O que a execução grava:

| Arquivo | Conteúdo |
|---|---|
| `avaliacoes/reviews/<produto>-<eixo>.md` | Cabeçalho (status, tentativa, commit, modelo, esforço, sessão) e o texto do revisor, sem edição. |
| `avaliacoes/reviews/<produto>-<eixo>.json` | Campos do bloco JSON e os metadados da sessão. |
| `.prompt.txt`, `.saida.jsonl`, `.sessao.jsonl` | O prompt exato, a saída bruta do CLI e a transcrição de cada eixo. |
| `avaliacoes/reviews/<produto>-decisoes-<id>.md` e `.json` | Revisor de decisões, um par por export. |
| `avaliacoes/reviews/<produto>-decisoes.md` e `.json` | O conjunto dos exports do produto, sem deduplicar. |
| `avaliacoes/reviews/<produto>-registro.md` | Uma seção por execução. Sem notas em `leigo` e `engenheiro`; com a coluna "Nota do revisor" em `leigo_pu` e `eng_pu`. |
| `avaliacoes/autor/<produto>.md` | Formulário do autor, criado só na primeira vez e nunca sobrescrito. Em `leigo_pu` e `eng_pu`, a cada execução o script preenche a linha "Nota do revisor:" dos eixos que ainda não têm número, e só ela. |

O `.json` de cada eixo traz:
- status e motivos;
- tentativa, início, fim e duração;
- repositório, ref e hash avaliado;
- modelo e esforço pedidos e confirmados;
- versão do CLI e id da sessão;
- tokens, custo e turnos;
- SHA-256 da rubrica, da especificação e do prompt;
- os encaixes;
- ferramentas, acessos fora das pastas liberadas e instruções carregadas;
- os campos do revisor.

Status:
- **ok:** passou em todas as conferências.
- **a conferir:** a sessão terminou, mas há motivo para olhar. O motivo fica no
  `.json`, no `.md` e no registro. Exemplos:
  - bloco JSON mal formado;
  - modelo ou esforço diferentes dos fixados;
  - acesso fora das pastas liberadas;
  - arquivo de instrução carregado;
  - contexto compactado;
  - no revisor de decisões, export não lido inteiro, conferido linha a linha, ou
    contagem que não bate com as listas.

  Refaça o eixo com `-Eixos`, ou valide à mão.
- **falhou:** tempo limite, sessão sem resposta ou erro do CLI. A saída de erro fica
  no `.md`.

## Depois: formulário, reviews e consolidação

O formulário tem dois modos, conforme o produto:

| Produto | Modo | Nota do autor |
|---|---|---|
| `leigo`, `engenheiro` | nota cega | `Nota (1 a 5):`, dada antes de abrir os reviews |
| `leigo_pu`, `eng_pu` | nota validada (pré-registro, §7, alteração de 09/11/2026) | `Nota validada (1 a 5):`, dada depois de ler o review |

Os arquivos já gerados não mudam de modo: o formulário só é criado na primeira vez, e o
do `leigo` continua o de nota cega.

**Nota cega (`leigo`, `engenheiro`),** na ordem da rubrica ("Como preencher"):

1. **Preencha `avaliacoes/autor/<produto>.md` antes de abrir os reviews.** O registro
   (`<produto>-registro.md`) não tem notas e pode ser lido. O formulário pede:
   - nas seis seções, a nota (um inteiro de 1 a 5 na linha `Nota (1 a 5):`), as
     observações objetivas e as regras ausentes;
   - nas seções finais, as decisões sem perguntar (tabela por tipo e forma, `Total:` e
     lista) e as perguntas sem resposta (`Total:` e lista). Conte a partir do export e
     do diff da branch. O `<produto>-decisoes.md` é insumo para essa contagem.

   Mantenha os títulos e os rótulos, porque o `consolidar.ps1` lê o arquivo por eles.
2. **Só então abra os reviews.** Para cada divergência de 2 pontos ou mais, escreva
   uma linha na seção "Depois de abrir os reviews".

**Nota validada (`leigo_pu`, `eng_pu`):**

1. **Leia o review de cada eixo** (`avaliacoes/reviews/<produto>-<eixo>.md`) antes de
   preencher a seção do eixo. Cada seção traz quatro linhas no lugar de `Nota (1 a 5):`:
   - `Nota do revisor:` preenchida pelo `avaliar.ps1` a partir do `.json` do eixo (o
     número, quando o status é ok; o status, quando não é; "pendente", sem review). Não
     edite. Se o eixo for refeito, o script troca só linha sem número; uma nota já escrita
     fica, e sai um aviso no terminal se o review novo tiver outra;
   - `Validada (sim ou não):` "sim" se a nota do revisor se sustenta, "não" se você a
     ajusta;
   - `Nota validada (1 a 5):` sempre um inteiro de 1 a 5, a do revisor ou a sua;
   - `Motivo do ajuste:` obrigatório quando a nota muda.

   Observações objetivas, regras ausentes, decisões sem perguntar e perguntas sem
   resposta são iguais às do modo cego. Não há seção "Depois de abrir os reviews".
2. **Confira os avisos do `consolidar.ps1`.** Ele aponta, como problema no formulário,
   "sim" com nota diferente da do revisor, ajuste sem motivo e `Validada` fora de sim
   ou não. A nota validada vale mesmo assim; o aviso é para corrigir.

**Consolide:**

   ```powershell
   .\avaliacoes\avaliador\consolidar.ps1
   ```

   Gera `avaliacoes/notas.csv` e `avaliacoes/notas.md`.
   - **CSV:** separador `;` e UTF-8 com BOM, para o Excel em português. Colunas:
     produto, eixo, nota_revisor, nota_autor, divergencia, regras_ausentes e
     decisoes_listadas.
   - **MD:** notas e totais por produto, a matriz do autor, H1, H2, H3, a exploratória
     e as decisões listadas pelos revisores. Em `leigo_pu` e `eng_pu`, também a lista
     dos ajustes do autor (nota do revisor, nota validada e motivo).
   - **Hipóteses:** usam a nota e as contagens do autor. Em `leigo_pu` e `eng_pu`, a
     nota do autor é a nota validada.
   - **Dados que faltam:** o que não tem dado fica "pendente".
   - **Revisor oculto, só na nota cega:** enquanto o formulário de `leigo` ou
     `engenheiro` não tem as seis notas, nada do revisor desse produto aparece. Em
     `leigo_pu` e `eng_pu` o revisor nunca fica oculto.

   Regras aplicadas:
   - **Divergência:** autor menos revisor, com asterisco quando o módulo é 2 ou mais.
     Em `leigo_pu` e `eng_pu`, "n/a (validada)", porque não há nota cega.
   - **H1:** eng_pu - leigo_pu >= 1 em pelo menos 4 dos 5 eixos (Segurança,
     Infraestrutura, Documentação, Código, Projeto e arquitetura).
   - **H2:** em nenhum dos 5 eixos eng_pu - leigo <= -1.
   - **H3,** leitura literal de §3.1.5.1 sobre as contagens do autor: leigo_pu > eng_pu
     e (leigo_pu - eng_pu) > (leigo - engenheiro).
   - **Exploratória,** descritiva e sem regra no pré-registro: por eixo, as diferenças
     entre personas e entre condições e a média dos módulos de cada par.

## Limites conhecidos

- **Arquivos não rastreados.** A fotografia da origem não detecta mudança de conteúdo
  num arquivo não rastreado que já existia. Esses arquivos nunca entram no checkout.
- **Dependência da versão do CLI.** Quatro conferências dependem de formatos da versão
  2.1.316, e por isso a contraprova e os ensaios devem ser refeitos a cada versão:
  - a marca de arquivo de instrução carregado;
  - o campo de esforço na transcrição;
  - os metadados das leituras (`startLine`, `numLines`, `totalLines`, `content`);
  - o evento de compactação.

  Se um formato mudar, o resultado tende a "a conferir", nunca a um falso ok, exceto
  pela marca de instrução, que é o que a contraprova cobre.
- **Exports grandes.** São lidos em várias leituras de até 2.000 linhas. Uma linha que
  a ferramenta devolva cortada não conta como lida. Os exports atuais têm no máximo
  330 caracteres por linha.
- **Custo de produto real ainda não medido.** No exemplo, um eixo custa cerca de US$
  0,26. O custo real de cada sessão fica no registro.
- **Ensaio na mesma pasta.** O ensaio grava `ensaio/saida/` na mesma pasta em execuções
  seguidas. Os reviews anteriores viram `-t<n>`, e o registro só cresce.
