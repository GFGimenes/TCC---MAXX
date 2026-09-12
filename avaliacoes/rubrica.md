# Rubrica de Avaliação (Agent Review)

Rubrica única, aplicada da mesma forma para qualquer combinação de agente (Claude /
Codex), persona (leigo / engenheiro) e qualidade de prompt (bom / ruim). O objetivo é
tornar a comparação justa: mesma régua para todo mundo.

Escala por eixo: **1 (crítico) a 5 (excelente)**. Pontuação total possível: 25 (soma dos
5 eixos). Registre a pontuação e as observações na planilha
`avaliacoes/registro-avaliacoes.xlsx`.

## 1. Arquitetura

| Nota | Critério |
|---|---|
| 1 | Sem separação de camadas; decisões incompatíveis com a stack definida no contexto do projeto; não escala nem para o MVP. |
| 2 | Estrutura confusa; mistura responsabilidades (ex.: lógica de negócio no componente de UI); pouca reutilização. |
| 3 | Separação básica de camadas (frontend/backend/dados), mas com acoplamentos evitáveis ou decisões não justificadas. |
| 4 | Arquitetura coerente com o restante do projeto, camadas bem definidas, decisões justificadas mesmo que melhoráveis. |
| 5 | Arquitetura coerente, justificada, alinhada ao contexto comum (seção 3.1 do TCC) e preparada para crescer (novas telas/features sem retrabalho). |

## 2. Segurança

| Nota | Critério |
|---|---|
| 1 | Segredos/credenciais expostos no código; sem validação de entrada; vulnerabilidade óbvia e explorável (ex.: injeção, RA de outro aluno alterável via request). |
| 2 | Validação de entrada incompleta; controle de acesso frágil (ex.: aluno consegue chamar rota de professor). |
| 3 | Validações básicas presentes, mas faltam casos de borda (ex.: não trata prova de foto adulterada/duplicada, não valida quem pode dar medalha a quem). |
| 4 | Validação de entrada e autorização consistentes; poucos pontos a reforçar. |
| 5 | Trata dados sensíveis (RA, fotos-prova, notas) corretamente, valida entradas, aplica o princípio do menor privilégio (aluno x professor) e não expõe segredos. |
| — | Referência: restrições de segurança definidas no contexto comum do projeto (seção 3.1, item "e"). |

## 3. Código

| Nota | Critério |
|---|---|
| 1 | Não compila/roda; lógica claramente errada (ex.: fronteiras de tier erradas). |
| 2 | Roda, mas falha em testes unitários básicos de fronteira (ex.: `calcularTierAluno` não trata 999 vs 1000). |
| 3 | Passa nos testes de fronteira, mas não trata entradas inválidas (null, tipos errados) como no exemplo de teste da seção 3.2. |
| 4 | Passa nos testes de fronteira e de entrada inválida; segue as convenções de nomenclatura/organização do contexto comum. |
| 5 | Idem ao 4, e sem sinais de alucinação (função/API inexistente, import que não existe, lógica plausível mas incorreta). |
| — | Critério objetivo: rodar a suíte de testes unitários da fase 7 antes de pontuar este eixo. |

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
| 4 | Segue convenções do contexto comum (nomenclatura, pastas), com testes cobrindo a lógica de negócio. |
| 5 | Idem ao 4, e o próximo prompt/sessão (mesma IA ou outra) consegue evoluir o código sem reintroduzir os mesmos erros. |

## Como preencher

1. Rode o prompt no agente, salve a resposta em `resultados/<agente>/<persona>/`.
2. Rode os testes unitários relevantes (fase 7 da linha do tempo).
3. Pontue os 5 eixos usando esta rubrica.
4. Registre a linha em `avaliacoes/registro-avaliacoes.xlsx` (aba "Registro"), com
   observações objetivas (o que especificamente motivou a nota, não impressão geral).
5. Vulnerabilidades de segurança encontradas devem ser descritas o suficiente para
   reprodução — isso vira evidência para a seção de Análise Comparativa do TCC.
