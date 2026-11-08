# Registro da rodada `eng_07_posts` (trilha do engenheiro)

Passo 7 do plano mestre: posts, upload e feed. Primeiro conteúdo gerado pelo aluno,
primeiro bucket compatível com S3 e as telas sociais do produto (feed, post, perfil,
busca e editar perfil).

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_07_posts` (saída da `main` em `a225e29`); trabalho em `feat/passo-07-posts` |
| Sessão | `db2e3dff-90c5-43a0-a9fa-f91217b12056`, aberta em 08/11/2026 00:19 UTC, encerrada em 08/11/2026 18:46 UTC |
| Modelo | `claude-opus-5-5` em todas as 1.253 mensagens do agente, esforço `medium`, auto mode; `claude --version` e `/model` conferidos antes do primeiro prompt |
| Versão do CLI | 2.1.316 do início ao fim |
| Interrupções | Duas compactações automáticas de contexto dentro da etapa 11 (04:29 UTC, de 967.869 para 23.432 tokens; 05:48 UTC, de 218.284 para 17.672), sem ação do autor; depois da primeira o agente passou a escrever em inglês até o autor pedir a volta ao português na `r12`. Uma compactação ociosa no fim. A suíte completa da API foi interrompida pelo próprio Claude Code por falta de memória na máquina (06:00 UTC); o agente não a reiniciou e esperou o autor. Pausa do autor de 06:12 a 18:32 UTC entre o relatório da etapa 11 e a resposta |
| Ambiente | Antes da `r12`, o autor ajustou o WSL (`.wslconfig`: teto de 8 GB, `autoMemoryReclaim=gradual`), removeu 11 contêineres mortos do Testcontainers e 5 GB de cache de build, e reiniciou o Docker; a pilha `maxx-*` voltou sozinha e o agente a deixou de pé. Declarado ao agente na `r12`. A suíte da API passou na segunda execução (752 testes) |
| Prompts do autor | `eng_07_posts` (abertura), `eng_07_posts-r1` (plano) a `r12` (etapa 11 e PR): 13 textos, 13 envios |
| Turnos humanos | 13 mensagens de conteúdo, mais `/model` e 12 `/export` |
| Mensagens do agente | 1.253 (inclui uso de ferramenta); 607 usos de ferramenta |
| Tokens (da transcrição) | saída 1.753.881; cache criado 2.833.053; cache lido 617.521.944; entrada sem cache 2.586 |
| Tempo de relógio | 18 h 27 min de ponta a ponta (07/11 21:19 a 08/11 15:46 no horário de Brasília); 4 h 52 min de atividade (soma dos intervalos menores que 20 min), o restante pausas do autor |
| Commits do agente | 12: `7c9f29f`, `9929c99`, `8097034`, `686847a`, `76ab6b4`, `7940ae5`, `35d1a2a`, `ed78c95`, `72ba60e`, `e46f52d`, `2444f00` (fix separado) e `e541946`, todos com CI verde nos seis jobs, sem rodapé de co-autoria; o fix teve a CI numa branch temporária apagada depois |
| Commits do autor | Merge do PR #9 (`4aa5470`) e `rodada/eng_07_posts` → `main` com `--no-ff` (`f28f404`) |
| Merge | PR #9 `feat/passo-07-posts` → `rodada/eng_07_posts`, 12 commits verdes; `main` em `f28f404` |
| Resultado | API 752 testes (746 aprovados, 6 da verificação do R2 ignorados sem a flag); Jest 387; e2e 65 mais 1 ignorado na passada normal e 4 na passada da demonstração; quatro migrations (UploadPendente, Post, Social, Perfil); 151 arquivos, 22.579 linhas acrescentadas |
| Export | `eng_07_posts-sessao.txt` (14.166 linhas) e `eng_07_posts-sessao.jsonl` (6.037 linhas) |

## O que saiu

Bucket compatível com S3 (R2 em produção, emulador VersityGW no local, porque a imagem do
MinIO não estava disponível), URL assinada com tipo e tamanho presos, chave aleatória,
limite de 30 pedidos por hora, limpeza do upload abandonado em 24 h pela fila; post com
duas derivadas JPEG geradas no app sem EXIF e conferidas no bucket antes da confirmação,
remoção física pelo autor e lógica pela instituição, curtida, comentário e seguir com as
regras do banco; feed por cursor com seguidos e recomendações 3:1 por semente; perfil
próprio e de outro, grade, contadores, anel dourado, menu com tema; busca por nome ou
arroba com `unaccent` e `pg_trgm`, chips de curso e de semestre pela duração do curso;
editar perfil (foto, nome, prefixo do arroba com disponibilidade); foto opcional no
registro da demonstração; deep link do post atrás do login; e2e social de ponta a ponta;
docs do passo, plano mestre e fluxo 02 alinhados ao construído.

## Perguntas do agente e respostas do autor

- Plano: onze etapas e decisões D1 a D14 (`r1`); D1 trocada do MinIO para o VersityGW
  pelo menu interativo do agente na etapa 1; D13 (posts semeados) adiada para o passo 12
  porque o seed de demonstração não tem contas de aluno; D14 (fotos do lote na purga)
  também para o passo 12.
- Etapas 1 a 9: ressalvas registradas sem decisão nova de produto (`r2` a `r10`); o
  autor conferiu a prancheta nas capturas do feed e do perfil.
- Etapa 10 (`r11`): correção pedida antes do commit, os chips de semestre iam do 1º ao
  8º e Medicina tem 12; o agente achou que a API tinha o mesmo teto (`[Range(1, 8)]`) e
  alinhou as duas pontas pela duração do curso; `produto.md` ajustado.
- Etapa 11 (`r12`): volta ao português, suíte da API do começo e dois commits (fix dos
  dois defeitos achados pelo e2e, depois docs e e2e).

## Decisões do agente sem o prompt pedir (declaradas)

Troca do MinIO pelo VersityGW (menu); retorno do login restrito a `/post/:id`; arroba
sob o nome no perfil; perfil de outro fora das abas com voltar; `test.slow()` como
paliativo declarado, depois removido com a causa achada (`docker compose run seeder`
reiniciava o migrator; passou a `exec` no worker); `(app)` vira Stack sem cabeçalho para
as abas não desmontarem; `router.replace("/")` vira `dismissTo("/")`; verificação manual
do R2 atrás de flag; foto da demonstração de melhor esforço; branch temporária para a CI
do fix; push da `rodada/eng_07_posts` como base do PR; pilha deixada de pé depois do
reinício do Docker.

## Observações

- Dois defeitos reais achados pelo e2e novo antes do commit (deep link e voltar), e um
  resíduo documental do passo 0 (semestre 1º ao 8º) achado pelo autor na revisão e que já
  tinha virado tela e validação na API. Nenhuma falha de CI; todas as correções antes do
  commit.
- Primeira rodada com compactação automática dentro de uma etapa; a mudança de idioma
  depois dela repete o padrão da `eng_03_auth`. Registrado como ocorrência de ambiente.
- Pendências para passos futuros: D13 e D14 (passo 12); k6 da recomendação e dos índices,
  CSP da CDN e do R2, verificação do R2 real, `CREATE EXTENSION` na VPS, PUT da foto no
  Android pelo Maestro (passo 13); atalhos de ranking na Busca (passo 11).
