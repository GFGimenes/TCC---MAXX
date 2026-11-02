ID: eng_01_fundacao-r3
Trilha: engenheiro
Tela: passo 1 (resposta 3 do autor: revisão da etapa 2, banco e migração)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisões do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Entrega: `MaxxDbContext` com snake_case, tabela de histórico `__ef_migrations_history`, migration `Inicial`, `DatabaseMigrator` com `pg_advisory_lock`, subcomando `migrate` do `Maxx.Api`, `/api/ready` checando migrations pendentes via `to_regclass`, `dotnet-ef` como ferramenta local.
- Quatro correções feitas pelo agente durante a etapa e aceitas, inclusive `MSBuildTreatWarningsAsErrors` (o `TreatWarningsAsErrors` sozinho não cobria avisos do MSBuild) e a checagem com `to_regclass`.

---
Etapa 2 aprovada. As quatro correções ficam como estão, inclusive MSBuildTreatWarningsAsErrors e a checagem com to_regclass; registra no plano do passo 2 a remoção do ignore-exit-code, como anotado. Commita com a mensagem proposta, push, e segue para a etapa 3; para para a minha revisão no fim dela.
