ID: eng_02_dados-r1
Trilha: engenheiro
Tela: passo 2 (resposta 1 do autor: aprovação do plano de sete etapas e nove decisões pedidas pelo agente)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisões do autor (cursos e calendário dados por ele; o Cowork conferiu os cursos no site da UniMAX e propôs datas e matérias, aprovadas); redigida pelo Cowork, o autor revisou.

Notas de registro:
- O agente leu plano mestre, produto, regras de conquista, ADRs, os quatro JSON do catálogo e o código do passo 1, propôs sete etapas (domínio acadêmico e calendário com TDD; catálogo e validador; leitura dos JSON e validação na CI; migration acadêmica; migration do catálogo; seeder base; seeder demo) e nove perguntas, recusando-se a inventar as datas do calendário.
- Calendário: a UniMAX não publica o calendário 2026 em página aberta. As datas são aproximadas, declaradas pelo autor (últimos dias de janeiro a primeiros de dezembro), e ficam assim registradas no seed.
- Cursos conferidos em unimax.edu.br em 02/11: Ciência da Computação (8 semestres, noturno), Administração (8, noturno), Medicina (12, integral). Medicina com 12 semestres fez a duração virar campo de Curso em vez do limite fixo de 8 que o agente propôs.
- Matérias plausíveis, escolhidas pelo Cowork e aprovadas pelo autor (Medicina pelas disciplinas citadas na página do curso).
- Registro de erro do lado do autor: o Cowork preparou uma segunda versão desta resposta com um quarto curso (Inteligência Artificial e Ciência de Dados, IA, conferido no site), pedida pelo autor, mas o texto colado na sessão foi a primeira versão, com três cursos. O quarto curso entrou na `r8` e na `r9` como decisão nova, com ajuste dos docs. O texto abaixo é o que foi enviado.
- Demais decisões seguem a recomendação do agente: matrícula e vínculo no cadastro elegível; uma tabela de catálogo com tipo e regra em jsonb; versão por item e retirada por vigência; base só estrutura; flag de demonstração no passo 5; seed base automático no compose e demo manual; remoção da nota desatualizada dos JSON.

---
Plano do passo 2 aprovado como está, sete etapas, um PR da feat/passo-02-dados para a rodada/eng_02_dados. Respostas:

1. Calendário 2026. A UniMax não publica o calendário em página aberta, então as datas abaixo são aproximadas, declaradas por mim, e ficam registradas assim no seed, com comentário dizendo que podem ser corrigidas por seed sem mudar código. 2026/1: bimestre 1 de 26/01 a 03/04, bimestre 2 de 06/04 a 27/06. 2026/2: bimestre 3 de 27/07 a 26/09, bimestre 4 de 28/09 a 05/12. Recesso em julho e de dezembro a janeiro.

2. Matrícula e vínculo apontam para o CadastroElegivel, e o Usuario do passo 3 se liga a ele um para um. O cadastro elegível guarda papel, nome completo, semestre e RA opcional para quem não é aluno. O semestre do aluno vai de 1 até a duração do curso, que passa a ser um campo de Curso: CC e ADM têm 8 semestres, Medicina tem 12.

3. Uma tabela item_catalogo com coluna de tipo, campos comuns em colunas, específicos opcionais, regra em jsonb.

4. Versão por item sobe quando o conteúdo muda; item que sumiu do JSON faz o seeder falhar; retirada é por vigencia.fim.

5. Base só estrutura (catálogo e calendário); demo o mundo fictício; domínios de e-mail no passo 3.

6. Três cursos reais da UniMax: Ciência da Computação (CC, 8 semestres), Administração (ADM, 8 semestres) e Medicina (MED, 12 semestres). Matérias, quatro por curso: CC: Algoritmos e Programação, Estruturas de Dados, Banco de Dados, Engenharia de Software. ADM: Teoria Geral da Administração, Contabilidade Gerencial, Marketing, Gestão de Pessoas. MED: Anatomia, Fisiologia, Bioquímica, Histologia. Uma turma por matéria em 2026/2, um professor por curso, uma conta de instituição, cinco alunos por curso. O seed completo de 150 fica no passo 12.

7. Flag e lote de demonstração no passo 5, migration aditiva.

8. Serviço seeder no compose rodando seed base depois do migrator e antes das réplicas; seed demo à mão.

9. Pode tirar a frase da observacao nos três JSON na E3.

Começa pela E1 e para para a minha revisão no fim dela.
