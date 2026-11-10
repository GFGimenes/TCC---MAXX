# Review engenheiro, eixo 2. Segurança

- Status: ok
- Tentativa: 1
- Commit avaliado: 076549bbea15649813d347c2618a4b51377e6bdd (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: b2796b9e-1b93-4ff1-8c85-2b65f81336b2

Texto do revisor, sem edição:

---
# Revisão: eixo 2 (Segurança), produto `engenheiro`, commit `076549bb`

**Nota: 4 de 5**

## Justificativa

A API é sólida em autenticação, autorização e proteção de dados. O que ficou faltando é a camada de endurecimento, que o próprio plano deixou para o "passo 13" e que não foi feita. Além disso, o cadastro do aluno aceita qualquer pessoa que conheça o RA e o e-mail de outro aluno.

**Pontos fortes:**
- **Rotas fechadas por padrão.** Todo o grupo `/v1` exige login, e as rotas públicas são marcadas como tal uma a uma (`apps/api/src/Maxx.Api/Program.cs:178`, `:195`).
- **Papel e escopo separados.** O papel vem do token, por policy. O escopo do professor (turma, aluno) é sempre conferido no banco:
  - concessão de medalha (`Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:51`, `:61`);
  - decisão sobre comprovação (`Maxx.Application/PremiosParticipacao/DecidirComprovacaoHandler.cs:80-85`);
  - aviso de turma (`Maxx.Application/Mural/PublicarAviso.cs:55-65`);
  - a consulta em si (`Maxx.Infrastructure/Autorizacao/EscopoDeTurma.cs:13-40`).
- **Professor não pontua a si mesmo.** Só concede quem tem papel de professor, e só recebe quem é exclusivamente aluno (`Maxx.Domain/Premios/Medalha.cs:119-127`).
- **Senha e sessão.** Senha com Argon2id; o login falha com a mesma resposta e o mesmo tempo, exista a conta ou não (`LoginHandler.cs:19-28`). O token de acesso dura 15 minutos (`JwtOptions.cs:17`), só aceita HS256 e exige chave de pelo menos 32 bytes; sem ela a API não sobe em produção (`AutenticacaoServiceCollectionExtensions.cs:87-112`).
- **Renovação de sessão.** O refresh é rotativo por família, com detecção de reuso (`RefreshHandler.cs`). Na web vai em cookie HttpOnly, Secure, SameSite=Strict e só para o caminho de autenticação (`SessaoHttp.cs:52-60`); no app nativo, no armazenamento seguro do aparelho (`apps/mobile/src/sessao/plataforma.ts:12-14`). Trocar a senha pela recuperação derruba todas as sessões (`RecuperacaoDeSenha.cs:106-109`).
- **RA protegido.** O RA só aparece no perfil do próprio dono (`Maxx.Infrastructure/Perfil/ConsultaDePerfil.cs:81`). A busca não devolve RA nem e-mail (`PerfilEndpoints.cs:252-253`). RA e e-mail andam no corpo do pedido, nunca na URL, e não vão para o log.
- **Upload.** A foto não passa pela API. A API assina a URL prendendo o tipo (`image/jpeg`) e o tamanho exato (até 1 MiB e 200 KiB), com validade de 15 minutos (`Maxx.Domain/Fotos/UploadPendente.cs:13-20`, `:107-115`). Só o dono do upload pode usá-lo (`Post.cs:216`, `Usuario.cs:236`, `Aviso.cs:110`), e há limite de 30 pedidos por hora por usuário.
- **Entrada e banco.** Validação na borda (`AddValidation`, `StringLength`) e no domínio. Todo SQL manual é parametrizado (`FromSql`/`ExecuteSqlAsync` com interpolação; a purga executa só comandos fixos).
- **Segredos e rede.** Segredos só em variável de ambiente, com `:?` no compose. O `.env.example` traz só valores de exemplo, e há gitleaks. O proxy só é confiado vindo da sub-rede do Caddy (`ProxyConfiavel.cs`), e só a porta do Caddy é publicada.
- **Mural.** Aviso que o leitor não pode ver responde 404, e nada se descobre pelo id (`LeituraDoMural.cs:81-88`).

**Por que não é 5:**
- Encontrei falhas reproduzíveis: tomada de conta no cadastro, ausência de cabeçalhos de segurança e de HSTS/CSP, e limites de tentativa fracos com mais de uma réplica.
- O endurecimento previsto em `docs/plano-mestre.md:325-368` não foi feito: CSP, HSTS, lista de domínios de e-mail e varredura de dependências.
- A sessão não tem prazo máximo.

Nenhuma dessas falhas permite alterar dado de outro aluno pela API nem subir de papel. Por isso a nota não cai para 3.

## Falhas, com passos para reproduzir

**1. Qualquer um que saiba o RA e o e-mail de um aluno cria a conta dele.**
- Onde: `Maxx.Application/Autenticacao/Cadastro/CadastroHandler.cs:40-95` e `CadastroEndpoints.cs:30-35`.
- O cadastro só confere se o par RA e e-mail existe na mesma linha da base. Não envia confirmação por e-mail.
- Passos:
  1. Descubra o RA e o e-mail institucional de um colega que ainda não criou conta.
  2. Envie `POST /api/v1/auth/cadastro` com `{"ra":"<RA>","email":"<email>","nomeDeExibicao":"X","prefixo":"qualquer","senha":"12345678","versaoDoTermo":1}`.
  3. A resposta é 201 com uma sessão aberta. O atacante passa a postar, reivindicar prêmios e escolher o @ no nome da vítima.
- A vítima só recupera a conta pela recuperação de senha, e o @ escolhido pelo atacante fica reservado.
- O risco é conhecido: a verificação de e-mail está adiada para a fase 2 (`docs/produto.md:130-132`).
- Efeito colateral: `POST /auth/cadastro/sugestao` responde 404, 409 ou 200 e serve para testar pares RA e e-mail, limitado a 60 por minuto por IP.

**2. Sem cabeçalhos de segurança, HSTS nem CSP; a página pode ser embutida em iframe.**
- Onde: `infra/caddy/Caddyfile:2-27`.
- Passos:
  1. Suba o compose.
  2. Rode `curl -I http://<host>/`: não há `Content-Security-Policy`, `X-Frame-Options`/`frame-ancestors`, `X-Content-Type-Options`, `Strict-Transport-Security` nem `Referrer-Policy`.
  3. Uma página externa com `<iframe src="http://<host>/">` carrega o app, o que abre espaço para clickjacking.
- Sem CSP, um eventual XSS no web leria a chave do aparelho da demonstração, guardada no `localStorage` (`apps/mobile/src/demonstracao/contasDoDispositivo.web.ts:10-16`).

**3. Limite de tentativas de login enfraquecido; não há bloqueio de conta.**
- Onde: `LimiteDeTaxa/LimitesDeTaxa.cs:46-57`, `LoginEndpoints.cs:22-25` e `docker-compose.yml:94-95`.
- O limite fica na memória de cada réplica, e o compose roda 2 réplicas com distribuição alternada. A chave do limite é o texto digitado, então o RA e o e-mail do mesmo aluno contam separados.
- Passos:
  1. De vários IPs, envie `POST /api/v1/auth/login` alternando `identificador` entre o RA e o e-mail da vítima.
  2. Passam cerca de 20 tentativas por minuto por conta (5 × 2 réplicas × 2 identificadores) em vez de 5.
  3. Reiniciar a API zera os contadores.
- Agrava o quadro: a senha só exige 8 caracteres e não é comparada com listas de senhas vazadas.

**4. A sessão pode durar indefinidamente, e o token de acesso não pode ser revogado.**
- Onde: `Maxx.Domain/Identidade/FamiliaDeSessao.cs:10`, `:94` e `JwtOptions.cs:17`.
- Passos:
  1. Faça login.
  2. Renove o refresh a cada menos de 30 dias. A família continua válida para sempre, porque o prazo é renovado e não há teto absoluto.
  3. Em outro teste, depois de a instituição marcar o aluno como ex-aluno, ou depois de uma troca de senha, o token de acesso já emitido continua aceito por até 15 minutos.

**5. Com a demonstração ligada, qualquer anônimo vira aluno matriculado nas turmas reais.**
- Onde: `Maxx.Application/Demonstracao/DemonstracaoHandler.cs:63-77` e `LimitesDeTaxa.cs:53`.
- Passos:
  1. Suba com `docker-compose.demo.yml`.
  2. Envie `POST /api/v1/demo/alunos` com nome e curso, até 60 vezes por hora por IP.
  3. Cada conta entra matriculada em todas as turmas vigentes do curso, aparece para os professores reais, pode receber medalha e entrar no ranking.
- A flag vem desligada, e há purga por lote. Ainda assim, ligada no mesmo ambiente dos dados reais, mistura contas anônimas com alunos de verdade.

**6. Link de recuperação de senha pode sair em HTTP.**
- Onde: `docker-compose.yml:93` e `:111`.
- Passos:
  1. Na VPS, esqueça de definir `MAXX_URL_PUBLICA`.
  2. A API e o worker sobem com `http://localhost`, e o e-mail de recuperação leva um link inútil ou em HTTP.
- O código exige a URL fora de desenvolvimento (`AutenticacaoServiceCollectionExtensions.cs:66-77`), mas o valor padrão do compose contorna essa exigência.

## Regras ausentes (não entram na nota)
- **Vínculo pelo portal da instituição e restrição ao domínio institucional.** O produto usa uma base de elegíveis em vez do portal. A lista de domínios aceitos não existe e ficou para o passo 13 (`docs/decisoes/README.md:780`).
- **Denúncia de post pelo próprio aluno.** Só professor e instituição contestam; a denúncia pelo aluno ficou para a fase 2.
- **Consulta do registro de leitura pelo professor.** A leitura é gravada, mas não há rota para o professor ver quem leu.

## Decisões do agente sem pedido no prompt (neste eixo)
- Autenticação própria com Argon2id, token de acesso HS256 de 15 minutos e refresh rotativo por família com detecção de reuso (ADR 0006).
- Refresh em cookie HttpOnly com SameSite=Strict na web, mais um cabeçalho `X-Maxx-Cliente` exigido contra CSRF; no app nativo, armazenamento seguro do aparelho.
- Escopo de turma do professor sempre consultado no banco, nunca guardado no token.
- Limites de tentativa por IP, por identificador, por RA, por e-mail e por usuário.
- Login e recuperação de senha com a mesma resposta e o mesmo custo, para não revelar se a conta existe.
- RA visível só para o dono; RA e e-mail fora das URLs e dos logs; `ToString()` das requisições sem senha.
- Fotos enviadas direto ao bucket por URL assinada com tipo e tamanho presos; chaves aleatórias; leitura pública para quem tem o link (ADR 0002, coberta pelo termo de uso).
- Professor e instituição não se cadastram sozinhos: o primeiro acesso é pela recuperação de senha.
- Modo de demonstração atrás de uma flag, com rotas que respondem 404 quando desligado, lote e purga.
- `X-Forwarded-For` aceito só da sub-rede fixa do Caddy.
- Verificação de e-mail no cadastro adiada para a fase 2, aceitando o risco descrito na falha 1.
- Registro de quem fez e quando em concessão, decisão, anulação, correção de e-mail, ex-aluno e purga.
- Gitleaks na CI, com exceções pontuais em `.gitleaksignore`.

## O que não pude verificar (só leitura)
- Se a validação de token e o 401/403 funcionam de fato em execução, e se a suíte de testes passa.
- Se a assinatura gerada para o R2 real prende mesmo o `content-type` e o tamanho; não há prova de execução contra o R2.
- Se a instalação na VPS usa HTTPS automático do Caddy (depende de `MAXX_SITE_ADDRESS` ser um domínio) e quais cabeçalhos ela devolve.
- O resultado atual do `npm audit` e das varreduras de dependências.
- O comportamento real dos limites de tentativa com 2 réplicas e o reinício dos contadores.
- Se o front-end web tem algum ponto de XSS: não achei `dangerouslySetInnerHTML`, mas não li todos os componentes.
- A política de CORS e de leitura do bucket em produção (o compose só mostra o emulador local).

```json
{
  "nota": 4,
  "justificativa": "Autorização consistente por papel (policies no token) e por escopo (turma/aluno conferidos no banco em medalha, comprovação, aviso e lista de alunos); Argon2id, login com resposta e custo uniformes, access token de 15 min, refresh rotativo por família com detecção de reuso, cookie HttpOnly/Secure/SameSite=Strict; RA só visível ao dono; upload por URL assinada com tipo e tamanho presos, posse do upload conferida; SQL parametrizado; segredos só em variável de ambiente. Não chega a 5 porque há falhas reproduzíveis: cadastro sem verificação de e-mail permite tomar a conta de um aluno conhecendo RA+e-mail, o Caddy não tem CSP/HSTS/cabeçalhos de segurança (passo 13 não executado), limites de taxa em memória por réplica e sem bloqueio de conta, e sessão com renovação sem teto absoluto.",
  "evidencias": [
    {"local": "apps/api/src/Maxx.Api/Program.cs:178", "descricao": "Grupo /v1 com RequireAuthorization: fechado por padrão; só /auth e /demo são AllowAnonymous (linha 195 e DemonstracaoEndpoints.cs:43)."},
    {"local": "apps/api/src/Maxx.Api/Autenticacao/Politicas.cs:18-26", "descricao": "Policies por papel: aluno, professor, instituição e aprovador (professor ou instituição)."},
    {"local": "apps/api/src/Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:51-63", "descricao": "Concessão de medalha confere no banco que o professor leciona a turma e que o aluno está matriculado nela."},
    {"local": "apps/api/src/Maxx.Domain/Premios/Medalha.cs:119-127", "descricao": "Só quem tem papel de professor concede, e só quem é exclusivamente aluno recebe: não há autoconcessão."},
    {"local": "apps/api/src/Maxx.Application/PremiosParticipacao/DecidirComprovacaoHandler.cs:80-85", "descricao": "Professor só decide comprovação de aluno seu no semestre vigente (ProfessorEnsinaAlunoAsync); instituição decide qualquer uma."},
    {"local": "apps/api/src/Maxx.Infrastructure/Autorizacao/EscopoDeTurma.cs:13-40", "descricao": "Escopo de turma e de aluno consultado no banco, limitado ao semestre vigente."},
    {"local": "apps/api/src/Maxx.Application/Mural/PublicarAviso.cs:48-65", "descricao": "Papel conferido antes do escopo, e cada turma alvo conferida no banco."},
    {"local": "apps/api/src/Maxx.Application/Autenticacao/Login/LoginHandler.cs:19-28", "descricao": "Conta inexistente roda um hash falso (VerifyDummy) e recebe a mesma recusa: não há enumeração por tempo nem por resposta."},
    {"local": "apps/api/src/Maxx.Api/Autenticacao/AutenticacaoServiceCollectionExtensions.cs:87-112", "descricao": "Chave JWT só de variável de ambiente, base64 de no mínimo 32 bytes; sem ela a API não sobe fora de desenvolvimento."},
    {"local": "apps/api/src/Maxx.Api/Autenticacao/SessaoHttp.cs:52-60", "descricao": "Cookie do refresh HttpOnly, Secure, SameSite=Strict, com Path=/api/v1/auth."},
    {"local": "apps/api/src/Maxx.Application/Autenticacao/Login/RefreshHandler.cs:33-63", "descricao": "Refresh rotativo; reuso de um refresh já trocado revoga a família inteira."},
    {"local": "apps/api/src/Maxx.Infrastructure/Perfil/ConsultaDePerfil.cs:81", "descricao": "RA devolvido só quando quem lê é o próprio aluno."},
    {"local": "apps/api/src/Maxx.Domain/Fotos/UploadPendente.cs:13-20", "descricao": "Upload só image/jpeg, até 1 MiB (feed) e 200 KiB (grade), assinatura válida por 15 min; limpeza do que não for usado em 24 h."},
    {"local": "apps/api/src/Maxx.Domain/Social/Post.cs:216", "descricao": "Post só usa upload do próprio autor e da finalidade certa (idem em Usuario.cs:236 e Aviso.cs:110)."},
    {"local": "apps/api/src/Maxx.Application/Autenticacao/Cadastro/CadastroHandler.cs:83-95", "descricao": "Cadastro exige só RA+e-mail na mesma linha da base, sem confirmação por e-mail (falha 1)."},
    {"local": "infra/caddy/Caddyfile:2-27", "descricao": "Sem cabeçalhos de segurança, CSP nem HSTS; o comentário adia para o passo 13, que não foi executado."},
    {"local": "apps/api/src/Maxx.Api/LimiteDeTaxa/LimitesDeTaxa.cs:7-10,46-57", "descricao": "Limites de taxa em memória por réplica; login com 5 por minuto por identificador e 30 por minuto por IP; sem bloqueio de conta."},
    {"local": "apps/api/src/Maxx.Domain/Identidade/FamiliaDeSessao.cs:10", "descricao": "Refresh de 30 dias renovado a cada rotação, sem prazo máximo para a família."},
    {"local": "docker-compose.yml:17-29,88", "descricao": "Senhas do banco, JWT e bucket só por .env, com :? (não sobe sem elas); só a porta do Caddy é publicada."},
    {"local": "apps/api/src/Maxx.Infrastructure/Instituicao/PurgaDaDemonstracao.cs:69-102", "descricao": "SQL manual parametrizado por interpolação do EF; o ExecuteSqlRaw executa só comandos fixos."},
    {"local": "docs/plano-mestre.md:325-368", "descricao": "Passo 13 (CSP, HSTS, lista de domínios, varredura de dependências) previsto e não realizado no commit avaliado."}
  ],
  "regras_ausentes": [
    "Vínculo da conta pelo portal da instituição e restrição ao domínio institucional (@unimax.com.br): o produto usa uma base de elegíveis, e a lista de domínios aceitos não existe",
    "Denúncia de post pelo próprio aluno (só professor e instituição contestam; a denúncia ficou para a fase 2)",
    "Consulta do log de leitura de avisos pelo professor (a leitura é gravada, mas não há rota de consulta)"
  ],
  "decisoes_do_agente": [
    "Autenticação própria com Argon2id, access token HS256 de 15 minutos e refresh rotativo por família com detecção de reuso (ADR 0006)",
    "Refresh em cookie HttpOnly com SameSite=Strict e caminho restrito na web, mais o cabeçalho X-Maxx-Cliente contra CSRF; no nativo, armazenamento seguro do aparelho",
    "Escopo de turma do professor sempre consultado no banco, nunca guardado no token",
    "Limites de taxa por IP, identificador, RA, e-mail e usuário, por réplica e em memória",
    "Respostas e custo uniformes no login e na recuperação de senha, para não revelar se a conta existe",
    "RA visível só ao dono; RA e e-mail nunca na URL nem no log; ToString() das requisições sem dados sensíveis",
    "Fotos enviadas direto ao bucket por URL assinada com tipo e tamanho presos, chaves aleatórias e leitura pública por link (ADR 0002)",
    "Professor e instituição sem autocadastro: primeiro acesso pela recuperação de senha",
    "Modo de demonstração atrás de flag desligada por padrão (rotas inexistentes = 404), com lote e purga",
    "Cabeçalhos X-Forwarded aceitos só da sub-rede fixa do Caddy",
    "Verificação de e-mail no cadastro adiada para a fase 2, aceitando o risco de alguém criar a conta de outro aluno",
    "Registro de quem fez e quando em concessão, decisão, anulação, correção de e-mail, ex-aluno e purga",
    "Gitleaks na CI, com exceções pontuais por commit e linha"
  ],
  "nao_verificado": [
    "Comportamento real da validação de JWT e das respostas 401/403 em execução, e se a suíte de testes passa",
    "Se a assinatura gerada para o R2 real prende content-type e tamanho (VerificacaoDoR2Tests não executado)",
    "Configuração da VPS: HTTPS automático do Caddy (depende de MAXX_SITE_ADDRESS) e cabeçalhos efetivamente devolvidos",
    "Resultado atual do npm audit e de varreduras de dependências",
    "Comportamento efetivo dos limites de taxa com 2 réplicas e reinício",
    "Ausência de XSS em todos os componentes do front-end (não achei dangerouslySetInnerHTML, mas não li todos)",
    "Política de CORS e de leitura do bucket em produção (só o emulador local está no compose)"
  ],
  "falhas": [
    {"titulo": "Criação da conta de outro aluno conhecendo só RA e e-mail (sem verificação de e-mail)", "reproducao": "1) Obter o RA e o e-mail institucional de um aluno da base que ainda não tem conta. 2) POST /api/v1/auth/cadastro com {\"ra\":\"<RA>\",\"email\":\"<email>\",\"nomeDeExibicao\":\"X\",\"prefixo\":\"qualquer\",\"senha\":\"12345678\",\"versaoDoTermo\":1}. 3) Resposta 201 com sessão: o atacante age como o aluno (posta, reivindica prêmios, escolhe o @). A vítima só recupera pela recuperação de senha. Variante: POST /api/v1/auth/cadastro/sugestao responde 404, 409 ou 200 e serve para testar pares RA+e-mail (60 por minuto por IP).", "local": "apps/api/src/Maxx.Application/Autenticacao/Cadastro/CadastroHandler.cs:83"},
    {"titulo": "Sem CSP, HSTS, X-Frame-Options e X-Content-Type-Options: página embutível em iframe", "reproducao": "1) docker compose up. 2) curl -I http://<host>/ e curl -I http://<host>/api/health: nenhum cabeçalho de segurança. 3) Uma página externa com <iframe src=\"http://<host>/\"> carrega o app (clickjacking). Sem CSP, um XSS leria a chave do aparelho da demonstração no localStorage.", "local": "infra/caddy/Caddyfile:3"},
    {"titulo": "Limite de tentativas de login enfraquecido por réplicas e por identificador; sem bloqueio de conta", "reproducao": "1) Com o compose padrão (2 réplicas da API, round robin), enviar POST /api/v1/auth/login alternando identificador entre o RA e o e-mail da mesma vítima, a partir de vários IPs. 2) Passam cerca de 20 tentativas por minuto por conta em vez de 5. 3) Reiniciar a API zera os contadores. Não há bloqueio, e a senha mínima é de 8 caracteres sem checagem de vazamento.", "local": "apps/api/src/Maxx.Api/LimiteDeTaxa/LimitesDeTaxa.cs:48"},
    {"titulo": "Sessão sem prazo máximo e access token não revogável", "reproducao": "1) Fazer login. 2) Chamar POST /api/v1/auth/refresh a cada menos de 30 dias: a família continua válida para sempre. 3) A instituição marca o aluno como ex-aluno, ou o aluno troca a senha: o access token já emitido continua aceito em /api/v1/* por até 15 minutos.", "local": "apps/api/src/Maxx.Domain/Identidade/FamiliaDeSessao.cs:10"},
    {"titulo": "Demonstração ligada permite a anônimos criar alunos matriculados nas turmas reais", "reproducao": "1) Subir com docker-compose.demo.yml (Demo__Habilitada=true). 2) POST /api/v1/demo/alunos com {\"nome\":\"Fulano\",\"curso\":\"<sigla>\",\"versaoDoTermo\":1}, até 60 vezes por hora por IP. 3) Cada conta é matriculada em todas as turmas vigentes do curso, aparece na lista de alunos do professor real e pode receber medalha e entrar no ranking.", "local": "apps/api/src/Maxx.Application/Demonstracao/DemonstracaoHandler.cs:63"},
    {"titulo": "URL pública do e-mail de recuperação com padrão http://localhost no compose", "reproducao": "1) Na VPS, não definir MAXX_URL_PUBLICA no .env. 2) A API e o worker sobem com App__UrlPublica=http://localhost (o padrão do compose contorna a exigência do código). 3) POST /api/v1/auth/recuperacao com um e-mail válido: o link enviado aponta para http://localhost, inútil ou sem HTTPS.", "local": "docker-compose.yml:93"}
  ]
}
```
