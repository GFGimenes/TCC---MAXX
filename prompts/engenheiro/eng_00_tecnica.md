ID: eng_00_tecnica
Trilha: engenheiro
Tela: abertura (definição técnica; segunda mensagem da mesma sessão, enviada depois da resposta a `eng_00_produto`)
Data: 2026-10-11
Origem: texto do autor, revisado no Cowork (Anthropic) em 11/10/2026

---
Agora a parte técnica. Sou engenheiro backend e vou conduzir o projeto. O que quero nesta sessão é a base do Maxx, conversada antes de qualquer código.

Campus de 3.200 alunos, com pico de 2.000 usuários simultâneos em eventos. Na apresentação do TCC, no máximo 10 a 20 pessoas ao mesmo tempo. Fotos nos posts. Então: custo mínimo agora, mas um desenho que aguenta o pico sem reescrever.

Pensei na stack como: cliente em Expo (React Native + TypeScript) com Expo Router, um código só para web, Android e iOS. A web é o acesso principal da primeira fase: na apresentação a banca escaneia um QR code e abre o app no navegador, em celular ou notebook, servido pelo Caddy; no notebook, o app aparece centralizado numa moldura de largura de celular. O nativo fica pronto para publicar (projeto configurado para build e um APK gerado), sem publicar nas lojas nesta fase. O que difere entre web e nativo (guarda de token, câmera, notificação) é resolvido primeiro para a web, com o equivalente nativo declarado.
API em ASP.NET Core (LTS vigente) com EF Core e PostgreSQL. Contrato pelo OpenAPI da API, com cliente TypeScript gerado. Fotos em storage S3-compatível com CDN na frente. Docker Compose numa VPS com Caddy, que também serve o build web. Testes: xUnit com Testcontainers na API; no cliente e no e2e, me dê opções. Se tiver alguma contraindicação nessa stack, me avise antes de propor a base.

Agora sobre a arquitetura: monorepo, com Maxx.sln na raiz, apps/api, apps/mobile, packages/api-client (gerado do OpenAPI), design/, docker-compose.yml e CI com um job por pasta.
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

Vamos trabalhar da seguinte maneira: primeiro você analisa tudo o que passei nas duas mensagens e aponta pendências, lacunas e sugestões. Iremos fazer um plano mestre geral, com passos e etc. Antes de cada passo, iremos fazer um plano com etapas definidas, eu reviso, modificamos se necessário e só então começamos cada etapa desse passo.
Tudo com teste: unitário no domínio, integração com Postgres real, e2e dos fluxos principais, e, o mais importante, revisão humana. TDD onde couber.
Git: uma branch por feature ou fix, com prefixo e assunto; commits convencionais a cada fechamento de ciclo; PRs pequenos e bem definidos. Lint e formatação desde o primeiro commit. Antes de cada commit eu reviso o código.
Clean Code, SOLID, encapsulamento e as boas práticas das linguagens escolhidas. Segredos só em variável de ambiente.
Pronto significa: testes passando, lint limpo, migration aplicada, OpenAPI atualizado e revisado por mim.
As regras do projeto que saírem desta conversa (arquitetura, convenções, definição de pronto) ficam gravadas num CLAUDE.md na raiz do repositório, para valerem em toda sessão daqui em diante.

O design está no repo: design/telas/ (seis telas mais cadastro, em claro e escuro) e design/telas/padrao-visual.png; valores em design/tokens.json; regras em design/identidade-visual.md. Leia os tokens e as regras agora; as telas, quando formos implementar cada uma. A entrada da demo no login não tem tela desenhada: siga a identidade visual.

Proponha a base: estrutura, módulos, modelo de dados inicial, dados semeados para demonstração e pipeline. Discuta o que é interessante para este projeto. Pergunte antes de decidir; onde houver escolha, me dê opções com pesos. Nesta rodada, só depois do total entendimento iremos fazer um plano de ações, e aí sim começaremos cada passo. Nesta rodada, nada de código: o plano mestre é o entregável, e eu reviso antes do primeiro passo.
