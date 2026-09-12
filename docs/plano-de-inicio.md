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
4. Atualizar o projeto Maxx no Orca: as branches agora são `main`, `leigo` e
   `engenheiro` (as quatro antigas foram apagadas). Dar `git merge main` no workspace
   coordenador se quiser o contexto lá.
5. Preparar contas para o deploy: VPS pequena e bucket S3-compatível (para a trilha do
   engenheiro); conta Expo (EAS) e uma hospedagem genérica (Vercel ou similar) para o
   que o agente da trilha leiga escolher. Dois deploys, uma URL por trilha.
6. Rodada piloto: `leigo_00_abertura` e `eng_00_contexto` pelo coordenador
   (`orquestracao/coordenador.md`). Validar o fluxo ponta a ponta: worker, review,
   checklist humano, linha na planilha, registro em `resultados/<trilha>/`, merge.
7. Depois do piloto: `eng_01_login` e `leigo_01_login`, e seguir módulo a módulo.
8. Fazer `git push` dos dois repos quando quiser (Maxx está 2 commits à frente da
   origin; tcc tem tudo commitado, PDFs e PNGs da raiz ficaram de fora).

## Pequenos pendentes

- `docs/especificacao-telas.md` ainda aguarda os descritivos complementares por
  feature que o autor ia enviar.
- Decidir se os PDFs e PNGs da raiz do repo `tcc` entram no versionamento ou no
  `.gitignore`.
