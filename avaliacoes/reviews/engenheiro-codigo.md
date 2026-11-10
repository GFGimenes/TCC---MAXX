# Review engenheiro, eixo 5. Código

- Status: ok
- Tentativa: 1
- Commit avaliado: 8910b51ae7b0ca10582517ead72ee832746683a3 (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 6592d385-04d7-4a82-82c9-b9a0a91d3899

Texto do revisor, sem edição:

---
# Revisão no eixo 5 (Código): produto `engenheiro`, commit `8910b51a`

**Nota: 5**

**Sem a suíte de referência.** Não há resultado da suíte de testes de referência para este produto. A nota se baseia só na leitura do código e dos testes. Nesta sessão não pude compilar nem rodar nada.

## Justificativa

**Regras de fronteira corretas e testadas.**
- As faixas de tier estão num lugar só: `Tiers.Faixa` em `apps/api/src/Maxx.Domain/Catalogo/Tier.cs:21-28`. Bronze vai de 1 a 30, Prata de 31 a 70, Ouro de 71 a 100 e Diamante de 101 a 150.
- A faixa usa limites inclusivos em `Tier.cs:14`.
- O teste `CatalogoValidatorTests.cs:65-87` cobre exatamente as fronteiras da rubrica (30/31, 70/71, 100/101, 150/151), além do 0. Os valores fora da faixa são recusados e os de dentro são aceitos.
- Os pontos não vêm de quem pede. O professor manda só o código do item (`ProfessorEndpoints.cs:112-113`), e a medalha copia tier e pontos do catálogo (`Medalha.cs:36-37`).

**Ranking.**
- `Classificacao.Ordenar` (`apps/api/src/Maxx.Domain/Ranking/Classificacao.cs:86-90`) ordena por pontos em ordem decrescente.
- Em caso de empate, decide pelo instante da última concessão e, depois, pelo id do aluno.
- `ClassificacaoTests.cs` tem 10 casos. Eles cobrem a soma, a ordem, os dois níveis de desempate, ex-aluno aparecendo só no histórico, troca de curso e as visões geral e por curso, por semestre e histórica.

**Entradas inválidas.**
- O domínio devolve recusas tipadas: o enum `RecusaDaConcessao` em `Medalha.cs:208-218` e `RecusaDaPublicacao`. A aplicação converte essas recusas em `RecusaException` com código e tipo HTTP (`ConcederMedalhaHandler.cs:92-104`, `Posts.cs:199-216`).
- A concessão trata a corrida entre duas gravações pela chave única, com uma nova tentativa (`ConcederMedalhaHandler.cs:31-45`).
- Os testes de integração cobrem esses casos: post vazio ou com legenda longa devolve 400 (`Social/PostTests.cs:95`), foto alheia ou já usada é recusada (`:119`), há concorrência nos posts (`:165`, `:183`) e no limite de medalhas (`ConcessaoDeMedalhaTests.cs:136`), turma fora do escopo (`:160`), aluno chamando rota de professor (`:178`) e ex-aluno (`:207`).

**Testes próprios.**
- O backend tem cerca de 970 atributos `[Fact]`/`[Theory]` em 94 arquivos, divididos em três projetos: domínio, arquitetura e integração com Postgres real.
- O app mobile tem 49 arquivos `*.test.ts(x)`, um por área de tela.
- Há testes de arquitetura que garantem a direção das camadas (`Maxx.Architecture.Tests/LayerDependencyTests.cs`).

**CI.**
- `.github/workflows/ci.yml` roda formatação, build com aviso tratado como erro e todos os testes .NET (`:26-44`).
- No mobile roda lint, typecheck e testes (`:56-60`). Também confere se o cliente gerado bate com o OpenAPI (`:77-78`).
- Roda e2e com Playwright sobre o compose (`:95-126`), e a publicação só acontece com todos os jobs verdes (`:215`).
- O build é rígido: `Directory.Build.props:7-10` liga `TreatWarningsAsErrors`, `AnalysisLevel latest-recommended` e `EnforceCodeStyleInBuild`.

**Padrões onde ajudam.**
- Arquitetura em camadas (Domain, Application, Infrastructure, Api), com repositório e unidade de trabalho.
- Fábrica estática com objeto de resultado: `Medalha.Conceder` devolve `ResultadoDaConcessao`.
- O catálogo é dado, validado por `CatalogoValidator`, que devolve todos os erros de uma vez. Há um ponto de extensão `IRegraCustomizada` registrado por nome (`AvaliadorDeConquista.cs:150-164`, `:189`).
- A fila de trabalhos cuida do que pode esperar, como notificação, reavaliação de conquistas e recálculo do ranking (`ConcederMedalhaHandler.cs:85-87`).
- Não vi padrão usado à toa. No front, o `FeedScreen` é enxuto, trata carregamento, erro e vazio, e usa os componentes compartilhados `StateMessage`, `Icon` e os tokens de tema.

**Pontos menores, que não derrubam a nota.**
- O helper `UsuarioId(ClaimsPrincipal)` está repetido. Há uma cópia idêntica em `ProfessorEndpoints.cs:93-96` e `UploadEndpoints.cs:46-47`. A mesma leitura do claim `sub` aparece em linha em `EuEndpoints.cs:26`, `PremiosEndpoints.cs:27`, `EventoEndpoints.cs:83` e `PostEndpoints.cs:83`. Um método de extensão resolveria.
- `ProfessorEndpoints.Nome<T>` (`:98-99`) é usado como helper por outros arquivos (`MedalhaConcedidaResponse.De`, `:118`), o que acopla os endpoints entre si. Ele também duplica `NomeJson.De` (`Infrastructure/Seed/NomeJson.cs:12`).
- `PublicarPostHandler.PublicarAsync` tem três sobrecargas que foram ganhando parâmetros (`Posts.cs:103-120`), com três ids de prêmio anuláveis e mutuamente exclusivos. Na checagem de "prêmio já postado" (`Posts.cs:160-163`), o prêmio de participação usa uma consulta diferente dos outros dois tipos.
- O código usa muitos comentários com referência a `produto.md` e aos ADRs. Ajudam a rastrear, mas o critério "se lê sem comentário" é atendido só em parte: os nomes já são bastante expressivos e os comentários explicam o porquê, não o quê.

São detalhes. O conjunto atende a todos os critérios do nível 5: fronteiras e entradas inválidas testadas, testes cobrindo as regras de negócio, convenções impostas pelo build, padrões bem aplicados e suíte rodando na CI.

## Regras ausentes (sem efeito na nota)
- **Vinculação de conta pelo portal da instituição (SSO).** O cadastro usa e-mail institucional ou RA conferido contra uma lista de elegíveis (`CadastroElegivel`). Não encontrei integração com portal, OIDC ou SSO.

## Decisões do agente neste eixo (sem o prompt pedir)
- Faixa de tier fechada num value object (`FaixaDePontos`), com o tier congelado na concessão (ADR 0007).
- Catálogo de prêmios como dado (JSON), com validador de domínio que roda na CI e antes do seed (ADR 0004).
- Recusas de domínio como enum e resultado tipado, em vez de exceção, convertidas em código de erro na aplicação.
- Desempate do ranking pela última concessão e depois pelo id do aluno, para a posição ser estável.
- Concorrência resolvida por índice único com uma nova tentativa (medalha) e por `xmin` (upload).
- Testes de arquitetura que verificam a direção de dependência entre as camadas.
- Testes de integração com Postgres real, em vez de banco em memória.
- `TreatWarningsAsErrors`, `AnalysisLevel latest-recommended` e `dotnet format --verify-no-changes` na CI.
- Cliente TypeScript gerado a partir do OpenAPI e conferido na CI.
- Suíte e2e com Playwright sobre o compose, nos modos com e sem demonstração.
- Raridade ("encontrabilidade") calculada a partir da escassez, em inteiros e sem arredondamento na fronteira (`Raridade.cs:20-35`).
- Ponto de extensão `IRegraCustomizada` para conquista com regra em C#, que nenhum item usa ainda.

## O que não pude verificar
- Se a solução compila e se a CI está verde neste commit.
- Se os ~970 testes .NET, os testes do mobile e os e2e passam.
- A suíte de testes de referência, que não foi fornecida.
- A cobertura real de testes, em porcentagem.
- O comportamento em execução do app mobile e da API.

```json
{
  "nota": 5,
  "justificativa": "Faixas de tier centralizadas em Tiers.Faixa (Bronze 1-30, Prata 31-70, Ouro 71-100, Diamante 101-150) e testadas exatamente nas fronteiras 30/31, 70/71, 100/101, 150/151. Pontos sempre vêm do catálogo, nunca do pedido. O ranking ordena por pontos com desempate determinístico e tem 10 testes de domínio. Entradas inválidas viram recusas tipadas e códigos de erro, com testes de integração para 400/403/404/409 e concorrência. Cerca de 970 testes .NET (domínio, arquitetura, integração com Postgres real) e 49 arquivos de teste no mobile, tudo rodando na CI com build que trata aviso como erro, format, lint, typecheck e e2e. Padrões aplicados com propósito (camadas verificadas por teste, resultado tipado, catálogo validado, fila, extensão por regra customizada). Pontos menores: helper UsuarioId e leitura do claim sub repetidos nos endpoints, Nome<T> usado entre endpoints e duplicando NomeJson.De, sobrecargas acumuladas em PublicarPostHandler. Sem resultado da suíte de referência; nota dada só pela leitura, sem compilar nem rodar.",
  "evidencias": [
    {"local": "apps/api/src/Maxx.Domain/Catalogo/Tier.cs:21", "descricao": "Faixas de pontos por tier num único switch, com limites inclusivos (linha 14)."},
    {"local": "apps/api/tests/Maxx.Domain.Tests/Catalogo/CatalogoValidatorTests.cs:65", "descricao": "Theory com as fronteiras 0/31/30/71/70/101/100/151 recusadas e 1/30/31/70/71/100/101/150 aceitas."},
    {"local": "apps/api/src/Maxx.Domain/Catalogo/CatalogoValidator.cs:88", "descricao": "O validador recusa item com pontos fora da faixa do tier e exige pontos crescentes na família (progressão), linhas 376-385."},
    {"local": "apps/api/src/Maxx.Domain/Ranking/Classificacao.cs:86", "descricao": "Ordenação do ranking por pontos decrescentes, depois última concessão, depois id do aluno."},
    {"local": "apps/api/tests/Maxx.Domain.Tests/Ranking/ClassificacaoTests.cs:29", "descricao": "10 testes de ordenação, desempate, ex-aluno, semestre x histórico e curso."},
    {"local": "apps/api/src/Maxx.Domain/Premios/Medalha.cs:90", "descricao": "Concessão com validações de papel, ex-aluno, período, vigência, curso e limite, devolvendo recusa tipada."},
    {"local": "apps/api/src/Maxx.Api/Medalhas/ProfessorEndpoints.cs:113", "descricao": "Pedido traz só o código do item, com Required e StringLength; tier e pontos vêm do catálogo."},
    {"local": "apps/api/src/Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:31", "descricao": "Corrida de concessões tratada por índice único com uma nova tentativa."},
    {"local": "apps/api/tests/Maxx.Api.IntegrationTests/Social/PostTests.cs:95", "descricao": "Testes de entrada inválida (post vazio, legenda longa = 400), foto alheia e concorrência (linhas 119, 165, 183)."},
    {"local": "apps/api/tests/Maxx.Api.IntegrationTests/Medalhas/ConcessaoDeMedalhaTests.cs:136", "descricao": "Concessões simultâneas, escopo de turma, aluno em rota de professor e ex-aluno testados."},
    {"local": "apps/api/tests/Maxx.Architecture.Tests/LayerDependencyTests.cs:8", "descricao": "Testes que verificam a direção das dependências entre camadas."},
    {"local": ".github/workflows/ci.yml:26", "descricao": "CI com format, build Release, testes de domínio, arquitetura e integração, lint, typecheck e testes do mobile, cliente OpenAPI e e2e Playwright."},
    {"local": "Directory.Build.props:7", "descricao": "TreatWarningsAsErrors, AnalysisLevel latest-recommended e EnforceCodeStyleInBuild."},
    {"local": "apps/api/src/Maxx.Api/Medalhas/ProfessorEndpoints.cs:93", "descricao": "Duplicação menor: UsuarioId(ClaimsPrincipal) idêntico em Fotos/UploadEndpoints.cs:46 e leitura do claim sub repetida em EuEndpoints.cs:26, PremiosEndpoints.cs:27, EventoEndpoints.cs:83 e PostEndpoints.cs:83."},
    {"local": "apps/api/src/Maxx.Api/Medalhas/ProfessorEndpoints.cs:98", "descricao": "Nome<T> usado como helper por outros arquivos e duplicando NomeJson.De (Infrastructure/Seed/NomeJson.cs:12)."},
    {"local": "apps/api/src/Maxx.Application/Posts/Posts.cs:103", "descricao": "Três sobrecargas de PublicarAsync acumulando ids anuláveis e exclusivos; checagem de prêmio já postado inconsistente entre os tipos (linhas 160-163)."},
    {"local": "apps/mobile/src/feed/FeedScreen.tsx:91", "descricao": "Tela enxuta com carregamento, erro e vazio via componentes compartilhados; o mobile tem 49 arquivos de teste."}
  ],
  "regras_ausentes": [
    "Vinculação da conta via portal da instituição (SSO/OIDC): o cadastro usa e-mail institucional ou RA conferido contra lista de elegíveis, sem integração com portal."
  ],
  "decisoes_do_agente": [
    "Faixa de tier como value object FaixaDePontos, com tier e pontos congelados na concessão (ADR 0007).",
    "Catálogo de prêmios como dado JSON, com CatalogoValidator rodando na CI e antes do seed (ADR 0004).",
    "Recusas de domínio como enum e resultado tipado, convertidas em RecusaException com código de erro na aplicação.",
    "Desempate do ranking por instante da última concessão e depois por id do aluno, para posição estável.",
    "Concorrência resolvida por índice único com uma nova tentativa (medalha) e por xmin (upload).",
    "Testes de arquitetura verificando a direção de dependência entre camadas.",
    "Testes de integração contra Postgres real em vez de banco em memória.",
    "Build com TreatWarningsAsErrors, AnalysisLevel latest-recommended e dotnet format verificado na CI.",
    "Cliente TypeScript gerado do OpenAPI e conferido na CI.",
    "Suíte e2e Playwright sobre docker compose, nos modos com e sem demonstração.",
    "Raridade (encontrabilidade) calculada a partir da escassez, em inteiros e sem arredondamento.",
    "Ponto de extensão IRegraCustomizada registrado por nome para conquistas com regra em C#."
  ],
  "nao_verificado": [
    "Se a solução compila e se a CI está verde neste commit.",
    "Se os cerca de 970 testes .NET, os testes do mobile e os e2e passam.",
    "Suíte de testes de referência (fronteiras, entradas inválidas, ordenação do ranking): resultado não fornecido.",
    "Cobertura de testes em porcentagem.",
    "Comportamento em execução da API e do app mobile."
  ]
}
```
