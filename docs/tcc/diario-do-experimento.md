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

Título fechado com o orientador em 23/10: "A Mesma Ideia, Dois Construtores: o que muda
em um produto de software quando quem conduz a IA entende, ou não, de engenharia e
arquitetura de software". O acréscimo de "e arquitetura" acompanha a persona do
engenheiro (engenheiro e arquiteto de software) e o fato de a comparação incluir a
arquitetura das duas soluções. Descritivo dos capítulos para o orientador gerado em
`docs/tcc/descritivo-capitulos-tcc.docx`, com o corpo planejado em 25 páginas e os
materiais no repositório.

## 2026-11-01

`eng_00`, continuação. O autor enviou a `tecnica-r1` (respostas ao plano mestre v1:
barra de navegação mantida com rankings pelo perfil e pela Busca; raridade derivada da
escassez com limiares fixos, contra a sugestão do agente; "salvar" removido e "enviar"
vira compartilhar; domínio em português e técnico em inglês; GitHub Actions; R2;
leitura pública por chave aleatória; motor declarativo; sem plano B local de rede, a
banca usa a rede móvel; termo de uso na fase 1; aceite em bloco das recomendações de
peso 8 ou mais e da ordem dos 13 passos). O agente devolveu o **plano do passo 0**
(fundação documental, seis etapas: produto.md, catálogo em três JSON, regras
declarativas das conquistas em três formas de contagem, sete famílias de trilha, oito
ADRs com índice, plano mestre, CLAUDE.md; um commit por etapa com revisão do autor
antes de cada um), três consequências das decisões (raridade vira tabela de
estatística calculada pelo worker; com 40 alunos as faixas de raridade colapsam,
recomendou 120; oito superfícies sem desenho inventariadas) e oito perguntas. O autor
respondeu na `tecnica-r2`: denominador por elegíveis; raridade não congela; 150 alunos
no seed (120 ativos, 30 ex-alunos); arroba único escolhido pelo usuário, RA nunca
exposto, busca por nome e arroba com filtros de curso e semestre; convenção de branch
e commit aceita, passo 0 na `rodada/eng_00`; um commit por etapa e um PR por assunto;
oito ADRs separados; deep link com muro de login. Autorizada a E0.1. Ainda sem código.

Mais tarde em 01/11: passo 0 em execução. E0.1 (`docs/produto.md`, 534 linhas, 13 seções,
com diagrama de estados do prêmio de participação e tabela de visibilidade por
estado) revisada pelo Cowork no repo e aprovada pelo autor com três mudanças
(`tecnica-r3`: ex-alunos entram na conta de raridade; sufixo `-EX`; aluno nunca acumula
papel) e quatro pendências do arroba fechadas; o agente aplicou e commitou (`14999e3`,
primeiro commit do agente na trilha). E0.2a (`medalhas.json`, `premios-participacao.json`)
entregue com três decisões que o agente precisou tomar e declarou; o autor trouxe a
estrutura real de avaliação da UniMax (prova, prova integrativa, presença ou trabalhos
por bimestre; substitutiva como segunda chance) e transformou a repetibilidade em
campos do catálogo com limites derivados dela (`tecnica-r4`). Export parcial da sessão
e cópia do `.jsonl` salvos em `resultados/engenheiro/` (`43b4210`). Ainda sem código
executável; só documentação e dados, como o passo 0 prevê.

Noite de 01/11: passo 0 fechado. E0.2b, E0.2c, E0.3, E0.4 e E0.5 revisadas pelo Cowork
no repo e aprovadas pelo autor (`tecnica-r5` a `r9`): 18 conquistas em duas formas de
contagem (o agente descobriu que as três previstas eram duas), oito famílias de trilha,
oito ADRs com Mermaid e índice de decisões, plano mestre com a ordem dos passos 6 a 9
corrigida pelo próprio agente (post antes de prêmio de participação), `CLAUDE.md` da
trilha. Decisões do autor ao longo da noite: raridade com ex-alunos nos dois lados;
sufixo `-EX`; aluno nunca acumula papel; repetibilidade das medalhas pela estrutura real
de avaliação; dois nomes de conquista; migration por passo; sem rodapé de co-autoria nos
commits (persona: o agente é ferramenta). Sete commits do agente na
`docs/passo-00-fundacao`, PR #1 contra a `rodada/eng_00`, as duas publicadas. Em
paralelo, o desenho da avaliação mudou (`avaliacoes/rubrica.md`, protocolo): seis eixos
(experiência do usuário, segurança, infraestrutura, documentação, código, projeto e
arquitetura), um revisor de IA por eixo, avaliação uma vez por produto no fim, autor
pontua sem ver o revisor; ordem de execução: engenheiro inteiro, leigo inteiro, prompt
único, avaliações. Sete prompts do leigo rascunhados em `prompts/leigo/` para o autor
reescrever. Título do TCC com "e arquitetura" (23/10) e descritivo dos capítulos para o
orientador em `docs/tcc/descritivo-capitulos-tcc.docx`.

02/11: `eng_01_fundacao` em andamento, sessão nova na `rodada/eng_01_fundacao` (saída da
`main` após o merge da `eng_00`). Prompt de abertura curto de propósito, para medir se o
`CLAUDE.md` sustenta a sessão sozinho: sustentou. O agente leu os docs, não escreveu
código antes do plano e perguntou só o que não estava documentado (gerenciador de
pacotes, escopo inicial do job de segurança, forma do migrador, prefixo de rotas,
medidas da moldura). Plano de oito etapas aprovado (`fundacao-r1`), branch
`chore/passo-01-esqueleto-monorepo` com um PR para a rodada. A revisão passou a ser
por export: a cada etapa o autor roda `/export` para
`resultados/engenheiro/eng_01_fundacao-sessao.txt`, o Cowork lê o fim do arquivo e
redige a resposta. Etapas 1 a 4 revisadas e aprovadas (`fundacao-r2` a `r5`): esqueleto
.NET 10 com health e ready, testes de arquitetura separados e teste de pureza do Domain;
banco com migração por subcomando `migrate`, advisory lock e `ready` checando migrations
pendentes; cliente OpenAPI gerado sob demanda com duas versões de TypeScript; app Expo
SDK 58 com tela de estado da API e moldura de celular só na web (390 px a partir de
600 px de janela, teto de 844 px). Desvios declarados pelo agente e aceitos: `ignore-exit-code`
no `Domain.Tests` até o passo 2, `MSBuildTreatWarningsAsErrors`, `JsonNumberHandling.Strict`,
Node 22 com avaliação do 24 no passo 13, proxy de `/api` no Metro só em desenvolvimento,
ícones reais no passo 4. Achados moderados do `npm audit` em ferramentas de build e teste
registrados, abaixo do corte do job de segurança. O autor instalou o SDK do .NET 10
antes de o agente continuar. Etapa 5 (`fundacao-r6`): compose com Postgres 18, migrador, duas réplicas de API e
Caddy; o agente testou resiliência além do critério (réplica parada, rodízio exato,
as duas paradas, dados sobrevivendo à recriação do Postgres). `infra/` entra no mapa
do `CLAUDE.md` na etapa 8; porta 443, HSTS e CSP ficam no passo 13. Etapa 6 (`fundacao-r7`): e2e com Playwright em quatro projetos (desktop e celular,
claro e escuro), conferindo moldura, cores dos tokens e chamada real pelo Caddy; o
agente provou que o teste falha com a API fora. Sem decisão pedida. Etapa 7 (`fundacao-r8`): CI com os seis jobs, validada no Actions antes do commit com
branches descartáveis em três cenários (verde, formato quebrado, contrato mudado sem
regerar o cliente); o agente descobriu que `dotnet list package --vulnerable` sai com 0
mesmo achando vulnerabilidade e filtrou com `jq`. Gatilho por push em qualquer branch,
sem `pull_request`, decisão do autor; execuções das branches temporárias mantidas como
registro. Etapa 8 (`fundacao-r9`): cinco diagramas de sequência em `docs/fluxos/`, cada passo
rastreado a uma regra escrita. O agente achou uma ambiguidade real no `produto.md` 4.7
(reenvio após reprovação) e não decidiu; o autor decidiu: reenvio é post novo, o
reprovado vira post comum. Recálculo de ranking em todo evento que muda pontuação
confirmado e levado ao ADR 0005. PR #2 (8 commits, CI verde) mergeado pelo autor, `rodada/eng_01_fundacao` → `main`
(`3d1e91f`). Rodada fechada em 3 h 29 min de relógio, numa noite; registro em
`resultados/engenheiro/eng_01_fundacao.md`. Achado do fechamento: o `.jsonl` mostra
que a sessão rodou em `claude-opus-5-5` com esforço `medium`, enquanto a `eng_00`
rodou em `claude-opus-5` com `high`, mesma opção no `/model`, cinco minutos de
intervalo. Decisão: esse é o ambiente fixo daqui em diante, nas duas trilhas, com
`/model` conferido antes de cada sessão; a `eng_00` fica como exceção declarada.

02/11 (noite) a 03/11: `eng_02_dados` inteira numa sessão de 4 h 21 min. `/model`
conferido antes do primeiro prompt (Opus 5.5, medium, 2.1.308). Plano de sete etapas
com nove perguntas; o agente se recusou a inventar o calendário 2026, que o autor
declarou como aproximado (a UniMAX não publica), e os cursos foram conferidos no site
(CC, ADM, MED com 12 semestres, IA). Etapas E1 a E7 revisadas por export (`dados-r2` a
`r8`): domínio acadêmico e catálogo com TDD, leitor de JSON estrito com passo na CI,
duas migrations, seeder base idempotente com versão por item, seed demo. Episódio
registrado: na E7 o autor acusou falta de um curso, o agente mostrou que a resposta
enviada do plano dizia três (o autor colou a primeira versão, sem IA) e que os docs
também, não mudou nada e ofereceu opções; o autor reconheceu e escolheu quatro cursos
com docs ajustados (`r9`). PR #3 com oito commits, CI verde, merge na `main`
(`a84a868`). Registro em `resultados/engenheiro/eng_02_dados.md`. Próxima:
`eng_03_auth`.

03/11 e 04/11: `eng_03_auth` (autenticação e autorização), a rodada mais longa, em duas
noites. O CLI apareceu na 2.1.316 apesar do `DISABLE_AUTOUPDATER=1`; modelo e esforço
iguais (Opus 5.5, medium), então a versão foi declarada a partir desta rodada. Plano de
onze etapas com onze decisões recomendadas, todas aceitas (`auth-r1`). Três interrupções
de ambiente: janela fechada sem querer (retomada com `--resume`, compactação automática
do contexto, export em duas partes), Docker Desktop parado, disco C: cheio na E9 (o
agente parou sem commitar e esperou). Etapas E1 a E11 revisadas (`r2` a `r12`): domínio
de identidade com TDD, Argon2id e JWT, cadastro com arroba, login com respostas e custo
iguais, refresh rotativo com reuso provado em corrida real, papéis e escopo de turma no
banco, recuperação de senha com Mailpit, modo de demonstração atrás de flag com purga
por lote, limite de taxa. No fechamento o agente declarou que não tinha conferido a CI
a cada push (E9 e E10 vermelhas por falso positivo do gitleaks) e corrigiu com exceção
delimitada; o autor fixou a regra da CI verde por etapa (`r13`). PR #4 com 13 commits,
450 testes, merge na `main` (`5b7cb45`). Registro em
`resultados/engenheiro/eng_03_auth.md`. Próxima: `eng_04_design`.

05/11 e 06/11: `eng_04_design` (design system), oito etapas em duas sessões de trabalho,
CLI 2.1.316 e Opus 5.5 medium conferidos antes do prompt. Dez prompts de abertura dos
passos 4 a 13 rascunhados em `prompts/engenheiro/rascunhos/`. A regra da CI verde por
etapa pegou na primeira aplicação um defeito intermitente do passo 3 (registro
simultâneo de demonstração com o mesmo nome dando 500): o agente não reexecutou a CI,
mostrou que já falhava na `main` e corrigiu em PR separado (#5) com traço do autor.
Etapas: tema persistido, fontes instanciadas por script, ícones próprios e vitrine de
desenvolvimento, controles, navegação e estados, prêmios, ícone e splash a partir do
logo vetorizado do PNG. Três aprovações visuais do autor; numa delas o autor viu os dois
X fundidos no cruzamento, defeito que a métrica do agente não mostrava, e o traçado foi
corrigido. Identificador do app `tech.gimenes.maxx`. Docker Desktop caiu de novo (uma
vez reiniciado pelo agente, com aviso). PR #6 com CI verde, merge na `main`
(`3818816`). Registro em `resultados/engenheiro/eng_04_design.md`. Próxima:
`eng_05_login`, as primeiras telas reais.

06/11 (noite): abertura da `eng_05_login`. Decisão de contexto do autor: não haverá
apresentação presencial do TCC; a avaliação acontece antes de 05/12/2026. O ensaio com a
banca previsto no passo 13 passa a ser ensaio de demonstração remota, e o risco do
calendário em recesso, apontado pelo agente no plano do passo 5, deixa de se aplicar.

07/11: `eng_05_login` fechada, as primeiras telas reais. Queda de rede de madrugada
deixou o turno preso 15 horas na etapa 1; retomado com Esc na mesma sessão. Oito
etapas: termo de uso na API (texto redigido pelo agente e aprovado pelo autor com a
seção "Demonstração"), sessão com refresh serializado entre abas, peças da autenticação,
login pela prancheta, cadastro em três passos, recuperação pelo Mailpit, entrada da
demonstração com a mensagem de `registro-simultaneo`, fechamento com o plano mestre
ajustado para a avaliação remota. Três bugs do agente pegos pelos próprios testes, um
deles com CI vermelha e fix separado. 292 Jest, 63 e2e em duas passadas. PR #7, merge
na `main` (`9115368`). Registro em `resultados/engenheiro/eng_05_login.md`. Próxima:
`eng_06_medalhas`, com dois trechos do README de decisões a ajustar na abertura.

07/11 (noite): `eng_06_medalhas` fechada em 3 h 04 min, dez etapas, a rodada mais
limpa até aqui: nenhuma falha de CI, nenhuma interrupção, todas as correções do agente
antes do commit. Abertura com o ajuste de docs da avaliação remota em todos os
documentos. Fila no Postgres e worker, e-mail na fila com token emitido no worker,
domínio e API da medalha com concorrência provada, anulação por comando, notificação e
raridade por escassez com coalescência, leitura do aluno, telas do professor e de
Troféus, navegação de cinco abas, e2e de ponta a ponta. Doze decisões no plano, todas
pela recomendação; o agente levantou e o autor acolheu o recálculo de raridade no
cadastro, fora da lista original do ADR 0005. PR #8 com onze commits verdes, merge na
`main` (`a225e29`). Registro em `resultados/engenheiro/eng_06_medalhas.md`. Próxima:
`eng_07_posts`.

08/11: pré-registro da condição de prompt único, antes de qualquer execução
(`docs/tcc/pre-registro-prompt-unico.md`). Decisões do autor: repositório próprio e
vazio por persona em vez de branch na trilha (volta o argumento de 10/10: o agente
roda `git` e veria a trilha iterativa); `eng_pu` sem pasta `design/` e sem deploy, e
`leigo_pu` com o pedido de deploy trocado por "me explica como abrir no celular", para
nenhuma persona depender de credencial; `leigo_pu` condensado ao tamanho que o leigo
escreveria; fecho comum idêntico; tetos de 12 h e 3.000.000 de tokens de saída; uma
execução por prompt; execução durante a trilha do engenheiro, entre os passos 7 e 8,
para ficar no mesmo ambiente das rodadas iterativas, desvio declarado da ordem do
protocolo. Commit de pré-registro: `4d4cc4b` (08/11/2026, 04:10 UTC).

08/11: `eng_07_posts` fechada: posts, upload e feed, a maior rodada até aqui (1,75 milhão
de tokens de saída, 12 commits, 151 arquivos). Onze etapas: bucket S3 com emulador
VersityGW (o MinIO não estava disponível), upload assinado com limite e limpeza pela
fila, post com derivadas e conferência no bucket, curtida, comentário e seguir, feed por
cursor com recomendação, perfil e busca na API, novo post, feed, perfil, busca e editar
perfil no cliente, e2e social, docs. O e2e novo achou dois defeitos reais antes do commit
(deep link e voltar); o autor achou na revisão um resíduo do passo 0 que virou tela (chips
de semestre até o 8º com Medicina em 12). Duas compactações automáticas dentro da etapa
11, com o agente passando a escrever em inglês depois da primeira, como na `eng_03_auth`;
pedido de volta ao português na `r12`. A suíte da API foi interrompida uma vez por falta
de memória na máquina; o autor pôs teto de 8 GB no WSL com devolução automática, limpou
11 contêineres mortos do Testcontainers e 5 GB de cache, e a suíte passou (752 testes).
PR #9, merge na `main` (`f28f404`). Registro em `resultados/engenheiro/eng_07_posts.md`.
Em seguida, pelo pré-registro, a condição de prompt único (`eng_pu`, depois `leigo_pu`),
com a pilha do engenheiro derrubada.

08/11 (tarde): decisão de prazo. O autor tem até 09/11 ao meio-dia para fechar os
produtos. Prioridade declarada: as duas trilhas iterativas completas; a condição de
prompt único é adição e sai da janela, rodando depois do prazo se houver tempo, o que
muda o momento fixado no pré-registro ("entre os passos 7 e 8") sem mudar os prompts;
fica declarado aqui e no pré-registro. Para caber, a trilha do leigo passa a rodar em
paralelo com os passos 8 a 13 do engenheiro, em janelas e repositórios separados, com
memória desligada; o isolamento de contexto não muda, mas a máquina passa a ser
compartilhada. Mitigação: a pilha do engenheiro sobe primeiro e ocupa as portas de
sempre, de modo que um eventual conflito de porta recaia no agente do leigo, cuja
trilha é observacional; qualquer contorno que ele fizer entra no registro da rodada e
nas ameaças à validade. A ordem do protocolo (engenheiro inteiro, depois leigo) fica
alterada por esta decisão. Passo 8 aberto às 15h58 (horário de Brasília) e abertura do
leigo colada em seguida, na mesma tarde.

