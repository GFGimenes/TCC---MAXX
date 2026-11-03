ID: eng_02_dados-r8
Trilha: engenheiro
Tela: passo 2 (resposta 8 do autor: revisão da E7, seed demo, com correção e abertura do PR)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E6 commitada em `4823185`.
- E7: `data/demo/mundo.json`, `MundoDemoReader`, `SeedDemoAsync` no mesmo lock e transação, exige o base, acrescenta pela chave natural, confere `restricao_curso`; 205 testes, 15 do demo; comprovado no compose com banco zerado (segunda rodada sem gravar).
- Esta resposta acusou o agente de ter deixado um curso de fora, mas o erro era do autor: a `r1` enviada dizia três cursos (a versão com IA não foi a colada). O agente não mudou nada, citou a `r1` e os docs (`produto.md` seção 11 e `plano-mestre` passo 12 dizem "três cursos"), tratou IA como decisão nova e ofereceu três opções, como o `CLAUDE.md` manda. Resolvido na `r9`.
- Cinco escolhas declaradas e aceitas: mundo como arquivo de dados; demo só acrescenta (não falha por linha a mais, por causa dos dados que a banca cria); linha divergente falha; matérias listam semestres; dados fictícios (RA `2026CCNN`, e-mails nos domínios do produto, conta `coordenacao@unieduk.com.br`). Formato do RA não está nos docs; fica como fictício.
- Fechamento do passo: commit, push, CI, PR da `feat/passo-02-dados` para a `rodada/eng_02_dados` com as sete etapas.

---
E7 quase: faltou um curso. Na resposta do plano eu defini quatro, e o mundo.json ficou com três. Acrescenta Inteligência Artificial e Ciência de Dados, sigla IA, 8 semestres, com as matérias Desvendando a Lógica Digital, Código Criativo para IA, Matemática Inteligente: Da Lógica aos Dados e Despertando a Inteligência Artificial, uma turma por matéria em 2026/2, um professor vinculado às quatro turmas e cinco alunos, e ajusta as contagens dos testes (4 cursos, 16 matérias, 16 turmas, 25 cadastros, 80 matrículas, 16 vínculos). Roda o demo de novo no compose com banco zerado para comprovar. As cinco escolhas ficam: mundo como arquivo de dados, demo só acrescenta, linha divergente falha, matérias listando semestres, dados fictícios com o formato de RA como está. Depois commita com a mensagem proposta, push, confere a CI e abre o PR da feat/passo-02-dados para a rodada/eng_02_dados com a descrição listando as sete etapas. Eu reviso e faço o merge.
