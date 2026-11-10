# Registro da rodada `eng_13_endurecimento` (trilha do engenheiro)

Passo 13 do plano mestre, o último: endurecimento, deploy e ensaio. Compose de produção e
imagens no GHCR, primeiro deploy na VPS com seed de demonstração no R2 e e-mail de produção,
domínios de e-mail aceitos, CSP e cabeçalhos, saúde do worker, Trivy e revisão do npm audit,
backup com restauração testada, carga reduzida com planos, ensaio remoto com purga pela tela
e registro do passo.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_13_endurecimento` (saída da `main` em `076549b`); trabalho em `chore/passo-13-endurecimento` |
| Sessão | `e8cae222-afea-4a0d-99d3-64ff0935d6dd`, aberta em 09/11/2026 21:12 UTC, parada em 10/11 02:33 UTC numa pergunta do agente; continuada em `22b8c6a1-19b3-4453-ad85-f89f79f11d3d` (via `claude --continue`, que copia o histórico) de 10/11 16:50 UTC a 19:18 UTC |
| Modelo | `claude-opus-5-5` em todas as 943 mensagens do agente, esforço `medium`, auto mode; `claude --version` e `/model` conferidos antes do primeiro prompt |
| Versão do CLI | 2.1.316 do início ao fim |
| Interrupções | Pausa noturna de 13 h 56 min com a sessão parada numa pergunta (etapa 6, opções para o Trivy), retomada no dia seguinte sem compactação; `ECONNRESET` às 21h40 de 09/11 durante troca de rede do autor, recuperado sozinho; etapa 6 interrompida pelo Claude Code por falta de memória na máquina do autor (pilha local do compose mais `npm ci` em contêiner); vigia de CI encerrado com código -1 uma vez; `pkill` do agente derrubou a própria sessão de comando ao encerrar a gravação do ensaio, deploy refeito |
| Ambiente | Primeiro passo com o produto fora da máquina do autor: VPS Hetzner (2 vCPU, 3,7 GiB), domínio `app.maxx-unimax.com`, R2 com CDN em `fotos.maxx-unimax.com`, SMTP do Brevo, Email Routing da Cloudflare para os e-mails de professor e instituição do seed. Valores de credencial só no `/opt/maxx/.env`, escrito pelo autor; o agente recebeu e conferiu só nomes |
| Alteração de protocolo | Nenhuma nova. Cadência por grupo mantida, com paradas declaradas na `r1`: lista de variáveis antes do deploy, roteiro do ensaio e CI vermelha depois de fix. Cortes por prazo declarados na `r1` (papel de banco com menos privilégio, carga a 2.000 usuários em servidor separado, bucket de backup próprio) e registrados como pendência fora da fase 1 |
| Prompts do autor | `eng_13_endurecimento` (abertura), `-r1` (plano) a `-r8` (fechamento): 9 textos; mais 4 mensagens curtas do autor (endpoint corrigido, comandos em segundo plano, relato do ensaio, purga) |
| Turnos humanos | 13 mensagens de conteúdo, `/model`, 10 `/export`, notificações de tarefa em segundo plano |
| Mensagens do agente | 943; 428 usos de ferramenta |
| Tokens (da transcrição) | saída 780.196; cache criado 1.694.897; cache lido 332.241.779; entrada sem cache 1.961 |
| Tempo de relógio | 22 h 06 min de ponta a ponta (09/11 18:12 a 10/11 16:18 no horário de Brasília); 6 h 27 min de atividade (descontados os intervalos acima de 15 min: 18 min, 1 h 01 min, a noite e 23 min durante o ensaio do autor) |
| Commits do agente | 18 na branch: `778a587`, `f828d9c`, `c1f2b77` (etapa 1 e dois fix), `cf65243`, `925e16a` (etapa 2 e fix do R2), `7694b94` (3), `fd16c39`, `3c9d2cf` (4), `cec612a`, `711ff11`, `58f0666`, `8a9a0c4` (6 e três fix), `789313a`, `4467680` (7 e fix), `490ffa9` (8), `060f0b4` (fix do ensaio), `4e42d75` (10), `ade3f81` (CLAUDE.md); todos com CI verde ao fim, sem rodapé de co-autoria |
| Commits do autor | Merge do PR #15 (`51802f1`) e `rodada/eng_13_endurecimento` → `main` com `--no-ff` (`8910b51`) |
| Merge | PR #15 `chore/passo-13-endurecimento` → `rodada/eng_13_endurecimento`; `main` em `8910b51`, final da trilha |
| Resultado | Produto no ar em `https://app.maxx-unimax.com` (`sha-060f0b4`), demonstração ligada com o lote `banca-2026`; API 1.275 testes; app 523; e2e com `instituicao.spec` e cabeçalhos; carga 9.488 pedidos sem falha, p95 43 ms |
| Export | `eng_13_endurecimento-sessao.txt` (6.350 linhas), `eng_13_endurecimento-sessao.jsonl` (sessão de 09/11) e `eng_13_endurecimento-sessao-parte2.jsonl` (continuação, com o histórico completo; as métricas acima vêm dela, sem dupla contagem) |

## O que saiu

Etapa 1: `docker-compose.producao.yml` sem build, Mailpit nem emulador, Caddy em 80 e 443
com volumes de certificado, log com teto; `.env.producao.example` só com nomes; job
`publicar` com `latest` na `main` e `sha-<curto>` por disparo manual; imagens
`maxx-engenheiro-api` e `maxx-engenheiro-caddy` públicas no GHCR. Etapa 2: e-mails de
professor e instituição em `@maxx-unimax.com`, `docs/operacao.md`, primeiro deploy, seed demo
na VPS (150 alunos, 1.178 medalhas, 975 trabalhos drenados em 21 s, 412 linhas de ranking),
fotos pela CDN, e-mail da coordenação pelo Brevo. Etapa 3: lista de domínios aceitos como
configuração da API, na rota de cadastro e na correção pela instituição, com código
`dominio-nao-aceito` e textos no app. Etapa 4: CSP, HSTS e cabeçalhos no Caddy, também no
compose local e na CI, e2e conferindo. Etapa 5: batimento do worker em tabela, `GET
/api/health/worker` com 503 em três casos, conferido na VPS com o worker parado e religado.
Etapa 6: Trivy nas duas imagens, apt da imagem da API atualizado, exceção com prazo para a
CVE do Caddy, Node 24 avaliado e rejeitado, npm audit revisado sem mudança. Etapa 7:
`infra/backup/` com dump, rotação de 14 dias, timer às 03:00 e restauração testada em 46
tabelas; `infra/deploy.sh` com dump antes do migrator. Etapa 8: `carga/leitura.js` e
planos. Etapa 9: `docs/ensaio.md`, ensaio executado e purga pela tela. Etapa 10: índice de
decisões, plano mestre com pendências fora da fase 1, roteiros com a limpeza do cache da
CDN, `CLAUDE.md`.

## Perguntas do agente e respostas do autor

- Plano (`r1`): 11 etapas com o deploy na sétima e dez perguntas. Autor subiu o deploy
  para a segunda etapa e respondeu: e-mails do seed em `maxx-unimax.com` com Email
  Routing; textos aprovados; sem bucket de backup (disco da VPS com rotação, bucket como
  pendência); UptimeRobot pelo autor; `workflow_dispatch` com `sha-<curto>` e pacote
  público; sem papel `maxx_app`; carga a 2.000 cortada por k6 pequeno dentro da VPS mais
  planos; Trivy sim; Node 24 só se verde de primeira.
- Variáveis do `.env` (`r2`): lista só com nomes; autor escreveu o arquivo e corrigiu
  um resto de marcador no endpoint do R2 apontado pelo agente.
- Etapa 6 (`r3`): suíte local do Node 24 interrompida por memória; autor escolheu deixar a
  CI decidir, com volta ao 22 se vermelha.
- Trivy no Caddy (`r4`): sem versão corrigida; autor escolheu a exceção com prazo
  (05/12/2026) e aprovou o método do k6 com tokens assinados na própria VPS.
- Ensaio (`r5`): roteiro aprovado; duas conexões em vez de três, declarado; lote do ensaio
  próprio.
- Cache da CDN (`r6`): após a purga, a URL exata ainda respondia pelo cache de borda; autor
  escolheu a limpeza manual na Cloudflare como passo da rotina e a executou.
- Correção do ensaio (`r7`): capturas conferidas, aprovada.
- Fechamento (`r8`): `CLAUDE.md` ajustado em commit separado, PR único.

## Decisões do agente sem o prompt pedir (declaradas)

Renomear as imagens no GHCR para nomes próprios do repositório; publicar sem atestado de
proveniência para o `GITHUB_TOKEN` gravar o manifesto; desligar a assinatura em pedaços do
SDK da AWS para o R2 (provado por teste reverso na VPS); `style-src 'unsafe-inline'` na CSP
pelo react-native-web; limites da saúde do worker (2 min, 5 min, 24 h); `apt-get upgrade`
no estágio final da imagem da API; `--ignore-unfixed` no Trivy; k6 rodando como root no
contêiner; `auto_explain` só numa rodada curta; gravação de log e `docker stats` durante o
ensaio; correção do passo 6 estendida à concessão da instituição por ser o mesmo componente;
publicação da `rodada/eng_13_endurecimento` no remoto para o GitHub aceitar o PR.

## Observações

- Primeiro passo em que o agente operou infraestrutura real por SSH. Nenhum valor de
  credencial apareceu no chat nem no repositório; o agente conferiu nomes e tamanhos, e as
  consultas ao `.env` da VPS foram feitas pelo autor fora da sessão.
- Dois defeitos reais só apareceram em produção: o R2 recusa o corpo assinado em pedaços
  que o emulador aceitava, e o laço do Trivy parava na primeira imagem. Nos dois casos o
  agente escreveu o teste ou a correção que falha sem o fix antes de aplicar o fix.
- O agente se corrigiu duas vezes por conta própria: o pacote `maxx-api` vazio no GHCR era
  dele, não do `maxx-leigo`; e uma anotação no índice dizendo que o timeout do contêiner
  de armazenamento não se repetira estava errada.
- O teste de restauração do backup tinha um falso positivo (comparava dois arquivos vazios)
  que o próprio agente pegou e corrigiu em fix separado.
- Ensaio em 10/11 das 14h47 às 15h06: tela de login em 4 s no 5G com cache limpo, medalha
  refletida no ranking em 2 s, aviso no Mural na hora, purga de 2 alunos e 6 fotos
  conferida no banco, na fila e no bucket. Um achado de tela (prêmio selecionado sem como
  trocar) corrigido no mesmo dia com Jest e captura revisada. Resíduo do cache de borda da
  CDN registrado como limite conhecido com mitigação na rotina.
- Cortes por prazo declarados e registrados como pendência fora da fase 1: carga de 2.000
  usuários, índices com volume real, backup fora do disco, papel do banco com menos
  privilégio, APK e Maestro, Node 24, Caddy corrigido antes de 05/12, limpeza do cache pela
  própria purga.
- Com o autor dormindo e o agente parado numa pergunta, a sessão esperou 14 h sem perder
  contexto nem compactar; a retomada por `--continue` gerou um segundo arquivo de sessão.
