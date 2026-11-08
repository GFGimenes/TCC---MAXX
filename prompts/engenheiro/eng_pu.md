ID: eng_pu
Trilha: engenheiro, condição de prompt único
Tela: produto inteiro numa mensagem só (sem rodadas)
Data: a preencher no envio
Origem: rascunho do Cowork (Anthropic) montado a partir de `eng_00_produto.md` e `eng_00_tecnica.md`, para revisão do autor. Pré-registro pendente: o arquivo só vale depois de revisado e commitado antes da sessão.

Notas de registro:
- Mesmo conteúdo das duas aberturas da trilha iterativa, numa mensagem só. Saíram as frases que organizam turnos ("Nesta mensagem vai só o produto; a parte técnica vem na próxima", "Na próxima mensagem digo onde isso está", "Só confirme o entendimento... nada de código", "Vamos trabalhar da seguinte maneira: ... eu reviso", "Pergunte antes de decidir; me dê opções com pesos", "revisado por mim"), substituídas por instruções de decidir sozinho e registrar nos docs. Nenhuma regra de produto ou técnica foi acrescentada ou removida.
- Fechamento comum às duas personas (mesmo parágrafo final no `leigo_pu`).
- Diferenças declaradas em relação à abertura iterativa, por decisão do autor (08/11): o repositório `maxx-engenheiro-pu` começa vazio e sem a pasta `design/`, então o prompt pede que o agente defina a identidade visual e desenhe as telas; e não há deploy nem criação de conta em serviço externo, só a infraestrutura descrita e configurável, com emulador local. Na trilha iterativa o engenheiro entregou o design e o deploy é passo do plano.
- Texto mantém a apresentação para banca com QR code, como na abertura original, por fidelidade ao que a persona entregou; a avaliação remota é decisão posterior do experimento, não da persona.

---
Gostaria de criar uma aplicação chamada Maxx dentro deste repositório. A aplicação é para a UniMax, instituição de ensino de Indaiatuba, interior de São Paulo (rede UniEduk, com a UniFaj). A ideia é um aplicativo de celular parecido com uma rede social, tipo Instagram mas sem stories, sem reels e sem mensagens entre usuários, com fortes elementos de gamificação: os alunos recebem prêmios e medalhas por participação em eventos e méritos em aula, e isso vira pontos, ranking e um feed onde eles mostram as conquistas. Primeiro o produto, depois a parte técnica; está tudo nesta mensagem.

Existem três tipos de usuário: aluno, professor e instituição (coordenação e secretaria). Ninguém de fora entra.
Aluno: tem RA, curso e semestre. Faz posts com foto, ganha prêmios por comparecer em eventos, palestras, fazer apresentações e outros itens definidos pela instituição, ganha medalhas, acumula pontos, aparece nos rankings, segue outros alunos para ver os posts deles e lê o mural de avisos.
Professor: vinculado às turmas em que dá aula. Dá medalhas só aos alunos com quem tem aula (por presença, notas, ajuda em sala e outros critérios definidos pela instituição), revisa os posts de comprovação de prêmio dos alunos dele e publica avisos para as turmas.
Instituição: cadastra os prêmios disponíveis e os critérios, concede troféus, valida comprovações, publica avisos da faculdade e do curso.

Login e cadastro somente com e-mail institucional ou RA (aluno por RA ou e-mail; professor por e-mail institucional). Sem login social. Ex-aluno mantém o acesso e a posição no ranking, mas não pontua mais.

Existem dois tipos de prêmio: troféus (concedidos pela instituição ou por regra automática, como assiduidade, participação em evento, acúmulo de medalhas) e medalhas (dadas por professores). Todo prêmio tem um tier, e o tier define os pontos: Bronze de 1 a 30, Prata de 31 a 70, Ouro de 71 a 100, Diamante de 101 a 150. O aluno não tem tier: a pontuação dele é a soma dos pontos dos prêmios, e o ranking é só a posição numérica.
Alguns prêmios têm progressão: a mesma conquista repetida (média 10 numa matéria em semestres diferentes, por exemplo) rende um prêmio novo, um tier acima do anterior, até o Diamante; o aluno guarda todos os prêmios da progressão.
Alguns prêmios exigem comprovação por foto, validada pela instituição ou pelo professor da turma. Um prêmio pode ser contestado por um professor das turmas do aluno (inclusive quem o concedeu) ou pela instituição, informando o motivo. A contestação vai para a instituição averiguar; enquanto isso o prêmio fica como “em averiguação”, visível para o aluno, e deixa de pontuar. A instituição decide: confirma, e os pontos voltam, ou revoga, e o prêmio sai da pontuação mas fica no histórico com o motivo.

Sobre os rankings, terão quatro visões: ranking geral e ranking por curso, cada um do semestre atual e histórico (all time). Medalhas e prêmios contam pontos e os pontos definem a posição de cada aluno.

As telas serão: login e cadastro; feed (post com foto, ligado ou não a um prêmio); perfil do aluno (pontos, posição, prêmios); mural de avisos (faculdade, curso, professores); troféus e medalhas (o que já ganhou e o que ainda falta); rankings.

A primeira fase é o meu TCC, com uma apresentação para uma banca rotativa. Só nessa apresentação existe um login/registro de demo, ligado por configuração: quem entrar por ali cai num registro simples (foto opcional, nome e escolha de um dos três cursos de demonstração, já populados) e vira um aluno de demonstração, numa turma de demonstração desse curso, com tudo que um aluno tem. Se a pessoa voltar pelo mesmo dispositivo, pode entrar no usuário que criou ou criar um novo. Os dados da demo são semeados (os três cursos, turmas, prêmios, posts, ranking) e marcados para eu apagar depois. Esse modo não existe fora da apresentação.

Não há design pronto. Defina a identidade visual (paleta, tipografia, tema claro e escuro) e desenhe as seis telas, o cadastro e a entrada da demo a partir do que descrevi, registrando as decisões de design no repositório.

Agora a parte técnica. Sou engenheiro backend e este é o meu projeto.

Campus de 3.200 alunos, com pico de 2.000 usuários simultâneos em eventos. Na apresentação do TCC, no máximo 10 a 20 pessoas ao mesmo tempo. Fotos nos posts. Então: custo mínimo agora, mas um desenho que aguenta o pico sem reescrever.

Pensei na stack como: cliente em Expo (React Native + TypeScript) com Expo Router, um código só para web, Android e iOS. A web é o acesso principal da primeira fase: na apresentação a banca escaneia um QR code e abre o app no navegador, em celular ou notebook, servido pelo Caddy; no notebook, o app aparece centralizado numa moldura de largura de celular. O nativo fica pronto para publicar (projeto configurado para build e um APK gerado), sem publicar nas lojas nesta fase. O que difere entre web e nativo (guarda de token, câmera, notificação) é resolvido primeiro para a web, com o equivalente nativo declarado.
API em ASP.NET Core (LTS vigente) com EF Core e PostgreSQL. Contrato pelo OpenAPI da API, com cliente TypeScript gerado. Fotos em storage S3-compatível com CDN na frente. Docker Compose numa VPS com Caddy, que também serve o build web. Não faça deploy nem crie conta em serviço nenhum (VPS, bucket, CDN, domínio): deixe a infraestrutura descrita e configurável por variável de ambiente, pronta para eu subir, e use emulador local para o que depender de serviço externo. Testes: xUnit com Testcontainers na API; no cliente e no e2e, escolha e justifique. Se tiver alguma contraindicação nessa stack, registre e decida.

Agora sobre a arquitetura: monorepo, com Maxx.sln na raiz, apps/api, apps/mobile, packages/api-client (gerado do OpenAPI), docker-compose.yml e CI com um job por pasta.
API em camadas: endpoints, casos de uso, domínio e infraestrutura; regras de produto no domínio, validação na borda, um formato só de erro.
Fotos nunca passam pela API: ela assina URLs; o app faz upload direto no bucket privado e lê pela CDN, que busca no bucket quando não tem em cache.
Cache em camadas e só onde medido: fotos na CDN; no app, cache de consultas com stale-while-revalidate (abre com o que já tinha e atualiza por trás); na API, ETag no feed e no perfil, com 304 sem corpo. Micro-cache em memória da primeira página do feed só se o teste de carga pedir (alvo: p95 de 300 ms nas leituras com 2.000 usuários virtuais). Sem Redis. Nada que dependa de quem pede (linha do próprio aluno, quem eu sigo, lido ou não) vai para cache compartilhado.
API sem estado, para rodar duas réplicas atrás do Caddy. Feed paginado por cursor com índice, sem offset. Ranking pré-calculado por job, nas quatro visões.
Tudo que o usuário precisa ver na hora (post, curtida, leitura de aviso) é síncrono. O que pode esperar (recálculo de ranking, limpeza de uploads abandonados, notificações) vai para uma fila numa tabela do Postgres e um worker processa; sem broker. Notificação é registro no banco, mostrado no sininho em qualquer plataforma; push nativo é evolução. O usuário não pode ter a sensação de que o app está demorando.
Autenticação: access token curto em memória e refresh rotativo; na web, o refresh em cookie HttpOnly emitido pela API; no nativo, no secure store. Autorização por papel (aluno, professor, instituição) e por escopo: professor só poderá dar medalhas, por exemplo, nas turmas dele. CORS restrito ao domínio do app. Nada sensível no bundle web nem no binário.
API versionada em /v1, com mudanças só aditivas, porque o app instalado atrasa em relação à API. Pool de conexões dimensionado para o pico; limite de taxa em login, upload e registro de demo.
Segurança, além do que já falei: senha só com hash Argon2id, nunca em texto. A API só assina a URL de upload depois de validar tipo e tamanho do arquivo, e a assinatura prende o content-type. A flag da demo vem desligada por padrão e não existe na configuração de produção; desligada, as rotas de demo respondem 404. Toda concessão e revogação de prêmio ou medalha grava quem fez e quando. Reuso de um refresh token já rotacionado derruba a sessão inteira, e logout revoga. HTTPS automático pelo Caddy, com HSTS e cabeçalhos de segurança (CSP para o build web). Na CI, varredura de dependências vulneráveis e de segredos commitados; .env fora do git, só um .env.example.
Demo: o login de demonstração existe só com uma flag de configuração ligada; alunos e turmas de demo têm um marcador no banco para eu apagar depois; o "voltar pelo mesmo dispositivo" é lembrança local, sem senha. A base inclui os dados semeados (três cursos, turmas, prêmios, posts, ranking).
Sempre que um erro estourar em tela, o usuário recebe uma mensagem amigável.

Como trabalhar: analise tudo o que está aqui, registre pendências, lacunas e as decisões que tomar nos documentos do repositório (um documento de produto, decisões de arquitetura e um plano mestre em passos), e então execute os passos, um de cada vez, até o fim ou até onde conseguir.
Tudo com teste: unitário no domínio, integração com Postgres real, e2e dos fluxos principais. TDD onde couber.
Git: uma branch por feature ou fix, com prefixo e assunto; commits convencionais a cada fechamento de ciclo; PRs pequenos e bem definidos. Lint e formatação desde o primeiro commit.
Clean Code, SOLID, encapsulamento e as boas práticas das linguagens escolhidas. Segredos só em variável de ambiente.
Pronto significa: testes passando, lint limpo, migration aplicada, OpenAPI atualizado.
As regras do projeto (arquitetura, convenções, definição de pronto) ficam gravadas num CLAUDE.md na raiz do repositório.

Essa é a única mensagem que vou mandar nesta sessão: depois dela não respondo mais nada. Faça tudo o que conseguir sozinho, decidindo por conta própria o que eu teria que decidir, e vá até onde der. Quando parar, deixe o repositório num estado que eu consiga abrir e testar, com as instruções de como rodar escritas nele e, commitado, um registro do que você decidiu sem me perguntar e do que ficou faltando.
