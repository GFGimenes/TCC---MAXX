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

Passo 1 da trilha do engenheiro (identidade visual) encerrado. Quatro sessões do
Claude Design em paralelo, cada uma com um propósito (modelo propõe o padrão; padrão
fixo com regra do Instagram; exploração de componentes; exploração livre em três
direções), e convergência de volta na primeira, que recebeu a paleta de uma, os
medalhões e o card de prêmio de outra, e a regra do Instagram da terceira. Registro
prompt a prompt em `docs/referencias-visuais/prompts-design.md`, com anexos
identificados e a procedência de cada um (insumo do autor ou resultado gerado em
outra sessão). Entregáveis: seis telas mais cadastro, em tema claro e escuro, e a
prancheta de padrão visual. Tempo total do autor no passo 1 a consolidar no registro.
