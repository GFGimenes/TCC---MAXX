# Diário do experimento

Registro cronológico, uma entrada por sessão de trabalho ou por rodada. É a fonte para
a seção de metodologia (o que foi feito, quando, por quê) e para a discussão de custo
(tempo, iterações, turnos). Escrever em português, sem travessões, modelos de IA
referidos pelo nome da empresa (Anthropic), não por versão.

Formato de cada entrada: data, o que foi feito, decisões tomadas, tempo gasto quando
houver, observações que possam virar achado.

## 2026-09-12

Arrumação da casa antes da execução. Desenho do experimento simplificado de 4 trilhas
(2 personas x 2 agentes) para 2 trilhas (leigo e engenheiro), um único agente
(Claude Code, da Anthropic) e um único revisor. A dimensão "prompt bom x ruim" passou a
estar embutida na persona. Contexto comum (`CLAUDE.md`) escrito de forma enxuta, só a
ideia do produto e as regras de prêmios e pontos, e gravado como semente idêntica das
branches `leigo` e `engenheiro` do repo Maxx. Persona do engenheiro escrita a partir do
próprio autor (projetos reais de 2026 e currículo), com os desenvolvedores do corpus do
formulário como corroboração. Decisões: faixas de pontos por tier do prêmio (Bronze 1 a
30, Prata 31 a 70, Ouro 71 a 100, Diamante 101 a 150), aluno sem tier; stack A do
engenheiro (Expo e TypeScript no cliente, API Fastify, Zod, Drizzle e PostgreSQL,
storage S3-compatível, Docker Compose em VPS); projeção de campus de 3.200 alunos com
pico de 2.000; teste de carga como validação objetiva (fase 7b). Repo Maxx movido para
dentro da pasta `tcc`; Orca reconfigurado (projeto novo, workspace coordenador novo).

## 2026-09-13

Título novo decidido: "A Mesma Ideia, Dois Construtores: o que muda em um produto de
software quando quem conduz a IA entende, ou não, de engenharia de software", a
alinhar com o orientador. Pesquisa sobre a orientação da Anthropic para prompts
(menor conjunto de tokens de alto sinal, contexto carregado automaticamente,
explorar, planejar e só então codificar). Consequências no desenho: rodadas podem ter
diálogo, registrado turno a turno; o prompt de contexto do engenheiro deve ser curto
(cerca de 50 linhas) e pedir a base do projeto em vez de descrevê-la; um rascunho
longo de 342 linhas foi arquivado em `docs/rascunhos/`. Fluxo do engenheiro fixado em
quatro passos (identidade visual, prompt de contexto com discussão, planejamento,
desenvolvimento) e do leigo em pedido direto seguido de uma rodada por tela.

## 2026-09-26

Início do passo 1 da trilha do engenheiro (identidade visual). Documentos principais
copiados para o projeto "tcc" do claude.ai. Criado o registro de prompts de design
com bloco de consistência. Duas regras de produto decididas antes de qualquer rodada
(portanto ainda dentro da regra de contexto comum imutável): login somente por
e-mail institucional ou RA, sem login social; e progressão de prêmios (a mesma
conquista repetida rende um novo prêmio de tier acima do anterior). As duas entraram
em `docs/contexto-comum.md`, no `CLAUDE.md`/`AGENTS.md` da `main` do Maxx e nas
branches `leigo` e `engenheiro`, ainda no mesmo commit. Revisão do primeiro prompt de
design contra a documentação oficial do Claude Design (objetivo, layout, conteúdo,
público; identidade anexada; uma tela por mensagem).

## 2026-09-27

Passo 1 da trilha do engenheiro (identidade visual) encerrado. Três sessões do
Claude Design em paralelo, cada uma com um propósito (modelo propõe o padrão; padrão
fixo com regra do Instagram; exploração livre em três direções), e convergência de
volta na primeira, que recebeu a paleta e os medalhões da terceira e a regra do
Instagram da segunda. Doze prompts no total, recuperados das próprias sessões e
registrados como enviados. Tempo: cerca de 6 horas nas sessões (26 e 27/09) mais 3 a
4 horas de rascunhos manuais em agosto. Registro
prompt a prompt em `docs/referencias-visuais/prompts-design.md`, com anexos
identificados e a procedência de cada um (insumo do autor ou resultado gerado em
outra sessão). Entregáveis: seis telas mais cadastro, em tema claro e escuro, e a
prancheta de padrão visual, como PNG em `docs/referencias-visuais/`; e a exportação
completa das três sessões em `docs/referencias-visuais/design/` (código-fonte das
pranchetas, `canvas.json`, `tokens.json` e README do design system, componentes,
fontes e imagens), feita pelo Cowork a partir dos arquivos publicados de cada
artifact, com README de procedência. Os PNGs foram renderizados das pranchetas do
canvas 1 com Chromium, e não exportados pela interface do Claude Design.

Reabertura no mesmo dia. Revisando os PNGs, o autor notou que o botão do Mural,
elevado com sombra e anel em todas as telas (item 1 do D1.5, pedido por ele), lia
como item selecionado mesmo com outra tela aberta. Dois prompts a mais no canvas 1,
rascunhados no Cowork: D1.7 (tirar o botão elevado; regra única de estado ativo para
as cinco abas) e D1.8 (realce arredondado atrás do ícone ativo, como no Instagram,
a partir de dois prints do celular). Resultado aceito sem novo ajuste. Passo 1
fechado com 14 prompts; `design/canvas-1/` e os PNGs reexportados; registro, §3.1.4
e este diário atualizados.

## 2026-10-10

Ambiente das rodadas refeito antes do primeiro prompt. Duas mudanças, as duas por
isolamento e fidelidade.

Primeira: as trilhas deixam de ser branches do mesmo repositório e passam a ser dois
repositórios, `maxx-leigo` e `maxx-engenheiro` (o antigo `Maxx` renomeado), nascidos
do mesmo commit `e32107d`, com o mesmo hash nos dois. O motivo: o agente executa `git`
livremente, e num worktree da branch `leigo` um `git branch -a` ou `git show
engenheiro:arquivo` entregaria o material da outra trilha; o nome da branch sozinho já
seria informação. Com dois repositórios não há o que vazar. A pasta `tcc`, que ganhou
remoto privado em 27/09 (`GFGimenes/TCC---MAXX`), passa a ser o repositório do TCC;
os dois repos de trilha ficam fora dela pelo `.gitignore`. Três repositórios, não
quatro: o `Maxx` virou um dos dois.

Segunda: o Orca sai. Com dois repositórios e um experimento sequencial de uma pessoa,
o que ele resolvia (worktree por rodada, worker e revisor disparados por um
coordenador) se resolve com git e duas sessões do Claude Code. E o coordenador era
mais um agente, com prompt escrito pelo autor, entre a persona e o worker; para a
trilha do leigo isso é irreal, e para as duas é um confundidor. Sem ele, quem fala
com o agente é a persona, direto, e o que entra no experimento é só o prompt dela
mais o `CLAUDE.md`. O fluxo novo está em `protocolo-de-rodada.md`; os arquivos do
Orca foram arquivados em `docs/rascunhos/` como registro da decisão.

Ficou decidido também que a interface é a CLI do Claude Code nas duas trilhas, com o
mesmo modelo e a mesma versão (a registrar na linha do tempo na primeira sessão), e
que antes do piloto se confere, pela documentação do Claude Code: memória automática
desligada (`CLAUDE_CODE_DISABLE_AUTO_MEMORY=1`), nenhum `CLAUDE.md` global ou em
pasta acima dos repos, e `/context` mostrando só o `CLAUDE.md` do repo. Sessões
exportadas com `/export` por rodada, porque as transcrições automáticas expiram em 30
dias.

Stack do engenheiro trocada antes do primeiro prompt: de A (Expo + Fastify, Zod,
Drizzle) para C (Expo + ASP.NET Core, EF Core, PostgreSQL, monorepo com contrato
OpenAPI). A opção A tinha sido sugestão do Cowork aceita pelo autor em 12/09; a C é o
que o autor escolheria sozinho, e é a stack em que o review corretivo dele é mais
afiado, o que é parte do que se mede. O cliente é Expo (app de loja é requisito do
produto), mas o acesso principal da primeira fase é a versão web do mesmo código: na
apresentação a banca entra por QR code no navegador, e o nativo fica pronto para
build sem ir às lojas. Cogitou-se React web puro (PWA); descartado porque o Expo dá
web e nativo do mesmo projeto. Registro completo em `personas/engenheiro/perfil.md`.

## 2026-10-11

Mudança de desenho, decidida em debate com o Cowork ao revisar o rascunho do
`eng_00`: **os repositórios passam a nascer vazios**, sem `CLAUDE.md`. Até aqui as
duas trilhas recebiam o mesmo contexto com as regras completas do produto; isso
entregava ao leigo uma especificação que ele nunca escreveria, e o experimento media
só técnica de prompt. Agora a ideia é o pitch de corredor (igual nas duas) e chega ao
agente pelo prompt de abertura de cada persona. O engenheiro faz três definições antes
do código (design, produto no `eng_00_produto`, técnica no `eng_00_tecnica`, dois
prompts na mesma sessão); o leigo entrega o pitch e segue uma política de reação
pré-registrada (aceita o que o agente propõe, reclama só do que vê quebrado ou feio,
não introduz regra nova), com abertura e prompts de tela escritos antes do piloto. O
trabalho de definição não desaparece: ou a pessoa faz antes, ou o agente faz por ela,
e isso passa a ser medido (tabela de custo de entrada e decisões do agente por
trilha). A rubrica ganha o estado "regra ausente". A tese fica escopada: não afirma
que o engenheiro tem ideias melhores, afirma que a disciplina de engenharia de
software muda o que é construído a partir da mesma ideia; o autor único é a força do
desenho (mesma pessoa, mesma ideia, só o conhecimento aplicado muda), com a política
de reação como controle do que ele não consegue não saber. Semente órfã nos dois repos
(README e `.gitattributes`), porque o `CLAUDE.md` ficaria no histórico. Decidido
também que o Cowork revisa os prompts do autor sem reescrevê-los no próprio estilo; o
exemplo do `eng_00` montado a partir do texto do autor fica registrado como tal.

Fechados os dois prompts de abertura do engenheiro, em `prompts/engenheiro/`:
`eng_00_produto` (a ideia em termos de produto: papéis, login, tipos de prêmio e
tiers, progressão, comprovação e revogação, as quatro visões de ranking, as seis telas,
o modo de demonstração para a banca e o aviso de que o design já existe; termina
pedindo só confirmação de entendimento, sem código nem proposta técnica) e
`eng_00_tecnica` (cenário de carga, stack C com web via QR code, arquitetura,
cache em camadas, fila no Postgres, autenticação e autorização, segurança, demo,
método de trabalho, testes, git, definição de pronto, `CLAUDE.md` a ser escrito pelo
agente, onde está o design; entregável da rodada é o plano mestre, sem código). Texto
do autor; o Cowork revisou, apontou três correções (linha de cache duplicada, "nada
de código" ausente no fecho, erros de digitação) e sugeriu um parágrafo de segurança
(hash de senha, validação antes de assinar upload, flag da demo desligada por padrão,
auditoria de concessões, reuso de refresh token, HSTS e CSP no Caddy, varredura de
dependências e segredos na CI), aceito na íntegra. Os dois vão na mesma sessão, em
sequência, amanhã, junto com a abertura do leigo.

Ajuste no `eng_00_produto` ao reler: contestação de prêmio deixa de ser revogação
direta e vira averiguação pela instituição (professor das turmas do aluno ou a
instituição contesta com motivo; o prêmio fica "em averiguação", visível ao aluno, e
deixa de pontuar; a instituição confirma ou revoga, com histórico).

Abertura do leigo fechada em `prompts/leigo/leigo_00_abertura.md`: texto do autor,
escrito de uma vez, no registro do corpus ("Oi chat", app existente como referência,
features pelo nome, nenhuma regra, nenhum termo técnico); o Cowork apontou três
ausências em relação ao pitch (nome Maxx, ranking por curso, professores como
usuários) e o autor reescreveu. Tamanho e justificativa registrados no cabeçalho do
arquivo, com as frases de reação para usar na sessão. Piloto das duas aberturas
marcado para 12/10.

## 2026-10-12 e 2026-10-22

Rodada `eng_00` em andamento, sessão retomada com `claude --resume` depois de um
reinício do computador em 11/10. Em 12/10 o autor enviou a `r1` (respostas aos 8
bloqueadores, lacunas e contradições; `prompts/engenheiro/eng_00_produto-r1.md`). O
agente devolveu o modelo revisado como entendeu (tabela dos três tipos de prêmio, ciclo
do prêmio de participação, calendário, superfícies, social) e **20 decisões que ainda
faltam, cada uma com sugestão**, mais quatro inconsistências nos exemplos do autor
(valor da medalha de nota 10 dado como 30 no catálogo e 10 na conta da conquista;
"Diamante baixo" não existe como sub-tier; recuperação de senha por e-mail sem
verificação de e-mail; medalha por presença automática na fase 2 se confundiria com
conquista). Continuou sem código e sem proposta técnica, como pedido, e disse que não
propõe estrutura antes de ler o design e de ter o catálogo canônico de prêmios. Em
22/10, ao retomar, o CLI tinha se atualizado sozinho para 2.1.308 (ver linha do tempo).

## 2026-10-23

`eng_00`, continuação. O autor enviou a `r2` (`prompts/engenheiro/eng_00_produto-r2.md`: 14
sugestões do agente aceitas, 6 decisões próprias, quatro inconsistências resolvidas,
catálogo delegado ao agente). O agente devolveu as decisões fechadas em um parágrafo,
um **catálogo proposto** com três princípios declarados (fato isolado é Bronze, acúmulo
é Prata ou acima; conquista de período é repetível por instância; topo da faixa
reservado ao item mais pesado) e 48 itens (14 medalhas, 16 prêmios de participação, 18
conquistas, com tier, valor, período e gatilho), conferiu o exemplo do autor (3 × M01 +
C02 = 130) e reclassificou "três palestras no semestre" de prêmio para conquista. Expôs
**oito decisões novas**: medalhas discricionárias (contradizem "medalha é fato
registrado"), medalha acima de Bronze no fechamento de matéria, evento com duração,
conquista não conta conquista, congelamento do ranking semestral 30 dias após o fim,
desequilíbrio estrutural dos rankings a assumir de propósito, dedupe de evento em texto
livre, conteúdo do perfil do professor. O autor respondeu na `r3` (três decisões
próprias, cinco aceites); o agente congelou o catálogo (11 medalhas, 17 prêmios, 18
conquistas) e deixou dois pontos, fechados na `r4` (M13 cai; dedupe por item + data +
matéria para apresentação em sala). Continua sem código e sem proposta técnica, como
pedido. Primeiras trocas na versão 2.1.308 do CLI. Em paralelo, o autor decidiu
acrescentar ao desenho a condição "prompt único" (um prompt por persona, sem turnos
humanos depois) e pediu a estrutura de capítulos do TCC num chat separado do projeto.

Mais tarde em 23/10: `r4` enviada (a `r4` colada sem a técnica junto; o agente registrou o
catálogo congelado e, em vez de sair lendo o repositório, pediu o caminho do design e
disse que não "fuçaria" antes de o autor apontar o que é canônico). Em seguida o
`eng_00_tecnica` foi enviado inteiro. O agente leu `design/tokens.json` e
`design/identidade-visual.md`, listou `design/telas/` sem abrir as telas (como pedido)
e devolveu a primeira versão do **plano mestre**, sem código: (1) oito contradições
entre o design e o produto (raridade existe no design e não no produto; a trilha de
progressão com cadeado desenha a regra substituída; a navegação tem aba Busca nunca
especificada e Rankings sem aba; "enviar" e "salvar" no post sem DM nem coleção;
sininho ausente da identidade; "editar perfil" e foto de perfil nunca entraram no
produto; glifos batem com o vocabulário); (2) quatro contraindicações da stack (fonte
variável Archivo 112% não funciona no nativo, instanciar estática; bundle web do RN a
medir; miniaturas ninguém gera; bucket privado com CDN pública é contradição parcial,
com LGPD) e versões (.NET 10 LTS, OpenAPI nativo); (3) quinze decisões técnicas com
opções e pesos (origem única, R2, leitura pública por ULID, derivadas no cliente,
motor declarativo de conquistas, snapshot de pontos, ranking por worker com
coalescência, auth própria com Argon2id e família de refresh, openapi-typescript +
TanStack, Jest/Playwright/Maestro, quatro projetos, migrations em contêiner com
advisory lock, seed no cursor para recomendação aleatória, catálogo em JSON com seeder
idempotente, domínio em português e técnico em inglês); (4) modelo de dados inicial
com índices únicos que carregam regra; (5) seed base e demo; (6) pipeline com seis jobs
e definição de pronto com p95 medido; (7) quatro riscos (rede do campus na banca,
pico de aprovação, LGPD e termo de uso, backup); (8) plano mestre de 13 passos; (9)
seis bloqueantes e oito itens importantes para o autor antes do plano do passo 0. Tempo
do agente na resposta: alguns minutos; leitura humana e decisões ficam para a `r5`.

