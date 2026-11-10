# Inventário de cobertura: engenheiro (trilha iterativa)

Lista fixa do pré-registro (§8), igual para todos os produtos. Estados: funcionando,
quebrado, parcial, simulado, ausente. Preenchido pelo autor em 10/11/2026 olhando o
produto no ar (`https://app.maxx-unimax.com`, `main` em `8910b51`, imagem `sha-060f0b4`),
depois do ensaio remoto do passo 13, e o código.

| # | Item | Estado | Nota |
|---|---|---|---|
| 1 | Login só institucional | funcionando | cadastro só para RA elegível da base e domínio de e-mail da lista aceita; professor e instituição pelo primeiro acesso por e-mail |
| 2 | Feed com posts de foto, curtir e comentar | funcionando | conferido no ensaio, com a foto indo direto ao armazenamento |
| 3 | Perfil do aluno (foto, pontos, prêmios, posts) | funcionando | com posição no ranking e trilhas de prêmios |
| 4 | Mural de avisos (faculdade, curso, professor) | funcionando | três escopos; aviso de curso conferido no ensaio |
| 5 | Tela de troféus e medalhas (ganhos e a ganhar) | funcionando | |
| 6 | Ranking geral e por curso | funcionando | quatro visões (geral, curso, semestre, histórico), recalculadas pelo worker; posição nova em 2 s no ensaio |
| 7 | Tipos de prêmio cadastrados pela instituição, com critérios | parcial | catálogo com tipo, tier, pontos e critério existe e é o que os professores usam, mas é dado versionado em `data/catalogo/`, carregado pelo seed; não há tela de cadastro para a instituição (decisão registrada no produto.md 4.5) |
| 8 | Tiers e faixas de pontos; aluno sem tier | funcionando | Bronze 1 a 30, Prata 31 a 70, Ouro 71 a 100, Diamante 101 a 150, validados no domínio; o aluno tem soma de pontos e posição, sem tier |
| 9 | Professor só premia aluno com quem tem aula | funcionando | conferido no ensaio: professor de outro curso não enxerga o aluno |
| 10 | Progressão de pontos a partir de prêmios e medalhas | funcionando | pontos só de medalhas, prêmios de participação e conquistas |
| 11 | Comprovação por foto, revisão e validação | funcionando | reivindicação com foto, fila de comprovações e aprovação conferidas no ensaio |
| 12 | Contestação e revogação | funcionando | fila de contestações, confirmar e revogar com motivo, anulação pela área da instituição |
| 13 | Ex-alunos | funcionando | marcação pela instituição, sem volta; ex-aluno só no ranking histórico |
| 14 | Entrada da banca sem cadastro (demonstração) | funcionando | botão de demonstração ligado por flag, lote `banca-2026` no ar; purga por lote conferida no ensaio |
| 15 | Instruções de execução no repositório e registro do que foi decidido e do que faltou | funcionando | README, `docs/operacao.md`, oito ADRs, índice de decisões por passo e tabela de pendências fora da fase 1 no plano mestre |

Fase alcançada: endurecimento (produto publicado com HTTPS, backup, monitor de saúde e
ensaio remoto). Estado de execução: instala, sobe por compose, suíte própria passa na CI
(API 1.275 testes, app 523, e2e nos dois temas), publicado. Suíte de referência de caixa
preta não executada: o adaptador do engenheiro está desenhado e não implementado
(`avaliacoes/testes-referencia/adaptadores/engenheiro/README.md`); as fronteiras que ela
cobre (30/31, 70/71, 100/101, 150/151) estão nos testes de domínio do próprio produto
(`apps/api/tests/Maxx.Domain.Tests/Catalogo/CatalogoValidatorTests.cs`), que rodam na CI.
Alegações sem lastro observadas: nenhuma mantida; duas anotações erradas do próprio agente
no passo 13 (origem do pacote `maxx-api` e repetição do timeout do contêiner) foram
corrigidas por ele antes do commit.
