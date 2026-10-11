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
  de turnos humanos por rodada é métrica de custo. A abertura do engenheiro são dois
  prompts na mesma sessão: `eng_00_produto` (as regras do produto, na voz dele) e
  `eng_00_tecnica` (projeção, stack, arquitetura, segurança, testes, deploy, jeito de
  trabalhar): decisões e critérios de aceite, não o conteúdo que a IA deve produzir
  (modelo de dados, fluxos, estrutura de pastas viram entregáveis). Depois do review
  humano vem `eng_00_v2` com correções.

- Experimento: duas trilhas (`leigo` e `engenheiro`), um repositório por trilha
  (`maxx-leigo`, `maxx-engenheiro`, mesma semente vazia `1577ae9`), um único agente (Claude
  Code CLI, sessão nova por rodada, sem orquestrador), um único revisor (mesmo
  modelo, mesmo prompt, mesma rubrica),
  review humano observacional no leigo e corretivo no engenheiro, correção só por
  prompt (`_v2`). Qualidade do prompt embutida na persona. Ver `README.md`.
- A ideia: `docs/contexto-comum.md`. Pitch igual nas duas trilhas, entregue pelo
  prompt de abertura de cada persona; repos nascem vazios, sem `CLAUDE.md` (decidido
  em 11/10). As regras completas ficam lá como referência do autor e base do
  `eng_00_produto`; o leigo não as recebe.
- Prêmios: tier do prêmio define pontos (Bronze 1 a 30, Prata 31 a 70, Ouro 71 a 100,
  Diamante 101 a 150); aluno não tem tier, ranking é posição numérica.
- Persona do engenheiro: o autor, com os devs do corpus como corroboração
  (`personas/engenheiro/perfil.md`). Stack C (decidida em 10/10, no lugar da A):
  API em ASP.NET Core com EF Core e PostgreSQL, cliente Expo (React Native +
  TypeScript), contrato por OpenAPI, storage S3-compatível com CDN, Docker Compose em
  VPS com Caddy, xUnit + Testcontainers na API e Vitest no cliente, monorepo
  (`.sln` na raiz, `apps/api`, `apps/mobile`, `packages/api-client`). Projeção:
  campus de 3.200, pico de 2.000 simultâneos. Infra do deploy mínima nas duas trilhas.
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

Conectar a pasta `tcc` (os repos `maxx-leigo` e `maxx-engenheiro` estão dentro dela).
Primeira mensagem sugerida:

> Vamos continuar o experimento do TCC "A Mesma Ideia, Dois Construtores". Lê o
> `docs/plano-de-inicio.md` e segue a seção "Próxima sessão, na ordem" a partir do
> primeiro item não marcado como FEITO. O fluxo de rodada está em
> `protocolo-de-rodada.md`. A cada rodada,
> atualiza `docs/tcc/diario-do-experimento.md` e a tabela de resultados em
> `docs/tcc/capitulo-3-experimento.md`.

## Fluxo das duas trilhas (decidido em 13/09/2026)

**Engenheiro**, na ordem em que o autor trabalha de verdade:

1. Identidade visual antes de qualquer prompt: mockups das 6 telas (Claude Design ou
   Figma) a partir de `docs/rascunhos/`, salvos em `docs/referencias-visuais/`. É
   trabalho da persona fora do agente; registrar o tempo gasto como custo.
2. Rodada `eng_00`, dois prompts na mesma sessão. Primeiro `eng_00_produto`: as
   regras do produto na voz do engenheiro (atores, telas, troféus e medalhas, tabela
   de tiers, aluno sem tier, progressão, login institucional ou RA, comprovação por
   foto, ex-alunos, rankings, mural, acesso de demonstração), fechando com "só
   confirme o entendimento; a parte técnica vem a seguir". Depois `eng_00_tecnica`:
   projeção (campus de 3.200, pico de 2.000), stack C, arquitetura e requisitos não
   funcionais, segurança, jeito de trabalhar, design no repo, e o pedido: propor a
   base do projeto e discutir o que é interessante para ela. É uma rodada com
   diálogo: o agente pergunta e propõe, o engenheiro debate e pede opções com pesos.
   Tudo registrado em `resultados/engenheiro/eng_00.md`. O rascunho longo de 342
   linhas ficou arquivado em `docs/rascunhos/eng_00_contexto_v0_longo.md` como
   referência do que a IA deve produzir, não do que o engenheiro escreve.
3. Planejamento: o resultado da rodada 2 é o plano, a arquitetura, o modelo de dados,
   a estrutura de pastas e as regras gravadas pelo agente como `CLAUDE.md` do repo
   `maxx-engenheiro`, a pedido do engenheiro (é a trilha dele criando o próprio
   contexto). Review humano corretivo, depois `eng_00_v2` com correções e o "pode
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
4. Política de reação pré-registrada (`personas/leigo/perfil.md`): o conhecimento de
   produto do leigo é a abertura e nada mais; ele aceita o que o agente propõe,
   reclama só do que vê quebrado ou feio, e não introduz regra nova. A abertura e os
   seis prompts de tela são escritos antes do piloto e não mudam depois de nenhum
   resultado. O que ele nunca pede vira "regra ausente" na rubrica.

## Como rodar uma rodada

O passo a passo completo, com o prompt do revisor, o checklist humano e a conferência
de contexto (`/status`, `/context`, `/memory`), está em `protocolo-de-rodada.md`. Em
resumo: prompt salvo em `prompts/<trilha>/<id>.md`; terminal na pasta do repo da
trilha, `git checkout -b rodada/<id>`; `claude` em sessão nova; colar o prompt e
dialogar no estilo da persona; `/export` da sessão para
`resultados/<trilha>/<id>-sessao.txt`; segunda sessão como revisor; review humano,
planilha e `resultados/<trilha>/<id>.md`; merge na `main` (`rodada: <id>`) e push;
diário e tabela do capítulo 3.

## Próxima sessão, na ordem

1. FEITO em 27/09. Mockups do engenheiro em `docs/referencias-visuais/` (registro em `prompts-design.md`, 14 prompts; PNGs das 15 telas na pasta; exportação completa do design em `design/`, canvas 1 na versão final `1790471156-05a5`).
2. FEITO em 11/10. `prompts/engenheiro/eng_00_produto.md` e `eng_00_tecnica.md`, no formato
   do passo 2 acima. O autor escreve; o Cowork revisa contra
   `personas/engenheiro/perfil.md`, `docs/contexto-comum.md` e
   `docs/especificacao-telas.md`. Antes, levar o pacote de design para o repo
   (`design/`, primeiro commit da branch `rodada/eng_00`).
3. Escrever `prompts/leigo/leigo_00_abertura.md` e os seis prompts de tela, todos
   antes do piloto (o Cowork redige a partir do corpus e da política de reação; o
   autor valida contra as respostas reais em `personas/leigo/corpus-respostas.md`).
   Depois de escritos, não mudam.
4. Ambiente das rodadas: FEITO em 10/10 (dois repos no lugar do Orca). Antes do
   piloto, a conferência única do `protocolo-de-rodada.md`: versão do Claude Code,
   modelo fixado, memória automática desligada, nenhum `CLAUDE.md` em lugar nenhum,
   `/context` sem arquivo de memória. Registrar modelo e versão na linha do tempo.
5. Contas para o deploy: VPS pequena e bucket S3-compatível (trilha do engenheiro);
   conta Expo e uma hospedagem gratuita genérica para o que o agente da trilha leiga
   escolher. Uma URL por trilha.
6. Rodada piloto: `leigo_00_abertura` e `eng_00` (produto e técnica), cada uma no seu repo,
   seguindo o protocolo. Validar o fluxo ponta a ponta (sessão, export, revisor,
   checklist, planilha, registro, merge, diário).
7. `eng_00_v2` depois do review humano; então `eng_01_login` e
   `leigo_01_login`, e seguir módulo a módulo.
8. **Três repositórios.** `maxx-leigo` e `maxx-engenheiro` (`Repos\tcc\maxx-leigo` e
   `Repos\tcc\maxx-engenheiro`; remotos privados `GFGimenes/maxx-leigo` e
   `GFGimenes/maxx-engenheiro`, o segundo é o antigo `Maxx` renomeado) são os repos
   das trilhas, os únicos que os agentes tocam, ambos nascidos da semente órfã de
   11/10 (só README e `.gitattributes`; commit `1577ae9` nos dois). A `tcc` é o repositório do TCC (`origin` = `GFGimenes/TCC---MAXX`,
   branch `master`, privado), caderno do autor; as duas pastas de trilha estão no
   `.gitignore` dela e nunca entram nela. O Cowork commita na `tcc` a cada sessão; o
   push é do autor (a ponte não tem credencial do GitHub). Versões em PDF do TCC em
   `docs/tcc/versoes/`. Nunca criar `CLAUDE.md` ou `AGENTS.md` na raiz da `tcc` nem
   em pasta acima dos repos. Sem Orca: o fluxo é o do `protocolo-de-rodada.md`. No
   fim, com as 12 rodadas feitas, prompts, resultados, reviews, planilha, relatórios de
   carga e `docs/tcc/` já estão na `tcc`; os repos das trilhas ficam como estão.

## Pequenos pendentes

- `docs/especificacao-telas.md` ainda aguarda os descritivos complementares por
  feature que o autor ia enviar.
- Decidir, ao final, se os repos das trilhas recebem um `docs/experimento/` apontando
  para a `tcc`, ou se ficam só com o código.
