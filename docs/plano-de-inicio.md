# Plano de início da execução

Registro do estado em 12/09/2026 e do que a próxima sessão faz, na ordem. Serve para
retomar sem depender do histórico da conversa.

## Decisões fechadas em 12/09/2026

- Título (13/09/2026): "A Mesma Ideia, Dois Construtores: o que muda em um produto de
  software quando quem conduz a IA entende, ou não, de engenharia de software" (EN:
  "Same Idea, Two Builders: what changes in a software product when the person
  directing the AI does, or does not, understand software engineering"). Pergunta de
  pesquisa e título original no `README.md`. Alinhar com o orientador antes da
  versão final.
- Rodadas podem ter diálogo (perguntas do agente e respostas da persona), desde que
  cada mensagem humana fique registrada em `resultados/<trilha>/<id>.md`; o número
  de turnos humanos por rodada é métrica de custo. O `eng_00_contexto` deve ser
  enxuto (80 a 120 linhas): decisões e critérios de aceite, não o conteúdo que a IA
  deve produzir (modelo de dados, fluxos, estrutura de pastas viram entregáveis);
  sem "leia o CLAUDE.md" (o Claude Code já o carrega em toda sessão, nas duas
  trilhas). Depois do review humano vem `eng_00_contexto_v2` com correções.

- Experimento: duas trilhas (`leigo` e `engenheiro`), branches do repo Maxx, um único
  agente (Claude Code), um único revisor (mesmo modelo, mesmo prompt, mesma rubrica),
  review humano observacional no leigo e corretivo no engenheiro, correção só por
  prompt (`_v2`). Qualidade do prompt embutida na persona. Ver `README.md`.
- Contexto comum: `docs/contexto-comum.md`, idêntico como `CLAUDE.md` e `AGENTS.md`
  no commit inicial das duas branches. Só evolui pelos prompts de cada trilha.
- Prêmios: tier do prêmio define pontos (Bronze 1 a 30, Prata 31 a 70, Ouro 71 a 100,
  Diamante 101 a 150); aluno não tem tier, ranking é posição numérica.
- Persona do engenheiro: o autor, com os devs do corpus como corroboração
  (`personas/engenheiro/perfil.md`). Stack A: Expo + TypeScript no cliente, API
  Fastify + Zod + Drizzle + PostgreSQL, storage S3-compatível com CDN, Docker Compose
  em VPS com Caddy, Vitest + testcontainers + Playwright. Projeção: campus de 3.200,
  pico de 2.000 simultâneos. Infra do deploy mínima nas duas trilhas.
- Persona do leigo: `personas/leigo/perfil.md` (N=28). Abre com `leigo_00_abertura`
  no estilo do corpus e usa app existente (ex.: Instagram) como referência visual;
  não constrói mockup.
- Referência visual do engenheiro: mockups feitos antes (Figma ou Claude Design), a
  partir dos rascunhos em `docs/rascunhos/`.
- Ordem de execução: as duas rodadas de abertura primeiro; depois módulo a módulo
  (login, feed, troféus, perfil e ranking, mural), sem obrigação de alternar trilha
  a cada rodada.
- Validação objetiva: testes de referência (fase 7: fronteiras da pontuação por
  tier, entradas inválidas, ordenação do ranking) e teste de carga (fase 7b: k6 ou
  autocannon, 200 e 2.000 usuários virtuais, mesmos cenários nos dois deploys).
- Planilha `avaliacoes/registro-avaliacoes.xlsx` refeita: nota do revisor IA ao lado
  da nota validada, divergência calculada, resumo por trilha e por tela.
- Ajustes pendentes no texto do TCC (fase 11): seção 3.1 (Quadro 1 com quatro famílias
  e personas por modelo já não descreve o experimento) e exemplo de teste da 3.2
  (`calcularTierAluno` vira teste da pontuação do prêmio).

## Como retomar em uma sessão nova do Cowork

Conectar a pasta `tcc` (o `Maxx` está dentro dela). Primeira mensagem sugerida:

> Vamos continuar o experimento do TCC "A Mesma Ideia, Dois Construtores". Lê o
> `docs/plano-de-inicio.md` e segue a seção "Próxima sessão, na ordem" a partir do
> primeiro item não marcado como FEITO. O Orca já está configurado. A cada rodada,
> atualiza `docs/tcc/diario-do-experimento.md` e a tabela de resultados em
> `docs/tcc/capitulo-3-experimento.md`.

## Fluxo das duas trilhas (decidido em 13/09/2026)

**Engenheiro**, na ordem em que o autor trabalha de verdade:

1. Identidade visual antes de qualquer prompt: mockups das 6 telas (Claude Design ou
   Figma) a partir de `docs/rascunhos/`, salvos em `docs/referencias-visuais/`. É
   trabalho da persona fora do agente; registrar o tempo gasto como custo.
2. `eng_00_contexto`: um prompt de cerca de 50 linhas com ideia, projeção (campus de
   3.200, pico de 2.000), arquitetura em camadas, modelo de desenvolvimento (plano
   antes de código, testes, convenções, definição de pronto), infra (stack A, deploy
   mínimo) e o pedido: propor a base do projeto e discutir o que é interessante para
   ela. É uma rodada com diálogo: o agente pergunta e propõe, o engenheiro debate e
   pede opções com pesos. Tudo registrado em `resultados/engenheiro/eng_00_contexto.md`.
   Não escrever "leia o CLAUDE.md" (o Claude Code já o carrega). O rascunho longo de
   342 linhas ficou arquivado em `docs/rascunhos/eng_00_contexto_v0_longo.md` como
   referência do que a IA deve produzir, não do que o engenheiro escreve.
3. Planejamento: o resultado da rodada 2 é o plano, a arquitetura, o modelo de dados,
   a estrutura de pastas e as regras gravadas no `CLAUDE.md` da branch `engenheiro`.
   Review humano corretivo, depois `eng_00_contexto_v2` com correções e o "pode
   subir a fundação" (tooling, banco, migration inicial, CI, sem funcionalidade).
4. Desenvolvimento: `eng_01_login`, depois módulo a módulo (feed, troféus, perfil e
   ranking, mural), cada tela com regras de negócio, restrições de segurança, casos
   de borda, testes esperados e o mockup anexado.

**Leigo**, como o corpus mostra:

1. `leigo_00_abertura`: uma mensagem só, no estilo do corpus, pedindo o app de cara
   ("quero criar um aplicativo pra minha faculdade com login, mural de avisos e
   sistema de pontos, parecido com o Instagram mas sem chat e sem reels"). Sem termo
   técnico, sem regra de negócio, sem segurança ou teste. Referência visual é um app
   que já existe, nomeado, não um mockup. Se o agente perguntar, o leigo responde
   vago ("faz do jeito que ficar melhor").
2. Depois, uma rodada por tela, sempre curta, nomeando a feature pelo nome de usuário
   final ("agora quero a tela de troféus, tipo conquistas de jogo").
3. Review humano observacional: registra, não corrige. Merge do que saiu.

## Como rodar uma rodada no Orca

1. Salvar o prompt em `prompts/<trilha>/<id>.md` com o cabeçalho (ID, trilha, tela,
   data) e o texto do prompt depois da linha `---`.
2. No Orca, abrir o workspace `coordenador` do projeto `Maxx` (branch
   `GFGimenes/coordenador-2`) e colar o prompt de `orquestracao/coordenador.md`, com
   `<id>` e `<trilha>` preenchidos. O coordenador cria o worker Claude num worktree
   novo a partir da branch da trilha, espera terminar e dispara o revisor.
3. Se o worker perguntar, o coordenador avisa; responder no estilo da persona e anotar
   a pergunta e a resposta no registro da rodada.
4. Ao final, seguir o "Checklist do humano após cada rodada" de
   `orquestracao/coordenador.md`: ler o review, conferir que o worker não leu a outra
   trilha, validar notas na planilha, salvar `resultados/<trilha>/<id>.md`, mergear
   o worktree na branch da trilha (`rodada: <id>`).
5. Documentar: uma entrada em `docs/tcc/diario-do-experimento.md` e a linha da
   rodada na tabela de `docs/tcc/capitulo-3-experimento.md`.

## Próxima sessão, na ordem

1. FEITO em 27/09. Mockups do engenheiro em `docs/referencias-visuais/` (registro em `prompts-design.md`, 14 prompts; PNGs das 15 telas na pasta; exportação completa do design em `design/`, canvas 1 na versão final `1790471156-05a5`).
2. Escrever `prompts/engenheiro/eng_00_contexto.md` enxuto (cerca de 50 linhas), no
   formato do passo 2 acima. O autor escreve; o Cowork revisa contra
   `personas/engenheiro/perfil.md` e `docs/especificacao-telas.md`.
3. Escrever `prompts/leigo/leigo_00_abertura.md` (o Cowork redige a partir do corpus;
   o autor valida contra as respostas reais em `personas/leigo/corpus-respostas.md`).
4. Orca: FEITO em 12/09 (projeto em `Repos\tcc\Maxx`, workspace `coordenador-2`).
5. Contas para o deploy: VPS pequena e bucket S3-compatível (trilha do engenheiro);
   conta Expo e uma hospedagem gratuita genérica para o que o agente da trilha leiga
   escolher. Uma URL por trilha.
6. Rodada piloto: `leigo_00_abertura` e `eng_00_contexto` pelo coordenador. Validar o
   fluxo ponta a ponta (worker, review, checklist, planilha, registro, merge, diário).
7. `eng_00_contexto_v2` depois do review humano; então `eng_01_login` e
   `leigo_01_login`, e seguir módulo a módulo.
8. **Único repositório é o Maxx, dentro da pasta `tcc`** (`Repos\tcc\Maxx`). A `tcc` é
   área de trabalho local (o `.git` dela é só histórico na máquina, sem push; `Maxx/`
   está no `.gitignore` da `tcc`). Nunca criar `CLAUDE.md` ou `AGENTS.md` na raiz da
   `tcc`. Workers sempre nos worktrees do Orca, nunca direto em `tcc\Maxx`. No fim,
   com as 12 rodadas feitas, copiar prompts, resultados, reviews, planilha, relatórios
   de carga e `docs/tcc/` para `docs/experimento/` na `main` do Maxx, num commit
   final. Push do Maxx quando quiser (está 2 commits à frente da origin).

## Pequenos pendentes

- `docs/especificacao-telas.md` ainda aguarda os descritivos complementares por
  feature que o autor ia enviar.
- No commit final em `docs/experimento/` do Maxx, decidir se as versões em PDF do TCC
  e os PNGs de rascunho entram junto.
