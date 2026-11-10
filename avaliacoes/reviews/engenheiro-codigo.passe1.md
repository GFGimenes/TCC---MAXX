# Review engenheiro, eixo 5. Código

- Status: ok
- Tentativa: 1
- Commit avaliado: 076549bbea15649813d347c2618a4b51377e6bdd (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 96ef4321-8e95-49a6-bcbf-e5103d3e053e

Texto do revisor, sem edição:

---
# Revisão do eixo 5 (Código): produto `engenheiro`, commit `076549bbea15`

**Não há resultado da suíte de testes de referência para este produto.** A nota vem só da leitura do código e dos testes do próprio produto. Não compilei, não executei nada e não rodei nenhum teste.

## Nota: 5

## Justificativa

**Regra de pontos e ranking corretos e testados**
- As faixas de tier estão num lugar só e batem com a especificação: Bronze 1–30, Prata 31–70, Ouro 71–100, Diamante 101–150 (`apps/api/src/Maxx.Domain/Catalogo/Tier.cs:21-28`).
- Os testes cobrem as fronteiras que a suíte de referência pede, dos dois lados:
  - Recusados: 0/31, 30/71, 70/101, 100/151 (`apps/api/tests/Maxx.Domain.Tests/Catalogo/CatalogoValidatorTests.cs:65-77`).
  - Aceitos: 1/30, 31/70, 71/100, 101/150 (`CatalogoValidatorTests.cs:79-91`).
- O ranking ordena por pontos decrescentes. No empate, vem primeiro quem pontuou por último mais cedo; persistindo o empate, decide o id (`apps/api/src/Maxx.Domain/Ranking/Classificacao.cs:86-90`).
- `ClassificacaoTests.cs` testa soma, ordem, os dois desempates, ex-aluno só no histórico, troca de curso e aluno sem pontos fora da tabela.

**Entradas inválidas tratadas no domínio**
- A recusa volta como resultado tipado, não como exceção genérica (`Post.cs:282-306`, `Medalha.cs:208-218`).
- Legenda: aparada e limitada a 1000 caracteres, contando emoji como um (`Post.cs:201-212`). O endpoint ainda tem um teto bruto de 4000 (`PostEndpoints.cs:93`).
- Post vazio e post com mais de um prêmio são recusados (`Post.cs:113`, `Post.cs:157`).
- Upload de outra pessoa ou já usado é recusado (`Post.cs:214-224`).
- O validador de catálogo devolve todos os erros de uma vez e roda na CI (`CatalogoValidator.cs`, `ci.yml:38-41`).

**Testes amplos**
- Domínio: cerca de 40 arquivos de teste.
- Integração com Postgres real: cerca de 60 arquivos.
- Arquitetura: as dependências entre camadas viram teste (`LayerDependencyTests.cs`).
- App: testes Jest por tela.
- Ponta a ponta: Playwright sobre o docker compose.

**CI completa** (`.github/workflows/ci.yml`)
- Checagem de formatação, build com aviso virando erro e testes da API.
- Lint, typecheck e testes do app.
- Verificação de que o cliente gerado continua igual ao OpenAPI da API.
- Testes ponta a ponta e varredura de segredos e de pacotes vulneráveis.

**Padrões de projeto onde ajudam**
- Handlers na camada Application, com repositórios e unidade de trabalho atrás de interfaces.
- Entidades com construtor privado e fábrica estática que valida (`Medalha.Conceder`, `Post.Publicar`).
- Motor de conquistas declarativo, registrado no ADR 0004.
- Tratamento de corrida na concessão de medalha: índice único mais uma nova tentativa (`ConcederMedalhaHandler.cs:29-45`).
- O escopo do professor é checado antes da concessão (`ConcederMedalhaHandler.cs:51-63`).

**Dívidas encontradas, pequenas e que não derrubam a nota**
1. **Utilitário no lugar errado.** `ProfessorEndpoints.Nome<T>` (`apps/api/src/Maxx.Api/Medalhas/ProfessorEndpoints.cs:98`) converte enum para camelCase de forma genérica. Mesmo assim, é usado 22 vezes em 8 arquivos de outros módulos (Posts, Mural, Prêmios, Instituição…).
2. **Sobrecargas empilhadas.** `Post.Publicar` tem três sobrecargas encadeadas (`Post.cs:81-104`), cada uma acrescentando um parâmetro de prêmio. É resto de crescimento incremental.
3. **Duplicação no app.** `formatarNumero` existe em `apps/mobile/src/feed/textos.ts:5` e de novo em `apps/mobile/src/trofeus/montagem.ts:115`.
4. **Comentários longos que citam o histórico da construção.** São dezenas de arquivos com "passo 9", "passo 12" e "entraram como acréscimo" (ex.: `PostEndpoints.cs:88-91`). O código se lê bem sem eles, mas as referências a passos envelhecem mal.

Pelo que dá para verificar lendo, o produto cumpre o critério 5. A ressalva é que nada foi executado.

## Evidências

| Local | O que mostra |
|---|---|
| `apps/api/src/Maxx.Domain/Catalogo/Tier.cs:21-28` | Faixas de tier corretas, num lugar só |
| `apps/api/tests/Maxx.Domain.Tests/Catalogo/CatalogoValidatorTests.cs:65-91` | Testes das fronteiras 30/31, 70/71, 100/101, 150/151 e de 0 |
| `apps/api/src/Maxx.Domain/Ranking/Classificacao.cs:86-90` | Ordenação e desempate determinístico |
| `apps/api/tests/Maxx.Domain.Tests/Ranking/ClassificacaoTests.cs` | 10 testes de ordenação e das visões do ranking |
| `apps/api/src/Maxx.Domain/Social/Post.cs:113,157,201-224` | Validação de entradas inválidas no domínio |
| `apps/api/src/Maxx.Domain/Premios/Medalha.cs:119-172` | Regras da concessão: só professor concede, só aluno recebe, ex-aluno não pontua, vigência, curso e limite por período |
| `apps/api/src/Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:29-63` | Escopo do professor e tratamento de concessões simultâneas |
| `apps/api/tests/Maxx.Architecture.Tests/LayerDependencyTests.cs` | Camadas garantidas por teste |
| `.github/workflows/ci.yml` | A suíte roda na CI, junto com lint, formatação, e2e e segurança |
| `apps/api/src/Maxx.Api/Medalhas/ProfessorEndpoints.cs:98` | Utilitário genérico usado em 8 arquivos de outros módulos |
| `apps/mobile/src/feed/textos.ts:5` e `apps/mobile/src/trofeus/montagem.ts:115` | `formatarNumero` duplicado |
| `apps/api/src/Maxx.Domain/Social/Post.cs:81-104` | Três sobrecargas encadeadas de `Publicar` |

## Regras ausentes

- **Consulta do log de leitura do mural.** A leitura é gravada com instante (`Maxx.Domain/Mural/LeituraDeAviso.cs`), mas `AvisoEndpoints.cs` não tem rota para o professor ver quem leu e quando. Só existem `PUT .../leitura` e `POST /mural/leitura`.

## Decisões do agente (dentro do eixo Código)

- Resultados de recusa tipados (`ResultadoDaConcessao`, `ResultadoDaPublicacao`) no lugar de exceções para regras de negócio.
- Validador de catálogo com teste próprio na CI; catálogo tratado como dado (ADR 0004).
- Desempate do ranking pelo instante da última concessão e depois pelo id do aluno.
- Aluno sem pontos não aparece no ranking.
- Pontos e tier congelados na concessão (ADR 0007).
- Chave de deduplicação e limite de medalhas por período e matéria.
- Testes de arquitetura que garantem a dependência entre camadas.
- Testes de integração contra Postgres real e e2e com Playwright sobre o compose.
- Cliente TypeScript gerado do OpenAPI, com checagem de divergência na CI.
- Build com aviso virando erro, `dotnet format` e Prettier obrigatórios na CI.
- Tratamento de corrida na concessão via índice único e nova tentativa.
- Família de prêmios com pontos estritamente crescentes por passo, validada.
- Raridade ("encontrabilidade") calculada pelo percentual de alunos que têm o prêmio.

## Não verificado (só leitura)

- Se a solução .NET e o app Expo compilam.
- Se as suítes de domínio, integração, Jest e e2e passam.
- Se as versões de pacote declaradas existem (Expo ~58, React Native 0.88.1, TypeScript ~6.0, actions `@v7`).
- Se a CI está verde no commit avaliado.
- O comportamento em tempo de execução das recusas como respostas HTTP (ProblemDetails).

```json
{
  "nota": 5,
  "justificativa": "Não há resultado da suíte de testes de referência; a nota vem só da leitura. As faixas de tier estão corretas e num lugar só (Tier.cs:21-28), com testes dos dois lados de todas as fronteiras de referência (30/31, 70/71, 100/101, 150/151, além de 0). O ranking ordena por pontos com desempate determinístico e é coberto por 10 testes de domínio. Entradas inválidas são recusadas no domínio com resultados tipados (legenda longa, post vazio, mais de um prêmio, upload alheio ou já usado, medalha fora de escopo, de vigência ou do limite). Há testes amplos de domínio, de integração com Postgres real, de arquitetura, do app (Jest) e e2e (Playwright), todos rodando na CI com formatação e aviso virando erro. Padrões usados onde ajudam: handlers, repositórios, fábricas que validam, motor de conquistas declarativo, tratamento de concessões simultâneas. Dívidas pequenas: utilitário genérico ProfessorEndpoints.Nome usado em 8 arquivos de outros módulos, três sobrecargas encadeadas de Post.Publicar, formatarNumero duplicado no app e comentários longos que citam 'passo N' da construção.",
  "evidencias": [
    {"local": "apps/api/src/Maxx.Domain/Catalogo/Tier.cs:21-28", "descricao": "Faixas Bronze 1-30, Prata 31-70, Ouro 71-100, Diamante 101-150, centralizadas"},
    {"local": "apps/api/tests/Maxx.Domain.Tests/Catalogo/CatalogoValidatorTests.cs:65-91", "descricao": "Testes de fronteira recusando 0/31/30/71/70/101/100/151 e aceitando 1/30/31/70/71/100/101/150"},
    {"local": "apps/api/src/Maxx.Domain/Ranking/Classificacao.cs:86-90", "descricao": "Ordenação por pontos desc, depois última concessão asc, depois id"},
    {"local": "apps/api/tests/Maxx.Domain.Tests/Ranking/ClassificacaoTests.cs", "descricao": "10 testes de soma, ordem, desempates, ex-aluno, troca de curso e aluno sem pontos"},
    {"local": "apps/api/src/Maxx.Domain/Social/Post.cs:113,157,201-224", "descricao": "Validação de entrada no domínio: mais de um prêmio, post vazio, legenda > 1000 caracteres, upload alheio ou já usado"},
    {"local": "apps/api/src/Maxx.Domain/Premios/Medalha.cs:119-172", "descricao": "Regras da concessão: só professor concede, só aluno recebe, ex-aluno não pontua, vigência, restrição de curso, limite por período"},
    {"local": "apps/api/src/Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:29-63", "descricao": "Escopo professor/turma/aluno checado e corrida de concessões tratada por índice único e nova tentativa"},
    {"local": "apps/api/tests/Maxx.Architecture.Tests/LayerDependencyTests.cs", "descricao": "Dependências entre camadas garantidas por teste"},
    {"local": ".github/workflows/ci.yml:15-180", "descricao": "CI roda testes da API, testes do app, verificação do cliente OpenAPI, e2e e varreduras de segurança"},
    {"local": "apps/api/src/Maxx.Api/Medalhas/ProfessorEndpoints.cs:98", "descricao": "Utilitário genérico de enum para camelCase no lugar errado, usado 22 vezes em 8 arquivos de outros módulos"},
    {"local": "apps/api/src/Maxx.Domain/Social/Post.cs:81-104", "descricao": "Três sobrecargas encadeadas de Publicar acumuladas ao longo da construção"},
    {"local": "apps/mobile/src/trofeus/montagem.ts:115", "descricao": "formatarNumero duplicado de apps/mobile/src/feed/textos.ts:5"},
    {"local": "apps/api/src/Maxx.Api/Posts/PostEndpoints.cs:88-91", "descricao": "Exemplo de comentário que cita passos do histórico da construção ('passo 9', 'passo 12', 'acréscimo')"}
  ],
  "regras_ausentes": [
    "Consulta do log de leitura do mural pelo professor (quem leu e quando): a leitura é gravada em LeituraDeAviso, mas AvisoEndpoints.cs não expõe rota de consulta"
  ],
  "decisoes_do_agente": [
    "Resultados de recusa tipados (ResultadoDaConcessao, ResultadoDaPublicacao) no lugar de exceções para regras de negócio",
    "Validador de catálogo com passo próprio na CI; catálogo de prêmios como dado e motor de conquistas declarativo (ADR 0004)",
    "Desempate do ranking pelo instante da última concessão e depois pelo id do aluno",
    "Aluno sem pontos fica fora do ranking",
    "Pontos e tier congelados no momento da concessão (ADR 0007)",
    "Chave de deduplicação e limite de medalhas por período e matéria",
    "Testes de arquitetura garantindo a dependência entre camadas",
    "Testes de integração contra Postgres real e e2e Playwright sobre o docker compose",
    "Cliente TypeScript gerado do OpenAPI, com checagem de divergência na CI",
    "Build com aviso virando erro, dotnet format e Prettier obrigatórios na CI",
    "Concessões simultâneas de medalha tratadas por índice único e nova tentativa",
    "Família de prêmios com pontos estritamente crescentes por passo, validada",
    "Raridade (encontrabilidade) calculada pelo percentual de alunos que têm o prêmio"
  ],
  "nao_verificado": [
    "Se a solução .NET e o app Expo compilam",
    "Se as suítes de domínio, integração, Jest e e2e passam",
    "Suíte de testes de referência: não há resultado para este produto",
    "Se as versões de pacote declaradas existem (Expo ~58, React Native 0.88.1, TypeScript ~6.0, GitHub Actions @v7)",
    "Se a CI está verde no commit avaliado",
    "O comportamento em tempo de execução das recusas como respostas HTTP"
  ]
}
```
