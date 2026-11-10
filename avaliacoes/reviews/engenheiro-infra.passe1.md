# Review engenheiro, eixo 3. Infraestrutura

- Status: ok
- Tentativa: 1
- Commit avaliado: 8910b51ae7b0ca10582517ead72ee832746683a3 (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: a21af84f-bca2-4c13-8a19-4018067cbe8c

Texto do revisor, sem edição:

---
# Revisão do eixo 3: Infraestrutura, produto `engenheiro` (commit `8910b51ae7b0`)

**Nota: 4 de 5**

**Teste de carga.** Não recebi relatório de teste de carga para este produto e pontuei sem ele. O repositório traz um script k6 (`carga/leitura.js` e `carga/rodar.sh`) e afirma em `docs/decisoes/README.md:881-895` que rodou uma carga reduzida: 50 usuários virtuais por 2 minutos, 9.488 pedidos, 0 falhas, p95 de 43 ms. Esse resultado é declarado pelo próprio agente, sem nenhum artefato de saída versionado. Não pude conferir.

## Justificativa

O produto cumpre todo o nível 4 da rubrica:

- **Deploy reproduzível em contêineres.** A imagem da API serve também para a migração, o seed e o worker. A CI publica as imagens no GHCR e um script implanta a versão de um commit específico.
- **Configuração por variável de ambiente.** Faltando qualquer variável obrigatória, o compose recusa subir.
- **Banco separado da aplicação.**
- **Backup previsto e implementado.** Há dump noturno, dump antes de cada migration e um script que prova que o dump restaura.

Do nível 5, o produto tem quase tudo:

- **API sem estado:** JWT com a mesma chave nas duas réplicas e refresh guardado no banco.
- **Fotos fora da API:** upload direto ao Cloudflare R2 por URL pré-assinada e leitura pela CDN.
- **Fila para o que pode esperar:** fila numa tabela do Postgres, consumida por um worker separado.
- **Duas réplicas da API** atrás do Caddy, com balanceamento.
- **Observabilidade mínima:** rotas `/health`, `/ready` e `/health/worker`, monitor externo e logs com teto de tamanho.

Não dei 5 por quatro motivos:

1. **A redundância não está onde mais importa.** É uma VPS só, com um Postgres só e um worker só. O backup fica no mesmo disco da VPS, e a própria documentação admite que ele não sobrevive à perda desse disco (`docs/operacao.md:174-176`).
2. **O teste de carga não tem relatório oficial.** O que existe é uma versão reduzida (50 usuários, contra os 2.000 planejados), autodeclarada. O cenário real ficou como pendência.
3. **O limite de taxa é por réplica.** É guardado em memória, então com duas réplicas o limite efetivo dobra. A decisão foi registrada e aceita, mas é estado local.
4. **Fragilidades pequenas de operação:**
   - `deploy.sh` usa uma URL fixa em vez de `MAXX_URL_PUBLICA`.
   - A API não tem healthcheck no compose, e o Caddy só espera o contêiner existir.
   - O banco roda com um usuário superusuário.
   - O README da raiz está vazio. As instruções para rodar localmente estão só no comentário do `docker-compose.yml`, e as de produção em `docs/operacao.md`.

## Evidências

| Local | O que mostra |
|---|---|
| `docker-compose.producao.yml:13-14` | As imagens vêm do GHCR pela tag `MAXX_IMAGEM_TAG`. Produção não faz build. |
| `docker-compose.producao.yml:26-45` | Conexão com o banco e credenciais só por variável de ambiente (`${...:?defina no .env}`). Falta uma, o compose não sobe. |
| `docker-compose.producao.yml:39-53` | Postgres em contêiner próprio, com volume, healthcheck e `restart: unless-stopped`. |
| `docker-compose.producao.yml:55-76` | Migrator e seeder rodam uma vez cada, antes das réplicas, encadeados por `service_completed_successfully`. |
| `apps/api/src/Maxx.Infrastructure/Persistence/DatabaseMigrator.cs:25` | A migração roda sob `pg_advisory_lock`. |
| `docker-compose.producao.yml:78-93` | Duas réplicas da API (`deploy.replicas: 2`), sem estado. O comentário admite: "resiliência de deploy, não capacidade". |
| `docker-compose.producao.yml:95-112` | Worker separado, com uma réplica só. |
| `docker-compose.producao.yml:16-22` | Logs com teto de 5 arquivos de 10 MB por contêiner. |
| `docker-compose.producao.yml:137-143` | Só as portas do Caddy (80 e 443) são publicadas. Postgres e API ficam na rede interna. |
| `infra/caddy/Caddyfile:31-43` | Balanceamento round-robin com descoberta das réplicas por DNS (`dynamic a api 8080`) e nova tentativa em outra réplica (`lb_try_duration 5s`). |
| `infra/caddy/Caddyfile:4, 15-28` | HTTPS automático, HSTS e cabeçalhos de segurança, CSP inclusive. |
| `apps/api/Dockerfile:6-34` | Build em dois estágios, imagem final com `apt-get upgrade` e execução sem root (`USER $APP_UID`). |
| `.github/workflows/ci.yml:95-106` | A CI sobe o compose inteiro, com duas réplicas e Caddy, espera `/api/ready` e roda os testes ponta a ponta contra ele. |
| `.github/workflows/ci.yml:178-182` | A CI valida o compose de produção contra a lista de nomes do `.env.producao.example`. |
| `.github/workflows/ci.yml:193-207` | Trivy varre as imagens da API e do Caddy. Achado alto ou crítico falha o job. |
| `.github/workflows/ci.yml:213-244` | O job `publicar` leva as imagens ao GHCR só com os seis jobs verdes, com as tags `sha-<curto>` e `latest`. |
| `infra/deploy.sh:17-32` | O deploy baixa os arquivos do mesmo commit, para se faltar variável no `.env` e troca a tag. |
| `infra/deploy.sh:40-42` | Faz o dump antes da migration quando o banco já existe. |
| `infra/deploy.sh:46, 49` | Espera `/api/ready`, mas com a URL `https://app.maxx-unimax.com` fixa no script, em vez de `MAXX_URL_PUBLICA`. |
| `infra/deploy.sh:44` | `up -d --remove-orphans` sem ordem de atualização entre as réplicas. Pode haver uma janela sem API durante o deploy (não verificável só pela leitura). |
| `infra/backup/backup.sh:22-30` | `pg_dump -Fc`, conferido com `pg_restore --list` antes de ganhar o nome final, e rotação de 14 dias. |
| `infra/backup/restaurar-teste.sh:17-46` | Restaura num Postgres descartável e compara a contagem de linhas de cada tabela com a produção. Recusa a comparação quando nenhuma tabela foi contada. |
| `docs/operacao.md:171-176` | O backup fica em `/opt/maxx/backups`, no disco da própria VPS. O envio para fora é pendência: o backup não sobrevive à perda do disco. |
| `docs/operacao.md:200-213` | Roteiro de restauração e de volta de versão: a migration volta pelo dump `antes-de-migration`. |
| `apps/api/src/Maxx.Api/Health/HealthEndpoints.cs:12-26` | `/health` (processo vivo), `/ready` (healthchecks) e `/health/worker` (503 com a lista de problemas). |
| `docs/operacao.md:148-159` | Monitor externo (UptimeRobot) a cada 5 minutos e tabela de resposta para cada problema do worker. |
| `docker-compose.producao.yml:28-36` | Fotos no Cloudflare R2. A API só assina (ADR 0002). |
| `docs/decisoes/0008-fila-no-postgres.md` | Fila numa tabela do Postgres com `FOR UPDATE SKIP LOCKED` e worker separado, ao custo de disputar I/O com o banco. |
| `docs/decisoes/README.md:55, 94-113` | Limite de taxa nativo do ASP.NET, guardado na memória de cada réplica, sem estado compartilhado. |
| `docs/decisoes/README.md:807` | Na VPS, API e worker usam o superusuário do Postgres. Menos privilégio é pendência. |
| `docs/decisoes/README.md:881-895` | Carga reduzida autodeclarada (50 usuários por 2 minutos, p95 de 43 ms). O cenário de 2.000 usuários foi cortado por prazo. |
| `carga/leitura.js:1-47` e `carga/rodar.sh` | Script k6 versionado. Nenhum arquivo de resultado está no repositório. |
| `docker-compose.yml:3` e `.env.example` | Instrução local: `cp .env.example .env && docker compose up --build`. O emulador do bucket e o Mailpit tornam o ambiente local independente de serviço externo. |
| `README.md:1` | O README da raiz só contém `# Maxx`, sem instrução de execução. |
| `docker-compose.producao.yml:116-135` | Nenhum healthcheck na API. O Caddy depende só de o contêiner existir e conta com a falha passiva do proxy. |

## Regras ausentes

Nenhuma regra da especificação funcional depende deste eixo de forma direta, e não há regra de infraestrutura da ideia que o produto deixe de implementar.

## Decisões do agente neste eixo

Não tive acesso aos prompts da trilha. Os itens abaixo são decisões registradas como do agente ou do plano. Algumas podem ter vindo de restrições técnicas que o engenheiro pediu, e isso precisa ser conferido no export das sessões.

- Hospedagem com Docker Compose numa VPS Hetzner CX23, sem orquestrador.
- Caddy como borda: HTTPS automático pelo Let's Encrypt, HSTS, CSP, outros cabeçalhos de segurança e proxy de `/api` no mesmo domínio (ADR 0001).
- Duas réplicas da API sem estado, apresentadas como resiliência de deploy e não como capacidade.
- Migração num contêiner próprio com advisory lock, nunca na subida da aplicação. Seeder idempotente também em contêiner próprio.
- Fila numa tabela do Postgres, sem broker nem Redis, com worker em contêiner separado (ADR 0008).
- Fotos no Cloudflare R2 com CDN, upload direto por PUT pré-assinado (ADR 0002) e emulador VersityGW em ambiente local e na CI.
- Imagens publicadas no GHCR como pacotes públicos, só com todos os jobs da CI verdes.
- `infra/deploy.sh`, que baixa os arquivos do mesmo commit e faz dump antes da migration.
- Backup com `pg_dump` noturno por timer do systemd, rotação de 14 dias e script de restauração com prova de contagem. Envio para fora da VPS adiado.
- Logs do Docker com teto de 5 arquivos de 10 MB.
- Rotas `/health`, `/ready` e `/health/worker` com batimento do worker, mais alerta externo pelo UptimeRobot.
- Na CI: Trivy nas imagens, gitleaks no histórico completo e `npm audit` e NuGet com corte em alto ou crítico. Exceções do Trivy com data de expiração.
- Atualização dos pacotes do sistema dentro da imagem da API e execução sem root.
- Sub-rede fixa `172.30.0.0/24`, a única confiável para `X-Forwarded-For`.
- Limite de taxa por réplica, sem estado compartilhado.
- Manter o superusuário do Postgres para API e worker.
- Carga reduzida com k6 (50 usuários) no lugar dos 2.000 planejados, e a decisão de não colocar micro-cache no feed.
- SMTP pelo Brevo em produção e Mailpit no ambiente local.
- Avaliação sem plano B local: a VPS é o único ambiente.

## O que não pude verificar só pela leitura

- Se o compose local e o de produção sobem de fato. Não rodei `docker compose` nem build.
- Se a URL `https://app.maxx-unimax.com` está no ar, se o certificado é válido e se as imagens existem no GHCR.
- Se a CI está verde no commit avaliado e se o job `publicar` rodou.
- Os números da carga reduzida (p95, 0 falhas). São autodeclarados, sem artefato de saída no repositório.
- Se o timer de backup está instalado na VPS e se `restaurar-teste.sh` passa.
- Se o `docker compose up -d` do deploy deixa uma janela sem API ao recriar as duas réplicas.
- Se o monitor externo existe e alerta.
- Como o limite de taxa por réplica se comporta sob balanceamento round-robin.

```json
{
  "nota": 4,
  "justificativa": "Cumpre todo o nível 4: deploy reproduzível por contêineres (imagens publicadas no GHCR pela CI e implantadas por infra/deploy.sh pelo sha), configuração só por variável de ambiente com recusa a subir se faltar uma, Postgres em contêiner separado com volume, e backup implementado (pg_dump noturno por timer, dump antes de cada migration, script de restauração com prova de contagem). Do nível 5 tem API sem estado (JWT e refresh no banco), fotos fora da API (R2 com PUT pré-assinado e CDN), fila no Postgres com worker separado, duas réplicas atrás do Caddy e observabilidade mínima (health, ready, health/worker, monitor externo, logs com teto). Não chega a 5 porque a redundância não está onde mais importa (uma VPS só, Postgres e worker únicos, backup no mesmo disco da VPS, admitido em docs/operacao.md:174-176) e porque o teste de carga não tem relatório oficial: só uma versão reduzida (50 usuários) autodeclarada em docs/decisoes/README.md:881-895, sem artefato de saída. Pesam ainda o limite de taxa guardado na memória de cada réplica, o superusuário no banco, a URL fixa no deploy.sh, a falta de healthcheck da API no compose e o README da raiz vazio. Não houve relatório de teste de carga para este produto, e a nota foi dada sem ele.",
  "evidencias": [
    {"local": "docker-compose.producao.yml:13-14", "descricao": "Imagens vêm do GHCR pela MAXX_IMAGEM_TAG; produção não faz build."},
    {"local": "docker-compose.producao.yml:26-45", "descricao": "Conexão com o banco e credenciais só por variável de ambiente, com ${...:?}; faltando uma, o compose não sobe."},
    {"local": "docker-compose.producao.yml:55-76", "descricao": "Migrator e seeder rodam uma vez cada, antes das réplicas, encadeados por service_completed_successfully."},
    {"local": "apps/api/src/Maxx.Infrastructure/Persistence/DatabaseMigrator.cs:25", "descricao": "Migração roda sob pg_advisory_lock."},
    {"local": "docker-compose.producao.yml:78-93", "descricao": "Duas réplicas da API sem estado; o comentário admite que é resiliência de deploy, não capacidade."},
    {"local": "docker-compose.producao.yml:95-112", "descricao": "Worker separado, com uma réplica só."},
    {"local": "docker-compose.producao.yml:16-22", "descricao": "Logs com teto de 5 arquivos de 10 MB por contêiner."},
    {"local": "docker-compose.producao.yml:137-143", "descricao": "Só as portas do Caddy são publicadas; Postgres e API ficam na rede interna."},
    {"local": "infra/caddy/Caddyfile:31-43", "descricao": "Round-robin com descoberta das réplicas por DNS e nova tentativa em outra réplica (lb_try_duration)."},
    {"local": "infra/caddy/Caddyfile:4", "descricao": "HTTPS automático pela MAXX_URL_PUBLICA, com HSTS e cabeçalhos de segurança."},
    {"local": "apps/api/Dockerfile:6-34", "descricao": "Build em dois estágios, apt-get upgrade e execução sem root (USER $APP_UID)."},
    {"local": ".github/workflows/ci.yml:95-106", "descricao": "A CI sobe o compose inteiro, espera /api/ready e roda os testes ponta a ponta contra ele."},
    {"local": ".github/workflows/ci.yml:178-182", "descricao": "Compose de produção validado contra a lista de nomes do .env.producao.example."},
    {"local": ".github/workflows/ci.yml:193-207", "descricao": "Trivy nas imagens da API e do Caddy; achado alto ou crítico falha o job."},
    {"local": ".github/workflows/ci.yml:213-244", "descricao": "Job publicar leva as imagens ao GHCR só com os seis jobs verdes."},
    {"local": "infra/deploy.sh:17-44", "descricao": "Baixa os arquivos do mesmo commit, para se faltar variável, troca a tag, puxa as imagens, faz o dump antes da migration e sobe."},
    {"local": "infra/deploy.sh:46", "descricao": "URL https://app.maxx-unimax.com fixa no script, em vez de MAXX_URL_PUBLICA."},
    {"local": "infra/backup/backup.sh:22-30", "descricao": "pg_dump -Fc conferido com pg_restore --list antes do nome final; rotação de 14 dias."},
    {"local": "infra/backup/restaurar-teste.sh:17-46", "descricao": "Restaura num Postgres descartável e compara a contagem de linhas de cada tabela com a produção."},
    {"local": "docs/operacao.md:171-176", "descricao": "O backup fica no disco da VPS; o envio para fora é pendência e o backup não sobrevive à perda do disco."},
    {"local": "docs/operacao.md:200-213", "descricao": "Roteiro de restauração e de volta de versão pelo dump antes-de-migration."},
    {"local": "apps/api/src/Maxx.Api/Health/HealthEndpoints.cs:12-26", "descricao": "Rotas /health, /ready e /health/worker (503 com a lista de problemas)."},
    {"local": "docs/operacao.md:148-159", "descricao": "Monitor externo (UptimeRobot) a cada 5 minutos e tabela de resposta a cada problema do worker."},
    {"local": "docs/decisoes/0008-fila-no-postgres.md", "descricao": "Fila numa tabela do Postgres com worker separado, ao custo de disputar I/O com o banco."},
    {"local": "docker-compose.producao.yml:28-36", "descricao": "Fotos no Cloudflare R2; a API só assina o upload (ADR 0002)."},
    {"local": "docs/decisoes/README.md:55", "descricao": "Limite de taxa guardado na memória de cada réplica, sem estado compartilhado."},
    {"local": "docs/decisoes/README.md:807", "descricao": "API e worker usam o superusuário do Postgres; menos privilégio é pendência."},
    {"local": "docs/decisoes/README.md:881-895", "descricao": "Carga reduzida autodeclarada (50 usuários por 2 minutos, p95 de 43 ms); cenário de 2.000 usuários cortado por prazo."},
    {"local": "carga/leitura.js:1-47", "descricao": "Script k6 versionado; nenhum arquivo de resultado no repositório."},
    {"local": "docker-compose.yml:3", "descricao": "Instrução local só no comentário: cp .env.example .env && docker compose up --build, com emulador do bucket e Mailpit."},
    {"local": "README.md:1", "descricao": "README da raiz só contém '# Maxx', sem instrução de execução."},
    {"local": "docker-compose.producao.yml:116-135", "descricao": "API sem healthcheck no compose; o Caddy depende só de o contêiner existir."}
  ],
  "regras_ausentes": [],
  "decisoes_do_agente": [
    "Hospedagem com Docker Compose numa VPS Hetzner CX23, sem orquestrador",
    "Caddy como borda, com HTTPS automático, HSTS, CSP, cabeçalhos de segurança e proxy de /api no mesmo domínio (ADR 0001)",
    "Duas réplicas da API sem estado, como resiliência de deploy e não capacidade",
    "Migração num contêiner próprio com advisory lock, nunca na subida da aplicação; seeder idempotente em contêiner próprio",
    "Fila numa tabela do Postgres, sem broker nem Redis, com worker em contêiner separado (ADR 0008)",
    "Fotos no Cloudflare R2 com CDN e upload por PUT pré-assinado; emulador VersityGW em ambiente local e na CI",
    "Imagens publicadas no GHCR como pacotes públicos, só com a CI verde",
    "Script infra/deploy.sh que baixa os arquivos do mesmo commit e faz dump antes da migration",
    "Backup com pg_dump noturno por timer do systemd, rotação de 14 dias e script de restauração com prova; envio para fora da VPS adiado",
    "Logs do Docker com teto de 5 arquivos de 10 MB",
    "Rotas /health, /ready e /health/worker com batimento do worker e alerta externo pelo UptimeRobot",
    "Na CI: Trivy nas imagens, gitleaks no histórico, npm audit e NuGet com corte em alto ou crítico; exceções do Trivy com data de expiração",
    "Atualização dos pacotes do sistema dentro da imagem da API e execução sem root",
    "Sub-rede fixa 172.30.0.0/24 como única confiável para X-Forwarded-For",
    "Limite de taxa por réplica, sem estado compartilhado",
    "Manter o superusuário do Postgres para API e worker",
    "Carga reduzida com k6 (50 usuários) no lugar dos 2.000 planejados, sem micro-cache no feed",
    "SMTP pelo Brevo em produção e Mailpit no ambiente local",
    "VPS como único ambiente da avaliação, sem plano B local"
  ],
  "nao_verificado": [
    "Se o compose local e o de produção sobem de fato (sem docker nem build)",
    "Se https://app.maxx-unimax.com está no ar, se o certificado é válido e se as imagens existem no GHCR",
    "Se a CI está verde no commit avaliado e se o job publicar rodou",
    "Os números da carga reduzida (p95, 0 falhas), autodeclarados e sem artefato de saída; não houve relatório de teste de carga para este produto",
    "Se o timer de backup está instalado na VPS e se restaurar-teste.sh passa",
    "Se o docker compose up -d do deploy deixa uma janela sem API ao recriar as duas réplicas",
    "Se o monitor externo (UptimeRobot) existe e alerta",
    "Como o limite de taxa por réplica se comporta sob balanceamento round-robin"
  ]
}
```
