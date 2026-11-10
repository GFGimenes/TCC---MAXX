# Review engenheiro, eixo 6. Projeto e arquitetura

- Status: ok
- Tentativa: 1
- Commit avaliado: 8910b51ae7b0ca10582517ead72ee832746683a3 (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 70b5d635-2859-49af-843c-bf9450666b8c

Texto do revisor, sem edição:

---
# Revisão: eixo 6, Projeto e arquitetura (produto `engenheiro`, commit `8910b51a`)

## Nota: 5

## Justificativa

- **Camadas separadas e protegidas por teste.** São quatro projetos: Domain, Application, Infrastructure e Api, com fatias por recurso dentro de Application. A regra de dependência entre eles é verificada por um teste de arquitetura (`apps/api/tests/Maxx.Architecture.Tests/LayerDependencyTests.cs:11-40`), e o Domain só referencia a biblioteca padrão.
- **Cada regra de produto vive num lugar só, no domínio:**
  - faixas de tier em `Tier.cs`;
  - concessão de medalha, com ex-aluno, período, vigência, curso e limite, em `Medalha.Conceder`;
  - ranking, com ordenação e desempate, em `Classificacao`;
  - intercalação do feed em `Feed.Intercalar`.
- **As bordas são finas.** Os endpoints traduzem HTTP, os handlers orquestram, a Infrastructure implementa as portas (`IEscopoDeTurma`, `IArmazenamentoDeFotos`). No cliente, as rotas do Expo Router só reexportam telas de pastas por recurso (`apps/mobile/src/app/(app)/(abas)/trofeus.tsx:1-3`). A validação repetida no cliente é declarada como cópia só para resposta rápida (`apps/mobile/src/cadastro/regras.ts:1-2`).
- **O modelo de dados representa as regras sem gambiarra:**
  - `Tier` com faixa, e uma constraint de banco espelhando a mesma faixa;
  - `SemestreLetivo`, `Bimestre`, `Turma`, `Matricula` e `VinculoProfessor`;
  - `Papeis`, ex-aluno com auditoria;
  - pontos congelados na concessão (ADR 0007);
  - catálogo declarativo e versionado (ADR 0004).
- **Decisões justificadas.** Há 8 ADRs com alternativas e consequências negativas, e um índice extenso de decisões por passo.
- **Escala pensada para o campus.** API sem estado com duas réplicas, worker separado, ranking e raridade pré-calculados, fila no Postgres, e fotos fora da API, enviadas por URL assinada direto ao bucket e servidas por CDN.
- **Fiel ao pitch.** O produto cobre as seis telas e as regras centrais. As divergências estão registradas em `docs/produto.md`, não são acidentais.

**Pontos fracos (não derrubam a nota):**
- Há acoplamento lateral entre endpoints: `RankingEndpoints` usa `PostEndpoints.UsuarioId` e `PostResponse.Leitura`, e `ProfessorEndpoints` tem uma cópia própria de `UsuarioId`.
- O log de leitura de avisos é gravado, mas não há rota que mostre ao professor quem leu.
- A escala para o campus inteiro foi pensada, mas só medida em carga reduzida (50 usuários virtuais). O cenário de 2.000 está registrado como pendência.

## Evidências

| Local | O que mostra |
|---|---|
| `apps/api/tests/Maxx.Architecture.Tests/LayerDependencyTests.cs:11-40` | Dependências entre camadas verificadas por teste |
| `apps/api/src/Maxx.Domain/Catalogo/Tier.cs:19-28` | Faixas de tier num lugar só, com espelho em check constraint (`Migrations/20261103013352_Catalogo.cs:61`) |
| `apps/api/src/Maxx.Domain/Premios/Medalha.cs:90-178` | Regra de concessão inteira no domínio; pontos e tier congelados; auditoria de quem concedeu e anulou |
| `apps/api/src/Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:48-90` | Handler só orquestra: escopo, carga, domínio, fila e unidade de trabalho |
| `apps/api/src/Maxx.Infrastructure/Autorizacao/EscopoDeTurma.cs:13-40` | "Professor só dá medalha a quem leciona" checado no banco; reaproveitado em seguir, comprovação e contestação |
| `apps/api/src/Maxx.Domain/Ranking/Classificacao.cs:36-92` | Quatro visões, desempate e "ex-aluno só no histórico" no domínio |
| `apps/api/src/Maxx.Api/Ranking/RankingEndpoints.cs:3,55,124` | Acoplamento lateral entre endpoints (ponto menor) |
| `apps/api/src/Maxx.Api/Medalhas/ProfessorEndpoints.cs:93-96` | `UsuarioId` duplicado em vez de vir de um utilitário comum da borda |
| `apps/api/src/Maxx.Domain/Mural/LeituraDeAviso.cs:5-24` e `Maxx.Api/Mural/AvisoEndpoints.cs:39,51` | Leitura gravada (quem e quando); só há rotas para marcar leitura, nenhuma para consultar |
| `docs/decisoes/README.md:11-35` | ADRs 0001 a 0008, réplicas sem estado, worker separado, backup |
| `CLAUDE.md:51-74` e `docs/produto.md` | Mapa do repositório, regra de dependências, glossário; produto canônico com as decisões assumidas de propósito (seção 12) |
| `apps/mobile/src/app/(app)/(abas)/trofeus.tsx:1-3` e `apps/mobile/src/cadastro/regras.ts:1-2` | Cliente organizado por recurso; validação no cliente declarada como cópia, e quem decide é a API |

## Regras da ideia ausentes (não penalizadas)

- **Log de leitura acessível ao professor.** A leitura é gravada, mas nenhuma rota ou tela mostra quem leu. Fica parcialmente ausente.
- **Progressão por tier** ("a mesma conquista repetida rende prêmio de tier acima, até o Diamante"). Foi substituída por famílias de trilha e conquistas repetíveis por período (`docs/produto.md:263-271`).
- **Denúncia de post pelo usuário.** Adiada para fora da fase 1. A revogação existe, mas via contestação por professor ou instituição.
- **Bio e "followed by xxxx and yyyy" no perfil.** Removidos de propósito (decisão D10).
- **Mural com a categoria "Professores".** Implementado como escopo "turma".
- **Comportamento de semi-colapso do mural** (aviso mais recente semi-colapsado, clique abre quase em tela cheia). Substituído por "não lido aberto, lido recolhido".
- **"Último troféu" em destaque no perfil.** Não encontrado no código.

## Decisões do agente dentro deste eixo

- Arquitetura em camadas, com quatro projetos .NET e fatias verticais em Application, garantida por teste de arquitetura.
- "Troféu" é só rótulo de interface: o modelo tem três tipos distintos (Medalha, PremioParticipacao, Conquista).
- Catálogo como dado versionado em JSON, avaliado por um motor de conquistas declarativo (ADR 0004).
- Tier e pontos congelados na concessão; raridade derivada da escassez e recalculada pelo worker (ADR 0007).
- Ranking e raridade pré-calculados em tabela por worker com coalescência (ADR 0005).
- Fila em tabela do Postgres com `FOR UPDATE SKIP LOCKED`, sem broker (ADR 0008).
- Fotos fora da API, com URL assinada, derivadas geradas no cliente e chave aleatória (ADRs 0002 e 0003).
- Autenticação própria com Argon2id e família de refresh rotativo (ADR 0006).
- Escopo de turma do professor sempre consultado no banco, nunca lido do token.
- API versionada em `/v1` com mudanças só aditivas; cliente TypeScript gerado do OpenAPI.
- Mesma regra do tier repetida como check constraint no banco.
- Calendário modelado com ano, semestre letivo e bimestre, com fronteiras em `America/Sao_Paulo`.
- Modo de demonstração por flag e lote, com purga.
- Papel de instituição com área web própria em `/instituicao`.
- Origem única com Caddy, duas réplicas de API sem estado, migrations em contêiner separado.

## O que não pôde ser verificado (só leitura)

- Se a solução compila e se os testes, inclusive o de arquitetura, passam.
- Se as migrations aplicam e o seed popula o mundo de demonstração.
- Comportamento do worker de ranking e raridade sob concorrência, e se a coalescência funciona.
- Escalabilidade real: o relatório de carga não foi lido nem executado, e só existe o cenário reduzido de 50 usuários virtuais.
- Aderência visual às telas e aos mockups.
- Se todos os endpoints mantêm a regra de produto fora da borda: foi lida uma amostra (medalhas, ranking, mural, escopo), não todos os arquivos.

```json
{
  "nota": 5,
  "justificativa": "Arquitetura em quatro camadas (Domain, Application, Infrastructure, Api) com dependências garantidas por teste de arquitetura; regras de produto concentradas no domínio (Tier, Medalha.Conceder, Classificacao, Feed.Intercalar), handlers só orquestrando e bordas finas; cliente Expo organizado por recurso com rotas que só reexportam telas. O modelo de dados representa tiers, períodos (semestre letivo, bimestre, turma, matrícula), papéis e ex-aluno sem gambiarra, com pontos congelados na concessão e catálogo declarativo. Decisões justificadas em 8 ADRs com consequências negativas. Escala pensada para o campus: réplicas sem estado, worker separado, ranking pré-calculado, fila no Postgres, fotos fora da API via CDN. O produto cobre o pitch e as seis telas, com divergências registradas em docs/produto.md. Pontos menores: acoplamento lateral entre endpoints (RankingEndpoints usando PostEndpoints e PostResponse; UsuarioId duplicado), log de leitura do mural gravado mas não exposto ao professor, e escala do campus medida só em carga reduzida.",
  "evidencias": [
    {"local": "apps/api/tests/Maxx.Architecture.Tests/LayerDependencyTests.cs:11-40", "descricao": "Teste que garante Domain sem dependências, Application só do Domain e Infrastructure sem a Api."},
    {"local": "apps/api/src/Maxx.Domain/Catalogo/Tier.cs:19-28", "descricao": "Faixas de tier num lugar só (1-30, 31-70, 71-100, 101-150), espelhadas por check constraint em Migrations/20261103013352_Catalogo.cs:61."},
    {"local": "apps/api/src/Maxx.Domain/Premios/Medalha.cs:90-178", "descricao": "Regra de concessão inteira no domínio: papel, ex-aluno, semestre e bimestre, vigência, curso, limite por período, deduplicação; congela tier e pontos e grava quem concedeu e quando."},
    {"local": "apps/api/src/Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:48-90", "descricao": "Handler só orquestra: escopo, carga das entidades, chamada ao domínio, enfileiramento e unidade de trabalho."},
    {"local": "apps/api/src/Maxx.Infrastructure/Autorizacao/EscopoDeTurma.cs:13-40", "descricao": "Professor só concede ou atua sobre aluno que leciona no semestre vigente, checado no banco; reaproveitado em Social, DecidirComprovacao e Contestacao."},
    {"local": "apps/api/src/Maxx.Domain/Ranking/Classificacao.cs:36-92", "descricao": "Quatro visões, desempate por última concessão e id, ex-aluno só no histórico, tudo no domínio."},
    {"local": "apps/api/src/Maxx.Api/Ranking/RankingEndpoints.cs:3,55,124", "descricao": "Acoplamento lateral: o endpoint de ranking depende de PostEndpoints.UsuarioId e PostResponse.Leitura."},
    {"local": "apps/api/src/Maxx.Api/Medalhas/ProfessorEndpoints.cs:93-96", "descricao": "Helper UsuarioId duplicado em vez de compartilhado na borda."},
    {"local": "apps/api/src/Maxx.Domain/Mural/LeituraDeAviso.cs:5-24", "descricao": "Leitura de aviso gravada (usuário, aviso, instante), mas AvisoEndpoints.cs:39,51 só marca leitura; não há consulta de quem leu para o professor."},
    {"local": "docs/decisoes/README.md:11-35", "descricao": "Índice de 8 ADRs com consequência negativa, réplicas sem estado, worker separado, migrations em contêiner, backup."},
    {"local": "CLAUDE.md:51-74", "descricao": "Mapa do repositório, regra de dependências entre camadas e 'regra de produto mora no Domain' declarados como padrão."},
    {"local": "apps/mobile/src/app/(app)/(abas)/trofeus.tsx:1-3", "descricao": "Rota do Expo Router só reexporta a tela da pasta do recurso (src/trofeus)."},
    {"local": "apps/mobile/src/cadastro/regras.ts:1-2", "descricao": "Validação no cliente declarada como cópia para resposta imediata; quem decide é a API."}
  ],
  "regras_ausentes": [
    "Log de leitura de avisos acessível ao professor (a leitura é gravada, mas não há rota ou tela de quem leu): parcialmente ausente",
    "Progressão em que a mesma conquista repetida rende prêmio de tier acima até o Diamante (substituída por famílias de trilha e conquistas repetíveis por período)",
    "Denúncia de post pelo usuário",
    "Bio e 'followed by xxxx and yyyy' no perfil",
    "Categoria 'Professores' no mural (implementada como escopo 'turma')",
    "Comportamento de semi-colapso do mural (aviso mais recente semi-colapsado e abertura quase em tela cheia)",
    "'Último troféu' em destaque no perfil"
  ],
  "decisoes_do_agente": [
    "Arquitetura em quatro projetos .NET (Domain, Application, Infrastructure, Api) com fatias verticais por recurso e teste de arquitetura",
    "Três tipos de prêmio distintos no modelo (Medalha, PremioParticipacao, Conquista), com 'troféu' só como rótulo de interface",
    "Catálogo de prêmios como JSON versionado e motor de conquistas declarativo (ADR 0004)",
    "Tier e pontos congelados na concessão; raridade derivada e recalculada pelo worker (ADR 0007)",
    "Ranking e raridade pré-calculados em tabela por worker com coalescência (ADR 0005)",
    "Fila de trabalhos numa tabela do Postgres com FOR UPDATE SKIP LOCKED, sem broker nem Redis (ADR 0008)",
    "Fotos nunca passam pela API: URL assinada, derivadas geradas no cliente, chave aleatória, CDN (ADRs 0002 e 0003)",
    "Autenticação própria com Argon2id e família de refresh rotativo (ADR 0006)",
    "Escopo de turma do professor sempre verificado no banco, nunca no token",
    "API versionada em /v1 com mudanças só aditivas e cliente TypeScript gerado do OpenAPI",
    "Faixa de pontos do tier repetida como check constraint no banco",
    "Modelagem do calendário em ano, semestre letivo e bimestre com fronteiras em America/Sao_Paulo",
    "Modo de demonstração por flag e lote com purga pela área da instituição",
    "Papel de instituição com área web própria (/instituicao) dentro do mesmo app",
    "Origem única com Caddy, duas réplicas de API sem estado, worker e migrator em contêineres separados"
  ],
  "nao_verificado": [
    "Se a solução compila e se as suítes de teste, inclusive a de arquitetura, passam",
    "Se as migrations aplicam e o seed popula corretamente o mundo de demonstração",
    "Comportamento do worker de ranking e raridade sob concorrência e se a coalescência funciona",
    "Escalabilidade real para o campus inteiro: só há cenário de carga reduzido (50 usuários virtuais), não executado nem lido nesta revisão",
    "Aderência visual das telas aos mockups e à especificação",
    "Ausência de regra de produto em todos os endpoints e telas: foi lida uma amostra (medalhas, ranking, mural, escopo de turma, cadastro)"
  ]
}
```
