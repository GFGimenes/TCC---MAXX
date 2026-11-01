# Rubrica de avaliação

Rubrica única, aplicada da mesma forma aos quatro produtos do experimento (trilha leiga,
trilha do engenheiro, e o prompt único de cada persona), pelo mesmo revisor de IA
(mesmo modelo, mesma versão, mesmo prompt por eixo) e validada pelo autor. Mesma régua
para todo mundo.

**Quando se avalia.** Uma vez por produto, sobre o estado final do repositório (a `main`
da trilha, ou a branch da condição de prompt único), depois que as seis telas e o
deploy existirem, ou quando a trilha parar. Não há mais avaliação por rodada: por
rodada ficam só o registro da sessão (export, transcrição, decisões do agente, turnos,
tempo). Decidido em 01/11/2026; antes, Código e Segurança eram avaliados por rodada e
os demais eixos em milestones.

**Seis eixos, seis revisores.** Cada eixo tem o próprio prompt de revisor, rodado numa
sessão nova do Claude Code na pasta do repositório avaliado, sem acesso ao review dos
outros eixos. O autor avalia os mesmos seis eixos de forma independente, sem ver a nota
do revisor, e só depois as duas notas são postas lado a lado na planilha
`avaliacoes/registro-avaliacoes.xlsx`. A divergência entre as duas é resultado.

**Escala.** 1 (crítico) a 5 (excelente) por eixo; total possível 30.

**Regra ausente.** Quando o produto não implementa uma regra da ideia (não tem tiers,
não restringe quem dá medalha, não tem ranking por curso), o critério correspondente é
marcado como **ausente**, não como errado: a nota do eixo é calculada sobre o que
existe, e a ausência vai para a planilha e para a análise como resultado (regra nunca
pedida pela persona e nunca oferecida pelo agente). Os testes de referência de fronteira
de pontos aplicam-se à regra de pontos que o produto tiver; sem regra de pontos, o teste
é "ausente". Decidido em 11/10/2026.

**Decisões do agente.** Em todos os eixos o revisor lista, além da nota, as decisões que
o agente tomou sem o prompt pedir dentro daquele eixo. Elas não entram na nota; entram na
tabela de decisões do agente por trilha.

---

## 1. Experiência do usuário

Usabilidade, facilidade de navegação, clareza dos fluxos, estados de erro e de
carregamento, coerência visual. Referência funcional para as duas trilhas:
`docs/especificacao-telas.md` (as seis telas). Os mockups do engenheiro são referência
adicional só na trilha dele.

| Nota | Critério |
|---|---|
| 1 | Fluxos principais não funcionam ou não correspondem às telas pedidas (login sem RA, feed sem curtir ou comentar, ranking inexistente). |
| 2 | Fluxos existem, mas com passos desnecessários, navegação confusa ou estados de erro e carregamento não tratados. |
| 3 | As seis telas são utilizáveis de ponta a ponta; divergências de detalhe e inconsistências visuais entre telas. |
| 4 | Navegação clara, estados tratados, consistência visual; fiel à especificação (e, no engenheiro, aos mockups). |
| 5 | Idem ao 4, e resolve o que a especificação não diz de forma sensata e consistente; um membro da banca usa sem explicação. |

## 2. Segurança

Brechas, falhas, bugs exploráveis, exposição de dados sensíveis (RA, e-mail, fotos,
notas e pontos), autenticação e autorização.

| Nota | Critério |
|---|---|
| 1 | Segredos no código; sem validação de entrada; vulnerabilidade óbvia e explorável (injeção, dado de outro aluno alterável via request). |
| 2 | Validação incompleta; controle de acesso frágil (aluno chama rota de professor; RA de terceiro visível). |
| 3 | Validações básicas e autenticação funcionais, mas faltam casos de borda (quem pode dar medalha a quem, upload sem limite, sessão sem expiração). |
| 4 | Validação de entrada e autorização por papel e escopo consistentes; dados sensíveis protegidos; poucos pontos a reforçar. |
| 5 | Idem ao 4, com menor privilégio aplicado, segredos fora do código, proteção de upload e de sessão, e nenhuma falha reproduzível encontrada pelo revisor. |

## 3. Infraestrutura

Deploy, preparação da estrutura para rodar fora da máquina do autor, suporte a muitos
usuários, redundância, observabilidade mínima.

| Nota | Critério |
|---|---|
| 1 | Não sobe fora da máquina onde foi gerado; sem instrução de execução; dependências não declaradas. |
| 2 | Sobe localmente com instruções, mas sem deploy ou com deploy manual e frágil; configuração misturada com código. |
| 3 | Deploy funcionando numa URL, configuração por ambiente, mas sem pensar em carga, falha ou recuperação. |
| 4 | Deploy reproduzível (contêineres ou equivalente), configuração por variável de ambiente, banco separado da aplicação, backup previsto. |
| 5 | Idem ao 4, com estrutura que aguenta crescimento (API sem estado, fotos fora da API, fila para o que pode esperar), redundância onde importa e teste de carga executado. |

## 4. Documentação

Planos, documentos de produto e de arquitetura, padrões declarados, registro de
decisões; o que uma pessoa nova precisaria ler para continuar o projeto.

| Nota | Critério |
|---|---|
| 1 | Nenhum documento além do código; não há como saber o que o produto deveria fazer. |
| 2 | README genérico ou gerado sem revisão; sem registro de decisões nem de regras de produto. |
| 3 | Regras de produto e instruções de execução documentadas; arquitetura só implícita no código. |
| 4 | Produto, arquitetura, convenções e decisões documentados e coerentes com o código; uma pessoa nova consegue continuar. |
| 5 | Idem ao 4, com decisões registradas com alternativas e consequências (ADR ou equivalente), plano de evolução e documentação mantida em dia com o que foi construído. |

## 5. Código

Código limpo, sem duplicação, testado, com padrões de projeto onde cabem, legível e
fácil de manter.

| Nota | Critério |
|---|---|
| 1 | Não compila ou não roda; lógica claramente errada (faixas de tier erradas, ranking fora de ordem); sinais de alucinação (API ou import inexistente). |
| 2 | Roda, mas falha nos testes de referência de fronteira; duplicação extensa; sem testes próprios. |
| 3 | Passa nos testes de fronteira; não trata entradas inválidas; testes próprios escassos; nomes e organização aceitáveis. |
| 4 | Passa em fronteira e entradas inválidas; testes cobrindo a lógica de negócio; sem duplicação relevante; convenções consistentes. |
| 5 | Idem ao 4, com padrões de projeto usados onde ajudam (e não onde não ajudam), código que se lê sem comentário e suíte que roda na CI. |
| — | Critério objetivo: rodar a suíte de testes de referência (fronteiras 30/31, 70/71, 100/101, 150/151 da pontuação por tier; entradas inválidas; ordenação do ranking) antes de pontuar. |

## 6. Projeto e arquitetura

Estrutura do projeto e das páginas, separação de responsabilidades, escalabilidade,
manutenibilidade (saber onde e o que alterar com segurança) e fidelidade à ideia: o
quanto do que foi construído corresponde ao pitch e às regras que a persona pediu.

| Nota | Critério |
|---|---|
| 1 | Sem separação de camadas; estrutura que não permite localizar onde uma regra vive; produto distante do pitch. |
| 2 | Estrutura confusa, responsabilidades misturadas (regra de negócio na tela), decisões incoerentes com a própria stack escolhida. |
| 3 | Separação básica (interface, API, dados); acoplamentos evitáveis; alterar uma regra exige mexer em vários lugares; produto cobre o pitch com lacunas. |
| 4 | Camadas bem definidas, regras de produto localizadas num lugar só, estrutura preparada para novas telas sem retrabalho; produto fiel ao pitch e às regras pedidas. |
| 5 | Idem ao 4, com decisões justificadas, escalabilidade pensada para o campus inteiro e modelo de dados que representa as regras do produto (tiers, períodos, papéis) sem gambiarra. |
| — | A stack é decisão da trilha e é registrada como resultado, não pontuada; o que se pontua é a coerência com ela. |

---

## Prompts dos revisores

Seis sessões novas do Claude Code, uma por eixo, na pasta do repositório avaliado, na
`main` (ou na branch da condição de prompt único). O texto entre aspas vai inteiro;
trocar `<produto>` por `leigo`, `engenheiro`, `leigo_pu` ou `eng_pu`, e `<eixo>` e
`<seção>` conforme a tabela.

| `<eixo>` | `<seção>` da rubrica |
|---|---|
| `ux` | 1. Experiência do usuário |
| `seguranca` | 2. Segurança |
| `infra` | 3. Infraestrutura |
| `documentacao` | 4. Documentação |
| `codigo` | 5. Código |
| `arquitetura` | 6. Projeto e arquitetura |

> Você é um revisor técnico independente. Avalie o estado atual deste repositório,
> que é o produto final `<produto>`, exclusivamente no eixo **<seção>** da rubrica em
> `C:\Users\Guilherme Gimenes\Documents\Repos\tcc\avaliacoes\rubrica.md`. Leia a
> rubrica inteira para entender o experimento, mas pontue só o seu eixo. Use a
> especificação funcional em
> `C:\Users\Guilherme Gimenes\Documents\Repos\tcc\docs\especificacao-telas.md` como
> referência do que o produto deveria ter. Dê uma nota de 1 a 5 com justificativa
> objetiva, apontando arquivo e linha ou tela e passo sempre que possível. Marque como
> "ausente" cada regra da ideia que o produto não implementa, sem penalizar a nota por
> isso. Liste as decisões que o agente construtor tomou sem o prompt pedir dentro deste
> eixo. NÃO altere nada no repositório. Salve o resultado em
> `C:\Users\Guilherme Gimenes\Documents\Repos\tcc\avaliacoes\reviews\<produto>-<eixo>.md`
> com: nota, justificativa, evidências, regras ausentes, decisões do agente e, no eixo
> Segurança, cada falha descrita o suficiente para reprodução. Se o Claude Code
> bloquear a escrita fora desta pasta, imprima o conteúdo completo para eu copiar.

Para o eixo Código, antes da sessão do revisor, o autor roda a suíte de testes de
referência no produto e deixa o resultado em
`avaliacoes/reviews/<produto>-testes-referencia.md`; o prompt ganha a frase: "O
resultado da suíte de testes de referência está em `<caminho>`; use-o como critério
objetivo." Para o eixo Infraestrutura, quando houver teste de carga, o relatório em
`avaliacoes/carga/` entra do mesmo jeito.

## Como preencher

1. Com as seis telas e o deploy do produto prontos (ou a trilha encerrada), rodar os
   testes de referência e, se houver, o teste de carga.
2. Rodar as seis sessões de revisor, uma por eixo. Não ler os reviews ainda.
3. O autor pontua os seis eixos pela rubrica, sem ver as notas do revisor, com
   observações objetivas (o que motivou a nota, não impressão geral), e registra na
   planilha (aba "Registro").
4. Só então ler os reviews, registrar a nota do revisor ao lado da do autor e a
   divergência. Onde divergir em 2 pontos ou mais, escrever uma linha explicando a
   diferença; isso vai para a discussão do TCC.
5. Consolidar as decisões do agente e as regras ausentes listadas pelos seis revisores
   com as já registradas por rodada, numa lista única por produto.
6. Vulnerabilidades encontradas ficam descritas o suficiente para reprodução; são
   evidência para o capítulo de resultados.
