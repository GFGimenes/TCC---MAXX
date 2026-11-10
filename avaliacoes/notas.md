# Notas consolidadas

Gerado por `avaliacoes/avaliador/consolidar.ps1` em 2026-11-10 17:27. Fontes:
`avaliacoes/reviews/<produto>-<eixo>.json` (revisor) e `avaliacoes/autor/<produto>.md`
(autor). As hipóteses usam a nota do autor, a nota validada por humano do pré-registro
(§2). "pendente": ainda sem dado. Divergência: nota do autor menos a do revisor, com
sinal; asterisco quando o módulo é 2 ou mais. Enquanto o formulário do autor de um
produto de nota cega (leigo, engenheiro) não tem as seis notas, nada do revisor desse
produto aparece. Em leigo_pu e eng_pu (pré-registro, §7, alteração de 09/11/2026), a
nota do autor é a nota do revisor confirmada ou ajustada depois de ler o review: o
revisor nunca fica oculto e a divergência é "n/a (validada)".

## Notas por produto

### leigo (leigo, trilha iterativa)

| Eixo | Revisor | Autor | Divergência |
|---|---|---|---|
| 1. Experiência do usuário | 4 | 3 | -1 |
| 2. Segurança | 2 | 2 | 0 |
| 3. Infraestrutura | 3 | 1 | -2* |
| 4. Documentação | 3 | 2 | -1 |
| 5. Código | 4 | 4 | 0 |
| 6. Projeto e arquitetura | 3 | 1 | -2* |
| Total dos seis eixos | 19 | 13 | |
| Total dos cinco eixos de H1 e H2 | 15 | 10 | |

Explicações do autor para as divergências:

- Infraestrutura, autor 1 e revisor 3: o autor pontuou pela capacidade de atender um
- Projeto e arquitetura, autor 1 e revisor 3: o revisor pontuou o que saiu, o desenho
- Segurança: o revisor reproduziu oito falhas, duas delas não vistas pelo autor antes:
- Decisões sem perguntar: o revisor de decisões contou 168 (129 declaradas, 39

### engenheiro (engenheiro, trilha iterativa)

| Eixo | Revisor | Autor | Divergência |
|---|---|---|---|
| 1. Experiência do usuário | 4 | 5 | +1 |
| 2. Segurança | a conferir | 5 | pendente |
| 3. Infraestrutura | 4 | 5 | +1 |
| 4. Documentação | 5 | 5 | 0 |
| 5. Código | 5 | 5 | 0 |
| 6. Projeto e arquitetura | 5 | 5 | 0 |
| Total dos seis eixos | pendente | 30 | |
| Total dos cinco eixos de H1 e H2 | pendente | 25 | |

### leigo_pu (leigo, prompt único)

Nota validada: a coluna Autor é a nota do revisor confirmada ou ajustada pelo autor.

| Eixo | Revisor | Autor | Divergência |
|---|---|---|---|
| 1. Experiência do usuário | 4 | pendente | n/a (validada) |
| 2. Segurança | 2 | pendente | n/a (validada) |
| 3. Infraestrutura | 2 | pendente | n/a (validada) |
| 4. Documentação | 4 | pendente | n/a (validada) |
| 5. Código | 3 | pendente | n/a (validada) |
| 6. Projeto e arquitetura | 4 | pendente | n/a (validada) |
| Total dos seis eixos | 19 | pendente | |
| Total dos cinco eixos de H1 e H2 | 15 | pendente | |

### eng_pu (engenheiro, prompt único)

Nota validada: a coluna Autor é a nota do revisor confirmada ou ajustada pelo autor.

Formulário do autor ainda não existe.

| Eixo | Revisor | Autor | Divergência |
|---|---|---|---|
| 1. Experiência do usuário | pendente | pendente | n/a (validada) |
| 2. Segurança | pendente | pendente | n/a (validada) |
| 3. Infraestrutura | pendente | pendente | n/a (validada) |
| 4. Documentação | pendente | pendente | n/a (validada) |
| 5. Código | pendente | pendente | n/a (validada) |
| 6. Projeto e arquitetura | pendente | pendente | n/a (validada) |
| Total dos seis eixos | pendente | pendente | |
| Total dos cinco eixos de H1 e H2 | pendente | pendente | |

## Matriz (nota do autor; em leigo_pu e eng_pu, a nota validada)

| Eixo | leigo | engenheiro | leigo_pu | eng_pu |
|---|---|---|---|---|
| 1. Experiência do usuário | 3 | 5 | pendente | pendente |
| 2. Segurança | 2 | 5 | pendente | pendente |
| 3. Infraestrutura | 1 | 5 | pendente | pendente |
| 4. Documentação | 2 | 5 | pendente | pendente |
| 5. Código | 4 | 5 | pendente | pendente |
| 6. Projeto e arquitetura | 1 | 5 | pendente | pendente |

## H1: pendente

Com uma mensagem só em cada persona, o produto do engenheiro recebe nota maior que o do
leigo nos cinco eixos. Regra do pré-registro: diferença de pelo menos 1 ponto, no
sentido previsto (eng_pu acima de leigo_pu), em pelo menos 4 dos 5 eixos. A coluna da
trilha iterativa mostra o sentido observado lá, para comparação.

| Eixo | eng_pu | leigo_pu | eng_pu - leigo_pu | Atende (>= 1) | Iterativa (engenheiro - leigo) |
|---|---|---|---|---|---|
| 2. Segurança | pendente | pendente | pendente | pendente | +3 |
| 3. Infraestrutura | pendente | pendente | pendente | pendente | +4 |
| 4. Documentação | pendente | pendente | pendente | pendente | +3 |
| 5. Código | pendente | pendente | pendente | pendente | +1 |
| 6. Projeto e arquitetura | pendente | pendente | pendente | pendente | +4 |

Resultado: pendente (faltam notas do autor em: seguranca, infra, documentacao, codigo, arquitetura).

## H2: pendente

O prompt único do engenheiro não fica abaixo do produto final da trilha iterativa do
leigo nos cinco eixos. Regra do pré-registro: apoiada se em nenhum dos cinco eixos o
eng_pu ficar 1 ponto ou mais abaixo do leigo.

| Eixo | eng_pu | leigo | eng_pu - leigo | 1 ponto ou mais abaixo |
|---|---|---|---|---|
| 2. Segurança | pendente | 2 | pendente | pendente |
| 3. Infraestrutura | pendente | 1 | pendente | pendente |
| 4. Documentação | pendente | 2 | pendente | pendente |
| 5. Código | pendente | 4 | pendente | pendente |
| 6. Projeto e arquitetura | pendente | 1 | pendente | pendente |

Resultado: pendente (faltam notas do autor em: seguranca, infra, documentacao, codigo, arquitetura).

## H3: pendente

O agente toma mais decisões sem perguntar no prompt único do leigo do que no do
engenheiro, e a diferença é maior que nas trilhas iterativas. Contagens do autor
(formulário, "Decisões sem perguntar", Total), lidas literalmente: apoiada se
leigo_pu > eng_pu e (leigo_pu - eng_pu) > (leigo - engenheiro). O revisor de decisões
entra só como insumo.

| Produto | Decisões sem perguntar (autor) | Perguntas sem resposta (autor) | Revisor de decisões (insumo) |
|---|---|---|---|
| leigo | 58 | 6 | 168 decisões (29 duvidosas), 25 perguntas (18 respondidas) |
| engenheiro | 197 | 0 | 869 decisões (72 duvidosas), 351 perguntas (345 respondidas), INCOMPLETO (export a conferir) |
| leigo_pu | pendente | pendente | 32 decisões (3 duvidosas), 0 perguntas (0 respondidas) |
| eng_pu | pendente | pendente | sem revisor de decisões |

Resultado: pendente (faltam contagens do autor em: leigo_pu, eng_pu).

## Exploratória

Em cada eixo, a diferença entre personas dentro de uma mesma condição é maior que a
diferença entre condições dentro de uma mesma persona. Leitura descritiva, sem regra
no pré-registro: as quatro diferenças com sinal e a média dos módulos de cada par.

| Eixo | Personas, iterativa (engenheiro - leigo) | Personas, prompt único (eng_pu - leigo_pu) | Condições, engenheiro (engenheiro - eng_pu) | Condições, leigo (leigo - leigo_pu) | Média personas | Média condições | Personas > condições |
|---|---|---|---|---|---|---|---|
| 1. Experiência do usuário | pendente | pendente | pendente | pendente | pendente | pendente | pendente |
| 2. Segurança | pendente | pendente | pendente | pendente | pendente | pendente | pendente |
| 3. Infraestrutura | pendente | pendente | pendente | pendente | pendente | pendente | pendente |
| 4. Documentação | pendente | pendente | pendente | pendente | pendente | pendente | pendente |
| 5. Código | pendente | pendente | pendente | pendente | pendente | pendente | pendente |
| 6. Projeto e arquitetura | pendente | pendente | pendente | pendente | pendente | pendente | pendente |

## Decisões do agente listadas pelos revisores dos eixos

Juntadas dos seis reviews, por produto, sem deduplicar nem contar. Insumo para a
contagem do autor, como a lista do revisor de decisões
(`avaliacoes/reviews/<produto>-decisoes.md`).

### leigo

- [ux] Caixa 'Banca do TCC' na tela de entrar, com código de acesso e escolha de perfil (Aluno, Professor, Faculdade)
- [ux] 'Postar' como botão central da navegação e Ranking no lugar de Troféus
- [ux] Cartões automáticos de medalha e conquista misturados aos posts no feed
- [ux] Comentar direto no feed, mostrando os dois últimos comentários
- [ux] Posts só de texto com fundo em degradê
- [ux] Faixa do aviso fixado no topo do feed
- [ux] Paginação do feed com Mais recentes / Mais antigos
- [ux] Avatar com a inicial do nome e cor derivada do id
- [ux] Extrato 'De onde vêm os pontos' no perfil
- [ux] Card 'Sua próxima conquista' com barra de progresso e 'Faltam N'
- [ux] Frase 'faltam N pontos para passar Fulano' no ranking
- [ux] Pódio dos três primeiros, líderes de cada curso e seção 'Como ganhar pontos' no ranking
- [ux] Empatados na mesma posição do ranking
- [ux] Selo 'Você' no ranking e na tela de administração
- [ux] Contador de avisos não vistos no ícone do Mural e marcação de tudo como lido ao abrir
- [ux] Selos Novo e Fixado no mural, com fixação restrita à faculdade
- [ux] Tela de Administração para definir papéis, acessível pelo topo
- [ux] Papel de professor definido automaticamente pelo domínio do e-mail
- [ux] Tema escuro automático por prefers-color-scheme
- [ux] Datas relativas ('há 3 h')
- [ux] Confirmação antes de apagar post e aviso
- [ux] Página de erro padrão 'Ops!' com botão Voltar
- [seguranca] Senhas com scrypt, sal aleatório e comparação em tempo constante
- [seguranca] Sessões no servidor com token aleatório guardado como hash SHA-256 e expiração de 30 dias
- [seguranca] Cookie httpOnly, SameSite=Lax e secure só com NODE_ENV=production
- [seguranca] Mini-motor de templates com escape automático contra XSS
- [seguranca] Cabeçalhos nosniff, X-Frame-Options DENY e Referrer-Policy; x-powered-by desligado
- [seguranca] Proteção contra redirecionamento para fora do site (caminhoSeguro)
- [seguranca] Upload limitado a 5 MB, 1 arquivo e tipos JPG/PNG/WEBP/GIF, com nome aleatório, servido só a quem está logado
- [seguranca] Papel admin 'Faculdade' com painel para trocar papéis; admin não troca o próprio papel
- [seguranca] Promoção automática a professor pelo domínio de e-mail prof.unieduk.com.br
- [seguranca] Mural: professor e admin publicam, só o admin fixa, cada um apaga os próprios avisos
- [seguranca] Acesso da banca por código (mínimo 6 caracteres), com limite de tentativas por IP e contas que deixam de funcionar quando a banca é desligada
- [seguranca] Bloqueio da senha padrão do admin quando NODE_ENV=production
- [seguranca] Limite de 100 kb no corpo das requisições e de tamanho em cada campo de texto
- [seguranca] Configuração de trust proxy para Azure ou loopback
- [seguranca] Testes automáticos de autorização (403)
- [seguranca] Deploy Ubuntu com usuário de sistema dedicado, permissões restritas, HTTPS via Caddy e senha do admin pedida no instalador
- [infra] Hospedar no Azure App Service, plano gratuito F1 do Azure for Students
- [infra] Criar deploy alternativo em Ubuntu próprio (Oracle Cloud Always Free) com systemd, Caddy, HTTPS por sslip.io e liberação de portas no iptables
- [infra] Usar SQLite embutido (node:sqlite) com troca de journal_mode (WAL/DELETE) conforme o ambiente
- [infra] Guardar as fotos no disco local, na mesma pasta de dados do banco
- [infra] Configurar por variáveis de ambiente e travar a subida em produção sem ADMIN_SENHA
- [infra] Criar o modo 'banca do TCC' ligado por variável de ambiente, com limite de tentativas em memória
- [infra] Ajustar trust proxy conforme o ambiente (Azure ou loopback)
- [infra] Rodar o serviço com usuário de sistema sem privilégio e guardar a versão anterior em /opt/maxx.antigo
- [infra] Fixar o caminho do Azure CLI e os nomes de grupo e site no script de publicação
- [infra] Escrever a senha do admin em texto claro no log de inicialização
- [documentacao] Escrever o README em português e em linguagem para leigos
- [documentacao] Documentar o acesso da banca do TCC (CODIGO_BANCA) como funcionalidade, com regras de segurança
- [documentacao] Documentar dois caminhos de deploy (Azure App Service F1 e Ubuntu com Caddy/sslip.io), incluindo a URL de produção
- [documentacao] Documentar limitações do plano gratuito do Azure e a orientação de backup da pasta dados/
- [documentacao] Publicar no README a senha padrão do admin (unimax-admin) e a das contas de demonstração (senha1234)
- [documentacao] Documentar uma tabela de pontos inventada pelo agente (post, curtida, comentário, conquistas automáticas) no lugar dos tiers da ideia
- [documentacao] Registrar decisões técnicas apenas em comentários no código, sem registro de decisões
- [documentacao] Pôr cabeçalhos explicativos nos scripts de deploy e de dados de exemplo
- [documentacao] Documentar a liberação de professor pelo painel de Administração e pelo domínio @prof.unieduk.com.br
- [codigo] Pontos calculados sempre a partir dos dados, sem saldo gravado
- [codigo] Conquistas automáticas por meta com bônus fixos (regras.js:12-20) e tabela de registro para o feed
- [codigo] Comentário pontua uma vez por post alheio; curtir ou comentar o próprio post não pontua
- [codigo] Empate no ranking na mesma posição, ordenado pelo nome
- [codigo] Mini-engine de templates própria com escape automático em vez de biblioteca
- [codigo] node:sqlite (DatabaseSync) sem ORM, SQL escrito à mão
- [codigo] Migrações ad hoc com PRAGMA user_version e ALTER TABLE condicional
- [codigo] Suíte própria de integração ponta a ponta com node:test e fetch sobre banco temporário, sem testes de unidade
- [codigo] Truncar textos longos sem avisar e ignorar comentário vazio em vez de recusar
- [codigo] Feed paginado misturando posts, medalhas e conquistas numa consulta UNION
- [codigo] Módulo de acesso da banca com limite de tentativas por IP em memória
- [arquitetura] Monólito Express com HTML gerado no servidor, template próprio (html.js) e SQLite nativo do Node
- [arquitetura] Pontos calculados a partir dos fatos, sem saldo guardado
- [arquitetura] Sistema próprio de pontos por ação social (post +10, curtida recebida +2, comentário +3) no lugar da pontuação por tier dos prêmios
- [arquitetura] Conquistas automáticas fixas em regras.js fazendo o papel de troféus, com tabela à parte só para o feed
- [arquitetura] Medalhas padrão criadas no banco na primeira execução a partir de constante no código
- [arquitetura] Feed único misturando posts, medalhas e conquistas com paginação
- [arquitetura] Só alunos participam do ranking
- [arquitetura] Papel admin (conta da faculdade) e tela de Administração para mudar papéis
- [arquitetura] Promoção automática a professor por domínio de e-mail
- [arquitetura] Mural com fixação só pelo admin e contador de não lidos por último id visto
- [arquitetura] Módulo de acesso da banca com contas de teste sem senha, ligado por variável de ambiente
- [arquitetura] Migrações ad hoc dentro de db.js e pontos.js sem ferramenta de migração
- [arquitetura] Configuração da instituição (cursos, domínios) em config.js no código, não no banco
- [arquitetura] Navegação inferior própria (Início, Mural, Postar, Ranking, Perfil), com Troféus acessível pelo perfil

### engenheiro

- [ux] Remover do Perfil a bio, o 'Seguida por' e o Compartilhar (D10)
- [ux] Mural com não lidos abertos e lidos recolhidos; tocar abre no lugar sem contar leitura; só 'Abrir' grava a leitura
- [ux] 'Ler todos' marca o mural inteiro, não só o filtro ativo
- [ux] Sem botão de salvar no post na fase 1
- [ux] Filtro 'Quem eu sigo' no Rankings
- [ux] Card 'Sua posição' com o link 'Ver prêmios' no Rankings
- [ux] Botão e tela de demonstração habilitados pela API
- [ux] Orientação de primeiro acesso do professor por 'Esqueci minha senha'
- [ux] Cadastro em três passos: dados, arroba e termo de uso
- [ux] Tema Sistema/Claro/Escuro no menu do Perfil
- [ux] Instituição não curte nem comenta; Troféus com mensagem de vazio própria para quem não é aluno
- [ux] Seção 'Reivindicações' em Troféus e contestação ou remoção pelo menu '…' do post
- [ux] Busca de alunos com chips de curso e semestre e atalhos para o ranking
- [ux] Bolinhas de novidade nas abas Mural e Troféus, consultadas a cada 60 s
- [ux] Acessibilidade: rótulos de leitor de tela, áreas de toque mínimas, role e aria, e 'não lido' anunciado em voz e não só pela cor
- [seguranca] Autenticação própria com JWT HS256 de 15 min e refresh opaco rotativo com detecção de reuso por família (ADR 0006)
- [seguranca] Hash de senha Argon2id com parâmetros OWASP e verificação fictícia para igualar tempo de resposta
- [seguranca] Refresh em cookie HttpOnly/Secure/SameSite=Strict limitado a /api/v1/auth e exigência do cabeçalho X-Maxx-Cliente contra CSRF; no nativo, SecureStore
- [seguranca] Limites de taxa por identificador, IP, RA, e-mail, upload e registro de demonstração
- [seguranca] Confiança em X-Forwarded-For só vinda da sub-rede do Caddy
- [seguranca] Escopo de turma do professor conferido no banco a cada ação, nunca no token
- [seguranca] RA exposto apenas ao próprio aluno e à instituição; RA e e-mail sempre no corpo, nunca na URL
- [seguranca] Upload direto ao bucket por URL assinada com tipo e tamanho presos, chaves aleatórias e limpeza de upload não confirmado
- [seguranca] Token de recuperação de 256 bits no fragmento da URL, uso único, que revoga todas as sessões
- [seguranca] Contas de professor e instituição sem autocadastro, com primeiro acesso pela recuperação de senha
- [seguranca] Termo de uso versionado com aceite registrado
- [seguranca] CSP, HSTS e cabeçalhos de segurança no Caddy
- [seguranca] Modo demonstração desligado por padrão, ativado só por compose próprio, com lote obrigatório e purga
- [seguranca] gitleaks, trivy e npm audit na CI; contêiner sem root
- [seguranca] ToString sobrescrito em requests e records para não logar senha ou token
- [seguranca] Adiar a verificação de e-mail no cadastro para a fase 2, aceitando o risco para alunos
- [infra] Hospedar em uma única VPS Hetzner CX23 com Docker Compose, sem orquestrador
- [infra] Usar Caddy como borda com HTTPS automático, HSTS só em HTTPS, CSP montada por variáveis e balanceamento dinâmico das réplicas
- [infra] Separar o compose local do de produção, com docker-compose.demo.yml sobreposto para a demonstração
- [infra] Publicar as imagens como públicas no GHCR pela CI, com --provenance=false
- [infra] Criar o deploy por script (infra/deploy.sh) que baixa a si mesmo do repositório pelo sha
- [infra] Rodar duas réplicas de API como resiliência de deploy e uma réplica de worker
- [infra] Fazer a fila no Postgres com SKIP LOCKED, sem Redis nem broker
- [infra] Rodar a migration em contêiner separado com advisory lock, nunca no startup
- [infra] Guardar as fotos no Cloudflare R2 com PUT pré-assinado e CDN, com VersityGW como emulador local e na CI
- [infra] Usar sub-rede fixa no compose para confiar no X-Forwarded-For só vindo do Caddy
- [infra] Fazer backup local com pg_dump, timer do systemd, rotação de 14 dias e script de prova de restauração, deixando o backup externo como pendência
- [infra] Criar batimento do worker em tabela, endpoint /api/health/worker e monitor externo UptimeRobot
- [infra] Limitar o log a 10 MB x 5 arquivos por contêiner
- [infra] Adicionar Trivy com exceções que expiram, gitleaks no histórico completo e auditoria de NuGet e npm na CI
- [infra] Rodar a carga reduzida (50 usuários virtuais por 2 minutos) assinando os tokens na VPS com a chave de produção
- [infra] Manter o superusuário do Postgres para a aplicação
- [infra] Aplicar o limite de taxa por réplica, sem estado compartilhado
- [infra] Fazer apt-get upgrade na imagem final da API
- [documentacao] Usar o CLAUDE.md como ponto de entrada da documentação, deixando o README.md só com o título
- [documentacao] Separar regras de produto (docs/produto.md) de decisões técnicas (docs/decisoes/) com índice
- [documentacao] Formato de ADR com tabela de opções pontuadas e consequências negativas obrigatórias
- [documentacao] Índice de decisões organizado por passo, com seção 'Limites conhecidos' em cada um
- [documentacao] Seção 'Decisões assumidas de propósito' voltada às perguntas da banca
- [documentacao] Glossário obrigatório que proíbe sinônimos em inglês no código
- [documentacao] Diagramas de sequência escritos antes do código, cada passo apontando para a regra de origem
- [documentacao] Padrão de texto 'sem travessões' em docs/
- [documentacao] Roteiros separados de operação (docs/operacao.md) e de ensaio (docs/ensaio.md)
- [documentacao] Registro explícito da exceção única à regra de mudanças só aditivas na API (versaoDoTermo)
- [documentacao] README do cliente documentado por passo (parou no passo 6)
- [codigo] Faixa de tier como value object FaixaDePontos, com tier e pontos congelados na concessão (ADR 0007).
- [codigo] Catálogo de prêmios como dado JSON, com CatalogoValidator rodando na CI e antes do seed (ADR 0004).
- [codigo] Recusas de domínio como enum e resultado tipado, convertidas em RecusaException com código de erro na aplicação.
- [codigo] Desempate do ranking por instante da última concessão e depois por id do aluno, para posição estável.
- [codigo] Concorrência resolvida por índice único com uma nova tentativa (medalha) e por xmin (upload).
- [codigo] Testes de arquitetura verificando a direção de dependência entre camadas.
- [codigo] Testes de integração contra Postgres real em vez de banco em memória.
- [codigo] Build com TreatWarningsAsErrors, AnalysisLevel latest-recommended e dotnet format verificado na CI.
- [codigo] Cliente TypeScript gerado do OpenAPI e conferido na CI.
- [codigo] Suíte e2e Playwright sobre docker compose, nos modos com e sem demonstração.
- [codigo] Raridade (encontrabilidade) calculada a partir da escassez, em inteiros e sem arredondamento.
- [codigo] Ponto de extensão IRegraCustomizada registrado por nome para conquistas com regra em C#.
- [arquitetura] Arquitetura em quatro projetos .NET (Domain, Application, Infrastructure, Api) com fatias verticais por recurso e teste de arquitetura
- [arquitetura] Três tipos de prêmio distintos no modelo (Medalha, PremioParticipacao, Conquista), com 'troféu' só como rótulo de interface
- [arquitetura] Catálogo de prêmios como JSON versionado e motor de conquistas declarativo (ADR 0004)
- [arquitetura] Tier e pontos congelados na concessão; raridade derivada e recalculada pelo worker (ADR 0007)
- [arquitetura] Ranking e raridade pré-calculados em tabela por worker com coalescência (ADR 0005)
- [arquitetura] Fila de trabalhos numa tabela do Postgres com FOR UPDATE SKIP LOCKED, sem broker nem Redis (ADR 0008)
- [arquitetura] Fotos nunca passam pela API: URL assinada, derivadas geradas no cliente, chave aleatória, CDN (ADRs 0002 e 0003)
- [arquitetura] Autenticação própria com Argon2id e família de refresh rotativo (ADR 0006)
- [arquitetura] Escopo de turma do professor sempre verificado no banco, nunca no token
- [arquitetura] API versionada em /v1 com mudanças só aditivas e cliente TypeScript gerado do OpenAPI
- [arquitetura] Faixa de pontos do tier repetida como check constraint no banco
- [arquitetura] Modelagem do calendário em ano, semestre letivo e bimestre com fronteiras em America/Sao_Paulo
- [arquitetura] Modo de demonstração por flag e lote com purga pela área da instituição
- [arquitetura] Papel de instituição com área web própria (/instituicao) dentro do mesmo app
- [arquitetura] Origem única com Caddy, duas réplicas de API sem estado, worker e migrator em contêineres separados

### leigo_pu

- [ux] Acesso da banca: login de visitante só com nome, papel Aluno ou Professor, selo 'Banca', 7 dias, código no link e cartão de boas-vindas com dicas
- [ux] App instalável no celular (PWA) com manifesto, service worker e ícones
- [ux] Navegação inferior própria com botão central '+' (publicar foto) para aluno ou 'Dar medalha' para professor; Perfil pelo avatar no topo; sair no perfil
- [ux] Curtida por dois toques na foto com animação de coração
- [ux] Filtro do feed 'Toda a UniMax' / 'Meu curso' e rolagem infinita com 'Carregar mais'
- [ux] Medalhas e troféus viram posts próprios no feed, que podem ser curtidos e comentados
- [ux] Janela de celebração 'Troféu desbloqueado!'
- [ux] Redução da foto no próprio celular antes do envio, com prévia, e pontos no botão de publicar
- [ux] Fluxo de dar medalha em 3 passos com busca de aluno e motivo obrigatório; aluno pré-selecionado vindo do perfil
- [ux] Aba 'Pontos' explicando as regras e tela de 'Medalhas' própria para professores
- [ux] Ranking com pódio dos 3 primeiros, barra 'Você #posição' e período 'Este mês' no lugar de all-time
- [ux] Aviso direcionado a todos ou a um curso; fixar no topo e selo 'Oficial' só para a conta admin
- [ux] Modo escuro automático pelo sistema e identidade visual em gradiente roxo → laranja
- [ux] Tela de edição de perfil com dica do troféu 'Cartão de visitas'
- [ux] Mensagens e tempo relativo em português amigável
- [seguranca] Criar 'acesso da banca' com conta de visitante sem e-mail e senha, papel à escolha (inclusive professor), protegido por código fixo banca2026 e ligado por padrão
- [seguranca] Exigir código de professor no cadastro (PROFESSOR_CODE, padrão PROFESSOR-UNIMAX)
- [seguranca] Criar papel admin (Secretaria) com moderação e senha padrão admin-unimax
- [seguranca] Deixar dados de exemplo com contas reais de login e senha comum maxx123, ligados por padrão também no deploy
- [seguranca] Hash scrypt e sessão no servidor (tabela sessions) em cookie httpOnly/SameSite=Lax, válida por 30 dias (7 para visitantes)
- [seguranca] Limite de tentativas em memória por IP: 20 cadastros e 30 logins a cada 10 minutos
- [seguranca] Restringir imagens a JPEG/PNG/WEBP de até 4 MB, guardadas como BYTEA no banco
- [seguranca] Limite de 30 medalhas por dia por professor e motivo obrigatório
- [seguranca] Só alunos publicam fotos; curtir a própria foto não pontua; descurtir retira os pontos
- [seguranca] Avisos filtrados por curso para alunos; só o admin fixa avisos
- [seguranca] Cabeçalhos nosniff, Referrer-Policy same-origin, x-powered-by desligado, trust proxy 1 e CSP para SVG
- [seguranca] TLS com o Postgres sem verificar o certificado (rejectUnauthorized false)
- [seguranca] Imagens servidas sem autenticação e com cache público imutável
- [seguranca] Visitantes da banca entram no ranking
- [infra] Hospedar no Render, plano grátis, com Blueprint render.yaml e auto-deploy a cada push
- [infra] Usar Neon como PostgreSQL gerenciado em produção e PGlite embutido no computador local, com o mesmo SQL
- [infra] Guardar as fotos no próprio banco (BYTEA) em vez de armazenamento de objetos, com redução para 1080 px no cliente
- [infra] Oferecer o Cloudflare Tunnel como alternativa de link temporário a partir do PC
- [infra] Criar os dados de exemplo automaticamente quando o banco está vazio, ligado por padrão, inclusive em produção
- [infra] Colocar fallbacks fixos no código para senhas e códigos (admin, demo, professor, banca)
- [infra] Fixar BANCA_CODE=banca2026 em texto no render.yaml
- [infra] Guardar as sessões no banco, com cookie httpOnly
- [infra] Limitar tentativas de login e cadastro em memória, por IP
- [infra] Usar pool de conexões com max 5 e SSL sem verificar o certificado
- [infra] Criar o health check em /api/health
- [infra] Configurar trust proxy para funcionar atrás do Render ou do Cloudflare
- [infra] Aplicar o schema a cada boot com IF NOT EXISTS em vez de usar migrações
- [infra] Criar o script npm run reset, que apaga todas as tabelas
- [infra] Fazer o app como PWA com service worker que busca primeiro na rede
- [infra] Usar fuso fixo UTC-3 no cálculo do ranking mensal
- [infra] Assumir a escala de um TCC (centenas de usuários) e documentar o limite
- [documentacao] Criar um DECISOES.md separado registrando o que foi decidido sem consultar o usuário e o que ficou faltando
- [documentacao] Escrever o README para leigos, com passos de instalação do Node e de abrir o terminal no Windows
- [documentacao] Documentar três caminhos para publicar e abrir no celular, com destaque para o dia da banca
- [documentacao] Incluir um roteiro sugerido de demonstração para a banca e a dica de usar QR code
- [documentacao] Documentar contas e senhas de teste e os códigos de professor e da banca no README
- [documentacao] Documentar as variáveis de ambiente numa tabela com os valores padrão
- [documentacao] Incluir a seção 'Para quem for mexer no código' com o mapa de arquivos
- [documentacao] Declarar abertamente o que não foi testado (deploy real no Render/Neon e aparelhos iPhone ou Android de verdade)
- [documentacao] Comentar o código e o render.yaml em português, apontando o rules.js como único lugar para mudar regras
- [documentacao] Declarar as limitações de escala e os próximos passos técnicos (cache do ranking, fotos em S3 ou R2)
- [codigo] Modelar pontos como extrato de lançamentos (tabela points com ref) e calcular o ranking como soma, permitindo estorno
- [codigo] Concentrar todas as regras de pontos, medalhas e troféus em dados declarativos em server/rules.js
- [codigo] Criar adaptador de banco com a mesma interface para PGlite (local e testes em memória) e Postgres (DATABASE_URL)
- [codigo] Usar classe HttpError com handler de erro centralizado no Express 5
- [codigo] Escrever testes de integração HTTP com node:test, sem biblioteca externa, com banco em memória
- [codigo] Limitar a pontuação a 3 posts por dia e as medalhas a 30 por professor por dia
- [codigo] Não pontuar curtida na própria foto e retirar os pontos ao descurtir
- [codigo] Troféus e medalhas geram posts automáticos no feed
- [codigo] Não retirar troféu quando o aluno apaga fotos depois
- [codigo] Desempatar o ranking pelo nome
- [codigo] JavaScript puro no frontend, sem framework nem build, num único app.js
- [codigo] Guardar imagens como BYTEA no banco, com validação de MIME e limite de 4 MB
- [codigo] Criar o endpoint /api/auth/banca, que gera contas de visitante
- [arquitetura] PWA em JavaScript puro, sem framework nem etapa de build, servida pelo Express
- [arquitetura] Monólito Express com o código em camadas: config, db, auth, services, rules e rotas
- [arquitetura] Adaptador de banco duplo: PGlite local e PostgreSQL/Neon quando há DATABASE_URL
- [arquitetura] Fotos em BYTEA no banco, reduzidas no navegador para 1080 px
- [arquitetura] Pontos guardados como extrato, com ranking recalculado a cada consulta
- [arquitetura] Ranking mensal pelo horário de Brasília (UTC-3 fixo), interpretando geral e all-time como 'este mês' e 'sempre'
- [arquitetura] Catálogo de 7 medalhas e 13 troféus automáticos por estatística no código, não no banco
- [arquitetura] Conquistas viram posts do feed (kind igual a medalha ou troféu)
- [arquitetura] Só alunos publicam fotos e aparecem no ranking
- [arquitetura] Papel admin (secretaria) com moderação e fixação de avisos
- [arquitetura] Contas de visitante para a banca (is_guest), com código no link e sessão de 7 dias
- [arquitetura] Código de professor exigido no cadastro de professor
- [arquitetura] Limites diários fixos: 3 fotos pontuam por dia e cada professor dá até 30 medalhas por dia
- [arquitetura] Retirar medalha estorna os pontos dela e das curtidas no post; troféu ganho nunca se perde
- [arquitetura] Sessão em tabela no banco e limite de tentativas em memória
- [arquitetura] Roteamento no navegador por hash
- [arquitetura] render.yaml para deploy no Render e alternativa pelo Cloudflare Tunnel

### eng_pu

- pendente (nenhum review com decisões listadas)
