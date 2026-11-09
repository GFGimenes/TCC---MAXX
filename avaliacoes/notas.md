# Notas consolidadas

Gerado por `avaliacoes/avaliador/consolidar.ps1` em 2026-11-08 23:28. Fontes:
`avaliacoes/reviews/<produto>-<eixo>.json` (revisor) e `avaliacoes/autor/<produto>.md`
(autor). As hipóteses usam a nota do autor, a nota validada por humano do pré-registro
(§2). "pendente": ainda sem dado. Divergência: nota do autor menos a do revisor, com
sinal; asterisco quando o módulo é 2 ou mais. Enquanto o formulário do autor de um
produto não tem as seis notas, nada do revisor desse produto aparece.

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

Formulário do autor ainda não existe.

| Eixo | Revisor | Autor | Divergência |
|---|---|---|---|
| 1. Experiência do usuário | oculta (formulário do autor incompleto) | pendente | pendente |
| 2. Segurança | oculta (formulário do autor incompleto) | pendente | pendente |
| 3. Infraestrutura | oculta (formulário do autor incompleto) | pendente | pendente |
| 4. Documentação | oculta (formulário do autor incompleto) | pendente | pendente |
| 5. Código | oculta (formulário do autor incompleto) | pendente | pendente |
| 6. Projeto e arquitetura | oculta (formulário do autor incompleto) | pendente | pendente |
| Total dos seis eixos | oculta (formulário do autor incompleto) | pendente | |
| Total dos cinco eixos de H1 e H2 | oculta (formulário do autor incompleto) | pendente | |

### leigo_pu (leigo, prompt único)

Formulário do autor ainda não existe.

| Eixo | Revisor | Autor | Divergência |
|---|---|---|---|
| 1. Experiência do usuário | oculta (formulário do autor incompleto) | pendente | pendente |
| 2. Segurança | oculta (formulário do autor incompleto) | pendente | pendente |
| 3. Infraestrutura | oculta (formulário do autor incompleto) | pendente | pendente |
| 4. Documentação | oculta (formulário do autor incompleto) | pendente | pendente |
| 5. Código | oculta (formulário do autor incompleto) | pendente | pendente |
| 6. Projeto e arquitetura | oculta (formulário do autor incompleto) | pendente | pendente |
| Total dos seis eixos | oculta (formulário do autor incompleto) | pendente | |
| Total dos cinco eixos de H1 e H2 | oculta (formulário do autor incompleto) | pendente | |

### eng_pu (engenheiro, prompt único)

Formulário do autor ainda não existe.

| Eixo | Revisor | Autor | Divergência |
|---|---|---|---|
| 1. Experiência do usuário | oculta (formulário do autor incompleto) | pendente | pendente |
| 2. Segurança | oculta (formulário do autor incompleto) | pendente | pendente |
| 3. Infraestrutura | oculta (formulário do autor incompleto) | pendente | pendente |
| 4. Documentação | oculta (formulário do autor incompleto) | pendente | pendente |
| 5. Código | oculta (formulário do autor incompleto) | pendente | pendente |
| 6. Projeto e arquitetura | oculta (formulário do autor incompleto) | pendente | pendente |
| Total dos seis eixos | oculta (formulário do autor incompleto) | pendente | |
| Total dos cinco eixos de H1 e H2 | oculta (formulário do autor incompleto) | pendente | |

## Matriz (nota do autor)

| Eixo | leigo | engenheiro | leigo_pu | eng_pu |
|---|---|---|---|---|
| 1. Experiência do usuário | 3 | pendente | pendente | pendente |
| 2. Segurança | 2 | pendente | pendente | pendente |
| 3. Infraestrutura | 1 | pendente | pendente | pendente |
| 4. Documentação | 2 | pendente | pendente | pendente |
| 5. Código | 4 | pendente | pendente | pendente |
| 6. Projeto e arquitetura | 1 | pendente | pendente | pendente |

## H1: pendente

Com uma mensagem só em cada persona, o produto do engenheiro recebe nota maior que o do
leigo nos cinco eixos. Regra do pré-registro: diferença de pelo menos 1 ponto, no
sentido previsto (eng_pu acima de leigo_pu), em pelo menos 4 dos 5 eixos. A coluna da
trilha iterativa mostra o sentido observado lá, para comparação.

| Eixo | eng_pu | leigo_pu | eng_pu - leigo_pu | Atende (>= 1) | Iterativa (engenheiro - leigo) |
|---|---|---|---|---|---|
| 2. Segurança | pendente | pendente | pendente | pendente | pendente |
| 3. Infraestrutura | pendente | pendente | pendente | pendente | pendente |
| 4. Documentação | pendente | pendente | pendente | pendente | pendente |
| 5. Código | pendente | pendente | pendente | pendente | pendente |
| 6. Projeto e arquitetura | pendente | pendente | pendente | pendente | pendente |

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
| engenheiro | pendente | pendente | sem revisor de decisões |
| leigo_pu | pendente | pendente | sem revisor de decisões |
| eng_pu | pendente | pendente | sem revisor de decisões |

Resultado: pendente (faltam contagens do autor em: engenheiro, leigo_pu, eng_pu).

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

- oculta (formulário do autor incompleto)

### leigo_pu

- oculta (formulário do autor incompleto)

### eng_pu

- oculta (formulário do autor incompleto)
