# Decisões do agente: leigo (revisor de decisões)

Gerado pelo avaliador a partir dos arquivos `leigo-decisoes-<export>.json`, um por export.
Insumo para a contagem do autor (H3), não a contagem. Sem deduplicação entre exports.

- Status do conjunto: ok
- Totais do revisor: decisoes 168, declaradas 129, silenciosas 39, duvidosas 29, perguntas 25, perguntas_respondidas 18

| Export | Status | Leitura completa | Decisões | Declaradas | Silenciosas | Duvidosas | Perguntas | Respondidas | Motivo |
|---|---|---|---|---|---|---|---|---|---|
| leigo_00_abertura | ok | sim | 27 | 20 | 7 | 5 | 2 | 1 | - |
| leigo_01_login | ok | sim | 18 | 15 | 3 | 4 | 2 | 1 | - |
| leigo_02_feed | ok | sim | 22 | 16 | 6 | 5 | 3 | 1 | - |
| leigo_03_perfil | ok | sim | 16 | 14 | 2 | 3 | 2 | 1 | - |
| leigo_04_mural | ok | sim | 20 | 14 | 6 | 1 | 1 | 1 | - |
| leigo_05_trofeus | ok | sim | 23 | 18 | 5 | 3 | 1 | 1 | - |
| leigo_06_ranking | ok | sim | 17 | 14 | 3 | 4 | 2 | 1 | - |
| leigo_07_deploy_v2 | ok | sim | 25 | 18 | 7 | 4 | 12 | 11 | - |

## Export leigo_00_abertura

Decisões sem perguntar:

- Construir como aplicativo web (não app nativo de celular) [stack e arquitetura; declarada]. Trecho: "Vou montar a primeira versão do Maxx com as decisões já tomadas: um app web"
- Node.js (>=22.13) com Express e multer [stack e arquitetura; silenciosa]. Trecho: ""express": "^4.21.2", "multer": "^2.0.2""
- Banco SQLite nativo do Node, num arquivo dados/maxx.db [stack e arquitetura; silenciosa]. Trecho: "const { DatabaseSync } = require('node:sqlite');"
- HTML gerado no servidor com sistema de templates próprio que escapa o conteúdo automaticamente contra XSS [stack e arquitetura; silenciosa]. Trecho: "Mini sistema de templates: tudo que é interpolado é escapado automaticamente"
- Restrição à UniMax feita só pelo domínio de e-mail @unimax.edu.br [segurança; declarada]. Trecho: "login só para e-mails @unimax.edu.br"
- Todo cadastro entra como aluno; uma conta de administração (papel novo) decide quem é professor ou administrador [regra de produto; declarada]. Trecho: "cadastro como aluno (a administração define os professores)"
- Senha guardada com hash scrypt e sal aleatório [segurança; silenciosa]. Trecho: "crypto.scryptSync(senha, sal, 64)"
- Os prêmios viraram um sistema de pontos mais conquistas com bônus [regra de produto; declarada]. Trecho: "desbloqueia conquistas com pontos extras, como "Primeiro clique" ou "Popular""
- Valores dos pontos: post +10, curtida recebida +2, comentário +3 [regra de produto; declarada]. Trecho: "o aluno ganha pontos quando posta (+10), quando recebe curtida de outra pessoa (+2)"
- Curtir ou comentar o próprio post não dá pontos, e o comentário conta uma vez por post [regra de produto; declarada]. Trecho: "Curtir ou comentar o próprio post não dá pontos."
- Pontuação recalculada a partir dos dados, sem saldo guardado [modelo de dados; silenciosa]. Trecho: "Tudo é calculado a partir dos dados reais: se um post ou curtida for apagado, a pontuação se ajusta sozinha."
- Catálogo fixo de medalhas, cada uma valendo de 20 a 50 pontos e com mensagem do professor [regra de produto; declarada]. Trecho: "Cada medalha vale de 20 a 50 pontos, por exemplo 🥇 Excelência acadêmica"
- Só alunos entram no ranking [regra de produto; declarada]. Trecho: "Ranking geral e por curso. Só alunos entram no ranking."
- Só a conta da faculdade publica no mural, e o aviso fixado aparece também no topo do feed [regra de produto; declarada]. Trecho: "Mural de avisos, onde só a conta da faculdade publica. Um aviso fixado também aparece no topo do feed."
- Posts com foto e/ou texto, com as fotos guardadas no disco local, em dados/ [stack e arquitetura; declarada]. Trecho: "Fotos enviadas e o banco de dados ficam na pasta `dados/`."
- Lista fixa de cursos definida em src/config.js [modelo de dados; declarada, duvidosa]. Trecho: "Para mudar a lista de cursos ... é só editar src/config.js"
- Conta de administração criada automaticamente com senha padrão, que pode ser trocada pela variável ADMIN_SENHA [segurança; declarada]. Trecho: "admin@unimax.edu.br / senha unimax-admin (troque definindo a variável ADMIN_SENHA"
- Visual em roxo e rosa, com ícone de M em degradê e ícones SVG [UX e visual; silenciosa]. Trecho: "--primaria: #5b21b6; --primaria-2: #db2777;"
- O professor dá a medalha por um formulário no perfil do aluno [UX e visual; declarada]. Trecho: "no perfil de um aluno, o professor escolhe uma medalha e deixa uma mensagem"
- Teste automatizado dos fluxos principais com node:test, num banco temporário [testes e processo; declarada]. Trecho: "Now an automated test that walks through the main flows"
- Script de dados de exemplo, com todas as contas usando a senha senha1234 [testes e processo; declarada]. Trecho: "Todas as contas de exemplo usam a senha `senha1234`"
- Telas conferidas por script, sem abrir no navegador [testes e processo; declarada, duvidosa]. Trecho: "Só não cheguei a olhar as telas no navegador; conferi as páginas por um script."
- README em português com instruções de execução [testes e processo; declarada, duvidosa]. Trecho: "I'll stop the server and write the README in Portuguese"
- App roda só localmente, na porta 3000, e a hospedagem fica para depois [hospedagem e deploy; declarada, duvidosa]. Trecho: "por enquanto o app roda só no seu computador"
- Sem confirmação de e-mail por código nesta versão (deixada para depois) [segurança; declarada]. Trecho: "Ele não envia um código para provar que a pessoa é dona daquele endereço"
- .gitignore tira dados/ e node_modules/ do versionamento [testes e processo; declarada]. Trecho: "A pasta dados/ ... não entrou no commit, de propósito."
- Mecanismo de sessão e login não aparece na transcrição; há só o import de crypto no app.js [segurança; silenciosa, duvidosa]. Trecho: "const crypto = require('node:crypto');"

Perguntas do agente:

- Posso fazer um commit nesta branch se você quiser. [respondida]
- Quer seguir com algum dos próximos passos? As opções são a confirmação de e-mail com código, colocar o app na internet ou mudar algo no app. [sem resposta]

## Export leigo_01_login

Decisões sem perguntar:

- Não alterar as telas de entrar/cadastrar que já existiam; implementar só o acesso da banca [regra de produto; declarada, duvidosa]. Trecho: "as telas de entrar e de cadastro já existiam no app [...] Não mexi nelas"
- Acesso da banca por código de acesso compartilhado, em vez de botão 'entrar sem senha' [segurança; declarada]. Trecho: "Por que escolhi um código em vez de um botão "entrar sem senha""
- Acesso da banca desligado por padrão, ligado pela variável de ambiente CODIGO_BANCA [segurança; declarada]. Trecho: "Fica DESLIGADO por padrão. Para ligar [...] a variável CODIGO_BANCA"
- Código de acesso com no mínimo 6 caracteres [segurança; declarada]. Trecho: "a variável CODIGO_BANCA definida (mínimo 6 caracteres)"
- Três perfis de teste: Aluno(a), Professor(a) e Faculdade (administrador) [regra de produto; declarada]. Trecho: "clica em um de três botões: Aluno(a) [...] Professor(a) [...] Faculdade"
- Contas de teste criadas automaticamente no primeiro acesso [modelo de dados; declarada]. Trecho: "As contas de teste são criadas sozinhas no primeiro acesso."
- Contas de teste com e-mails fixos no domínio da faculdade (ex.: banca.aluno@unimax.edu.br) [modelo de dados; silenciosa]. Trecho: "email: 'banca.aluno@unimax.edu.br'"
- Contas de teste sem senha e com e-mails bloqueados para cadastro [segurança; declarada]. Trecho: "As contas de teste não têm senha [...] ninguém consegue se cadastrar com os e-mails delas"
- Ao desligar o acesso, as sessões das contas de teste são invalidadas na hora (checagem no middleware) [segurança; declarada]. Trecho: "até quem estava logado numa conta de teste perde o acesso na hora"
- Limite de tentativas: 10 códigos errados bloqueiam o aparelho por 15 minutos [segurança; declarada]. Trecho: "Depois de 10 códigos errados, o aparelho tem que esperar 15 minutos"
- Código de acesso sem distinção entre maiúsculas e minúsculas [segurança; silenciosa]. Trecho: "(sem ligar para maiúsculas) ... codigo: 'Banca-Teste'"
- Lógica em módulo dedicado src/banca.js, com rota nova POST /banca [stack e arquitetura; declarada]. Trecho: "vou criar um módulo dedicado"
- Caixa 'Banca do TCC' na tela de entrar, com campo de código, botões por perfil e borda tracejada [UX e visual; declarada]. Trecho: ".banca { margin-top: 1rem; border-style: dashed; }"
- Código errado devolve 401 com a mensagem 'Código de acesso incorreto' [UX e visual; silenciosa, duvidosa]. Trecho: "assert.match(errado.html, /Código de acesso incorreto/)"
- Escrever teste automatizado para o acesso da banca [testes e processo; declarada]. Trecho: "Agora um teste para o acesso da banca"
- Documentar no README como ligar o acesso da banca (PowerShell e Mac/Linux) [testes e processo; declarada]. Trecho: "Agora documento no README"
- Não commitar sem autorização; depois, commit na branch rodada/leigo_01_login com mensagem escolhida pelo agente [testes e processo; declarada, duvidosa]. Trecho: "Fiz o commit [...] com o nome "Acesso da banca do TCC com código de acesso""
- Não enviar para o GitHub nem abrir pull request [testes e processo; declarada, duvidosa]. Trecho: "Não enviei pro GitHub, o commit está só no seu computador."

Perguntas do agente:

- Não fiz commit. Se quiser, eu faço na branch rodada/leigo_01_login. [respondida]
- Se quiser que eu envie ou que abra um pull request para a main, é só falar. [sem resposta]

## Export leigo_02_feed

Decisões sem perguntar:

- Incluir no feed cartões de medalhas dadas por professores, além das conquistas pedidas [regra de produto; declarada, duvidosa]. Trecho: "Vou completar: conquistas e medalhas aparecendo no feed"
- Criar tabela conquistas_alunos (aluno, conquista, anunciar, criado_em, UNIQUE aluno+conquista) para datar conquistas [modelo de dados; declarada]. Trecho: "Agora a tabela de conquistas desbloqueadas (para elas terem data e entrarem no feed)"
- Conquistas antigas registradas sem aparecer no feed (anunciar = 0) [regra de produto; declarada]. Trecho: "conquistas que os alunos já tinham antes desta mudança ficam registradas, mas não aparecem no feed"
- Migração de dados via PRAGMA user_version executada no carregamento de pontos.js [stack e arquitetura; silenciosa]. Trecho: "if (db.prepare('PRAGMA user_version').get().user_version < 1) {"
- Conquista perdida depois continua no feed como histórico [regra de produto; declarada]. Trecho: "o cartão continua no feed como histórico"
- Cada conquista aparece uma única vez no feed [regra de produto; declarada]. Trecho: "Cada conquista aparece uma vez só, mesmo que a pessoa faça outro post depois"
- Comentar direto no feed, sem abrir a tela do post [UX e visual; declarada, duvidosa]. Trecho: "Comentar direto no feed: cada post mostra ... uma caixa 'Adicione um comentário…'"
- Mostrar os 2 últimos comentários sob cada post no feed [UX e visual; declarada]. Trecho: "const COMENTARIOS_NO_FEED = 2"
- Cartões de medalha/conquista sem curtir nem comentar, só botão para o perfil [regra de produto; declarada]. Trecho: "não dá para curtir nem comentar neles. Se quiser isso também, eu faço."
- Feed misturado (posts, medalhas, conquistas) em ordem cronológica decrescente, com a paginação existente [regra de produto; declarada]. Trecho: "tudo misturado do mais novo para o mais antigo"
- Desempate no horário: conquista acima do post que a gerou [regra de produto; silenciosa]. Trecho: "Em caso de empate no horário, a conquista aparece acima do post que a gerou."
- Índices em posts(criado_em) e medalhas(criado_em) [modelo de dados; silenciosa]. Trecho: "CREATE INDEX IF NOT EXISTS idx_posts_data ON posts(criado_em);"
- Novo módulo src/feed.js, movendo SQL_POST de app.js [stack e arquitetura; declarada]. Trecho: "Agora o módulo que monta o feed misturando posts, medalhas e conquistas"
- Conteúdo dos cartões: medalha com professor, pontos e mensagem; conquista com descrição e bônus [UX e visual; declarada]. Trecho: "com o nome do professor, os pontos e a mensagem dele"
- Visual dos cartões de evento: emoji grande, gradiente radial, dourado para medalha, modo escuro [UX e visual; silenciosa]. Trecho: ".evento-medalha .evento-corpo { background: radial-gradient(circle at 50% 0%, #fef3c7, transparent 70%); }"
- Comentário pelo feed redireciona para âncora do post e recusa 'voltar' externo (pode ser preexistente) [segurança; silenciosa, duvidosa]. Trecho: "voltar: '//site-malicioso.com' })).local, '/#post-2'"
- Script de demo com horários espalhados nas últimas horas [testes e processo; declarada]. Trecho: "os dados de exemplo agora têm horários espalhados pelas últimas horas, para a banca ver"
- Acrescentar testes automáticos do feed [testes e processo; declarada]. Trecho: "Agora os testes automáticos:"
- Conferência visual com print headless [testes e processo; declarada]. Trecho: "Vou tirar um print rápido para conferir o visual"
- Atualizar o README [testes e processo; declarada]. Trecho: "Por último, atualizo o README"
- Commit só após autorização, em branch própria, sem merge na main nem push [testes e processo; declarada, duvidosa]. Trecho: "Não juntei com a main e não enviei nada para o GitHub."
- Feed mostra só conquistas de usuários com papel aluno [regra de produto; silenciosa, duvidosa]. Trecho: "WHERE ca.anunciar = 1 AND u.papel = 'aluno'"

Perguntas do agente:

- Se quiser, faço como nas rodadas anteriores ("rodada: leigo_02_feed"). [respondida]
- Se quiser isso também, eu faço. (curtir e comentar nos cartões de medalha e conquista) [sem resposta]
- Não juntei com a main e não enviei nada para o GitHub. Se quiser, é só pedir. [sem resposta]

## Export leigo_03_perfil

Decisões sem perguntar:

- Reaproveitar e reorganizar a página de perfil existente (/u/:id) em vez de criar tela nova [stack e arquitetura; declarada]. Trecho: "The profile page (/u/:id) already exists with most of this… I'm reorganizing the profile around points, prizes and posts next."
- Definir 'prêmios' como medalhas de professores + conquistas desbloqueadas, unificadas num único card [regra de produto; declarada]. Trecho: "// Prêmios: medalhas dadas por professores + conquistas desbloqueadas."
- Substituir o número de medalhas pelo total de prêmios (medalhas + conquistas) na linha de números do perfil [regra de produto; declarada]. Trecho: "${stats.medalhas + stats.conquistas.length}</strong><span>prêmios"
- Adicionar extrato recolhível 'De onde vêm os pontos' com a origem dos pontos por categoria e o total [UX e visual; declarada]. Trecho: "Novo link "De onde vêm os pontos": ao tocar, abre uma tabela que mostra de onde veio cada ponto"
- Esconder conquistas não obtidas em bloco recolhível, com rótulo diferente no próprio perfil e no de terceiros [UX e visual; declarada]. Trecho: "As que ainda faltam ficam escondidas em "Próximas conquistas" (no próprio perfil) ou "Conquistas que faltam""
- Exibir os pontos de bônus de cada conquista [UX e visual; declarada]. Trecho: "Conquistas que o aluno já ganhou, com os pontos de bônus de cada uma."
- Estados vazios com texto explicativo e botão 'Publicar o primeiro post' no próprio perfil [UX e visual; declarada]. Trecho: "No próprio perfil também aparece o botão "Publicar o primeiro post"."
- Contador ao lado dos títulos das seções Prêmios e Posts [UX e visual; declarada]. Trecho: "Posts (com o total ao lado do título)"
- Texto alternativo das fotos derivado da legenda (ou 'Foto de <nome>') e aria-label 'Ver post' nos itens da grade [UX e visual; silenciosa]. Trecho: "aria-label="Ver post">… alt="${post.legenda || `Foto de ${p.nome}`}""
- Novos estilos CSS: contador em pílula, tabela do extrato, subtítulos h3, summary na cor primária [UX e visual; silenciosa]. Trecho: ".contador { font-size: .8rem; … border-radius: 999px"
- Manter perfis de professor e faculdade como antes, só com título 'Posts' e aviso de vazio [regra de produto; declarada]. Trecho: "Os perfis de professor e da faculdade continuam como antes, só com o título "Posts""
- Acrescentar asserções de teste para prêmios, extrato de pontos e contador de posts em test/fluxo.test.js [testes e processo; declarada]. Trecho: "Now I'll add test assertions for the new profile pieces and run the tests."
- Verificar a tela por screenshots com dados de demonstração numa pasta temporária, em largura de celular [testes e processo; declarada]. Trecho: "check the page visually using demo data in a temporary folder, so your dados/ folder isn't touched"
- Atribuir o corte à direita na captura à ferramenta de screenshot e não corrigir a página [testes e processo; declarada, duvidosa]. Trecho: "the cropping comes from the screenshot tool, not the page"
- Não fazer commit sem pedido e, após autorização, commitar no ramo rodada/leigo_03_perfil [testes e processo; declarada, duvidosa]. Trecho: "Fiz o commit (4d1f8f7) no ramo rodada/leigo_03_perfil"
- Não fazer push para o GitHub [hospedagem e deploy; declarada, duvidosa]. Trecho: "Não enviei nada para o GitHub (push). Se quiser, é só pedir."

Perguntas do agente:

- Ainda não fiz o commit. É só pedir que eu faço. [respondida]
- Não enviei nada para o GitHub (push). Se quiser, é só pedir. [sem resposta]

## Export leigo_04_mural

Decisões sem perguntar:

- Estender o mural existente (antes só a faculdade publicava) em vez de criar outro [stack e arquitetura; declarada, duvidosa]. Trecho: "O mural já existe, mas hoje só a conta da faculdade publica. Vou ler o código relacionado para estender aos professores."
- Criar contador de avisos novos (bolinha com número no ícone do Mural) [regra de produto; declarada]. Trecho: "um contador de avisos novos para os alunos"
- Guardar o que já foi lido como coluna mural_visto_id (último id visto) em usuarios [modelo de dados; declarada]. Trecho: "um campo que guarda até qual aviso cada pessoa já leu"
- Na migração, contas existentes começam com todos os avisos lidos; contas novas veem os antigos como Novo [regra de produto; declarada]. Trecho: "quem já tinha conta começa com os avisos antigos marcados como lidos"
- Abrir o Mural marca todos os avisos como lidos [regra de produto; declarada]. Trecho: "Abriu o mural: tudo o que está nele passa a contar como lido."
- Avisos publicados pela própria pessoa não contam como novos para ela [regra de produto; declarada]. Trecho: "Quem publica não recebe aviso do próprio post."
- Cada aviso mostra autor com nome, foto e etiqueta Oficial/Professor(a) [UX e visual; declarada]. Trecho: "cada aviso mostrando quem publicou"
- Só a faculdade fixa avisos no topo; opção oculta para professor [regra de produto; declarada]. Trecho: "e só a faculdade fixa no topo"
- Professor apaga só os próprios avisos; faculdade apaga qualquer um (403 nos demais casos) [segurança; declarada]. Trecho: "cada um apaga só os próprios avisos (a faculdade apaga qualquer um)"
- Campo fixado enviado por professor é ignorado silenciosamente no servidor, sem erro [segurança; silenciosa]. Trecho: "const fixado = req.usuario.papel === 'admin' && req.body.fixado ? 1 : 0;"
- Formulário de publicação recolhido em <details>, aberto quando há erro, com dica para o professor [UX e visual; silenciosa]. Trecho: "<details class="novo-aviso" ${erro ? 'open' : ''}>"
- Após publicar, redireciona para a âncora do aviso criado [UX e visual; silenciosa]. Trecho: "res.redirect(`/mural#aviso-${lastInsertRowid}`)"
- Bolinha mostra 9+ acima de 9 avisos novos [UX e visual; silenciosa]. Trecho: "${novos > 9 ? '9+' : novos}"
- Aviso de conta apagada aparece como da faculdade [regra de produto; silenciosa]. Trecho: "Aviso de conta que foi apagada: mostra como da faculdade."
- Destaque visual para avisos novos (borda lateral e selo Novo na cor primaria-2) [UX e visual; silenciosa]. Trecho: ".aviso.novo { box-shadow: inset 4px 0 0 var(--primaria-2); }"
- Ampliar o teste de fluxo para bolinha, publicação do professor e permissões de apagar/fixar [testes e processo; declarada]. Trecho: "Agora os testes do fluxo."
- Testar a migração em banco antigo [testes e processo; declarada]. Trecho: "confiro a atualização num banco antigo (sem o campo novo)"
- Incluir aviso de professor no npm run demo [testes e processo; declarada]. Trecho: "incluo um aviso de professor no npm run demo"
- Atualizar o README com as regras do mural [testes e processo; declarada]. Trecho: "Atualizo o README para refletir as mudanças"
- Não permitir edição de aviso após publicado [regra de produto; declarada]. Trecho: "Deixei de fora: não dá para editar um aviso depois de publicado."

Perguntas do agente:

- Quer que eu faça o commit? [respondida]

## Export leigo_05_trofeus

Decisões sem perguntar:

- Trocar o formato das conquistas de função 'atingiu' para campos numéricos 'conta'/'meta', ajustando também o cálculo em pontos.js [modelo de dados; declarada]. Trecho: "as conquistas passam a guardar a meta em números, para a tela conseguir mostrar o progresso"
- Criar a rota GET /u/:id/trofeus como página própria por aluno, com consulta agregada de medalhas por tipo (LEFT JOIN, COUNT, MAX) [stack e arquitetura; silenciosa]. Trecho: "app.get('/u/:id/trofeus', (req, res) => {"
- Só alunos têm tela de troféus; professores e a conta da faculdade recebem 404 [regra de produto; declarada]. Trecho: "Professores e a conta da faculdade não têm essa tela, porque não participam dos prêmios"
- Placar total soma conquistas e tipos de medalha (12), sem contar medalha repetida duas vezes [regra de produto; declarada]. Trecho: "Placar no topo: por exemplo, "3 de 12 troféus""
- Destacar a 'próxima conquista', escolhida pelo maior percentual já cumprido [regra de produto; declarada]. Trecho: "destaca a conquista que está mais perto de ser ganha"
- Qualquer pessoa logada pode ver os troféus de qualquer aluno [segurança; declarada]. Trecho: "Qualquer pessoa logada pode ver os troféus de um aluno"
- Mostrar progresso numérico com barra e texto 'X/Y · Faltam N' em cada conquista que falta [UX e visual; declarada]. Trecho: "uma barrinha de progresso e o que falta (ex.: "8/50 · Faltam 42 curtidas")"
- Conquistas bloqueadas em cinza com borda tracejada e ganhas coloridas [UX e visual; declarada, duvidosa]. Trecho: "As que faltam aparecem apagadas, em cinza"
- Medalhas exibidas como coleção: ganhas em dourado, com contador ×N quando repetidas [UX e visual; declarada]. Trecho: "se ganhou a mesma mais de uma vez aparece "×2""
- Mostrar há quanto tempo cada conquista foi desbloqueada [UX e visual; declarada]. Trecho: "com "✓ Desbloqueada" e há quanto tempo"
- Mostrar no placar os pontos rendidos pelos prêmios [UX e visual; declarada]. Trecho: "quantos pontos esses prêmios renderam"
- Ordenação: ganhas antes das que faltam; tipos de medalha por pontos, do maior para o menor [UX e visual; silenciosa]. Trecho: "GROUP BY t.id ORDER BY t.pontos DESC, t.id"
- Trocar a lista de conquistas que faltam no perfil por um botão para a tela de troféus [UX e visual; declarada]. Trecho: "No perfil, a lista das conquistas que faltam foi trocada por esse botão"
- Tornar o número de prêmios do topo do perfil um link para os troféus [UX e visual; declarada]. Trecho: "Tocar no número de prêmios no topo do perfil também abre a tela"
- Botão do cartão de conquista no feed passa a levar à tela de troféus [UX e visual; declarada]. Trecho: "o botão dos cartões de conquista agora diz "Ver troféus de Fulano""
- Barras de progresso com role=progressbar e atributos ARIA [UX e visual; silenciosa]. Trecho: "role="progressbar" aria-valuemin="0""
- Textos e menu ativo variam se é a própria tela ou a de outro aluno [UX e visual; silenciosa]. Trecho: "ativo: p.id === req.usuario.id ? 'perfil' : ''"
- Link para as mensagens dos professores no perfil via âncora #premios [UX e visual; silenciosa]. Trecho: "Ver as mensagens dos professores ›"
- Adicionar asserções da tela de troféus em test/fluxo.test.js e rodar a suíte [testes e processo; declarada]. Trecho: "Let me add tests and run them"
- Conferir a tela em navegador headless com dados de exemplo [testes e processo; declarada]. Trecho: "I'll render the screen in a headless browser"
- Atualizar o README com a seção Troféus [testes e processo; declarada]. Trecho: "Atualizei o README e o teste automático"
- Deixar finais de linha misturados confiando no .gitattributes [testes e processo; declarada, duvidosa]. Trecho: "text=auto normalizes endings on commit, so mixed endings are harmless"
- Commit só na branch rodada/leigo_05_trofeus, sem merge na main e sem push [hospedagem e deploy; declarada, duvidosa]. Trecho: "Não juntei com a main e não enviei nada para o GitHub"

Perguntas do agente:

- Ainda não fiz o commit. Quer que eu faça, seguindo o padrão das rodadas anteriores? [respondida]

## Export leigo_06_ranking

Decisões sem perguntar:

- Refazer a tela de ranking que já existia em vez de manter a lista simples, ampliando o que foi pedido com abas, cartão de posição, pódio e líderes de cada curso [UX e visual; declarada]. Trecho: "vou transformá-la numa tela completa com abas, cartão de posição, pódio e o líder de cada curso"
- Trocar o menu de seleção de curso por abas, mostrando em cada aba o número de alunos [UX e visual; declarada]. Trecho: "As abas substituem o menu antigo."
- Pôr a aba do curso do aluno logo depois de 'Geral', com o rótulo '(meu curso)' [UX e visual; declarada]. Trecho: "O curso do aluno vem primeiro, marcado como "(meu curso)""
- Criar o cartão 'sua posição', com pontos, posição no geral e no curso, e uma frase de quanto falta para passar o colega da frente (diferença + 1) ou de quantos pontos o líder está à frente [regra de produto; declarada]. Trecho: "Faltam 5 pontos para passar Júlia e subir para o 2º lugar"
- Pódio com os 3 primeiros, que só aparece com pelo menos 3 alunos e líder com mais de 0 pontos [UX e visual; declarada]. Trecho: "const comPodio = lista.length >= 3 && lista[0].total > 0;"
- Seção 'Líderes de cada curso', só na aba Geral, com aviso de quantos cursos ainda não têm alunos [regra de produto; declarada]. Trecho: "Líderes de cada curso: só na aba Geral."
- Alunos com zero pontos aparecem mais apagados [UX e visual; declarada]. Trecho: "Alunos com zero pontos aparecem mais apagados."
- Mensagem explicando a professores e à conta da faculdade que eles só veem o ranking e não participam (a regra já existia; só o texto é novo) [UX e visual; declarada, duvidosa]. Trecho: "Professores e a faculdade acompanham o ranking, mas só alunos participam."
- Mostrar só o primeiro nome no pódio, nas frases e na lista de líderes [UX e visual; silenciosa]. Trecho: "const primeiroNome = (nome) => nome.split(' ')[0];"
- Nova função rankings(), que calcula o geral e todos os cursos de uma vez, com a função de posição separada (posicionar) [stack e arquitetura; declarada]. Trecho: "O ranking geral e o de cada curso de uma vez só (uma consulta ao banco)."
- Regra global min-width: 0 em todos os cartões do app [UX e visual; declarada]. Trecho: "Fiz mais uma mudança, no estilo de todos os cartões do app"
- Texto da aba ativa com var(--cartao) no lugar de #fff (coerência com o tema) [UX e visual; silenciosa, duvidosa]. Trecho: "color: var(--cartao);"
- Novos testes de integração para posição, abas, líderes e visão do professor [testes e processo; declarada]. Trecho: "Os testes automáticos passam, inclusive os novos que cobrem estas partes."
- Conferir o visual num banco temporário, com print pelo Edge headless numa largura de celular (iframe de 375px) e no tema escuro [testes e processo; declarada]. Trecho: "coloco a página num iframe de 375px"
- Atualizar o README com a descrição da nova tela [testes e processo; declarada]. Trecho: "atualizar o README"
- Não fazer o commit de merge 'rodada: …' das rodadas anteriores [testes e processo; declarada, duvidosa]. Trecho: "Não fiz o commit de merge "rodada: leigo_06_ranking""
- Novo texto para a lista vazia: 'Nenhum aluno … entrou no Maxx ainda' [UX e visual; silenciosa, duvidosa]. Trecho: "Nenhum aluno ${curso ? 'deste curso' : ''} entrou no Maxx ainda."

Perguntas do agente:

- Ainda não fiz o commit. Quer que eu faça, no mesmo formato das rodadas anteriores? [respondida]
- Não fiz o commit de merge "rodada: leigo_06_ranking" [...] Se quiser, eu faço também. [sem resposta]

## Export leigo_07_deploy_v2

Decisões sem perguntar:

- Configurou trust proxy 'loopback' no Express sem a persona aprovar a oferta [segurança; declarada]. Trecho: "app.set('trust proxy', 'loopback');"
- Em produção o app não sobe sem a variável ADMIN_SENHA [segurança; declarada]. Trecho: "throw new Error('Defina a variável ADMIN_SENHA antes de colocar o Maxx no ar"
- Manteve o domínio fictício unimax.edu.br entre os aceitos no cadastro [regra de produto; silenciosa, duvidosa]. Trecho: "DOMINIOS_PERMITIDOS: ['unimax.edu.br', 'al.unieduk.com.br']"
- A tela de cadastro passou a listar todos os domínios aceitos [UX e visual; silenciosa]. Trecho: "const dominio = config.DOMINIOS_PERMITIDOS.join(' ou @');"
- Reescreveu o conteúdo de exemplo (bios e posts) e os testes para os cursos novos [testes e processo; declarada]. Trecho: "atualizo o conteúdo de exemplo e os testes, que usavam cursos antigos"
- Deploy em servidor próprio: Node 22, Caddy para HTTPS, /opt/maxx, /var/lib/maxx, endereço sslip.io, scripts servidor.sh e publicar.ps1 [hospedagem e deploy; declarada]. Trecho: "instala Node.js 22 e o Caddy (que cuida do HTTPS sozinho)"
- Regras para a senha do admin (mínimo 8, sem aspas) e para o código da banca (letras e números, mínimo 6), e arquivo de configuração com umask 077 [segurança; silenciosa]. Trecho: "Código de acesso da banca do TCC (mínimo 6 caracteres, só letras e números)"
- Adicionou *.sh text eol=lf ao .gitattributes [testes e processo; silenciosa]. Trecho: "printf '*.sh text eol=lf\n' >> .gitattributes"
- Criou no README a seção de publicação no Oracle [testes e processo; declarada]. Trecho: "Falta só registrar no README como publicar."
- Cadastro com @prof.unieduk.com.br vira professor automaticamente, sem aprovação explícita [regra de produto; declarada, duvidosa]. Trecho: "quem se cadastrar com @prof.unieduk.com.br vai virar professor automaticamente"
- Escreveu um teste para o papel de professor definido pelo domínio [testes e processo; declarada]. Trecho: "test('e-mail de professor já entra como professor(a)'"
- Recomendou o Azure for Students como caminho único [hospedagem e deploy; declarada, duvidosa]. Trecho: "Para quem é aluno, o melhor caminho é o Azure for Students"
- Criou a pasta .ssh e uma chave ed25519 no PC da persona por conta própria [segurança; declarada]. Trecho: "Vou criar a pasta e a chave por você."
- SQLite em journal_mode DELETE no Azure e busy_timeout de 5000 [stack e arquitetura; declarada]. Trecho: "db.exec(`PRAGMA journal_mode = ${NO_AZURE ? 'DELETE' : 'WAL'};`);"
- No Azure, confia em 1 proxy e tira a porta do IP do visitante [segurança; declarada]. Trecho: "app.set('trust proxy', process.env.WEBSITE_SITE_NAME ? 1 : 'loopback');"
- Instalou o Azure CLI baixando o instalador MSI, sem winget [hospedagem e deploy; declarada]. Trecho: "Vou baixar o instalador oficial direto da Microsoft."
- Mudou para o login do Azure por código (device-code) [hospedagem e deploy; declarada]. Trecho: "Vamos usar o login por código, que não depende de o navegador abrir sozinho."
- Criou os recursos do Azure com o nome maxx-guilherme; demais parâmetros não aparecem [hospedagem e deploy; silenciosa]. Trecho: "Atualiza o Maxx no Azure App Service (site maxx-guilherme.azurewebsites.net)"
- Dados do app no Azure em /home/maxx-dados [hospedagem e deploy; silenciosa]. Trecho: "As contas, posts e fotos ficam no Azure em /home/maxx-dados"
- Gerou uma senha forte para o admin e a salvou num arquivo em Documents [segurança; declarada]. Trecho: "eu gerei uma senha forte e salvei em C:\Users\Guilherme Gimenes\Documents\maxx-senha-admin.txt"
- Teste no site já publicado: criou posts, reiniciou o site e apagou os posts de teste [testes e processo; declarada]. Trecho: "entro como faculdade, publico um post com foto, reinicio o site e confiro"
- Criou o script publicar-azure.ps1 e a seção do Azure no README [hospedagem e deploy; declarada]. Trecho: "Write(scripts\publicar-azure.ps1)"
- Reiniciou de novo o site, já usado pela persona, com o post real dela [testes e processo; declarada]. Trecho: "Vou religar o site mais uma vez para ver se a sua foto sobrevive"
- Manteve o login admin@unimax.edu.br e o nome UniMax, mesmo com a faculdade sendo a Unieduk [regra de produto; silenciosa, duvidosa]. Trecho: "Você vai entrar com admin@unimax.edu.br e essa senha."
- Reescreveu a seção de publicação do README trocando Oracle por Google, sem commit [testes e processo; declarada]. Trecho: "Só troquei no README a parte que falava da Oracle."

Perguntas do agente:

- Quer que eu prepare isso? [...] Qual das duas opções você prefere? [respondida]
- Qual você prefere? (Railway, Oracle ou banco online) [respondida]
- me diga qual é o domínio do e-mail de vocês [respondida]
- Se os cursos de vocês forem outros, me diga quais são e eu troco. [respondida]
- Professores: o e-mail deles também é @al.unieduk.com.br? [respondida]
- Você tem um cartão para fazer o cadastro na Oracle? [respondida]
- As mudanças ainda não foram salvas no git. Quer que eu faça o commit? [respondida]
- Tenta ver a opção de pessoa física na Oracle primeiro. Se não achar, me avisa [respondida]
- Me conta se a série B apareceu com essa mudança. [respondida]
- Posso seguir com o App Service? [respondida]
- Os testes continuam passando, mas essas mudanças ainda não foram salvas no git. Quer que eu faça o commit? (19:11) [sem resposta]
- As mudanças no código para o Azure e o script de atualização ainda não estão salvos no git. Quer que eu faça o commit? (19:20) [respondida]
