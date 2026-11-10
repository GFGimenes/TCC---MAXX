# Review engenheiro, eixo 3. Infraestrutura

- Status: ok
- Tentativa: 1
- Commit avaliado: 076549bbea15649813d347c2618a4b51377e6bdd (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 6b3a89bd-0a14-4f04-9448-7c1f4fb4b86f

Texto do revisor, sem edição:

---
# Review: eixo 3 (Infraestrutura), produto `engenheiro`, commit `076549bbea15`

**Teste de carga:** não há relatório de teste de carga para este produto, então a nota foi dada sem ele. O repositório também não tem script k6. O teste de 2.000 usuários virtuais aparece só como plano do passo 13 (`docs/plano-mestre.md:327`).

## Nota: 3

## Justificativa

A estrutura está bem acima da média de um TCC. Em termos de arquitetura de execução, ela já cobre quase tudo que a rubrica pede para a nota 4 e parte do que pede para a nota 5:
- O compose sobe a pilha inteira: Postgres, migração com advisory lock, seeder idempotente, duas réplicas de API sem estado, worker de fila, Caddy servindo o web e fazendo proxy, Mailpit e um emulador S3.
- Os Dockerfiles são multi-stage, e a API roda com usuário sem privilégio.
- A configuração vem só de variáveis de ambiente, com `:?` para falhar quando falta valor.
- As fotos ficam fora da API: a API assina URLs de upload para o bucket.
- O que pode esperar vai para uma fila no Postgres com `SKIP LOCKED`.
- O CI sobe o compose e roda os testes e2e contra ele.

A nota fica em 3 por três motivos objetivos:

1. **Não há deploy comprovado em URL nenhuma.** O deploy na VPS, o HTTPS, o backup e o ensaio remoto estão todos marcados como pendentes no passo 13 (`docs/plano-mestre.md:325-361`). Além disso, a configuração versionada não serve produção como está:
   - o Caddyfile só escuta em `:80`, e a variável `MAXX_SITE_ADDRESS` nunca é repassada ao contêiner do Caddy;
   - a porta 443 não é publicada;
   - o próprio comentário diz "HTTPS, HSTS e CSP entram no passo 13".
2. **O backup é só documentação.** `pg_dump` noturno e dump antes de cada migration estão em `docs/decisoes/README.md:33`, mas não existem script, serviço nem job.
3. **A observabilidade é mínima e tem lacunas reconhecidas pelo próprio projeto:**
   - não há healthcheck da API nem do worker no compose;
   - o defeito "worker morto congela o ranking" é um risco aceito e ainda aberto;
   - não há métricas;
   - o limite de taxa fica em memória, por réplica.

Na régua, faltam o deploy em URL (exigido a partir da nota 3) e o backup implementado. A nota 2 não descreve bem o produto, porque aqui a configuração não está misturada com o código e o deploy é reproduzível por contêiner. A nota 3 reconhece a estrutura e penaliza a falta de deploy, backup e teste de carga. Se o deploy na VPS existir fora do repositório, a nota sobe para 4.

## Evidências

| Local | Descrição |
|---|---|
| `docker-compose.yml:1-3` | Pilha completa e instrução de uso: `cp .env.example .env && docker compose up --build`. É a única instrução de execução da raiz, porque o `README.md` tem só `# Maxx`. |
| `docker-compose.yml:17,23-29,42-44,88` | Conexão com o banco, bucket, credenciais e chave JWT vêm só de variáveis, com `:?defina no .env`. Faltando valor, nada sobe. |
| `docker-compose.yml:39-52` | Postgres 18 em serviço próprio, com volume nomeado e healthcheck `pg_isready`. O banco é separado da aplicação. |
| `docker-compose.yml:54-64` + `apps/api/src/Maxx.Infrastructure/Persistence/DatabaseMigrator.cs:25` | A migração roda num contêiner próprio, com `pg_advisory_lock`, antes das réplicas e nunca no startup. |
| `docker-compose.yml:81-100` | `api` com `replicas: 2` e `restart: unless-stopped`. Comentário: "resiliência de deploy, não capacidade". |
| `docker-compose.yml:102-123` + `apps/api/src/Maxx.Infrastructure/Fila/ConsumidorDeTrabalhos.cs:43` | Worker separado consumindo a fila no Postgres com `FOR UPDATE SKIP LOCKED`. É uma réplica só e não tem healthcheck. |
| `docker-compose.yml:129-180` | Emulador S3 (VersityGW) e configuração do bucket (policy e CORS) só no perfil `armazenamento-local`. Em produção, a troca para o R2 seria feita pelo `.env`. |
| `docker-compose.yml:141-142,186-187,194-195` | Só a porta 80 do Caddy é publicada. Emulador e Mailpit ficam presos a `127.0.0.1`. Não há porta 443. |
| `infra/caddy/Caddyfile:2-3` | `{$MAXX_SITE_ADDRESS::80}` com o comentário "HTTPS, HSTS e CSP entram no passo 13". A variável não é passada ao serviço `caddy` (`docker-compose.yml:190-198`). |
| `infra/caddy/Caddyfile:8-18` | Balanceamento das réplicas por DNS dinâmico (`refresh 5s`), `round_robin`, `lb_try_duration 5s`: há failover entre réplicas. |
| `apps/api/Dockerfile:6-29` | Build multi-stage com restore em camada própria. Uma imagem serve API, migrate, seed e worker. Roda com `USER $APP_UID`. |
| `infra/caddy/Dockerfile:4-20` | Build web do Expo embutido na imagem do Caddy (`npm ci` com lockfile). |
| `.env.example:1-49` | Todas as variáveis documentadas. Chave JWT vazia de propósito, com instrução para gerar. Avisos para não reutilizar valores na VPS. |
| `.gitignore:2-4` | `.env` e `.env.*` fora do git, exceto o exemplo. |
| `apps/api/src/Maxx.Api/appsettings.json:1-11` | Nenhum segredo, só nível de log. |
| `apps/api/src/Maxx.Api/Health/HealthEndpoints.cs:11-39` + `apps/api/src/Maxx.Infrastructure/DependencyInjection.cs:140-141` | `/api/health` (liveness) e `/api/ready` (checagem do banco com timeout de 3 s). Nenhum healthcheck do compose os usa; só o CI os consulta. |
| `apps/api/src/Maxx.Api/LimiteDeTaxa/LimitesDeTaxa.cs:7-8` | Limite de taxa em memória, por réplica. Com duas réplicas, o limite efetivo pode chegar ao dobro. O próprio projeto registra isso em `docs/plano-mestre.md:392`. |
| `.github/workflows/ci.yml:94-128` | O job e2e sobe o compose inteiro com chave descartável, espera o `/api/ready`, roda o seed demo e o Playwright, e repete com o overlay de demonstração. Isso é forte evidência de que a pilha sobe fora da máquina do autor. |
| `.github/workflows/ci.yml:137-180` | Gitleaks no histórico completo, auditoria de NuGet e npm (alto/crítico) e build das imagens. Não há job de deploy nem de publicação de imagens. |
| `docker-compose.demo.yml:1-10` | O modo de demonstração liga só por um overlay separado. O compose base nunca o menciona. |
| `docs/decisoes/README.md:28-35` | Infraestrutura decidida: VPS, HTTPS com HSTS, duas réplicas, R2 com CDN, backup `pg_dump`. O backup e o HTTPS não estão implementados no repositório. |
| `docs/plano-mestre.md:325-361` | O passo 13 (k6, HTTPS/CSP, R2 real, saúde do worker e alerta de fila, backup, ensaio na VPS) aparece inteiro como pendente. |
| `docs/decisoes/0008-fila-no-postgres.md` / `docs/plano-mestre.md:385,387` | Riscos registrados: worker morto congela o ranking sem erro visível; fila disputa I/O com o feed no pico. Postgres e worker são pontos únicos de falha. |
| `README.md:1` | O README da raiz tem só o título. As instruções ficam no cabeçalho do compose, no `.env.example` e em `apps/mobile/README.md`. |

## Regras ausentes

Nenhuma regra funcional da especificação de telas pertence ao eixo Infraestrutura. Não marco ausências neste eixo.

## Decisões do agente

O prompt do construtor não está disponível nesta sessão. Listo as decisões de infraestrutura que não aparecem na stack declarada do `CLAUDE.md` (Compose em VPS, Caddy, R2, fila no Postgres, GitHub Actions) e que parecem ter sido tomadas pelo agente. Algumas constam como "aprovado no plano do passo".

- VersityGW como emulador S3 local e na CI, ligado por perfil do compose, com dependência `required: false` para sumir em produção.
- Mailpit no compose como destino de e-mail local.
- Sub-rede fixa `172.30.0.0/24` para a API confiar no `X-Forwarded-For` só vindo do Caddy.
- `Gss Encryption Mode=Disable` na connection string, para evitar ruído de Kerberos no log.
- Seeder `seed base` como contêiner que roda a cada subida, entre a migração e as réplicas; `seed demo` feito à mão.
- Caddy descobrindo réplicas por DNS dinâmico, com `refresh 5s`, `lb_try_duration` e `fail_duration`.
- Build web do Expo embutido na imagem do Caddy.
- Uma imagem única servindo API, migrate, seed, worker e o comando administrativo de anulação, escolhida por argumento.
- Limite de taxa em memória por réplica, sem estado compartilhado.
- Overlay `docker-compose.demo.yml` para ligar a demonstração, separado do compose base.
- Gitleaks com histórico completo e auditoria de dependências NuGet e npm no CI.
- E2E no CI contra o compose real, nas duas configurações (com e sem demonstração).
- Portas do emulador e do Mailpit presas a `127.0.0.1`.
- `postgres:18-alpine`, com volume no caminho novo da versão 18.
- `/health` e `/ready` sob `/api`, fora do contrato `/v1`.

## O que não pude verificar

Só tive leitura de arquivos, sem execução. Por isso, não verifiquei:

- se `docker compose up --build` de fato sobe a pilha (o CI sugere que sim, mas não vi o resultado das execuções);
- se existe deploy em VPS ou URL pública fora do repositório;
- o comportamento do failover do Caddy entre réplicas;
- vazão, latência e p95 sob carga (não há relatório nem script);
- se o backup existe operacionalmente fora do repositório e se a restauração funciona;
- se o R2 real e a CDN estão configurados;
- o comportamento do worker quando trava e a recuperação da fila.

```json
{
  "nota": 3,
  "justificativa": "A estrutura de execução é sólida e reproduzível: docker-compose com Postgres separado e healthcheck, migração em contêiner próprio com advisory lock, seeder idempotente, duas réplicas de API sem estado atrás do Caddy com balanceamento e failover, worker consumindo fila no Postgres com SKIP LOCKED, fotos fora da API (URL assinada para bucket S3/R2), configuração só por variáveis de ambiente com falha explícita quando falta valor, imagem com usuário sem privilégio e CI que sobe o compose inteiro e roda e2e. Porém não há deploy comprovado em URL: HTTPS, VPS, backup, teste de carga e saúde do worker estão todos pendentes no passo 13, e a configuração versionada não serve produção (Caddyfile só em :80, MAXX_SITE_ADDRESS não repassada ao contêiner, porta 443 não publicada). O backup é só documentação, a observabilidade é mínima (/health e /ready sem uso em healthcheck do compose, sem métricas, worker sem verificação), o limite de taxa é por réplica e em memória, e Postgres e worker são pontos únicos de falha. A estrutura chegaria à nota 4, mas a falta de deploy, de backup implementado e de teste de carga a mantém em 3. Não há relatório de teste de carga para este produto; a nota foi dada sem ele.",
  "evidencias": [
    {"local": "docker-compose.yml:1-3", "descricao": "Pilha completa e única instrução de execução da raiz (cp .env.example .env && docker compose up --build); o README.md da raiz tem só '# Maxx'."},
    {"local": "docker-compose.yml:17,23-29,42-44,88", "descricao": "Conexão, bucket, credenciais e chave JWT só por variável de ambiente com ':?defina no .env'; faltando valor, nada sobe."},
    {"local": "docker-compose.yml:39-52", "descricao": "Postgres 18 em serviço próprio, com volume nomeado e healthcheck pg_isready: banco separado da aplicação."},
    {"local": "docker-compose.yml:54-64", "descricao": "Contêiner de migração separado, antes das réplicas; advisory lock em apps/api/src/Maxx.Infrastructure/Persistence/DatabaseMigrator.cs:25."},
    {"local": "docker-compose.yml:81-100", "descricao": "API com replicas: 2 e restart unless-stopped, descrita como resiliência de deploy, não capacidade."},
    {"local": "docker-compose.yml:102-123", "descricao": "Worker em contêiner próprio consumindo a fila do Postgres (FOR UPDATE SKIP LOCKED em apps/api/src/Maxx.Infrastructure/Fila/ConsumidorDeTrabalhos.cs:43); uma réplica, sem healthcheck."},
    {"local": "docker-compose.yml:129-180", "descricao": "Emulador S3 (VersityGW) e configuração do bucket (policy e CORS) só no perfil armazenamento-local; em produção a troca para o R2 seria pelo .env. Fotos fora da API."},
    {"local": "infra/caddy/Caddyfile:2-3", "descricao": "Site em {$MAXX_SITE_ADDRESS::80} com o comentário 'HTTPS, HSTS e CSP entram no passo 13'; a variável não é repassada ao serviço caddy (docker-compose.yml:190-198) e só a porta 80 é publicada."},
    {"local": "infra/caddy/Caddyfile:8-18", "descricao": "Balanceamento das réplicas por DNS dinâmico (refresh 5s), round_robin, lb_try_duration 5s, fail_duration 30s."},
    {"local": "apps/api/Dockerfile:6-29", "descricao": "Build multi-stage, uma imagem para API, migrate, seed e worker, executando com USER $APP_UID."},
    {"local": "infra/caddy/Dockerfile:4-20", "descricao": "Build web do Expo embutido na imagem do Caddy com npm ci e lockfile."},
    {"local": ".env.example:1-49", "descricao": "Todas as variáveis documentadas; chave JWT vazia de propósito, com instrução de geração; .env fora do git (.gitignore:2-4)."},
    {"local": "apps/api/src/Maxx.Api/appsettings.json:1-11", "descricao": "Nenhum segredo na configuração versionada."},
    {"local": "apps/api/src/Maxx.Api/Health/HealthEndpoints.cs:11-39", "descricao": "/api/health (liveness) e /api/ready (checagem do banco, apps/api/src/Maxx.Infrastructure/DependencyInjection.cs:140-141); nenhum healthcheck do compose os usa."},
    {"local": "apps/api/src/Maxx.Api/LimiteDeTaxa/LimitesDeTaxa.cs:7-8", "descricao": "Limite de taxa em memória e por réplica; com duas réplicas, o limite efetivo pode dobrar (registrado em docs/plano-mestre.md:392)."},
    {"local": ".github/workflows/ci.yml:94-128", "descricao": "CI sobe o compose completo com chave descartável, espera /api/ready, roda seed demo e e2e Playwright, inclusive com o overlay de demonstração."},
    {"local": ".github/workflows/ci.yml:137-180", "descricao": "Gitleaks no histórico completo, auditoria NuGet e npm, build das imagens; não há job de deploy nem de publicação de imagens."},
    {"local": "docs/decisoes/README.md:28-35", "descricao": "Decisões de VPS, HTTPS/HSTS, réplicas, R2 com CDN e backup pg_dump noturno; backup e HTTPS não estão implementados no repositório."},
    {"local": "docs/plano-mestre.md:325-361", "descricao": "Passo 13 pendente: k6 a 2.000 usuários virtuais, HTTPS/CSP, R2 real, saúde do worker e alerta de fila, backup com restauração testada, ensaio na VPS."},
    {"local": "docs/plano-mestre.md:385,387", "descricao": "Riscos reconhecidos: worker morto congela o ranking sem erro visível; fila disputa I/O com o feed no pico."}
  ],
  "regras_ausentes": [],
  "decisoes_do_agente": [
    "VersityGW como emulador S3 local e na CI, ligado por perfil do compose, com dependência required: false para sumir em produção",
    "Mailpit no compose como destino de e-mail local",
    "Sub-rede fixa 172.30.0.0/24 para confiar no X-Forwarded-For só vindo do Caddy",
    "Gss Encryption Mode=Disable na connection string para evitar ruído de Kerberos no log",
    "Seeder 'seed base' como contêiner que roda a cada subida, entre a migração e as réplicas; 'seed demo' manual",
    "Caddy descobrindo réplicas por DNS dinâmico, com refresh 5s, lb_try_duration e fail_duration",
    "Build web do Expo embutido na imagem do Caddy",
    "Imagem única servindo API, migrate, seed, worker e comando administrativo de anulação, escolhida por argumento",
    "Limite de taxa em memória por réplica, sem estado compartilhado",
    "Overlay docker-compose.demo.yml para ligar a demonstração, separado do compose base",
    "Gitleaks com histórico completo e auditoria de dependências NuGet e npm no CI",
    "E2E no CI contra o compose real, nas configurações com e sem demonstração",
    "Portas do emulador e do Mailpit presas a 127.0.0.1",
    "postgres:18-alpine com volume no caminho novo da versão 18",
    "/health e /ready sob /api, fora do contrato /v1"
  ],
  "nao_verificado": [
    "Se docker compose up --build de fato sobe a pilha (o CI sugere que sim, mas os resultados das execuções não foram vistos)",
    "Existência de deploy em VPS ou URL pública fora do repositório",
    "Comportamento do failover do Caddy entre réplicas",
    "Vazão, latência e p95 sob carga: não há relatório de teste de carga nem script k6",
    "Existência operacional de backup e teste de restauração",
    "Configuração do R2 real e da CDN",
    "Comportamento do worker em falha e recuperação da fila"
  ]
}
```
