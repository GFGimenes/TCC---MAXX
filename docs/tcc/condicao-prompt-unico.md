# 3.1.5 Condição de prompt único (rascunho)

Rascunho da seção que entra no capítulo 3 depois da §3.1.4, no mesmo padrão do
`capitulo-3-experimento.md`: português, sem travessões, modelos de IA referidos pelo
nome da empresa (Anthropic), afirmações sobre resultado só com a execução registrada.
A condição é nova (proposta em 23/10/2026) e ainda não está em nenhum outro documento
do experimento. Ela só pode rodar depois de pré-registrada (§3.1.5.8). As decisões que
dependem do autor estão marcadas no texto e reunidas na §3.1.5.9, que é nota de
trabalho e sai da versão final.

## 3.1.5 Condição de prompt único

As duas trilhas descritas até aqui são iterativas: cada persona conversa com o agente
ao longo de várias rodadas, responde perguntas, pede tela por tela e, no caso do
engenheiro, corrige por prompt depois do review. Isso deixa uma explicação
concorrente para qualquer diferença entre os produtos: o engenheiro poderia chegar a
um produto melhor não pelo que sabe, mas porque fala mais com o agente, responde
mais perguntas e corrige mais vezes. A condição de prompt único existe para separar
essas duas coisas. Cada persona entrega ao agente, em uma única mensagem, tudo o que
entrega na abertura da trilha iterativa; depois disso, nenhuma mensagem humana entra
na sessão, e o agente vai até onde consegue sozinho.

### 3.1.5.1 Hipóteses

A hipótese geral é que a diferença entre as trilhas está no conteúdo do que a persona
entrega ao agente, e não na quantidade de mensagens trocadas. Ela se desdobra em três
hipóteses verificáveis e uma exploratória:

- **H1.** Com uma mensagem só em cada persona, o produto do engenheiro recebe nota
  maior que o do leigo nos eixos Segurança, Infraestrutura, Documentação, Código e
  Projeto e arquitetura, no mesmo sentido da diferença observada entre as trilhas
  iterativas.
- **H2.** O produto do prompt único do engenheiro não fica abaixo do produto final da
  trilha iterativa do leigo nesses cinco eixos. Se ficar, as mensagens a mais do
  leigo compensaram a falta de conteúdo, e a hipótese geral perde força.
- **H3.** O agente toma mais decisões sem perguntar no prompt único do leigo do que
  no do engenheiro, e a diferença entre as duas contagens é maior que nas trilhas
  iterativas, porque no prompt único ninguém responde às perguntas dele.
- **Exploratória.** Em cada eixo, a diferença entre personas dentro de uma mesma
  condição é maior que a diferença entre condições dentro de uma mesma persona.

O eixo UX entra na comparação, mas fica fora de H1 e H2: na trilha do engenheiro ele
depende dos mockups produzidos antes do código (§3.1.4), o que mistura conteúdo do
prompt e artefato visual.

Como há uma execução por condição e a escala é ordinal de 1 a 5, a comparação é
descritiva, sem teste estatístico. Para que "maior" e "no mesmo sentido" não sejam
decididos depois de ver os dados, a regra de decisão é fixada no pré-registro.
Proposta: em cada eixo, conta como diferença uma distância de pelo menos 1 ponto na
nota validada por humano; H1 é apoiada se a diferença existir, no sentido previsto,
em pelo menos quatro dos cinco eixos; H2 é apoiada se em nenhum dos cinco eixos o
prompt único do engenheiro ficar 1 ponto ou mais abaixo do produto final do leigo
iterativo (decidido pelo autor em 23/10/2026).

### 3.1.5.2 O que a condição isola

Com a condição nova, o experimento passa a ter quatro produtos, numa matriz de duas
personas por duas condições:

| | Iterativa | Prompt único |
|---|---|---|
| **Leigo** | `maxx-leigo`, `main` | `maxx-leigo`, branch `rodada/leigo_pu` |
| **Engenheiro** | `maxx-engenheiro`, `main` | `maxx-engenheiro`, branch `rodada/eng_pu` |

Entre as personas, dentro do prompt único, as duas sessões têm exatamente uma mensagem
humana, nenhuma resposta a pergunta do agente, nenhum prompt por tela e nenhum review
corretivo. O que muda entre elas é só o conteúdo da mensagem. Essa é a comparação
limpa da condição: o que ela mostrar não pode ser atribuído a número de turnos, a
diálogo ou à correção do engenheiro, porque nenhum dos três existe ali.

Dentro de cada persona, entre o prompt único e a trilha iterativa, a diferença reúne
tudo o que a iteração acrescenta: mais mensagens, o conteúdo dos prompts por tela, as
respostas às perguntas do agente (como a `r1` do engenheiro, com as respostas a 8
bloqueadores) e, no engenheiro, as rodadas de correção `_v2`. Essas coisas não se
separam uma da outra nesta comparação; o que ela mede é o efeito do processo
iterativo inteiro de cada persona.

O cruzamento entre o prompt único do engenheiro e a trilha iterativa do leigo
responde à pergunta mais direta da condição: muitas mensagens sem conhecimento de
engenharia chegam aonde uma mensagem com esse conhecimento chega?

A condição não isola o efeito do review humano sobre a nota (a validação humana
continua igual nas quatro células) e não isola o conteúdo dos mockups do engenheiro,
que entram nas duas condições da trilha dele.

### 3.1.5.3 O prompt único de cada persona

O prompt único carrega tudo que a persona entrega ao agente na abertura da trilha
iterativa, e nada que tenha nascido de resposta do agente.

- **Leigo.** O texto de `prompts/leigo/leigo_00_abertura.md`, tal como enviado na
  trilha iterativa. As frases de reação previstas na política do leigo ("faz do jeito
  que ficar melhor") não entram: são respostas, e no prompt único não há respostas.
- **Engenheiro.** Os textos de `prompts/engenheiro/eng_00_produto.md` e
  `prompts/engenheiro/eng_00_tecnica.md`, em sequência, numa mensagem só. A `r1` não
  entra, porque foi escrita em resposta às perguntas do agente; incluí-la daria ao
  engenheiro, no prompt único, o benefício de uma iteração. O pacote de design entra
  como na `eng_00`: commitado na branch antes da sessão (§3.1.5.4), porque faz parte
  do que a persona entrega.

Há um problema a resolver antes de congelar os textos. Os dois prompts do engenheiro
foram escritos para uma conversa: o `eng_00_produto` termina pedindo só confirmação
de entendimento, sem código nem proposta técnica, e o `eng_00_tecnica` define como
entregável da rodada o plano mestre, sem código (diário de 11/10). Enviados como estão,
eles levariam o agente a parar no plano, enquanto o fecho do leigo ("Consegue fazer
pra mim ?") deixa o agente livre para codar. A condição compararia um plano com um
aplicativo e mediria a instrução de parar, não o conteúdo. Há duas saídas, e a escolha
é do autor:

1. **Textos literais.** Os prompts vão como estão, e "até onde vai" do engenheiro é o
   plano. A condição passa a medir o conteúdo junto com o método de trabalho de cada
   persona.
2. **Textos sem as instruções de turno, mais um fecho comum.** Saem apenas as frases
   que organizam a conversa (pedir só confirmação, anunciar que a parte técnica vem
   depois, definir o plano como entregável da rodada e proibir código nela); nenhuma
   regra de produto ou decisão técnica sai. Os dois prompts únicos recebem, no fim, o
   mesmo parágrafo, idêntico, avisando que não haverá respostas a perguntas, que o
   agente deve decidir e registrar o que decidiu, e que deve ir até onde conseguir.
   O diff entre cada prompt único e o original vai inteiro para o pré-registro e para
   o apêndice.

A opção 2 é a que responde à pergunta da condição, e é a recomendada; o fecho comum é
texto do autor escrito depois de a `eng_00` ter começado, e isso entra nas ameaças à
validade (§3.1.5.6). Os arquivos ficam em `prompts/leigo/leigo_pu.md` e
`prompts/engenheiro/eng_pu.md`, com o cabeçalho de sempre e o texto depois da linha
`---`, e não mudam depois de pré-registrados.

### 3.1.5.4 Protocolo de execução

O protocolo é o da §3.1.3 e do `protocolo-de-rodada.md`, com as diferenças abaixo.

**Repositório, branch e semente.** Cada prompt único roda no repositório da própria
persona, numa branch própria (`rodada/leigo_pu` em `maxx-leigo`, `rodada/eng_pu` em
`maxx-engenheiro`), criada a partir do commit semente vazio, o mesmo das trilhas
iterativas (`1577ae9`, README e `.gitattributes`). A branch nunca é mesclada na
`main`: a `main` é a trilha iterativa. Na branch do engenheiro, o primeiro commit é o
pacote de design, com a mesma árvore do commit de design da `rodada/eng_00`
(conferida pelo hash da árvore).

**Isolamento.** Uma branch no mesmo repositório traz de volta o problema que levou às
duas trilhas em repositórios separados (diário de 10/10): o agente executa `git` e, com
um `git log --all` ou `git branch -a`, enxergaria a trilha iterativa da própria
persona, que já tem a `rodada/eng_00` em andamento. Proposta de procedimento: a sessão
roda num clone local novo, que só contém a semente (e, no engenheiro, o commit de
design), sem remoto configurado, numa pasta com o mesmo nome do repositório da trilha
e fora da pasta `tcc`, com as pastas acima dela conferidas como na primeira sessão de
cada repo (nenhum `CLAUDE.md`, `AGENTS.md` ou `CLAUDE.local.md`). Só depois de as duas
trilhas iterativas terminarem o autor adiciona o remoto e envia a branch, para que
nenhuma sessão iterativa veja a branch do prompt único num `git fetch`. A localização
exata da pasta é decisão do autor.

**Ambiente.** O mesmo das trilhas iterativas, conforme o quadro de ambiente da §3.1.3:
mesma versão do Claude Code (a fixada em 22/10, com a atualização automática
desligada), mesmo modelo da Anthropic escolhido pelo nome, mesmo nível de esforço,
mesmo modo de permissão, memória automática desligada, as mesmas skills e conectores
visíveis. Conferido com `/status` e `/context` antes de colar o prompt, como em
qualquer rodada. As duas execuções rodam no mesmo dia, uma depois da outra, para
reduzir a chance de mudança no serviço entre elas; a ordem fica registrada.

**Entrada humana.** O autor cola o prompt único e, a partir daí, as únicas ações
permitidas são as de aprovação de execução. No modo de permissão fixado ("auto mode")
o agente já executa sem pedir aprovação a cada ação; se algum pedido de aprovação
aparecer, a política é fixa e igual nas duas personas: aprova o que tem efeito dentro
da pasta do clone e a instalação de dependências; nega leitura ou escrita fora da
pasta. Cada pedido e cada resposta ficam registrados. Não são permitidos: responder
pergunta, comentar, interromper para redirecionar, enviar "continue" ou qualquer
comando que leve texto ao agente. Os únicos comandos do autor são `/status` e
`/context` na abertura e `/export` no fim.

**Critério de parada.** A execução termina no primeiro destes eventos:

1. O agente encerra o turno, seja qual for o conteúdo da última mensagem: relatório de
   conclusão, pergunta, pedido de confirmação ou oferta de continuar.
2. O agente abre uma pergunta que bloqueia a sessão à espera de escolha. A pergunta não
   é respondida; a execução é encerrada e registrada como "parada por pergunta".
3. A execução atinge o teto de tempo de relógio ou o teto de tokens, com os valores
   fixados no pré-registro (a confirmar com o autor; proposta: tetos acima da maior
   rodada iterativa observada até a data do pré-registro, para que o teto só pare
   execuções anômalas).

Interrupções externas não contam como parada do agente. Proposta: se a sessão for
interrompida por falha do ambiente (travamento, reinício do computador, como em 11/10),
a execução é descartada e refeita do zero, num clone novo, com o descarte registrado;
se for interrompida por limite de uso da conta, o autor espera a liberação e envia uma
única mensagem literal, fixada no pré-registro (por exemplo, "continue"), contada como
retomada técnica e não como turno humano. As duas regras são decisão do autor.

**O que conta como "até onde vai".** É o estado da branch no momento da parada, depois
do commit de fechamento (se o agente não tiver commitado, o autor commita sem alterar
arquivo, como no passo 5 do protocolo). Esse estado é descrito em quatro partes:

1. **Fase alcançada:** só texto (plano, perguntas), fundação (projeto, banco,
   configuração, sem funcionalidade), ou funcionalidade (alguma tela utilizável).
2. **Estado de execução:** instala, compila, sobe localmente, os testes da própria
   trilha passam, a suíte de referência roda.
3. **Inventário de cobertura:** uma lista fixa, igual para os quatro produtos, com as
   seis telas de `docs/especificacao-telas.md` e as regras do produto de
   `docs/contexto-comum.md` (papéis, login só institucional, tipos de prêmio, tiers e
   faixas de pontos, aluno sem tier, professor só premia aluno com quem tem aula,
   progressão, comprovação por foto, contestação e revogação, ex-alunos, rankings
   geral e por curso, mural). Cada item recebe um estado: implementado e funcionando,
   implementado e quebrado, parcial, só simulado (dados fixos, tela sem lógica) ou
   ausente. A lista é escrita no pré-registro, antes de qualquer execução.
4. **Alegações sem lastro:** o que a mensagem final do agente diz que está pronto e o
   inventário mostra que não está.

**Registro.** Export da sessão em `resultados/<trilha>/<id>-sessao.txt`; cópia da
transcrição automática (`.jsonl`) em `resultados/<trilha>/<id>-transcricao.jsonl`,
porque é dela que saem os tokens e os tempos por mensagem e porque ela expira (§3.1.3);
registro da rodada em `resultados/<trilha>/<id>.md`, com o evento de parada. IDs:
`leigo_pu` e `eng_pu`, os mesmos no prompt, no resultado, no review e na planilha.

**Revisão.** A mesma avaliação de fim de produto das trilhas iterativas
(`avaliacoes/rubrica.md`, decidido em 01/11/2026): seis sessões de revisor, uma por
eixo (experiência do usuário, segurança, infraestrutura, documentação, código, projeto
e arquitetura), na pasta do clone e na branch da condição, e a avaliação independente
do autor nos mesmos seis eixos, sem ver a nota do revisor; a divergência é resultado.
Nada é corrigido e não existe `_v2` nesta condição.

**Validação técnica.** A suíte de referência da §3.2 roda sobre a regra de pontos que
cada produto tiver, com "ausente" quando não houver. O teste de carga não se aplica:
o prompt único não tem deploy, porque o agente não recebe credenciais e o autor não
pode fornecê-las sem um turno humano. Se o agente deixar o deploy preparado, isso é
registrado no inventário (a confirmar com o autor se um teste de carga local entra
como dado complementar, sabendo que não é comparável ao dos deploys).

### 3.1.5.5 Métricas

**Rubrica.** Os seis eixos, a mesma escala, a nota do revisor ao lado da nota do
autor, com o estado "regra ausente" como nas trilhas iterativas.

**Decisões tomadas pelo agente sem perguntar.** Cada decisão que o prompt não
determinou e o agente tomou, classificada por tipo (regra de produto, stack e
arquitetura, modelo de dados, segurança, UX e visual, testes e processo, hospedagem
e deploy) e por forma: declarada (o agente escreveu que decidiu) ou silenciosa (só
aparece no código). Fontes: export da sessão, diff da branch e a seção de decisões do
review. Ao lado, as perguntas que o agente fez e ficaram sem resposta.

**O que ficou quebrado ou ausente.** Do inventário de cobertura: itens quebrados,
parciais, simulados e ausentes; falhas de instalação, compilação e execução; testes
que falham; e as alegações sem lastro.

**Custo.** Tokens de entrada, de saída e de cache, somados da transcrição; tempo de
relógio do envio até a parada; tempo ativo do agente, pelas marcas de tempo da
transcrição; número de chamadas de ferramenta, de commits e de compactações de
contexto; número de pedidos de aprovação. Turnos humanos: um, por construção. Se a
versão fixada do Claude Code tiver comando próprio de custo ou de uso, o valor dele é
registrado ao lado da soma (a confirmar com o autor qual comando a versão oferece).

Para comparar custo com as trilhas iterativas, as rodadas iterativas precisam ter os
mesmos números. Hoje o protocolo registra turnos e tempo, mas não tokens; a condição
depende de acrescentar ao protocolo a cópia da transcrição de cada rodada e a soma de
tokens, inclusive da `eng_00`, que já está em andamento.

### 3.1.5.6 Ameaças à validade específicas desta condição

**O prompt único não é o jeito natural de nenhuma das personas.** O engenheiro
trabalha em diálogo, pede opções com pesos e corrige depois do review
(`persona-engenheiro.md`); o leigo, segundo o corpus, pede por partes (9 de 23
respostas). A condição mede o conteúdo de cada persona sem o método de interação de
cada uma, que é o que se quer isolar, mas não descreve como nenhuma delas trabalharia.
O resultado vale como experimento de controle, não como retrato de uso real.

**O fecho comum altera o conteúdo.** Se for adotada a opção 2 da §3.1.5.3, o fecho é
texto do autor que nenhuma das personas escreveria e que muda o comportamento do
agente (decidir em vez de perguntar). Ele é idêntico nas duas personas, o que mantém a
comparação entre elas, mas afasta as duas do comportamento iterativo. Além disso, foi
escrito depois de a `eng_00` ter começado, com o autor já sabendo que o agente,
naquela sessão, devolveu perguntas e decisões pendentes em vez de código. O controle
é o pré-registro: o fecho e a retirada das instruções de turno são fixados e
publicados no apêndice antes da primeira execução.

**Uma execução por condição.** O agente não é determinístico; outra execução do mesmo
prompt poderia ir mais longe ou parar antes. Com uma execução, uma parada precoce ou
um desvio raro pesa como resultado. Controle possível: repetir cada prompt único
algumas vezes e relatar todas as execuções; o número de repetições, se houver, é
fixado no pré-registro (a confirmar com o autor).

**Vazamento entre condições.** Sem o clone isolado da §3.1.5.4, o agente do prompt
único poderia ler pelo `git` a trilha iterativa da mesma persona, e o agente da trilha
iterativa poderia ler a branch do prompt único. Controle: clone sem remoto, branch
enviada só no fim, e a mesma conferência de acesso do checklist humano (o export é
lido para ver se o agente acessou algo fora da pasta; se acessou, a execução é
descartada e refeita).

**Deriva de ambiente.** A trilha iterativa do engenheiro já teve uma mudança de versão
do Claude Code no meio da `eng_00` (linha do tempo, 22/10). Se o prompt único rodar
semanas depois das rodadas iterativas, o serviço por trás do mesmo nome de modelo pode
ter mudado sem aviso. Controle: mesma versão fixada, mesmo nome de modelo, as duas
execuções no mesmo dia, data e versões registradas.

**Uma sessão longa contra várias sessões curtas.** Na trilha iterativa cada rodada é
uma sessão nova; no prompt único tudo acontece numa sessão, que pode passar por
compactação de contexto. Parte da diferença entre as condições pode vir da dinâmica
de contexto, não do número de mensagens humanas. Controle: registrar as compactações
e declarar a ameaça.

**O critério de parada molda o resultado.** Um teto baixo corta uma execução que
iria mais longe; tratar uma pergunta como parada favorece o prompt que antecipa as
respostas, o que é parte do que se quer medir, mas precisa estar dito. Controle: tetos
fixados antes, com folga, e o evento de parada registrado.

**A comparação com a trilha iterativa mistura várias coisas.** Dentro de cada persona,
prompt único contra iterativa mistura número de mensagens, conteúdo dos prompts por
tela, respostas e correções (§3.1.5.2). Só a comparação entre personas dentro do
prompt único sustenta uma afirmação sobre conteúdo; as outras são lidas como efeito do
processo inteiro.

**Avaliação sem cegamento.** O revisor e o autor sabem qual condição e qual persona
estão avaliando (o nome da pasta e da branch dizem). Controle parcial: mesmo prompt de
revisor, rubrica com critérios observáveis e o inventário de cobertura com estados
definidos antes.

### 3.1.5.7 Como a condição entra em resultados e discussão

No capítulo 4 (seção 4.8), a condição aparece em três tabelas: as notas validadas
por eixo nas quatro células da matriz, com a nota do revisor ao lado; o inventário de
cobertura das quatro células, item a item; e as decisões do agente e o custo (tokens,
tempo, chamadas de ferramenta, turnos humanos) nas quatro células. O evento de parada
de cada execução e a fase alcançada ficam no texto da seção.

No capítulo 5 (seção 5.3), a leitura segue regras fixadas no pré-registro, para que o
padrão encontrado não seja interpretado depois de visto. Proposta de regras:

| Padrão observado | Leitura |
|---|---|
| A diferença entre personas no prompt único tem o mesmo sentido e tamanho parecido com a da trilha iterativa | A diferença está no conteúdo do que a persona entrega; a iteração não a cria (H1 apoiada) |
| Mesmo sentido, mas menor no prompt único | O conteúdo explica parte da diferença, e o processo iterativo (prompts por tela, respostas, correção) amplia; a discussão diz em quais eixos |
| Diferença perto de zero ou invertida no prompt único, com diferença presente na trilha iterativa | A diferença vem do processo iterativo, não do conteúdo da abertura (H1 não apoiada); registrado como achado, conforme a §3.7 do rascunho |
| Prompt único do engenheiro igual ou acima do produto final do leigo iterativo | Mensagens a mais do leigo não compensaram a falta de conteúdo (H2 apoiada) |
| Prompt único do engenheiro abaixo do produto final do leigo iterativo | A iteração do leigo compensou, nesses eixos, a falta de conteúdo (H2 não apoiada) |

A contagem de decisões do agente entra na discussão sobre quem faz o trabalho de
definição (seção 5.2): no prompt único do leigo, tudo o que não está na abertura de
481 caracteres é decidido pelo agente ou fica ausente, e a lista dessas decisões é o
retrato mais direto dos padrões que o agente assume quando ninguém decide por ele. O
custo entra na seção 5.4, ao lado do custo de entrada do engenheiro.

### 3.1.5.8 Pré-registro

Como a política de reação do leigo e os prompts de abertura das duas trilhas, a
condição de prompt único é fixada antes de rodar e não muda depois de nenhum
resultado. O pré-registro é um commit no repositório do TCC, feito antes da primeira
execução, com a data e o hash anotados na linha do tempo e no diário, contendo:

1. Os arquivos `prompts/leigo/leigo_pu.md` e `prompts/engenheiro/eng_pu.md`, com o
   diff de cada um em relação aos prompts originais e, se adotado, o texto do fecho
   comum.
2. As hipóteses H1, H2 e H3, a hipótese exploratória e a regra de decisão de cada uma.
3. O procedimento de isolamento (clone, pasta, remoto, momento do envio da branch).
4. O ambiente: versão do Claude Code, modelo, esforço, modo de permissão, variáveis de
   ambiente, conferência de `/context`.
5. A política de aprovação, o critério de parada com os valores dos tetos e as regras
   para interrupção externa.
6. O inventário de cobertura, item a item, com a definição de cada estado.
7. As métricas e a forma de medir cada uma, incluindo a extração de tokens da
   transcrição.
8. O número de execuções por prompt e o que se faz com execuções descartadas.
9. As regras de interpretação da §3.1.5.7.

Qualquer mudança depois do commit vira uma condição nova, com sufixo (`leigo_pu_v2`,
`eng_pu_v2`), declarada no texto ao lado da original, nunca no lugar dela. O commit de
pré-registro e o texto dos dois prompts únicos vão para o apêndice de pré-registro.

### 3.1.5.9 Decisões a confirmar com o autor (nota de trabalho, sai do texto final)

1. Opção 1 (textos literais) ou opção 2 (sem instruções de turno, com fecho comum), e
   o texto do fecho.
2. Pasta do clone isolado e momento de enviar as branches ao remoto.
3. Tetos de tempo e de tokens.
4. Regras para falha do ambiente e para limite de uso da conta, incluindo a mensagem
   literal de retomada.
5. Número de execuções por prompt único.
6. Limiar de 1 ponto e regra de "três de quatro eixos" para H1 e H2.
7. Se um teste de carga local entra como dado complementar.
8. Quando rodar: a recomendação é logo depois do pré-registro, com a versão já fixada,
   para ficar perto, no tempo, das rodadas iterativas.
9. Acrescentar ao `protocolo-de-rodada.md` a cópia da transcrição `.jsonl` e a soma de
   tokens em todas as rodadas, a começar pela `eng_00`.
