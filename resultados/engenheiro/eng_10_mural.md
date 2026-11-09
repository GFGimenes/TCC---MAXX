# Registro da rodada `eng_10_mural` (trilha do engenheiro)

Passo 10 do plano mestre: mural de avisos e notificações. Publicação de aviso nos três
escopos, leitura do mural com ETag e registro de leitura, notificações com os nove
tipos e novidades (sininho, Mural, Troféus), aba Mural, novo aviso do professor,
sininho e tela de notificações, docs e e2e.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_10_mural` (saída da `main` em `eda626c`); trabalho em `feat/passo-10-mural` |
| Sessão | `d5b88180-0cac-4d91-8705-3b416bcd21c8`, aberta em 09/11/2026 02:15 UTC, encerrada em 09/11/2026 10:34 UTC |
| Modelo | `claude-opus-5-5` em todas as 678 mensagens do agente, esforço `medium`, auto mode; `claude --version` e `/model` conferidos antes do primeiro prompt |
| Versão do CLI | 2.1.316 do início ao fim |
| Interrupções | Nenhuma; sem compactação. Pausa do autor de 5 h 33 min entre o relatório da etapa 7 (01h50 de Brasília) e a aprovação (07h23), com a sessão aberta esperando |
| Ambiente | Em paralelo com a execução do `leigo_pu` e com o avaliador dele; a pilha do compose ficou no ar a sessão inteira, com dados das rodadas de captura no banco; `medalhas.spec` (passo 6) estourando 30 s só localmente sob a carga da suíte e2e inteira, passando sozinho e em todas as CIs; registrado pelo agente como ocorrência de ambiente para o passo 13 |
| Prompts do autor | `eng_10_mural` (abertura), `eng_10_mural-r1` (plano) a `r8` (fechamento): 9 textos, 9 envios |
| Turnos humanos | 9 mensagens de conteúdo, `/model` e 8 `/export` |
| Mensagens do agente | 678; 372 usos de ferramenta |
| Tokens (da transcrição) | saída 798.001; cache criado 1.944.048; cache lido 286.572.129; entrada sem cache 1.398 |
| Tempo de relógio | 8 h 19 min de ponta a ponta (08/11 23:15 a 09/11 07:34 no horário de Brasília); 2 h 45 min de atividade (descontada a pausa do autor) |
| Commits do agente | 7, um por etapa: `76cd841`, `b0d7e6d`, `e18a7f3`, `42f5c5d`, `f430528`, `b2bb781`, `aeb73b4`; todos com CI verde nos seis jobs na primeira tentativa, sem rodapé de co-autoria |
| Commits do autor | Merge do PR #12 (`ae1683d`) e `rodada/eng_10_mural` → `main` com `--no-ff` (`d4ac193`) |
| Merge | PR #12 `feat/passo-10-mural` → `rodada/eng_10_mural`; `main` em `d4ac193` |
| Resultado | API 1101 testes (6 do R2 ignorados); Jest 468; e2e 73 aprovados localmente com o spec novo do mural nos dois temas; três migrations (Mural, LeituraDeAviso, TrofeusVistos) |
| Export | `eng_10_mural-sessao.txt` (6.520 linhas) e `eng_10_mural-sessao.jsonl` (3.660 linhas) |

## O que saiu

Domínio `Aviso` (título de 3 a 120, texto de 1 a 2.000, foto opcional com finalidade
`aviso`, alvos em `AvisoTurma` e `AvisoCurso`), `POST /v1/avisos` com escopo conferido no
banco e trabalho `notificar-aviso-novo` idempotente com destinatários fixados na
publicação; `GET /v1/mural` por cursor com ETag e 304, aviso por id, leitura individual
(marcando a notificação na mesma transação) e "Ler todos", avisos do perfil do professor;
`GET /v1/eu/notificacoes` com resumo por tipo (nove tipos), leitura com `ate`,
`GET /v1/eu/novidades` (sininho, mural, troféus) e marcador `trofeus_visto_em`; purga com
teste; aba Mural com chips, cartão não lido aberto e lido recolhido, "Ler todos", aviso
aberto com imagem, estados vazio e de erro; "+" do professor e tela `/novo-aviso` com
chips das turmas vigentes, contadores e foto opcional; sininho no feed e no Mural, tela
`/notificacoes` com os nove textos e destinos, bolinhas das abas por novidades (foco e
60 s), Troféus marcando visto; e2e do mural e das notificações nos dois temas; docs
(produto.md 7 e 8, decisões do passo 10, plano mestre com a pendência do passo 9
resolvida e itens para os passos 12 e 13).

## Perguntas do agente e respostas do autor

- Plano: sete etapas, D1 a D7 técnicas e nove perguntas de produto, todas pela
  recomendação (`r1`): limites de título e texto; não lido aberto com bolinha e negrito,
  lido recolhido; visibilidade por vínculos com ex-aluno lendo sem ser notificado;
  aviso de curso para um ou mais cursos; marcador de Troféus separado do sininho;
  abrir o sininho marca tudo como lido; tela de notificações e "+" na lista de
  superfícies; sininho também no Mural; fora do escopo confirmado.
- Etapas 1 a 7: decisões técnicas do agente aceitas em cada relatório (`r2` a `r8`),
  com um ajuste do autor: avisos de perfil inexistente devolvem 404, por coerência com
  a grade de posts (`r3`).
- Capturas das etapas 4, 5 e 6 conferidas pelo autor contra as pranchetas: fiéis, só as
  diferenças declaradas pelo agente (sininho e bolinhas adiadas para a etapa 6, título
  em 22 pt, chips do componente do passo 4, aviso aberto e tela de novo aviso sem
  prancheta, espaço entre "+" e sininho menor pelas áreas de toque).

## Decisões do agente sem o prompt pedir (declaradas)

Quem vê recebe a notificação, instituição e autor nunca; destinatários do aviso de curso
lidos pelo curso atual na hora do worker (janela de segundos como limite conhecido);
uma migration por etapa (três no passo); `ate` na leitura do sininho contra a corrida
entre abrir e marcar; aluno novo vê a bolinha do Mural pelos avisos antigos; prêmio de
participação acende Troféus só na aprovação; ajuste de relógio no helper de teste;
"Ler todos" desativado por filtro até a etapa 6; conta professora e instituição
publicam só para turmas pelo app até o passo 12; "Remover foto" sem "Trocar foto";
texto genérico para tipo de notificação desconhecido; teste lendo o enum C# para
falhar se um tipo ficar sem texto; página da professora em contexto separado e login
com 15 s no e2e; falha local do `medalhas.spec` registrada como ocorrência de ambiente;
limite aceito da conquista aparecendo entre as medalhas no sininho.

## Observações

- Primeira rodada da trilha com CI verde na primeira tentativa em todas as etapas.
- Sonda temporária de re-render criada e apagada antes do commit, com o comentário
  "TEMPORÁRIO" no arquivo; investigação do e2e local comparada com os tempos da CI
  (12 s a 16 s) antes de concluir que a falha era do ambiente.
- A `rodada/eng_10_mural` existia só localmente; o agente publicou a branch sem
  alteração para o GitHub aceitar o PR, e declarou.
- O agente marcou como resolvida a pendência herdada do passo 9 (textos das
  notificações de conquista e bolinha de Troféus).
- Pendências herdadas: tela da instituição para aviso de faculdade e de curso, avisos
  no seed e a sugestão de semear pela própria publicação (12); p95 do mural com ETag e
  das novidades a 2.000 usuários, ocorrência local do e2e da medalha (13); push nativo
  (fase 2).
