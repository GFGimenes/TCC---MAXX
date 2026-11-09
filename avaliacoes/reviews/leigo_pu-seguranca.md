# Review leigo_pu, eixo 2. Segurança

- Status: ok
- Tentativa: 1
- Commit avaliado: ce76942b7aa1ebb3a016df705972fc32483cf98f (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 45dadad1-b28b-4cc5-89c8-4a4b9255fee4

Texto do revisor, sem edição:

---
# Revisão independente — eixo 2. Segurança — `leigo_pu` @ `ce76942b`

## Nota: 2 de 5

## Justificativa

A base técnica é boa. Senhas usam scrypt com salt e `timingSafeEqual`. A sessão fica guardada no servidor, com token aleatório de 32 bytes, cookie `httpOnly` + `SameSite=Lax`, prazo de validade, e o logout apaga a sessão. Todas as consultas SQL usam parâmetros. O frontend escapa todo texto de usuário com `esc()`. Há checagem de papel nas rotas de professor e admin, e checagem de dono para apagar post, comentário, aviso e medalha. O upload só aceita JPG/PNG/WEBP de até 4 MB, servido com `nosniff`. Login e cadastro têm limite de tentativas por IP.

O problema é o controle de acesso ao papel de professor, que é o papel que mexe nos pontos dos outros. Ele depende de segredos com valor padrão fixo no código e publicados no próprio repositório:

1. **Qualquer pessoa vira professor pelo "acesso da banca".** A rota `/api/auth/banca` cria uma conta de professor sem e-mail e sem senha. Basta o código `banca2026`, que está fixo em `render.yaml:25`, `config.js:13` e `README.md:46,111`. A rota vem ligada por padrão.
2. **Contas de professor de exemplo vão para o deploy com senha publicada.** O deploy cria os dados de exemplo por padrão (`SEED_DEMO`), e o `render.yaml` não define `DEMO_PASSWORD`. Então `helena.duarte@unimax.edu.br` / `maxx123` (`README.md:40`) funciona no ar.
3. Com qualquer uma dessas contas, dá para dar medalhas de até 100 pontos a qualquer aluno da instituição, sem vínculo de turma. Ou seja: **os pontos de outro aluno podem ser alterados por request**, o que cai no critério 1 da rubrica.

Não dei 1 porque não há injeção, XSS, vazamento de e-mail de terceiros nem quebra de checagem de dono. As falhas vêm de configuração padrão insegura e de um atalho de acesso criado pelo próprio agente, não de ausência de controles. O resto bate com o critério 2 ("controle de acesso frágil, aluno chama rota de professor"): cadastro sem confirmação de e-mail, fotos acessíveis sem login, sem cota de upload.

## Evidências

- `server/config.js:9,13,15,17,19`: valores padrão fixos: `PROFESSOR-UNIMAX`, `banca2026`, `admin-unimax`, `maxx123`, dados de exemplo ligados.
- `render.yaml:23-25`: `BANCA_CODE` com valor fixo commitado; `DEMO_PASSWORD` e `SEED_DEMO` nem aparecem.
- `README.md:36-46,111,132-137`: todas as credenciais e códigos padrão documentados.
- `server/index.js:146-166`: o acesso da banca aceita `role: 'professor'`, cria conta de visitante (sessão de 7 dias), limitado só a 30 por IP a cada 10 min.
- `server/index.js:331` + `server/services.js:165-186`: `giveMedal` só confere o papel e o limite de 30 por dia por professor. Não confere se o professor dá aula para o aluno.
- `server/index.js:94-101`: `/api/img/:id` é pública, sem `requireUser`, com IDs sequenciais.
- `server/index.js:104-135`: o cadastro confere só o sufixo do domínio do e-mail. Não há confirmação de posse (o próprio `DECISOES.md:57` admite).
- `server/index.js:70`, `server/index.js:221` e `server/services.js:83-99`: corpo de até 8 MB, nenhum limite de quantidade de posts nem de volume armazenado (a regra de 3 por dia vale só para pontos).
- `server/index.js:376-387`: o professor (inclusive o visitante da banca) publica aviso para "Todos os cursos". `course_id` não é validado (um ID inexistente gera erro 500 na FK).
- `server/index.js:208,215`: `limit` negativo (`?limit=-5`) gera `LIMIT -5` e erro 500. Não é injeção, mas é entrada não tratada.
- `server/db.js:20`: TLS com o Postgres usa `rejectUnauthorized: false`, sem verificar o certificado.
- `server/auth.js:73-88`: o limite de tentativas fica num `Map` em memória que nunca é limpo e zera quando o processo reinicia.
- Pontos positivos:
  - `server/auth.js:8-20` (scrypt), `auth.js:22-33` (cookie `httpOnly`, `secure` atrás de proxy, expiração), `auth.js:57-61` (checa `expires_at`).
  - `public/app.js:15` (`esc`) aplicado de forma consistente (ex.: `app.js:622,695,704,750,755`).
  - `services.js:105,156,191` e `index.js:392` (checagem de dono).
  - `services.js:14-24` (lista de tipos de imagem e tamanho máximo).
  - `index.js:72` (`nosniff`) e `index.js:99` (CSP para SVG).
  - `index.js:415-422` (não vaza stack trace).
  - `auth.js:50` (`PUBLIC_USER_FIELDS` sem e-mail): o e-mail de terceiros não é exposto.

## Falhas reproduzíveis (descritas por leitura do código)

1. **Qualquer pessoa obtém papel de professor pelo acesso da banca e altera pontos de qualquer aluno.**
   - Reprodução: `POST /api/auth/banca` com corpo `{"name":"X","role":"professor","code":"banca2026"}` e guardar o cookie `maxx_session`. Depois `GET /api/users?role=aluno` para pegar o `id` da vítima. Depois `POST /api/medals` com `{"student_id":<id>,"type":"excelencia","reason":"x"}`: +100 pontos, até 30 vezes por dia por conta, e contas ilimitadas (30 a cada 10 min por IP).
   - Também funciona com `"role":"aluno"`: cria contas que curtem a mesma foto (+2 pontos por conta, `rules.js:7`) para inflar o ranking.
   - Local: `server/index.js:146-166`, `server/config.js:13`, `render.yaml:25`.
2. **Contas de exemplo com senha pública no deploy de produção.**
   - Reprodução: fazer o deploy pelo `render.yaml` como o README manda (nenhuma variável para `SEED_DEMO`/`DEMO_PASSWORD`). Depois `POST /api/auth/login` com `{"email":"helena.duarte@unimax.edu.br","password":"maxx123"}`, e então `POST /api/medals` a qualquer aluno, ou `POST /api/notices`.
   - Se `ADMIN_PASSWORD` ficar vazio, ou nas opções A/B do README (local ou túnel Cloudflare), `secretaria@unimax.edu.br` / `admin-unimax` dá acesso de admin: fixa avisos e apaga qualquer post ou comentário.
   - Local: `server/config.js:15,17,19`, `server/seed.js:117-137`, `README.md:36-43`.
3. **Código de professor com valor padrão público.**
   - Reprodução: se `PROFESSOR_CODE` não for definido (a opção B do README não pede), `POST /api/auth/register` com `{"name":"Fulano","email":"x@unimax.edu.br","password":"123456","role":"professor","professorCode":"PROFESSOR-UNIMAX"}` cria um professor permanente.
   - Local: `server/config.js:9`, `server/index.js:118-121`.
4. **Cadastro sem confirmação de e-mail: dá para se passar por outra pessoa e criar contas falsas.**
   - Reprodução: `POST /api/auth/register` com `email` de um aluno real que ainda não tem conta (ex.: `nome.real@aluno.unimax.edu.br`). A conta fica com o nome escolhido e a sessão abre na hora. Repetir com e-mails inventados cria contas falsas para curtidas (20 a cada 10 min por IP).
   - Local: `server/index.js:110-114,127-133`.
5. **Fotos e avatares acessíveis sem login, por enumeração.**
   - Reprodução: sem cookie nenhum, `GET /api/img/1`, `/api/img/2`, …: devolve todas as fotos e avatares de alunos, com cache público de 1 ano.
   - Local: `server/index.js:94-101`.
6. **Upload sem cota permite encher o banco.**
   - Reprodução: com qualquer conta de aluno (ou visitante da banca), repetir em loop `POST /api/posts` com `{"image":"data:image/png;base64,<~4MB>"}`. Não há limite de quantidade, e as imagens vão para o banco (`images.data BYTEA`). O plano grátis do Neon tem 0,5 GB (`DECISOES.md:15`), que acaba em ~130 requests.
   - Local: `server/index.js:70,221`, `server/services.js:83-90`.
7. **Professor dá medalha a qualquer aluno, sem vínculo de turma.**
   - Reprodução: logar como `ricardo.lima@unimax.edu.br` (Direito) e dar medalha a um aluno de Medicina via `POST /api/medals`: aceito.
   - Local: `server/services.js:165-186`.
8. **Visitante-professor publica avisos para todos os cursos.**
   - Reprodução: com a conta de professor da falha 1, `POST /api/notices` com `{"title":"Aviso oficial","body":"...","course_id":""}`: aparece no mural de todos os alunos com selo de Professor/Banca.
   - Local: `server/index.js:376-387`.
9. **Parâmetros não tratados geram erro 500.**
   - Reprodução: `GET /api/feed?limit=-5` → `LIMIT -5` → erro 500. `POST /api/notices` com `course_id: 999999` → violação de FK → erro 500.
   - Local: `server/index.js:208,215,380`.
10. **TLS com o banco sem verificar certificado.**
    - Reprodução: com `DATABASE_URL` não local, a conexão aceita qualquer certificado. Quem estiver no meio da rede pode interceptar as credenciais e os dados.
    - Local: `server/db.js:20`.

## Regras ausentes (não penalizadas)

- Login por RA. O RA não existe no modelo (`schema.sql:17-29`), então também não há exposição de RA a avaliar.
- Cadastro e vínculo via portal da instituição (SSO).
- "Esqueci minha senha".
- Medalha do professor só para alunos que ele leciona ou orienta: não há modelo de turma.
- Denúncia e revogação de prêmio marcado errado (só o professor que deu, ou o admin, retira medalha).
- Prova por foto para prêmios.
- Ex-aluno mantém acesso mas não pontua: não há status de ex-aluno.
- Cadastro de troféus e medalhas pelo corpo da faculdade (estão fixos em `rules.js`).
- Log de leitura de avisos (requisito emergente esperado como ausente na trilha leiga).
- Domínio `@unimax.com.br` da especificação: o produto usa `unimax.edu.br` por padrão, configurável.

## Decisões do agente neste eixo (sem o prompt pedir)

- Criou o "acesso da banca": conta de visitante sem e-mail e sem senha, com escolha livre de papel (inclusive professor), protegida por um código fixo `banca2026` e ligada por padrão.
- Exigiu um código de professor no cadastro (`PROFESSOR_CODE`, padrão `PROFESSOR-UNIMAX`).
- Criou um papel admin ("Secretaria") com moderação (apagar posts e comentários, fixar avisos) e senha padrão `admin-unimax`.
- Deixou dados de exemplo com contas reais de login, senha comum `maxx123`, ligados por padrão também em produção.
- Escolheu scrypt para o hash e sessão no servidor, guardada no banco, em cookie `httpOnly`/`SameSite=Lax`, válida por 30 dias (7 para visitantes).
- Criou limite de tentativas em memória por IP (20 cadastros e 30 logins a cada 10 min).
- Restringiu imagens a JPEG/PNG/WEBP de até 4 MB, guardadas no banco, e reduziu a foto no cliente.
- Limitou cada professor a 30 medalhas por dia e tornou obrigatório o motivo da medalha.
- Só alunos publicam fotos.
- Curtir a própria foto não pontua, e descurtir retira os pontos.
- Aviso filtrado por curso para alunos.
- Só o admin fixa avisos.
- Pôs cabeçalhos `X-Content-Type-Options: nosniff`, `Referrer-Policy: same-origin`, `x-powered-by` desligado, `trust proxy 1`, e CSP restrita para SVG.
- Usou TLS com o Postgres sem verificar o certificado (`rejectUnauthorized: false`).
- Deixou as imagens públicas, sem autenticação, com cache imutável.
- Pôs os visitantes da banca no ranking.
- Ao apagar uma foto, os pontos dela saem; o troféu fica.

## Não verificado (só leitura)

- Não executei nenhuma das falhas acima: os passos vêm da leitura do código.
- Não rodei `npm test` (`test/api.test.js`) nem conferi se a suíte passa.
- Não sei se o deploy existe, nem com que variáveis de ambiente foi feito (se `SEED_DEMO`, `DEMO_PASSWORD`, `BANCA_ENABLED` e `ADMIN_PASSWORD` foram trocados). A gravidade real das falhas 1 a 3 depende disso.
- Não sei se o Render aceita deixar `ADMIN_PASSWORD`/`PROFESSOR_CODE` (`sync: false`) vazios no Blueprint.
- Não testei se o Express 5 responde 413 ao passar do limite de 8 MB, nem como o PGlite/Postgres reage a `LIMIT` negativo.
- Não sei se o repositório no GitHub é público, o que exporia diretamente os códigos e senhas padrão.
- Não confirmei no navegador que nenhum ponto de `innerHTML` em `public/app.js` deixa escapar texto sem `esc()`: revisei por amostragem e busca.
- Não auditei vulnerabilidades conhecidas das dependências (`npm audit`).

```json
{
  "nota": 2,
  "justificativa": "Base técnica sólida (scrypt, sessão no servidor com cookie httpOnly/SameSite e expiração, SQL parametrizado, escape consistente no frontend, checagem de papel e de dono, tipo e tamanho de imagem restritos, limite de tentativas no login e no cadastro). Mas o papel de professor, que altera pontos de terceiros, fica ao alcance de qualquer pessoa: o 'acesso da banca' cria contas de professor só com o código fixo 'banca2026', commitado no render.yaml e no README e ligado por padrão; e o deploy cria por padrão professores de exemplo com a senha pública 'maxx123'. Com isso qualquer pessoa dá medalhas de até 100 pontos a qualquer aluno, sem vínculo de turma. Somam-se cadastro sem confirmação de e-mail (contas falsas e personificação), fotos públicas sem login por ID sequencial, upload sem cota e TLS do banco sem verificação. Não há injeção nem XSS, por isso não é 1, mas o controle de acesso é frágil (critério 2).",
  "evidencias": [
    {"local": "server/config.js:9", "descricao": "PROFESSOR_CODE com valor padrão fixo 'PROFESSOR-UNIMAX'."},
    {"local": "server/config.js:13", "descricao": "BANCA_CODE padrão 'banca2026'; acesso da banca ligado por padrão (linha 11)."},
    {"local": "server/config.js:15", "descricao": "ADMIN_PASSWORD padrão 'admin-unimax'."},
    {"local": "server/config.js:17", "descricao": "DEMO_PASSWORD padrão 'maxx123' e SEED_DEMO ligado por padrão (linha 19)."},
    {"local": "render.yaml:24", "descricao": "BANCA_CODE commitado com valor fixo banca2026; DEMO_PASSWORD e SEED_DEMO não são configurados no deploy."},
    {"local": "README.md:36", "descricao": "Tabela de contas de teste com senhas (maxx123, admin-unimax) e códigos de professor e da banca publicados (linhas 45-46)."},
    {"local": "server/index.js:146", "descricao": "POST /api/auth/banca cria conta de visitante sem e-mail e sem senha, com role 'professor' à escolha (linha 153)."},
    {"local": "server/services.js:165", "descricao": "giveMedal confere só o papel e o limite de 30 por dia; nenhum vínculo professor-aluno."},
    {"local": "server/index.js:94", "descricao": "GET /api/img/:id sem requireUser; fotos e avatares públicos por ID sequencial, Cache-Control público."},
    {"local": "server/index.js:110", "descricao": "Cadastro valida só o sufixo do domínio do e-mail; sem confirmação de posse."},
    {"local": "server/index.js:221", "descricao": "POST /api/posts sem limite de quantidade; body JSON de até 8 MB (linha 70); imagens guardadas no banco."},
    {"local": "server/index.js:376", "descricao": "Qualquer professor (inclusive visitante) publica aviso para todos os cursos; course_id não validado."},
    {"local": "server/index.js:208", "descricao": "limit negativo vira LIMIT negativo no SQL (linha 215) e gera erro 500."},
    {"local": "server/db.js:20", "descricao": "ssl { rejectUnauthorized: false } na conexão com o Postgres remoto."},
    {"local": "server/auth.js:8", "descricao": "Positivo: scrypt com salt e comparação timingSafeEqual."},
    {"local": "server/auth.js:22", "descricao": "Positivo: sessão com token de 32 bytes, cookie httpOnly, SameSite=Lax, secure atrás de proxy, expiração conferida em loadUser (linha 60)."},
    {"local": "public/app.js:15", "descricao": "Positivo: função esc() aplicada de forma consistente nos innerHTML com dados do usuário."},
    {"local": "server/services.js:105", "descricao": "Positivo: checagem de dono para apagar post, comentário (156), medalha (191) e aviso (index.js:392)."},
    {"local": "server/services.js:14", "descricao": "Positivo: tipos de imagem permitidos (jpeg/png/webp) e máximo de 4 MB; servido com nosniff (index.js:72)."},
    {"local": "server/auth.js:50", "descricao": "Positivo: PUBLIC_USER_FIELDS não inclui e-mail; e-mail de terceiros não é exposto."}
  ],
  "regras_ausentes": [
    "Login por RA (RA não existe no modelo de dados)",
    "Cadastro e vínculo via portal da instituição (SSO)",
    "Esqueci minha senha",
    "Professor só dá medalha a alunos que leciona ou orienta",
    "Denúncia e revogação de prêmio marcado errado",
    "Prova por foto para prêmios",
    "Ex-aluno mantém acesso mas não pontua",
    "Cadastro de troféus e medalhas pelo corpo da faculdade",
    "Log de leitura de avisos (quem leu e quando)"
  ],
  "decisoes_do_agente": [
    "Criar 'acesso da banca' com conta de visitante sem e-mail e senha, papel à escolha (inclusive professor), protegido por código fixo banca2026 e ligado por padrão",
    "Exigir código de professor no cadastro (PROFESSOR_CODE, padrão PROFESSOR-UNIMAX)",
    "Criar papel admin (Secretaria) com moderação e senha padrão admin-unimax",
    "Deixar dados de exemplo com contas reais de login e senha comum maxx123, ligados por padrão também no deploy",
    "Hash scrypt e sessão no servidor (tabela sessions) em cookie httpOnly/SameSite=Lax, válida por 30 dias (7 para visitantes)",
    "Limite de tentativas em memória por IP: 20 cadastros e 30 logins a cada 10 minutos",
    "Restringir imagens a JPEG/PNG/WEBP de até 4 MB, guardadas como BYTEA no banco",
    "Limite de 30 medalhas por dia por professor e motivo obrigatório",
    "Só alunos publicam fotos; curtir a própria foto não pontua; descurtir retira os pontos",
    "Avisos filtrados por curso para alunos; só o admin fixa avisos",
    "Cabeçalhos nosniff, Referrer-Policy same-origin, x-powered-by desligado, trust proxy 1 e CSP para SVG",
    "TLS com o Postgres sem verificar o certificado (rejectUnauthorized false)",
    "Imagens servidas sem autenticação e com cache público imutável",
    "Visitantes da banca entram no ranking"
  ],
  "nao_verificado": [
    "Nenhuma falha foi executada; os passos de reprodução vêm da leitura do código",
    "Suíte npm test (test/api.test.js) não rodada",
    "Variáveis de ambiente do deploy real (SEED_DEMO, DEMO_PASSWORD, BANCA_ENABLED, ADMIN_PASSWORD, PROFESSOR_CODE) e se o deploy existe",
    "Se o Render aceita deixar vazias as variáveis sync:false do Blueprint",
    "Comportamento real do Express 5 ao passar do limite de 8 MB e do PGlite/Postgres com LIMIT negativo",
    "Se o repositório no GitHub é público, o que exporia códigos e senhas padrão",
    "Ausência total de XSS confirmada só por busca e amostragem dos innerHTML, sem teste no navegador",
    "Vulnerabilidades conhecidas das dependências (npm audit)"
  ],
  "falhas": [
    {"titulo": "Qualquer pessoa obtém papel de professor pelo acesso da banca e altera pontos de qualquer aluno", "reproducao": "1) POST /api/auth/banca com {\"name\":\"X\",\"role\":\"professor\",\"code\":\"banca2026\"}; guardar o cookie maxx_session. 2) GET /api/users?role=aluno para obter o id da vítima. 3) POST /api/medals com {\"student_id\":<id>,\"type\":\"excelencia\",\"reason\":\"x\"}: +100 pts; repetir até 30 por dia por conta e criar novas contas (30 a cada 10 min por IP). Variante: role 'aluno' para criar contas que curtem a foto alvo (+2 pts cada).", "local": "server/index.js:146"},
    {"titulo": "Contas de professor e admin de exemplo com senha pública no deploy", "reproducao": "1) Fazer o deploy pelo render.yaml como o README orienta (SEED_DEMO e DEMO_PASSWORD não configurados). 2) POST /api/auth/login com {\"email\":\"helena.duarte@unimax.edu.br\",\"password\":\"maxx123\"}. 3) POST /api/medals a qualquer aluno ou POST /api/notices. Com ADMIN_PASSWORD vazio, ou nas opções A/B do README, login com secretaria@unimax.edu.br / admin-unimax dá admin (apagar qualquer post ou comentário, fixar avisos).", "local": "server/config.js:17"},
    {"titulo": "Código de professor com valor padrão público", "reproducao": "Sem PROFESSOR_CODE definido: POST /api/auth/register com {\"name\":\"Fulano\",\"email\":\"x@unimax.edu.br\",\"password\":\"123456\",\"role\":\"professor\",\"professorCode\":\"PROFESSOR-UNIMAX\"} cria um professor permanente que dá medalhas.", "local": "server/config.js:9"},
    {"titulo": "Cadastro sem confirmação de e-mail permite personificação e contas falsas", "reproducao": "POST /api/auth/register com o e-mail de um aluno real que ainda não tem conta (ex.: nome.real@aluno.unimax.edu.br), senha qualquer de 6 caracteres e course_id válido: a conta é criada e a sessão abre sem prova de posse. Repetir com e-mails inventados (20 a cada 10 min por IP) para inflar curtidas.", "local": "server/index.js:110"},
    {"titulo": "Fotos e avatares acessíveis sem login por enumeração de ID", "reproducao": "Sem cookie, fazer GET /api/img/1, /api/img/2, ... em sequência: todas as imagens de posts e avatares são devolvidas, com Cache-Control público de 1 ano.", "local": "server/index.js:94"},
    {"titulo": "Upload sem cota permite esgotar o armazenamento do banco", "reproducao": "Com qualquer conta de aluno (inclusive visitante da banca), repetir em loop POST /api/posts com {\"image\":\"data:image/png;base64,<~4MB>\"}. Não há limite de quantidade; cada request grava ~4 MB em images.data; ~130 requests esgotam os 0,5 GB do Neon grátis.", "local": "server/services.js:83"},
    {"titulo": "Professor dá medalha a qualquer aluno, sem vínculo de turma", "reproducao": "Logar como ricardo.lima@unimax.edu.br / maxx123 (Direito) e fazer POST /api/medals para um aluno de Medicina (ex.: mariana.oliveira): a medalha é aceita e os pontos são creditados.", "local": "server/services.js:165"},
    {"titulo": "Visitante-professor publica avisos para todos os cursos", "reproducao": "Com a sessão de professor obtida pela banca, POST /api/notices com {\"title\":\"Aviso oficial\",\"body\":\"...\",\"course_id\":\"\"}: o aviso aparece no mural de todos os alunos.", "local": "server/index.js:376"},
    {"titulo": "Parâmetros não tratados geram erro 500", "reproducao": "GET /api/feed?limit=-5 (gera LIMIT -5) ou POST /api/notices com course_id 999999 (violação de FK): resposta 500 'Erro interno'.", "local": "server/index.js:208"},
    {"titulo": "Conexão TLS com o banco sem verificação de certificado", "reproducao": "Com DATABASE_URL apontando para um host não local, o cliente pg é criado com ssl.rejectUnauthorized=false e aceita qualquer certificado; quem estiver no meio da rede pode interceptar credenciais e dados.", "local": "server/db.js:20"}
  ]
}
```
