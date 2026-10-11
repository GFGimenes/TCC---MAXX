ID: eng_00_produto
Trilha: engenheiro
Tela: abertura (definição de produto; primeira de duas mensagens da mesma sessão, seguida de `eng_00_tecnica`)
Data: 2026-10-11
Origem: texto do autor, revisado no Cowork (Anthropic) em 11/10/2026

---
Gostaria de criar uma aplicação chamada Maxx dentro deste repositório. A aplicação é para a UniMax, instituição de ensino de Indaiatuba, interior de São Paulo (rede UniEduk, com a UniFaj). A ideia é um aplicativo de celular parecido com uma rede social, tipo Instagram mas sem stories, sem reels e sem mensagens entre usuários, com fortes elementos de gamificação: os alunos recebem prêmios e medalhas por participação em eventos e méritos em aula, e isso vira pontos, ranking e um feed onde eles mostram as conquistas. Nesta mensagem vai só o produto; a parte técnica vem na próxima.

Existem três tipos de usuário: aluno, professor e instituição (coordenação e secretaria). Ninguém de fora entra.
Aluno: tem RA, curso e semestre. Faz posts com foto, ganha prêmios por comparecer em eventos, palestras, fazer apresentações e outros itens definidos pela instituição, ganha medalhas, acumula pontos, aparece nos rankings, segue outros alunos para ver os posts deles e lê o mural de avisos.
Professor: vinculado às turmas em que dá aula. Dá medalhas só aos alunos com quem tem aula (por presença, notas, ajuda em sala e outros critérios definidos pela instituição), revisa os posts de comprovação de prêmio dos alunos dele e publica avisos para as turmas.
Instituição: cadastra os prêmios disponíveis e os critérios, concede troféus, valida comprovações, publica avisos da faculdade e do curso.

Login e cadastro somente com e-mail institucional ou RA (aluno por RA ou e-mail; professor por e-mail institucional). Sem login social. Ex-aluno mantém o acesso e a posição no ranking, mas não pontua mais.

Existem dois tipos de prêmio: troféus (concedidos pela instituição ou por regra automática, como assiduidade, participação em evento, acúmulo de medalhas) e medalhas (dadas por professores). Todo prêmio tem um tier, e o tier define os pontos: Bronze de 1 a 30, Prata de 31 a 70, Ouro de 71 a 100, Diamante de 101 a 150. O aluno não tem tier: a pontuação dele é a soma dos pontos dos prêmios, e o ranking é só a posição numérica.
Alguns prêmios têm progressão: a mesma conquista repetida (média 10 numa matéria em semestres diferentes, por exemplo) rende um prêmio novo, um tier acima do anterior, até o Diamante; o aluno guarda todos os prêmios da progressão.
Alguns prêmios exigem comprovação por foto, validada pela instituição ou pelo professor da turma. Um prêmio pode ser contestado por um professor das turmas do aluno (inclusive quem o concedeu) ou pela instituição, informando o motivo. A contestação vai para a instituição averiguar; enquanto isso o prêmio fica como "em averiguação", visível para o aluno, e deixa de pontuar. A instituição decide: confirma, e os pontos voltam, ou revoga, e o prêmio sai da pontuação mas fica no histórico com o motivo.

Sobre os rankings, terão quatro visões: ranking geral e ranking por curso, cada um do semestre atual e histórico (all time). Medalhas e prêmios contam pontos e os pontos definem a posição de cada aluno.

As telas serão: login e cadastro; feed (post com foto, ligado ou não a um prêmio); perfil do aluno (pontos, posição, prêmios); mural de avisos (faculdade, curso, professores); troféus e medalhas (o que já ganhou e o que ainda falta); rankings.

A primeira fase é o meu TCC, com uma apresentação para uma banca rotativa. Só nessa apresentação existe um login/registro de demo, ligado por configuração: quem entrar por ali cai num registro simples (foto opcional, nome e escolha de um dos três cursos de demonstração, já populados) e vira um aluno de demonstração, numa turma de demonstração desse curso, com tudo que um aluno tem. Se a pessoa voltar pelo mesmo dispositivo, pode entrar no usuário que criou ou criar um novo. Os dados da demo são semeados (os três cursos, turmas, prêmios, posts, ranking) e marcados para eu apagar depois. Esse modo não existe fora da apresentação.

A interface já está desenhada: as telas em claro e escuro, a paleta, a tipografia e as regras da identidade visual. Na próxima mensagem digo onde isso está no repositório, para você analisar antes de propor qualquer coisa.

Só confirme o entendimento e aponte o que estiver ambíguo, contraditório ou faltando. Nada de código, nada de proposta técnica ainda.
