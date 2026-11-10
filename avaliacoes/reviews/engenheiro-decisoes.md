# Decisões do agente: engenheiro (revisor de decisões)

Gerado pelo avaliador a partir dos arquivos `engenheiro-decisoes-<export>.json`, um por export.
Insumo para a contagem do autor (H3), não a contagem. Sem deduplicação entre exports.

- Status do conjunto: a conferir
- Totais do revisor (INCOMPLETOS, há export a conferir): decisoes 869, declaradas 783, silenciosas 86, duvidosas 72, perguntas 351, perguntas_respondidas 345

| Export | Status | Leitura completa | Decisões | Declaradas | Silenciosas | Duvidosas | Perguntas | Respondidas | Motivo |
|---|---|---|---|---|---|---|---|---|---|
| eng_00 | a conferir | sim | 34 | 30 | 4 | 9 | 93 | 93 | bloco JSON inconsistente: contagem.declaradas = 30, mas as listas dão 29; contagem.silenciosas = 4, mas as listas dão 5; contagem.duvidosas = 9, mas as listas dão 8 |
| eng_01_fundacao | ok | sim | 74 | 64 | 10 | 3 | 21 | 21 | - |
| eng_02_dados | ok | sim | 57 | 54 | 3 | 3 | 11 | 11 | - |
| eng_03_auth | ok | sim | 64 | 60 | 4 | 7 | 12 | 11 | - |
| eng_03_auth-sessao-parte1 | ok | sim | 66 | 60 | 6 | 4 | 24 | 22 | - |
| eng_04_design | ok | sim | 65 | 62 | 3 | 1 | 23 | 23 | - |
| eng_04_design-sessao-parte1 | ok | sim | 68 | 64 | 4 | 1 | 23 | 23 | - |
| eng_05_login | ok | sim | 46 | 43 | 3 | 3 | 16 | 15 | - |
| eng_06_medalhas | ok | sim | 58 | 56 | 2 | 10 | 20 | 20 | - |
| eng_07_posts | a conferir | não | 59 | 59 | 0 | 5 | 22 | 22 | bloco JSON inconsistente: contagem.decisoes = 59, mas as listas dão 60; contagem.declaradas = 59, mas as listas dão 60; contagem.duvidosas = 5, mas as listas dão 4; export não lido inteiro: 6788 de 14167 linhas recebidas pelo revisor (faltam 5900-6839, 7000-8742, 8868-10396, 10527-11426, 11557-13823) |
| eng_08_premios | ok | sim | 42 | 38 | 4 | 8 | 24 | 24 | - |
| eng_09_conquistas | ok | sim | 45 | 32 | 13 | 3 | 14 | 13 | - |
| eng_10_mural | ok | sim | 62 | 60 | 2 | 4 | 13 | 12 | - |
| eng_11_rankings | ok | sim | 35 | 32 | 3 | 4 | 8 | 8 | - |
| eng_12_instituicao | ok | sim | 52 | 37 | 15 | 4 | 11 | 11 | - |
| eng_13_endurecimento | ok | sim | 42 | 32 | 10 | 3 | 16 | 16 | - |

## Export eng_00

Decisões sem perguntar:

- Datas guardadas em UTC (timestamptz), com fronteiras de bimestre, semestre e ano interpretadas em America/Sao_Paulo [modelo de dados; declarada]. Trecho: "Tudo timestamptz em UTC, com as fronteiras de bimestre e semestre interpretadas em America/Sao_Paulo."
- Modelo de dados inicial: CadastroElegivel separado de Aluno, UsuarioPapel, ConquistaEvidencia, AuditoriaPremio, UploadPendente, RefreshToken com família, Trabalho com SKIP LOCKED, índices únicos que carregam regra e UPDATE condicional para 'quem aprova primeiro vale' [modelo de dados; declarada, duvidosa]. Trecho: "CadastroElegivel(ra, email, curso) ... Ela é separada de Aluno de propósito: existir na base não é ter conta."
- Composição do seed de demonstração: 1 turma por curso com 4 matérias, 1 professor por turma, histórico de 2 semestres, ~25 posts, 6 avisos, 3 eventos passados e 2 futuros, 2 comprovações pendentes e 1 contestação aberta [modelo de dados; declarada, duvidosa]. Trecho: "3 cursos de demonstração, 1 turma por curso com 4 matérias cada, 1 professor por turma"
- Pipeline de CI: jobs api, mobile, api-client, e2e e seguranca; tudo roda em PR e o merge na main gera a imagem; checagem de migration pendente; cliente regenerado com falha em caso de diferença [testes e processo; declarada, duvidosa]. Trecho: "Em PR, tudo; em merge na main, mais o build da imagem."
- Biblioteca Isopoh para o hash Argon2id [stack e arquitetura; declarada, duvidosa]. Trecho: "Módulo próprio (tabela de usuários, Argon2id via Isopoh, JWT curto"
- Ex-alunos excluídos do numerador e do divisor da raridade na primeira versão de produto.md, sem perguntar; a persona corrigiu depois [regra de produto; silenciosa]. Trecho: "Ex-alunos não entram em nenhum dos dois lados."
- Termo de uso versionado no cadastro [regra de produto; declarada]. Trecho: "cadastro e login contra a base de elegíveis · termo de uso versionado"
- Regra de processo gravada nos documentos: decisão que não está nos arquivos não foi tomada e deve ser perguntada [testes e processo; declarada]. Trecho: "Decisão que não está aqui não foi tomada: pergunte antes de"
- Esquema dos JSON do catálogo com campos não combinados, como versao, observacao, base, regraDeDeduplicacao e vigencia [modelo de dados; silenciosa, duvidosa]. Trecho: ""versao": 1, "tipo": "medalha", "observacao":"
- Nomes curtos e descrições dos itens de medalha e prêmio escritos pelo agente (ex.: 'Melhor nota da turma', 'Pontualidade') [UX e visual; silenciosa, duvidosa]. Trecho: ""descricao": "Tirar 10 em uma prova da matéria.""
- Repetibilidade das medalhas com limitePorPeriodo por item (M06 até 3, M07 até 2, M08 até 2, M09 até 4); a persona alterou depois [regra de produto; declarada]. Trecho: "Repetível com limite declarado por item (o que escrevi)"
- tipoDeEvento definido no item do catálogo, e não no evento, com a lista de tipos [modelo de dados; declarada]. Trecho: "Coloquei o tipo no item (palestra, visitaTecnica, extensao, ...) em vez de no evento"
- Campo formaDoEvento (pontual ou periodo) [modelo de dados; declarada]. Trecho: "formaDoEvento. pontual ou periodo, para distinguir o que é um dia do que é um semestre inteiro"
- Apresentação em sala com código P17 no fim da sequência, sem renumerar; ordem de exibição por tier e pontos [UX e visual; declarada]. Trecho: "Preferi não renumerar para não quebrar o vocabulário"
- M05 (evolução de nota) atribuída ao bimestre mais recente [regra de produto; declarada]. Trecho: "M05 (evolução de nota) compara dois bimestres mas é atribuída ao bimestre mais recente"
- Validação dos arquivos de catálogo e de documentação por scripts Node (faixas de tier, códigos únicos, links, travessões) [testes e processo; declarada]. Trecho: "Validei por script: JSON íntegro, códigos únicos"
- Avaliador de conquistas reduzido a duas formas de contagem em vez das três combinadas [stack e arquitetura; declarada]. Trecho: "as três formas previstas colapsaram em duas"
- Esquema da regra declarativa {forma, fonte, filtroItens, agruparPor, alvo}, com alvo dinâmico 'todasAsMatriculasDoPeriodo' [modelo de dados; declarada]. Trecho: "regra: { forma, fonte, filtroItens, agruparPor, alvo }"
- Nomes de exibição das 18 conquistas inventados pelo agente [UX e visual; declarada]. Trecho: "Inventei os 18 nomes curtos ("Primeiros passos", ...)"
- C14 com alvo literal 4 em vez de alvo dinâmico [regra de produto; declarada]. Trecho: "Usei o literal 4 ("os quatro bimestres do ano") em vez de um alvo dinâmico"
- Oito famílias de trilha em vez das sete planejadas, com presença dividida em duas e 19 itens sem trilha [regra de produto; declarada]. Trecho: "Oito famílias, cobrindo 27 dos 46 itens."
- Arquivo familias.json com o campo 'passos' redundante, usado pelo validador [modelo de dados; declarada]. Trecho: "Mantive o campo passos na família como redundância deliberada"
- Formato dos ADRs (status 'aceito · 01/11/2026', opções com peso), escolha dos ADRs sem diagrama e índice agrupado em cinco grupos [testes e processo; declarada]. Trecho: "Deixei sem diagrama os dois ADRs em que um desenho não acrescentaria nada"
- Travessão dos títulos dos ADRs trocado por '·', fora das opções que a persona deu (vírgula, dois pontos ou parênteses) [testes e processo; silenciosa]. Trecho: "# ADR 0001 · Origem única"
- Reordenação dos passos 6 a 9 do plano mestre já aprovado (posts antes de prêmios de participação) [testes e processo; declarada]. Trecho: "Inverti os dois passos."
- Esquema incremental (uma migration por passo) e fila/worker no passo 6, escritos no plano antes da aprovação [stack e arquitetura; declarada, duvidosa]. Trecho: "O esquema cresce por passo. Cada passo traz a sua migration"
- Plano mestre com grafo de dependências em Mermaid, tabela de riscos e pendências declaradas entre passos [testes e processo; declarada, duvidosa]. Trecho: "grafo de dependências em Mermaid, os 13 passos com entrega verificável, backlog de fase 2 e tabela de riscos"
- Identificadores de código sem acento e sem cedilha [stack e arquitetura; declarada]. Trecho: "Identificadores sem acento e sem cedilha. Premio, Materia, Contestacao"
- snake_case no Postgres mapeado do PascalCase do C# [modelo de dados; declarada]. Trecho: "snake_case no Postgres, PascalCase no C#."
- Glossário com proibição de Award, Prize, Badge, Reward e Trophy no código [testes e processo; declarada]. Trecho: "escrevi que Award, Prize, Badge, Reward e Trophy não existem no código"
- Rodapé Co-Authored-By nos commits e como convenção no CLAUDE.md, antes de perguntar [testes e processo; silenciosa]. Trecho: "Commits de agente terminam com o rodapé `Co-Authored-By:` do modelo que os escreveu."
- CLAUDE.md sem regras de produto, apontando para docs/produto.md [testes e processo; declarada]. Trecho: "O que ele deliberadamente não tem: regra de produto."
- Proibição explícita no CLAUDE.md de rodapé de co-autoria e de menção à ferramenta em commit e PR, além da remoção pedida [testes e processo; declarada]. Trecho: "Removo a linha, troco por uma proibição explícita"
- Commits reescritos com git filter-branch em vez do rebase interativo pedido [testes e processo; declarada]. Trecho: "git filter-branch com filtro de mensagem, já que rebase interativo não roda neste ambiente"

Perguntas do agente:

- Fonte da verdade acadêmica: quem garante RA, curso, semestre, turmas e professores? [respondida]
- Pontos: valor fixo por item ou escolhido por quem concede? Quem escolhe o tier da medalha? [respondida]
- Progressão soma ou substitui? O que acontece depois do Diamante? [respondida]
- Estados do prêmio: pendente conta? Comprovação reprovada mata o prêmio? Quem vence se professor e instituição divergirem? [respondida]
- Assiduidade e eventos na fase 1: lançamento manual, foto ou só seed? [respondida]
- Console da instituição e telas do professor entram na fase 1? [respondida]
- Dois sentidos de semestre: qual é o calendário e o que acontece na virada? [respondida]
- Feed sem conteúdo: existe descoberta? Seguir exige aprovação? [respondida]
- Autenticação: contas da instituição, domínios, senha e recuperação, papéis múltiplos, ex-aluno [respondida]
- Posts: foto obrigatória? Legenda, curtidas, comentários, comprovação pública, moderação? [respondida]
- Visibilidade de perfil, 'em averiguação' e prêmio revogado; o aluno pode sair do ranking? [respondida]
- Contestação: prazos, recontestação, efeito na progressão, revogação pelo professor? [respondida]
- Medalhas: existe cota? Vale para turma de semestre passado? [respondida]
- Avisos: escopos, anexo, fixação, expiração, notificação, comentários? [respondida]
- Rankings: desempate, top N, ex-aluno, troca de curso? [respondida]
- Catálogo 'o que falta': critérios, prêmio secreto, por curso, vigência? [respondida]
- Demo: como se acessa, lembrança local, rankings, concessão ao vivo, contas reais, expurgo? [respondida]
- Notificações existem? Só pt-BR? [respondida]
- Confirme que motivo e parecer são registro e não caixa de entrada [respondida]
- Quem decide quando professor e instituição divergem na validação? [respondida]
- Instituição é um papel só ou dois (coordenação e secretaria)? [respondida]
- Domínio de e-mail de professor e instituição [respondida]
- O que o seed carrega por aluno e o que o cadastro confere [respondida]
- Medalha concedida por engano: anulação pela instituição? [respondida]
- Ocorrência repetida do mesmo prêmio de participação: amarrar a evento? [respondida]
- Quem é 'professor da turma' para aprovar e contestar? [respondida]
- Prazo da instituição para decidir a contestação [respondida]
- Fim da janela quando houve contestação; uma contestação por prêmio? [respondida]
- Destino do post quando a comprovação é reprovada ou revogada [respondida]
- Conteúdo mínimo de um post [respondida]
- A medalha registra matéria e bimestre? A matrícula por matéria entra no seed? [respondida]
- Conquista que só fecha depois do período: em que semestre pontua? [respondida]
- A palavra 'troféu' e o que a instituição concede [respondida]
- Navegação do professor até o aluno (lista de turmas) [respondida]
- Professor e instituição no social [respondida]
- Ex-aluno: até onde vai o 'não posta' [respondida]
- Comentários: quem pode e quem remove [respondida]
- Aviso de turma: uma turma ou várias? [respondida]
- Catálogo de outro aluno: faltantes e progresso visíveis? [respondida]
- Confirmações sobre a demo (rankings, posts da banca, curtidas, contas semeadas) [respondida]
- Troca de curso: o histórico do curso antigo perde o aluno? [respondida]
- Valor canônico da medalha de nota 10 [respondida]
- 'Diamante baixo' é sub-tier? [respondida]
- E-mail errado sem verificação: validar e permitir correção pela instituição? [respondida]
- Medalha é sempre concessão humana? [respondida]
- Medalhas discricionárias M12–M14 entram ou saem? [respondida]
- Medalha acima de Bronze (M10, M11) é aceitável? [respondida]
- Evento precisa de data de início e fim? [respondida]
- Conquista pode contar conquista? [respondida]
- Ranking semestral congela 30 dias depois? [respondida]
- Assumir sem normalizar o desequilíbrio estrutural dos rankings? [respondida]
- Dedupe de evento em texto livre [respondida]
- O que mostra o perfil do professor? Ele tem feed? [respondida]
- M13 cai ou vira prêmio de participação? [respondida]
- Dedupe da apresentação em sala por item + data + matéria? [respondida]
- Pode reenviar a parte técnica, ou devo localizar o design sozinho? [respondida]
- O que é a raridade do design? [respondida]
- Destino da trilha de progressão com cadeado [respondida]
- Navegação: onde fica Rankings e o que a Busca faz? [respondida]
- Ações 'enviar' e 'salvar' do post [respondida]
- Onde fica o sininho? [respondida]
- O que é editável no 'editar perfil'? [respondida]
- Foto de perfil para aluno e professor? [respondida]
- Opções técnicas com pesos (origem, storage, leitura de fotos, miniaturas, motor, snapshot, ranking, auth, cliente, testes, camadas, migrations, feed, catálogo) [respondida]
- Idioma do código [respondida]
- Confirme o desempate pelo instante da última concessão [respondida]
- Tem fotos para o seed ou uso placeholders? [respondida]
- Onde vive o repositório e a CI? [respondida]
- Preferência de plano B de rede na banca [respondida]
- Termo de uso entra na fase 1? [respondida]
- Denominador da raridade para item restrito a curso [respondida]
- A raridade congela no prêmio? [respondida]
- População do seed demo: 120 alunos? [respondida]
- Existe @usuário único ou só nome de exibição? [respondida]
- Convenção de branch e commit; manter rodada/eng_00 no passo 0? [respondida]
- Um commit por etapa e um PR para o passo 0? [respondida]
- ADRs separados ou arquivo único? [respondida]
- Link compartilhado cai no login e vira deep link /post/:id? [respondida]
- Sufixo do arroba do ex-aluno [respondida]
- Colisão na sugestão de arroba [respondida]
- Arroba antigo liberado na troca de curso? [respondida]
- Sufixo do arroba com papel múltiplo [respondida]
- Repetibilidade da medalha no período (limitePorPeriodo) [respondida]
- Duas formas de contagem ou manter os três nomes? [respondida]
- Período curso e troca de curso: a contagem reinicia? [respondida]
- Revisar os nomes de exibição das conquistas [respondida]
- C06: duas palestras contam como um tipo? [respondida]
- C14 com alvo fixo 4 [respondida]
- Trilha pode misturar medalha e troféu? [respondida]
- Esquema incremental, com migration por passo? [respondida]
- Fila e worker nascem no passo 6? [respondida]
- Manter ou remover o rodapé Co-Authored-By no CLAUDE.md? [respondida]
- Adianto o plano do passo 1 enquanto você revisa o PR? [respondida]

## Export eng_01_fundacao

Decisões sem perguntar:

- Usar xUnit v3 em vez do v2 gerado pelo template [testes e processo; declarada]. Trecho: "Vou usar o xUnit v3 e escrever os csproj à mão"
- Gerenciamento central de pacotes NuGet (Directory.Packages.props) [stack e arquitetura; declarada]. Trecho: "com gerenciamento central de pacotes"
- Regras de estilo C# no .editorconfig (namespace file-scoped, chaves obrigatórias, var) [testes e processo; silenciosa]. Trecho: "csharp_style_namespace_declarations = file_scoped:warning"
- Terceiro projeto de teste Maxx.Architecture.Tests [testes e processo; declarada]. Trecho: "Fiz um terceiro projeto de teste, Maxx.Architecture.Tests"
- Teste de pureza: Domain só referencia a biblioteca padrão [testes e processo; declarada]. Trecho: "acrescentei o teste que pega o vazamento provável de verdade"
- --ignore-exit-code 8 no Maxx.Domain.Tests sem testes [testes e processo; declarada]. Trecho: "Pus um --ignore-exit-code 8"
- .gitattributes com eol=lf e *.png binary [testes e processo; declarada]. Trecho: "* text=auto virou * text=auto eol=lf e ganhou *.png binary"
- Runner Microsoft.Testing.Platform via global.json, sem VSTest [testes e processo; declarada]. Trecho: "Ligo no global.json e tiro o adaptador do VSTest"
- GenerateDocumentationFile ligado com NoWarn CS1591 [testes e processo; declarada]. Trecho: "ligo o GenerateDocumentationFile, que o IDE0005 exige no build"
- Imagem postgres:18-alpine nos testes e no compose [hospedagem e deploy; declarada]. Trecho: "Usei postgres:18-alpine nos testes"
- Timeout de 3 s no health check do banco [stack e arquitetura; silenciosa]. Trecho: "timeout: TimeSpan.FromSeconds(3)"
- launchSettings sem perfil https e com launchBrowser false [stack e arquitetura; silenciosa]. Trecho: ""launchBrowser": false"
- Pacote EFCore.NamingConventions para o snake_case [stack e arquitetura; silenciosa]. Trecho: "PackageVersion Include="EFCore.NamingConventions""
- Tabela de histórico de migrations __ef_migrations_history em snake_case [modelo de dados; declarada]. Trecho: "A tabela de histórico virou __ef_migrations_history"
- Chave fixa do advisory lock de migração [stack e arquitetura; silenciosa]. Trecho: "AdvisoryLockKey = 0x4D41_5858_0001"
- Banco novo por teste de integração [testes e processo; declarada]. Trecho: "com um banco novo para cada teste"
- Fixar versões transitivas do EF em 10.0.14 [stack e arquitetura; declarada]. Trecho: "Fixei os dois no 10.0.14 no Directory.Packages.props"
- MSBuildTreatWarningsAsErrors ligado [testes e processo; declarada]. Trecho: "Liguei MSBuildTreatWarningsAsErrors"
- Migrador cria a tabela de histórico antes de consultar; /ready usa to_regclass [stack e arquitetura; declarada]. Trecho: "O /ready pergunta ao Postgres com to_regclass antes de ler o histórico"
- Log de comandos SQL do EF e do Npgsql em Warning [stack e arquitetura; declarada]. Trecho: "Log de cada comando SQL caiu para Warning no appsettings.json"
- dotnet-ef como ferramenta local (dotnet-tools.json) [stack e arquitetura; declarada]. Trecho: "dotnet-ef 10.0.14 como ferramenta local do repositório"
- Documento OpenAPI gerado só sob demanda [stack e arquitetura; declarada]. Trecho: "O documento só é gerado quando pedido"
- JsonNumberHandling.Strict para toda a API [stack e arquitetura; declarada]. Trecho: "Número só como número (JsonNumberHandling.Strict)"
- Duas versões de TypeScript (5.9 no api-client, 6.0 no Expo) [stack e arquitetura; declarada]. Trecho: "Então o api-client usa o 5.9.3"
- src/index.ts manual dentro do pacote gerado api-client [stack e arquitetura; declarada]. Trecho: "src/index.ts é escrito à mão dentro de um pacote"
- Node 22 no .nvmrc com engines >=22.12 [hospedagem e deploy; declarada]. Trecho: "Node 22 no .nvmrc, que é o que está instalado aqui, com engines >=22.12"
- Prettier com configuração padrão e .prettierignore para gerados [testes e processo; declarada]. Trecho: "Prettier com as configurações padrão"
- Aceitar achados moderados do npm audit sem corrigir [segurança; declarada]. Trecho: "rebaixar o gerador para a versão 6, o que não vale a pena"
- Teste do /api/openapi: 200 em Development e 404 em Production [testes e processo; declarada]. Trecho: "Acrescento um teste que prova as duas pontas"
- Expo SDK 58 com template blank-typescript e rotas em src/app [stack e arquitetura; declarada, duvidosa]. Trecho: "App: Expo SDK 58 com Expo Router, rotas em src/app/"
- Remover AGENTS.md, LICENSE, .claude/settings.json, App.tsx e index.ts do template [testes e processo; declarada]. Trecho: "Vou remover os arquivos irrelevantes trazidos pelo template"
- Instalar e depois desinstalar expo-image [stack e arquitetura; silenciosa]. Trecho: "npm uninstall expo-image"
- Saída web single (SPA) com bundler metro [stack e arquitetura; declarada]. Trecho: "saída web single, que é a SPA que o Caddy vai servir"
- Nome Maxx, slug e scheme maxx no app.json [UX e visual; silenciosa]. Trecho: ""name": "Maxx", "slug": "maxx""
- noUncheckedIndexedAccess no tsconfig do app [testes e processo; silenciosa]. Trecho: ""noUncheckedIndexedAccess": true"
- Fonte do sistema até o passo 4 [UX e visual; declarada]. Trecho: "As fontes ficam para o passo 4, e por enquanto uso a fonte do sistema"
- Logo maxx-ouro.png direto de design/assets com 28 px [UX e visual; declarada]. Trecho: "com 28 px de altura (o mínimo da identidade é 22)"
- Textos da tela provisória e botão Tentar de novo [UX e visual; declarada]. Trecho: ""Não conseguimos falar com o servidor agora." com o botão discreto "Tentar de novo""
- URL base: mesma origem na web, EXPO_PUBLIC_API_URL no nativo [stack e arquitetura; declarada]. Trecho: "no nativo vem de EXPO_PUBLIC_API_URL"
- ESLint com eslint-config-prettier [testes e processo; declarada]. Trecho: "Lint (expo lint, com eslint-config-prettier)"
- gcTime Infinity nos testes do TanStack Query [testes e processo; declarada]. Trecho: "usando gcTime: Infinity nos testes"
- Borda de 1 px nos quatro lados da moldura [UX e visual; declarada]. Trecho: "a borda de 1 px vai nos quatro lados"
- Moldura só na web, interpretando desktop como web [UX e visual; declarada]. Trecho: "Li a decisão "no desktop" como web"
- Manter ícones e splash padrão do Expo [UX e visual; declarada]. Trecho: "Ícones e splash são os padrões do template Expo"
- Proxy do Metro devolve 502 problem+json quando a API local cai [stack e arquitetura; silenciosa]. Trecho: "title: `API local fora do ar em ${apiUrl}.`, status: 502"
- Proxy do Metro e item do plano no commit de infra da etapa 5 [testes e processo; declarada]. Trecho: "vou incluir no commit da etapa 5 o proxy de /api no Metro"
- Tags de imagem fixadas nas linhas menores [hospedagem e deploy; declarada]. Trecho: "Fixo nas linhas menores, que continuam recebendo patch: caddy:2.11-alpine, node:22-alpine"
- API roda com o usuário sem privilégio da imagem oficial [segurança; declarada]. Trecho: "com o usuário sem privilégio da imagem oficial"
- Caddy com descoberta DNS a cada 5 s, rodízio e nova tentativa [hospedagem e deploy; declarada]. Trecho: "descobertas pelo DNS do compose a cada 5 s, em rodízio"
- Pasta infra/caddy para Dockerfile e Caddyfile [stack e arquitetura; declarada]. Trecho: "A pasta infra/caddy/ guarda o Dockerfile e o Caddyfile"
- Variável MAXX_SITE_ADDRESS com padrão :80 [hospedagem e deploy; declarada]. Trecho: "O Caddyfile aceita MAXX_SITE_ADDRESS e cai em :80 sem ela"
- Gss Encryption Mode=Disable na string de conexão [hospedagem e deploy; declarada]. Trecho: "Pus Gss Encryption Mode=Disable na string de conexão do compose"
- Variáveis obrigatórias no compose, que falha cedo sem elas [hospedagem e deploy; declarada]. Trecho: "o compose para logo no início com "defina no .env""
- .env.example com senha placeholder e MAXX_HTTP_PORT, e .dockerignore [segurança; silenciosa]. Trecho: "POSTGRES_PASSWORD=troque-esta-senha"
- Aceitar o tsconfig.json reescrito pelo expo start [testes e processo; declarada]. Trecho: "vou aceitar essa versão"
- Playwright 1.64.1 só com Chromium [testes e processo; declarada]. Trecho: "Workspace e2e/ com Playwright 1.64.1, só Chromium"
- Viewports 1280x900 e 390x844, quatro projetos claro/escuro com tags [testes e processo; declarada]. Trecho: "Quatro projetos: desktop-claro, desktop-escuro, celular-claro e celular-escuro"
- Nova tentativa e relatório HTML com trace no e2e da CI [testes e processo; declarada]. Trecho: "Na CI: uma nova tentativa em caso de falha e relatório HTML com trace"
- Variável MAXX_E2E_BASE_URL para trocar o alvo do e2e [testes e processo; declarada]. Trecho: "MAXX_E2E_BASE_URL troca para outra porta ou para a VPS"
- testID app-fundo no PhoneFrame [testes e processo; declarada]. Trecho: "o PhoneFrame ganhou testID="app-fundo""
- Gatilho da CI em push de qualquer branch e workflow_dispatch, com concurrency [testes e processo; declarada]. Trecho: "Gatilho da CI: push em qualquer branch, mais workflow_dispatch"
- gitleaks 8.30.1 sobre o histórico completo [segurança; declarada]. Trecho: "gitleaks 8.30.1 no histórico completo"
- Filtro jq para NuGet vulnerável alto/crítico [segurança; declarada]. Trecho: "O filtro lê o JSON com jq"
- Actions fixadas por versão [segurança; declarada]. Trecho: "As actions estão fixadas nas versões atuais: checkout@v7"
- Job build com docker compose build [testes e processo; declarada]. Trecho: "build │ docker compose build"
- Validar a CI com branches temporárias enviadas ao GitHub e depois apagadas [testes e processo; declarada]. Trecho: "Vou testar a CI real criando duas branches temporárias"
- Texto dentro do Mermaid sem acento [testes e processo; declarada]. Trecho: "sem usar acento no texto, seguindo a convenção dos ADRs"
- Caddy fora dos diagramas de sequência [stack e arquitetura; declarada]. Trecho: "o Caddy fica fora dos diagramas para não repetir o mesmo salto"
- Tirar dos diagramas os códigos HTTP não fixados nos docs [regra de produto; declarada]. Trecho: "remover códigos HTTP não decididos pela documentação"
- Recálculo de ranking enfileirado em todos os eventos que mudam pontuação [regra de produto; declarada]. Trecho: "Nos diagramas eu o enfileiro também em aprovação, contestação, decisão, anulação"
- Acrescentar e2e/ ao mapa do CLAUDE.md sem pedido [testes e processo; declarada]. Trecho: "e também e2e/, que faltava"
- Dois eventos extras no ADR 0005 [regra de produto; declarada]. Trecho: "Acrescentei dois eventos além dos que você citou"
- Alterar também o passo 8 do plano-mestre sobre reenvio [regra de produto; declarada, duvidosa]. Trecho: "O passo 8 do plano-mestre.md dizia "reenvio de foto". Mudei"
- Enviar ao remoto a branch base rodada/eng_01_fundacao [hospedagem e deploy; declarada, duvidosa]. Trecho: "Vou enviar a base e abrir o PR"

Perguntas do agente:

- Gerenciador de pacotes JS: npm workspaces ou pnpm? [respondida]
- O que entra no job seguranca agora: versão básica ou só esqueleto? [respondida]
- Onde mora o migrador: subcomando do Maxx.Api, quinto projeto ou bundle do EF? [respondida]
- Rotas de saúde e prefixo: tudo sob /api, fora de /v1 e dentro do OpenAPI? [respondida]
- Medidas da moldura: diga se quer outra largura, ou um teto de altura de 844 px. [respondida]
- Esta etapa (diagramas) não depende das outras. Se preferir, ela vira a primeira. [respondida]
- Se preferir, movo o Maxx.Architecture.Tests para Maxx.Api.IntegrationTests. [respondida]
- Versão do Postgres: usei postgres:18-alpine. Diga se quer outra. [respondida]
- Decisões que tomei e quero que você confirme (cinco decisões da etapa 3) [respondida]
- Se quiser /api/openapi/v1.json no ambiente de desenvolvimento, são duas linhas. [respondida]
- A web em desenvolvimento não alcança a API: proxy de /api no Metro ou desenvolver pelo compose? [respondida]
- A moldura só existe na web; diga se quer a moldura também em tablet. [respondida]
- Ícones e splash reais: sugestão é o passo 4, junto com o design system. [respondida]
- Proxy e item do plano dentro de um commit infra: se preferir, separo. [respondida]
- Se aprovar, acrescento infra/ ao mapa do repositório no CLAUDE.md. [respondida]
- Endereço do site via MAXX_SITE_ADDRESS e só porta 80 por enquanto, com 443/HSTS/CSP no passo 13? [respondida]
- Gatilho da CI: push em qualquer branch sem pull_request, ou o par clássico? [respondida]
- Se quiser, apago as execuções das branches temporárias no Actions. [respondida]
- Reprovação e reenvio estão ambíguos no produto.md 4.7: post novo ou troca de foto? [respondida]
- Recálculo de ranking enfileirado em todos os eventos que mudam pontuação: confirme se fica. [respondida]
- Acrescentei dois eventos extras no ADR 0005; se não quiser os dois na lista, tiro. [respondida]

## Export eng_02_dados

Decisões sem perguntar:

- Dividiu o passo em sete etapas, um commit cada, um PR no fim, na branch feat/passo-02-dados [testes e processo; declarada]. Trecho: "Branch: feat/passo-02-dados, saindo de rodada/eng_02_dados. Sete etapas, um commit cada, um PR no fim."
- Função de calendário que mapeia instante UTC para bimestre/semestre com fronteiras em America/Sao_Paulo e datas inclusivas nas duas pontas [regra de produto; declarada, duvidosa]. Trecho: "A função que diz em qual bimestre e semestre cai um instante UTC, lendo as fronteiras em America/Sao_Paulo."
- Conjunto de regras do validador de catálogo (prefixo x tipo, faixa do tier, não-Bronze só semestre, famílias, regras de conquista) e extras (nome/descrição não vazios, chave de dedup sempre com aluno, vigência) [regra de produto; declarada, duvidosa]. Trecho: "O código é único no catálogo inteiro e o prefixo bate com o tipo (M, P ou C)."
- Seeder com advisory lock de chave própria, transação única e validação antes de gravar [stack e arquitetura; declarada]. Trecho: "O subcomando Maxx.Api seed base, no mesmo molde do migrate, com um advisory lock de chave própria e uma transação só."
- Não criar endpoint GET /v1/catalogo neste passo; OpenAPI sem diferença [stack e arquitetura; declarada]. Trecho: "Não estou propondo GET /v1/catalogo aqui."
- Passo próprio 'Catálogo válido' na CI, com os mesmos testes rodando de novo no passo geral [testes e processo; declarada]. Trecho: "- name: Catálogo válido"
- Semestre sem datas próprias: vai do início do 1º bimestre ao fim do 2º; dias entre bimestres contam como semestre [modelo de dados; declarada]. Trecho: "O semestre não guarda datas próprias. Ele começa no início do primeiro bimestre e termina no fim do segundo."
- Papeis como enum de combinação; único acúmulo permitido é professor+instituição [modelo de dados; declarada, duvidosa]. Trecho: "Papeis é um enum de combinação. O domínio só deixa um cadastro ter um papel, com uma exceção: professor e instituição juntos."
- Sigla do curso só aceita letras maiúsculas ASCII [regra de produto; declarada]. Trecho: "A sigla do curso só aceita letras maiúsculas sem acento, porque ela vira o sufixo do arroba."
- E-mail validado só na forma (um @ com texto dos dois lados); domínios aceitos ficam para o passo 3 [segurança; declarada]. Trecho: "O e-mail só tem a forma conferida aqui: um @, com texto dos dois lados."
- Matrícula não conferia se a matéria é do curso do aluno (revertida depois pela persona) [regra de produto; declarada]. Trecho: "A matrícula não confere se a matéria é do curso do aluno. Os docs não dizem que isso é proibido, então não travei."
- Id Guid v7 gerado no domínio; construtores privados do EF adiados para a E4 [modelo de dados; declarada]. Trecho: "O id é um Guid v7 gerado no domínio."
- DomainException própria e helper Texto.Obrigatorio que apara espaços (RA ' 123456 ' vira '123456') [stack e arquitetura; silenciosa]. Trecho: "var aluno = CadastroElegivel.Aluno(" 123456 ", ...); Assert.Equal("123456", aluno.Ra);"
- Renomeou campos estáticos privados dos testes para _camelCase via sed para seguir a convenção do analisador [testes e processo; silenciosa]. Trecho: "sed -i -E 's/\bMedicina\b/_medicina/g' Cadastr…"
- Regra derivada: repetível, ocorrência na chave e limite >= 2 andam juntos [regra de produto; declarada]. Trecho: "Repetível, ocorrência e limite andam juntos."
- Regra derivada: alvo todasAsMatriculasDoPeriodo exige gatilho fechamentoDePeriodo [regra de produto; declarada]. Trecho: "Alvo todasAsMatriculasDoPeriodo exige o gatilho fechamentoDePeriodo."
- Regra derivada: período curso não aceita gatilho fechamentoDePeriodo [regra de produto; declarada]. Trecho: "Período curso não aceita o gatilho fechamentoDePeriodo."
- Regra derivada: fonte 'ambos' não aceita agrupamento [regra de produto; declarada]. Trecho: "Com a fonte ambos, nenhum agrupamento é aceito."
- Regra derivada: filtroItens vazio é erro; null significa qualquer item [regra de produto; declarada]. Trecho: "filtroItens: [] é erro. Quem quer qualquer item da fonte usa null"
- Itens do catálogo como records imutáveis no domínio; versão fica fora do domínio [stack e arquitetura; declarada]. Trecho: "Os itens são dados imutáveis. A versao e o mapeamento para o banco ficam para a E5 e a E6."
- Leitor de JSON estrito: campo desconhecido é erro, enum só em camelCase exato, item de tipo errado é erro [stack e arquitetura; declarada]. Trecho: "O leitor é estrito."
- Teste do catálogo real no projeto Maxx.Api.IntegrationTests, sem banco [testes e processo; declarada]. Trecho: "O teste mora em Maxx.Api.IntegrationTests, porque é o projeto de teste que já enxerga a Infrastructure."
- Campo versao do topo de cada arquivo JSON é lido e ignorado [modelo de dados; declarada]. Trecho: "O versao: 1 do topo de cada arquivo é lido e ignorado."
- Checagem Prettier na CI via setup-node@v7 e npx com a versão do package-lock, sem npm ci [testes e processo; silenciosa]. Trecho: "run: npx --yes "prettier@$(node -p "require('./package-lock.json')..."
- E-mail em citext, ativando a extensão no banco [modelo de dados; declarada]. Trecho: "E-mail em citext. A unicidade não diferencia maiúsculas"
- Check constraints no banco repetindo invariantes do domínio, exceto a que cruza tabelas [modelo de dados; declarada]. Trecho: "Os checks repetem invariantes do domínio no banco, porque a carga por CSV da fase 2 pode não passar pelo domínio."
- MaxxDbContext sem DbSet, acesso por Set<T>() [stack e arquitetura; declarada]. Trecho: "O MaxxDbContext não tem DbSet; o acesso é por Set<T>()."
- Restrict entre agregados; cascata só dentro do calendário [modelo de dados; declarada]. Trecho: "Matrícula e vínculo seguram turma e cadastro com Restrict."
- Testes conferem o nome da constraint violada, não só o código de erro [testes e processo; declarada]. Trecho: "Os testes conferem o nome da constraint violada, não só o código do erro"
- Unicidades e índices além do plano (sigla do curso, ano, semestre, bimestre, matéria por curso+nome, vínculo; índices por turma_id) e tabelas no singular [modelo de dados; declarada]. Trecho: "sigla do curso; ano letivo; semestre por (ano, número); bimestre por (semestre, número); matéria por (curso, nome)"
- Construtores privados para o EF e coleções ordenadas na leitura (início/fim por min/max) [stack e arquitetura; declarada]. Trecho: "SemestreLetivo.Bimestres e AnoLetivo.Semestres agora ordenam por número na leitura"
- Regenerar a migration apagando arquivos à mão e restaurando o snapshot pelo git [testes e processo; declarada]. Trecho: "Para gerar de novo, apaguei os arquivos da migration e restaurei o snapshot pelo git."
- Linha da tabela como classe da Infrastructure (ItemCatalogoRow) com a versão, separada do domínio [stack e arquitetura; declarada]. Trecho: "A linha da tabela é uma classe da Infrastructure (ItemCatalogoRow), não o record do domínio."
- Chave primária do item é o codigo, não id gerado [modelo de dados; declarada]. Trecho: "A chave primária é o codigo (M01, C12), não um id gerado."
- Uma só coluna periodo para periodoDeReferencia e periodo [modelo de dados; declarada]. Trecho: "Uma só coluna periodo, que guarda o periodoDeReferencia da medalha e do prêmio de participação e o periodo da conquista."
- Enumerações gravadas em texto camelCase igual ao JSON [modelo de dados; declarada]. Trecho: "As enumerações ficam em texto camelCase, igual ao JSON"
- restricao_curso sem FK para curso [modelo de dados; declarada]. Trecho: "restricao_curso não tem FK para o curso."
- Helpers de banco dos testes extraídos para BancoDeTeste, alterando testes anteriores [testes e processo; declarada]. Trecho: "Os helpers de banco dos testes de integração foram para a nova classe BancoDeTeste"
- Checks de tipo/tier/faixa geradas das enumerações e de Tiers.Faixa; chave de dedup em text[]; índice único (família, ordem) e FK Restrict [modelo de dados; declarada]. Trecho: "As checks de tipo, de tier e de faixa são geradas de Tiers.Faixa e das enumerações do domínio"
- Calendário como arquivo de dados por ano em data/calendario/<ano>.json [stack e arquitetura; declarada]. Trecho: "O calendário é arquivo de dados, um por ano letivo (data/calendario/<ano>.json), e não código C#."
- Ano no banco ausente dos arquivos faz o seed falhar [regra de produto; declarada]. Trecho: "Um ano no banco ausente dos arquivos também faz o seed falhar"
- Versão sobe por comparação campo a campo via reflexão, regra jsonb comparada como árvore, sem coluna de hash [stack e arquitetura; declarada]. Trecho: "a linha do banco é comparada com a do arquivo campo por campo, por reflexão, sem uma coluna de hash."
- Família sem versão; mudanças aplicadas no lugar [modelo de dados; declarada]. Trecho: "Família não tem versão: uma mudança de nome, descrição ou passos é aplicada no lugar."
- Diretório de dados por configuração Seed:DiretorioDeDados com padrão 'data' [hospedagem e deploy; declarada]. Trecho: "O diretório de dados vem da configuração Seed:DiretorioDeDados, com padrão data relativo ao diretório de trabalho."
- AnoLetivo.AtualizarDatas no domínio para corrigir datas mantendo os ids [modelo de dados; declarada]. Trecho: "vou adicionar AtualizarDatas ao AnoLetivo para permitir corrigir as datas de um ano já no banco sem alterar seus ids."
- Códigos de saída do subcomando seed (0 sucesso, 1 dado recusado sem pilha, 2 uso inválido) [stack e arquitetura; declarada]. Trecho: "Sai com 1 quando os dados são recusados, com a mensagem e sem pilha de erro no log."
- Dockerfile copia data/ inteiro (não só data/catalogo) para /app/data [hospedagem e deploy; declarada]. Trecho: "O Dockerfile copia data/ para /app/data."
- Prettier na CI e no package.json ampliado de data/catalogo para data/ inteiro [testes e processo; declarada]. Trecho: "O Prettier, na CI e no package.json, passa a conferir data/ inteiro, incluindo o calendário."
- Mundo de demonstração como arquivo de dados data/demo/mundo.json [stack e arquitetura; declarada]. Trecho: "O mundo é arquivo de dados, como o calendário, e não código."
- Seed demo só acrescenta e não falha por linha a mais no banco [regra de produto; declarada]. Trecho: "O demo só acrescenta e não falha por linha a mais."
- Linha que existe no banco e no arquivo e diverge faz o seed falhar em vez de corrigir [regra de produto; declarada]. Trecho: "Uma linha que existe nos dois lugares e diverge faz o seed falhar, em vez de ser corrigida."
- Formato do mundo: matérias listam semestres com turma; professor e aluno listam matérias e entram em todas as turmas delas [modelo de dados; declarada]. Trecho: "Professor e aluno listam as matérias e entram em todas as turmas delas; cada matéria lista os semestres em que tem turma."
- Dados fictícios: RA de 8 dígitos (2026CCNN), e-mails nome.sobrenome, conta coordenacao@unieduk.com.br, nomes dos professores [regra de produto; declarada]. Trecho: "RAs de 8 dígitos (2026CCNN); e-mails nome.sobrenome nos três domínios de produto.md"
- MundoDemoReader valida coerência interna do arquivo (sigla, e-mail sem caixa e RA únicos, matérias existentes) antes do banco [stack e arquitetura; declarada]. Trecho: "O MundoDemoReader confere a coerência do arquivo: sigla, e-mail (sem diferenciar maiúsculas) e RA únicos"
- Dados do curso IA: professor fictício Cláudio Fonseca e alunos do 1º ao 7º semestre [regra de produto; declarada]. Trecho: "um professor (o fictício Cláudio Fonseca) vinculado às quatro turmas e cinco alunos, do 1º ao 7º semestre."
- Redação no produto.md: 'professores dos quatro cursos de demonstração' em vez de trocar só o número [testes e processo; declarada]. Trecho: "vou corrigir "das três turmas de demonstração" para "dos quatro cursos de demonstração""
- Publicou a branch rodada/eng_02_dados no remoto sem perguntar, para abrir o PR [hospedagem e deploy; declarada]. Trecho: "Publico a branch como está, sem commit novo, e abro o PR."

Perguntas do agente:

- Calendário de 2026: preciso do início e do fim dos quatro bimestres de 2026, de preferência do calendário acadêmico da UniMax. [respondida]
- A quem a matrícula e o vínculo de professor apontam? (recomenda CadastroElegivel com papel, nome, semestre e RA opcional) [respondida]
- Formato do catálogo no banco: uma tabela item_catalogo com coluna de tipo e regra em jsonb, ou três tabelas? [respondida]
- Versão e remoção de item: versão por item sobe quando o conteúdo muda; item sumido do JSON faz o seeder falhar; retirada por vigencia.fim? [respondida]
- Divisão entre base e demo: base só estrutura, demo o mundo fictício, domínios de e-mail no passo 3? [respondida]
- Conteúdo do demo: quais os três cursos com nome e sigla, quais matérias cada curso tem, e o tamanho mínimo proposto? [respondida]
- Marcação de demonstração (flag e lote) entra já nestas tabelas ou só no passo 5? [respondida]
- O seed no Compose: serviço seeder rodando seed base entre migrator e réplicas e seed demo à mão, ou os dois manuais? [respondida]
- Nota desatualizada nas observacao dos JSON sobre a etapa E0.2c: posso tirar a frase na E3? [respondida]
- O Prettier acusa formatação em familias.json e medalhas.json: formato os dois neste commit ou deixo como está? [respondida]
- Um quarto curso (IA) contradiz produto.md e plano-mestre.md: quatro cursos com docs no mesmo PR, docs em PR à parte, ou ficam três? [respondida]

## Export eng_03_auth

Decisões sem perguntar:

- Disponibilidade de arroba exige RA e e-mail válidos [segurança; declarada]. Trecho: "Disponibilidade exige RA e e-mail válidos"
- Cabeçalho X-Maxx-Cliente: web escolhe cookie; nome do cookie maxx_refresh [segurança; declarada]. Trecho: "Cabeçalho X-Maxx-Cliente: web escolhe o cookie"
- Todo erro sai com codigo, derivado do status quando não há próprio [stack e arquitetura; declarada]. Trecho: "Todo erro sai com codigo"
- Campos em branco voltam com o código da regra de domínio, não dados-invalidos [stack e arquitetura; declarada]. Trecho: "Nome, prefixo e senha em branco voltam com o código da regra de domínio"
- Escrita da sessão (cookie/corpo) antecipada da E7 para a E6 [testes e processo; declarada]. Trecho: "a escolha entre cookie e corpo, que estava na E7, entrou aqui"
- RA e e-mail sempre no corpo, nunca na URL [segurança; declarada]. Trecho: "RA e e-mail sempre no corpo, nunca na URL, para não irem parar em log de acesso"
- Atributos do cookie de refresh: HttpOnly, Secure, SameSite=Strict, Path=/api/v1/auth [segurança; declarada, duvidosa]. Trecho: "cookie maxx_refresh (HttpOnly, Secure, SameSite=Strict, Path=/api/v1/auth)"
- Recusa 404 idêntica para par trocado, RA inexistente e linha de professor [segurança; declarada, duvidosa]. Trecho: "A resposta é idêntica nos três casos, e um teste compara os corpos"
- Handlers na Application, repositórios EF na Infrastructure, UnitOfWork traduz índice violado em conflito tipado [stack e arquitetura; declarada, duvidosa]. Trecho: "CadastroHandler e SessaoService na Application ... Os repositórios EF ficam na Infrastructure"
- Refresh simultâneo conta como reuso e derruba a família [segurança; declarada]. Trecho: "Refresh simultâneo conta como reuso"
- Identificador com @ é e-mail, sem @ é RA [regra de produto; declarada]. Trecho: "Identificador com @ é e-mail; sem @, é RA"
- Conta do seed sem senha recebe o mesmo 401 de credencial errada [segurança; declarada]. Trecho: "Conta do seed sem senha recebe o mesmo 401 de credencial errada"
- Um só código sessao-invalida para toda falha de refresh [segurança; declarada]. Trecho: "Um só código para toda falha de refresh (sessao-invalida)"
- Logout dispensa access token, revoga a família e responde sempre 204 [segurança; declarada]. Trecho: "Logout: dispensa o access token ... responde 204 até para refresh desconhecido"
- Cookie só lido com o cabeçalho web; refresh recusado e logout apagam o cookie [segurança; declarada]. Trecho: "Cookie só com o cabeçalho na web"
- Login não aplica política de senha, só teto de 512 caracteres [segurança; declarada]. Trecho: "O login não aplica a política de senha. Ele só limita a senha a 512 caracteres"
- MaxxApiFactory ganha coletor de log e gancho para trocar serviços [testes e processo; declarada]. Trecho: "o MaxxApiFactory ganhou um coletor de log e um gancho para trocar serviços"
- Custo do Argon2id testado por contagem de chamadas, não por tempo [testes e processo; declarada]. Trecho: "Testei o custo pela contagem de chamadas, e não medindo tempo"
- Conflito de concorrência tipado, Descartar() e nova tentativa relendo o banco [stack e arquitetura; silenciosa]. Trecho: "public sealed class ConflitoDeConcorrenciaException ... void Descartar();"
- Subiu o Docker Desktop por conta própria para rodar os testes [testes e processo; declarada]. Trecho: "O Docker estava parado e eu subi o Docker Desktop"
- Exigência de login no grupo /v1 e não em FallbackPolicy [segurança; declarada]. Trecho: "Exigir login no grupo, e não numa FallbackPolicy"
- /v1/eu lê papéis e arroba do banco e ganha o campo arroba [stack e arquitetura; declarada]. Trecho: "/v1/eu lê papéis e arroba do banco, e não do token"
- Seed cria conta sem senha para toda linha de professor/instituição, com prefixo sugerido em ordem de e-mail [modelo de dados; declarada]. Trecho: "O seed cria conta para toda linha de professor e de instituição que está no banco"
- Rotas de professor/instituição registradas só no host de teste [testes e processo; declarada]. Trecho: "os testes registram duas rotas, /teste/instituicao e /teste/turmas/{id}, só no host de teste"
- Testes de escopo com calendário em volta da data real [testes e processo; declarada]. Trecho: "Os testes de escopo montam um calendário em volta da data real de hoje"
- Repositório de usuário em memória nos dois testes da E5 [testes e processo; declarada]. Trecho: "Eles ganharam um repositório de usuário em memória"
- Teste com a lista fechada das rotas anônimas de /v1 [testes e processo; declarada]. Trecho: "Rota pública nova entra nesta lista de propósito, nunca por esquecimento"
- Health e documento OpenAPI de desenvolvimento ficam anônimos [segurança; silenciosa, duvidosa]. Trecho: "menos o que é público por natureza: saúde, entrada na conta e o documento OpenAPI"
- MailKit como biblioteca de SMTP [stack e arquitetura; silenciosa]. Trecho: "dotnet add apps/api/src/Maxx.Infrastructure package MailKit"
- Mailpit v1.33.0 no compose, publicado só em 127.0.0.1:8025 [hospedagem e deploy; declarada, duvidosa]. Trecho: "image: axllent/mailpit:v1.33.0 ... "127.0.0.1:${MAXX_MAILPIT_PORT:-8025}:8025""
- Pacote Microsoft.Extensions.Hosting.Abstractions na Infrastructure [stack e arquitetura; declarada]. Trecho: "Pacote novo: Microsoft.Extensions.Hosting.Abstractions na Infrastructure"
- Token de recuperação no fragmento do link (#token=) [segurança; declarada]. Trecho: "Token no fragmento do link: http://<url-publica>/redefinir-senha#token="
- Confirmar a senha nova não abre sessão [regra de produto; declarada]. Trecho: "Confirmar não abre sessão: responde 204"
- App__UrlPublica obrigatória fora de desenvolvimento [hospedagem e deploy; declarada]. Trecho: "App__UrlPublica obrigatória fora de desenvolvimento: sem ela a API não sobe"
- Um só código recuperacao-invalida para todo link inválido [segurança; declarada]. Trecho: "Um só código para todo link inválido (recuperacao-invalida)"
- E-mail de recuperação vai para o endereço gravado na base [segurança; declarada]. Trecho: "O e-mail vai para o endereço gravado na base, e não para o digitado"
- Fila em memória de até 1.000 mensagens que descarta a nova quando cheia; falha de envio só no log [stack e arquitetura; declarada]. Trecho: "A fila em memória guarda até 1.000 mensagens por réplica, e, cheia, descarta a nova"
- Política de senha conferida antes do token; Argon2id roda uma vez só [segurança; declarada]. Trecho: "A política de senha é conferida antes de buscar o token"
- Teste do SMTP real com MailKit contra contêiner do Mailpit [testes e processo; declarada]. Trecho: "o SMTP real, com MailKit, foi testado contra um contêiner do Mailpit"
- Variáveis MAXX_SMTP_*, MAXX_URL_PUBLICA e remetente nao-responda@maxx.local [hospedagem e deploy; silenciosa]. Trecho: "Email__Remetente: ${MAXX_EMAIL_REMETENTE:-Maxx <nao-responda@maxx.local>}"
- Com o disco cheio, não liberou espaço sozinho e parou para a persona decidir [testes e processo; declarada, duvidosa]. Trecho: "Por que não liberei nada sozinho"
- Apagou bin e obj para resolver o IDE0005 causado por arquivo gerado corrompido [testes e processo; declarada]. Trecho: "Vou apagar bin e obj nos projetos da API e reconstruir"
- Com a flag desligada, rotas da demo não são mapeadas; OpenAPI as mapeia mesmo assim [segurança; declarada]. Trecho: "Desligada, as rotas nem são mapeadas"
- Flag da demo só liga pelo docker-compose.demo.yml [hospedagem e deploy; declarada]. Trecho: "A flag só liga pelo docker-compose.demo.yml"
- Demo__Lote obrigatório com a flag ligada [hospedagem e deploy; declarada]. Trecho: "Lote obrigatório com a flag ligada: sem Demo__Lote, a API não sobe"
- Curso da demo escolhido pela sigla entre os com turma vigente [regra de produto; declarada]. Trecho: "Curso escolhido pela sigla, entre os cursos com turma no semestre vigente"
- RA DEMO+8 caracteres, e-mail @demonstracao.invalid, semestre 1, nome como nome completo e de exibição [modelo de dados; declarada]. Trecho: "RA gerado no formato DEMO mais 8 caracteres ... <ra>@demonstracao.invalid"
- Aluno de demonstração sem senha e sem recuperação [segurança; declarada]. Trecho: "Sem senha e sem recuperação: o aluno de demonstração entra só pela chave"
- Chave do dispositivo sempre no corpo, inclusive na web [segurança; declarada]. Trecho: "A chave do dispositivo vai sempre no corpo, na web também"
- Sugestão de arroba extraída para o serviço compartilhado SugestaoDeArroba [stack e arquitetura; declarada]. Trecho: "a sugestão de arroba saiu do CadastroHandler para um serviço compartilhado"
- Consulta de semestre vigente extraída para o helper SemestreVigente [stack e arquitetura; declarada]. Trecho: "a consulta de semestre vigente saiu do EscopoDeTurma para um helper"
- Remoção do HasDefaultValue(false) e migration gerada de novo [modelo de dados; declarada]. Trecho: "Vou tirar o HasDefaultValue(false) do bool"
- Check no banco: lote e chave juntos, papel aluno, sem senha; índice no lote [modelo de dados; declarada, duvidosa]. Trecho: "Uma check no banco exige lote e chave juntos, papel de aluno e nenhuma senha"
- Apagou os dados da fumaça por SQL direto no banco, numa transação [testes e processo; declarada]. Trecho: "apago os dados da fumaça pelo lote, numa transação"
- Limite de taxa como filtro de endpoint, não policy do middleware [stack e arquitetura; declarada]. Trecho: "Filtro de endpoint em vez das policies do middleware"
- Janela fixa, sem fila; toda tentativa conta [segurança; declarada]. Trecho: "Janela fixa e sem fila. Estourou, recusa na hora"
- Chave do limite normalizada (trim e minúsculas) [segurança; declarada]. Trecho: "Chave normalizada: sem espaços nas pontas e em minúsculas"
- Confirmar da recuperação sem limite de taxa [segurança; declarada]. Trecho: "O confirmar não, porque o token tem 256 bits"
- /demo/entrar sem limite de taxa [segurança; declarada]. Trecho: "/demo/entrar fica sem limite"
- Limite provisório de upload de 30 por hora por usuário [segurança; declarada]. Trecho: "Upload com número provisório: 30 por hora por usuário"
- Log do limite registra só o nome do limite, nunca a chave [segurança; declarada]. Trecho: "o log registra só o nome do limite, nunca a chave"
- Acrescentou ao plano-mestre o debounce do arroba e a tela /redefinir-senha, sem pedido [testes e processo; declarada]. Trecho: "Acrescentei também o debounce na digitação do arroba e a tela /redefinir-senha, que você não tinha pedido"
- .gitleaksignore com os dois achados e o literal de senha de teste movido para constante [segurança; declarada]. Trecho: "o .gitleaksignore lista só esses dois achados"
- Publicou no remoto a branch rodada/eng_03_auth, que só existia local, para servir de base ao PR [testes e processo; declarada]. Trecho: "Vou publicá-la como está, sem commit novo, para que o PR tenha base"

Perguntas do agente:

- E6: Decisões que tomei e quero confirmar (4 decisões) [respondida]
- Proponho registrar 2 e 3 em docs/decisoes/README.md no fechamento do passo ... Se preferir agora, entra neste commit. [respondida]
- E7: Decisões que tomei e quero confirmar (7 decisões); proponho registrar 1, 4 e 6 no fechamento [respondida]
- E8: Decisões que tomei e quero confirmar (3 decisões) [respondida]
- Opções de limpeza, se quiser ... Me avise quando o disco tiver espaço que eu continuo de onde parei. [respondida]
- E9: Decisões que tomei e quero confirmar (7 decisões) [respondida]
- E10: Decisões que tomei e quero confirmar (7 decisões) [respondida]
- Posso registrá-lo como procedimento de purga no fechamento do passo. [respondida]
- Esta preciso que você decida: deixar como está, ou pôr um limite por IP nas duas, com um número a definir. [respondida]
- E11: Decisões que tomei e quero confirmar (1, 2, 3, 5, 6 e 7) [respondida]
- Se preferir só a serialização, eu tiro os dois. [respondida]
- Faço isso num commit docs(docs) no começo do passo 4, se você quiser. [sem resposta]

## Export eng_03_auth-sessao-parte1

Decisões sem perguntar:

- Branch feat/passo-03-auth saindo de rodada/eng_03_auth, um commit por etapa e um PR no fim [testes e processo; declarada]. Trecho: "Branch: feat/passo-03-auth, saindo de rodada/eng_03_auth. Um commit por etapa, um PR no fim."
- Nomes e métodos das rotas de autenticação em /api/v1/auth (cadastro/sugestao, login, refresh, logout, recuperacao, recuperacao/confirmar) [stack e arquitetura; declarada]. Trecho: "Sugestão de arroba (POST /v1/auth/cadastro/sugestao, com RA e e-mail)"
- Modelo Usuario ligado 1:1 a CadastroElegivel, com tabelas usuario, familia_sessao, refresh_token e recuperacao_senha [modelo de dados; declarada]. Trecho: "Usuario, ligado 1:1 a um CadastroElegivel."
- Refresh token e token de reset guardados só como hash SHA-256 [segurança; declarada]. Trecho: "Refresh e reset guardados só como hash SHA-256, nunca o valor em claro."
- Uso de citext no Postgres para a unicidade do arroba sem diferenciar maiúsculas [modelo de dados; declarada]. Trecho: "em arroba com citext"
- Refresh na web em cookie HttpOnly; Secure; SameSite=Strict; Path=/api/v1/auth e no nativo no corpo, com a distinção feita por cabeçalho de cliente [segurança; declarada]. Trecho: "Na web, o refresh vai em cookie HttpOnly; Secure; SameSite=Strict; Path=/api/v1/auth. No nativo, vai no corpo."
- Login de professor e instituição só por e-mail; professor tentando entrar por RA é recusado [regra de produto; declarada, duvidosa]. Trecho: "aluno por RA ou e-mail, professor e instituição só por e-mail"
- Mesma resposta para credencial errada e usuário inexistente, com tempo igualado por um hash fictício [segurança; declarada]. Trecho: "Credencial errada e usuário inexistente dão a mesma resposta, e o tempo é igualado com um hash fictício."
- No cadastro, par RA/e-mail errado recebe resposta genérica; RA que já tem conta recebe 409 com código que leva à recuperação de senha [segurança; declarada]. Trecho: "RA que já tem conta responde 409 com um código que o cliente usa para levar à recuperação de senha."
- O cadastro já devolve uma sessão aberta (entrada automática) [regra de produto; declarada]. Trecho: "e o cadastro já devolvendo sessão"
- Escopo do professor consultado no banco só para o semestre vigente em America/Sao_Paulo, com IEscopoDeTurma e token sem turmas [segurança; declarada, duvidosa]. Trecho: "IEscopoDeTurma.ProfessorLecionaAsync(usuarioId, turmaId), consultando vinculo_professor no banco, só para o semestre vigente em America/Sao_Paulo"
- Pedido de recuperação de senha sempre responde 202 [segurança; declarada]. Trecho: "POST /v1/auth/recuperacao, que sempre responde 202."
- Rotas da demonstração (GET /v1/demo, POST /v1/demo/alunos, POST /v1/demo/entrar) e usuário demo marcado por flag e por lote [stack e arquitetura; declarada]. Trecho: "GET /v1/demo, POST /v1/demo/alunos (nome e curso) e POST /v1/demo/entrar"
- Teste que lê os appsettings*.json versionados e falha se a chave da demonstração existir [testes e processo; declarada]. Trecho: "Um teste lê os appsettings*.json versionados e falha se a chave existir."
- Limite de taxa chaveado pelo IP real vindo do X-Forwarded-For do Caddy, com 429 em ProblemDetails e Retry-After [segurança; declarada]. Trecho: "A chave usa o IP real vindo do X-Forwarded-For do Caddy."
- Nos docs, o limite de cadastro ficou 'por RA' e o de recuperação 'por e-mail', quando o plano aprovado dizia 'por e-mail ou RA' [segurança; silenciosa, duvidosa]. Trecho: "| Cadastro | 3 a cada 15 minutos por RA |"
- Validação de entrada com AddValidation() nativo do .NET 10, registrada como decisão nova [stack e arquitetura; declarada, duvidosa]. Trecho: "| Validação de entrada | `AddValidation()` nativo do .NET 10 na borda"
- Fora de um semestre letivo vigente, o professor fica sem escopo [regra de produto; declarada]. Trecho: "escrevi que, fora de um semestre letivo vigente (férias), o professor fica sem escopo"
- O dono pode voltar a um prefixo antigo seu [regra de produto; declarada]. Trecho: "escrevi que o dono pode voltar a um prefixo antigo dele"
- Registro de demonstração não pede aceite do termo de uso até o passo 5 [regra de produto; declarada]. Trecho: "escrevi que o registro de demonstração não pede aceite do termo até o passo 5"
- Nome com menos de 3 caracteres gera sugestão já numerada; nome com mais de 30 é cortado, com o número dentro do limite [regra de produto; declarada]. Trecho: "se o nome der menos de 3 letras, a sugestão já sai numerada ("Li" vira li2)"
- Hífen e apóstrofo no nome são descartados na geração do arroba, sem separar palavras [regra de produto; declarada]. Trecho: "Hífen e apóstrofo no nome são descartados ("D'Ávila" vira Davila"
- Trocar só as maiúsculas do próprio prefixo muda a exibição sem criar outra reserva [regra de produto; declarada]. Trecho: "Trocar só as maiúsculas do próprio prefixo muda a exibição sem criar outra reserva."
- Ex-aluno pode editar o prefixo, mantendo o sufixo -EX [regra de produto; declarada]. Trecho: "Ex-aluno pode editar o prefixo, e o sufixo continua -EX."
- Tamanho da senha contado em caracteres (runes) e não em unidades UTF-16; a mensagem de recusa nunca repete a senha [segurança; declarada]. Trecho: "contados como caractere e não como unidade de UTF-16 (um emoji conta um). A mensagem de recusa nunca repete a senha"
- Conta criada pelo seed (professor e instituição) nasce com o nome completo como nome de exibição [regra de produto; declarada]. Trecho: "CriarPeloSeed (só professor e instituição, sem senha, com o nome completo como nome de exibição)"
- Teto de 10.000 tentativas numeradas na sugestão de prefixo [regra de produto; silenciosa]. Trecho: "private const int _tentativasNumeradas = 10_000;"
- A rotação do refresh devolve um resultado em vez de lançar exceção; erros de quem chama (token de outra família, outro usuário) lançam exceção [stack e arquitetura; declarada]. Trecho: "a rotação devolve um resultado em vez de lançar exceção"
- Motivos de revogação Logout, Reuso e SenhaRedefinida, com só a primeira revogação registrada [modelo de dados; declarada]. Trecho: "O motivo é Logout, Reuso ou SenhaRedefinida, e só a primeira revogação fica registrada."
- Refresh expirado é só recusado e não revoga a família [segurança; declarada]. Trecho: "Refresh expirado só é recusado e não revoga a família. Não é sinal de roubo."
- Fronteira de validade inclusiva: o último instante ainda vale, um segundo depois não [regra de produto; declarada]. Trecho: "as duas fronteiras de validade (o último instante ainda vale e um segundo depois não)"
- Na invalidação de pedidos de reset: pedido já usado não vira invalidado, pedido expirado não invalida ninguém, e há um resultado novo 'Invalidada' [regra de produto; silenciosa]. Trecho: "public void Pedido_ja_usado_nao_vira_invalidado()"
- xmin do Postgres como token de concorrência otimista em refresh_token e recuperacao_senha [modelo de dados; declarada]. Trecho: "refresh_token e recuperacao_senha, ambas com xmin como token de concorrência"
- Regras do domínio repetidas no banco como check constraints (regex do prefixo, papéis, ex-aluno com sufixo EX) [modelo de dados; declarada]. Trecho: "As regras do domínio também vão para o banco como check constraints, seguindo o passo 2."
- Tabela prefixo_reservado com o prefixo citext como chave primária, no lugar da tabela arroba do plano [modelo de dados; declarada]. Trecho: "a tabela do arroba se chama prefixo_reservado, e não arroba, porque a unicidade é do prefixo"
- Exclusão em cascata dentro do agregado, Restrict para cadastro_elegivel e índices parciais (famílias ativas, pedidos pendentes) [modelo de dados; declarada]. Trecho: "familia_sessao, com índice parcial nas famílias ativas do usuário"
- Pacotes Konscious.Security.Cryptography.Argon2 1.3.1 e JwtBearer 10.0.14; interfaces na Application, hasher e gerador na Infrastructure, JWT na Api [stack e arquitetura; declarada]. Trecho: "O pacote de Argon2 e o JwtBearer vão para o Directory.Packages.props, com as interfaces em Maxx.Application/Autenticacao."
- Hash no formato PHC com os parâmetros dentro dele, comparado em tempo constante [segurança; declarada]. Trecho: "formato PHC com os parâmetros dentro do hash. Compara em tempo constante"
- Token opaco de 32 bytes em base64url para o cliente e SHA-256 em hexadecimal para o banco [segurança; declarada]. Trecho: "TokenGenerator: 32 bytes em base64url para o cliente e SHA-256 em hexadecimal para o banco."
- JWT só com sub e papel; emissor e audiência fixos no código, sem configuração [segurança; declarada]. Trecho: "Validade, emissor e audiência são decisão, não configuração"
- Chave base64 de pelo menos 32 bytes; a API não sobe sem ela fora de Development; migrate, seed e geração do OpenAPI não exigem a chave [segurança; declarada]. Trecho: "fora de Development a API não sobe sem uma chave válida. Migrate, seed e a geração do OpenAPI não exigem a chave."
- Senha vazia vira um placeholder com o mesmo custo de hash e a verificação dá falso, em vez de erro 500 [segurança; declarada]. Trecho: "Vou corrigir o hasher para que senha vazia gaste o mesmo custo e devolva falso."
- Formato de erro: ProblemDetails com extensão 'codigo' em kebab-case; DomainException vira 400 sem a mensagem interna [stack e arquitetura; declarada]. Trecho: "ProblemDetails com a extensão codigo em kebab-case (ex.: requisicao-invalida)"
- Tolerância de relógio de 30 segundos na validação do JWT [segurança; declarada]. Trecho: "Tolerância de relógio de 30 segundos na validação do JWT."
- Em Development sem chave, a API gera uma chave por processo [segurança; declarada]. Trecho: "sem chave em Development, a API gera uma por processo"
- Sub-rede 172.30.0.0/24 fixa no compose e ForwardedHeaders aceito só dessa rede (Proxy__RedesConfiaveis) [hospedagem e deploy; declarada]. Trecho: "a rede interna ganha uma sub-rede fixa, para a API confiar no X-Forwarded-For só vindo dela"
- CI passa a gerar uma chave JWT descartável a cada execução nos jobs de e2e e de build [testes e processo; declarada]. Trecho: "Passo a gerar uma chave por execução logo depois da cópia"
- Alterou o .env local da persona, acrescentando uma MAXX_JWT_CHAVE gerada [hospedagem e deploy; declarada]. Trecho: "Seu .env local: acrescentei a ele uma MAXX_JWT_CHAVE gerada"
- MAXX_JWT_CHAVE no .env.example e obrigatória no compose via ${...:?}, passada só às réplicas da API [hospedagem e deploy; declarada]. Trecho: "Jwt__Chave: ${MAXX_JWT_CHAVE:?defina no .env}"
- Derrubou e subiu de novo a stack local (sem -v) para verificar a API em Production [testes e processo; declarada]. Trecho: "Vou subir a stack inteira para checar a API em Production e a rede nova, o que exige antes um down sem -v"
- InternalsVisibleTo da Api para os testes de integração e parâmetro de configuração extra no MaxxApiFactory (ChaveDeTeste) [testes e processo; declarada]. Trecho: "abro InternalsVisibleTo da Api para o projeto de testes de integração"
- GET /v1/eu antecipado na E5, em versão mínima (id e papéis) [stack e arquitetura; declarada]. Trecho: "GET /v1/eu nasceu mínimo aqui (id e papéis), porque o 401 precisava de uma rota protegida"
- Teste de senha em log adiado para a E7 e testes de X-Forwarded-For adiados para a E11 [testes e processo; declarada]. Trecho: "O teste de "senha não aparece em log" vai para a E7"
- Esquema bearer no OpenAPI exigido só nas rotas autenticadas [stack e arquitetura; declarada]. Trecho: "o esquema bearer no OpenAPI, exigido só nas rotas autenticadas"
- RecusaException, IUnitOfWork e repositórios declarados na Application; UnitOfWork traduz índice violado em conflito tipado; SessaoService compartilhado [stack e arquitetura; declarada]. Trecho: "CadastroHandler e SessaoService na Application, que também declara os repositórios, o IUnitOfWork e a RecusaException"
- Status e códigos de recusa do cadastro: 404 cadastro-nao-encontrado idêntico nos três casos, 409 conta-existente, 409 prefixo-indisponivel, 400 com o código da regra [segurança; declarada]. Trecho: "404 cadastro-nao-encontrado: par trocado, RA inexistente ou linha de professor. A resposta é idêntica nos três casos"
- RA e e-mail sempre no corpo (POST), nunca na URL, para não irem a log de acesso [segurança; declarada]. Trecho: "RA e e-mail sempre no corpo, nunca na URL, para não irem parar em log de acesso"
- Consulta de disponibilidade do prefixo exige RA e e-mail válidos [segurança; declarada]. Trecho: "Disponibilidade exige RA e e-mail válidos."
- Cabeçalho X-Maxx-Cliente: web escolhe o cookie maxx_refresh; sem o cabeçalho, refresh no corpo; na web o corpo traz refreshToken null [segurança; declarada]. Trecho: "Cabeçalho X-Maxx-Cliente: web escolhe o cookie. Sem o cabeçalho, o refresh vai no corpo. O nome do cookie é maxx_refresh."
- Todo erro sai com 'codigo'; quem não traz um próprio ganha o do status [UX e visual; declarada]. Trecho: "Todo erro sai com codigo: quem não traz um próprio ganha o do status"
- Nome, prefixo e senha em branco voltam com o código da regra de domínio, não com dados-invalidos [UX e visual; declarada]. Trecho: "Nome, prefixo e senha em branco voltam com o código da regra de domínio, e não com dados-invalidos"
- Tamanhos máximos na borda: Ra 32, Email 254, NomeDeExibicao 240, Prefixo 64, Senha 512 [segurança; silenciosa]. Trecho: "[property: Required(AllowEmptyStrings = true), StringLength(512)] string Senha"
- ToString do CadastroRequest sobrescrito para omitir e-mail e senha [segurança; silenciosa]. Trecho: "public override string ToString() => $"CadastroRequest {{ Ra = {Ra}, Prefixo = {Prefixo} }}";"
- Usuario.ValidarNomeDeExibicao tornado público para a borda usar [stack e arquitetura; declarada]. Trecho: "O handler usa Usuario.ValidarNomeDeExibicao, então o deixo público no domínio."
- Escrita da sessão (cookie ou corpo) antecipada da E7 para a E6 [testes e processo; declarada]. Trecho: "Escrita da sessão: a escolha entre cookie e corpo, que estava na E7, entrou aqui"
- E-mail comparado sem diferenciar maiúsculas na busca do cadastro elegível [regra de produto; silenciosa]. Trecho: "A linha de aluno em que RA e e-mail estão juntos, com o curso dela. E-mail sem diferenciar maiúsculas."

Perguntas do agente:

- 1. Professor e instituição: como entram? (recomenda não se autocadastrarem; seed sem senha e primeiro acesso pela recuperação) [respondida]
- 2. Unicidade do arroba: pelo prefixo sem diferenciar maiúsculas, ou pelo arroba completo? [respondida]
- 3. Editar o prefixo no perfil também reserva o antigo? [respondida]
- 4. Formato do prefixo (letras ASCII e dígitos, 3 a 30, começando por letra; acentos e partículas na geração)? [respondida]
- 5. Validade dos tokens (access 15 min, refresh 30 dias renovado, reset 30 min)? [respondida]
- 6. Assinatura do JWT (HS256 com chave em variável de ambiente)? [respondida]
- 7. E-mail (SMTP com MailKit, Mailpit no compose, envio em BackgroundService)? [respondida]
- 8. Senha e Argon2id (8 a 128 sem regra de composição; Konscious com parâmetros do OWASP)? [respondida]
- 9. Limites de taxa (tabela por rota; upload só declarado)? [respondida]
- 10. Demonstração no passo 3 (API aqui e tela no passo 5, chave de dispositivo, lote, cadastro elegível demo)? [respondida]
- 11. Termo de uso: deixar o campo de versão aceita para o passo 5? [respondida]
- Três pontos que escrevi além das suas respostas (escopo fora de semestre, voltar a prefixo antigo, demo sem aceite do termo). Confira se concorda [respondida]
- Comportamentos que não estavam escritos nos docs e que eu fixei (1 a 4). Confira [respondida]
- Nome de exibição sem tamanho máximo. Se quiser um limite, me diga qual [respondida]
- Se aprovar o 1 e o 2, proponho registrá-los em produto.md 2.3.1 neste mesmo commit [respondida]
- Outros pedidos de reset pendentes: recomendo invalidá-los na conclusão. Não implementei porque não está decidido [respondida]
- Pontos para confirmar: reuso estrito sem janela, refresh expirado só recusa, concorrência na E4 [respondida]
- Para fechar a E4, preciso que você suba o Docker [respondida]
- Decisões que tomei e quero confirmar (E5): formato de erro com codigo, tolerância de 30 s, chave em desenvolvimento, sub-rede fixa [respondida]
- Normalização Unicode da senha: recomendo normalizar para NFC no Hash e no Verify, mas é decisão sua [respondida]
- Se aprovar, registro os itens 1 a 3 (e o 5, se entrar) em docs/decisoes/README.md neste mesmo commit [respondida]
- Decisões que tomei e quero confirmar (E6): disponibilidade exige RA e e-mail, cabeçalho X-Maxx-Cliente e cookie maxx_refresh, codigo em todo erro, campos em branco com código do domínio [sem resposta]
- Proponho registrar 2 e 3 em docs/decisoes/README.md no fechamento do passo. Se preferir agora, entra neste commit [sem resposta]
- Plano: as etapas já assumem as recomendações; se escolher outra opção eu ajusto antes de começar (pedido de aprovação do plano) [respondida]

## Export eng_04_design

Decisões sem perguntar:

- Regra de ESLint (no-restricted-syntax) que proíbe cor literal em src/ como forma de cumprir o critério 'sem cor literal fora dos tokens' [testes e processo; declarada]. Trecho: "eslint.config.js: cor literal em src/ agora é erro de lint, o que cobre o critério de aceite."
- ThemeProvider não desenha nada até ler a preferência guardada, para não piscar o tema errado [UX e visual; declarada]. Trecho: "o provedor não desenha nada até ler a preferência, para não piscar o tema errado"
- Falha de leitura ou gravação no AsyncStorage não trava o app; valor guardado desconhecido cai no padrão Sistema [regra de produto; declarada]. Trecho: "Se a leitura ou a gravação falhar, o app não trava."
- Barra de status (ThemedStatusBar) segue o tema do app, não o do aparelho [UX e visual; declarada]. Trecho: "// A barra de status segue o tema do app, que pode diferir do tema do aparelho."
- Token raios.segmentoAtivo = 8 tirado da identidade-visual.md, sem origem no tokens.json [UX e visual; declarada]. Trecho: "Token sem origem no JSON: raios.segmentoAtivo (8) vem da identidade-visual.md"
- Controle de tema provisório feito como segmentado simples, a ser trocado na etapa 4 [UX e visual; declarada]. Trecho: "Controle provisório: ele é um segmentado simples, e pretendo trocá-lo pelo SegmentedControl na etapa 4."
- FontGate segura a primeira pintura até as fontes carregarem e cai na fonte do sistema se a carga falhar [UX e visual; declarada]. Trecho: "FontGate: segura a primeira pintura até as fontes carregarem. Se a carga falhar, segue com a fonte do sistema."
- Uma família de fonte por peso (Archivo112-700 etc.), porque o Android não escolhe arquivo por fontWeight [stack e arquitetura; declarada]. Trecho: "com uma família por peso, porque o Android não escolhe arquivo por fontWeight"
- Pipeline de fontes com imagem, fontTools e commits do Google Fonts travados e conferência de hash do que baixa [segurança; declarada]. Trecho: "rodam em contêiner, com imagem, fontTools e commits do Google Fonts travados, e conferem o hash do que baixam"
- Inclusão de @types/node, *.ttf binary no .gitattributes e manutenção do plugin expo-font acrescentado pelo expo install [stack e arquitetura; declarada]. Trecho: "expo-font, @types/node para o teste que lê os TTFs, *.ttf binary no .gitattributes. O expo install também acrescentou o plugin expo-font ao app.json, e mantive."
- Verificação dos 112% no e2e pela largura de quatro 'M' em Archivo 800 no navegador [testes e processo; declarada]. Trecho: "112% de verdade: no navegador, quatro "M" em Archivo 800 a 100 px medem cerca de 410 px"
- Não reexecutar a CI vermelha da etapa 1 para não mascarar o defeito intermitente [testes e processo; declarada]. Trecho: "Não reexecutei a CI, porque uma nova execução podia sair verde por sorte e esconder o defeito abaixo."
- Nome do código de recusa 'registro-simultaneo' para o 409 de tentativas esgotadas [regra de produto; declarada]. Trecho: "Nome do código: escolhi registro-simultaneo, porque prefixo-indisponivel já significa outra coisa no cadastro."
- Push da rodada/eng_04_design, que só existia localmente, para servir de base do PR #5 [testes e processo; declarada]. Trecho: "a rodada/eng_04_design só existia localmente, então fiz o push dela sem mudanças, para servir de base do PR"
- Tolerância do e2e de largura da fonte ampliada de 1 px para 2 px por arredondamento no Linux da CI [testes e processo; declarada]. Trecho: "Ajuste, ainda sem commit: a tolerância passa a 2 px, meio pixel por letra."
- Conjunto de 15 ícones com caminhos do Lucide 1.70.0 e arquivo LICENSE-lucide.txt junto ao componente [stack e arquitetura; declarada]. Trecho: "Icon: 15 ícones com caminhos do Lucide 1.70.0 ... A licença do Lucide vai junto"
- Prop detailColor para pintar o recorte interno dos ícones preenchidos na cor do fundo [UX e visual; declarada]. Trecho: "criei a prop detailColor para pintar esse desenho na cor do fundo"
- Ícone 'fita' feito com o medal do Lucide [UX e visual; declarada]. Trecho: "Ícone fita: usei o medal do Lucide, com as fitas acima do círculo"
- Ícones alert e inbox escolhidos para ErrorState e EmptyState [UX e visual; declarada]. Trecho: "alert e inbox são escolha minha para ErrorState e EmptyState"
- ApiStatusScreen não migrada para o Screen por ser provisória [stack e arquitetura; declarada]. Trecho: "ApiStatusScreen: não migrei para o Screen, porque é uma tela provisória."
- Rota /vitrine com require atrás de __DEV__ e redirecionamento para o início em produção, com e2e conferindo que não entra no bundle [stack e arquitetura; declarada]. Trecho: "/vitrine: só em __DEV__. Em produção a rota volta para o início."
- Acessibilidade do Icon: com rótulo vira imagem acessível; sem rótulo fica aria-hidden [UX e visual; silenciosa]. Trecho: "? { accessible: true, role: "img" as const, "aria-label": label } : { "aria-hidden": true }"
- Button com variantes primária e secundária, além de discreto e grande [UX e visual; declarada]. Trecho: "Button: discreto com 32 de altura e 44 de toque, grande com 50, nas variantes primária e secundária."
- Chip inativo em contorno (line), contrariando a frase de uso do tokens.json [UX e visual; declarada]. Trecho: "Fundo do chip inativo | contorno em line"
- Altura do chip 32 com 44 de toque [UX e visual; declarada]. Trecho: "Altura do chip | 32, com 44 de toque"
- Borda de 1 px em line no trilho do segmentado [UX e visual; declarada]. Trecho: "Borda do trilho do segmentado | 1 px em line"
- Texto do botão grande em Instrument Sans 700 tamanho 15 [UX e visual; declarada]. Trecho: "Texto do botão grande | Instrument Sans 700, tamanho 15"
- Texto do campo em 16, fora da escala, por causa do zoom do Safari [UX e visual; declarada]. Trecho: "Texto do campo | tamanho 16, fora da escala"
- Rótulo do campo em tamanho 14, peso 600 [UX e visual; declarada]. Trecho: "Rótulo do campo | tamanho 14, peso 600"
- Segmento ativo desativado mantém segmentOn, sem sombra [UX e visual; declarada]. Trecho: "Segmento ativo desativado | mantém segmentOn, sem sombra"
- Botão 'Tentar de novo' da tela de status passou a usar o Button, fora da lista pedida [UX e visual; declarada]. Trecho: "Fora da sua lista: o "Tentar de novo" da tela de status passou a usar o Button"
- Contorno padrão do navegador removido com outline-style: none [UX e visual; declarada]. Trecho: "a correção é outline-style: none, que o e2e agora confere"
- Anel de foco só para navegação por teclado (:focus-visible na web) [UX e visual; declarada]. Trecho: "O anel de foco dos controles: aparece para quem navega por teclado ... vale a regra do navegador (:focus-visible)"
- Segmentado navega com Tab, sem as setas de grupo de rádio [UX e visual; declarada]. Trecho: "Teclado no segmentado: navega com Tab, sem as setas que um grupo de rádio costuma ter."
- FilterChip exposto como checkbox para acessibilidade [UX e visual; declarada]. Trecho: "Papel do chip: é exposto como checkbox."
- Volta da opacidade ao soltar sem teste automatizado, conferida só no navegador [testes e processo; declarada]. Trecho: "A volta da opacidade ao soltar não tem teste automatizado ... Conferi no navegador"
- Reinício do Docker Desktop pela CLI por conta própria [testes e processo; declarada]. Trecho: "Reiniciei o Docker eu mesmo. ... Rodei docker desktop restart uma vez e voltou."
- Prop aboveNav no Screen para não somar duas vezes a área segura inferior [stack e arquitetura; declarada]. Trecho: "Área segura em dobro ... confirmei o problema e criei aboveNav no Screen, com teste."
- Halo da bolinha de novidade sempre em bg [UX e visual; declarada]. Trecho: "Halo na aba ativa | sempre em bg, como diz o token"
- Altura da navegação = 50 + área segura, com mínimo de 84 [UX e visual; declarada]. Trecho: "Altura com área segura | 50 + área segura, com mínimo de 84"
- Texto padrão do erro 'Não deu certo agora.' / 'Tente de novo em instantes.' [UX e visual; declarada]. Trecho: "Texto padrão do erro | "Não deu certo agora." e "Tente de novo em instantes.""
- Ícone de 32 em vazio e erro [UX e visual; declarada]. Trecho: "Tamanho do ícone em vazio e erro | 32"
- Iniciais do avatar em Archivo 700 a 40% do tamanho [UX e visual; declarada]. Trecho: "Fonte das iniciais | Archivo 700, a 40% do tamanho do avatar"
- Iniciais do primeiro e do último nome; com um nome só, uma letra [regra de produto; declarada]. Trecho: "Iniciais | primeiro e último nome; com um nome só, uma letra"
- Novidade da aba também anunciada no rótulo de acessibilidade [UX e visual; declarada]. Trecho: "O leitor de tela também ouve "Mural, com novidade"."
- EmptyState e ErrorState num só arquivo StateMessage.tsx, com ação opcional e anúncio ao leitor de tela só no bloco de texto [UX e visual; silenciosa]. Trecho: "{/* O anúncio fica só no texto: envolvendo o botão, ele o esconderia do leitor de tela. */}"
- Erro da tela de status não trocado pelo ErrorState [UX e visual; declarada]. Trecho: "Tela de status: não troquei o erro dela pelo ErrorState, porque ela é provisória"
- Medidas do ornamento do token valem para o medalhão de 48 e escalam [UX e visual; declarada]. Trecho: "Escala do ornamento | medidas do token valem para o medalhão de 48"
- Lendário com 32 traços de 2 px [UX e visual; declarada]. Trecho: "Raios do lendário | 32 traços de 2 px"
- Com raridade, sempre reservar a folga do lendário (74 px no de 48) [UX e visual; declarada]. Trecho: "Espaço do medalhão | com raridade, sempre reserva a folga do lendário: 74 px no de 48"
- Glifo em contorno ocupando 50% do metal [UX e visual; declarada]. Trecho: "Glifo | contorno, ocupando 50% do metal"
- Selo com altura 26, medalhão 18 e nome em Archivo 700 tamanho 12 [UX e visual; declarada]. Trecho: "Selo | altura 26, medalhão 18, nome em Archivo 700 tamanho 12"
- Faixa com raio 16 e tier em negrito [UX e visual; declarada]. Trecho: "Faixa | raio 16, tier em negrito"
- Trilha com círculo 36, passo de 82 px, tracejado 4/4 e rótulo Archivo 700 12 [UX e visual; declarada]. Trecho: "Trilha | círculo 36, passo de 82 px, tracejado 4/4, rótulo em Archivo 700 tamanho 12"
- Cartão com título e resumo da trilha dentro do componente TrilhaFamilia [stack e arquitetura; declarada]. Trecho: "Título da trilha | o cartão com título e resumo fica dentro do componente"
- Lacuna na trilha: obtidos depois de um passo não obtido seguem com medalhão, sem linha contínua [regra de produto; declarada]. Trecho: "Lacuna na trilha | se um passo do meio não foi obtido, os seguintes obtidos seguem com medalhão, sem linha contínua"
- Teste que falha se houver gradiente fora de Medalhao/SeloPremio ou sombra fora do SegmentedControl [testes e processo; declarada]. Trecho: "Teste novo de regra: falha se gradiente aparecer fora de Medalhao e SeloPremio, ou sombra fora do SegmentedControl."
- Vetorização com potrace 2.1.8 sobre o alfa ampliado 8x, com desfoque de 0,6 px [UX e visual; declarada]. Trecho: "Traçado: potrace 2.1.8, instalado só no scratchpad, sobre o alfa do PNG ampliado 8 vezes, com um desfoque de 0,6 px"
- Cortes do XX reabertos em 1 px pelo eixo lido no alfa antes de traçar, em vez de editar o caminho à mão [UX e visual; declarada]. Trecho: "antes de traçar, reabro os dois cortes com largura de 1 px, seguindo o eixo lido no alfa do PNG. Editar o caminho à mão não foi necessário."
- Script versionado design/icones/gerar.js que gera ícone, adaptativo, splash e favicon pelo Chromium do Playwright [stack e arquitetura; declarada]. Trecho: "Script: design/icones/gerar.js gera tudo a partir do SVG, com as cores do tokens.json."
- Dimensões dos ícones: logo de 760 px no ícone de 1024, 620 px no adaptativo, monocromático branco, favicon de 64 px com cantos arredondados, splash com imageWidth 200 [UX e visual; declarada]. Trecho: "icon.png | 1024 px, logo em ouro sobre marinho #0B2A55, com 760 px de largura"
- Remoção do android-icon-background.png, com o fundo do adaptativo só por cor [UX e visual; declarada]. Trecho: "saiu o android-icon-background.png, porque o fundo agora é só a cor"
- Dependência expo-splash-screen e configuração do plugin com fundo por tema [stack e arquitetura; declarada]. Trecho: "Dependência e limpeza: entrou expo-splash-screen"
- Título do PR 'feat(mobile): passo 4, design system' [testes e processo; declarada]. Trecho: "Título do PR: usei feat(mobile): passo 4, design system, porque ele cobre mais do que uma etapa."
- Organização da documentação: limite do registro simultâneo na seção de autenticação e nota no README do mobile de que mudanças do prebuild não entram em commit [testes e processo; silenciosa, duvidosa]. Trecho: "Ele também mexe em `package.json`, e isso não deve entrar em commit."

Perguntas do agente:

- 1. Origem do ícone e do splash: você tem SVG ou versão maior do logo? [respondida]
- 2. Arte do ícone: logo em ouro sobre marinho no ícone e no adaptativo e favicon com recorte do XX? (a decisão é sua) [respondida]
- 3. Troca de tema: três opções (Sistema, Claro, Escuro), padrão Sistema, persistidas com AsyncStorage? [respondida]
- 4. Dependência de ícones: só react-native-svg com os caminhos do Lucide num Icone nosso? [respondida]
- 5. Vitrine: rota só de desenvolvimento (__DEV__), fora do build de produção? [respondida]
- 6. Trilha: seguir o produto (TrilhaFamilia por itens, até 5 passos, rolando na horizontal)? [respondida]
- 7. Anel de foco no claro: seguir o token, com afastamento de 2 px? [respondida]
- 8. Pressionado e desativado: desativado com surface2 e ink3, pressionado com opacidade 0,85? [respondida]
- 9. Cores de avatar: só o token? [respondida]
- 10. Raio do chip: raio 8 e corrigir a frase no tokens.json? [respondida]
- Premissas (tokens.json sem mudança de estrutura, fontTools em Docker, pranchetas não servem de referência de fonte, nomes dos componentes, altura mínima 84): me corrija se discordar [respondida]
- Como corrigir o job api? (PR separado, commit nesta branch ou reexecutar) [respondida]
- Aprovar o ajuste do teste de fontes como commit próprio, fora do 'um commit por etapa'? [respondida]
- Decisões da etapa 4 que preciso que você confirme (fundo e altura do chip, borda do trilho, texto do botão grande, texto e rótulo do campo, segmento ativo desativado) [respondida]
- Decisões da etapa 5 que preciso que você confirme (halo, altura com área segura, texto do erro, ícone 32, fonte e regra das iniciais) [respondida]
- Decisões da etapa 6 que preciso que você confirme (escala do ornamento, raios do lendário, espaço do medalhão, glifo, selo, faixa, trilha, título, lacuna) [respondida]
- O traçado (SVG do logo) está aprovado? (primeira versão) [respondida]
- Qual ouro usar no SVG? Token #F5B400 ou o #FAB301 do PNG [respondida]
- O traçado está aprovado? (versão com os cortes do XX reabertos) [respondida]
- Os ícones estão aprovados? [respondida]
- Favicon sobre marinho com cantos arredondados, ou o XX sem fundo? [respondida]
- Instalar expo-system-ui? [respondida]
- Qual identificador do app? (ex.: br.com.unimax.maxx, ou deixo para o passo 13?) [respondida]

## Export eng_04_design-sessao-parte1

Decisões sem perguntar:

- Regra do ESLint (no-restricted-syntax) que torna erro qualquer cor literal em src/ [testes e processo; declarada]. Trecho: "eslint.config.js: cor literal em src/ agora é erro de lint, o que cobre o critério de aceite."
- O ThemeProvider não desenha nada até ler a preferência, para não piscar o tema errado [UX e visual; declarada]. Trecho: "Tela em branco na abertura: o provedor não desenha nada até ler a preferência"
- Falha de leitura ou gravação no AsyncStorage não trava o app; valor desconhecido guardado cai no padrão Sistema [regra de produto; declarada]. Trecho: "Se a leitura ou a gravação falhar, o app não trava."
- A barra de status segue o tema escolhido no app, não o do aparelho [UX e visual; silenciosa]. Trecho: "// A barra de status segue o tema do app, que pode diferir do tema do aparelho."
- Raio do segmento ativo (8) tirado da identidade-visual.md, sem origem no tokens.json [UX e visual; declarada]. Trecho: "Token sem origem no JSON: raios.segmentoAtivo (8) vem da identidade-visual.md"
- Controle de tema provisório (segmentado simples) até a etapa 4 [UX e visual; declarada]. Trecho: "Controle provisório: ele é um segmentado simples, e pretendo trocá-lo pelo SegmentedControl na etapa 4."
- Uma família de fonte por peso, porque o Android não escolhe arquivo por fontWeight [stack e arquitetura; declarada]. Trecho: "com uma família por peso, porque o Android não escolhe arquivo por fontWeight"
- FontGate segura a primeira pintura até as fontes carregarem; se falhar, usa a fonte do sistema [UX e visual; declarada]. Trecho: "FontGate: segura a primeira pintura até as fontes carregarem. Se a carga falhar, segue com a fonte do sistema."
- Geração das fontes com imagem, fontTools e commits do Google Fonts travados e hash conferido [segurança; declarada]. Trecho: "rodam em contêiner, com imagem, fontTools e commits do Google Fonts travados, e conferem o hash do que baixam"
- Dependências e configuração extras: @types/node, *.ttf binary no .gitattributes, manter o plugin expo-font no app.json [stack e arquitetura; declarada]. Trecho: "expo-font, @types/node para o teste que lê os TTFs, *.ttf binary no .gitattributes. O expo install também acrescentou o plugin expo-font ao app.json, e mantive."
- Não reexecutar a CI vermelha da etapa 1 para não esconder o defeito intermitente [testes e processo; declarada]. Trecho: "Não reexecutei a CI, porque uma nova execução podia sair verde por sorte e esconder o defeito abaixo."
- Código de recusa 'registro-simultaneo' para o 409 [regra de produto; declarada]. Trecho: "Nome do código: escolhi registro-simultaneo, porque prefixo-indisponivel já significa outra coisa no cadastro."
- Implementação da correção com sobrecarga de PrimeiroLivreAsync recebendo conjunto de recusados (OrdinalIgnoreCase) e stub GravacaoSempreRecusada no teste [stack e arquitetura; silenciosa, duvidosa]. Trecho: "var recusados = new HashSet<string>(StringComparer.OrdinalIgnoreCase);"
- Push da rodada/eng_04_design, que só existia localmente, para servir de base do PR [testes e processo; declarada]. Trecho: "a rodada/eng_04_design só existia localmente, então fiz o push dela sem mudanças, para servir de base do PR"
- Tolerância do e2e de largura da Archivo ampliada de 1 para 2 px [testes e processo; declarada]. Trecho: "Ajuste, ainda sem commit: a tolerância passa a 2 px, meio pixel por letra."
- Esperar a CI terminar antes do próximo push para não cancelar a execução [testes e processo; declarada]. Trecho: "Só faço o commit e o push da etapa 3 quando ela terminar, porque um novo push na mesma branch cancelaria a execução em andamento."
- Conjunto de 15 ícones, com alert e inbox escolhidos para ErrorState e EmptyState [UX e visual; declarada]. Trecho: "alert e inbox são escolha minha para ErrorState e EmptyState."
- Prop detailColor para pintar o desenho interno do ícone preenchido na cor do fundo [UX e visual; declarada]. Trecho: "criei a prop detailColor para pintar esse desenho na cor do fundo"
- Usar o medal do Lucide como ícone da fita [UX e visual; declarada]. Trecho: "Ícone fita: usei o medal do Lucide, com as fitas acima do círculo"
- ApiStatusScreen fica fora do Screen e sem ErrorState por ser provisória [stack e arquitetura; declarada]. Trecho: "ApiStatusScreen: não migrei para o Screen, porque é uma tela provisória."
- Acessibilidade do Icon: com rótulo vira imagem acessível, sem rótulo fica aria-hidden [UX e visual; silenciosa]. Trecho: "? { accessible: true, role: "img" as const, "aria-label": label } : { "aria-hidden": true }"
- e2e e teste de rota que confirmam que a vitrine não existe no build de produção [testes e processo; declarada]. Trecho: "O e2e também confirma que o texto da vitrine não viaja no bundle de produção."
- Anel de foco só para navegação por teclado (:focus-visible na web) [UX e visual; declarada]. Trecho: "Foco por teclado: anel do token com 2 px de afastamento."
- Button com variantes primária e secundária [UX e visual; declarada]. Trecho: "Button: discreto com 32 de altura e 44 de toque, grande com 50, nas variantes primária e secundária."
- O 'Tentar de novo' da tela de status passa a usar o Button [UX e visual; declarada]. Trecho: "Fora da sua lista: o "Tentar de novo" da tela de status passou a usar o Button"
- Remover o contorno do navegador com outline-style: none [UX e visual; declarada]. Trecho: "Largura 0 não o remove, e a correção é outline-style: none, que o e2e agora confere."
- Chip inativo em contorno (line), contra o uso de surface do tokens.json [UX e visual; declarada]. Trecho: "Fundo do chip inativo | contorno em line"
- Chip com 32 de altura e 44 de toque [UX e visual; declarada]. Trecho: "Altura do chip | 32, com 44 de toque"
- Borda de 1 px em line no trilho do segmentado [UX e visual; declarada]. Trecho: "Borda do trilho do segmentado | 1 px em line"
- Texto do botão grande em Instrument Sans 700 tamanho 15 [UX e visual; declarada]. Trecho: "Texto do botão grande | Instrument Sans 700, tamanho 15"
- Texto do campo em 16, fora da escala, por causa do zoom do Safari [UX e visual; declarada]. Trecho: "Texto do campo | tamanho 16, fora da escala"
- Rótulo do campo em 14, peso 600 [UX e visual; declarada]. Trecho: "Rótulo do campo | tamanho 14, peso 600"
- Segmento ativo desativado mantém segmentOn, sem sombra [UX e visual; declarada]. Trecho: "Segmento ativo desativado | mantém segmentOn, sem sombra"
- Segmentado navega só com Tab, sem as setas de grupo de rádio [UX e visual; declarada]. Trecho: "Teclado no segmentado: navega com Tab, sem as setas que um grupo de rádio costuma ter."
- Chip de filtro exposto como checkbox [UX e visual; declarada]. Trecho: "Papel do chip: é exposto como checkbox."
- Sem teste automatizado da volta da opacidade ao soltar; conferido só no navegador [testes e processo; declarada]. Trecho: "A volta da opacidade ao soltar não tem teste automatizado, porque não consegui simular o fim do toque no Jest."
- Reiniciar o Docker Desktop pela CLI sem avisar a persona antes [testes e processo; declarada]. Trecho: "Reiniciei o Docker eu mesmo. [...] Rodei docker desktop restart uma vez e voltou."
- Rodar o e2e de controles num servidor provisório sem API enquanto o Docker estava fora [testes e processo; declarada]. Trecho: "contra o build de produção num servidor provisório com o mesmo fallback do Caddy e sem API"
- Halo da bolinha de novidade sempre em bg [UX e visual; declarada]. Trecho: "Halo na aba ativa | sempre em bg, como diz o token"
- Altura da navegação de 50 mais a área segura, com mínimo de 84 [UX e visual; declarada]. Trecho: "Altura com área segura | 50 + área segura, com mínimo de 84"
- Texto padrão do erro: 'Não deu certo agora.' / 'Tente de novo em instantes.' [UX e visual; declarada]. Trecho: "Texto padrão do erro | "Não deu certo agora." e "Tente de novo em instantes.""
- Ícone de 32 nos estados vazio e erro [UX e visual; declarada]. Trecho: "Tamanho do ícone em vazio e erro | 32"
- Iniciais em Archivo 700 a 40% do tamanho do avatar [UX e visual; declarada]. Trecho: "Fonte das iniciais | Archivo 700, a 40% do tamanho do avatar"
- Iniciais do primeiro e do último nome; com um nome só, uma letra [regra de produto; declarada]. Trecho: "Iniciais | primeiro e último nome; com um nome só, uma letra"
- Prop aboveNav no Screen para não somar a área segura duas vezes [stack e arquitetura; declarada]. Trecho: "Área segura em dobro (pendência da etapa 3): confirmei o problema e criei aboveNav no Screen, com teste."
- Novidade também anunciada no rótulo de acessibilidade da aba [UX e visual; declarada]. Trecho: "O leitor de tela também ouve "Mural, com novidade"."
- EmptyState e ErrorState juntos em StateMessage.tsx, com ação opcional e anúncio só no texto [UX e visual; declarada]. Trecho: "EmptyState e ErrorState: ficam em StateMessage.tsx, com ação opcional."
- Medidas do ornamento do token valem para o medalhão de 48 e escalam [UX e visual; declarada]. Trecho: "Escala do ornamento | medidas do token valem para o medalhão de 48"
- Lendário com 32 traços de 2 px [UX e visual; declarada]. Trecho: "Raios do lendário | 32 traços de 2 px"
- Com raridade, sempre reserva a folga do lendário (74 px no de 48) [UX e visual; declarada]. Trecho: "Espaço do medalhão | com raridade, sempre reserva a folga do lendário: 74 px no de 48"
- Glifo em contorno, ocupando 50% do metal [UX e visual; declarada]. Trecho: "Glifo | contorno, ocupando 50% do metal"
- Selo com altura 26, medalhão 18 e nome em Archivo 700 tamanho 12 [UX e visual; declarada]. Trecho: "Selo | altura 26, medalhão 18, nome em Archivo 700 tamanho 12"
- Faixa com raio 16 e tier em negrito [UX e visual; declarada]. Trecho: "Faixa | raio 16, tier em negrito"
- Trilha com círculo 36, passo de 82 px, tracejado 4/4 e rótulo em Archivo 700 tamanho 12 [UX e visual; declarada]. Trecho: "Trilha | círculo 36, passo de 82 px, tracejado 4/4, rótulo em Archivo 700 tamanho 12"
- Cartão de título e resumo da trilha dentro do componente [stack e arquitetura; declarada]. Trecho: "Título da trilha | o cartão com título e resumo fica dentro do componente"
- Lacuna no meio da trilha: os obtidos seguintes mantêm o medalhão, sem linha contínua [regra de produto; declarada]. Trecho: "Lacuna na trilha | se um passo do meio não foi obtido, os seguintes obtidos seguem com medalhão, sem linha contínua"
- Teste de regra que falha com gradiente fora de Medalhao/SeloPremio ou sombra fora do SegmentedControl [testes e processo; declarada]. Trecho: "Teste novo de regra: falha se gradiente aparecer fora de Medalhao e SeloPremio, ou sombra fora do SegmentedControl."
- Conteúdo da FaixaPremio: tier e raridade em texto, pontos à direita, nota e rótulo opcionais [UX e visual; declarada]. Trecho: "FaixaPremio: medalhão, nome, tier e raridade em texto, e pontos à direita, com nota e rótulo opcionais."
- Vetorização com potrace sobre o alfa ampliado 8 vezes, com desfoque de 0,6 px [UX e visual; declarada]. Trecho: "Traçado: potrace 2.1.8, instalado só no scratchpad, sobre o alfa do PNG ampliado 8 vezes, com um desfoque de 0,6 px"
- Usar o ouro do token #F5B400 no SVG, antes de perguntar, em vez do #FAB301 do PNG [UX e visual; declarada]. Trecho: "Usei o gold do token, #F5B400, mas o PNG é #FAB301."
- Reabrir os cortes do XX pré-processando o alfa pelo eixo lido no PNG, sem editar o caminho à mão [UX e visual; declarada]. Trecho: "antes de traçar, reabro os dois cortes com largura de 1 px, seguindo o eixo lido no alfa do PNG. Editar o caminho à mão não foi necessário."
- Script design/icones/gerar.js rasteriza os ícones com o chromium do Playwright [stack e arquitetura; silenciosa]. Trecho: "const { chromium } = require("
- Medidas dos ícones: logo com 760 px no ícone de 1024, 620 no adaptativo, monocromático em branco, favicon de 64 px [UX e visual; declarada]. Trecho: "icon.png | 1024 px, logo em ouro sobre marinho #0B2A55, com 760 px de largura"
- Favicon com o XX sobre marinho e cantos arredondados [UX e visual; declarada]. Trecho: "Usei marinho com cantos arredondados, para o ouro não perder contraste em aba clara."
- Remover android-icon-background.png (fundo só por cor) e configurar expo-splash-screen com imageWidth 200 [stack e arquitetura; declarada]. Trecho: "entrou expo-splash-screen, e saiu o android-icon-background.png, porque o fundo agora é só a cor."
- Rodar expo prebuild para conferir e depois restaurar app.json/package.json e apagar android/ [testes e processo; declarada]. Trecho: "O prebuild alterou o app.json e o package.json e criou a pasta android/; restaurei os dois arquivos e removi a pasta"
- Conteúdo e organização dos docs de fechamento, com aviso de que o prebuild mexe no package.json e android/ios ficam fora do git [testes e processo; declarada]. Trecho: "`npx expo prebuild` gera `android/` e `ios/`, que ficam fora do git. Ele também mexe em `package.json`, e isso não deve entrar em commit."
- Título do PR do passo 4 [testes e processo; declarada]. Trecho: "Título do PR: usei feat(mobile): passo 4, design system, porque ele cobre mais do que uma etapa."

Perguntas do agente:

- 1. Origem do ícone e do splash: você tem SVG ou versão maior do logo? [respondida]
- 2. Arte do ícone: logo em ouro sobre marinho no ícone e no adaptativo, favicon com recorte do XX, splash em ouro sobre o bg de cada tema? [respondida]
- 3. Troca de tema: Sistema, Claro e Escuro, padrão Sistema, persistido com AsyncStorage? [respondida]
- 4. Dependência de ícones: só react-native-svg com os caminhos do Lucide num Icone nosso? [respondida]
- 5. Vitrine: rota só de desenvolvimento (__DEV__), fora do build de produção? [respondida]
- 6. Trilha: seguir o produto, TrilhaFamilia por itens, até 5 passos, rolando na horizontal? [respondida]
- 7. Anel de foco no claro: seguir o token, com afastamento de 2 px? [respondida]
- 8. Pressionado e desativado: desativado com surface2 e ink3, pressionado com opacidade 0,85? [respondida]
- 9. Cores de avatar: só o token avatarBg? [respondida]
- 10. Raio do chip: raio 8 e corrigir a frase no tokens.json? [respondida]
- Premissas (me corrija se discordar): tokens.json sem mudança de estrutura, fontTools em Docker, pranchetas sem referência de fonte, nomes dos componentes, altura da navegação [respondida]
- Como corrigir o job api? PR separado, commit nesta branch ou reexecutar até passar [respondida]
- Aprovar o ajuste do teste de fontes como commit próprio, sem reescrever o da etapa 2? [respondida]
- Etapa 4: confirma as sete decisões (chip, altura do chip, trilho, botão grande, texto e rótulo do campo, segmento desativado)? [respondida]
- Etapa 5: confirma as seis decisões (halo, altura com área segura, texto do erro, ícone 32, fonte e regra das iniciais)? [respondida]
- Etapa 6: confirma as decisões do medalhão, selo, faixa e trilha? [respondida]
- O traçado do SVG está aprovado? (primeira versão) [respondida]
- Qual ouro usar no SVG, o gold do token #F5B400 ou o #FAB301 do PNG? (feita duas vezes) [respondida]
- O traçado está aprovado? (versão com os cortes do XX reabertos) [respondida]
- Os ícones estão aprovados? [respondida]
- Favicon sobre marinho, ou o XX sem fundo? [respondida]
- Instalar expo-system-ui? [respondida]
- Qual identificador do app? Por exemplo br.com.unimax.maxx, ou deixo para o passo 13? [respondida]

## Export eng_05_login

Decisões sem perguntar:

- Debounce de 500 ms na disponibilidade do arroba, cancelando o pedido anterior e conferindo o formato antes de consultar [UX e visual; declarada]. Trecho: "A disponibilidade usa debounce de 500 ms, cancela o pedido anterior e confere o formato antes de consultar."
- Serializar o refresh entre abas com navigator.locks (Web Locks) e compartilhar o refresh em voo dentro da aba [stack e arquitetura; declarada]. Trecho: "Na web, navigator.locks serializa entre abas. Dentro da aba, os pedidos compartilham o refresh em voo."
- Sem Web Locks (fora de HTTPS), fica só a fila da própria aba [stack e arquitetura; declarada]. Trecho: "Sem ela (página fora de HTTPS), fica só a fila da própria aba."
- Access token só em memória; refresh em expo-secure-store no nativo e cookie com X-Maxx-Cliente na web [segurança; declarada, duvidosa]. Trecho: "Refresh em expo-secure-store no nativo e cookie com X-Maxx-Cliente: web na web."
- Renovação proativa 30 s antes de vencer; 401 provoca uma renovação e uma única repetição [stack e arquitetura; declarada]. Trecho: "Se o token está a menos de 30 segundos de vencer, a sessão é renovada antes do pedido."
- Estado 'sem conexão': falha de rede, 429 ou 5xx não encerram a sessão; só sessao-invalida encerra [regra de produto; declarada]. Trecho: "Falha de rede, 429 ou 5xx não encerram a sessão. Só sessao-invalida encerra."
- Esvaziar o cache de consultas só ao sair de uma sessão autenticada [segurança; declarada]. Trecho: "A correção esvazia o cache só quando se sai de uma sessão autenticada"
- Tabela única código→mensagem com os textos amigáveis e mensagem padrão para código desconhecido [UX e visual; declarada]. Trecho: "Código desconhecido cai na mensagem padrão."
- Teste que lê CodigosDeRecusa.cs e DomainExceptionHandler.cs e falha se um código da API não tiver mensagem [testes e processo; declarada]. Trecho: "Esse teste lê CodigosDeRecusa.cs e DomainExceptionHandler.cs, então um código novo na API sem mensagem no app quebra o teste."
- createApiClient ganha fetch opcional para injetar o gerenciador de sessão [stack e arquitetura; declarada]. Trecho: "createApiClient ganhou um fetch opcional, e o layout raiz liga tudo isso."
- Tabelas termo_de_uso (PK versão >= 1) e aceite_de_termo (PK usuário+versão, FK RESTRICT ao termo, cascata com o usuário) [modelo de dados; declarada]. Trecho: "Apagar o usuário apaga os aceites dele [...] Uma versão que alguém aceitou não pode sair do banco."
- Versão publicada imutável no seed (falha sem gravar), fim de linha ignorado, vigente é a de número mais alto [modelo de dados; declarada]. Trecho: "Uma versão publicada não muda nem some: texto alterado ou arquivo apagado faz o seed falhar sem gravar nada."
- Status e códigos do termo: 400 dados-invalidos, 409 termo-desatualizado, 404 termo-indisponivel [stack e arquitetura; declarada]. Trecho: "Com uma versão que não é a vigente, é 409 termo-desatualizado."
- Apagar a linha do termo no banco local, reconstruir a imagem do seeder e republicar antes do commit [testes e processo; declarada]. Trecho: "vou apagar essa linha e rodar o seed de novo, antes do commit e do push"
- Detalhes do erro de campo: legenda, ícone 16, gap 8, role alert, accessibilityHint, borda like também no foco com espessura do foco [UX e visual; declarada]. Trecho: "Borda em like, inclusive com o campo em foco (aí com a espessura do foco)."
- Logo vetorial com react-native-svg gerado por script novo design/icones/logoVetor.js integrado ao gerar.js, com teste de sincronia [stack e arquitetura; declarada]. Trecho: "O traçado vem de design/assets/maxx-ouro.svg por um script novo, design/icones/logoVetor.js"
- Screen com rolagem passa a ocupar ao menos a altura da tela para o rodapé ficar no fim [UX e visual; declarada]. Trecho: "o Screen com rolagem passou a ocupar ao menos a altura da tela"
- Conteúdo da tela de autenticação centrado no espaço acima do pé [UX e visual; silenciosa]. Trecho: "conteudo: { flexGrow: 1, justifyContent: "center", gap: 24, paddingTop: 24 }"
- Grupos de rotas (publico) e (app), espera com logo e indicador, 'Sem conexão' com Tentar de novo; /status pública [stack e arquitetura; declarada]. Trecho: "Grupo (app): o que exige login. Sem sessão, manda para /login."
- Login: credencial errada no campo da senha, outros erros abaixo do botão, campo vazio sem ir à API, identificador com trim [UX e visual; declarada]. Trecho: "Credencial errada aparece no campo da senha. Limite de taxa e falta de rede aparecem abaixo do botão"
- Links para /cadastro e /esqueci-senha caem em rota inexistente até as etapas 5 e 6 [UX e visual; declarada]. Trecho: "Quem tocar nelas agora cai na página padrão de rota inexistente do Expo Router."
- Adiar a leitura do Mailpit da etapa 4 para a etapa 6 [testes e processo; declarada]. Trecho: "A leitura do Mailpit, que o plano punha nesta etapa, ficou para a 6"
- e2e cria linhas próprias de cadastro elegível direto no Postgres por psql, com curso CC do seed demo [testes e processo; declarada]. Trecho: "e2e/tests/apoio/contas.ts cria uma linha nova de elegível por teste, direto no Postgres do compose"
- Fluxos com conta só no @celular claro/escuro; teste de limite só no celular-claro [testes e processo; declarada]. Trecho: "os fluxos com cadastro e login rodam só em @celular, claro e escuro"
- Dados do cadastro só em memória num contexto; senha fora de URL e armazenamento; recarregar volta ao passo 1 [segurança; declarada]. Trecho: "a senha não vai para a URL nem para o armazenamento, e recarregar no meio volta ao passo 1"
- Validação no cliente espelhando o domínio (senha 8 a 128, emoji como um caractere) [regra de produto; declarada]. Trecho: "A contagem trata emoji como um caractere, como o domínio."
- Passos 2 e 3 sem prancheta com 'Voltar', '2 de 3', título e termo rolando com o botão no fim [UX e visual; declarada]. Trecho: "Eles mostram "Voltar" e "2 de 3" ou "3 de 3" no alto e um título na escala titulo."
- Acrescentar o ícone check do Lucide 1.70.0 ao Icon [UX e visual; declarada]. Trecho: "Acrescento o check do Lucide 1.70.0 ao Icon"
- Termo alterado durante a leitura pede novo aceite; arroba tomado oferece 'Escolher outro arroba'; RA com conta leva à recuperação [regra de produto; declarada]. Trecho: "Se outra pessoa tomou o arroba no último instante, a tela oferece "Escolher outro arroba"."
- Formato do texto do termo restrito a parágrafos e títulos '## ' [stack e arquitetura; declarada]. Trecho: "o que começa por "## " é título de seção. Nada além disso, de propósito."
- Desligar a coleta de cache (gcTime Infinity) no cliente de teste [testes e processo; declarada]. Trecho: "O cliente de teste agora desliga essa coleta."
- Token de recuperação capturado uma vez ao carregar o bundle, só na rota /redefinir-senha, apagado com replaceState [segurança; declarada]. Trecho: "Agora o token é capturado uma única vez, quando o bundle carrega"
- /redefinir-senha fora dos grupos de rotas [stack e arquitetura; declarada]. Trecho: "/redefinir-senha, fora dos grupos, porque o link pode ser aberto com ou sem sessão"
- Senha nova encerra a sessão local; link sem token ou nativo mostra 'link incompleto' sem formulário [regra de produto; declarada]. Trecho: "Se havia uma sessão aberta no aparelho, ela é encerrada"
- Reescrever a frase de abertura do Esqueci minha senha [UX e visual; declarada]. Trecho: "troquei a frase de abertura do pedido, que dizia "Mandamos um link" antes de a pessoa pedir"
- FilterChip ganha papel radio; radiogroup só na web [UX e visual; declarada]. Trecho: "O FilterChip ganha um papel opcional de radio, porque a escolha do curso é única."
- Botão da demonstração secundário, abaixo do texto do primeiro acesso, só com resposta 200 [UX e visual; declarada]. Trecho: "O botão "Entrar na demonstração" (discreto, abaixo do texto do primeiro acesso) só aparece com resposta 200."
- Contas de demonstração em AsyncStorage na web e secure store no nativo; chave guardada antes de entrar; lista malformada vira vazia [segurança; declarada]. Trecho: "A chave fica guardada antes de entrar: se a sessão cair, a pessoa ainda volta pela lista."
- chave-invalida tira a conta da lista; curso-indisponivel volta à escolha do curso [regra de produto; declarada]. Trecho: "curso-indisponivel: volta à escolha do curso."
- Aviso na tela da demonstração de que as contas de teste são apagadas [UX e visual; declarada, duvidosa]. Trecho: "Mostra um título e um aviso de que as contas de teste são apagadas ao fim da avaliação."
- CI do e2e em duas passadas (--grep-invert @demo e --grep @demo) com lote e2e-ci-run_id [testes e processo; declarada]. Trecho: "CI: o job e2e agora roda em duas passadas."
- Publicar a branch rodada/eng_05_login no remoto para abrir o PR, sem perguntar [testes e processo; declarada]. Trecho: "vou publicá-la como está e abrir o PR."
- Início provisório lê o arroba de GET /v1/eu [stack e arquitetura; declarada]. Trecho: "Início provisório: mostra "Você entrou como @arroba", lido de GET /v1/eu"
- Componente AvisoDeErro para erro de formulário com o mesmo desenho do erro de campo [UX e visual; silenciosa]. Trecho: "O mesmo desenho do erro de campo: ícone em `like`, texto em `ink`, anunciado ao aparecer."
- expo-secure-store instalado via expo install com config plugin no app.json [stack e arquitetura; silenciosa]. Trecho: "› Added config plugin: expo-secure-store"
- Branch feat/passo-05-login, um commit por etapa e um PR no fim [testes e processo; declarada, duvidosa]. Trecho: "Tudo em feat/passo-05-login, saindo da rodada, com um commit por etapa e um PR no fim."

Perguntas do agente:

- Decisão 1: onde entram nome e arroba no cadastro [respondida]
- Decisão 2: texto no lugar do Portal UniMax [respondida]
- Decisão 3: texto e guarda do termo [respondida]
- Decisão 4: quem aceita, e se há novo aceite [respondida]
- Decisão 5: versaoDoTermo obrigatório em duas rotas [respondida]
- Decisão 6: o que aparece depois de entrar, já que o feed só chega no passo 7 [respondida]
- Decisão 7: aparência do erro de campo [respondida]
- Decisão 8: botão grande só no Entrar ou também em Criar conta [respondida]
- Secure store e deep link não serão testados em aparelho, a menos que você queira fazer essa conferência [respondida]
- O texto não fala de LGPD, direitos do titular, contato, prazo de guarda [...] Se quiser algum desses pontos, me diga o conteúdo. [respondida]
- Se quiser o bloco na mesma altura da prancheta, ajusto antes do commit. [respondida]
- Se quiser, apago esses alunos com o SQL da purga do README. [respondida]
- Se você contava outro fix, me diga qual e ajusto a descrição. [respondida]
- O risco 'Rede do campus na apresentação' e o ensaio do passo 13 supõem apresentação presencial; reescrever o passo 13 é decisão sua [respondida]
- TermoDeUso e AceiteDeTermo não estão no glossário do CLAUDE.md. Se quiser, acrescento as duas linhas. [respondida]
- Linha 'Banca' e justificativa do limite de 60 registros por hora ainda supõem apresentação presencial; ficam para quando você quiser revisar [sem resposta]

## Export eng_06_medalhas

Decisões sem perguntar:

- Troca do rótulo Banca por Avaliação e justificativa do limite de 60/h pelo CGNAT de operadora [segurança; declarada, duvidosa]. Trecho: "a rede móvel costuma pôr muitos aparelhos atrás do mesmo IP (CGNAT da operadora)"
- Cria a branch feat/passo-06-medalhas [testes e processo; declarada, duvidosa]. Trecho: "Criei a branch feat/passo-06-medalhas a partir da rodada/eng_06_medalhas"
- Adia o registro da regra F no produto.md para o commit da etapa 4 [testes e processo; declarada, duvidosa]. Trecho: "Vou registrá-la no commit da etapa 4"
- Tabela trabalho: concluído sai da tabela, estados pendente/falho, índice parcial dos pendentes [modelo de dados; declarada]. Trecho: "Trabalho concluído sai da tabela"
- Handler roda na transação que segura a linha, com ponto de salvamento; queda do processo não conta tentativa [stack e arquitetura; declarada]. Trecho: "roda o handler na mesma transação que segura a linha"
- Limite de 60 s por handler; tipo sem handler conta como falha [stack e arquitetura; declarada]. Trecho: "um handler que passa de 60 s é cancelado e conta como falha"
- Erro gravado só com tipo e mensagem (até 2000 caracteres), sem a carga [segurança; declarada]. Trecho: "O erro guarda só tipo e mensagem, nunca a carga"
- Worker espera 1 s quando a fila está vazia [stack e arquitetura; silenciosa]. Trecho: "Com a fila vazia, o worker espera 1 s"
- Serviço worker no compose sem porta, dependendo do seeder, com restart unless-stopped [hospedagem e deploy; declarada]. Trecho: "worker: ... depends_on: seeder ... restart: unless-stopped"
- Validade de 30 min do token passa a contar do envio (confirmada depois pela persona) [regra de produto; declarada, duvidosa]. Trecho: "os 30 minutos agora contam do envio, não do pedido"
- Pedido de recuperação já encerrado quando o trabalho roda não gera e-mail [regra de produto; declarada]. Trecho: "Pedido já encerrado quando o trabalho roda (outro link trocou a senha) não gera e-mail"
- Hash da recuperação passa a aceitar nulo, com check ck_recuperacao_senha_token [modelo de dados; declarada]. Trecho: "o hash passa a aceitar nulo, e a constraint ck_recuperacao_senha_token"
- Variáveis de SMTP saem da API e vão só para o worker; App__UrlPublica fica nos dois [hospedagem e deploy; declarada]. Trecho: "as variáveis de SMTP saíram da API e foram para o worker"
- Log de e-mail enviado com o assunto e sem o destinatário [segurança; declarada]. Trecho: "O log "E-mail enviado" passou para o SmtpEmailSender, com o assunto e sem destinatário"
- Lista dos motivos de recusa da concessão, separados dos erros de quem chama [regra de produto; declarada]. Trecho: "Motivos de recusa: ex-aluno, data fora do semestre da turma, data no semestre mas entre dois bimestres, item fora de vigência"
- Anulação idempotente: medalha já anulada não muda e o comando sai com 0 [regra de produto; declarada]. Trecho: "devolve falso se a medalha já estava anulada, sem mudar nada"
- Desenho das rotas /api/v1/professor (turmas, alunos, medalhas, concessão) e dos formatos de resposta [stack e arquitetura; declarada]. Trecho: "POST /turmas/{turmaId}/medalhas {alunoId, item}"
- Mapeamento de status e códigos de recusa, com o tipo novo Proibido (403) e aluno sem conta respondendo 404 [stack e arquitetura; declarada]. Trecho: "a Application ganhou um tipo novo de recusa, Proibido"
- Concessão simultânea: quem perde relê e tenta uma vez a próxima vaga livre, senão 409 [stack e arquitetura; declarada]. Trecho: "a que perde relê e tenta uma vez a próxima vaga livre"
- Chaves estrangeiras sem cascata e check constraints na tabela medalha [modelo de dados; declarada]. Trecho: "chaves estrangeiras sem cascata para aluno, professor, quem anulou, item, turma"
- Índice único de deduplicação só entre as medalhas ativas [modelo de dados; declarada, duvidosa]. Trecho: "O índice único ix_medalha_chave_ativa cobre só as medalhas não anuladas"
- Catálogo do modal mostra só as medalhas vigentes hoje [regra de produto; declarada]. Trecho: "As medalhas do catálogo vigentes hoje, para o modal"
- Lista de turmas com a contagem de alunos com conta; alunos por nome, com as medalhas ativas na turma [UX e visual; declarada]. Trecho: "Os alunos com conta e não ex-alunos, por nome, com as medalhas ativas que já têm nessa turma"
- Comando de anulação roda no serviço seeder do compose [hospedagem e deploy; declarada]. Trecho: "docker compose run --rm seeder anular-medalha <id> --instituicao <e-mail>"
- Códigos de saída do comando de anulação: 0, 1 e 2 [stack e arquitetura; declarada]. Trecho: "Uso errado │ a linha de uso │ 2"
- Conta que é professor e instituição ao mesmo tempo também pode anular [segurança; declarada]. Trecho: "Contas que são professor e instituição ao mesmo tempo também anulam"
- Controle de concorrência na medalha pelo xmin (migration MedalhaVersao) [modelo de dados; declarada]. Trecho: "a medalha ganhou controle de concorrência pelo xmin"
- Comando de anulação sobe sem exigir chave JWT nem URL pública [segurança; declarada]. Trecho: "O comando sobe sem exigir chave JWT nem URL pública, como o seed e o migrate"
- Tabela notificacao com índice único (usuário, tipo, referência) para idempotência; o texto não fica no banco [modelo de dados; declarada]. Trecho: "O texto exibido não fica no banco: o cliente monta pelo tipo"
- Medalha anulada ou purgada antes do trabalho rodar não gera notificação [regra de produto; declarada]. Trecho: "Medalha anulada antes de o trabalho rodar, ou apagada pela purga, não notifica"
- Faixas de raridade em números inteiros, com abaixo de estrito; item sem dono é Lendário [regra de produto; declarada, duvidosa]. Trecho: "com "abaixo de" estrito nas fronteiras de 1%, 5% e 20%"
- Numerador da raridade: alunos distintos com medalha ativa, contando ex-alunos [regra de produto; declarada]. Trecho: "Numerador: alunos distintos com ao menos uma medalha ativa do item, contando ex-alunos"
- Numerador limitado ao divisor nos itens restritos quando o aluno trocou de curso (confirmado depois) [regra de produto; declarada, duvidosa]. Trecho: "Uma decisão minha: quem trocou de curso leva a medalha de item restrito"
- Coalescência por linha travada na tabela recalculo, apagando os pedidos pendentes e adiando um pedido; Enfileirar ganha disponivelEm [stack e arquitetura; declarada]. Trecho: "Uma linha travada na tabela recalculo impede dois cálculos ao mesmo tempo"
- Rota GET /v1/eu/premios só para aluno, com nome que evita troféu [stack e arquitetura; declarada]. Trecho: "O nome evita "troféu", que só existe na interface"
- Conteúdo da leitura do aluno: pontos das ativas, percentual com uma casa, obtidos do mais recente ao mais antigo, anulada fora [regra de produto; declarada]. Trecho: "a raridade, com o nível e o percentual com uma casa decimal"
- Raridade nula até o primeiro cálculo, e a linha mostra só o tier [UX e visual; declarada]. Trecho: "A raridade vem nula enquanto o worker não calculou"
- Itens restritos a outro curso ficam fora da lista, salvo o já obtido (confirmado depois) [regra de produto; declarada, duvidosa]. Trecho: "Itens restritos a outro curso ficam de fora da lista"
- Seed base pede o primeiro recálculo de raridade (confirmado depois) [stack e arquitetura; declarada, duvidosa]. Trecho: "O seed base agora pede o primeiro cálculo de raridade"
- Ícones novos do Lucide, componente Cabecalho e accessibilityLabel no Button [UX e visual; declarada]. Trecho: "O Icon ganhou voltar, avancar e fechar, do Lucide"
- Modal em folha que sobe de baixo; Conceder só com item escolhido; erros dentro do modal; ao conceder, fecha, confirma e recarrega [UX e visual; declarada]. Trecho: "uma folha que sobe de baixo, como as do Instagram"
- Textos das mensagens de erro dos códigos da medalha [UX e visual; silenciosa]. Trecho: ""limite-atingido": "Esse aluno já recebeu essa medalha o máximo de vezes no período.""
- Teste de mensagens exige exatamente dois arquivos Codigos*.cs [testes e processo; declarada]. Trecho: "expect(arquivosDeCodigos()).toHaveLength(2)"
- Troca do estilo rotulo por secao em nomes e matérias [UX e visual; declarada]. Trecho: "Troquei por secao (Archivo 700, 15 px)"
- Capturas com Playwright em 390x844, com dados criados no compose local [testes e processo; declarada]. Trecho: "Capturas, no compose local, em 390×844"
- GET /v1/eu passa a trazer nomeDeExibicao [stack e arquitetura; declarada]. Trecho: "GET /v1/eu passa a trazer o nome de exibição"
- Grupo de rotas (abas), com /turmas fora das abas [stack e arquitetura; declarada]. Trecho: "/turmas fica fora das abas, como tela interna com voltar"
- Mostrar não obtidos ligado por padrão [UX e visual; declarada]. Trecho: ""Mostrar não obtidos": ligado por padrão"
- Trilhas só das famílias em que o aluno tem algum item; passos rotulados pelo tier [UX e visual; declarada]. Trecho: "Trilhas: só das famílias em que o aluno já tem algum item"
- Ordenação: obtidos primeiro, cada grupo do maior valor para o menor; faltantes apagados e sem o + [UX e visual; declarada]. Trecho: "os obtidos primeiro e depois os que faltam, cada grupo do maior valor para o menor"
- Professor na aba Troféus vê um aviso, e a tela não pede os prêmios [UX e visual; declarada]. Trecho: "Professor na aba vê "Troféus e medalhas são dos alunos.""
- Polegar do botão branco nos dois temas [UX e visual; declarada]. Trecho: "agora é branco nos dois temas, como na prancheta"
- Trilha que mistura medalha e conquista aparece nas duas abas (persona mandou manter) [UX e visual; declarada, duvidosa]. Trecho: "a trilha "Nota 10 em prova" aparece nas duas abas"
- e2e cria a própria professora (Postgres, seed demo e Mailpit) e roda nos dois projetos de celular [testes e processo; declarada]. Trecho: "Cada execução cria a própria professora"
- Esperar a CI da etapa anterior antes do push, porque a CI cancela a execução anterior [testes e processo; declarada]. Trecho: "Não faço push agora, porque a CI cancela a execução anterior da mesma branch"
- Envia a branch rodada/eng_06_medalhas para o origin sem perguntar (aprovado depois) [hospedagem e deploy; declarada]. Trecho: "Uma ação fora do combinado: ... Enviei a branch para o origin"
- Plano mestre ganha o alerta de trabalho falho no passo 13 [testes e processo; declarada]. Trecho: "O passo 13 ganhou o alerta de trabalho falho"
- Descrição do PR no formato do PR #7 [testes e processo; declarada]. Trecho: "A descrição segue o formato do PR #7"

Perguntas do agente:

- Fora do seu pedido, banca ainda aparece em ADR 0001, 0005, 0008 e produto.md. Se quiser, eles entram neste mesmo commit. [respondida]
- Decisão A. Onde roda o worker (contêiner próprio, mesma imagem, uma réplica) [respondida]
- Decisão B. Segredo do e-mail na fila (trabalho leva só o id, worker gera o token) [respondida]
- Decisão C. Retentativa (5 tentativas, recuo 10/20/40/80 s) [respondida]
- Decisão D. Ocorrência e anulação (ocorrência pelo sistema, anulada libera vaga) [respondida]
- Decisão E. Concessão fora de bimestre (recusar com código próprio) [respondida]
- Decisão F. Aluno sem conta (não aparece e não recebe) [respondida]
- Decisão G. Entrada do professor (lista da turma e Minhas turmas) [respondida]
- Decisão H. Navegação para Troféus (cinco abas com Em breve) [respondida]
- Decisão I. Bolinha de novidade em Troféus (fica para o passo 10) [respondida]
- Decisão J. Divisor da raridade (alunos com conta, ativos e ex-alunos, demo inclusive) [respondida]
- Decisão K. Auditoria (colunas de quem e quando na própria medalha) [respondida]
- Decisão L. Forma do comando de anulação (Maxx.Api anular-medalha <id> --instituicao <e-mail>) [respondida]
- Duas coisas para você olhar: o ruído relation trabalho does not exist no teste do worker hospedado [respondida]
- Validade: os 30 minutos agora contam do envio. É uma mudança de regra pequena; vale você confirmar. [respondida]
- O produto.md 4.8 ainda diz concede pelo perfil do aluno. Se quiser essa nuance também no produto.md, eu acrescento. [respondida]
- Numerador limitado ao divisor quando o aluno trocou de curso; vale você confirmar. [respondida]
- Duas decisões minhas que valem conferir: item restrito a outro curso fora da lista e seed base pedindo o primeiro recálculo [respondida]
- Se quiser, o cadastro e o registro da demonstração passam a enfileirar o recálculo também. [respondida]
- A trilha Nota 10 em prova aparece nas duas abas; se preferir que cada trilha apareça só numa aba, eu ajusto. [respondida]

## Export eng_07_posts

Decisões sem perguntar:

- Branch feat/passo-07-posts saindo da rodada e voltando por PR [testes e processo; declarada, duvidosa]. Trecho: "Branch: feat/passo-07-posts, saindo da rodada/eng_07_posts e voltando a ela por PR."
- Adaptador de armazenamento com AWSSDK.S3 e dois endereços (interno e público) [stack e arquitetura; declarada]. Trecho: "O adaptador IArmazenamentoDeFotos na Infrastructure, com AWSSDK.S3 ... ArmazenamentoOptions com dois endereços"
- Emulador num perfil do compose ligado só pelo .env.example (COMPOSE_PROFILES), com as variáveis do bucket obrigatórias e sem padrão [hospedagem e deploy; declarada]. Trecho: "vou colocar o emulador num perfil do compose ativado só pelo .env.example, para que nunca suba na VPS"
- Contêiner de inicialização com o AWS CLI 2.38.0 que cria o bucket com leitura anônima de objeto, listagem recusada e CORS só para a origem do app e o Expo [segurança; declarada]. Trecho: "O init cria o bucket com leitura anônima de objeto e CORS só para a origem do app e para o Expo de desenvolvimento."
- Validação da pilha num projeto compose isolado (outra sub-rede e outras portas), sem tocar na pilha do usuário [testes e processo; declarada]. Trecho: "vou testar só o emulador e a inicialização do bucket num projeto separado, com outra sub-rede e outra porta"
- Tabela upload_pendente com chaves ULID <ULID>/feed.jpg e <ULID>/grade.jpg; ULID escrito à mão, sem dependência [modelo de dados; declarada]. Trecho: "O ULID tem 80 bits de gerador criptográfico e foi escrito à mão, sem dependência nova."
- Matriz de quem envia foto: post só de aluno ativo; foto de perfil de aluno, ex-aluno e professor; a instituição não envia [regra de produto; declarada]. Trecho: "post só de aluno ativo; foto de perfil de aluno (ex-aluno inclusive) e de professor; a instituição não envia nada."
- O limite de taxa conta todo pedido de upload, inclusive o recusado [segurança; declarada]. Trecho: "30 por hora por usuário, contando todo pedido, inclusive o recusado."
- A limpeza apaga a linha antes dos objetos, e a corrida com a confirmação é decidida pelo xmin [stack e arquitetura; declarada]. Trecho: "Corrida com a confirmação: o xmin na linha decide."
- Chave estrangeira de upload_pendente para usuario sem cascata [modelo de dados; declarada]. Trecho: "chave estrangeira sem cascata para usuario"
- Frase acrescentada ao README dizendo que as fotos do bucket não saem pela purga SQL [testes e processo; declarada]. Trecho: "Acrescentei também uma frase dizendo que as fotos do bucket não saem por esse SQL"
- Remoção em dois modos: o autor apaga fisicamente; a instituição remove logicamente, com removido_em e removido_por_id (aprovada depois) [modelo de dados; declarada]. Trecho: "o autor apaga de fato, e a instituição remove logicamente, registrando quem e quando"
- O professor não remove post (403); o ex-aluno apaga o próprio post [regra de produto; declarada]. Trecho: "Ninguém mais remove, nem o professor (403). O ex-aluno ainda apaga o próprio post."
- Limites de legenda e de comentário contam emoji como um caractere [regra de produto; declarada]. Trecho: "Legenda de até 1.000 caracteres, contando emoji como um."
- Extensão da D6: na anulação, o post já removido pela instituição fica como estava [regra de produto; declarada]. Trecho: "O post já removido pela instituição fica como estava, para não perder o registro de quem removeu."
- Ajudante de testes compartilhado MundoSocial [testes e processo; declarada]. Trecho: "vou criar um auxiliar compartilhado, MundoSocial"
- A instituição não curte nem comenta (403 interacao-nao-permitida) [regra de produto; declarada]. Trecho: "A instituição recebe 403 interacao-nao-permitida."
- Comentários paginados de 20 em 20 [UX e visual; declarada]. Trecho: "Comentários do mais antigo ao mais novo, 20 por página"
- Cursor opaco em base64url de instante e id, sem assinatura, com a comparação de linha do Postgres [stack e arquitetura; declarada]. Trecho: "O cursor é opaco para o app: base64url de "<ticks UTC>.<id>". Não é segredo nem assinatura"
- Feed em SQL direto, com md5(semente||id), COLLATE "C", recomendações nas posições 4, 8 e 12 e a semente sorteada na primeira página [stack e arquitetura; declarada]. Trecho: "com a comparação de linha, o md5 da semente e COLLATE "C" na ordem das chaves"
- Não tratar a repetição de post ao seguir alguém no meio da sessão, porque o feed não guarda estado no servidor [regra de produto; declarada]. Trecho: "Não tratei porque exigiria guardar os já vistos, e o feed não tem estado no servidor."
- Leitura dos posts em lote (uma consulta para os posts e outra para as medalhas) [stack e arquitetura; declarada]. Trecho: "trocar a consulta de posts por uma versão em lote"
- Teste do índice com enable_seqscan desligado; relógio do teste avançando 100 ms [testes e processo; declarada, duvidosa]. Trecho: "o teste desliga a varredura (enable_seqscan = off)"
- Grade do perfil com 18 posts por página e busca com 20 por página [UX e visual; declarada]. Trecho: "18 por página (seis linhas de três)"
- ETag fraca com Cache-Control: private, no-cache no perfil [stack e arquitetura; declarada]. Trecho: "ETag fraca calculada do conteúdo e Cache-Control: private, no-cache"
- Conta só de instituição sem perfil social (404) [regra de produto; declarada]. Trecho: "Conta só de instituição: não tem perfil social e recebe 404."
- Edição de perfil tudo ou nada; trocar e remover a foto no mesmo pedido recebe 400 [regra de produto; declarada]. Trecho: "a edição é tudo ou nada ... Trocar e remover no mesmo pedido recebe 400 foto-de-perfil-ambigua"
- Foto de perfil (derivada da grade) no autor do post, no autor do comentário e em /v1/eu [modelo de dados; declarada]. Trecho: "Avatar em todo lugar: a derivada da grade aparece no autor do post e do feed, no autor do comentário e no GET /v1/eu."
- Função imutável maxx_sem_acento e índices GIN de trigramas no nome e no prefixo; % e _ tratados como texto [stack e arquitetura; declarada]. Trecho: "uma função imutável maxx_sem_acento, porque o unaccent sozinho não pode entrar em índice"
- BuscarComPrefixosAsync só para a edição, sem Include nas outras buscas [stack e arquitetura; declarada]. Trecho: "Criei BuscarComPrefixosAsync, usado só pela edição"
- Layout da tela de novo post: área quadrada de foto, Trocar e Remover foto, contador 45/1.000, prêmio por concessão desmarcável, volta ao início depois de publicar [UX e visual; declarada]. Trecho: "Foto: área quadrada em cima, como no "novo post" do Instagram."
- Botão provisório "Novo post" no início até a etapa 8 [UX e visual; declarada]. Trecho: "Entrada: botão "Novo post" no início provisório, só para aluno"
- Derivadas sem ampliar foto menor e segunda tentativa mais comprimida quando passam do limite [regra de produto; declarada]. Trecho: "Se uma derivada passar do limite da API, uma segunda tentativa mais comprimida"
- Reaproveitar o upload já feito quando a publicação falha, sem gastar o limite [stack e arquitetura; declarada]. Trecho: "a nova tentativa reaproveita o upload já feito, sem gastar outro pedido do limite"
- Campo postId nos prêmios de /v1/eu/premios [modelo de dados; declarada]. Trecho: "API, um campo novo: postId em cada prêmio obtido de /v1/eu/premios"
- Plugin do seletor no app.json com texto de permissão em português e sem câmera; ícones do Lucide [segurança; declarada]. Trecho: "o app.json ganhou o plugin do seletor, com texto de permissão em português e sem câmera"
- HEIC na web sem conversão, com mensagem amigável [regra de produto; declarada]. Trecho: "HEIC na web: o Chrome não abre HEIC. Quem escolher um vê "Não deu para abrir essa foto."
- Nome no cartão do feed sem @ e sem sufixo [UX e visual; declarada]. Trecho: "Nome de usuário: o arroba sem "@" e sem sufixo (anaSouza)"
- Faixa do prêmio refeita, com matéria e bimestre numa linha de detalhe sob o tier [UX e visual; declarada]. Trecho: "A comparação me fez corrigir a faixa do prêmio."
- Menu "..." só para o autor e a instituição, com confirmação na folha; a instituição não vê o coração [UX e visual; declarada]. Trecho: "Menu "...": só para o autor ("Apagar post") e para a instituição ("Remover post")"
- Números no formato brasileiro e tempo relativo ("há 2 horas") [UX e visual; declarada]. Trecho: "tempo ("há 2 horas"). Números no formato brasileiro."
- Retorno depois do login restrito a /post/:id e aos comentários dele [segurança; declarada]. Trecho: "O retorno aceita só /post/:id e os comentários dele. ... Restringi."
- Aba Perfil provisória até a etapa 9, com tema, Minhas turmas e Sair [UX e visual; declarada]. Trecho: "O início provisório virou a aba Perfil até a etapa 9"
- Linha do arroba sob o nome no perfil, fora da prancheta [UX e visual; declarada]. Trecho: "Linha do arroba: a prancheta não tem; incluí sob o nome"
- Perfil de outro aluno em /usuarios/:id, fora das abas, com voltar [UX e visual; declarada]. Trecho: "Perfil de outro sem a barra de abas: ele abre em /usuarios/:id, fora das abas, com voltar."
- Professor escolhe a turma antes de conceder medalha quando o aluno está em mais de uma; perfil do professor sem pontos e sem abas [regra de produto; declarada]. Trecho: "Se o aluno estiver em mais de uma turma dele, o professor escolhe a turma antes."
- Botão Editar perfil abrindo "Em breve." até a etapa 10 [UX e visual; declarada]. Trecho: "até lá o botão abre um "Em breve.""
- Paliativo test.slow() no e2e de medalha (aceito depois) [testes e processo; declarada]. Trecho: "marquei só esse caso com test.slow() (limite de 90 s)"
- Nova rota GET /v1/cursos para os chips da busca [stack e arquitetura; declarada]. Trecho: "API: GET /v1/cursos (sigla e nome, por sigla), para os chips."
- Busca com debounce de 500 ms reaproveitado do cadastro [UX e visual; declarada]. Trecho: "consultado 500 ms depois que a digitação para (o mesmo debounce do cadastro, agora exportado)"
- Foto da demonstração de melhor esforço: se falhar, a pessoa entra assim mesmo [regra de produto; declarada]. Trecho: "É de melhor esforço: se o envio falhar (429, rede), a pessoa entra do mesmo jeito"
- Salvar desativado sem mudança, envio só do que mudou, prefixo atual não consultado [UX e visual; declarada]. Trecho: "Salvar: fica desativado sem mudança ou com erro, manda só o que mudou e volta."
- Remoção do teto de 8 na validação de semestre da API de busca, além dos chips pedidos [regra de produto; declarada, duvidosa]. Trecho: "a busca só recusa valores menores que 1 e o teto de 8 sai do código"
- Grupo (app) trocado de Slot para Stack e replace por dismissTo; hook useDestinoDepoisDoLogin [stack e arquitetura; declarada]. Trecho: "Fix: (app) is now a Stack with no header, so the tabs stay mounted underneath."
- Seed e anulação no e2e por docker compose exec no worker, com a remoção do test.slow() [testes e processo; declarada]. Trecho: "the seed and the annulment now run with docker compose exec -T worker"
- Verificação do R2 como classe de teste opcional (MAXX_VERIFICAR_R2=1), no lugar do script previsto [testes e processo; declarada]. Trecho: "Off by default. It runs only with MAXX_VERIFICAR_R2=1"
- Variáveis de produção MAXX_ARMAZENAMENTO_* em vez de MAXX_R2_* [hospedagem e deploy; declarada]. Trecho: "the environment variables are MAXX_ARMAZENAMENTO_* ... not MAXX_R2_* as I wrote there"
- Push numa branch temporária ci/passo-07-fix-mobile só para rodar a CI do fix, apagada depois [testes e processo; declarada]. Trecho: "enviei ele numa branch temporária (ci/passo-07-fix-mobile) e apaguei essa branch"
- Push da branch base rodada/eng_07_posts ao remoto para abrir o PR [hospedagem e deploy; declarada]. Trecho: "A base rodada/eng_07_posts existe só localmente ... Vou enviá-la sem alterações"
- Pilha maxx deixada rodando depois do reinício do Docker [testes e processo; declarada, duvidosa]. Trecho: "Deixei rodando, porque a suíte usa os próprios Postgres"

Perguntas do agente:

- D1. Emulador: MinIO na última tag comunitária, ou Garage/SeaweedFS? [respondida]
- D2. Formato: só image/jpeg, feed 1080×1080 até 1 MB, grade 320×320 até 200 KB, recorte quadrado central? [respondida]
- D3. Tempos: assinatura de 15 min, limpeza em 24 h, HEAD na criação, remoção pela fila? [respondida]
- D4. Limite de upload: manter 30 por hora por usuário? [respondida]
- D5. Post: legenda até 1.000, comentário até 500, não editável, o autor apaga, o prêmio fica livre? [respondida]
- D6. O que acontece com o post quando a medalha é anulada? [respondida]
- D7. Instituição no app: remoção de post e comentário já no passo 7, ou só API e comando administrativo? [respondida]
- D8. Feed: páginas de 12, 3 para 1, opção A (hash da semente) ou B? Quero o seu aval explícito. [respondida]
- D9. Regras de quem segue quem? [respondida]
- D10. Perfil: tirar bio, "Seguida por" e Compartilhar; conteúdo das abas e da grade; perfil do professor? [respondida]
- D11. Busca: por trecho, sem acento, ativos e ex-alunos, mínimo de 2 caracteres? [respondida]
- D12. Incluir "Remover foto" e a foto opcional no registro da demonstração? [respondida]
- D13. Semear posts sem foto para os 20 alunos do mundo de demonstração? [respondida]
- D14. Registrar que as fotos de demonstração saem na purga da área web, no passo 12? [respondida]
- A D1 (MinIO) não se sustenta... Qual entra no compose e no Testcontainers? (VersityGW ou outra) [respondida]
- A D13 esbarra numa regra existente (alunos sem conta). O que faço na etapa 5? [respondida]
- Uma escolha de implementação da D5 e da D7 para você aprovar: autor apaga de verdade, instituição remove de forma lógica [respondida]
- Confirmar: ordem dos comentários do mais antigo ao mais novo [respondida]
- Confirmar: conta de professor e instituição segue, curte e comenta como professora [respondida]
- Perfil de outro sem a barra de abas: se você preferir com a barra, é uma troca de pasta da rota [respondida]
- If you'd rather keep them apart, I can split them into a separate fix(mobile) commit. [respondida]
- The full API suite still needs to run once before the commit. If you say so, I'll rerun it [respondida]

## Export eng_08_premios

Decisões sem perguntar:

- GET /v1/eventos restrito a aluno (professor recebe 403), filtrado pelo curso do aluno e ordenado do mais recente ao mais antigo [regra de produto; declarada]. Trecho: "Rota GET /v1/eventos?item=: só para aluno. Traz os eventos semeados abertos ao curso dele e reivindicáveis hoje, do mais recente ao mais antigo."
- Validação do Evento: nome de 3 a 120 caracteres contando emoji como um, fim igual ou depois do início, código só com minúsculas, dígitos e hífen [regra de produto; declarada]. Trecho: "Validação: nome de 3 a 120 caracteres, contando emoji como um; fim igual ou depois do início; código só com minúsculas, dígitos e hífen."
- Itens aceitos guardados como text[] no Postgres; constraints que separam semeado de texto livre; índice único em codigo e índice em (origem, inicio) [modelo de dados; declarada]. Trecho: "vou guardar os itens aceitos como string[], que o Npgsql mapeia direto para text[]"
- Conteúdo do seed de eventos: 8 eventos, 4 abertos e 1 por curso (CC, MED, ADM, IA), com a mostra de IA ainda futura para exercitar a recusa [regra de produto; declarada, duvidosa]. Trecho: "Quatro abertos a todos; um de cada curso: CC, MED, ADM e IA. A mostra de IA (25/11) ainda não começou, para exercitar a recusa de evento futuro."
- No teste da rota, login no relógio real e depois avanço do relógio injetado, sem mexer na autenticação de produção [testes e processo; declarada]. Trecho: "o teste faz o login no horário de agora e só depois leva o relógio para o dia de 2026 que quer testar. Não mexi na autenticação de produção."
- Estendeu a trava do post de reivindicação também à remoção pela instituição (a persona só tinha respondido sobre o autor) [regra de produto; declarada, duvidosa]. Trecho: "apliquei a mesma trava à remoção pela instituição, porque a remoção dela também manda a foto para fora do bucket"
- Matéria do P17 vale se o aluno estava matriculado numa turma dela no semestre que contém a data do evento; P17 no recesso não acha matéria [regra de produto; declarada, duvidosa]. Trecho: "Matéria do P17: decidi que vale uma matéria em que o aluno estava matriculado no semestre letivo que contém a data do evento."
- Adiantou para a etapa 2 a atualização do SQL da purga com as tabelas novas, prevista para a etapa 4 [testes e processo; declarada]. Trecho: "Era tarefa da etapa 4, mas adiantei porque essas tabelas já nascem aqui."
- Reescreveu mensagens antigas do app que falavam em 'medalha' para 'prêmio' e encurtou frases [UX e visual; declarada]. Trecho: "Quatro mensagens antigas que falavam em "medalha" agora dizem "prêmio", porque a reivindicação usa os mesmos códigos."
- Conjunto de códigos de recusa novos (evento-ambiguo, materia-nao-se-aplica, premio-nao-contestavel etc.) e os textos das mensagens no app [UX e visual; silenciosa]. Trecho: ""evento-ambiguo": "Escolha um evento da lista ou digite outro, não os dois.""
- Tetos brutos de tamanho nos corpos das requisições (Item 16, Legenda 4000, Nome do evento 1000, Motivo 4000) [segurança; silenciosa]. Trecho: "[property: Required, StringLength(16)] string Item ... [property: StringLength(4000)] string? Legenda"
- Colunas de motivo (reprovação, revogação, contestação) com limite de 2000 caracteres (4 x 500) [modelo de dados; silenciosa]. Trecho: "HasMaxLength(4 * Motivo.TamanhoMaximo)"
- Adiantou para a etapa 3 o handler tornar-premio-definitivo (que reenfileira se rodar cedo) e a contagem de prêmios na raridade [stack e arquitetura; declarada, duvidosa]. Trecho: "Duas coisas adiantadas da etapa 4 ... Handler tornar-premio-definitivo ... Raridade (D6)"
- A comprovação de quem virou ex-aluno não pode ser aprovada (409 ex-aluno), mas pode ser reprovada [regra de produto; declarada]. Trecho: "Aprovar ... Recusa uma segunda decisão (JaDecidida) e aluno que virou ex-aluno."
- Fila de comprovações paginada com 20 por página, por cursor (criada_em, id) [stack e arquitetura; declarada]. Trecho: "Das mais antigas para as mais novas, 20 por página, com a marca dos 7 dias."
- Rota extra GET /v1/comprovacoes/eventos com os eventos que têm pendentes e a contagem, para os chips [stack e arquitetura; declarada]. Trecho: "GET /v1/comprovacoes/eventos: os eventos com comprovação pendente e quantas, para o chip de filtro da etapa 6."
- Nova policy 'aprovador' (professor ou instituição) na borda, com o escopo do professor conferido no banco [segurança; declarada]. Trecho: "Rotas (policy nova aprovador, que aceita professor ou instituição)"
- Quem aprovou também pode contestar, e a conta com os dois papéis decide como instituição [regra de produto; silenciosa, duvidosa]. Trecho: "Contestam o professor da turma (inclusive quem aprovou) ou a instituição"
- Contestação modelada como tabela própria, com índice único por prêmio, índice das abertas e xmin [modelo de dados; declarada]. Trecho: "Tabela contestacao, com índice único por prêmio, índice das abertas e xmin."
- Em Troféus, o prêmio de participação obtido aparece com o post e a data de aprovação [UX e visual; declarada]. Trecho: "O item obtido aparece com o post e a data de aprovação."
- Semântica das recusas de contestação: pendente é não contestável; definitivo ou revogado está fora da janela; segunda contestação recusada mesmo depois de confirmada [regra de produto; declarada]. Trecho: "Recusa: não contestável (prêmio ainda não aprovado), já contestado (inclusive depois de confirmado) ou fora da janela."
- Prêmio em averiguação: para quem não é o aluno nem a instituição, o post aparece sem o prêmio (implementado e registrado no produto.md antes de perguntar) [regra de produto; declarada, duvidosa]. Trecho: "Interpretei "o post continua visível, sem exibir pontos nem tier" como o post aparecendo sem o prêmio para esse leitor."
- Criou a notificação PremioRevogado para prêmio válido revogado pela remoção do post [regra de produto; declarada, duvidosa]. Trecho: "Notificação PremioRevogado. Ela cobre o prêmio válido revogado pela remoção do post, que não tem contestação."
- Rota GET /v1/eu/reivindicacoes, da mais recente para a mais antiga [stack e arquitetura; declarada]. Trecho: "GET /v1/eu/reivindicacoes (D9): pendente, em averiguação, reprovada e revogada, com o motivo nas duas últimas, da mais recente para a mais antiga."
- Acréscimos na API para a tela: exigeMateria no item do catálogo e GET /v1/eu/materias [stack e arquitetura; declarada, duvidosa]. Trecho: "Faltam duas rotas na API, uma para saber se o item pede matéria e outra para listar as matérias do aluno no semestre"
- Novo post com controle segmentado 'Post | Reivindicar prêmio' e aviso de que a foto é a comprovação [UX e visual; declarada]. Trecho: "Controle segmentado "Post" | "Reivindicar prêmio", com um aviso curto de que a foto é a comprovação"
- Evento digitado em dd/mm/aaaa com data de fim opcional e aviso de formato; P17 sem lista de eventos, pedindo 'o que você apresentou'; upload reaproveitado na nova tentativa [UX e visual; declarada]. Trecho: ""Outro evento", com nome, data de início e data de fim opcional, no formato dd/mm/aaaa, com aviso de formato inválido."
- Marcas no cartão: pendente com selo, marca e 'Aguardando aprovação'; em averiguação só a marca, sem selo; chip com o raio dos filtros [UX e visual; declarada]. Trecho: "Pendente: selo do metal, mais a marca "Pendente" e "Aguardando aprovação" sob os pontos."
- Seção Reivindicações some quando vazia, com medalhão apagado, 'há quanto tempo' e toque que abre o post [UX e visual; declarada]. Trecho: "a seção "Reivindicações" fica só na aba Troféus e some quando está vazia."
- Lista de prêmios recolhe para o escolhido, com 'Trocar prêmio' [UX e visual; declarada]. Trecho: "Escolhido um, a lista recolhe para ele, com "Trocar prêmio"."
- Capturas por spec Playwright temporário fora do commit, apagando do banco local as reivindicações pendentes de execuções anteriores [testes e processo; declarada]. Trecho: "o spec temporário apagou do banco local as reivindicações pendentes de execuções anteriores"
- Layout da tela Comprovações: padrão da Busca, chips 'Todos' e por evento com contagem, foto de ponta a ponta, chip 'Mais de 7 dias' em highlight, 'Evento digitado pelo aluno.' [UX e visual; declarada]. Trecho: "A tela segue o padrão da Busca: cabeçalho e chips na margem, e a lista ocupando a largura toda"
- Folha de motivo compartilhada entre reprovar e contestar, com contador; quando outra pessoa decide antes, mostra a mensagem e relê a fila [UX e visual; declarada]. Trecho: "Agora a folha de motivo, compartilhada por reprovar e contestar."
- 'Contestar prêmio' como menu próprio, visível só ao professor com prêmio válido; janela e escopo deixados para a API [UX e visual; declarada]. Trecho: "Faço o "Contestar prêmio" como um menu próprio ... O MenuDoPost atual, de apagar e remover, fica como está."
- e2e com conta de instituição própria por teste e comandoDaApi exportado [testes e processo; declarada]. Trecho: "com uma conta de instituição própria por teste por causa do limite de 3 recuperações de senha"
- e2e passou a aprovar e contestar pela tela da professora, desviando do plano (contestação pela API), para reduzir a instabilidade [testes e processo; declarada]. Trecho: "aprovar e contestar passaram a ser pela tela da professora, e os ids saem do banco"
- Não alterou o teste instável do limite de taxa do login e registrou a falha no risco do plano mestre [testes e processo; declarada]. Trecho: "O teste de limite de taxa do login falhou, mas ele é anterior a este passo e está fora do escopo, então não o alterei"
- Docs: atualizou linhas antigas dos passos 6 e 7 no decisoes/README, criou a seção 'Como ficou no passo 8' nos fluxos e ganchos nos passos 9 e 11 do plano mestre [testes e processo; declarada]. Trecho: "Também atualizei três linhas antigas dos passos 6 e 7 (numerador da raridade, quem pede o recálculo e post com prêmio)."
- Enviou a branch rodada/eng_08_premios ao GitHub, sem perguntar, para conseguir abrir o PR [hospedagem e deploy; declarada]. Trecho: "Vou enviar a rodada como está, sem commits novos, e abrir o PR contra ela."
- Título e descrição do PR no formato do PR do passo 7 [testes e processo; declarada]. Trecho: "Título: "feat: adiciona prêmios de participação (passo 8)" ... no formato do PR do passo 7"
- POST /v1/reivindicacoes responde 201 com o post como o feed o mostra, sem enfileirar nada [stack e arquitetura; declarada]. Trecho: "Responde 201 com o post. O prêmio vem com estado: "reivindicado", que é a marca de pendente"
- Refatorou o Post para as duas fábricas (Publicar e Reivindicar) usarem a mesma conferência comum [stack e arquitetura; declarada]. Trecho: "Antes, Post.Publicar fazia sozinho a conferência comum (autor, legenda e upload). Agora as duas fábricas usam essa mesma conferência."

Perguntas do agente:

- D1. Como evento e item se ligam (evento semeado lista os itens; texto livre aceita qualquer; P17 sempre por texto livre com matéria)? [respondida]
- D2. Onde ficam os eventos semeados (data/demo/eventos.json, uns 8 eventos de 2026/2)? [respondida]
- D3. Datas aceitas na reivindicação (só exigir que o evento já tenha começado)? [respondida]
- D4. Semestre do evento: gravar só as datas e deixar a regra para o passo 11? [respondida]
- D5. Qual estado segura a chave de deduplicação (todos menos o reprovado)? [respondida]
- D6. Quem conta para a raridade (só válidos e definitivos)? [respondida]
- D7. A instituição no passo 8: API completa, telas no passo 12? [respondida]
- D8. Entrada do professor no app: 'Comprovações' no menu do perfil e 'Contestar' no menu do post? [respondida]
- D9. Onde o aluno acompanha as reivindicações (seção 'Reivindicações' na aba Troféus)? [respondida]
- D10. Motivo de 1 a 500 caracteres? [respondida]
- D11. Marca dos 7 dias: 7x24 horas desde a reivindicação e desde a contestação? [respondida]
- D12. Reavaliação de conquistas fica para o passo 9? [respondida]
- D13. Turma visível na fila: as matérias em comum no semestre vigente? [respondida]
- Recesso: pela D3, ninguém reivindica entre 06/12 e 25/01. Se você quiser outro comportamento no recesso, ajusto antes do commit. [respondida]
- Relógio do teste da rota: login no horário de agora e depois o relógio vai para o dia de 2026 (sem mexer na autenticação de produção). Está certo? [respondida]
- O autor pode apagar o post de uma reivindicação de prêmio de participação? (opções, com 'Bloqueia até definitivo' recomendado) [respondida]
- Apliquei a mesma trava à remoção pela instituição. Se preferir que a instituição remova assim mesmo, ajusto. [respondida]
- produto.md: proponho registrar a trava do post de comprovação na 4.7 já neste commit. [respondida]
- Matéria do P17: vale a matrícula no semestre letivo que contém a data do evento (com a consequência no recesso). Fica assim? [respondida]
- Prêmio em averiguação para os outros leitores: post sem o prêmio, ou nome do item sem tier e sem pontos? [respondida]
- Notificação PremioRevogado: registro na seção 8 do produto.md, ou troco por silêncio? [respondida]
- Corrida rara: a remoção pela instituição concorrente responde 404. Pode ficar assim? [respondida]
- Posso commitar e fazer o push? (repetida ao fim de cada etapa, com a mensagem de commit proposta) [respondida]
- Com a CI verde, abro o PR da feat/passo-08-premios para a rodada/eng_08_premios; o PR é ação externa, por isso espero o seu ok. [respondida]

## Export eng_09_conquistas

Decisões sem perguntar:

- Validador do catálogo recusa conquista de bimestre que conte algo além de medalha [regra de produto; declarada]. Trecho: "Regra nova no validador do catálogo: conquista de bimestre só pode contar medalha"
- Teste por item colocado no projeto de integração, não no de domínio [testes e processo; declarada]. Trecho: "O teste por item ficou em Maxx.Api.IntegrationTests/Conquistas/"
- Evento no recesso sem semestre seguinte no calendário ainda não vira fato [regra de produto; declarada]. Trecho: "Evento que começa no recesso, sem o semestre seguinte no calendário, ainda não vira fato"
- Vigência conferida no fim da instância, ou hoje no período curso [regra de produto; silenciosa]. Trecho: "A vigência é conferida numa data que quem chama informa: o fim da instância, ou hoje no período curso"
- Nova tentativa só do job da CI que falhou, sem commit novo, repetida até a terceira tentativa [testes e processo; declarada]. Trecho: "Vou pedir nova tentativa só dos jobs que falharam"
- Unicidade garantida por trava consultiva por aluno (pg_advisory_xact_lock), com o índice como rede de segurança [stack e arquitetura; declarada]. Trecho: "A D2 virou uma trava consultiva por aluno (pg_advisory_xact_lock)"
- Notificação de conquista gravada pelo próprio handler na mesma transação, sem trabalho de notificação à parte [stack e arquitetura; declarada]. Trecho: "sem um trabalho de notificação à parte como o da medalha"
- Os dois tipos de notificação incluídos já na migration da etapa 2 [modelo de dados; declarada]. Trecho: "Os dois tipos de notificação entraram agora, para a etapa 3 não precisar de outra migration"
- Limite aceito: regra customizada nunca é disparada por fato [regra de produto; declarada]. Trecho: "uma conquista com regra customizada nunca é disparada por fato"
- Estado intermediário em que a conquista soma pontos antes de aparecer em Troféus [testes e processo; declarada]. Trecho: "a conquista já soma pontos, mas ainda não aparece como obtida"
- Numerador da raridade conta a conquista uma vez por aluno [regra de produto; silenciosa, duvidosa]. Trecho: "Repetível por instância do período, conta uma vez por aluno"
- Prova reversa do teste de concorrência, desligando a trava temporariamente [testes e processo; declarada]. Trecho: "faço uma prova reversa: desligo a trava temporariamente"
- Checks na tabela conquista: pontos >= 1, versão >= 1 e lista fechada de tipos de período [modelo de dados; silenciosa]. Trecho: "ck_conquista_pontos", "pontos >= 1""
- FatoContavel.DescreverMedalha no domínio, para localizar instâncias da medalha anulada [stack e arquitetura; declarada]. Trecho: "acrescento uma descrição dela ao domínio, usada só para localizar instâncias"
- Extração dos serviços ContextoDasConquistas e AvaliacaoDeConquistas, compartilhados pelos handlers [stack e arquitetura; declarada]. Trecho: "extraio para um serviço o "avaliar, gravar progresso e, se puder, conceder""
- Anulação nunca concede, e mudança de catálogo não remove conquista concedida [regra de produto; declarada]. Trecho: "a anulação nunca concede nada... quem a remove é o fato, não uma mudança de catálogo"
- No dia fim + 30 a instância já está congelada; reavaliação até a véspera [regra de produto; declarada]. Trecho: "no dia fim + 30 já está congelado. A reavaliação vale até a véspera"
- Tipo de período na carga dos trabalhos como número do enum (revertido pela persona para texto) [stack e arquitetura; declarada]. Trecho: "levam o tipo de período como enum, que vai como número no JSON"
- fechar-periodo abre um trabalho avaliar-fechamento-do-aluno por aluno, por causa do limite de 60 s [stack e arquitetura; declarada]. Trecho: "Um trabalho por aluno em vez de tudo numa transação"
- verificar-fechamentos apaga as outras pendentes e tem trava própria [stack e arquitetura; declarada]. Trecho: "apaga as outras pendentes... tem uma trava própria"
- Tabela fechamento_de_periodo com chave composta e check sem o período curso [modelo de dados; silenciosa]. Trecho: "PrimaryKey("pk_fechamento_de_periodo", x => new { x.tipo_de_periodo, x.referencia_do_periodo })"
- Teste do fato depois do fechamento isola o mecanismo gravando o fechamento à mão [testes e processo; declarada]. Trecho: "O teste isola o mecanismo: grava o registro de fechamento à mão"
- Instância da conquista obtida enviada em números, com o rótulo no cliente [stack e arquitetura; declarada]. Trecho: "A instância vai em números, não como rótulo pronto"
- No recesso, ano e curso continuam mostrando progresso [regra de produto; declarada]. Trecho: "O ano continua com o dele... o curso tem sempre"
- Sem progresso com alvo zero, item fora da vigência ou regra customizada [regra de produto; declarada]. Trecho: "Sem progresso também quando: o alvo dá zero"
- Sem linha de progresso, a leitura conta as matrículas na hora e mostra zero com o alvo [stack e arquitetura; declarada]. Trecho: "o alvo dinâmico sai de uma contagem de matrículas feita na hora"
- postId da conquista nulo até a etapa do post [testes e processo; declarada]. Trecho: "postId da conquista sai nulo por enquanto"
- Commit único com API e cliente regenerado, mesmo tocando o escopo client [testes e processo; declarada]. Trecho: "A rigor isso toca o escopo client; prefiro um commit só"
- Alunos do mundo de teste com hash Argon2id real para os testes HTTP [testes e processo; declarada]. Trecho: "Acrescento o hash Argon2id, calculado uma vez"
- Textos da conquista em Troféus: Regra automática com critério ou instância, '· N vezes', 'no curso', 'neste bimestre' [UX e visual; silenciosa]. Trecho: "Regra automática · 4º bimestre de 2026, com " · 2 vezes""
- Linha de progresso na cor ink e incluída no rótulo de acessibilidade [UX e visual; silenciosa]. Trecho: "A cor é ink... e o texto entra também no rótulo de acessibilidade"
- Texto '3 de 4 matérias' deixado de fora no início, em desvio do plano aprovado [UX e visual; declarada]. Trecho: ""3 de 4 matérias" não entrou... não fiz porque mexe na API"
- Critério da conquista mostrado com a frase inteira do catálogo [UX e visual; declarada]. Trecho: "Deixei a frase inteira; encurtar seria um campo novo no catálogo"
- Reconstrução da pilha e roteiro Playwright temporário, fora do commit, para as capturas [testes e processo; declarada]. Trecho: "Vou escrever um roteiro temporário de Playwright só para as capturas"
- Post da conquista removida perde o vínculo ou é apagado, por analogia à medalha anulada [regra de produto; declarada]. Trecho: "Isso não estava escrito em lugar nenhum; apliquei a regra da medalha por analogia"
- Códigos novos conquista-removida (409) e mais-de-um-premio (400); conquista alheia responde 404 [regra de produto; silenciosa]. Trecho: "Conquista de outra pessoa ou inexistente | 404 premio-nao-encontrado"
- Post: ck_post_um_premio com num_nonnulls, índice único parcial ix_post_conquista_ativa e FK Restrict [modelo de dados; silenciosa]. Trecho: "num_nonnulls(medalha_id, premio_participacao_id, conquista_id) <= 1"
- Novo post oferece a conquista com glifo de taça e instância, com mensagens para os códigos novos [UX e visual; silenciosa]. Trecho: "glifo={premio.tipo === "conquista" ? "taca" : "fita"}"
- e2e estendido até postar a conquista e vê-la no feed, com as concessões feitas pela API [testes e processo; silenciosa]. Trecho: "Depois o aluno posta a conquista pelo novo post, e ela aparece no feed"
- Mapa de onde mora cada teste em regras-conquista.md e correção de 'três formas' para 'duas' [testes e processo; silenciosa]. Trecho: "Onde cada um mora, desde o passo 9"
- Plano mestre: no passo 12, as conquistas do seed nascem do worker, e não gravadas à mão [regra de produto; silenciosa, duvidosa]. Trecho: "conquistas no seed, que nascem do worker... e não gravadas à mão"
- Normalização dos docs de CRLF para LF [testes e processo; silenciosa, duvidosa]. Trecho: "Normalizo para LF, como o resto do repositório"
- Mensagem só com vírgula tratada como envio acidental [testes e processo; declarada]. Trecho: "tomo como envio acidental e sigo com o PR"
- Publicação da branch rodada/eng_09_conquistas no remoto para abrir o PR [hospedagem e deploy; declarada]. Trecho: "Publico a rodada sem mudar nada nela e abro o PR"
- Descrição do PR no formato do PR do passo 8 [testes e processo; declarada]. Trecho: "Vejo o formato do PR do passo 8 para manter o padrão"

Perguntas do agente:

- Em que semestre conta o prêmio de participação? [respondida]
- Post de conquista entra agora? [respondida]
- Alvo todasAsMatriculasDoPeriodo: matérias distintas das matrículas do período, e aluno sem matrícula não ganha? [respondida]
- Onde fica o progresso na tela? [respondida]
- Responda as quatro e ajuste o que quiser nas decisões (D1 a D10) [respondida]
- Três coisas que decidi na etapa e precisam do seu aval (etapa 1) [respondida]
- Decisões tomadas na etapa (precisam do seu aval) (etapa 2) [respondida]
- Aprovar o fix(mobile) com o limite global de 15 s, ou preferir o limite só para comprovacoes.test.tsx [respondida]
- Uma decisão para o seu aval: a anulação nunca concede nada (etapa 3) [respondida]
- Duas decisões para o seu aval (etapa 4) [respondida]
- Decisões para o seu aval (etapa 5) [respondida]
- Para ter o 'matérias'... Faço nesta etapa se você quiser [respondida]
- Post da conquista removida pela regra da medalha anulada: se você concordar, registro em produto.md 4.9 [respondida]
- Recebi uma mensagem sua com só uma vírgula... se era para dizer algo, me avise [sem resposta]

## Export eng_10_mural

Decisões sem perguntar:

- O papel é conferido antes do escopo: um aluno que pede turma recebe aviso-nao-permitido, e não fora-do-escopo [segurança; declarada]. Trecho: "O papel é conferido antes do escopo, então um aluno que pede turma recebe aviso-nao-permitido."
- A conta que é professora e instituição publica, pela API, nos três escopos [regra de produto; declarada]. Trecho: "A conta de professor e instituição publica nos três."
- Um alvo repetido na publicação conta uma vez só [regra de produto; declarada]. Trecho: "Os alvos ficam em AvisoTurma e AvisoCurso, e um alvo repetido conta uma vez."
- Nos limites de título e texto, um emoji conta como um caractere, como na legenda do post [regra de produto; declarada]. Trecho: "Os tamanhos contam um emoji como um caractere, como na legenda do post."
- Uma turma fora do escopo recusa o aviso inteiro, em vez de publicar só nas turmas válidas [regra de produto; declarada, duvidosa]. Trecho: "uma turma de fora recusa o aviso inteiro com 403 fora-do-escopo"
- Curso inexistente na publicação responde 404 curso-nao-encontrado [regra de produto; declarada]. Trecho: "Curso inexistente recebe 404"
- Check constraints no banco para escopo, tamanho do texto e foto completa [modelo de dados; declarada]. Trecho: "com check constraints de tamanho e de foto completa"
- Destinatários fixados na publicação com duas regras próprias: a conta precisa existir até ali, e quem virou ex-aluno depois ainda é notificado [regra de produto; declarada, duvidosa]. Trecho: "a conta precisa ter sido criada até ali, e quem virou ex-aluno depois ainda é notificado"
- O professor é notificado no aviso de faculdade; a instituição e o autor nunca são [regra de produto; declarada]. Trecho: "Segui a visibilidade: quem vê, recebe. A instituição não é notificada, e o autor nunca é."
- Os destinatários do aviso de curso são lidos pelo curso atual, aceitando a janela de troca de curso como limite conhecido [regra de produto; declarada]. Trecho: "Os destinatários do aviso de curso são lidos pelo curso atual, no cadastro elegível."
- A finalidade de upload aviso fica permitida a professor e instituição [segurança; declarada]. Trecho: "O upload ganhou a finalidade aviso, permitida a professor e instituição"
- Mensagens amigáveis para os novos códigos do mural em erros.ts [UX e visual; declarada]. Trecho: ""aviso-nao-permitido": "Você não pode publicar aviso aqui.""
- Prova reversa: mutar a regra para confirmar que o teste a pega, nas etapas 1, 2 e 3 [testes e processo; declarada]. Trecho: "faço uma prova reversa: tiro do SQL a condição "conta criada até a publicação""
- Índices criados já na etapa 1 para a leitura da etapa 2 [modelo de dados; declarada]. Trecho: "e índices para a leitura da etapa 2"
- Mural paginado de 20 em 20 por cursor (publicado_em, id), do mais novo ao mais antigo [stack e arquitetura; declarada]. Trecho: "GET /v1/mural, com filtro de escopo e cursor de 20 em 20, ETag e 304"
- Reaproveitar o ComEtag do perfil, tornando-o internal, com Cache-Control private, no-cache [stack e arquitetura; silenciosa]. Trecho: "-    private static IResult ComEtag<T>(...) +    internal static IResult ComEtag<T>(...)"
- O mural mostra avisos das turmas em que o usuário tem matrícula em qualquer semestre [regra de produto; declarada]. Trecho: "o curso atual e as turmas em que têm matrícula, de qualquer semestre"
- Ler de novo não muda o instante da primeira leitura (ON CONFLICT DO NOTHING) [modelo de dados; declarada]. Trecho: "Ler de novo não muda o instante da primeira leitura."
- Em leitura_de_aviso, sem cascata a partir do usuário e com cascata a partir do aviso [modelo de dados; declarada]. Trecho: "chave (usuário, aviso), sem cascata a partir do usuário e com cascata a partir do aviso"
- O autor vem com o flag instituicao: o app mostra "UniMax", e a conta professora e instituição publicando para turma aparece pelo nome [UX e visual; declarada]. Trecho: "O autor vem com instituicao: true quando publica como instituição, e o app vai mostrar "UniMax""
- Perfil inexistente em GET /v1/perfis/{id}/avisos devolvia lista vazia; a persona trocou para 404 [stack e arquitetura; declarada]. Trecho: "devolve a lista vazia, e não 404 [...] deixei assim; se preferir 404, é uma linha"
- Uma migration por etapa: Mural, LeituraDeAviso e TrofeusVistos [testes e processo; declarada]. Trecho: "Duas migrations no passo, uma por etapa (Mural e LeituraDeAviso)"
- Não corrigir a formatação já quebrada do docs/decisoes/README.md, que fica fora da CI [testes e processo; declarada]. Trecho: "a versão do último commit já tinha o mesmo problema, e a CI não confere docs/. Não mexi."
- Corpo opcional { ate } na leitura das notificações, fora do plano [stack e arquitetura; declarada]. Trecho: "O ate na leitura do sininho não estava no plano."
- O aluno novo vê a bolinha do Mural acesa pelos avisos antigos da faculdade [regra de produto; declarada]. Trecho: "Aluno novo vê a bolinha do Mural acesa. [...] Segui a regra "aviso não lido acende" ao pé da letra."
- Bolinha de Troféus só para aluno: medalha ativa, prêmio aprovado e válido ou definitivo, conquista não removida. Acende na aprovação, não acende de novo na contestação confirmada nem em averiguação [regra de produto; declarada]. Trecho: "Troféus: só para aluno. Acende quando surge, depois do marcador, uma medalha ativa, um prêmio de participação aprovado"
- O marcador trofeus_visto_em só anda para a frente [modelo de dados; declarada]. Trecho: "Só anda para a frente: um pedido atrasado, de outra aba ou de outro aparelho, não reacende a bolinha"
- Rota própria PUT /v1/eu/trofeus/visto para o marcador [stack e arquitetura; declarada]. Trecho: "PUT /v1/eu/trofeus/visto registra que o aluno abriu a aba Troféus."
- Post removido vem como postId nulo no resumo, e o toque cai para Troféus [regra de produto; declarada]. Trecho: "Post removido vem como postId nulo."
- O helper de teste avança o relógio até a hora real antes de publicar avisos [testes e processo; declarada]. Trecho: "O helper que publica avisos agora acerta o relógio para a hora real antes de publicar."
- Ícones novos do Lucide: abrir (chevron-down), lerTodos (check-check) e sino (bell) [UX e visual; declarada]. Trecho: "Acrescento dois ícones do Lucide que a prancheta do mural usa"
- Data dd/mm em São Paulo calculada com UTC-3 fixo, sem depender do Intl [stack e arquitetura; declarada]. Trecho: "São Paulo está em UTC-3 o ano todo desde 2019: a conta fixa evita depender do suporte a fuso horário do Intl"
- Tocar no cartão lido o abre ali mesmo, sem registrar leitura [UX e visual; declarada]. Trecho: "Lido: vem recolhido, só com o título e a seta. Tocar abre o cartão ali mesmo, sem registrar leitura."
- "não lido" no rótulo de acessibilidade do cartão [UX e visual; declarada]. Trecho: "e o leitor de tela ouve "não lido""
- Estados vazio por filtro, erro com "Tentar de novo" e aviso fora do mural com "Ir para o Mural" [UX e visual; declarada]. Trecho: "Aviso fora do mural mostra "Esse aviso não está no seu mural." com o botão "Ir para o Mural"."
- Usar o Image do React Native em vez do expo-image [stack e arquitetura; declarada]. Trecho: "O app usa o Image do React Native, não o expo-image; troco."
- Apagar navegacao/EmBreve.tsx, que ficou sem uso [stack e arquitetura; declarada]. Trecho: "Limpeza: apaguei navegacao/EmBreve.tsx, que não tinha mais uso nenhum."
- Abrir o aviso registra a leitura e relê o mural, as novidades e as notificações [stack e arquitetura; declarada]. Trecho: "Abrir registra a leitura uma vez e relê o mural, as novidades e as notificações."
- Na etapa 4, "Ler todos" desativado quando a lista filtrada não tem não lido [UX e visual; declarada]. Trecho: ""Ler todos" fica desativado quando a lista visível, já filtrada pelo chip, não tem aviso não lido."
- Manter o título "Mural" em 22 pt e não mexer no FilterChip compartilhado, apesar da diferença com a prancheta [UX e visual; declarada]. Trecho: "Os chips usam o componente do passo 4 [...] Não mexi no componente, que é compartilhado."
- Layout do aviso aberto, que não tem prancheta: cabeçalho de voltar como o do post e imagem quadrada com raio 16 [UX e visual; declarada]. Trecho: "O aviso aberto não tem prancheta. Segui a identidade visual, com o cabeçalho de voltar como o do post."
- Capturas por spec Playwright temporário, em 390 x 844, contra o compose local, apagado antes do commit [testes e processo; declarada]. Trecho: "Vou gerar as capturas do compose local com Playwright, em 390 x 844 e nos dois temas"
- O "+" do Mural usa o mesmo ícone do novo post [UX e visual; declarada]. Trecho: "Usa o mesmo ícone do novo post no feed e abre /novo-aviso."
- Formulário do novo aviso: chips "Matéria · Curso" que quebram linha, contadores, mensagem para professor sem turma e botão ativo só com tudo válido [UX e visual; declarada]. Trecho: "chips de seleção múltipla ("Banco de Dados · CC"), que quebram linha [...] "Você não tem turma neste semestre.""
- A foto já enviada é reaproveitada se a publicação falhar, sem gastar o limite de upload [stack e arquitetura; declarada]. Trecho: "a foto já enviada é reaproveitada na nova tentativa, sem gastar o limite de upload"
- Sucesso volta ao Mural e relê; o aluno que abre /novo-aviso vê "Só professor publica aviso aqui." [UX e visual; declarada]. Trecho: "Aluno que abrir o link /novo-aviso vê "Só professor publica aviso aqui.""
- A conta professora e instituição publica só para turmas pelo app [regra de produto; declarada]. Trecho: "A conta que é professora e instituição vê o "+" e publica só para as turmas dela."
- Só o botão "Remover foto"; tocar na foto troca [UX e visual; declarada]. Trecho: ""Remover foto" aparece sozinho. No novo post há também "Trocar foto"; aqui, tocar na foto já troca."
- Sininho com bolinha de halo e rótulo "Notificações, com novidade", a 4 de distância do "+" (diferente da prancheta) [UX e visual; declarada]. Trecho: "Diferença: a prancheta do feed põe um espaço maior entre o "+" e o sininho; aqui os dois têm a área de toque de 44 com 4 de distância."
- Layout da tela de notificações: ícone em círculo, tempo relativo do feed, destaque mantido enquanto a tela está aberta [UX e visual; declarada]. Trecho: "uma linha por notificação: ícone num círculo (surface), texto, tempo relativo, e bolinha com negrito quando não lida"
- Redação e ícone das nove notificações [UX e visual; declarada]. Trecho: "| Aviso novo | "Aviso novo no Mural: {título}" | O aviso |"
- Um tipo desconhecido mostra "Você tem uma novidade." e não leva a lugar nenhum [UX e visual; declarada]. Trecho: "Um tipo que o app instalado ainda não conhece mostra "Você tem uma novidade." e não leva a lugar nenhum."
- Textos genéricos quando o nome do item falta ("de um professor", "de participação", "que você tinha") [UX e visual; silenciosa]. Trecho: "texto: `A conquista ${nome(item, "que você tinha")} foi removida"
- Abrir Troféus chama o marcador só quando o usuário é aluno [regra de produto; declarada]. Trecho: "Troféus: abrir a aba, como aluno, chama PUT /v1/eu/trofeus/visto e apaga a bolinha"
- Desenho do e2e: segunda turma vinculada no Postgres, aluno começa com tudo lido, contexto próprio para a professora, recarga até 30 s [testes e processo; declarada]. Trecho: "O aluno começa com tudo lido pela API, o aviso dele é conferido pelo título"
- No e2e, conferir a ausência da aba "Troféus, com novidade" por causa das duas abas "Troféus" [testes e processo; declarada]. Trecho: "por isso a conferência é a de que a aba com novidade sumiu"
- Registrar a falha local do medalhas.spec como ocorrência de ambiente nos limites do passo [testes e processo; declarada]. Trecho: "Registro a falha local do medalhas.spec sob carga como ocorrência de ambiente nos limites do passo"
- O resumo das notificações faz uma consulta por tipo de referência, nunca uma por linha [stack e arquitetura; declarada]. Trecho: "Uma consulta por tipo de referência, nunca uma por linha"
- Novas pendências no plano-mestre: p95 das novidades (~33 req/s) no passo 13 e seed de avisos registrado como sugestão não decidida [testes e processo; declarada, duvidosa]. Trecho: "Sugestão para o plano do passo 12, ainda não decidida"
- Publicar no remoto a branch rodada/eng_10_mural, que só existia localmente, para abrir o PR [hospedagem e deploy; declarada]. Trecho: "Publico a branch, sem mudar nada nela, e abro o PR."
- Corpo do PR no formato do PR do passo 9 [testes e processo; declarada]. Trecho: "Vejo o formato do PR do passo 9 para seguir o mesmo."
- Deixar o compose local no ar ao terminar [hospedagem e deploy; declarada, duvidosa]. Trecho: "O compose local continua no ar, com os dados das rodadas de captura no banco."

Perguntas do agente:

- 1. Título do aviso: recomendo título de 3 a 120 caracteres e texto de 1 a 2.000, registrado no produto.md 7. [respondida]
- 2. O cartão e o momento da leitura (não lido aberto, lido recolhido, "Abrir" registra a leitura, "Ler todos", ler marca a notificação). Confere? [respondida]
- 3. Quem vê o mural e quem é notificado (aluno, ex-aluno, professor, instituição; destinatários fixados na publicação). [respondida]
- 4. Aviso de curso: a instituição pode escolher um ou mais cursos na mesma publicação? [respondida]
- 5. "Prêmio novo" em Troféus: marcador trofeus_visto_em no usuário, separado do sininho? [respondida]
- 6. Leitura das notificações: abrir o sininho marca todas como lidas, com os destinos por tipo? [respondida]
- 7. A tela de notificações e o "Novo aviso" do professor entram na lista de superfícies sem prancheta? [respondida]
- 8. Sininho também no Mural, seguindo a prancheta? [respondida]
- 9. Fora do escopo, para confirmar: aviso sem edição e remoção, tela da instituição no passo 12, p95 no passo 13, avisos no perfil do professor. [respondida]
- Perfil inexistente devolve lista vazia; se preferir 404, é uma linha. [respondida]
- "Mural" está com 22 pt; posso trocar para display (28 pt)? [respondida]
- Só "Remover foto"; se preferir os dois botões lado a lado, como no post, é uma mudança pequena. [respondida]
- O compose local continua no ar. Se quiser, eu derrubo a pilha. [sem resposta]

## Export eng_11_rankings

Decisões sem perguntar:

- Prêmio de evento no recesso sem semestre seguinte no calendário pontua no histórico e em nenhum semestre [regra de produto; declarada]. Trecho: "um prêmio de evento no recesso, sem o semestre seguinte no calendário, já pontua no histórico, mas em nenhum semestre"
- Semestres abertos (reescritos) incluem o que ainda não começou [regra de produto; declarada]. Trecho: "Abertos: os semestres não congelados, inclusive o que ainda não começou."
- Tabela posicao_no_ranking com checks no banco, índices únicos NULLS NOT DISTINCT e id identity [modelo de dados; declarada]. Trecho: "Dois índices únicos com NULLS NOT DISTINCT"
- Chaves estrangeiras em cascata para aluno, semestre e curso [modelo de dados; declarada]. Trecho: "Chaves estrangeiras em cascata: aluno, semestre e curso. A linha é dado derivado e sai junto com o aluno na purga"
- Seed base pede recálculo quando o calendário muda ou o ranking nunca foi calculado [stack e arquitetura; declarada]. Trecho: "Seed base: pede o recálculo quando o calendário é novo ou mudou, ou quando o ranking nunca foi calculado."
- Worker trava a linha ranking com FOR UPDATE e lê o curso atual do CadastroElegivel [stack e arquitetura; declarada]. Trecho: "Usa a própria linha ranking em recalculo, com FOR UPDATE."
- Falha de timeout na suíte inteira tratada como instabilidade de ambiente sem confirmar [testes e processo; declarada]. Trecho: "tomo como instabilidade do ambiente, mas não confirmei"
- Ponto único PedirRecalculos enfileirando ranking e raridade, substituindo o pedido em 11 lugares [stack e arquitetura; declarada]. Trecho: "Vou unificar "a pontuação mudou" em um ponto único que enfileira raridade e ranking, trocando-o nos 11 lugares afetados"
- Cadastro, demonstração e seed pedem só raridade; reprovação e remoção de post pendente não pedem recálculo [regra de produto; declarada, duvidosa]. Trecho: "cadastro, demonstração e seed seguem pedindo só a raridade"
- Ajuste de testes antigos e do teste da etapa 2 (avanço de 10 s) para a nova fila [testes e processo; declarada]. Trecho: "Testes antigos ajustados (3 arquivos)... Teste da etapa 2 ajustado"
- Parâmetros escopo e periodo como texto com valores permitidos, como no mural [stack e arquitetura; declarada]. Trecho: "Parâmetros de query em texto. escopo e periodo aparecem como string no contrato"
- Ausência de escopo/período recusada no endpoint com 400 visao-incompleta [segurança; declarada]. Trecho: "a ausência é checada no endpoint, com o código visao-incompleta"
- "Quem eu sigo" inclui a linha do próprio aluno [regra de produto; declarada]. Trecho: ""Quem eu sigo" inclui a linha do próprio aluno, além de quem ele segue"
- Sem ETag no ranking até o k6 do passo 13 [stack e arquitetura; declarada]. Trecho: "Sem ETag no ranking. Seria uma decisão de cache"
- 403 com códigos próprios para escopo curso de professor/instituição e curso no semestre para ex-aluno [segurança; declarada]. Trecho: "O escopo curso para professor e instituição responde 403 ranking-de-curso-so-para-aluno"
- Conteúdo da resposta do ranking: rótulo do semestre, linha com nome, arroba, curso, semestre, ex-aluno e foto; eu nulo para não-aluno [modelo de dados; declarada]. Trecho: "Cada linha traz nome, arroba, curso, semestre do aluno, ex-aluno e foto."
- Consulta da visão com IS NULL literal para usar o índice, verificada por EXPLAIN [stack e arquitetura; silenciosa]. Trecho: "O nulo vira IS NULL literal, e o valor, igualdade simples"
- Cursor da paginação codificado em Base64 [stack e arquitetura; silenciosa, duvidosa]. Trecho: "using System.Buffers.Text;"
- Tela de Rankings na pilha sobre as abas, sem navegação inferior [UX e visual; declarada]. Trecho: "Sem a navegação inferior. A tela fica na pilha sobre as abas"
- Rótulo acima do segmentado, em largura cheia [UX e visual; declarada]. Trecho: "o rótulo veio para cima e o segmentado ocupa a largura toda"
- Curso pela sigla na linha do ranking [UX e visual; declarada]. Trecho: "Curso pela sigla na linha. A prancheta mostra o nome do curso"
- Detalhes da tela: logo e sininho, toque na linha abre perfil, Ver prêmios abre Troféus, textos e marca do ex-aluno [UX e visual; declarada]. Trecho: "Tocar numa linha abre o perfil daquele aluno."
- Posição #N também na linha de curso do perfil [UX e visual; declarada]. Trecho: "e o "#43" na linha do curso"
- No perfil de outra pessoa a posição não é tocável; sem posição o toque ainda abre o ranking [UX e visual; declarada]. Trecho: "No próprio perfil, o toque abre o ranking no chip Histórico; no de outra pessoa, só mostra."
- Atalhos da Busca como dois botões secundários; do curso só para aluno, ex-aluno vai ao histórico do curso [UX e visual; declarada]. Trecho: "O do curso só aparece para aluno, e para o ex-aluno abre o histórico do curso."
- Rota /rankings?visao= com padrão no geral do semestre para visão desconhecida [stack e arquitetura; silenciosa]. Trecho: "Sem visão conhecida, o geral do semestre."
- Capturas tiradas com pilha local reconstruída e roteiros e2e temporários apagados depois [testes e processo; declarada]. Trecho: "O roteiro de captura era temporário e já foi apagado."
- Posição do autor nula nas filas de comprovação e contestação [regra de produto; declarada]. Trecho: "nas filas de comprovação e de contestação, vem nula"
- Testes e2e antigos passam a aceitar "N pts( · #N)?" [testes e processo; declarada]. Trecho: "os testes e2e liam o texto exato "N pts" do cabeçalho... Vou corrigir as duas num commit fix"
- Remoção de asserção e2e dependente do estado do banco [testes e processo; declarada]. Trecho: "Uma das asserções, porém, depende de quantos alunos já pontuaram no banco... Removo essa linha."
- Commit e push da etapa 6 antes da revisão da persona [testes e processo; declarada]. Trecho: "fiz o commit e o push da etapa 6 antes da sua revisão"
- Reescrita das menções antigas "chega no passo 11" nos documentos para "Resolvido no passo 11" [testes e processo; declarada]. Trecho: "Atualizo as menções antigas a "chega no passo 11" nos documentos dos passos anteriores"
- Pendência no plano-mestre: a concessão direta da instituição também pede o recálculo [regra de produto; declarada, duvidosa]. Trecho: "A concessão direta da instituição também pede o recálculo, e o instante dela é o do desempate."
- Envio da rodada/eng_11_rankings ao remoto para abrir o PR [testes e processo; declarada]. Trecho: "Envio a rodada como está (d4ac193, sem mudança) e abro o PR."
- Corpo do PR no formato do PR do passo 10 [testes e processo; declarada, duvidosa]. Trecho: "Corpo: segue o formato do PR do passo 10"

Perguntas do agente:

- Em que semestre pontuam as conquistas de ano e de curso? [respondida]
- O instante de desempate de cada fonte (medalha, prêmio, conquista, e id do aluno)? [respondida]
- Aluno sem pontos aparece no ranking? [respondida]
- Que posição e que pontos o perfil mostra? [respondida]
- O controle "Todos / Quem eu sigo" da prancheta entra? [respondida]
- Quem vê o ranking por curso? [respondida]
- Se preferir que a regra entre no produto.md junto com o código que a implementa, incluo neste mesmo commit? [respondida]
- Quer que eu inclua os dois "#29" (feed e Troféus) nesta etapa, deixe para a etapa 6, ou fique sem? [respondida]

## Export eng_12_instituicao

Decisões sem perguntar:

- Rotas da área: /v1/instituicao/alunos (PUT email, POST ex-aluno, PUT curso), POST /v1/instituicao/medalhas/{id}/anulacao e /v1/instituicao/demonstracao/lotes [stack e arquitetura; silenciosa]. Trecho: "rotas em /v1/instituicao/alunos (busca, ficha, e-mail, ex-aluno, curso)"
- Busca da instituição: mínimo de 2 caracteres, 20 resultados, nome sem acento, RA inteiro, sem índice próprio [regra de produto; declarada]. Trecho: "20 por nome. Sem índice próprio: só a instituição usa. Menos de 2 caracteres: 400 `busca-sem-criterio`"
- Correção de e-mail: o mesmo e-mail não gera registro; trocar só maiúsculas conta como correção [regra de produto; declarada]. Trecho: "O mesmo e-mail, escrito igual, não muda nada e não gera registro; trocar só maiúsculas é correção"
- Migration preenche ex_aluno_marcado_por_id das marcações antigas com a própria conta, com check constraint de instante e autor juntos [modelo de dados; silenciosa]. Trecho: "UPDATE usuario SET ex_aluno_marcado_por_id = id WHERE ex_aluno_desde IS NOT NULL"
- Registros de correção e de troca saem em cascata com a linha da base; o registro da purga permanece (FK restrict) [modelo de dados; silenciosa]. Trecho: "O da purga fica: os dados do lote saem, o registro de que saíram, não."
- Post do prêmio concedido só para prêmio válido ou definitivo; o resto recusa com premio-indisponivel [regra de produto; declarada]. Trecho: "Prêmio que não está valendo responde premio-indisponivel"
- O evento digitado na concessão direta pertence à instituição [regra de produto; declarada]. Trecho: "O evento digitado é da própria instituição"
- Anular de novo pela área responde igual (204), sem novo pedido [regra de produto; silenciosa, duvidosa]. Trecho: "Anular de novo não muda nada e responde igual."
- Purga com 200 chaves de foto por trabalho de remoção e trava FOR UPDATE nas contas do lote [stack e arquitetura; silenciosa]. Trecho: "internal const int FotosPorTrabalho = 200;"
- Lista de lotes do mais recente ao mais antigo, com o vigente marcado [UX e visual; declarada]. Trecho: "Os lotes vêm do mais recente ao mais antigo"
- Textos das mensagens dos códigos novos em erros.ts [UX e visual; silenciosa]. Trecho: ""aluno-sem-conta": "Esse aluno ainda não criou a conta.""
- Texto e destino da notificação premioConcedido [UX e visual; silenciosa]. Trecho: ""A UniMax te concedeu Monitoria.", "/trofeus""
- Conta de aluno do seed com o nome completo como nome de exibição [modelo de dados; silenciosa]. Trecho: "com o nome completo como nome de exibição"
- Ex-aluno do seed marcado no dia seguinte ao fim do último semestre cursado; conta criada no início do primeiro semestre cursado [regra de produto; declarada]. Trecho: "o ex-aluno é marcado pela instituição no dia seguinte ao fim do último semestre que cursou"
- Seed acha o aluno pelo RA, e a correção feita pela instituição vence o arquivo [regra de produto; declarada]. Trecho: "O seed acha o aluno pelo RA, e um e-mail ou curso corrigido pela instituição vence o arquivo."
- Domínio reservado escolhido: al.unieduk.invalid [modelo de dados; declarada]. Trecho: "Os e-mails estão em al.unieduk.invalid."
- Atividade do seed gerada só na primeira população; aluno acrescentado depois não ganha fatos [regra de produto; declarada]. Trecho: "A atividade nasce uma vez só, na primeira vez em que os alunos do arquivo ganham conta."
- Faixas de raridade do seed diferentes das do plano (Épico 2 a 6, Raro 9 a 22, Comum 40 ou mais) [modelo de dados; silenciosa, duvidosa]. Trecho: "um aluno só no Lendário, de 2 a 6 no Épico, de 9 a 22 no Raro e 40 ou mais no Comum"
- Geração determinística com semente fixa e 'empenho' concentrado em poucos alunos [modelo de dados; silenciosa]. Trecho: "Empenho de 0,15 a 1, concentrado embaixo: poucos alunos ganham muito."
- Conteúdo dos 22 eventos semeados (monitoria, iniciação científica, extensão etc.) [modelo de dados; silenciosa, duvidosa]. Trecho: ""codigo": "iniciacao-cientifica-2026""
- Parte dos prêmios do semestre em curso nasce como reivindicação com foto aprovada por professor; o resto como concessão direta sem post [regra de produto; silenciosa, duvidosa]. Trecho: "Parte dos prêmios do semestre em curso nasce como o app faz"
- Interações sociais do seed só entre alunos ativos do mesmo curso, com volumes escolhidos pelo agente [modelo de dados; silenciosa]. Trecho: "Seguimentos entre colegas de curso ... Só de alunos ativos"
- Medalhas semeadas não geram notificação de medalha recebida [regra de produto; declarada]. Trecho: "As medalhas semeadas não geram notificação de medalha recebida"
- Fotos do Wikimedia Commons em vez de Unsplash/Pexels, ampliando para CC BY e CC BY-SA [UX e visual; declarada]. Trecho: "Amplio para CC BY e CC BY-SA"
- 33 fotos recortadas em quadrado ao centro, com as derivadas versionadas no repositório (~10 MB) [UX e visual; declarada]. Trecho: "33 fotos geradas, todas dentro dos limites (cerca de 10 MB no total)"
- Novo método EnviarAsync na abstração de armazenamento, usado só pelo seed [stack e arquitetura; silenciosa]. Trecho: "Task EnviarAsync(string chave, byte[] conteudo"
- Seeder do docker-compose passa a receber as variáveis do bucket [hospedagem e deploy; declarada]. Trecho: "O seeder do compose passou a ter o bucket."
- Corrigiu o mundo de teste para criar contas no relógio de teste [testes e processo; declarada]. Trecho: "Agora o mundo de teste cria as contas no próprio relógio."
- Falha na suíte da etapa 1 tratada como intermitente e commit feito assim mesmo [testes e processo; declarada]. Trecho: "Sozinho, passa (os 19 s apontam para a disputa de recurso"
- Moveu as comprovações pendentes da etapa 5 para a 6 [testes e processo; declarada]. Trecho: "Mudei a ordem de uma entrega"
- Na queda do GitHub Actions, repetiu a CI e adiantou a etapa 6 localmente sem commit [testes e processo; declarada]. Trecho: "adiantar a etapa 6 localmente, sem commit até ela ficar verde"
- Na fila de contestações, 'Confirmar' decide na hora e só 'Revogar' abre a folha de motivo [UX e visual; declarada]. Trecho: ""Confirmar" decide na hora, como o "Aprovar" das comprovações"
- 'Contestar prêmio' acima de 'Remover post', indo direto para a folha de motivo [UX e visual; declarada]. Trecho: "aparece "Contestar prêmio" acima de "Remover post""
- Textos próprios para a instituição ('Esta área é da instituição.', 'dos alunos') e o voltar para a área [UX e visual; declarada]. Trecho: "para outros papéis, "Esta área é da instituição.""
- Cartão de contestação sem foto mostra 'Concedido direto pela instituição, sem comprovação.' [UX e visual; declarada]. Trecho: ""Concedido direto pela instituição, sem comprovação.""
- Para as capturas: senha definida pela recuperação e um aluno do seed fez post [testes e processo; declarada]. Trecho: "A senha das duas contas no ambiente local é senha-de-captura-12."
- Nova rota GET /v1/instituicao/alunos/{cadastroId}/premios-participacao [stack e arquitetura; declarada]. Trecho: "Vou expor a rota GET /v1/instituicao/alunos/{cadastroId}/premios-participacao"
- GET /v1/cursos passa a devolver o id [stack e arquitetura; declarada]. Trecho: "Acrescento o id à resposta, como acréscimo."
- Busca com debounce de 400 ms e a partir de 2 letras [UX e visual; declarada]. Trecho: "espera 400 ms depois da digitação e só busca a partir de 2 letras"
- Atos por situação: sem conta só corrige e-mail e troca de curso; ex-aluno só corrige e-mail [regra de produto; declarada]. Trecho: "Sem conta: só corrigir e-mail e trocar de curso. Ex-aluno: só corrigir e-mail."
- Mensagem própria para prêmio repetido na concessão [UX e visual; declarada]. Trecho: ""O aluno já tem esse prêmio nesse evento.""
- Seletor da reivindicação generalizado com fontes injetáveis (FontesDaEscolha) [stack e arquitetura; declarada]. Trecho: "adapto o seletor da reivindicação para servir também à concessão"
- Área como lista de entradas, com 'Alunos' antes de Comprovações e Contestações [UX e visual; declarada]. Trecho: "Entrada "Alunos" na área: fica antes de Comprovações e Contestações."
- Formulário de aviso compartilhado entre professor e instituição [stack e arquitetura; declarada]. Trecho: "Vou tornar o formulário de aviso um componente compartilhado"
- Escopo Faculdade como padrão; publicar só com pelo menos um curso no escopo Cursos [UX e visual; declarada]. Trecho: "escolhe entre Faculdade (o padrão) e Cursos"
- Capturas da etapa 9 com a demonstração ligada e lotes ensaio-1 e banca-1 deixados no banco [testes e processo; declarada]. Trecho: "Registrei 2 alunos de demonstração no lote ensaio-1 e 3 no banca-1"
- 'Voltar à ficha' passou a voltar na pilha [UX e visual; declarada]. Trecho: ""Voltar à ficha" passou a voltar na pilha em vez de abrir a ficha de novo"
- Prazo de 90 s nos e2e de medalhas, conquistas e rankings [testes e processo; declarada]. Trecho: "vou dar a medalhas e rankings o mesmo prazo de 90 s"
- Isolamento do e2e: nomes únicos, lote da purga criado direto no banco, foto enviada por outra conta [testes e processo; declarada]. Trecho: "O lote da purga nasce direto no banco com a flag desligada"
- Tipo de commit test(mobile) na etapa 10 [testes e processo; declarada]. Trecho: "Usei o tipo test com escopo mobile porque não existe escopo e2e"
- Push da branch base rodada/eng_12_instituicao para o remoto antes de abrir o PR [testes e processo; declarada]. Trecho: "The base branch rodada/eng_12_instituicao exists only locally. Before I push it"
- Seed enfileira recálculos de raridade e ranking só se não houver um pendente [stack e arquitetura; silenciosa]. Trecho: "Um pedido de cada, se ainda não houver um pendente."

Perguntas do agente:

- P1. Onde fica a área web (mesmo app em /instituicao, entrada pelo menu do perfil, só na web)? [respondida]
- P2. Concessão direta: nasce válida com janela de 15 dias, post com o aluno, notificação premioConcedido? [respondida]
- P3. Corrigir e-mail: linha da base com ou sem conta, forma e unicidade, invalidar recuperações, manter sessões? [respondida]
- P4. Ex-aluno sem volta e sem troca de curso; troca pede curso e semestre, matrículas antigas ficam? [respondida]
- P5. Registrar quem fez e quando nos quatro atos (correção, ex-aluno, troca, purga)? [respondida]
- P6. Purga também do lote vigente, com o nome do lote digitado? [respondida]
- P7. De onde vêm as fotos do seed: fotos suas, banco livre com créditos, ou geradas por script? [respondida]
- P8. Contas dos alunos do seed: fábrica sem senha com criado_em retroativo; domínio reservado ou bloquear recuperação? [respondida]
- P9. Seguimentos, curtidas e comentários no seed: poucos, ou nenhum? [respondida]
- A linha 'em comum' da comprovação fica longa para a instituição; posso encurtar, se quiser? [respondida]
- Se quiser só fotos em domínio público e CC0, troco por fotos suas? [respondida]

## Export eng_13_endurecimento

Decisões sem perguntar:

- Renomeou as imagens do GHCR para maxx-engenheiro-api e maxx-engenheiro-caddy, em vez de maxx-api/maxx-caddy do plano [hospedagem e deploy; declarada]. Trecho: "vou renomeá-lo para maxx-engenheiro-api e maxx-engenheiro-caddy para não colidir com o outro repositório do TCC"
- Publicação das imagens com docker build --provenance=false para ligar o pacote ao repositório [hospedagem e deploy; declarada]. Trecho: "Vou tentar publicar com --provenance=false."
- Grupo de concorrência da CI por ref e evento, para o disparo à mão e o push não se cancelarem [testes e processo; declarada]. Trecho: "group: ci-${{ github.ref }}-${{ github.event_name }}"
- Log de cada contêiner de produção limitado a 5 arquivos de 10 MB [hospedagem e deploy; declarada]. Trecho: "log de cada contêiner limitado a 5 arquivos de 10 MB, para não encher o disco"
- Exceção no .gitignore para versionar o .env.producao.example [hospedagem e deploy; silenciosa]. Trecho: "+!.env.producao.example"
- Verificação do R2 filtrando só as linhas MAXX_ARMAZENAMENTO_ para um arquivo temporário privado (umask 077), apagado no fim [segurança; declarada]. Trecho: "Filtro só as linhas do R2 para um arquivo temporário e privado"
- Correção do envio ao R2 desligando o chunk encoding do PutObject (UseChunkEncoding = false) [stack e arquitetura; declarada]. Trecho: "A correção é desligar o chunk encoding no PutObjectRequest, forma que o R2 aceita"
- Novo teste de envio direto no VerificacaoDoR2Tests, com prova reversa rodada na VPS [testes e processo; declarada]. Trecho: "Escrevo primeiro o teste, para rodá-lo na VPS sem a correção (prova reversa)"
- Dois códigos de recusa (email-fora-da-faculdade no cadastro, dominio-nao-aceito na correção) em vez do código único do plano [regra de produto; declarada]. Trecho: "a etapa 3 vai usar dois códigos, um para o cadastro (email-fora-da-faculdade) e outro para a correção (dominio-nao-aceito)"
- Checagem de domínio também na sugestão e na disponibilidade do arroba, antes da consulta à base, com código próprio [regra de produto; declarada]. Trecho: "a checagem no BuscarSemContaAsync (vale para cadastro, sugestão e disponibilidade do arroba)"
- Lista de domínios no appsettings.json, igual em todo ambiente e sem lista separada de teste; vazia, nada sobe [stack e arquitetura; declarada]. Trecho: "não é segredo, e a lista é a mesma em todo ambiente. Vazia ou mal formada, nada sobe."
- Batimento do worker gravado no máximo a cada 15 s [stack e arquitetura; silenciosa]. Trecho: "Sem batimento há mais de 2 minutos (o worker grava um a cada 15 s)"
- Falha ao gravar o batimento só gera aviso no log, e o laço do worker continua [stack e arquitetura; silenciosa]. Trecho: "LogFalhaNoBatimento(logger, falha.GetType().Name, falha.Message);"
- Tabela batimento_do_worker de uma linha com restrição de checagem id = 1 [modelo de dados; declarada]. Trecho: "apenas a tabela de uma linha e a restrição id = 1"
- Janela de trabalho falho calculada pelo disponivel_em, sem coluna nova [modelo de dados; declarada]. Trecho: "a consulta das últimas 24 horas não precisa de coluna nova"
- Fila parada contada do que vier depois entre a chegada e a disponibilidade do trabalho [stack e arquitetura; silenciosa]. Trecho: "contados do que vier depois entre a chegada e a disponibilidade (o seed enfileira com datas passadas)"
- Formato da resposta do /health/worker: status, idades, contagens, códigos worker-parado/fila-parada/trabalho-falho, 503 com o mesmo corpo [stack e arquitetura; silenciosa]. Trecho: "200 com "status": "ok", ou 503 com a lista problemas"
- Parou o worker em produção por mais de 2 minutos para provar o alerta [testes e processo; declarada]. Trecho: "Vou parar o worker por pouco mais de 2 minutos para checar o alerta worker-parado na produção"
- Cabeçalhos e diretivas além do plano: X-Frame-Options DENY, COOP same-origin, remoção do Server, font/worker/manifest-src, form-action, connect-src com data: e blob: [segurança; silenciosa]. Trecho: "X-Frame-Options "DENY" ... Cross-Origin-Opener-Policy "same-origin" -Server"
- HSTS de um ano, sem includeSubDomains nem preload [segurança; silenciosa]. Trecho: "Um ano, sem subdomínios nem preload: vale só para o app."
- style-src com 'unsafe-inline' por causa do react-native-web e do expo-reset [segurança; declarada, duvidosa]. Trecho: "o style-src vai precisar de 'unsafe-inline', como eu tinha previsto, e registro o motivo"
- Trivy fixado na v0.76.1, com checksum, escolhendo versão com mais de duas semanas [testes e processo; declarada]. Trecho: "Fixo a v0.76.1, de 21/10, com a soma conferida pelo arquivo de checksums."
- Trivy com --ignore-unfixed e varredura de segredos nas imagens [segurança; declarada]. Trecho: "alto ou crítico e --ignore-unfixed"
- apt-get upgrade no estágio final da imagem da API para corrigir achado do Trivy [segurança; declarada]. Trecho: "o Trivy também ganha um fix próprio para atualizar os pacotes do Ubuntu"
- Laço do Trivy varrendo sempre as duas imagens antes de falhar o job [testes e processo; declarada]. Trecho: "As duas sempre, e o job falha no fim: a primeira com achado não esconde a segunda."
- Exceção do Trivy limitada ao binário do Caddy [segurança; declarada, duvidosa]. Trecho: "o .trivyignore.yaml com a exceção limitada ao binário do Caddy e com validade"
- Backup com pg_dump -Fc, nome com instante UTC e rótulo, validação por pg_restore --list antes do nome final, pasta 700 de root, timer Persistent [hospedagem e deploy; silenciosa]. Trecho: "O dump só ganha o nome final depois de o pg_restore --list conseguir lê-lo."
- deploy.sh baixa compose e scripts do GitHub no mesmo commit, confere o .env, troca a si mesmo com mv e espera o /api/ready [hospedagem e deploy; declarada]. Trecho: "traz do repositório, no mesmo commit, os arquivos do compose, o .env.producao.example e os scripts de infra/, inclusive ele mesmo"
- k6 fixado em grafana/k6:1.8.2 [testes e processo; declarada]. Trecho: "Fixo a grafana/k6:1.8.2, de 12/10"
- Contêiner do k6 rodando como root na VPS [segurança; declarada]. Trecho: "Vou rodar o contêiner do k6 como root, passando a chave só pelo --env-file"
- Aquecimento de 20 s descartado antes da medida de carga [testes e processo; declarada]. Trecho: "depois de 20 s de aquecimento descartado (as réplicas tinham acabado de reiniciar"
- Limites no k6: p95 < 300 ms por rota e taxa de falha < 1% [testes e processo; silenciosa]. Trecho: "http_req_failed: ["rate<0.01"] ... ["p(95)<300"]"
- EXPLAIN com enable_seqscan = off na VPS para provar que os índices do feed e de trigramas servem [testes e processo; declarada]. Trecho: "Vou forçar enable_seqscan = off para confirmar se os índices de trigramas atendem à consulta"
- Escolha dos índices pelo planejador com volume real registrada como pendência fora da fase 1 [testes e processo; declarada, duvidosa]. Trecho: "a escolha com volume real fica pendente junto com o cenário de 2.000 usuários"
- Gravação de logs e docker stats a cada 10 s na VPS durante o ensaio [testes e processo; declarada]. Trecho: "Vou gravar logs e amostras de docker stats a cada 10 s para cruzar com cada passo"
- Correção do passo 6: tocar de novo no prêmio escolhido devolve a lista, mantém nome e datas, limpa evento e matéria; vale também para a concessão da instituição [UX e visual; declarada]. Trecho: "tocar de novo no prêmio escolhido devolve a lista inteira, com o mesmo efeito do "Trocar prêmio""
- Captura por spec temporário do Playwright, a 390 de largura, nos temas claro e escuro [testes e processo; declarada]. Trecho: "Vou gravar a captura com uma especificação temporária do Playwright, fora do commit, nos temas claro e escuro"
- Rotina de purga em operacao.md com desligar a demonstração antes e esperar a fila esvaziar [hospedagem e deploy; silenciosa]. Trecho: "1. Desligar a demonstração (dc up -d), para ninguém entrar no lote durante a purga."
- Atualização de comentários e docs que citavam o passo 13 como futuro [testes e processo; declarada]. Trecho: "Ficaram cinco referências ao passo 13 escritas como futuro."
- Publicou no remoto a branch rodada/eng_13_endurecimento para servir de base do PR [testes e processo; declarada]. Trecho: "publico-a sem commit novo, como base para o PR"
- Primeira subida na VPS com sha-c1f2b77 só com seed base, antes da troca dos e-mails [hospedagem e deploy; declarada]. Trecho: "a primeira subida na VPS com a sha-c1f2b77, usando só o seed base"
- Encadeamento que só implanta na VPS se a publicação terminar verde [hospedagem e deploy; declarada]. Trecho: "Escrevo um script de implantação reutilizável; depois de checar que a publicação ficou verde, vou trocar a tag na VPS"

Perguntas do agente:

- E-mails dos professores e da instituição no seed: trocar para endereços em maxx-unimax.com com Email Routing? Ou você prefere outro caminho? [respondida]
- Textos do código dominio-nao-aceito: aprova? E posso passar o produto.md 2.4 para 'configuração da API'? [respondida]
- Bucket de backup separado maxx-backup sem domínio público, com token próprio e retenção de 14 dias: você cria? [respondida]
- Para onde vai o alerta: monitor externo (UptimeRobot) ou cron no host com Brevo? [respondida]
- Imagens antes da main por workflow_dispatch com sha-<curto>; pacote no GHCR público ou privado? [respondida]
- Papel maxx_app com menos privilégio: entra no passo, ou o usuário dono fica, só com a revisão registrada? [respondida]
- Contas e volume do k6: seed carga com cerca de 3.050 alunos como lote carga-k6. Topa? Ou 'volume real' quer dizer outra coisa? [respondida]
- De onde roda o k6: uma CX temporária da Hetzner no mesmo datacenter, criada por você. Pode ser? [respondida]
- Varredura das imagens com Trivy no job build, mesmo corte alto ou crítico. Entra? [respondida]
- Node 24: se o Expo 58 suportar e a CI ficar verde, eu já troco, ou só trago a avaliação para você decidir? [respondida]
- Como você prefere seguir? 1. Derrubo a pilha local e rodo de novo a suíte do Node 24; 2. pulo a suíte local e deixo a CI decidir. [respondida]
- Qual opção para o Caddy? (exceção com prazo no Trivy, compilar com xcaddy, ou Trivy não bloqueante) [respondida]
- O lote do ensaio no MAXX_DEMO_LOTE: o .env já tem um valor; confirme se ele é o do ensaio ou troque. [respondida]
- Se o e-mail de primeiro acesso da coordenação chegou. [respondida]
- Cache da CDN depois da purga: passo manual na rotina, automatizar na API, ou só registrar como limite? Qual você prefere? [respondida]
- O CLAUDE.md tem duas linhas desatualizadas pelo passo 13. Se quiser, ajusto no mesmo PR. [respondida]
