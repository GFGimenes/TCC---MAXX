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
