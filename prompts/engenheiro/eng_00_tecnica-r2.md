ID: eng_00_tecnica-r2
Trilha: engenheiro
Tela: abertura (resposta 2 do autor: às consequências e às oito perguntas do plano do passo 0, fundação documental)
Data: 2026-11-01
Origem: decisões do autor, debatidas com o Cowork (Anthropic) em 01/11/2026 e redigidas pelo Cowork a partir das palavras do autor; o autor revisou.

Notas de registro:
- O agente devolveu o plano do passo 0 em seis etapas (produto.md, catálogo em três JSON, regras declarativas das conquistas, famílias de trilha, ADRs, plano mestre, CLAUDE.md), com três consequências das decisões da `tecnica-r1` (raridade vira estatística calculada; faixas de raridade colapsam com população pequena; oito superfícies sem desenho) e oito perguntas.
- Decisões próprias do autor: arroba único escolhido pelo usuário, RA nunca exposto nem buscável, busca por nome e arroba com filtros de curso e semestre; 150 alunos no seed (120 ativos, 30 ex-alunos). Demais: aceites da sugestão do agente.

---
Sobre as consequências: de acordo com as três. A raridade sai do catálogo e vira estatística calculada; o inventário das oito superfícies sem desenho entra em docs/.

Respostas às oito perguntas.

1. Denominador: aceito a sugestão. Alunos ativos elegíveis ao item (do curso, quando o item é restrito a curso), e o texto exibido é "x% dos alunos que podem ganhar".

2. Raridade não congela: é propriedade do item, sempre a atual, fonte única.

3. População do seed demo: 150 alunos, sendo 120 ativos distribuídos por vários semestres e 30 ex-alunos.

4. Existe arroba. O RA é dado pessoal: fica como identidade interna e credencial de login, nunca aparece para outros alunos nem é buscável. No cadastro o aluno escolhe um arroba único (sugerido a partir do nome), que aparece no cabeçalho do post e no perfil, como no Instagram; nome de exibição continua existindo e editável. A Busca procura por nome de exibição e por arroba, com filtros de curso e semestre. Professor também tem arroba.

5. Aceito a convenção: branch <tipo>/<assunto-em-kebab> com feat, fix, docs, chore, refactor, test, ci; commit convencional <tipo>(<escopo>): <assunto> com os escopos api, mobile, client, seed, infra, docs, design. O passo 0 fica na branch atual, rodada/eng_00; a partir do passo 1, as branches por tipo saem dela e voltam para ela por PR, e sou eu quem leva a rodada para a main.

6. Um commit por etapa, revisado por mim antes de cada um, e um PR para o passo 0 inteiro. Daqui em diante é sempre assim: commits por etapa, um PR por assunto.

7. Oito ADRs curtos, um arquivo cada, mais o índice. Cada um com a consequência negativa escrita.

8. Sim: quem recebe o link sem conta cai no login, e o link é um deep link /post/:id que abre o post depois do login.

Pode começar pela E0.1 e parar para a minha revisão.
