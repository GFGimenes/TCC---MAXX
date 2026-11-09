# Inventário de cobertura: leigo (trilha iterativa)

Lista fixa do pré-registro (§8), igual para os quatro produtos. Estados: funcionando,
quebrado, parcial, simulado, ausente. Preenchido pelo autor em 08/11/2026 olhando o
produto no ar (`https://maxx-guilherme.azurewebsites.net`, commit `2a7dad5`) e o código.

| # | Item | Estado | Nota |
|---|---|---|---|
| 1 | Login só institucional | funcionando | por domínio de e-mail, sem verificação de posse |
| 2 | Feed com posts de foto, curtir e comentar | funcionando | |
| 3 | Perfil do aluno (foto, pontos, prêmios, posts) | parcial | foto, pontos, posição no ranking e posts; prêmios só como pontos e conquistas automáticas |
| 4 | Mural de avisos (faculdade, curso, professor) | parcial | um mural só para todos, sem distinção de faculdade, curso e professor |
| 5 | Tela de troféus e medalhas (ganhos e a ganhar) | funcionando | com conquistas automáticas e medalhas fixas no lugar dos troféus da ideia |
| 6 | Ranking geral e por curso | funcionando | só pelos pontos de atividade no app |
| 7 | Tipos de prêmio cadastrados pela instituição, com critérios | ausente | |
| 8 | Tiers e faixas de pontos; aluno sem tier | ausente | |
| 9 | Professor só premia aluno com quem tem aula | ausente | qualquer professor dá medalha a qualquer aluno |
| 10 | Progressão de pontos a partir de prêmios e medalhas | ausente | pontos vêm de post, curtida e comentário |
| 11 | Comprovação por foto, revisão e validação | parcial | a foto do post gera pontos, sem revisão nem validação; nada a ver com a comprovação da ideia |
| 12 | Contestação e revogação | ausente | |
| 13 | Ex-alunos | quebrado | qualquer um faz login sem distinção entre aluno atual e ex-aluno |
| 14 | Entrada da banca sem cadastro (demonstração) | implementado, desligado no ar | caixa "Banca do TCC" por código (`CODIGO_BANCA`); a variável não foi definida no deploy, a confirmar pelo autor |
| 15 | Instruções de execução no repositório e registro do que foi decidido e do que faltou | parcial | README com execução, demo, banca e deploy; sem registro de decisões nem do que faltou |

Fase alcançada: funcionalidade (todas as seis telas utilizáveis). Estado de execução:
instala, sobe, testes próprios passam (`npm test`), publicado; suíte de referência ainda
não executada. Alegações sem lastro observadas na última rodada: "apaguei o post de
teste" e "dados preservados após reinício", corrigidas na própria sessão depois de o
autor abrir o app (registro da rodada 7).
