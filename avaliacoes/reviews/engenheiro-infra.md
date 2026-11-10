# Review engenheiro, eixo 3. Infraestrutura

- Status: ok
- Tentativa: 1
- Commit avaliado: 8910b51ae7b0ca10582517ead72ee832746683a3 (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 10a26f9f-ba9b-4b7e-8fe7-9a0270d62f41

Texto do revisor, sem edição:

---
# Revisão do eixo 3: Infraestrutura, produto `engenheiro` (commit `8910b51a`)

**Não há relatório de teste de carga do avaliador para este produto.** A nota sai sem ele. O repositório traz um script k6 e um resultado descrito pelo próprio projeto. Uso isso como evidência declarada, que não pude verificar.

Esta sessão só permitia leitura de arquivos. Não executei comandos, não subi o compose e não acessei a URL de produção. Tudo abaixo vem dos arquivos.

## Nota: 4

## Justificativa

O produto cumpre com folga o critério da nota 4 e boa parte do critério da nota 5:

- **Deploy reproduzível em contêineres:**
  - Há um compose local e um compose de produção separados.
  - As imagens são publicadas no GHCR pela CI, só depois que os seis jobs passam.
  - O `infra/deploy.sh` recebe o sha do commit, confere o `.env`, faz backup antes da migration, sobe a pilha e espera o `/api/ready`.
- **Configuração por variável de ambiente:** o compose usa `${VAR:?defina no .env}` e não sobe se faltar valor. A CI prova que o `.env.producao.example` tem todos os nomes exigidos.
- **Banco separado da aplicação:** o Postgres roda em contêiner próprio com volume próprio. As migrations rodam num contêiner à parte, com advisory lock, antes das réplicas.
- **Backup:** dump noturno pelo systemd, dump antes de cada migration, rotação de 14 dias, validação com `pg_restore --list` e um script que restaura num Postgres descartável e compara a contagem de linhas.

Para a nota 5, já existem:

- API sem estado, com duas réplicas atrás do Caddy e balanceamento por DNS.
- Fotos fora da API, enviadas por PUT pré-assinado direto ao R2 e lidas pela CDN.
- Fila no Postgres (`FOR UPDATE SKIP LOCKED`) consumida por um worker separado.
- Health checks de liveness, readiness e saúde do worker, com monitor externo.
- Teto de log por contêiner.
- Varredura de imagens (Trivy), de segredos (gitleaks) e de dependências (NuGet e npm).

**Por que não chega a 5:**

1. **Não há redundância onde mais importa, que são os dados.** Tudo roda numa única VPS, com um único Postgres sem réplica. O backup fica no mesmo disco da VPS, e a própria documentação admite que "hoje o backup não sobrevive à perda do disco da VPS" (`docs/operacao.md:174-176`). As duas réplicas de API estão no mesmo host e são declaradas como "resiliência de deploy, não capacidade" (`docker-compose.producao.yml:78`). O worker tem uma réplica só.
2. **O teste de carga foi reduzido.** Foram 50 usuários virtuais por 2 minutos sobre um seed de 150 alunos, contra o cenário de 2.000 usuários e 3.200 alunos que o próprio ADR 0005 definiu. Esse cenário completo ficou pendente (`docs/decisoes/README.md:883-891`). Além disso, não existe relatório externo do avaliador.
3. **Restam pontos de configuração presos ao código e de privilégio:**
   - O domínio `app.maxx-unimax.com` está fixo no `deploy.sh:46-49` e no `carga/rodar.sh:39`.
   - O nome do repositório e o owner do GHCR estão fixos no compose e no deploy.
   - A API e o worker usam o superusuário do Postgres (`docs/decisoes/README.md:807`).
   - O limite de taxa fica em memória, por réplica, sem estado compartilhado (`docs/decisoes/README.md:55`).
   - Os serviços `api` e `worker` não têm `healthcheck` no compose, e o `caddy` usa um `depends_on` simples.
   - A observabilidade se resume a log em json-file e health checks, sem métricas nem tracing.

## Evidências

| Local | Descrição |
|---|---|
| `docker-compose.producao.yml:13-14` | Imagem da API vem do GHCR com a tag em `MAXX_IMAGEM_TAG` obrigatória. Não há build na VPS. |
| `docker-compose.producao.yml:26-36, 84-108` | Toda a configuração e os segredos vêm de variáveis `${...:?defina no .env}`. Faltando uma, a pilha não sobe. |
| `docker-compose.producao.yml:39-53` | Postgres 18 em contêiner próprio, com volume `postgres-data`, healthcheck e `restart: unless-stopped`. |
| `docker-compose.producao.yml:55-64` | Contêiner `migrator` separado, que roda antes das réplicas e espera o Postgres ficar saudável. |
| `apps/api/src/Maxx.Infrastructure/Persistence/DatabaseMigrator.cs:12-38` | Migration protegida por `pg_advisory_lock` e `pg_advisory_unlock`. |
| `docker-compose.producao.yml:78-93` | Duas réplicas de API sem estado, descritas como "resiliência de deploy, não capacidade". |
| `docker-compose.producao.yml:95-112` | Worker separado com uma réplica. O SMTP fica só nele. |
| `docker-compose.producao.yml:16-22` | Log de cada contêiner limitado a 5 arquivos de 10 MB. |
| `docker-compose.producao.yml:114-135, 137-143` | Caddy com HTTPS automático (Let's Encrypt), volumes para os certificados e só as portas 80 e 443 publicadas. Postgres e API ficam na rede interna, numa sub-rede fixa. |
| `infra/caddy/Caddyfile:31-43` | Proxy reverso com descoberta dinâmica das réplicas (`dynamic a api 8080`, refresh de 5 s), round robin e `lb_try_duration` para tentar outra réplica quando uma falha. |
| `infra/caddy/Caddyfile:15-28` | Cabeçalhos de segurança, CSP montada a partir de variáveis e HSTS só em HTTPS. |
| `apps/api/Dockerfile:6-34` | Build multi-stage com restore em camada própria, imagem aspnet com `apt-get upgrade`, usuário sem privilégio (`USER $APP_UID`) e uma imagem só para API, migrate, seed e worker. |
| `apps/api/src/Maxx.Api/Program.cs:26-50` | Mesmo binário com os modos `migrate`, `seed`, `anular-medalha` e `worker`. |
| `.github/workflows/ci.yml:81-136` | Job e2e sobe o compose completo (duas réplicas, Caddy, emulador de bucket), espera o `/api/ready` e roda o Playwright. É uma prova automatizada de que a pilha sobe fora da máquina do autor. |
| `.github/workflows/ci.yml:178-182` | CI valida o compose de produção com um valor falso para cada nome do `.env.producao.example`, sozinho e com a demonstração por cima. |
| `.github/workflows/ci.yml:193-207` | Trivy nas imagens da API e do Caddy, falhando em achado alto ou crítico com correção publicada. |
| `.github/workflows/ci.yml:213-244` | Job `publicar` envia as imagens ao GHCR com as tags `sha-<curto>` e `latest`, só depois que os seis jobs passam. |
| `infra/deploy.sh:17-30` | Baixa do repositório, no mesmo commit, os arquivos de compose e os scripts, e para se faltar variável no `.env`. |
| `infra/deploy.sh:39-49` | Dump antes da migration, `up -d` e espera do `/api/ready`. |
| `infra/deploy.sh:46-49` | URL de produção fixa no script (`https://app.maxx-unimax.com/api/ready`): configuração misturada com código. |
| `infra/deploy.sh:13` | Busca os arquivos em `raw.githubusercontent.com` pelo sha, sem verificar assinatura. Usar o sha imutável atenua o risco. |
| `infra/backup/backup.sh:14-30` | `pg_dump -Fc` gravado primeiro como `.parcial`, validado com `pg_restore --list`, com permissão 700 e rotação de 14 dias. |
| `infra/backup/restaurar-teste.sh:17-46` | Restaura num Postgres descartável e compara a contagem exata de linhas de cada tabela com a produção. Recusa o falso positivo de dois arquivos vazios. |
| `docs/operacao.md:171-176` | Admite que o backup fica no disco da VPS e não sobrevive à perda dele. Envio para fora está pendente. |
| `docs/operacao.md:200-213` | Roteiro de restauração real e de rollback de versão, com a migration desfeita pelo dump `antes-de-migration`. |
| `apps/api/src/Maxx.Api/Health/HealthEndpoints.cs:12-26` | Endpoints `/api/health` (liveness), `/api/ready` (checa o banco) e `/api/health/worker` (devolve 503 com a lista de problemas). |
| `apps/api/src/Maxx.Infrastructure/DependencyInjection.cs:145-146` | Readiness com a verificação do banco e timeout de 3 s. |
| `docs/operacao.md:148-159` | Monitor externo (UptimeRobot) a cada 5 minutos, com uma tabela de problemas e da ação correspondente. |
| `carga/leitura.js:38-64` e `carga/rodar.sh:42-65` | Teste k6 versionado, com limite de p95 < 300 ms por rota, 50 usuários virtuais por 2 minutos e uma rodada separada com `auto_explain`. |
| `docs/decisoes/README.md:883-895` | Resultado declarado: 9.488 pedidos, 0 falha, p95 geral de 43 ms e máximo por rota de 71 ms (feed). O cenário de 2.000 usuários ficou pendente. |
| `docs/decisoes/README.md:807` | API e worker usam o superusuário do Postgres. Um papel com menos privilégio está pendente. |
| `docs/decisoes/README.md:55` | Limite de taxa em memória, por réplica, sem estado compartilhado. Com N réplicas, o limite efetivo é multiplicado por N. |
| `docs/decisoes/0008-fila-no-postgres.md` | Fila no próprio Postgres, sem broker. O banco acumula a função de fila. |
| `docker-compose.yml:125-188` | Ambiente local com VersityGW (compatível com S3) e Mailpit, ligados por perfil, em paridade com o R2 e o SMTP de produção. |
| `.env.example:1-50` e `.env.producao.example:1-39` | Variáveis documentadas, sem segredo real versionado. A chave JWT vem vazia de propósito. |
| `README.md:1` | O README raiz tem só o título. As instruções de execução estão no cabeçalho do `docker-compose.yml:3` e em `docs/operacao.md`. |

## Regras ausentes

Nenhuma. A especificação das telas não traz regra de produto própria deste eixo.

## Decisões do agente neste eixo

Não tive acesso ao prompt da persona. Parte destas escolhas pode ter sido pedida pelo engenheiro, e a documentação marca algumas como aprovadas pelo autor (por exemplo, a carga reduzida). A lista inclui tudo o que aparece como decisão registrada no repositório.

- Hospedar em uma única VPS Hetzner CX23 com Docker Compose, sem orquestrador.
- Usar Caddy como borda, com HTTPS automático, HSTS só em HTTPS, CSP montada por variáveis e balanceamento dinâmico das réplicas.
- Separar o compose local do de produção, com um `docker-compose.demo.yml` sobreposto para ligar a demonstração.
- Publicar as imagens como públicas no GHCR, usando `--provenance=false` para contornar o erro `denied`.
- Criar um deploy por script (`infra/deploy.sh`) que baixa a si mesmo do repositório no sha informado.
- Rodar duas réplicas de API como resiliência de deploy, sem ganho de capacidade, e uma réplica de worker.
- Fazer a fila no Postgres com `SKIP LOCKED`, sem Redis nem broker (ADR 0008).
- Rodar a migration num contêiner separado com advisory lock, nunca no startup.
- Guardar as fotos no Cloudflare R2 com PUT pré-assinado e CDN, e usar o VersityGW como emulador local e na CI (ADR 0002).
- Usar uma sub-rede fixa no compose para restringir a confiança no `X-Forwarded-For` ao Caddy.
- Fazer backup local com `pg_dump`, timer do systemd, rotação de 14 dias e script de prova de restauração, deixando o backup externo como pendência.
- Criar um batimento do worker em tabela, o endpoint `/api/health/worker` e o monitor externo UptimeRobot.
- Limitar o log a 10 MB × 5 arquivos por contêiner.
- Adicionar Trivy com exceções que expiram sozinhas, gitleaks no histórico inteiro e auditoria de NuGet e npm na CI.
- Rodar a carga reduzida (50 usuários virtuais por 2 minutos) assinando os tokens dentro da VPS com a chave de produção.
- Manter o superusuário do Postgres para a aplicação.
- Aplicar o limite de taxa por réplica, sem estado compartilhado.
- Fazer `apt-get upgrade` na imagem final por causa do Trivy.

## O que não pude verificar

- Que as imagens compilam e que `docker compose up --build` sobe de fato.
- Que a URL `https://app.maxx-unimax.com` está no ar e com certificado válido.
- Que a CI está verde no commit avaliado e que as imagens `sha-8910b51` existem no GHCR.
- Os números do teste de carga, que são declarados em `docs/decisoes/README.md` e não auditados. Também não há relatório do avaliador em `avaliacoes/carga/`.
- Que o timer de backup está instalado na VPS e que os dumps existem.
- Que o monitor do UptimeRobot existe e alerta.
- O comportamento do failover entre réplicas no Caddy (`lb_try_duration`) diante de uma falha real.
- Se o restore de fato dá 46 tabelas iguais, como a documentação afirma.

```json
{
  "nota": 4,
  "justificativa": "Cumpre integralmente o nível 4 e boa parte do 5. Deploy reproduzível com contêineres: imagens publicadas no GHCR pela CI só depois que os seis jobs passam, docker-compose.producao.yml separado do local e infra/deploy.sh que confere o .env, faz dump antes da migration, sobe e espera o /api/ready. Configuração toda por variável de ambiente com ${VAR:?}, validada na CI. Postgres em contêiner e volume próprios, com migrator separado e advisory lock. Backup noturno e antes de cada migration, validado com pg_restore --list e com script de prova de restauração. Do nível 5 já há API sem estado com duas réplicas atrás do Caddy, fotos fora da API (PUT pré-assinado ao R2 e leitura pela CDN), fila no Postgres consumida por worker separado, health e readiness, saúde do worker com monitor externo e teto de log. Não chega a 5 porque falta redundância onde mais importa: VPS única, Postgres único sem réplica e backup no mesmo disco, o que a própria documentação admite. O teste de carga foi reduzido (50 usuários virtuais, seed de 150 alunos), o cenário de 2.000 usuários ficou pendente e não há relatório do avaliador. Também restam domínio fixo nos scripts, a aplicação usando o superusuário do Postgres, limite de taxa por réplica em memória, ausência de healthcheck da API e do worker no compose e observabilidade limitada a logs e health checks, sem métricas.",
  "evidencias": [
    {"local": "docker-compose.producao.yml:13-14", "descricao": "Imagem da API vem do GHCR com a tag em MAXX_IMAGEM_TAG obrigatória; não há build na VPS."},
    {"local": "docker-compose.producao.yml:26-36", "descricao": "Conexão do banco e credenciais do R2 exigidas por ${VAR:?defina no .env}; faltando uma, a pilha não sobe."},
    {"local": "docker-compose.producao.yml:39-53", "descricao": "Postgres 18 em contêiner próprio com volume, healthcheck e restart unless-stopped."},
    {"local": "docker-compose.producao.yml:55-64", "descricao": "Contêiner migrator separado, que roda antes das réplicas."},
    {"local": "apps/api/src/Maxx.Infrastructure/Persistence/DatabaseMigrator.cs:25", "descricao": "Migration protegida por pg_advisory_lock."},
    {"local": "docker-compose.producao.yml:78-93", "descricao": "Duas réplicas de API sem estado, descritas como resiliência de deploy e não capacidade."},
    {"local": "docker-compose.producao.yml:95-112", "descricao": "Worker separado com uma réplica e SMTP só nele."},
    {"local": "docker-compose.producao.yml:16-22", "descricao": "Log de cada contêiner limitado a 5 arquivos de 10 MB."},
    {"local": "docker-compose.producao.yml:114-143", "descricao": "Caddy com HTTPS automático e volumes de certificado; só as portas 80 e 443 publicadas; sub-rede fixa e Postgres e API apenas na rede interna."},
    {"local": "infra/caddy/Caddyfile:31-43", "descricao": "Proxy com descoberta dinâmica das réplicas, round robin e lb_try_duration para tentar outra réplica em caso de falha."},
    {"local": "apps/api/Dockerfile:6-34", "descricao": "Build multi-stage, apt-get upgrade na imagem final, usuário sem privilégio e uma única imagem para API, migrate, seed e worker."},
    {"local": ".github/workflows/ci.yml:81-136", "descricao": "Job e2e sobe o compose completo na CI e roda o Playwright: prova automatizada de que a pilha sobe fora da máquina do autor."},
    {"local": ".github/workflows/ci.yml:178-182", "descricao": "CI valida o compose de produção com valor falso para cada nome do .env.producao.example."},
    {"local": ".github/workflows/ci.yml:193-207", "descricao": "Trivy nas imagens da API e do Caddy, com corte em achado alto ou crítico."},
    {"local": ".github/workflows/ci.yml:213-244", "descricao": "Job publicar envia as imagens ao GHCR com as tags sha e latest, só depois que os seis jobs passam."},
    {"local": "infra/deploy.sh:17-49", "descricao": "Deploy por sha: baixa compose e scripts no mesmo commit, valida o .env, troca a tag, faz pull, dump antes da migration, up -d e espera o /api/ready."},
    {"local": "infra/deploy.sh:46-49", "descricao": "URL de produção fixa no script (app.maxx-unimax.com): configuração misturada com código."},
    {"local": "carga/rodar.sh:39", "descricao": "Domínio de produção também fixo no script de carga."},
    {"local": "infra/backup/backup.sh:14-30", "descricao": "pg_dump -Fc gravado como .parcial, validado com pg_restore --list, permissão 700 e rotação de 14 dias."},
    {"local": "infra/backup/restaurar-teste.sh:17-46", "descricao": "Restaura em Postgres descartável e compara a contagem de linhas de cada tabela com a produção."},
    {"local": "docs/operacao.md:171-176", "descricao": "Admite que o backup fica no disco da VPS e não sobrevive à perda dele."},
    {"local": "docs/operacao.md:200-213", "descricao": "Roteiro de restauração real e de rollback de versão."},
    {"local": "apps/api/src/Maxx.Api/Health/HealthEndpoints.cs:12-26", "descricao": "Endpoints /api/health (liveness), /api/ready (banco) e /api/health/worker (503 com a lista de problemas)."},
    {"local": "docs/operacao.md:148-159", "descricao": "Monitor externo UptimeRobot a cada 5 minutos, com tabela de problemas e ação correspondente."},
    {"local": "carga/leitura.js:38-64", "descricao": "Teste k6 versionado com limite de p95 < 300 ms por rota."},
    {"local": "docs/decisoes/README.md:883-895", "descricao": "Carga reduzida declarada: 50 usuários virtuais por 2 minutos, 9.488 pedidos, 0 falha, p95 geral de 43 ms; cenário de 2.000 usuários pendente."},
    {"local": "docs/decisoes/README.md:807", "descricao": "API e worker usam o superusuário do Postgres; papel com menos privilégio pendente."},
    {"local": "docs/decisoes/README.md:55", "descricao": "Limite de taxa em memória, por réplica, sem estado compartilhado."},
    {"local": "docker-compose.producao.yml:79-93", "descricao": "Serviços api e worker sem healthcheck no compose; o caddy usa depends_on simples."},
    {"local": "README.md:1", "descricao": "README raiz tem só o título; as instruções de execução estão no cabeçalho do docker-compose.yml e em docs/operacao.md."}
  ],
  "regras_ausentes": [],
  "decisoes_do_agente": [
    "Hospedar em uma única VPS Hetzner CX23 com Docker Compose, sem orquestrador",
    "Usar Caddy como borda com HTTPS automático, HSTS só em HTTPS, CSP montada por variáveis e balanceamento dinâmico das réplicas",
    "Separar o compose local do de produção, com docker-compose.demo.yml sobreposto para a demonstração",
    "Publicar as imagens como públicas no GHCR pela CI, com --provenance=false",
    "Criar o deploy por script (infra/deploy.sh) que baixa a si mesmo do repositório pelo sha",
    "Rodar duas réplicas de API como resiliência de deploy e uma réplica de worker",
    "Fazer a fila no Postgres com SKIP LOCKED, sem Redis nem broker",
    "Rodar a migration em contêiner separado com advisory lock, nunca no startup",
    "Guardar as fotos no Cloudflare R2 com PUT pré-assinado e CDN, com VersityGW como emulador local e na CI",
    "Usar sub-rede fixa no compose para confiar no X-Forwarded-For só vindo do Caddy",
    "Fazer backup local com pg_dump, timer do systemd, rotação de 14 dias e script de prova de restauração, deixando o backup externo como pendência",
    "Criar batimento do worker em tabela, endpoint /api/health/worker e monitor externo UptimeRobot",
    "Limitar o log a 10 MB x 5 arquivos por contêiner",
    "Adicionar Trivy com exceções que expiram, gitleaks no histórico completo e auditoria de NuGet e npm na CI",
    "Rodar a carga reduzida (50 usuários virtuais por 2 minutos) assinando os tokens na VPS com a chave de produção",
    "Manter o superusuário do Postgres para a aplicação",
    "Aplicar o limite de taxa por réplica, sem estado compartilhado",
    "Fazer apt-get upgrade na imagem final da API"
  ],
  "nao_verificado": [
    "Se as imagens compilam e se docker compose up --build sobe de fato",
    "Se a URL https://app.maxx-unimax.com está no ar com certificado válido",
    "Se a CI está verde no commit avaliado e se as imagens sha-8910b51 existem no GHCR",
    "Os números do teste de carga, que são autodeclarados; não há relatório de teste de carga do avaliador para este produto",
    "Se o timer de backup está instalado na VPS e se os dumps existem",
    "Se o monitor UptimeRobot existe e dispara alertas",
    "O comportamento real do failover entre réplicas no Caddy",
    "O resultado declarado da prova de restauração (46 tabelas iguais)"
  ]
}
```
