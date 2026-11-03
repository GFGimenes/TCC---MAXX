ID: eng_02_dados-r5
Trilha: engenheiro
Tela: passo 2 (resposta 5 do autor: revisão da E4, migration do modelo acadêmico)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E3 commitada em `9357878` com os JSON formatados e `data/catalogo` no Prettier; três commits do passo verdes na CI.
- E4: migration `ModeloAcademico` com nove tabelas em snake_case, uma configuração por entidade, unicidades (sigla, ano, semestre, bimestre, matéria, turma, matrícula, vínculo, RA, e-mail), checks (intervalos, fim não antes do início, duração mínima, combinações de papéis, campos por papel), índices por turma; 161 testes, 15 de integração com Postgres real; migration aplicada pelo contêiner do compose.
- Mudanças no domínio sem mudar regra: construtores privados para o EF; coleções do calendário ordenadas na leitura.
- Cinco escolhas declaradas e aceitas: `citext` no e-mail; checks no banco repetindo invariantes (a que cruza tabelas fica só no domínio); `Set<T>` sem `DbSet` por consistência dos nomes de FK; `Restrict` entre agregados, cascata só dentro do calendário; testes conferindo o nome da constraint violada.
- Tropeço declarado: `dotnet ef migrations remove` tenta conectar ao banco; o agente apagou os arquivos e restaurou o snapshot pelo git.

---
E4 aprovada. As cinco escolhas ficam: citext no e-mail, checks no banco repetindo as invariantes exceto a que cruza tabelas, Set<T> sem DbSet, Restrict entre agregados e cascata só no calendário, teste conferindo o nome da constraint. Commita com a mensagem proposta, push, e segue para a E5; para para a minha revisão no fim dela.
