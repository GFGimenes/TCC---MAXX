# Review engenheiro, eixo 2. Segurança

- Status: a conferir (acessos fora das pastas liberadas: Read: C:\Users\Guilherme Gimenes\.claude\projects\C--Users-Guilherme-Gimenes-AppData-Local-Temp-avaliador-tcc-engenheiro-8910b51ae7b0-20261110-171112-fa29-sessao-seguranca-t1\b65bf3f1-02f3-4f27-af54-5e839afc91c6\tool-results\toolu_01BW3QPfuveuNchD4FJXJTmZ.txt)
- Tentativa: 1
- Commit avaliado: 8910b51ae7b0ca10582517ead72ee832746683a3 (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: b65bf3f1-02f3-4f27-af54-5e839afc91c6

Texto do revisor, sem edição:

---
# Revisão de Segurança: produto `engenheiro` (commit `8910b51a`)

## Nota: 4 de 5

A segurança é um ponto forte deste produto. O controle de acesso é fechado por padrão, e o escopo do professor é conferido no banco a cada ação, nunca lido do token. As sessões usam tokens curtos com renovação rotativa, e as senhas usam Argon2id. Não há segredos no código, o upload de fotos é limitado e os dados sensíveis estão protegidos. Não encontrei IDOR, injeção nem rota de professor acessível a aluno.

A nota não é 5 por três motivos:
- **Tomada de conta pelo cadastro:** qualquer pessoa que saiba o RA e o e-mail institucional de um colega pode criar a conta dele antes dele. O cadastro não verifica se a pessoa é dona do e-mail. O agente adiou isso para a "fase 2" e registrou a decisão nos documentos.
- **Menor privilégio no banco:** a API usa o mesmo usuário do Postgres que cria o banco.
- **Limites de taxa por réplica:** ficam na memória de cada réplica e, com duas réplicas, valem o dobro.

## Evidências principais (o que está bem feito)

**Acesso fechado por padrão**
- Toda rota `/v1` exige login (`apps/api/src/Maxx.Api/Program.cs:178`).
- As rotas públicas são explícitas: autenticação (`Program.cs:195`), termo de uso e demonstração.
- Há políticas por papel em `Autenticacao/Politicas.cs:22-25`, aplicadas por grupo:
  - professor: `Medalhas/ProfessorEndpoints.cs:19`
  - instituição: `Instituicao/InstituicaoEndpoints.cs:21,86,92`
  - quem aprova comprovações: `PremiosParticipacao/ComprovacaoEndpoints.cs:19`

**Quem dá medalha a quem**
- O professor precisa lecionar a turma no semestre vigente, e isso é conferido no banco (`Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:51-55`).
- O aluno precisa estar matriculado naquela turma (`ConcederMedalhaHandler.cs:61-63`).
- Pontos e tier vêm do catálogo; ninguém digita valor (`ProfessorEndpoints.cs:113`).
- Aprovar comprovação e contestar prêmio seguem a mesma regra (`DecidirComprovacaoHandler.cs:80-85`, `ContestacaoHandler.cs:35-39`). A decisão final da contestação é só da instituição (`ContestacaoHandler.cs:130-133`).

**Posse dos dados (sem IDOR)**
- Post: o upload e o prêmio têm de ser do autor (`Maxx.Domain/Social/Post.cs:120,133,146,216`).
- Remover comentário confere se ele é do post e se quem remove pode remover (`Maxx.Application/Social/Social.cs:159-165`).
- Aviso alheio responde 404, e só se registra leitura do que a pessoa vê (`Maxx.Application/Mural/LeituraDoMural.cs:83-88`).

**Dados sensíveis**
- O RA só aparece no próprio perfil do aluno (`Maxx.Infrastructure/Perfil/ConsultaDePerfil.cs:81`). RA e e-mail completos só na área da instituição (`InstituicaoEndpoints.cs:259-287`).
- RA e e-mail vão no corpo da requisição, nunca na URL (`CadastroEndpoints.cs:8-9`).
- Os limites de taxa não registram dados pessoais no log (`LimitesDeTaxa.cs:64`).
- Respostas que dependem de quem pede usam `Cache-Control: private` (`PerfilEndpoints.cs:181`).

**Login e senha**
- Argon2id com os parâmetros recomendados pela OWASP (`Argon2idSenhaHasher.cs:9-18`).
- Mesma resposta e mesmo custo de tempo exista a conta ou não, para não revelar quem tem conta (`LoginHandler.cs:19-28`).
- `ToString` sobrescrito para a senha nunca ir parar em log (`LoginEndpoints.cs:105`, `CadastroHandler.cs:126`).

**Sessão**
- O token de acesso dura 15 minutos (`JwtOptions.cs:17`) e só aceita o algoritmo HS256 (`AutenticacaoServiceCollectionExtensions.cs:45`).
- O token de renovação é trocado a cada uso; reutilizar um já trocado derruba toda a sessão (`Maxx.Domain/Identidade/FamiliaDeSessao.cs:48-72`).
- No navegador, ele fica num cookie HttpOnly, Secure, SameSite=Strict, restrito a `/api/v1/auth` e lido só com o cabeçalho `X-Maxx-Cliente` (`SessaoHttp.cs:37-60`).
- O link de recuperação de senha vale uma vez, leva 256 bits aleatórios (`TokenGenerator.cs:13-18`), vai depois do `#` da URL, que o navegador não envia ao servidor (`RecuperacaoEndpoints.cs:58-63`), e derruba todas as sessões ao trocar a senha.

**Segredos**
- A chave do JWT é obrigatória fora do ambiente de desenvolvimento; em desenvolvimento, é gerada a cada execução e nunca gravada (`AutenticacaoServiceCollectionExtensions.cs:95-120`).
- Os arquivos de compose usam `${VAR:?}` (`docker-compose.producao.yml`), que impede a subida sem o valor.
- `.env.example` só traz valores de exemplo.
- A CI roda gitleaks, trivy e npm audit (`.github/workflows/ci.yml:146-205`).

**Upload de fotos**
- Só aceita JPEG, até 1 MiB (feed) e 200 KiB (miniatura) (`Maxx.Domain/Fotos/UploadPendente.cs:13-17,107-115`).
- O tamanho e o tipo ficam presos na assinatura do link de envio (`Maxx.Infrastructure/Fotos/ArmazenamentoS3.cs:35-41`).
- Os nomes dos arquivos são aleatórios, e o servidor confere se o arquivo chegou antes de publicar (`Posts.cs:170-176`).
- Envios não confirmados são apagados depois (`Uploads.cs:54`), e há limite de 30 envios por hora (`LimitesDeTaxa.cs:56`).

**Borda (Caddy e contêiner)**
- CSP rígida, HSTS, `nosniff`, bloqueio de iframe (`X-Frame-Options DENY`) e COOP (`infra/caddy/Caddyfile:15-28`).
- `X-Forwarded-For` só é aceito vindo da rede do Caddy (`Autenticacao/ProxyConfiavel.cs`), e só o Caddy expõe portas.
- O contêiner roda sem root (`apps/api/Dockerfile:32`).

## Falhas encontradas (com reprodução)

1. **Tomada de conta pelo cadastro (gravidade média).** `CadastroHandler.cs:41-79` cria a conta e abre a sessão (linha 63) só porque o RA e o e-mail estão na mesma linha da base, sem confirmar que a pessoa é dona do e-mail. O e-mail segue o padrão `nome.sobrenome@al.unieduk.com.br`, fácil de adivinhar. A decisão está em `docs/produto.md:133-135`, e o próprio documento admite o risco para professores (linhas 144-145).
   - Reprodução: descobrir o RA de um colega que ainda não se cadastrou (pela lista da turma, por exemplo). Enviar `POST /api/v1/auth/cadastro` com `{ra, email, nomeDeExibicao, prefixo, senha, versaoDoTermo}`. A resposta é 201 com sessão. A vítima depois recebe "conta existente" e precisa recuperar a senha pelo e-mail.

2. **Consulta que confirma pares RA/e-mail.** `POST /api/v1/auth/cadastro/sugestao` responde 200 para um par válido sem conta, 404 para um par inexistente e 409 para quem já tem conta (`CadastroHandler.cs:85-101`). O limite é só por IP, 60 por minuto (`LimitesDeTaxa.cs:51`).
   - Reprodução: com um e-mail conhecido, variar o RA em várias requisições, trocando de IP, até receber 200 ou 409. O resultado alimenta a falha 1.

3. **Limite de taxa vale o dobro.** Ele fica na memória de cada réplica (`LimitesDeTaxa.cs:7-9`), e o Caddy alterna as requisições entre duas réplicas (`Caddyfile:31-41`, `docker-compose.producao.yml:88-89`).
   - Reprodução: enviar 10 `POST /auth/login` seguidos com o mesmo identificador. A expectativa pela distribuição é que cerca de 10 passem antes do 429, e não 5.

4. **API sem menor privilégio no banco.** A API, o worker e o migrator usam o mesmo `POSTGRES_USER` que cria o banco (`docker-compose.producao.yml:26,43-45`).
   - Reprodução: ler o compose e ver que a connection string das réplicas usa o dono do banco. Um eventual SQL injection teria permissão de DDL. Não encontrei nenhum, porque o acesso é via EF Core.

5. **O conteúdo das fotos não é validado no servidor.** Só o tipo e o tamanho declarados ficam presos na assinatura; os bytes não são conferidos como JPEG. Remover os metadados EXIF (que podem trazer GPS) depende do app (`UploadPendente.cs:107-115`, ADR 0003).
   - Reprodução: pedir `POST /api/v1/uploads` com `tipoDeConteudo: image/jpeg` e `tamanhoDoFeed = N`, depois fazer `PUT` na URL assinada com N bytes de outro formato, ou um JPEG com GPS. Publicar o post: a "foto" fica pública na CDN.

6. **Sessão renovável sem prazo máximo.** Cada renovação dá mais 30 dias, sem teto absoluto (`FamiliaDeSessao.cs:9-10`, decisão registrada).
   - Reprodução: renovar o token pelo menos uma vez a cada 30 dias e a sessão nunca expira.

7. **Modo demonstração: contas anônimas veem dados reais.** Com a demonstração ligada (`docker-compose.demo.yml`), `POST /api/v1/demo/alunos` é público (`DemonstracaoEndpoints.cs:43-57`) e cria um aluno de verdade, matriculado nas turmas vigentes. Ele vê o feed, a busca e os perfis reais. A chave que reabre essa conta não expira e, no navegador, fica no `localStorage` (`apps/mobile/src/demonstracao/contasDoDispositivo.web.ts:16`). O risco é limitado: o modo vem desligado, é intencional para a banca e existe purga por lote.
   - Reprodução: subir com `docker-compose.demo.yml` e enviar `POST /api/v1/demo/alunos {nome, curso, versaoDoTermo}` sem login. A sessão é emitida.

8. **Menores:**
   - O `ToString` do `CadastroRequest` inclui o RA (`CadastroEndpoints.cs:80`); se o objeto for logado, o RA vai para o log.
   - `/api/health/worker` é público e mostra contagens da fila (`HealthEndpoints.cs:23`). Não expõe dados pessoais.

## Regras ausentes (não pesam na nota)

- Cadastro e vínculo pelo portal da instituição (SSO). Foi trocado por uma base de elegíveis vinda de seed ou CSV, mais verificação de RA e e-mail.
- Verificação de e-mail no cadastro (adiada para a fase 2).
- Denúncia de prêmio pelo aluno. A contestação existe, mas só professor e instituição podem abrir.

## Decisões do agente sem pedido no prompt (eixo Segurança)

- Autenticação própria: JWT HS256 de 15 minutos, token de renovação rotativo com detecção de reuso, Argon2id com parâmetros OWASP (ADR 0006).
- Cookie HttpOnly, Secure, SameSite=Strict, restrito ao caminho `/api/v1/auth` e lido só com o cabeçalho `X-Maxx-Cliente`, contra CSRF. No app nativo, a renovação fica no SecureStore.
- Mesma resposta e mesmo custo de tempo no login com a conta inexistente, para não revelar quem tem conta.
- Limites de taxa por identificador, IP, RA, e-mail, envio de fotos e demonstração.
- Confiança no `X-Forwarded-For` só vinda da sub-rede do Caddy.
- Escopo de turma do professor sempre conferido no banco, nunca no token.
- RA exposto só ao próprio aluno e à instituição.
- Upload por link assinado com tipo e tamanho presos, nomes aleatórios e limpeza de envios não confirmados.
- Link de recuperação depois do `#` da URL, de uso único, derrubando todas as sessões ao trocar a senha.
- Contas de professor e instituição sem senha, com primeiro acesso só pela recuperação de senha.
- Termo de uso versionado, com o aceite registrado.
- CSP, HSTS e demais cabeçalhos no Caddy.
- Modo demonstração desligado por padrão, com lote obrigatório e purga.
- gitleaks, trivy e npm audit na CI; contêiner sem root.
- Chave JWT obrigatória fora do ambiente de desenvolvimento.
- `ToString` sobrescrito para não logar senhas e tokens.
- Verificação de e-mail adiada conscientemente para a fase 2.

## O que não pude verificar (só leitura, sem executar)

- Que os testes de autorização passam (há cerca de 68 asserções de 403 em `apps/api/tests`, mas não rodei).
- As consultas SQL de escopo dentro de `EscopoDeTurma.cs` e `ConsultaDoMural.cs`: confiei nas interfaces e nos comentários.
- A política real do bucket R2 e da CDN em produção (leitura pública sem listagem, CORS) e os cabeçalhos que a CDN devolve.
- O comportamento do Caddy e do limite de taxa com duas réplicas em execução.
- Se o `seed demo` foi rodado em produção e que contas de seed sem senha estão de fato bloqueadas.
- A proteção da chave da conta R2 e do `.env` na VPS.
- O comportamento do app web e nativo em execução (XSS e armazenamento real).

```json
{
  "nota": 4,
  "justificativa": "Autorização fechada por padrão (/v1 RequireAuthorization) com policies por papel e escopo de turma do professor sempre conferido no banco; posse checada no domínio (post, upload, prêmio, comentário, aviso); RA exposto só ao próprio aluno e à instituição; Argon2id com resposta uniforme no login; access JWT de 15 min e refresh rotativo com detecção de reuso em cookie HttpOnly/Secure/SameSite=Strict; segredos só por variável de ambiente e varridos na CI; upload limitado em tipo, tamanho e taxa por assinatura; CSP, HSTS e cabeçalhos na borda. Não chega a 5 porque há falha reproduzível: o cadastro do aluno não verifica posse do e-mail, e quem sabe RA e e-mail de um colega cria a conta dele (decisão documentada, adiada para a fase 2). Também falta menor privilégio no banco (a API usa o superusuário do Postgres), o limite de taxa é por réplica em memória e o conteúdo das fotos não é validado no servidor.",
  "evidencias": [
    {"local": "apps/api/src/Maxx.Api/Program.cs:178", "descricao": "Grupo /v1 com RequireAuthorization: fechado por padrão; públicas só auth, termo e demo (linha 195)."},
    {"local": "apps/api/src/Maxx.Api/Autenticacao/Politicas.cs:22", "descricao": "Policies por papel (aluno, professor, instituição, aprovador) aplicadas por grupo nas rotas."},
    {"local": "apps/api/src/Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:51", "descricao": "Professor só concede medalha em turma que leciona no semestre vigente (banco) e a aluno matriculado nela (linha 61)."},
    {"local": "apps/api/src/Maxx.Application/PremiosParticipacao/DecidirComprovacaoHandler.cs:80", "descricao": "Aprovação ou reprovação de comprovação só por instituição ou professor que ensina o aluno."},
    {"local": "apps/api/src/Maxx.Domain/Social/Post.cs:146", "descricao": "Medalha, conquista, prêmio e upload têm de ser do autor do post (linhas 120, 133, 216)."},
    {"local": "apps/api/src/Maxx.Infrastructure/Perfil/ConsultaDePerfil.cs:81", "descricao": "RA só devolvido quando o leitor é o próprio aluno."},
    {"local": "apps/api/src/Maxx.Application/Autenticacao/Login/LoginHandler.cs:19", "descricao": "Conta inexistente roda VerifyDummy: mesma resposta e mesmo custo de Argon2id."},
    {"local": "apps/api/src/Maxx.Infrastructure/Autenticacao/Argon2idSenhaHasher.cs:9", "descricao": "Argon2id 19 MiB, t=2, p=1, comparação em tempo constante."},
    {"local": "apps/api/src/Maxx.Domain/Identidade/FamiliaDeSessao.cs:48", "descricao": "Refresh rotativo; reuso derruba a família. Validade de 30 dias renovável, sem teto absoluto (linha 9)."},
    {"local": "apps/api/src/Maxx.Api/Autenticacao/SessaoHttp.cs:52", "descricao": "Cookie do refresh HttpOnly, Secure, SameSite Strict, Path /api/v1/auth; só lido com o cabeçalho X-Maxx-Cliente."},
    {"local": "apps/api/src/Maxx.Api/Autenticacao/AutenticacaoServiceCollectionExtensions.cs:95", "descricao": "Chave JWT só por variável de ambiente; sem ela a API não sobe fora de desenvolvimento."},
    {"local": "apps/api/src/Maxx.Domain/Fotos/UploadPendente.cs:107", "descricao": "Upload aceita só image/jpeg até 1 MiB e 200 KiB, mas pelo valor declarado; os bytes não são inspecionados."},
    {"local": "apps/api/src/Maxx.Infrastructure/Fotos/ArmazenamentoS3.cs:41", "descricao": "Content-Length e Content-Type presos na assinatura do PUT."},
    {"local": "infra/caddy/Caddyfile:15", "descricao": "CSP restritiva, nosniff, X-Frame-Options DENY, COOP e HSTS em HTTPS."},
    {"local": "apps/api/src/Maxx.Application/Autenticacao/Cadastro/CadastroHandler.cs:63", "descricao": "Sessão aberta no cadastro sem verificar a posse do e-mail; produto.md:133 adia a verificação para a fase 2."},
    {"local": "docker-compose.producao.yml:26", "descricao": "API, worker e migrator usam o mesmo usuário dono do Postgres (linhas 43-45): sem menor privilégio."},
    {"local": "apps/api/src/Maxx.Api/LimiteDeTaxa/LimitesDeTaxa.cs:7", "descricao": "Limites em memória por réplica; com 2 réplicas em round robin o limite efetivo dobra."},
    {"local": ".github/workflows/ci.yml:146", "descricao": "gitleaks no histórico, npm audit e trivy nas imagens na CI."},
    {"local": "apps/api/Dockerfile:32", "descricao": "Contêiner roda como usuário sem privilégio ($APP_UID)."}
  ],
  "regras_ausentes": [
    "Cadastro e vínculo via portal da instituição (SSO): substituído por base de elegíveis via seed/CSV com RA e e-mail na mesma linha",
    "Verificação de posse do e-mail institucional no cadastro (adiada para a fase 2)",
    "Denúncia de prêmio pelo aluno: a contestação existe, mas só professor e instituição podem abrir"
  ],
  "decisoes_do_agente": [
    "Autenticação própria com JWT HS256 de 15 min e refresh opaco rotativo com detecção de reuso por família (ADR 0006)",
    "Hash de senha Argon2id com parâmetros OWASP e verificação fictícia para igualar tempo de resposta",
    "Refresh em cookie HttpOnly/Secure/SameSite=Strict limitado a /api/v1/auth e exigência do cabeçalho X-Maxx-Cliente contra CSRF; no nativo, SecureStore",
    "Limites de taxa por identificador, IP, RA, e-mail, upload e registro de demonstração",
    "Confiança em X-Forwarded-For só vinda da sub-rede do Caddy",
    "Escopo de turma do professor conferido no banco a cada ação, nunca no token",
    "RA exposto apenas ao próprio aluno e à instituição; RA e e-mail sempre no corpo, nunca na URL",
    "Upload direto ao bucket por URL assinada com tipo e tamanho presos, chaves aleatórias e limpeza de upload não confirmado",
    "Token de recuperação de 256 bits no fragmento da URL, uso único, que revoga todas as sessões",
    "Contas de professor e instituição sem autocadastro, com primeiro acesso pela recuperação de senha",
    "Termo de uso versionado com aceite registrado",
    "CSP, HSTS e cabeçalhos de segurança no Caddy",
    "Modo demonstração desligado por padrão, ativado só por compose próprio, com lote obrigatório e purga",
    "gitleaks, trivy e npm audit na CI; contêiner sem root",
    "ToString sobrescrito em requests e records para não logar senha ou token",
    "Adiar a verificação de e-mail no cadastro para a fase 2, aceitando o risco para alunos"
  ],
  "nao_verificado": [
    "Execução dos testes de integração de autorização (cerca de 68 asserções de 403 em apps/api/tests)",
    "SQL real de EscopoDeTurma, ConsultaDoMural e ConsultaDeComprovacoes (avaliado pelas interfaces e comentários)",
    "Política real do bucket R2 e da CDN em produção (leitura pública sem listagem, CORS, cabeçalhos servidos)",
    "Comportamento efetivo do limite de taxa com duas réplicas atrás do Caddy",
    "Se o seed demo foi rodado em produção e se as contas de seed sem senha estão de fato inacessíveis",
    "Proteção do .env e das credenciais R2 e SMTP na VPS",
    "Comportamento do app web e nativo em execução (XSS, armazenamento real de tokens)"
  ],
  "falhas": [
    {
      "titulo": "Tomada de conta de aluno pelo cadastro sem verificação de posse do e-mail",
      "reproducao": "1) Obter o RA de um colega ainda não cadastrado e deduzir o e-mail nome.sobrenome@al.unieduk.com.br. 2) POST /api/v1/auth/cadastro com {ra, email, nomeDeExibicao, prefixo, senha, versaoDoTermo}. 3) A API responde 201 com sessão. 4) O verdadeiro aluno, ao tentar se cadastrar, recebe conta existente e precisa recuperar a senha pelo e-mail.",
      "local": "apps/api/src/Maxx.Application/Autenticacao/Cadastro/CadastroHandler.cs:41"
    },
    {
      "titulo": "Oráculo de pares RA/e-mail nos endpoints de sugestão e disponibilidade do cadastro",
      "reproducao": "Com um e-mail institucional conhecido, enviar POST /api/v1/auth/cadastro/sugestao {ra, email} variando o RA. 404 indica par inexistente, 200 par válido sem conta, 409 par com conta. O limite é só 60/min por IP; distribuir entre IPs aumenta a vazão.",
      "local": "apps/api/src/Maxx.Application/Autenticacao/Cadastro/CadastroHandler.cs:85"
    },
    {
      "titulo": "Limite de taxa em memória por réplica permite o dobro de tentativas",
      "reproducao": "Com o compose de produção (2 réplicas em round robin), enviar 10 POST /api/v1/auth/login seguidos com o mesmo identificador e senhas erradas. Pela distribuição, espera-se cerca de 10 respostas 401 antes do primeiro 429, em vez de 5.",
      "local": "apps/api/src/Maxx.Api/LimiteDeTaxa/LimitesDeTaxa.cs:46"
    },
    {
      "titulo": "API conecta ao banco com o usuário dono do Postgres (sem menor privilégio)",
      "reproducao": "Ler docker-compose.producao.yml: ConnectionStrings__Maxx das réplicas usa POSTGRES_USER e POSTGRES_PASSWORD, as mesmas do serviço postgres. Qualquer comprometimento da API tem permissão de DDL e de leitura total.",
      "local": "docker-compose.producao.yml:26"
    },
    {
      "titulo": "Conteúdo da foto não validado no servidor (bytes arbitrários e EXIF)",
      "reproducao": "1) POST /api/v1/uploads {finalidade: post, tipoDeConteudo: image/jpeg, tamanhoDoFeed: N, tamanhoDaGrade: M}. 2) PUT nas URLs assinadas com N e M bytes que não são JPEG, ou JPEG com GPS no EXIF. 3) POST /api/v1/posts com o uploadId. O objeto fica público na CDN sem reencode nem remoção de metadados.",
      "local": "apps/api/src/Maxx.Domain/Fotos/UploadPendente.cs:107"
    },
    {
      "titulo": "Sessão sem expiração absoluta",
      "reproducao": "Após o login, chamar POST /api/v1/auth/refresh pelo menos uma vez a cada 30 dias: cada rotação emite um refresh com mais 30 dias, e a sessão nunca expira.",
      "local": "apps/api/src/Maxx.Domain/Identidade/FamiliaDeSessao.cs:10"
    },
    {
      "titulo": "Modo demonstração cria aluno anônimo com acesso aos dados reais e chave sem expiração",
      "reproducao": "Subir com -f docker-compose.demo.yml. Sem login, POST /api/v1/demo/alunos {nome, curso, versaoDoTermo} devolve sessão de aluno matriculado nas turmas vigentes, que lê feed, busca e perfis reais. A chave do dispositivo, guardada no localStorage na web, reabre a conta indefinidamente via POST /api/v1/demo/entrar.",
      "local": "apps/api/src/Maxx.Api/Demonstracao/DemonstracaoEndpoints.cs:43"
    }
  ]
}
```
