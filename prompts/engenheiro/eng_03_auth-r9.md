ID: eng_03_auth-r9
Trilha: engenheiro
Tela: passo 3 (resposta 9 do autor: revisão da E8, papéis, escopo de turma no banco e contas do seed)
Data: 2026-11-04
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E7 commitada em `95b942e`.
- E8: policies por papel; grupo `/v1` com `RequireAuthorization` e `/v1/auth` anônimo, com teste que lista todas as rotas de `/v1` e confere que as anônimas são exatamente as seis de entrada; `IEscopoDeTurma.ProfessorLecionaAsync` em uma consulta, só semestre vigente pela data de São Paulo; `/v1/eu` lendo do banco com arroba; seed demo criando contas sem senha para professores e instituição. 412 testes, 14 novos; fumaça pelo Caddy.
- Ambiente: o Docker Desktop reiniciou durante a primeira rodada de testes e derrubou o Postgres do compose; segunda rodada inteira; o agente recriou o contêiner do Caddy. Declarado.
- Três desvios aceitos (rotas de teste no host de teste porque as rotas reais só chegam nos passos 6 e 12; calendário em volta da data real nos testes de escopo; repositório em memória em dois testes da E5). Três decisões aceitas; a primeira registra que a `FallbackPolicy` fazia rota inexistente responder 401, quebrando a regra do 404 da demonstração desligada.
- Entrega de novo com a primeira frase em inglês.

---
E8 aprovada. Os três desvios ficam: rotas só no host de teste, calendário em volta da data real nos testes de escopo, repositório em memória nos dois testes da E5. As três decisões aceitas: exigência de login no grupo /v1 e não em FallbackPolicy, /v1/eu lendo do banco, seed criando conta para toda linha de professor e instituição. Commita com a mensagem proposta, push, e segue para a E9; para para a minha revisão no fim dela.

Nota posterior (E9, 04/11): o disco C: do computador do autor chegou a 0 GB livres durante a E9. O agente parou antes de fechar a etapa, sem commit, diagnosticou (falhas em suítes não tocadas, `npm run gerar` sem gravar, `git` sem conseguir criar `index.lock`, `dotnet format` removendo um `using` necessário e `git checkout` falhando ao restaurar), apontou que o disco virtual do Docker tem 11,4 GB e que o restante é da máquina, e não liberou nada sozinho porque as imagens podem ser de outros projetos. O autor liberou espaço fora do experimento e mandou uma mensagem curta de retomada (não contada como prompt numerado). O reinício do Docker Desktop na E8 teve provavelmente a mesma causa.
