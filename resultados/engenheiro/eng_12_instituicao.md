# Registro da rodada `eng_12_instituicao` (trilha do engenheiro)

Passo 12 do plano mestre: área web da instituição. Ficha do aluno e atos sobre a conta
(correção de e-mail, ex-aluno, troca de curso), concessão direta e anulação de prêmio,
purga da demonstração por lote, seed do mundo de demonstração (estrutura, fatos, posts
com foto), telas da área (entrada, filas, busca e ficha, novo aviso, purga), e2e e docs.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_12_instituicao` (saída da `main` em `e43a83a`); trabalho em `feat/passo-12-instituicao` |
| Sessão | `38159b62-809d-48b4-b879-988b5a3ce98a`, aberta em 09/11/2026 15:28 UTC, encerrada em 09/11/2026 21:07 UTC |
| Modelo | `claude-opus-5-5` em todas as 1.068 mensagens do agente, esforço `medium`, auto mode; `claude --version` e `/model` conferidos antes do primeiro prompt |
| Versão do CLI | 2.1.316 do início ao fim |
| Interrupções | Uma compactação automática de contexto durante a etapa 9, com retomada pelo resumo do próprio CLI, sem perda observada de estado (o agente seguiu a etapa e fechou o passo). Sem pausa do autor acima de 15 min |
| Ocorrência externa | Queda do GitHub Actions (incidente "Actions and Checks API", ~15h12 a ~15h55 de Brasília). A CI da etapa 5 falhou duas vezes sem criar jobs e passou na terceira, sem código envolvido; o agente esperou com um vigia em vez de seguir |
| Protocolo | Cadência por grupo declarada no passo 11 mantida: etapas 1 a 6 (sem tela) emendadas em sequência, cada uma com commit, push e CI verde; paradas para revisão do autor com capturas antes das etapas 7, 8, 9 e 10 |
| Prompts do autor | `eng_12_instituicao` (abertura), `eng_12_instituicao-r1` (plano) a `r6` (fechamento): 7 textos, 7 envios |
| Turnos humanos | 7 mensagens de conteúdo, `/model`, 7 `/export`, 2 notificações de tarefa em segundo plano e 1 retomada após compactação |
| Mensagens do agente | 1.068; 561 usos de ferramenta |
| Tokens (da transcrição) | saída 1.189.560; cache criado 2.002.132; cache lido 582.012.816; entrada sem cache 2.160 |
| Tempo de relógio | 5 h 39 min de ponta a ponta (09/11 12:28 a 18:07 no horário de Brasília), sem intervalo acima de 15 min |
| Commits do agente | 10, um por etapa: `52a6a7d`, `7a2c8b3`, `2346f59`, `36b38de`, `6bdfebf`, `f588e1e`, `6dd1e82`, `6eca0ec`, `b641a1d`, `8c48193`; todos com CI verde nos seis jobs, nenhum fix, sem rodapé de co-autoria |
| Commits do autor | Merge do PR #14 (`c25b988`) e `rodada/eng_12_instituicao` → `main` com `--no-ff` (`076549b`) |
| Merge | PR #14 `feat/passo-12-instituicao` → `rodada/eng_12_instituicao`; `main` em `076549b` |
| Resultado | Jest 520 (de 489); e2e 85 sem demonstração e 4 com demonstração, nos dois temas; testes de integração e de domínio novos nas etapas 1 a 3 e 8; purga por lote; seed demo com 150 alunos, 1.156 medalhas, 280 prêmios, 33 fotos com `CREDITOS.md` e ~50 posts com foto |
| Export | `eng_12_instituicao-sessao.txt` (10.949 linhas) e `eng_12_instituicao-sessao.jsonl` (5.356 linhas) |

## O que saiu

API: ficha do aluno com busca por nome, arroba, e-mail ou RA; atos da instituição sobre a
conta (correção de e-mail na linha da base, ex-aluno sem volta, troca de curso) com
registro de quem e quando; concessão direta de prêmio de participação nascendo válida com
janela de 15 dias e notificação; anulação pela área; purga da demonstração por lote com
as fotos indo para a fila de remoção; `GET /v1/instituicao/alunos/{id}/premios-participacao`
e id do curso em `GET /v1/cursos`. Seed: mundo de demonstração em três etapas (150 alunos
com conta sem senha e `criado_em` retroativo, e-mails em `al.unieduk.invalid`, 22 eventos;
medalhas, prêmios, contestação aberta e 9 avisos com as conquistas nascendo do worker,
fila de 1.482 trabalhos drenada em 66 s; posts com foto, comprovações pendentes,
seguimentos, curtidas e comentários). App: rotas `/instituicao` só no navegador e para o
papel de instituição; entrada pelo menu do perfil; filas de comprovações e contestações;
busca e ficha do aluno com folhas por ato; conceder prêmio; novo aviso para a faculdade ou
para cursos pelo formulário compartilhado com o do professor; purga com confirmação pelo
nome do lote. E2e `instituicao.spec.ts` com quatro casos; produto.md, decisões e plano
mestre atualizados.

## Perguntas do agente e respostas do autor

- Plano (`r1`): dez etapas; três achados do agente (conta só de instituição sem entrada
  no app, domínio recusando aluno do seed, lista de domínios do produto.md 2.4 nunca
  implementada); nove perguntas de produto, todas pela recomendação (área no mesmo app
  Expo em `/instituicao`, concessão direta válida com janela de 15 dias, correção de
  e-mail mantendo sessões, ex-aluno sem volta, entre outras); avisos do seed pela fábrica
  do domínio com datas passadas.
- Etapas 1 a 6 (`r2`): aprovadas; fotos em CC BY e CC BY-SA com crédito aceitas;
  comprovações pendentes movidas da etapa 5 para a 6 aceitas.
- Etapa 7 (`r3`): 14 capturas conferidas; linha "em comum" longa e foto sorteada entre
  as do curso aceitas como estão.
- Etapa 8 (`r4`): 20 capturas conferidas; dois acréscimos aditivos na API aceitos.
- Etapa 9 (`r5`): 12 capturas conferidas; formulário compartilhado com o aviso do
  professor aceito.
- Etapa 10 (`r6`): prazo de 90 s nos e2e de vários papéis e tipo `test(mobile)`
  aceitos; PR aberto com tabela de fechamento no corpo.

## Decisões do agente sem o prompt pedir (declaradas)

Contas do seed com data retroativa e notificações pelo worker; e-mails do seed em domínio
reservado `.invalid`; fila de remoção para as fotos purgadas; e2e esperando a fila drenar;
dois endpoints aditivos para a ficha; formulário do aviso compartilhado entre professor e
instituição; prazo de 90 s nos e2e de vários papéis; ambiente local recriado com o seed
demo para as capturas; capturas tiradas sem confirmar nenhum ato; push da
`rodada/eng_12_instituicao` para o remoto para o GitHub aceitar o PR, como nos passos
anteriores.

## Observações

- Primeiro passo sem nenhum fix: dez etapas, dez commits, CI verde de primeira em todos,
  descontadas as duas falhas sem jobs durante a queda do GitHub Actions.
- Três linhas de narração do agente saíram em inglês perto do fim ("Meanwhile, I'm
  drafting the PR body", "I'll wait for the CI to finish", "I'll check that it holds
  only what it should"), depois da compactação; o conteúdo entregue ao autor seguiu em
  português.
- A compactação de contexto foi a primeira da trilha do engenheiro em um passo iterativo;
  os registros, o índice de decisões e o plano mestre no repositório fizeram o papel de
  memória, e nenhuma decisão anterior foi contrariada depois dela.
- Avaliação dos agentes revisores sobre a trilha do engenheiro disparada pelo autor com
  a `main` neste ponto (`076549b`), por prazo; a dimensão Infraestrutura será reavaliada
  contra a `main` final depois do passo 13. Declarado no diário.
- Infraestrutura do passo 13 preparada pelo autor fora da sessão (VPS, DNS, R2, SMTP),
  sem nenhum valor de credencial no repositório nem no chat; repositórios `maxx-leigo`
  e `maxx-engenheiro` tornados públicos no mesmo dia.
- Pendências para o passo 13 declaradas pelo agente: lista de domínios de e-mail como
  configuração; primeiro acesso de professores e instituição do seed pelo SMTP; seed
  demo na VPS com as variáveis do R2; tempo de drenagem da fila na VPS; purga de ensaio
  pela tela.
