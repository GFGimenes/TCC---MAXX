# Review leigo_pu, eixo 3. Infraestrutura

- Status: ok
- Tentativa: 1
- Commit avaliado: ce76942b7aa1ebb3a016df705972fc32483cf98f (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 878270ce-fc29-41d4-816c-a671db8999e7

Texto do revisor, sem edição:

---
# Revisão do eixo 3 (Infraestrutura): produto `leigo_pu`, commit `ce76942b`

**Nota: 2 de 5.** É um 2 alto. Pode subir para 3 se o avaliador confirmar uma URL publicada e funcionando.

**Teste de carga:** não há relatório de teste de carga para este produto. A nota foi dada sem ele.

## Justificativa

O produto está bem preparado para rodar fora da máquina do autor:
- **Dependências:** estão declaradas, com lockfile, e a versão do Node está fixada em `engines` e no `render.yaml`.
- **Execução local:** `npm install` e `npm start` bastam. O banco PGlite fica embutido no próprio app, então não é preciso instalar nada.
- **Instruções:** o README tem passo a passo para três caminhos: rede local, Cloudflare Tunnel e um Blueprint do Render com banco Neon.
- **Configuração:** fica toda em variáveis de ambiente, num único arquivo (`server/config.js`).
- **Banco:** o banco gerenciado (Neon) é separado da aplicação quando `DATABASE_URL` existe.
- **Saúde e sessão:** há health check (`/api/health`). As sessões ficam no banco, não na memória.

O critério que define a nota 3 é "deploy funcionando numa URL". O próprio agente declara que não publicou nem testou o deploy (`DECISOES.md:59`). O repositório não tem remoto configurado nem URL registrada em lugar nenhum. Por isso a descrição que se aplica é a da nota 2, "sem deploy". O deploy está preparado, mas não foi executado.

Outros pontos que mostram que falta pensar em falha, recuperação e carga:
- **Banco efêmero sem aviso no servidor:** sem `DATABASE_URL`, o banco cai para o disco efêmero do Render e os dados se perdem a cada reinício. Isso é só um aviso no README, sem nenhuma checagem no servidor.
- **Contas de exemplo em produção:** os dados de exemplo são criados em produção por padrão, com as contas `maxx123` e `admin-unimax` publicadas no README.
- **Valores de fallback no código:** senhas e códigos têm valor padrão escrito no código.
- **Sem backup, Docker, CI, logs estruturados nem redundância.**
- **Fotos no banco:** as fotos ficam guardadas no banco em BYTEA e são servidas pela própria API.
- **Ranking caro:** o ranking soma a tabela inteira de pontos a cada visita de perfil.
- **Limite de tentativas na memória:** o limite fica num `Map` dentro do processo, então zera ao reiniciar e não funciona com mais de uma instância.

Pelo critério do 4, nada disso está presente além das variáveis de ambiente e do banco separado.

## Evidências

| Local | O que mostra |
|---|---|
| `render.yaml:3-25` | Blueprint do Render: serviço web no plano grátis, `npm ci`, `npm start`, `healthCheckPath: /api/health`, `NODE_VERSION 22`. `DATABASE_URL`, `ADMIN_PASSWORD` e `PROFESSOR_CODE` com `sync:false`. `BANCA_CODE` fixo no arquivo (`banca2026`). |
| `DECISOES.md:59` | O agente declara: "Não publiquei o app… Não testei o deploy no Render/Neon de verdade, só localmente." |
| `.git/config:1-7` | Nenhum remoto configurado. Não há prova de que o código foi publicado. |
| `server/config.js:4-20` | Toda a configuração por variável de ambiente, mas com fallbacks no código: `PROFESSOR-UNIMAX`, `banca2026`, `admin-unimax`, `maxx123`. Se a variável faltar, o app sobe com credenciais conhecidas. |
| `server/db.js:14-40` | Usa PostgreSQL de verdade (pool `max: 5`, SSL com `rejectUnauthorized:false`) quando `DATABASE_URL` existe. Sem ela, usa PGlite no disco local `data/pglite`. Não avisa nem bloqueia o modo efêmero em produção. |
| `server/db.js:41-42` | O schema é aplicado a cada boot com `IF NOT EXISTS`. Não há ferramenta de migração nem versionamento do schema. |
| `README.md:91-93` | Avisa que o app "dorme" no plano grátis e que, sem Neon, "tudo o que for criado se perde quando o Render reiniciar". |
| `server/index.js:65` e `server/seed.js:107-121` | Os dados de exemplo são criados sempre que o banco está vazio (`SEED_DEMO` padrão `true`). O `render.yaml` não desliga isso nem define `DEMO_PASSWORD`, então a produção nasce com as contas de exemplo e as senhas publicadas no README (`README.md:36-43`). |
| `server/schema.sql:9-15` e `server/index.js:94-101` | Fotos guardadas no banco (BYTEA) e servidas pela API em `/api/img/:id`. Há um cabeçalho de cache longo (`immutable`), mas nenhuma CDN ou armazenamento de objetos. |
| `server/index.js:70` | `express.json({limit:'8mb'})`: uploads em base64 dentro do JSON, processados na memória do processo. |
| `server/auth.js:22-33` e `server/auth.js:53-65` | Sessões guardadas na tabela `sessions`, o que deixa a API sem estado de sessão. Não há limpeza das sessões expiradas. |
| `server/auth.js:72-88` | Limite de tentativas num `Map` em memória: zera ao reiniciar e não é compartilhado entre instâncias. |
| `server/services.js:200-222` | O ranking soma toda a tabela `points`, sem LIMIT nem cache. `positions()` recalcula o ranking inteiro a cada `GET /api/users/:id`. O próprio agente reconhece em `DECISOES.md:68`. |
| `server/index.js:79` | O health check responde `ok` e o tipo de banco, mas não testa a conexão com o banco. |
| `server/index.js:417` | Observabilidade limitada a `console.error` em erros 500. Não há log de requisições nem métricas. |
| `server/reset.js:6` | `npm run reset` apaga todas as tabelas no banco que estiver configurado, inclusive o de produção se `DATABASE_URL` estiver definida. Não há confirmação nem backup antes. |
| `test/api.test.js:6-16` | Os testes rodam com PGlite em memória. O caminho PostgreSQL de verdade (`pg`) não tem cobertura de teste. |
| `package.json:8-22` | `engines node >=20`, scripts `start`, `dev`, `test` e `reset`. Três dependências declaradas, com `package-lock.json` presente. |
| `public/sw.js:17-31` | O service worker busca primeiro na rede e não guarda `/api/` em cache, então não serve dado velho da API. |
| `README.md:19-32` e `README.md:59-93` | Instruções de execução local e dos três caminhos de publicação, escritas para leigo. |
| Ausência de arquivos | Não há Dockerfile, docker-compose, workflow de CI (`.github/`), `.env.example` nem política ou script de backup. |

## Regras ausentes

Não marquei nenhuma regra funcional da ideia como ausente neste eixo. A especificação não traz requisitos de infraestrutura, e as regras de produto (tiers, log de leitura e outras) são avaliadas nos outros eixos.

## Decisões do agente (sem pedido no prompt)

- Hospedar no Render, plano grátis, com Blueprint `render.yaml` e auto-deploy a cada push.
- Usar Neon como PostgreSQL gerenciado em produção e PGlite embutido no computador local, com o mesmo SQL nos dois.
- Guardar as fotos no próprio banco (BYTEA), em vez de usar armazenamento de objetos, com redução para 1080 px no cliente.
- Oferecer o Cloudflare Tunnel como alternativa de link temporário a partir do PC.
- Criar os dados de exemplo automaticamente quando o banco está vazio, ligado por padrão, inclusive em produção.
- Colocar fallbacks fixos no código para senhas e códigos (admin, demo, professor, banca).
- Fixar `BANCA_CODE=banca2026` em texto no `render.yaml`.
- Guardar as sessões no banco, com cookie `httpOnly`.
- Limitar tentativas de login e cadastro em memória, por IP.
- Usar pool de conexões com `max: 5` e SSL sem verificar o certificado.
- Criar o health check em `/api/health`.
- Configurar `trust proxy` para funcionar atrás do Render ou do Cloudflare.
- Aplicar o schema a cada boot com `IF NOT EXISTS`, em vez de usar migrações.
- Criar o script `npm run reset`, que apaga todas as tabelas.
- Fazer o app como PWA com service worker que busca primeiro na rede.
- Usar fuso fixo UTC-3 no cálculo do ranking mensal.
- Assumir a escala de um TCC ("centenas de usuários") e documentar o limite.

## O que não pôde ser verificado (só leitura)

- Se o Blueprint do Render sobe de fato com `npm ci` e `npm start` em Node 22.
- Se existe alguma URL publicada e funcionando. Nenhuma está registrada no repositório.
- Se a conexão com o Neon (`pg`, SSL) e o schema funcionam num PostgreSQL de verdade. Os testes só cobrem o PGlite em memória.
- Se `npm install` e `npm start` funcionam em máquina limpa, incluindo a compatibilidade do PGlite 0.5.x com Node 20 e 22.
- Se a suíte `npm test` passa.
- Como a API se comporta sob carga. Não há relatório de teste de carga.
- Se o Render aceita deixar `DATABASE_URL` vazio (`sync:false`) na criação do Blueprint.
- Quanto o banco cresce com fotos em BYTEA em relação ao limite de 0,5 GB do Neon grátis.

```json
{
  "nota": 2,
  "justificativa": "Produto bem preparado para rodar fora da máquina do autor: dependências declaradas com lockfile, execução local com npm install/npm start e banco embutido (PGlite), README passo a passo, configuração por variáveis de ambiente centralizada em server/config.js, Blueprint render.yaml com health check e banco gerenciado separado (Neon) via DATABASE_URL, sessões no banco. O critério que define o 3 é 'deploy funcionando numa URL', mas o agente declara que não publicou nem testou o deploy (DECISOES.md:59) e o repositório não tem remoto nem URL registrada; por isso vale a descrição do 2 ('sem deploy'). É um 2 alto, que pode subir para 3 se o avaliador confirmar uma URL publicada. Não há nada do nível 4 além das variáveis de ambiente e do banco separado: sem contêiner, sem CI, sem backup, sem migrações; sem DATABASE_URL o app cai para disco efêmero sem aviso; os dados de exemplo e os fallbacks de senha (maxx123, admin-unimax) vão para produção por padrão; fotos em BYTEA servidas pela API; ranking sem cache recalculado a cada visita de perfil; limite de tentativas em memória; observabilidade limitada a console.error. Não há relatório de teste de carga; a nota foi dada sem ele.",
  "evidencias": [
    {"local": "render.yaml:3-25", "descricao": "Blueprint do Render (plano grátis, npm ci, npm start, healthCheckPath /api/health, NODE_VERSION 22); DATABASE_URL/ADMIN_PASSWORD/PROFESSOR_CODE com sync:false; BANCA_CODE fixo no arquivo (banca2026)."},
    {"local": "DECISOES.md:59", "descricao": "Agente declara que não publicou o app e não testou o deploy no Render/Neon, só localmente."},
    {"local": ".git/config:1-7", "descricao": "Nenhum remoto configurado; não há prova de que o código foi publicado."},
    {"local": "server/config.js:4-20", "descricao": "Configuração toda por variável de ambiente, mas com fallbacks fixos no código para código de professor, código da banca, senha do admin e senha das contas de exemplo."},
    {"local": "server/db.js:14-40", "descricao": "PostgreSQL com pool max 5 e SSL rejectUnauthorized:false quando há DATABASE_URL; sem ela, PGlite no disco local data/pglite, sem aviso nem bloqueio em produção."},
    {"local": "server/db.js:41-42", "descricao": "Schema aplicado a cada boot com IF NOT EXISTS; sem ferramenta de migração nem versionamento do schema."},
    {"local": "README.md:91-93", "descricao": "Avisa que o app dorme no plano grátis e que, sem Neon, os dados se perdem quando o Render reiniciar."},
    {"local": "server/index.js:65", "descricao": "seedIfEmpty roda por padrão (SEED_DEMO=true); render.yaml não desliga, então a produção nasce com as contas de exemplo e as senhas publicadas no README.md:36-43."},
    {"local": "server/seed.js:117-121", "descricao": "Contas de exemplo e conta da secretaria criadas com as senhas da config (fallbacks maxx123 e admin-unimax)."},
    {"local": "server/schema.sql:9-15", "descricao": "Fotos guardadas no banco (tabela images, coluna BYTEA), sem armazenamento de objetos."},
    {"local": "server/index.js:94-101", "descricao": "Imagens servidas pela própria API (/api/img/:id) com Cache-Control immutable; sem CDN."},
    {"local": "server/index.js:70", "descricao": "Upload em base64 dentro do JSON, com limite de 8mb, processado na memória do processo."},
    {"local": "server/auth.js:22-65", "descricao": "Sessões na tabela sessions (API sem estado de sessão); não há limpeza das sessões expiradas."},
    {"local": "server/auth.js:72-88", "descricao": "Limite de tentativas num Map em memória: zera ao reiniciar e não é compartilhado entre instâncias."},
    {"local": "server/services.js:200-222", "descricao": "Ranking soma toda a tabela points, sem LIMIT nem cache; positions() recalcula o ranking inteiro a cada GET /api/users/:id."},
    {"local": "server/index.js:79", "descricao": "Health check responde ok e o tipo de banco, mas não testa a conexão com o banco."},
    {"local": "server/index.js:417", "descricao": "Observabilidade limitada a console.error em erros 500; sem log de requisições nem métricas."},
    {"local": "server/reset.js:6", "descricao": "npm run reset apaga todas as tabelas no banco configurado, inclusive o de produção se DATABASE_URL estiver definida; sem confirmação nem backup antes."},
    {"local": "test/api.test.js:6-16", "descricao": "Testes rodam só com PGlite em memória; o caminho PostgreSQL de verdade (pg) não tem cobertura."},
    {"local": "package.json:8-22", "descricao": "engines node >=20, scripts start/dev/test/reset, três dependências declaradas, package-lock.json presente."},
    {"local": "public/sw.js:17-31", "descricao": "Service worker busca primeiro na rede e não guarda /api/ em cache."},
    {"local": "README.md:19-93", "descricao": "Instruções de execução local e dos três caminhos de publicação (rede local, Cloudflare Tunnel, Render+Neon)."},
    {"local": "raiz do repositório", "descricao": "Não há Dockerfile, docker-compose, workflow de CI (.github/), .env.example nem política ou script de backup."}
  ],
  "regras_ausentes": [],
  "decisoes_do_agente": [
    "Hospedar no Render, plano grátis, com Blueprint render.yaml e auto-deploy a cada push",
    "Usar Neon como PostgreSQL gerenciado em produção e PGlite embutido no computador local, com o mesmo SQL",
    "Guardar as fotos no próprio banco (BYTEA) em vez de armazenamento de objetos, com redução para 1080 px no cliente",
    "Oferecer o Cloudflare Tunnel como alternativa de link temporário a partir do PC",
    "Criar os dados de exemplo automaticamente quando o banco está vazio, ligado por padrão, inclusive em produção",
    "Colocar fallbacks fixos no código para senhas e códigos (admin, demo, professor, banca)",
    "Fixar BANCA_CODE=banca2026 em texto no render.yaml",
    "Guardar as sessões no banco, com cookie httpOnly",
    "Limitar tentativas de login e cadastro em memória, por IP",
    "Usar pool de conexões com max 5 e SSL sem verificar o certificado",
    "Criar o health check em /api/health",
    "Configurar trust proxy para funcionar atrás do Render ou do Cloudflare",
    "Aplicar o schema a cada boot com IF NOT EXISTS em vez de usar migrações",
    "Criar o script npm run reset, que apaga todas as tabelas",
    "Fazer o app como PWA com service worker que busca primeiro na rede",
    "Usar fuso fixo UTC-3 no cálculo do ranking mensal",
    "Assumir a escala de um TCC (centenas de usuários) e documentar o limite"
  ],
  "nao_verificado": [
    "Se o Blueprint do Render sobe de fato com npm ci/npm start em Node 22",
    "Se existe alguma URL publicada e funcionando (nenhuma registrada no repositório)",
    "Se a conexão com o Neon (pg, SSL) e o schema funcionam num PostgreSQL de verdade; os testes só cobrem o PGlite em memória",
    "Se npm install e npm start funcionam em máquina limpa, incluindo a compatibilidade do PGlite 0.5.x com Node 20 e 22",
    "Se a suíte npm test passa",
    "Como a API se comporta sob carga; não há relatório de teste de carga",
    "Se o Render aceita deixar DATABASE_URL vazio (sync:false) na criação do Blueprint",
    "Quanto o banco cresce com fotos em BYTEA em relação ao limite de 0,5 GB do Neon grátis"
  ]
}
```
