# Review engenheiro, eixo 6. Projeto e arquitetura

- Status: a conferir (acessos fora das pastas liberadas: Grep: C:\Users\Guilherme Gimenes\.claude\projects\C--Users-Guilherme-Gimenes-AppData-Local-Temp-avaliador-tcc-engenheiro-076549bbea15-20261109-181205-139d-sessao-arquitetura-t1\cf5ef812-28d6-4686-88b1-9271a8b487e3\tool-results\toolu_01Sj3bcqRMdmbbd8cdmunWgP.txt)
- Tentativa: 1
- Commit avaliado: 076549bbea15649813d347c2618a4b51377e6bdd (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: cf5ef812-28d6-4686-88b1-9271a8b487e3

Texto do revisor, sem edição:

---
# Revisão: eixo 6, Projeto e arquitetura (produto `engenheiro`, commit `076549bb`)

## Nota: 5

**Resumo.** O backend tem quatro camadas: Domain, Application, Infrastructure e Api. As dependências entre elas são checadas por um teste. As regras de produto ficam no domínio e no catálogo versionado. As decisões estão justificadas em ADRs, com alternativas, pesos e consequências. A escalabilidade foi pensada para o campus todo: ranking pré-calculado por worker e fotos fora da API. O modelo de dados representa tiers, períodos e papéis sem gambiarra. Os desvios em relação à especificação estão documentados. Os pontos fracos são pequenos e não chegam a tirar a nota máxima.

## Justificativa

**Camadas.** `CLAUDE.md:67-74` declara: Api conhece Application, Application conhece Domain, Infrastructure implementa e Domain não conhece ninguém. Os `.csproj` seguem isso: Application referencia só Domain, e Infrastructure referencia Application e Domain. O teste `apps/api/tests/Maxx.Architecture.Tests/LayerDependencyTests.cs:10-40` garante a regra. Dentro da Application, o código é organizado em fatias por recurso (Medalhas, Mural, Ranking, PremiosParticipacao…).

**Regra num lugar só.** Um exemplo é a concessão de medalha:
- o endpoint (`Maxx.Api/Medalhas/ProfessorEndpoints.cs:81-90`) só extrai o `sub` do token e delega;
- o handler (`Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:51-54, 68-88`) confere no banco se o professor dá aula na turma, chama o domínio e enfileira notificação, conquistas e recálculo na mesma transação;
- o domínio (`Maxx.Domain/Premios/Medalha.cs:119-171`) decide tudo: só professor concede, só aluno recebe, ex-aluno não recebe, semestre e bimestre, vigência, restrição de curso e limite por período.

As faixas de tier existem num único ponto (`Maxx.Domain/Catalogo/Tier.cs:19-28`). O validador do catálogo reusa essas faixas (`CatalogoValidator.cs:88-91`). As conquistas são dados declarativos (`data/catalogo/conquistas.json`) lidos por um avaliador único (ADR 0004). Na prática, mudar o alvo de uma conquista é mexer numa linha de JSON.

**Modelo de dados.** Ele representa as regras do produto:
- `Tier` e `FaixaDePontos`;
- `Periodo` (bimestre, semestre, ano, curso) e `InstanciaDePeriodo`;
- `Papeis` como flags, para permitir professor e instituição na mesma conta;
- `Medalha`, `PremioParticipacao` e `Conquista` como tipos distintos;
- `Turma` e `Matricula`, que servem de base para "professor só pontua quem leciona";
- tier e pontos congelados na concessão (ADR 0007).

O ranking é uma função pura do domínio (`Maxx.Domain/Ranking/Classificacao.cs:36-90`), com quatro visões, desempate determinístico e ex-aluno só no histórico.

**Escalabilidade e decisões justificadas.**
- ADR 0005: ranking e raridade numa tabela escrita pelo worker, com coalescência, para um alvo de p95 de 300 ms com 3.200 alunos.
- ADR 0002: as fotos não passam pela API.
- ADR 0008: fila no Postgres com `SKIP LOCKED`.

Todos os ADRs trazem opções com peso e as consequências negativas.

**Preparado para novas telas.** O cliente Expo Router tem uma pasta por feature (`apps/mobile/src/{feed,mural,perfil,busca,...}`), cada uma com seu `api.ts`. O contrato com a API é gerado por OpenAPI (`packages/api-client`).

**Fidelidade ao pitch.** As seis telas existem: login, feed, perfil, mural, troféus e rankings, com as quatro visões de ranking. As regras centrais estão implementadas: tiers e faixas, professor dá só medalha e só a alunos das suas turmas, ex-aluno sem pontuar, log de leitura do mural (`Maxx.Domain/Mural/LeituraDeAviso.cs`), prova por foto com contestação e revogação.

**Pontos fracos (não mudam a nota):**
- O cliente repete a validação de formato de senha, arroba e nome (`apps/mobile/src/cadastro/regras.ts:1-2`). A duplicação é declarada: o comentário diz que quem decide é a API.
- A Api referencia a Infrastructure, mas só como ponto de registro das dependências (`Program.cs:21-24`).
- Os seeders são arquivos grandes (`DatabaseSeeder.Demo.cs`, com cerca de 600 linhas).
- Algumas regras da ideia foram reinterpretadas, e isso está documentado (ver "Regras ausentes").

## Evidências

| Local | O que mostra |
|---|---|
| `apps/api/tests/Maxx.Architecture.Tests/LayerDependencyTests.cs:10-40` | Teste que garante a direção das dependências entre camadas |
| `apps/api/src/Maxx.Domain/Catalogo/Tier.cs:19-28` | Faixas Bronze 1–30, Prata 31–70, Ouro 71–100, Diamante 101–150 num ponto único |
| `apps/api/src/Maxx.Domain/Premios/Medalha.cs:119-171` | Regras de concessão no domínio: papéis, ex-aluno, período, curso, limite |
| `apps/api/src/Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:51-54` | Escopo de turma conferido no banco, não lido do token |
| `apps/api/src/Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:84-88` | Medalha, notificação, reavaliação de conquistas e recálculo de ranking na mesma transação |
| `apps/api/src/Maxx.Api/Medalhas/ProfessorEndpoints.cs:81-90` | Endpoint fino, sem regra de negócio |
| `apps/api/src/Maxx.Domain/Ranking/Classificacao.cs:36-90` | Quatro visões e desempate como função pura do domínio |
| `apps/api/src/Maxx.Domain/Catalogo/CatalogoValidator.cs:88-91` | Validação do catálogo reusa as faixas de tier |
| `docs/decisoes/0004-motor-de-conquistas-declarativo.md` | Conquistas como dado declarativo, com alternativas e pesos |
| `docs/decisoes/0005-ranking-por-worker.md` | Escalabilidade do ranking pensada para 3.200 alunos e p95 de 300 ms |
| `apps/mobile/src/cadastro/regras.ts:1-2` | Duplicação declarada de validação de formato no cliente |
| `apps/mobile/src/mural/MuralScreen.tsx:29-35` | Chips Faculdade, Curso, Professores; "Professores" corresponde ao escopo turma |
| `docs/produto.md:266-268` | A regra de progressão para o tier acima foi substituída de propósito |

## Regras ausentes (sem efeito na nota)

1. **Progressão por repetição.** A ideia pedia que a mesma conquista repetida rendesse um prêmio do tier acima até o Diamante. Isso foi substituído por conquistas repetíveis por período e por trilhas de família (`docs/produto.md:266-268`).
2. **Denúncia de post pelo usuário.** Ficou para a fase 2. Só a instituição remove post, e só professor ou instituição contestam.
3. **Medalha a aluno orientado sem turma.** O escopo do professor é sempre a turma do semestre vigente.
4. **Perfil:** o "último troféu" em destaque e o "followed by xxxx e yyyy" não aparecem em `PerfilScreen.tsx`.
5. **Mural:** o comportamento de semi-colapso e de troca de foco ao clicar foi simplificado. O não lido aparece aberto e o lido recolhido; o aviso abre numa tela própria.
6. **Restrição por domínio de e-mail institucional.** A lista de domínios aceitos está pendente para o passo 13 (`docs/plano-mestre.md:355-357`). A identidade vem do cadastro elegível, não do domínio.

## Decisões que o agente tomou sem o prompt pedir

- Separar o backend em quatro projetos (Domain, Application, Infrastructure, Api), com fatias por recurso e teste automatizado de arquitetura.
- Separar Medalha, PremioParticipacao e Conquista no modelo, tratando "Troféu" só como rótulo de interface.
- Guardar as regras de conquista como dado declarativo no catálogo JSON, com um avaliador único (ADR 0004).
- Pré-calcular ranking e raridade numa tabela escrita por worker, com coalescência (ADR 0005).
- Usar fila em tabela do Postgres com `SKIP LOCKED`, sem broker (ADR 0008).
- Congelar tier, pontos e versão do item na concessão (ADR 0007).
- Calcular a raridade a partir da escassez, no lugar de "encontrabilidade" como campo do catálogo.
- Ligar o ranking ao semestre letivo, congelá-lo 30 dias depois do fim e desempatar pelo instante da última concessão.
- Criar o ciclo de vida do prêmio de participação, com janela de contestação de 15 dias e estado de averiguação.
- Gerar o contrato OpenAPI e o cliente TypeScript.
- Criar um modo de demonstração com flag, lote e purga.
- Montar uma área web da instituição dentro do mesmo app, em `/instituicao`.

## O que não pude verificar

Esta sessão só permite ler arquivos, então ficou de fora:
- se a solução compila e se os testes de arquitetura, domínio e integração passam;
- se o worker realmente recalcula ranking e raridade, e se a coalescência funciona em execução;
- se o desempenho bate o alvo de 2.000 usuários e p95 de 300 ms; o k6 ainda está pendente no passo 13;
- se as migrations aplicam e se o modelo físico confere com as entidades;
- se as telas correspondem aos mockups e pranchetas, que não foram abertos como imagem.

```json
{
  "nota": 5,
  "justificativa": "O backend tem quatro camadas (Domain, Application, Infrastructure, Api) e a direção das dependências é garantida por teste de arquitetura. As regras de produto ficam no domínio e no catálogo versionado: faixas de tier num ponto só, concessão de medalha com papéis, ex-aluno, período, curso e limite em Medalha.Conceder, e conquistas declarativas com avaliador único. Os endpoints são finos e os handlers orquestram. O modelo de dados representa tiers, períodos (bimestre, semestre, ano, curso), papéis em flags, turma e matrícula, e tier e pontos congelados na concessão. As decisões estão em ADRs com alternativas, pesos e consequências, e a escalabilidade foi pensada para o campus todo (ranking pré-calculado por worker, fotos fora da API, fila no Postgres). O produto cobre as seis telas e as regras centrais do pitch. Os pontos fracos são menores: validação de formato repetida no cliente (declarada), Api referenciando Infrastructure só para registrar dependências, seeders grandes e algumas regras da ideia reinterpretadas de forma documentada.",
  "evidencias": [
    {"local": "apps/api/tests/Maxx.Architecture.Tests/LayerDependencyTests.cs:10-40", "descricao": "Teste que garante a direção das dependências entre camadas"},
    {"local": "apps/api/src/Maxx.Domain/Catalogo/Tier.cs:19-28", "descricao": "Faixas Bronze 1-30, Prata 31-70, Ouro 71-100, Diamante 101-150 num ponto único"},
    {"local": "apps/api/src/Maxx.Domain/Premios/Medalha.cs:119-171", "descricao": "Regras de concessão no domínio: só professor concede, só aluno recebe, ex-aluno recusado, período, curso, limite por período"},
    {"local": "apps/api/src/Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:51-54", "descricao": "Escopo de turma do professor conferido no banco, não lido do token"},
    {"local": "apps/api/src/Maxx.Application/Medalhas/ConcederMedalhaHandler.cs:84-88", "descricao": "Medalha, notificação, reavaliação de conquistas e recálculo de ranking na mesma transação"},
    {"local": "apps/api/src/Maxx.Api/Medalhas/ProfessorEndpoints.cs:81-90", "descricao": "Endpoint fino, sem regra de negócio, delegando ao handler"},
    {"local": "apps/api/src/Maxx.Domain/Ranking/Classificacao.cs:36-90", "descricao": "Quatro visões de ranking e desempate determinístico como função pura do domínio"},
    {"local": "apps/api/src/Maxx.Domain/Catalogo/CatalogoValidator.cs:88-91", "descricao": "Validação do catálogo reusa as faixas de tier, sem duplicar"},
    {"local": "docs/decisoes/0004-motor-de-conquistas-declarativo.md", "descricao": "Conquistas como dado declarativo, com alternativas pesadas e consequências negativas"},
    {"local": "docs/decisoes/0005-ranking-por-worker.md", "descricao": "Escalabilidade do ranking pensada para 3.200 alunos e p95 de 300 ms, com tabela escrita por worker"},
    {"local": "apps/mobile/src/cadastro/regras.ts:1-2", "descricao": "Duplicação declarada de validação de formato no cliente; a API decide"},
    {"local": "apps/mobile/src/mural/MuralScreen.tsx:29-35", "descricao": "Chips Faculdade, Curso, Professores; Professores corresponde ao escopo turma"},
    {"local": "docs/produto.md:266-268", "descricao": "A regra de progressão para o tier acima foi substituída de propósito"}
  ],
  "regras_ausentes": [
    "Progressão: a mesma conquista repetida rende um prêmio do tier acima até o Diamante (substituída por conquistas repetíveis por período e trilhas de família)",
    "Denúncia de post pelo usuário (adiada para a fase 2; só a instituição remove e só professor ou instituição contestam)",
    "Professor dar medalha a aluno que orienta sem ter turma em comum (escopo sempre por turma)",
    "Perfil com o último troféu em destaque e com 'followed by xxxx e yyyy'",
    "Mural com semi-colapso do mais recente e troca de foco ao clicar (simplificado para não lido aberto e lido recolhido)",
    "Restrição de cadastro por domínio de e-mail institucional (lista de domínios pendente para o passo 13)"
  ],
  "decisoes_do_agente": [
    "Separar o backend em quatro projetos (Domain, Application, Infrastructure, Api), com fatias por recurso e teste automatizado de arquitetura",
    "Separar Medalha, PremioParticipacao e Conquista no modelo, com Troféu só como rótulo de interface",
    "Guardar as regras de conquista como dado declarativo em JSON, com avaliador único (ADR 0004)",
    "Pré-calcular ranking e raridade numa tabela escrita por worker, com coalescência (ADR 0005)",
    "Usar fila em tabela do Postgres com SKIP LOCKED, sem broker (ADR 0008)",
    "Congelar tier, pontos e versão do item na concessão (ADR 0007)",
    "Calcular a raridade a partir da escassez, no lugar de encontrabilidade como campo do catálogo",
    "Ligar o ranking ao semestre letivo, congelá-lo 30 dias depois do fim e desempatar pelo instante da última concessão",
    "Criar o ciclo de vida do prêmio de participação com janela de contestação de 15 dias e estado de averiguação",
    "Gerar o contrato OpenAPI e o cliente TypeScript",
    "Criar modo de demonstração com flag, lote e purga",
    "Montar a área web da instituição dentro do mesmo app, em /instituicao"
  ],
  "nao_verificado": [
    "Se a solução compila e se os testes de arquitetura, domínio e integração passam",
    "Se o worker recalcula ranking e raridade e se a coalescência funciona em execução",
    "Desempenho com 2.000 usuários e p95 de 300 ms (k6 pendente no passo 13)",
    "Se as migrations aplicam e se o modelo físico confere com as entidades",
    "Se as telas correspondem aos mockups e pranchetas (imagens não abertas)"
  ]
}
```
