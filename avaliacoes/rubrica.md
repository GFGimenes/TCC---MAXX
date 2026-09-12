# Rubrica de Avaliação (Agent Review)

Rubrica única, aplicada da mesma forma às duas trilhas (leigo / engenheiro), pelo
mesmo revisor (mesmo modelo, mesmo prompt). O objetivo é tornar a comparação justa:
mesma régua para todo mundo.

Escala por eixo: **1 (crítico) a 5 (excelente)**. Pontuação total possível: 25 (soma dos
5 eixos). Registre a pontuação e as observações na planilha
`avaliacoes/registro-avaliacoes.xlsx`.

## 1. Arquitetura

| Nota | Critério |
|---|---|
| 1 | Sem separação de camadas; decisões incoerentes com a stack que a própria trilha escolheu (ex.: mistura de frameworks concorrentes, dependência que não é usada); não escala nem para o MVP. |
| 2 | Estrutura confusa; mistura responsabilidades (ex.: lógica de negócio no componente de UI); pouca reutilização. |
| 3 | Separação básica de camadas (frontend/backend/dados), mas com acoplamentos evitáveis ou decisões não justificadas. |
| 4 | Arquitetura coerente com o restante da trilha, camadas bem definidas, decisões justificadas mesmo que melhoráveis. |
| 5 | Arquitetura coerente, justificada, adequada ao produto descrito no contexto comum (app para celular, muitos alunos, fotos) e preparada para crescer (novas telas/features sem retrabalho). |
| — | Nota: o contexto comum não fixa stack. A stack é decisão da trilha (explícita no prompt do engenheiro, delegada à IA no caso do leigo) e a decisão em si é registrada como resultado, não pontuada aqui; o que se pontua é a coerência com ela. |

## 2. Segurança

| Nota | Critério |
|---|---|
| 1 | Segredos/credenciais expostos no código; sem validação de entrada; vulnerabilidade óbvia e explorável (ex.: injeção, RA de outro aluno alterável via request). |
| 2 | Validação de entrada incompleta; controle de acesso frágil (ex.: aluno consegue chamar rota de professor). |
| 3 | Validações básicas presentes, mas faltam casos de borda (ex.: não trata prova de foto adulterada/duplicada, não valida quem pode dar medalha a quem). |
| 4 | Validação de entrada e autorização consistentes; poucos pontos a reforçar. |
| 5 | Trata dados sensíveis (RA, fotos-prova, notas) corretamente, valida entradas, aplica o princípio do menor privilégio (aluno x professor) e não expõe segredos. |
| — | Referência: o contexto comum não traz restrições de segurança de propósito; esta tabela é a referência. Dados sensíveis do Maxx: RA, e-mail, fotos-prova, notas e pontos. |

## 3. Código

| Nota | Critério |
|---|---|
| 1 | Não compila/roda; lógica claramente errada (ex.: faixas de pontos dos tiers erradas, ranking fora de ordem). |
| 2 | Roda, mas falha em testes unitários básicos de fronteira (ex.: aceita prêmio Bronze de 31 pontos, ou Diamante de 151; empata ranking de forma inconsistente). |
| 3 | Passa nos testes de fronteira, mas não trata entradas inválidas (null, tipos errados) como no exemplo de teste da seção 3.2. |
| 4 | Passa nos testes de fronteira e de entrada inválida; segue as convenções de nomenclatura/organização do contexto comum. |
| 5 | Idem ao 4, e sem sinais de alucinação (função/API inexistente, import que não existe, lógica plausível mas incorreta). |
| — | Critério objetivo: rodar a suíte de testes de referência da fase 7 antes de pontuar este eixo (fronteiras 30/31, 70/71, 100/101, 150/151 da pontuação por tier; entradas inválidas; ordenação do ranking). |

## 4. Experiência do Usuário (UX)

| Nota | Critério |
|---|---|
| 1 | Fluxo não corresponde ao que a tela pede (ex.: cadastro sem RA, feed sem ação de curtir/comentar). |
| 2 | Fluxo existe, mas com passos desnecessários ou estados de erro não tratados (loading, erro de rede, campo vazio). |
| 3 | Fluxo completo e utilizável, mas diverge de detalhes do desenho (ex.: navegação inferior sem o ícone de troféus). |
| 4 | Fiel ao desenho/telas de referência (login/cadastro, feed, dashboard, troféus, mural), com bons estados de erro/carregamento. |
| 5 | Idem ao 4, e resolve ambiguidades do desenho de forma sensata e consistente com o restante do app. |

## 5. Mantenabilidade

| Nota | Critério |
|---|---|
| 1 | Código não teria como ser retomado por outra pessoa (sem estrutura, nomes sem sentido, tudo hardcoded). |
| 2 | Dá para entender com esforço; poucos comentários onde seriam necessários (ex.: regra de pontuação dos tiers). |
| 3 | Organização e nomenclatura aceitáveis; falta cobertura de testes automatizados para lógica não trivial. |
| 4 | Convenções consistentes dentro da trilha (nomenclatura, pastas), com testes cobrindo a lógica de negócio. |
| 5 | Idem ao 4, e o próximo prompt/sessão (mesma IA ou outra) consegue evoluir o código sem reintroduzir os mesmos erros. |

## Como preencher

1. Rode o prompt na trilha, registre a rodada em `resultados/<trilha>/<id>.md`.
2. Rode os testes unitários relevantes (fase 7 da linha do tempo).
3. Pontue os 5 eixos usando esta rubrica.
4. Registre a linha em `avaliacoes/registro-avaliacoes.xlsx` (aba "Registro"), com
   observações objetivas (o que especificamente motivou a nota, não impressão geral).
5. Vulnerabilidades de segurança encontradas devem ser descritas o suficiente para
   reprodução — isso vira evidência para a seção de Análise Comparativa do TCC.
