# Review leigo, eixo 3. Infraestrutura

- Status: ok
- Tentativa: 1
- Commit avaliado: 2a7dad587e67aec8c45df37ce7b59c1f3eccfe2c (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 311fa8c1-b138-48d3-874a-59ba736925c2

Texto do revisor, sem edição:

---
Leitura concluída. Dei nota 3. Segue o review do eixo 3.

# Review do eixo 3. Infraestrutura, produto `leigo` (commit `2a7dad587e67`)

**Não existe relatório de teste de carga para este produto.** A nota foi dada sem ele. Isso já impede o 5, que exige teste de carga executado.

## Nota: 3 de 5

### Justificativa

O produto passa do nível 2. Tem dois caminhos de deploy por script e uma URL pública declarada. As configurações sensíveis e as que mudam por ambiente vêm de variáveis de ambiente.

Não chega ao 4 porque a rubrica pede quatro coisas e nenhuma está presente:
- **Deploy reproduzível em contêiner ou equivalente:** não há Dockerfile nem infraestrutura como código. Os scripts dependem do Windows e do Azure CLI instalado num caminho fixo.
- **Banco separado da aplicação:** o banco é SQLite embutido no mesmo processo, gravado num arquivo do disco local.
- **Backup previsto:** o README só diz "Faça backup dela".
- **Preparação para carga ou falha:** roda numa única instância. Fotos, banco e o limite de tentativas ficam no disco ou na memória do processo. Fora `console.error`, não há observabilidade.

O lado operacional do deploy no Ubuntu é cuidadoso: tem systemd com `Restart=always`, Caddy com HTTPS automático, usuário de sistema sem login, arquivo de ambiente com `umask 077`, dados fora da pasta do código e a versão anterior guardada. Isso segura a nota em 3 com folga, mas não substitui os requisitos do 4.

### Evidências

**O que existe:**
- **Instruções de execução local** (`README.md:16-27`): Node ≥ 22.13, `npm install` e `npm start`. As dependências estão declaradas em `package.json:12-18` (express e multer) e há um `package-lock.json`.
- **URL pública declarada** (`README.md:64-75`): https://maxx-guilherme.azurewebsites.net, no Azure App Service, plano gratuito F1. O próprio README avisa que o app "cochila" e que o primeiro acesso leva de 20 a 30 segundos.
- **Deploy no Azure** (`scripts/publicar-azure.ps1:11,18,22`): o script exige o `az.cmd` num caminho fixo do Windows (`C:\Program Files\...`), empacota com `tar` e envia com `az webapp deploy --type zip`. O grupo `maxx-rg` e o site `maxx-guilherme` vêm como padrão.
- **Deploy alternativo no Ubuntu** (`scripts/publicar.ps1` e `scripts/servidor.sh`):
  - instala Node 22 e Caddy (`servidor.sh:24-42`);
  - cria o usuário de sistema `maxx` (`:46`);
  - instala com `npm ci --omit=dev` (`:51`);
  - troca a pasta do código de forma quase atômica e guarda a versão anterior em `/opt/maxx.antigo` (`:52-54`);
  - grava `/etc/maxx.env` com `umask 077` (`:76-84`);
  - roda como serviço systemd com `Restart=always` (`:89-107`);
  - usa Caddy com HTTPS em `sslip.io` (`:110-118`);
  - faz uma checagem final com `curl` e, se falhar, mostra o `journalctl` (`:128-141`).
- **Variáveis de ambiente** (`src/config.js:22-30`): `ADMIN_EMAIL`, `ADMIN_SENHA`, `CODIGO_BANCA`, `PORT` e `MAXX_DADOS`. Cursos, domínios e tamanho máximo de imagem estão fixos no código (`src/config.js:9-19,31`).
- **Proteção contra senha padrão** (`src/db.js:120-122`): o app se recusa a subir em produção sem `ADMIN_SENHA`.
- **Ajuste ao ambiente** (`src/db.js:11-15`): detecta o Azure por `WEBSITE_SITE_NAME` e troca o modo de journal do SQLite de WAL para DELETE, porque lá o disco é de rede. Também define `busy_timeout`.
- **Proxy reverso** (`src/app.js:116-118`): `trust proxy` é configurado por ambiente (Azure ou loopback), e a porta é removida do IP que o proxy do Azure repassa.
- **Sessão no banco** (`src/app.js:59-72,126-130`): a sessão fica numa tabela, não na memória, então sobrevive a um restart. O cookie usa `secure` em produção.

**O que falta ou limita:**
- **Banco embutido** (`src/db.js:3,9`): SQLite (`node:sqlite`, módulo ainda experimental, com o aviso silenciado em `package.json:8`) num arquivo dentro de `PASTA_DADOS`. Não há serviço de banco separado. Isso impede rodar mais de uma instância e escalar na horizontal.
- **Fotos no disco local** (`src/app.js:15,32-36,201`): as fotos são gravadas pelo multer `diskStorage` e servidas pela própria API em `/uploads`. Não estão fora da API.
- **Estado na memória** (`src/banca.js:36`): o limite de tentativas do código da banca é um `Map`. Ele zera a cada restart e não é compartilhado entre instâncias.
- **Backup** (`README.md:72,114`): só a frase "Faça backup dela". Não há script, rotina nem procedimento de restauração.
- **Observabilidade** (`src/app.js:477`, `src/server.js:5`): só `console.error` nos erros 500. Não há log de requisição, health check nem métricas.
- **Senha em log** (`src/db.js:129`): ao criar o admin, a senha é escrita em texto claro no log (`console.log(... senha: ${config.ADMIN_SENHA})`). Em produção ela vai para o `journalctl` ou para o log stream do Azure.
- **Sessões nunca limpas** (`src/app.js:194`): a tabela `sessoes` só apaga linhas no logout. As sessões expiradas se acumulam.
- **Sem contêiner nem CI:** não há Dockerfile, docker-compose ou workflow. Os testes (`package.json:10`) não rodam em pipeline nenhum.
- **Teste de carga:** não existe relatório.

## Regras ausentes

Não penalizam a nota. Levantei estas pela leitura do README, dos modelos em `src/db.js` e das rotas em `src/app.js`. A verificação completa de cada uma cabe aos outros eixos.
- Login por RA (só e-mail).
- Tiers Bronze, Prata, Ouro e Diamante, com faixas de pontuação e progressão até o Diamante.
- Professor só dá medalha a alunos com quem tem aula.
- Rankings all-time geral e all-time por curso.
- Mural com categorias Faculdade, Curso e Professores, e log de leitura com quem leu e quando.
- Ex-aluno que mantém acesso mas não pontua mais.
- Prova por foto, denúncia e revogação de prêmio.
- "Esqueci minha senha".
- Seguidores e seguindo.
- Teste de carga.

## Decisões do agente neste eixo (sem o prompt pedir)

- Hospedar no Azure App Service, plano gratuito F1 do Azure for Students.
- Escrever um caminho alternativo para Ubuntu próprio (Oracle Cloud Always Free) com systemd e Caddy, HTTPS automático por sslip.io e liberação de portas no iptables.
- Usar SQLite embutido (`node:sqlite`) com WAL fora do Azure e DELETE no Azure.
- Guardar as fotos no disco local, na mesma pasta de dados do banco (`/home/maxx-dados` ou `/var/lib/maxx`).
- Configurar por variáveis de ambiente (`ADMIN_SENHA`, `CODIGO_BANCA`, `MAXX_DADOS`, `PORT`) e travar a subida em produção sem `ADMIN_SENHA`.
- Criar um modo "banca do TCC", ligado por variável de ambiente, com limite de tentativas em memória.
- Ajustar `trust proxy` conforme o ambiente detectado.
- Rodar o serviço com um usuário de sistema sem privilégio e guardar a versão anterior em `/opt/maxx.antigo`.
- Fixar o caminho do Azure CLI e os nomes de grupo e site no script de publicação.
- Gravar a senha do admin em texto claro no log de inicialização.

## O que não pude verificar (só leitura, sem executar)

- Se a URL https://maxx-guilherme.azurewebsites.net está no ar e corresponde a este commit.
- Se o deploy em zip no Azure instala as dependências: depende de `SCM_DO_BUILD_DURING_DEPLOYMENT` ou Oryx, configurados fora do repositório.
- Se `MAXX_DADOS=/home/maxx-dados` e `NODE_ENV=production` estão realmente definidas no portal do Azure.
- Se `scripts/servidor.sh` funciona de ponta a ponta num Ubuntu limpo.
- Se `npm install`, `npm start` e `npm test` rodam sem erro.
- Como o app se comporta sob carga e sob concorrência de escrita no SQLite em disco de rede.
- Se existe alguma rotina de backup configurada fora do repositório.

```json
{
  "nota": 3,
  "justificativa": "Há deploy numa URL pública declarada (Azure App Service F1) e um caminho alternativo por script para Ubuntu (systemd com Restart=always, Caddy com HTTPS, usuário sem privilégio, /etc/maxx.env com umask 077, versão anterior preservada). A configuração sensível e a que muda por ambiente vem de variáveis (ADMIN_SENHA, CODIGO_BANCA, MAXX_DADOS, PORT), com trava contra senha padrão em produção. Não chega ao 4: não há contêiner nem deploy reproduzível independente da máquina do autor (scripts PowerShell com caminho fixo do az.cmd), o banco é SQLite embutido no processo e no mesmo disco das fotos, não há backup além de uma frase no README e a observabilidade se resume a console.error. Fotos servidas pela própria API, rate limit em memória e banco em arquivo local impedem rodar mais de uma instância; plano F1 que hiberna. Não há relatório de teste de carga para este produto; a nota foi dada sem ele.",
  "evidencias": [
    {"local": "README.md:16-27", "descricao": "Instruções de execução local (Node >= 22.13, npm install, npm start); dependências declaradas em package.json:12-18 com package-lock.json."},
    {"local": "README.md:64-75", "descricao": "Deploy declarado em https://maxx-guilherme.azurewebsites.net (Azure F1, hiberna após ~20 min, cerca de 1 GB de dados)."},
    {"local": "scripts/publicar-azure.ps1:11-22", "descricao": "Deploy via az webapp deploy em zip; caminho do Azure CLI fixo no Windows e grupo/site fixos como padrão: depende da máquina do autor."},
    {"local": "scripts/servidor.sh:44-57", "descricao": "Código em /opt/maxx e dados em /var/lib/maxx, usuário de sistema maxx, npm ci --omit=dev, versão anterior guardada em /opt/maxx.antigo."},
    {"local": "scripts/servidor.sh:76-84", "descricao": "Configuração de produção em /etc/maxx.env com umask 077 (NODE_ENV, PORT, MAXX_DADOS, ADMIN_SENHA, CODIGO_BANCA)."},
    {"local": "scripts/servidor.sh:89-118", "descricao": "Serviço systemd com Restart=always e Caddy como proxy reverso com HTTPS automático em sslip.io."},
    {"local": "scripts/servidor.sh:128-141", "descricao": "Checagem final com curl; se falhar, mostra o journalctl."},
    {"local": "src/config.js:22-30", "descricao": "Configuração por variáveis de ambiente; cursos, domínios e tamanho máximo de imagem fixos no código (linhas 9-19 e 31)."},
    {"local": "src/db.js:120-122", "descricao": "O app se recusa a subir em produção sem ADMIN_SENHA."},
    {"local": "src/db.js:3-15", "descricao": "SQLite embutido (node:sqlite) num arquivo da pasta de dados; WAL fora do Azure e DELETE no Azure; banco não separado da aplicação."},
    {"local": "src/db.js:129", "descricao": "Senha do admin escrita em texto claro no log de inicialização."},
    {"local": "src/app.js:15,32-37,201", "descricao": "Uploads gravados em disco local pelo multer diskStorage e servidos pela própria API em /uploads: fotos não estão fora da API."},
    {"local": "src/banca.js:36", "descricao": "Limite de tentativas num Map em memória: zera no restart e não é compartilhado entre instâncias."},
    {"local": "src/app.js:59-72,126-130", "descricao": "Sessões persistidas no banco (sobrevivem a restart); cookie secure em produção."},
    {"local": "src/app.js:194", "descricao": "Sessões só são apagadas no logout; não há limpeza das expiradas."},
    {"local": "src/app.js:116-118", "descricao": "trust proxy configurado conforme o ambiente (Azure ou loopback)."},
    {"local": "src/app.js:477", "descricao": "Observabilidade limitada a console.error em erros 500; sem log de requisição, health check ou métricas."},
    {"local": "README.md:114", "descricao": "Backup só recomendado em texto ('Faça backup dela'); sem script, rotina nem restauração."},
    {"local": "raiz do repositório", "descricao": "Sem Dockerfile, docker-compose, infraestrutura como código ou workflow de CI."}
  ],
  "regras_ausentes": [
    "Login por RA (só e-mail)",
    "Tiers Bronze/Prata/Ouro/Diamante com faixas de pontos e progressão até o Diamante",
    "Professor só dá medalha a alunos com quem tem aula",
    "Rankings all-time geral e all-time por curso",
    "Categorias do mural (Faculdade, Curso, Professores) e log de leitura de avisos",
    "Ex-aluno que mantém acesso mas não pontua",
    "Prova por foto, denúncia e revogação de prêmios",
    "Esqueci minha senha",
    "Seguidores e seguindo",
    "Teste de carga executado"
  ],
  "decisoes_do_agente": [
    "Hospedar no Azure App Service, plano gratuito F1 do Azure for Students",
    "Criar deploy alternativo em Ubuntu próprio (Oracle Cloud Always Free) com systemd, Caddy, HTTPS por sslip.io e liberação de portas no iptables",
    "Usar SQLite embutido (node:sqlite) com troca de journal_mode (WAL/DELETE) conforme o ambiente",
    "Guardar as fotos no disco local, na mesma pasta de dados do banco",
    "Configurar por variáveis de ambiente e travar a subida em produção sem ADMIN_SENHA",
    "Criar o modo 'banca do TCC' ligado por variável de ambiente, com limite de tentativas em memória",
    "Ajustar trust proxy conforme o ambiente (Azure ou loopback)",
    "Rodar o serviço com usuário de sistema sem privilégio e guardar a versão anterior em /opt/maxx.antigo",
    "Fixar o caminho do Azure CLI e os nomes de grupo e site no script de publicação",
    "Escrever a senha do admin em texto claro no log de inicialização"
  ],
  "nao_verificado": [
    "Se a URL https://maxx-guilherme.azurewebsites.net está no ar e corresponde a este commit",
    "Se o deploy zip no Azure instala dependências (depende de SCM_DO_BUILD_DURING_DEPLOYMENT/Oryx, configurado fora do repositório)",
    "Se MAXX_DADOS=/home/maxx-dados e NODE_ENV=production estão definidas no portal do Azure",
    "Se scripts/servidor.sh funciona de ponta a ponta num Ubuntu limpo",
    "Se npm install, npm start e npm test rodam sem erro",
    "Comportamento sob carga e sob concorrência de escrita no SQLite em disco de rede (não há relatório de teste de carga)",
    "Existência de rotina de backup configurada fora do repositório"
  ]
}
```
