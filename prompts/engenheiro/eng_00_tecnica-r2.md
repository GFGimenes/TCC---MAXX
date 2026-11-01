ID: eng_00_tecnica-r2
Trilha: engenheiro
Tela: abertura (resposta 2 do autor: às consequências e às oito perguntas do plano do passo 0, fundação documental)
Data: 2026-11-01
Origem: decisões do autor, debatidas com o Cowork (Anthropic) em 01/11/2026 e redigidas pelo Cowork a partir das palavras do autor; o autor revisou.

Notas de registro:
- O agente devolveu o plano do passo 0 em seis etapas (produto.md, catálogo em três JSON, regras declarativas das conquistas, famílias de trilha, ADRs, plano mestre, CLAUDE.md), com três consequências das decisões da `tecnica-r1` (raridade vira estatística calculada; faixas de raridade colapsam com população pequena; oito superfícies sem desenho) e oito perguntas.
- Decisões próprias do autor: arroba único no formato @nomeSobrenome-SIGLA com sufixo do curso fixo, RA nunca exposto nem buscável, busca por nome e arroba com filtros de curso e semestre; raridade pelo campus ou pelo curso conforme o item; 150 alunos no seed (120 ativos, 30 ex-alunos); diagramas Mermaid nos ADRs e fluxos de sequência em docs/fluxos/. Demais: aceites da sugestão do agente.

---
Sobre as consequências: de acordo com as três. A raridade sai do catálogo e vira estatística calculada; o inventário das oito superfícies sem desenho entra em docs/.

Respostas às oito perguntas.

1. Denominador: a raridade é quantos ganharam em relação a quantos podiam ganhar. Item que todo mundo pode ganhar: raridade pelo campus, divisor igual a todos os alunos ativos. Item exclusivo de um curso: raridade pelo curso, divisor igual aos alunos ativos daquele curso. O texto exibido é "x% dos alunos".

2. Raridade não congela: é propriedade do item, sempre a atual, fonte única.

3. População do seed demo: 150 alunos, sendo 120 ativos distribuídos por vários semestres e 30 ex-alunos.

4. Existe arroba, único, no formato @primeiroNomeUltimoNome-SIGLA, com a sigla do curso atual sempre no fim (exemplo: @guilhermeGimenes-CC). O cadastro sugere a partir do nome; o aluno edita só a parte antes do hífen, no cadastro e depois no perfil; o sufixo muda sozinho se o aluno trocar de curso. Unicidade sem diferenciar maiúsculas; exibe como o aluno escreveu. Professor usa -PROF e instituição -UNIMAX. O RA é dado pessoal: fica como identidade interna e credencial de login, nunca aparece para outros alunos nem é buscável. Nome de exibição continua existindo e editável. A Busca procura por nome de exibição e por arroba, com filtros de curso e semestre.

5. Aceito a convenção: branch <tipo>/<assunto-em-kebab> com feat, fix, docs, chore, refactor, test, ci; commit convencional <tipo>(<escopo>): <assunto> com os escopos api, mobile, client, seed, infra, docs, design. O passo 0 fica na branch atual, rodada/eng_00; a partir do passo 1, as branches por tipo saem dela e voltam para ela por PR, e sou eu quem leva a rodada para a main.

6. Um commit por etapa, revisado por mim antes de cada um, e um PR para o passo 0 inteiro. Daqui em diante é sempre assim: commits por etapa, um PR por assunto.

7. Oito ADRs curtos, um arquivo cada, mais o índice. Cada um com a consequência negativa escrita.

8. Sim: quem recebe o link sem conta cai no login, e o link é um deep link /post/:id que abre o post depois do login.

9. Cada ADR traz, quando ajudar, um diagrama em Mermaid no próprio arquivo, e os fluxos principais (login, post com comprovação, concessão de medalha com recálculo de conquistas, contestação, ranking) viram diagramas de sequência em docs/fluxos/, previstos no plano mestre como entregável do passo 1.

Pode começar pela E0.1 e parar para a minha revisão.
