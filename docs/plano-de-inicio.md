# Plano de início da execução

Registro do estado em 12/09/2026 e do que a próxima sessão faz, na ordem. Serve para
retomar sem depender do histórico da conversa.

## Decisões fechadas em 12/09/2026

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

## Próxima sessão, na ordem

1. Escrever `prompts/engenheiro/eng_00_contexto.md`: projeção (3.200 / pico 2.000),
   stack A com justificativa por camada, arquitetura em camadas (rota, serviço,
   repositório), modelo de dados inicial, convenções (regra de negócio fora da rota,
   escrita com auditoria na mesma transação, entrada validada por schema, nada de
   SQL por concatenação, segredos fora do código), os seis requisitos não funcionais
   do perfil, testes (unitário, integração em container, e2e nos fluxos críticos),
   git (main deployável, commits em inglês no imperativo, CI), definição de pronto.
   Pedir plano e estrutura de pastas antes de código, e gravar as regras no
   `CLAUDE.md` da branch `engenheiro`.
2. Escrever `prompts/leigo/leigo_00_abertura.md`: uma mensagem curta (ordem de 165
   caracteres), no estilo do corpus, citando 2 ou 3 das features pelo nome de
   usuário final, sem termo técnico, sem regra de negócio, sem segurança ou teste
   (ver `personas/leigo/perfil.md`, seção "O que isso significa"). A trajetória
   simulada tem um composto típico como ponto de partida.
3. Gerar os mockups do engenheiro (login, feed, perfil, mural, troféus, ranking) a
   partir de `docs/rascunhos/` e guardar em `docs/referencias-visuais/`; o engenheiro
   os anexa nas rodadas por tela.
4. Orca: FEITO em 12/09. Projeto registrado em `Repos\tcc\Maxx`, projeto antigo
   removido, workspace coordenador novo (`coordenador-2`, branch
   `GFGimenes/coordenador-2`, nascida da `main`, já com o `CLAUDE.md`). O prompt de
   `orquestracao/coordenador.md` é colado nesse workspace a cada rodada.
5. Preparar contas para o deploy: VPS pequena e bucket S3-compatível (para a trilha do
   engenheiro); conta Expo (EAS) e uma hospedagem genérica (Vercel ou similar) para o
   que o agente da trilha leiga escolher. Dois deploys, uma URL por trilha.
6. Rodada piloto: `leigo_00_abertura` e `eng_00_contexto` pelo coordenador
   (`orquestracao/coordenador.md`). Validar o fluxo ponta a ponta: worker, review,
   checklist humano, linha na planilha, registro em `resultados/<trilha>/`, merge.
7. Depois do piloto: `eng_01_login` e `leigo_01_login`, e seguir módulo a módulo.
8. **Único repositório é o Maxx, e ele fica dentro da pasta `tcc`**
   (`Repos\tcc\Maxx`, decisão de 12/09). A pasta `tcc` é área de trabalho local (o
   `.git` dela é só histórico na máquina, sem push; `Maxx/` está no `.gitignore` da
   `tcc`). Nunca criar `CLAUDE.md` ou `AGENTS.md` na raiz da `tcc`: o Claude Code lê
   contexto das pastas ancestrais e isso vazaria para o Maxx. Workers sempre nos
   worktrees do Orca, nunca direto em `tcc\Maxx`. Depois de mover a pasta:
   re-registrar o caminho do projeto no Orca e rodar `git worktree repair` no Maxx. Durante a execução, nada do
   experimento entra no Maxx, para nenhuma trilha enxergar prompt ou review da
   outra. No fim, com as 12 rodadas rodadas, copiar prompts, resultados, reviews,
   planilha e relatórios de carga para `docs/experimento/` na `main` do Maxx, num
   commit final. Push do Maxx quando quiser (está 2 commits à frente da origin).

## Pequenos pendentes

- `docs/especificacao-telas.md` ainda aguarda os descritivos complementares por
  feature que o autor ia enviar.
- No commit final em `docs/experimento/` do Maxx, decidir se as versões em PDF do TCC
  e os PNGs de rascunho entram junto.
