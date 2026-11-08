# Review leigo, eixo 2. Segurança

- Status: ok
- Tentativa: 1
- Commit avaliado: 2a7dad587e67aec8c45df37ce7b59c1f3eccfe2c (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 3e50e1d8-e03a-4c24-8b5e-74354bd3e874

Texto do revisor, sem edição:

---
# Revisão: eixo 2, Segurança, produto `leigo` (commit `2a7dad5`)

## Nota: 2 de 5

## Justificativa

A base técnica é boa e, sozinha, chegaria perto de 4:
- Todo SQL é parametrizado.
- As telas escapam automaticamente o que vem do usuário (`src/html.js:14-31`).
- As senhas usam scrypt com sal e comparação em tempo constante (`src/senha.js`).
- O token de sessão é aleatório, fica gravado só como hash e tem expiração (`src/app.js:49-72`, `128-130`).
- O redirecionamento só aceita caminhos internos (`src/app.js:99`).
- O upload tem limite de tamanho e de tipo e grava com nome aleatório.
- As rotas de professor e de faculdade checam o papel, e os testes cobrem os 403 (`test/fluxo.test.js:109-138, 205`).

O problema principal é o modo de ganhar o papel de professor. Ele sai do domínio do e-mail digitado no cadastro, e o app não confirma que a pessoa é dona desse e-mail (`src/app.js:158-180`, `src/config.js:11`). Qualquer pessoa, inclusive de fora da faculdade, cria `qualquercoisa@prof.unieduk.com.br` e vira professor na hora. Com isso dá medalhas que valem pontos a qualquer aluno, sem limite, e publica no mural. É exatamente o caso da nota 2 da rubrica ("aluno chama rota de professor"): um aluno abre uma segunda conta de professor e dá medalhas a si mesmo.

A mesma falta de confirmação permite:
- criar contas falsas à vontade e usá-las para curtir e inflar pontos;
- ocupar o e-mail de um colega ou de um professor antes que ele se cadastre.

Há também:
- uma senha padrão de admin no código e no README, que só é barrada quando `NODE_ENV=production`;
- nenhum limite de tentativas no login.

## Evidências

| Local | O que mostra |
|---|---|
| `src/app.js:177` + `src/config.js:9-11` | O papel `professor` é dado só pelo domínio do e-mail informado, sem confirmação de posse. |
| `src/app.js:165-172` | Cadastro: confere só o formato e o domínio do e-mail; não envia e-mail de confirmação. |
| `src/app.js:333-346` | `POST /u/:id/medalha`: qualquer professor dá qualquer medalha a qualquer aluno, quantas vezes quiser. |
| `src/regras.js:4-8`, `src/app.js:217-226` | Cada post vale +10 e cada curtida recebida +2; não há limite de frequência. |
| `src/config.js:22-23`, `README.md:27` | Senha padrão do admin `unimax-admin` no código e publicada no README. |
| `src/db.js:119-130` | A senha padrão só é barrada se `NODE_ENV=production`, e a senha do admin é escrita em texto claro no log. |
| `scripts/publicar-azure.ps1` | O deploy no Azure (a URL de produção atual) não define `NODE_ENV` nem `ADMIN_SENHA`; isso fica a cargo do portal (`README.md:75`). |
| `src/app.js:143-151` | `/entrar` sem limite de tentativas, ao contrário do código da banca (`src/banca.js:35-46`). |
| `src/app.js:146`, `172` | Enumeração de contas: a mensagem "Já existe uma conta" e a diferença de tempo (o scrypt só roda quando o usuário existe). |
| `src/app.js:31-41` | O tipo da imagem é conferido só pelo `Content-Type` que o cliente declara; não há cota por usuário. |
| `src/app.js:19`, `66-71` | Sessão de 30 dias; cookie `httpOnly`, `SameSite=Lax`, e `secure` só em produção. Sessões vencidas nunca são apagadas. |
| `src/app.js:454-461` + `src/banca.js:19` | Quem tem o código da banca entra como admin e pode promover contas reais a admin; a promoção continua depois que a banca é desligada. |
| `src/app.js:112`, `119`, `122-125` | Pontos positivos: `x-powered-by` desligado, corpo limitado a 100 kb, cabeçalhos `nosniff`, `X-Frame-Options: DENY` e `Referrer-Policy`. Não há CSP nem token CSRF; a proteção contra CSRF depende só do SameSite. |
| `src/views.js:751` | O e-mail dos outros só aparece na tela de administração. O app não guarda RA. |
| `scripts/servidor.sh:46-56`, `76-84` | Pontos positivos: usuário de sistema dedicado, pasta de dados com `chmod 700`, arquivo de configuração com `umask 077`, HTTPS pelo Caddy. |
| `src/views.js:141` | O texto do cadastro diz que professores devem pedir liberação à faculdade, o que contradiz a promoção automática por domínio. |

## Falhas reproduzíveis

1. **Qualquer pessoa vira professor sozinha.** Em `/cadastrar`, informe o e-mail `x@prof.unieduk.com.br` (não precisa existir), escolha um curso e uma senha de 8 caracteres. A conta já entra como professor. Abra `/u/<id de um aluno>` e envie `POST /u/<id>/medalha` com `tipo_id=1`: a medalha vale +50 pontos. Repita sem limite; o aluno dispara no ranking. A mesma conta publica avisos com `POST /mural`.
2. **Cadastro sem confirmar o e-mail.** Cadastre `nome.de.um.colega@unimax.edu.br`. A conta é criada sem confirmação: ocupa o e-mail do colega e permite se passar por ele. O dono real passa a receber "Já existe uma conta com esse e-mail."
3. **Pontos inflados com contas falsas e spam de posts.** Crie N contas com e-mails inventados do domínio permitido. Com cada uma, curta todos os posts do aluno-alvo (+2 por curtida; conquistas de +50 e +100 com 50 e 200 curtidas). Ou publique em série posts com legenda "a" (+10 cada; bônus de +50 aos 10 posts).
4. **Senha padrão do admin.** Se o primeiro boot acontecer sem `NODE_ENV=production` e sem `ADMIN_SENHA`, entre em `/entrar` com `admin@unimax.edu.br` / `unimax-admin`. Você ganha o painel `/admin` e promove qualquer conta. O script de deploy no Azure não garante essas variáveis.
5. **Força bruta no login.** Mande `POST /entrar` em repetição para um e-mail conhecido, testando senhas. Não há bloqueio nem atraso.
6. **Enumeração de contas.** Em `/cadastrar`, a mensagem "Já existe uma conta com esse e-mail" confirma quem está cadastrado. Em `/entrar`, e-mails inexistentes respondem mais rápido.
7. **Upload sem conferência de conteúdo e sem cota.** Envie qualquer arquivo de até 5 MB declarando `Content-Type: image/png`: ele é gravado como `.png`. Repetir isso enche o disco (cerca de 1 GB no Azure F1, `README.md:74`).
8. **Promoções feitas pela banca não são desfeitas.** Com a banca ligada, entre como "Faculdade" e envie `POST /admin/usuarios/<id da sua conta real>/papel` com `papel=admin`. Depois que `CODIGO_BANCA` é removido, a conta real continua admin.

## Regras da ideia ausentes (não penalizadas)

- Login e cadastro por RA (o app não tem campo de RA).
- "Esqueci minha senha".
- Vínculo da conta pelo portal da instituição (o cadastro aceita e-mail de domínio sem confirmar).
- Professor só dá medalha a alunos com quem tem aula ou que orienta.
- Denúncia e revogação de prêmio marcado errado.
- Prêmios que exigem prova por foto.
- Ex-aluno mantém acesso mas para de pontuar.
- Mural mostra a cada aluno só o que lhe diz respeito (categorias Faculdade, Curso, Professores).
- Log de leitura do mural (quem leu e quando).
- Cadastro de troféus e medalhas pela faculdade (os tipos são fixos na carga inicial).
- Tiers Bronze, Prata, Ouro e Diamante e progressão de prêmios.

## Decisões do agente (sem o prompt pedir, dentro deste eixo)

- Senhas com scrypt, sal aleatório e comparação em tempo constante.
- Sessões no servidor, token aleatório guardado como hash SHA-256, expiração de 30 dias, cookie `httpOnly`, `SameSite=Lax` e `secure` em produção.
- Templates que escapam tudo automaticamente contra XSS.
- Cabeçalhos `nosniff`, `X-Frame-Options: DENY` e `Referrer-Policy`; `x-powered-by` desligado.
- Proteção contra redirecionamento para fora do site (`caminhoSeguro`).
- Upload limitado a 5 MB, 1 arquivo, JPG/PNG/WEBP/GIF, nome aleatório; fotos servidas só a quem está logado.
- Papel "admin/Faculdade", com painel para trocar papéis; o admin não troca o próprio papel.
- Promoção automática a professor pelo domínio `prof.unieduk.com.br`.
- Professor e admin publicam no mural; só o admin fixa avisos; cada um apaga os próprios.
- Acesso da banca com código (mínimo 6 caracteres), limite de 10 tentativas por IP a cada 15 minutos, contas sem senha que deixam de funcionar quando a banca é desligada.
- Bloqueio da senha padrão do admin quando `NODE_ENV=production`.
- Limite de 100 kb no corpo das requisições e de tamanho em cada campo de texto.
- `trust proxy` ajustado para Azure ou loopback.
- Testes automáticos de autorização (403).
- Deploy Ubuntu com usuário de sistema dedicado, permissões 700 e 077, HTTPS via Caddy e senha do admin pedida no instalador.

## Não verificado (só leitura, sem executar nada)

- Se no Azure (`maxx-guilherme`) estão definidos `NODE_ENV=production`, `ADMIN_SENHA` e `CODIGO_BANCA`, e se a conta admin de lá usa a senha padrão.
- Se `npm run demo` foi rodado em produção; nesse caso existem contas com a senha pública `senha1234` (`scripts/demo.js:12`).
- Se o Azure força HTTPS (o cookie só ganha `secure` com `NODE_ENV=production`).
- O comportamento real do SameSite contra CSRF em cada navegador.
- Se o limite por IP da banca funciona atrás do proxy do Azure.
- Vulnerabilidades conhecidas nas versões instaladas de express e multer.
- Se os testes passam.

```json
{
  "nota": 2,
  "justificativa": "Base técnica sólida: SQL parametrizado, escape automático de HTML, scrypt com comparação em tempo constante, token de sessão guardado como hash e com expiração, proteção contra open redirect, limites de upload, checagem de papel nas rotas e testes de 403. Mas o papel de professor é dado pelo domínio do e-mail digitado no cadastro, sem confirmação de posse (src/app.js:177, src/config.js:11): qualquer pessoa, inclusive de fora da faculdade, vira professor e dá medalhas com pontos sem limite a qualquer aluno, inclusive à própria conta de aluno. É o caso 'aluno chama rota de professor' da nota 2. A falta de confirmação também permite contas falsas para inflar pontos e ocupar o e-mail de terceiros. Somam-se a senha padrão do admin no código e no README (só barrada com NODE_ENV=production, que o deploy no Azure não garante) e a ausência de limite de tentativas no login.",
  "evidencias": [
    {"local": "src/app.js:177", "descricao": "Papel 'professor' atribuído só pelo domínio do e-mail informado no cadastro, sem confirmação de posse."},
    {"local": "src/app.js:165-172", "descricao": "Cadastro confere só formato e domínio do e-mail; não envia e-mail de confirmação."},
    {"local": "src/config.js:9-11", "descricao": "Domínios permitidos e domínio de professor (prof.unieduk.com.br) que promove automaticamente."},
    {"local": "src/app.js:333-346", "descricao": "Professor dá qualquer medalha a qualquer aluno, quantas vezes quiser, sem vínculo de turma."},
    {"local": "src/regras.js:4-8", "descricao": "Post +10 e curtida recebida +2, sem limite de frequência; base da fazenda de pontos."},
    {"local": "src/config.js:22-23", "descricao": "Senha padrão do admin 'unimax-admin' no código."},
    {"local": "README.md:27", "descricao": "Senha padrão do admin publicada no README."},
    {"local": "src/db.js:119-130", "descricao": "Senha padrão só é barrada com NODE_ENV=production; a senha do admin é escrita em texto claro no log."},
    {"local": "scripts/publicar-azure.ps1:15-22", "descricao": "Deploy no Azure (produção atual) não define NODE_ENV nem ADMIN_SENHA; depende do portal."},
    {"local": "src/app.js:143-151", "descricao": "Login sem limite de tentativas; só o código da banca tem limite (src/banca.js:35-46)."},
    {"local": "src/app.js:146", "descricao": "scrypt só roda quando o usuário existe: diferença de tempo revela contas."},
    {"local": "src/app.js:172", "descricao": "Mensagem 'Já existe uma conta com esse e-mail' revela contas cadastradas."},
    {"local": "src/app.js:31-41", "descricao": "Upload: tipo conferido só pelo Content-Type declarado pelo cliente; 5 MB e 1 arquivo por requisição; sem cota por usuário."},
    {"local": "src/app.js:19", "descricao": "Sessão de 30 dias; sessões vencidas nunca são apagadas do banco."},
    {"local": "src/app.js:66-71", "descricao": "Cookie httpOnly e SameSite=Lax; secure só com NODE_ENV=production; sem token CSRF."},
    {"local": "src/app.js:122-125", "descricao": "Cabeçalhos nosniff, X-Frame-Options DENY e Referrer-Policy; sem CSP."},
    {"local": "src/html.js:14-31", "descricao": "Escape automático de toda interpolação nas telas (proteção contra XSS)."},
    {"local": "src/senha.js:3-15", "descricao": "scrypt com sal aleatório e timingSafeEqual."},
    {"local": "src/app.js:49-72", "descricao": "Token de sessão de 32 bytes aleatórios, guardado como hash SHA-256."},
    {"local": "src/app.js:99", "descricao": "caminhoSeguro impede redirecionamento para outro site."},
    {"local": "src/app.js:454-461", "descricao": "Admin (inclusive a conta da banca) muda o papel de qualquer usuário; a promoção continua depois que a banca é desligada."},
    {"local": "src/banca.js:30-46", "descricao": "Código da banca comparado em tempo constante, com limite de 10 erros por IP em 15 minutos (em memória)."},
    {"local": "src/views.js:751", "descricao": "E-mails só aparecem na tela de administração; o app não guarda RA."},
    {"local": "src/views.js:141", "descricao": "Texto do cadastro diz que professores pedem liberação à faculdade, o que contradiz a promoção automática por domínio."},
    {"local": "scripts/servidor.sh:46-84", "descricao": "Usuário de sistema dedicado, pasta de dados 700, configuração com umask 077, HTTPS via Caddy."},
    {"local": "test/fluxo.test.js:109-138", "descricao": "Testes de autorização que conferem 403 para aluno e professor em rotas restritas."}
  ],
  "regras_ausentes": [
    "Login e cadastro por RA",
    "Esqueci minha senha",
    "Vínculo da conta via portal da instituição",
    "Professor só dá medalha a alunos com quem tem aula ou que orienta",
    "Denúncia e revogação de prêmio marcado errado",
    "Prêmios que exigem prova por foto",
    "Ex-aluno mantém acesso mas não pontua",
    "Mural mostra a cada aluno só o que lhe diz respeito (categorias Faculdade, Curso, Professores)",
    "Log de leitura do mural (quem leu e quando)",
    "Cadastro de troféus e medalhas pelo corpo da faculdade",
    "Tiers Bronze, Prata, Ouro e Diamante e progressão de prêmios"
  ],
  "decisoes_do_agente": [
    "Senhas com scrypt, sal aleatório e comparação em tempo constante",
    "Sessões no servidor com token aleatório guardado como hash SHA-256 e expiração de 30 dias",
    "Cookie httpOnly, SameSite=Lax e secure só com NODE_ENV=production",
    "Mini-motor de templates com escape automático contra XSS",
    "Cabeçalhos nosniff, X-Frame-Options DENY e Referrer-Policy; x-powered-by desligado",
    "Proteção contra redirecionamento para fora do site (caminhoSeguro)",
    "Upload limitado a 5 MB, 1 arquivo e tipos JPG/PNG/WEBP/GIF, com nome aleatório, servido só a quem está logado",
    "Papel admin 'Faculdade' com painel para trocar papéis; admin não troca o próprio papel",
    "Promoção automática a professor pelo domínio de e-mail prof.unieduk.com.br",
    "Mural: professor e admin publicam, só o admin fixa, cada um apaga os próprios avisos",
    "Acesso da banca por código (mínimo 6 caracteres), com limite de tentativas por IP e contas que deixam de funcionar quando a banca é desligada",
    "Bloqueio da senha padrão do admin quando NODE_ENV=production",
    "Limite de 100 kb no corpo das requisições e de tamanho em cada campo de texto",
    "Configuração de trust proxy para Azure ou loopback",
    "Testes automáticos de autorização (403)",
    "Deploy Ubuntu com usuário de sistema dedicado, permissões restritas, HTTPS via Caddy e senha do admin pedida no instalador"
  ],
  "nao_verificado": [
    "Se o Azure tem NODE_ENV=production, ADMIN_SENHA e CODIGO_BANCA definidos, e se a conta admin de lá usa a senha padrão",
    "Se npm run demo foi rodado em produção, criando contas com a senha pública senha1234",
    "Se o Azure força HTTPS (o cookie só ganha secure com NODE_ENV=production)",
    "Comportamento real do SameSite contra CSRF em cada navegador",
    "Se o limite por IP da banca funciona atrás do proxy do Azure",
    "Vulnerabilidades conhecidas nas versões instaladas de express e multer",
    "Se a suíte de testes passa"
  ],
  "falhas": [
    {"titulo": "Qualquer pessoa se cadastra como professor e dá medalhas com pontos", "reproducao": "1) Em /cadastrar, informar o e-mail x@prof.unieduk.com.br (não precisa existir), escolher um curso e uma senha de 8 caracteres. 2) A conta já entra como professor. 3) Enviar POST /u/<id de um aluno>/medalha com tipo_id=1 (+50 pontos). 4) Repetir sem limite; o aluno sobe no ranking. A mesma conta publica avisos com POST /mural.", "local": "src/app.js:177"},
    {"title_placeholder_removed": null, "titulo": "Cadastro sem confirmar o e-mail: ocupação do e-mail de terceiros e acesso de pessoas de fora", "reproducao": "1) Em /cadastrar, usar o e-mail de um colega (ex.: nome.colega@unimax.edu.br) com qualquer senha. 2) A conta é criada sem confirmação e se passa pelo colega. 3) O dono real recebe 'Já existe uma conta com esse e-mail.'", "local": "src/app.js:165-172"},
    {"titulo": "Pontos inflados com contas falsas e spam de posts", "reproducao": "1) Criar N contas com e-mails inventados @unimax.edu.br. 2) Com cada uma, curtir os posts do aluno-alvo (+2 por curtida; conquistas de +50 e +100 com 50 e 200 curtidas). 3) Ou publicar em série posts com legenda 'a' (+10 cada; bônus de +50 aos 10 posts).", "local": "src/regras.js:4-8"},
    {"titulo": "Senha padrão do admin pública", "reproducao": "1) Subir o app pela primeira vez sem NODE_ENV=production e sem ADMIN_SENHA (o script do Azure não define nenhuma das duas). 2) Em /entrar, usar admin@unimax.edu.br / unimax-admin. 3) Acessar /admin e promover qualquer conta.", "local": "src/config.js:23"},
    {"titulo": "Login sem limite de tentativas (força bruta)", "reproducao": "Enviar POST /entrar em repetição com email=<alvo> e senhas de uma lista. Não há bloqueio nem atraso.", "local": "src/app.js:143-151"},
    {"titulo": "Enumeração de contas", "reproducao": "1) Em /cadastrar, enviar um e-mail já cadastrado: a resposta 'Já existe uma conta com esse e-mail' confirma a conta. 2) Em /entrar, comparar o tempo de resposta: e-mails inexistentes respondem mais rápido, porque o scrypt não roda.", "local": "src/app.js:172"},
    {"titulo": "Upload sem conferência de conteúdo e sem cota", "reproducao": "Enviar POST /posts com um arquivo qualquer de até 5 MB declarando Content-Type image/png. Ele é gravado como .png. Repetir em série enche o disco (cerca de 1 GB no Azure F1).", "local": "src/app.js:31-41"},
    {"titulo": "Promoções feitas pela conta da banca não são desfeitas", "reproducao": "1) Com CODIGO_BANCA ativo, entrar pela banca como 'Faculdade'. 2) Enviar POST /admin/usuarios/<id da sua conta real>/papel com papel=admin. 3) Desligar a banca: a conta real continua admin.", "local": "src/app.js:454-461"}
  ]
}
```
