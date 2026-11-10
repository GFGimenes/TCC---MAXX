# Revisor de decisões: engenheiro, export eng_01_fundacao-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\engenheiro\eng_01_fundacao-sessao.txt (SHA-256 7da43001cf9c3394e2409d39e37fba70040d1303bffe2adda2862efcb0494570)
- Leitura do export: 5897 de 5897 linhas, em 6 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 3b7784ec-1af2-4ecd-a1d9-1b279802d3b7

Texto do revisor, sem edição:

---
Li a transcrição inteira, linhas 1 a 5897. A sessão cobre as oito etapas do passo 1 do monorepo do Maxx: API .NET, migrador, api-client, app Expo, compose com Caddy, e2e, CI e diagramas.

**Como contei.** O plano inicial foi aprovado "como está", e as cinco perguntas iniciais foram respondidas. Por isso só contei como decisão o que o agente escolheu na execução, além do que o plano trazia. Muitas decisões aparecem como "O que mudou", "Decisões que tomei e quero que você confirme" ou "Para você decidir", e a persona aprovou depois. Elas continuam contando como decisões declaradas, porque já estavam implementadas quando a persona foi consultada. As que vieram com pedido explícito de opinião também entram na lista de perguntas. Os documentos citados (CLAUDE.md, ADRs, plano mestre) eu só conheço pelo que o agente diz deles. Por isso marquei como duvidoso o que talvez já estivesse fixado ali.

## 1. Decisões tomadas sem perguntar

| # | Decisão | Trecho | Tipo | Forma |
|---|---|---|---|---|
| 1 | Usar xUnit v3 em vez do v2 do template | "Vou usar o xUnit v3 e escrever os csproj à mão" | testes e processo | declarada |
| 2 | Versões dos pacotes num arquivo só (Directory.Packages.props) | "com gerenciamento central de pacotes" | stack e arquitetura | declarada |
| 3 | Regras de estilo C# no .editorconfig (namespace de arquivo, chaves obrigatórias, var) | "csharp_style_namespace_declarations = file_scoped:warning" | testes e processo | silenciosa |
| 4 | Terceiro projeto de teste, Maxx.Architecture.Tests | "Fiz um terceiro projeto de teste, Maxx.Architecture.Tests" | testes e processo | declarada |
| 5 | Teste que exige que o Domain só referencie a biblioteca padrão | "acrescentei o teste que pega o vazamento provável de verdade" | testes e processo | declarada |
| 6 | --ignore-exit-code 8 no Domain.Tests, que ainda não tem teste | "Pus um --ignore-exit-code 8" | testes e processo | declarada |
| 7 | .gitattributes com eol=lf e png binário | "* text=auto virou * text=auto eol=lf e ganhou *.png binary" | testes e processo | declarada |
| 8 | Runner Microsoft.Testing.Platform pelo global.json, sem VSTest | "Ligo no global.json e tiro o adaptador do VSTest" | testes e processo | declarada |
| 9 | GenerateDocumentationFile ligado, com NoWarn CS1591 | "ligo o GenerateDocumentationFile, que o IDE0005 exige" | testes e processo | declarada |
| 10 | Imagem postgres:18-alpine (perguntou depois de usar) | "Usei postgres:18-alpine nos testes" | hospedagem e deploy | declarada |
| 11 | Timeout de 3 s no health check do banco | "timeout: TimeSpan.FromSeconds(3)" | stack e arquitetura | silenciosa |
| 12 | launchSettings sem o perfil https e com launchBrowser false | "\"launchBrowser\": false" | stack e arquitetura | silenciosa |
| 13 | Pacote EFCore.NamingConventions para gerar snake_case | "PackageVersion Include=\"EFCore.NamingConventions\"" | stack e arquitetura | silenciosa |
| 14 | Tabela de histórico de migrations com o nome __ef_migrations_history | "A tabela de histórico virou __ef_migrations_history" | modelo de dados | declarada |
| 15 | Chave fixa do advisory lock | "AdvisoryLockKey = 0x4D41_5858_0001" | stack e arquitetura | silenciosa |
| 16 | Um banco novo por teste de integração | "com um banco novo para cada teste" | testes e processo | declarada |
| 17 | Fixar o EF transitivo em 10.0.14 | "Fixei os dois no 10.0.14" | stack e arquitetura | declarada |
| 18 | MSBuildTreatWarningsAsErrors ligado | "Liguei MSBuildTreatWarningsAsErrors" | testes e processo | declarada |
| 19 | Migrador cria a tabela de histórico antes de consultar; /ready usa to_regclass | "O /ready pergunta ao Postgres com to_regclass" | stack e arquitetura | declarada |
| 20 | Log de cada comando SQL rebaixado para Warning | "Log de cada comando SQL caiu para Warning" | stack e arquitetura | declarada |
| 21 | dotnet-ef como ferramenta local do repositório | "dotnet-ef 10.0.14 como ferramenta local do repositório" | stack e arquitetura | declarada |
| 22 | OpenAPI gerado só quando pedido, não a cada build | "O documento só é gerado quando pedido" | stack e arquitetura | declarada |
| 23 | JsonNumberHandling.Strict para a API inteira | "Número só como número (JsonNumberHandling.Strict)" | stack e arquitetura | declarada |
| 24 | Duas versões de TypeScript: 5.9 no api-client e 6.0 no Expo | "Então o api-client usa o 5.9.3" | stack e arquitetura | declarada |
| 25 | src/index.ts escrito à mão dentro do pacote gerado | "src/index.ts é escrito à mão dentro de um pacote" | stack e arquitetura | declarada |
| 26 | Node 22 no .nvmrc, com engines >=22.12 | "Node 22 no .nvmrc ... com engines >=22.12" | hospedagem e deploy | declarada |
| 27 | Prettier com configuração padrão e .prettierignore para os arquivos gerados | "Prettier com as configurações padrão" | testes e processo | declarada |
| 28 | Aceitar os achados moderados do npm audit sem corrigir | "rebaixar o gerador para a versão 6, o que não vale a pena" | segurança | declarada |
| 29 | Teste de /api/openapi: 200 em desenvolvimento e 404 em produção | "Acrescento um teste que prova as duas pontas" | testes e processo | declarada |
| 30 | Expo SDK 58 com template blank-typescript e rotas em src/app (**duvidosa**) | "App: Expo SDK 58 com Expo Router, rotas em src/app/" | stack e arquitetura | declarada |
| 31 | Remover do template AGENTS.md, LICENSE, .claude/, App.tsx e index.ts | "Vou remover os arquivos irrelevantes trazidos pelo template" | testes e processo | declarada |
| 32 | Instalar expo-image e depois desinstalar | "npm uninstall expo-image" | stack e arquitetura | silenciosa |
| 33 | Saída web "single" (SPA) com bundler metro | "saída web single, que é a SPA" | stack e arquitetura | declarada |
| 34 | App com nome "Maxx", slug e scheme "maxx" | "\"name\": \"Maxx\"... \"scheme\": \"maxx\"" | UX e visual | silenciosa |
| 35 | noUncheckedIndexedAccess no tsconfig | "\"noUncheckedIndexedAccess\": true" | testes e processo | silenciosa |
| 36 | Fonte do sistema até o passo 4 | "por enquanto uso a fonte do sistema" | UX e visual | declarada |
| 37 | Logo maxx-ouro.png com 28 px, lido direto de design/assets | "com 28 px de altura (o mínimo da identidade é 22)" | UX e visual | declarada |
| 38 | Textos da tela e botão "Tentar de novo" | "\"Não conseguimos falar com o servidor agora.\" com o botão discreto \"Tentar de novo\"" | UX e visual | declarada |
| 39 | URL base: mesma origem na web, EXPO_PUBLIC_API_URL no nativo | "no nativo vem de EXPO_PUBLIC_API_URL" | stack e arquitetura | declarada |
| 40 | ESLint com eslint-config-prettier | "Lint (expo lint, com eslint-config-prettier)" | testes e processo | declarada |
| 41 | gcTime: Infinity nos testes do TanStack Query | "usando gcTime: Infinity nos testes" | testes e processo | declarada |
| 42 | Borda de 1 px nos quatro lados da moldura | "a borda de 1 px vai nos quatro lados" | UX e visual | declarada |
| 43 | Moldura só na web; "desktop" lido como web | "Li a decisão \"no desktop\" como web" | UX e visual | declarada |
| 44 | Manter os ícones e o splash padrão do Expo | "Ícones e splash são os padrões do template Expo" | UX e visual | declarada |
| 45 | Proxy do Metro responde 502 em problem+json quando a API cai | "title: `API local fora do ar em ${apiUrl}.`, status: 502" | stack e arquitetura | silenciosa |
| 46 | Proxy do Metro e item do plano dentro do commit de infra da etapa 5 | "vou incluir no commit da etapa 5 o proxy" | testes e processo | declarada |
| 47 | Imagens fixadas nas linhas menores (caddy:2.11-alpine, node:22-alpine, .NET 10.0) | "Fixo nas linhas menores ... caddy:2.11-alpine, node:22-alpine" | hospedagem e deploy | declarada |
| 48 | API roda com o usuário sem privilégio da imagem oficial | "com o usuário sem privilégio da imagem oficial" | segurança | declarada |
| 49 | Caddy descobre as réplicas pelo DNS a cada 5 s, em rodízio, com nova tentativa | "descobertas pelo DNS do compose a cada 5 s, em rodízio" | hospedagem e deploy | declarada |
| 50 | Pasta infra/caddy/ para o Dockerfile e o Caddyfile | "A pasta infra/caddy/ guarda o Dockerfile e o Caddyfile" | stack e arquitetura | declarada |
| 51 | Variável MAXX_SITE_ADDRESS, com :80 como padrão | "O Caddyfile aceita MAXX_SITE_ADDRESS e cai em :80" | hospedagem e deploy | declarada |
| 52 | Gss Encryption Mode=Disable na string de conexão | "Pus Gss Encryption Mode=Disable na string de conexão" | hospedagem e deploy | declarada |
| 53 | Compose para no início se faltar variável no .env | "o compose para logo no início com \"defina no .env\"" | hospedagem e deploy | declarada |
| 54 | .env.example com senha de exemplo e MAXX_HTTP_PORT, mais .dockerignore | "POSTGRES_PASSWORD=troque-esta-senha" | segurança | silenciosa |
| 55 | Aceitar o tsconfig.json reescrito pelo expo start | "vou aceitar essa versão" | testes e processo | declarada |
| 56 | Playwright 1.64.1, só com Chromium | "Workspace e2e/ com Playwright 1.64.1, só Chromium" | testes e processo | declarada |
| 57 | Viewports 1280×900 e 390×844, quatro projetos claro/escuro separados por tags | "Quatro projetos: desktop-claro, desktop-escuro..." | testes e processo | declarada |
| 58 | Na CI do e2e, uma nova tentativa e relatório HTML com trace | "Na CI: uma nova tentativa em caso de falha e relatório HTML" | testes e processo | declarada |
| 59 | Variável MAXX_E2E_BASE_URL para trocar o alvo do e2e | "MAXX_E2E_BASE_URL troca para outra porta ou para a VPS" | testes e processo | declarada |
| 60 | testID "app-fundo" no PhoneFrame | "o PhoneFrame ganhou testID=\"app-fundo\"" | testes e processo | declarada |
| 61 | Gatilho da CI: push em qualquer branch e workflow_dispatch, com concurrency | "Gatilho da CI: push em qualquer branch, mais workflow_dispatch" | testes e processo | declarada |
| 62 | gitleaks 8.30.1 sobre o histórico completo | "gitleaks 8.30.1 no histórico completo" | segurança | declarada |
| 63 | Filtro jq para os pacotes NuGet vulneráveis | "O filtro lê o JSON com jq" | segurança | declarada |
| 64 | Actions fixadas por versão (checkout@v7 etc.) | "As actions estão fixadas nas versões atuais: checkout@v7" | segurança | declarada |
| 65 | Job build com docker compose build | "build │ docker compose build" | testes e processo | declarada |
| 66 | Validar a CI com branches temporárias enviadas ao GitHub e depois apagadas | "Vou testar a CI real criando duas branches temporárias" | testes e processo | declarada |
| 67 | Texto dentro do Mermaid sem acento | "sem usar acento no texto, seguindo a convenção dos ADRs" | testes e processo | declarada |
| 68 | Caddy fora dos diagramas | "o Caddy fica fora dos diagramas" | stack e arquitetura | declarada |
| 69 | Tirar dos diagramas os códigos HTTP que nenhum documento fixa | "remover códigos HTTP não decididos pela documentação" | regra de produto | declarada |
| 70 | Enfileirar o recálculo de ranking em todos os eventos que mudam pontuação (inferência; perguntou depois) | "Nos diagramas eu o enfileiro também em aprovação, contestação..." | regra de produto | declarada |
| 71 | e2e/ no mapa do CLAUDE.md, além do infra/ aprovado | "e também e2e/, que faltava" | testes e processo | declarada |
| 72 | Dois eventos a mais no ADR 0005 | "Acrescentei dois eventos além dos que você citou" | regra de produto | declarada |
| 73 | Mudar também o passo 8 do plano-mestre, não só o produto.md (**duvidosa**) | "O passo 8 do plano-mestre.md dizia \"reenvio de foto\". Mudei" | regra de produto | declarada |
| 74 | Enviar ao remoto a branch base rodada/eng_01_fundacao, que só existia na máquina (**duvidosa**) | "Vou enviar a base e abrir o PR" | hospedagem e deploy | declarada |

## 2. Perguntas feitas à persona

As 21 perguntas foram respondidas na própria transcrição.

1. Gerenciador de pacotes JS: npm workspaces ou pnpm?
2. O que entra agora no job de segurança?
3. Onde mora o migrador?
4. Rotas de saúde e prefixo (/api, fora de /v1, dentro do OpenAPI)?
5. Medidas da moldura (outra largura? teto de 844 px?)
6. A etapa 8 passa a ser a primeira?
7. Mover o Maxx.Architecture.Tests para o IntegrationTests?
8. Versão do Postgres?
9. Confirmar as cinco decisões da etapa 3?
10. Servir /api/openapi/v1.json em desenvolvimento?
11. Proxy de /api no Metro ou só desenvolver pelo compose?
12. Moldura também em tablet?
13. Ícones e splash reais no passo 4?
14. Separar o proxy e o item do plano do commit de infra?
15. Pôr infra/ no mapa do CLAUDE.md?
16. Endereço do site e portas (443, HSTS e CSP agora ou no passo 13)?
17. Gatilho da CI, ou o par clássico com pull_request?
18. Apagar as execuções das branches temporárias?
19. Reenvio depois da reprovação: post novo ou troca de foto?
20. Recálculo de ranking em todos os eventos fica?
21. Tirar os dois eventos extras do ADR 0005?

```json
{
  "decisoes": [
    {"descricao": "Usar xUnit v3 em vez do v2 gerado pelo template", "trecho": "Vou usar o xUnit v3 e escrever os csproj à mão", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Gerenciamento central de pacotes NuGet (Directory.Packages.props)", "trecho": "com gerenciamento central de pacotes", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Regras de estilo C# no .editorconfig (namespace file-scoped, chaves obrigatórias, var)", "trecho": "csharp_style_namespace_declarations = file_scoped:warning", "tipo": "testes e processo", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Terceiro projeto de teste Maxx.Architecture.Tests", "trecho": "Fiz um terceiro projeto de teste, Maxx.Architecture.Tests", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Teste de pureza: Domain só referencia a biblioteca padrão", "trecho": "acrescentei o teste que pega o vazamento provável de verdade", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "--ignore-exit-code 8 no Maxx.Domain.Tests sem testes", "trecho": "Pus um --ignore-exit-code 8", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": ".gitattributes com eol=lf e *.png binary", "trecho": "* text=auto virou * text=auto eol=lf e ganhou *.png binary", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Runner Microsoft.Testing.Platform via global.json, sem VSTest", "trecho": "Ligo no global.json e tiro o adaptador do VSTest", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "GenerateDocumentationFile ligado com NoWarn CS1591", "trecho": "ligo o GenerateDocumentationFile, que o IDE0005 exige no build", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Imagem postgres:18-alpine nos testes e no compose", "trecho": "Usei postgres:18-alpine nos testes", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Timeout de 3 s no health check do banco", "trecho": "timeout: TimeSpan.FromSeconds(3)", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "launchSettings sem perfil https e com launchBrowser false", "trecho": "\"launchBrowser\": false", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Pacote EFCore.NamingConventions para o snake_case", "trecho": "PackageVersion Include=\"EFCore.NamingConventions\"", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Tabela de histórico de migrations __ef_migrations_history em snake_case", "trecho": "A tabela de histórico virou __ef_migrations_history", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Chave fixa do advisory lock de migração", "trecho": "AdvisoryLockKey = 0x4D41_5858_0001", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Banco novo por teste de integração", "trecho": "com um banco novo para cada teste", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Fixar versões transitivas do EF em 10.0.14", "trecho": "Fixei os dois no 10.0.14 no Directory.Packages.props", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "MSBuildTreatWarningsAsErrors ligado", "trecho": "Liguei MSBuildTreatWarningsAsErrors", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Migrador cria a tabela de histórico antes de consultar; /ready usa to_regclass", "trecho": "O /ready pergunta ao Postgres com to_regclass antes de ler o histórico", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Log de comandos SQL do EF e do Npgsql em Warning", "trecho": "Log de cada comando SQL caiu para Warning no appsettings.json", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "dotnet-ef como ferramenta local (dotnet-tools.json)", "trecho": "dotnet-ef 10.0.14 como ferramenta local do repositório", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Documento OpenAPI gerado só sob demanda", "trecho": "O documento só é gerado quando pedido", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "JsonNumberHandling.Strict para toda a API", "trecho": "Número só como número (JsonNumberHandling.Strict)", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Duas versões de TypeScript (5.9 no api-client, 6.0 no Expo)", "trecho": "Então o api-client usa o 5.9.3", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "src/index.ts manual dentro do pacote gerado api-client", "trecho": "src/index.ts é escrito à mão dentro de um pacote", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Node 22 no .nvmrc com engines >=22.12", "trecho": "Node 22 no .nvmrc, que é o que está instalado aqui, com engines >=22.12", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Prettier com configuração padrão e .prettierignore para gerados", "trecho": "Prettier com as configurações padrão", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Aceitar achados moderados do npm audit sem corrigir", "trecho": "rebaixar o gerador para a versão 6, o que não vale a pena", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Teste do /api/openapi: 200 em Development e 404 em Production", "trecho": "Acrescento um teste que prova as duas pontas", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Expo SDK 58 com template blank-typescript e rotas em src/app", "trecho": "App: Expo SDK 58 com Expo Router, rotas em src/app/", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": true},
    {"descricao": "Remover AGENTS.md, LICENSE, .claude/settings.json, App.tsx e index.ts do template", "trecho": "Vou remover os arquivos irrelevantes trazidos pelo template", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Instalar e depois desinstalar expo-image", "trecho": "npm uninstall expo-image", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Saída web single (SPA) com bundler metro", "trecho": "saída web single, que é a SPA que o Caddy vai servir", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Nome Maxx, slug e scheme maxx no app.json", "trecho": "\"name\": \"Maxx\", \"slug\": \"maxx\"", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "noUncheckedIndexedAccess no tsconfig do app", "trecho": "\"noUncheckedIndexedAccess\": true", "tipo": "testes e processo", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Fonte do sistema até o passo 4", "trecho": "As fontes ficam para o passo 4, e por enquanto uso a fonte do sistema", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Logo maxx-ouro.png direto de design/assets com 28 px", "trecho": "com 28 px de altura (o mínimo da identidade é 22)", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Textos da tela provisória e botão Tentar de novo", "trecho": "\"Não conseguimos falar com o servidor agora.\" com o botão discreto \"Tentar de novo\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "URL base: mesma origem na web, EXPO_PUBLIC_API_URL no nativo", "trecho": "no nativo vem de EXPO_PUBLIC_API_URL", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "ESLint com eslint-config-prettier", "trecho": "Lint (expo lint, com eslint-config-prettier)", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "gcTime Infinity nos testes do TanStack Query", "trecho": "usando gcTime: Infinity nos testes", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Borda de 1 px nos quatro lados da moldura", "trecho": "a borda de 1 px vai nos quatro lados", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Moldura só na web, interpretando desktop como web", "trecho": "Li a decisão \"no desktop\" como web", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Manter ícones e splash padrão do Expo", "trecho": "Ícones e splash são os padrões do template Expo", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Proxy do Metro devolve 502 problem+json quando a API local cai", "trecho": "title: `API local fora do ar em ${apiUrl}.`, status: 502", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Proxy do Metro e item do plano no commit de infra da etapa 5", "trecho": "vou incluir no commit da etapa 5 o proxy de /api no Metro", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tags de imagem fixadas nas linhas menores", "trecho": "Fixo nas linhas menores, que continuam recebendo patch: caddy:2.11-alpine, node:22-alpine", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "API roda com o usuário sem privilégio da imagem oficial", "trecho": "com o usuário sem privilégio da imagem oficial", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Caddy com descoberta DNS a cada 5 s, rodízio e nova tentativa", "trecho": "descobertas pelo DNS do compose a cada 5 s, em rodízio", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Pasta infra/caddy para Dockerfile e Caddyfile", "trecho": "A pasta infra/caddy/ guarda o Dockerfile e o Caddyfile", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Variável MAXX_SITE_ADDRESS com padrão :80", "trecho": "O Caddyfile aceita MAXX_SITE_ADDRESS e cai em :80 sem ela", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Gss Encryption Mode=Disable na string de conexão", "trecho": "Pus Gss Encryption Mode=Disable na string de conexão do compose", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Variáveis obrigatórias no compose, que falha cedo sem elas", "trecho": "o compose para logo no início com \"defina no .env\"", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": ".env.example com senha placeholder e MAXX_HTTP_PORT, e .dockerignore", "trecho": "POSTGRES_PASSWORD=troque-esta-senha", "tipo": "segurança", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Aceitar o tsconfig.json reescrito pelo expo start", "trecho": "vou aceitar essa versão", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Playwright 1.64.1 só com Chromium", "trecho": "Workspace e2e/ com Playwright 1.64.1, só Chromium", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Viewports 1280x900 e 390x844, quatro projetos claro/escuro com tags", "trecho": "Quatro projetos: desktop-claro, desktop-escuro, celular-claro e celular-escuro", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Nova tentativa e relatório HTML com trace no e2e da CI", "trecho": "Na CI: uma nova tentativa em caso de falha e relatório HTML com trace", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Variável MAXX_E2E_BASE_URL para trocar o alvo do e2e", "trecho": "MAXX_E2E_BASE_URL troca para outra porta ou para a VPS", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "testID app-fundo no PhoneFrame", "trecho": "o PhoneFrame ganhou testID=\"app-fundo\"", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Gatilho da CI em push de qualquer branch e workflow_dispatch, com concurrency", "trecho": "Gatilho da CI: push em qualquer branch, mais workflow_dispatch", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "gitleaks 8.30.1 sobre o histórico completo", "trecho": "gitleaks 8.30.1 no histórico completo", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Filtro jq para NuGet vulnerável alto/crítico", "trecho": "O filtro lê o JSON com jq", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Actions fixadas por versão", "trecho": "As actions estão fixadas nas versões atuais: checkout@v7", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Job build com docker compose build", "trecho": "build │ docker compose build", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Validar a CI com branches temporárias enviadas ao GitHub e depois apagadas", "trecho": "Vou testar a CI real criando duas branches temporárias", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Texto dentro do Mermaid sem acento", "trecho": "sem usar acento no texto, seguindo a convenção dos ADRs", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Caddy fora dos diagramas de sequência", "trecho": "o Caddy fica fora dos diagramas para não repetir o mesmo salto", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tirar dos diagramas os códigos HTTP não fixados nos docs", "trecho": "remover códigos HTTP não decididos pela documentação", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Recálculo de ranking enfileirado em todos os eventos que mudam pontuação", "trecho": "Nos diagramas eu o enfileiro também em aprovação, contestação, decisão, anulação", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Acrescentar e2e/ ao mapa do CLAUDE.md sem pedido", "trecho": "e também e2e/, que faltava", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Dois eventos extras no ADR 0005", "trecho": "Acrescentei dois eventos além dos que você citou", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Alterar também o passo 8 do plano-mestre sobre reenvio", "trecho": "O passo 8 do plano-mestre.md dizia \"reenvio de foto\". Mudei", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Enviar ao remoto a branch base rodada/eng_01_fundacao", "trecho": "Vou enviar a base e abrir o PR", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": true}
  ],
  "perguntas": [
    {"texto": "Gerenciador de pacotes JS: npm workspaces ou pnpm?", "respondida": true},
    {"texto": "O que entra no job seguranca agora: versão básica ou só esqueleto?", "respondida": true},
    {"texto": "Onde mora o migrador: subcomando do Maxx.Api, quinto projeto ou bundle do EF?", "respondida": true},
    {"texto": "Rotas de saúde e prefixo: tudo sob /api, fora de /v1 e dentro do OpenAPI?", "respondida": true},
    {"texto": "Medidas da moldura: diga se quer outra largura, ou um teto de altura de 844 px.", "respondida": true},
    {"texto": "Esta etapa (diagramas) não depende das outras. Se preferir, ela vira a primeira.", "respondida": true},
    {"texto": "Se preferir, movo o Maxx.Architecture.Tests para Maxx.Api.IntegrationTests.", "respondida": true},
    {"texto": "Versão do Postgres: usei postgres:18-alpine. Diga se quer outra.", "respondida": true},
    {"texto": "Decisões que tomei e quero que você confirme (cinco decisões da etapa 3)", "respondida": true},
    {"texto": "Se quiser /api/openapi/v1.json no ambiente de desenvolvimento, são duas linhas.", "respondida": true},
    {"texto": "A web em desenvolvimento não alcança a API: proxy de /api no Metro ou desenvolver pelo compose?", "respondida": true},
    {"texto": "A moldura só existe na web; diga se quer a moldura também em tablet.", "respondida": true},
    {"texto": "Ícones e splash reais: sugestão é o passo 4, junto com o design system.", "respondida": true},
    {"texto": "Proxy e item do plano dentro de um commit infra: se preferir, separo.", "respondida": true},
    {"texto": "Se aprovar, acrescento infra/ ao mapa do repositório no CLAUDE.md.", "respondida": true},
    {"texto": "Endereço do site via MAXX_SITE_ADDRESS e só porta 80 por enquanto, com 443/HSTS/CSP no passo 13?", "respondida": true},
    {"texto": "Gatilho da CI: push em qualquer branch sem pull_request, ou o par clássico?", "respondida": true},
    {"texto": "Se quiser, apago as execuções das branches temporárias no Actions.", "respondida": true},
    {"texto": "Reprovação e reenvio estão ambíguos no produto.md 4.7: post novo ou troca de foto?", "respondida": true},
    {"texto": "Recálculo de ranking enfileirado em todos os eventos que mudam pontuação: confirme se fica.", "respondida": true},
    {"texto": "Acrescentei dois eventos extras no ADR 0005; se não quiser os dois na lista, tiro.", "respondida": true}
  ],
  "contagem": {"decisoes": 74, "declaradas": 64, "silenciosas": 10, "duvidosas": 3, "perguntas": 21, "perguntas_respondidas": 21}
}
```
