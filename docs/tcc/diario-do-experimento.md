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
