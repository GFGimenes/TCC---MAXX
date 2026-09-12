# Corpus de respostas — formulário "Como o público leigo usa (ou usaria) IA para criar um app"

Fonte: Google Forms, título real **"Como pessoas sem formação técnica usariam IA para
criar um produto de software"** (subtítulo "Pesquisa TCC Guilherme Gimenes"),
estrutura de 12 perguntas — a mesma estrutura da versão CURTA descrita em
`personas/leigo/formulario-persona-leiga.md`, mas com o título e a introdução da
versão MÉDIA. Enviado 15/08/2026, coleta encerrada 20/08/2026. Texto de abertura
verbatim do formulário:

> Esta pesquisa faz parte de um Trabalho de Conclusão de Curso sobre construção de
> software com assistentes de inteligência artificial. Leva cerca de 5 minutos.
> Não existe resposta certa nem errada, e você não precisa saber nada de programação,
> na verdade, respostas de quem não é da área são as mais importantes aqui. As
> respostas podem ser anônimas e serão usadas apenas de forma agregada na pesquisa.

Cenário apresentado antes das perguntas 8–12, também verbatim:

> Imagine: você precisa criar um aplicativo de celular com login, mural de avisos e
> um sistema de pontos. Não há programador disponível, somente ferramentas de IA.

E a instrução dada logo abaixo da pergunta 10 (a mais importante, a mensagem real):

> Do seu jeito mesmo, sem se preocupar com termos técnicos.

Todo o texto das 12 perguntas e suas opções, e os números agregados citados neste
arquivo, foram conferidos contra a exportação HTML do próprio Google Forms (painel do
autor, perguntas + respostas + resumo) — batem exatamente com os dados extraídos da
planilha de respostas usada para montar este corpus.

**N = 28** respostas, anonimizadas aqui como R01–R28 (ordem de chegada). Nenhum filtro
foi aplicado por padrão — todas as 28 entram no corpus, cada uma marcada com o vínculo
declarado com tecnologia, para que a contaminação de vocabulário técnico possa ser
discutida em vez de escondida.

Este arquivo é o **benchmark**: o catálogo bruto, com a mensagem verbatim de cada
pessoa e uma leitura qualitativa (tags) do padrão de pedido. A leitura consolidada —
o que isso significa para a persona "leigo" e para os prompts do experimento — está em
`personas/leigo/perfil.md`.

## Como ler

Cada entrada traz:

- **Perfil** — faixa etária, vínculo com tecnologia (conforme a pergunta 2 do
  formulário), já pediu para uma IA criar algo antes, confiança declarada (1–5) em
  liberar o app para terceiros.
- **Comportamento declarado** — as respostas de múltipla escolha às perguntas 8 e 9
  (primeiro passo e como pediria), *antes* de a pessoa escrever a mensagem real. Vale
  comparar com a mensagem: em vários casos o declarado e o real não batem.
- **Padrões observados** — tags qualitativas atribuídas por leitura da mensagem real
  (ver legenda abaixo). Uma entrada pode ter mais de uma tag.
- **Mensagem real** — o texto verbatim da resposta à pergunta 10 ("Escreva a primeira
  mensagem que você mandaria para a IA"), sem correção ortográfica.

## Legenda das tags de padrão

| Tag | Significado |
|---|---|
| `VAGO-CURTO` | Pedido curto, sem detalhar nenhuma funcionalidade concreta |
| `IGNORA-CENARIO` | Troca o cenário proposto (login/mural/pontos) pela própria ideia de produto |
| `TUDO-DE-UMA-VEZ` | Pede o escopo inteiro num único pedido, sem faseamento |
| `PASSO-A-PASSO` | Pede para dividir em etapas ou telas, uma de cada vez |
| `REFERENCIA-VISUAL` | Usa prints, apps existentes ou anexos como especificação, em vez de descrever |
| `PERSONA-TECNICA` | Invoca um papel técnico para a IA ("aja como...", "atue como...") |
| `PEDAGOGICO` | Pede para a IA explicar/ensinar antes de construir qualquer coisa |
| `DELEGA-DECISAO` | Não define requisito nenhum; pergunta à IA "como você faria" |
| `JARGAO-DE-FACHADA` | Usa termo técnico (linguagem, código, Python, "melhores práticas") sem conteúdo técnico real por trás |
| `FOCO-VISUAL` | Prioriza estética/design antes de qualquer funcionalidade |
| `TEMPLATE-LITERAL` | Preenche placeholders genéricos (`[—]`, X, Y) sem substituir por conteúdo real |
| `ESCOPO-CLARO` | Restabelece fielmente as features do cenário dado, com poucas lacunas grandes |
| `CONTROLE-ESCOPO` | Define explicitamente o que a IA NÃO deve fazer ainda |
| `FORA-DE-FOCO` | Resposta que não parece engajar com o cenário dado — ruído de dados |
| `OUTLIER-TECNICO` | Vínculo declarado é não-dev, mas a mensagem é indistinguível da de um desenvolvedor |
| `DEV` | Marca de perfil (não de padrão): declarou trabalhar/ter trabalhado com desenvolvimento de software |

## Números do corpus (N=28)

- Vínculo com tecnologia: 10 nunca trabalharam na área · 13 já trabalharam em função
  próxima (suporte, dados, design, produto, qualidade) · 5 com desenvolvimento de
  software.
- Confiança média em liberar o app (escala 1–5): **3,50** geral · 3,60 entre quem
  desenvolve · 3,48 entre quem não desenvolve — praticamente a mesma, ou seja, saber
  programar não torna a pessoa mais cautelosa ao declarar confiança.
- Tamanho médio da primeira mensagem: **566 caracteres** entre devs vs. **165
  caracteres** entre não-devs (3,4x mais curta).
- Apenas **8 de 23** mensagens de não-devs (35%) citam pelo menos um dos três
  elementos literalmente pedidos no cenário (login, mural de avisos, sistema de
  pontos) — a maioria ignora os detalhes dados ou substitui pela própria ideia de
  produto.
- Vocabulário de risco/qualidade nas mensagens de não-devs: 0/23 mencionam
  "segurança", "teste"/"testar", "hospedagem" ou "publicar"; 1/23 menciona "senha";
  2/23 mencionam "dado(s)".

---

## R01
**Perfil:** 26–30 anos · nunca trabalhou na área · nunca pediu para uma IA criar um app · confiança 2/5
**Declarado:** primeiro passo = pesquisar no Google/YouTube antes · como pediria = mandando prints/exemplos em todo passo
**Padrões:** `REFERENCIA-VISUAL` `IGNORA-CENARIO`

> Analise as imagens que vou enviar e crie um app similar mas com as seguintes alterações:

---

## R02 `DEV`
**Perfil:** 21–25 anos · trabalha com desenvolvimento de software (1–3 anos) · participou da construção de um software em equipe · já pediu para IA criar algo, mas não atingiu o objetivo · confiança 3/5
**Declarado:** primeiro passo = escrever/desenhar o que quero · como pediria = por partes, uma tela por vez
**Padrões:** `PASSO-A-PASSO`

> Estruture uma ideia e monte um planejamento para um app de celular com login, mural de avisos e um sistema de pontos,
>
> Criando a primeiro planejamento do app, monte e depois me fale o passo a passo para criação das telas/funcionalidades e divida em passos, para ser realizado a montagem do app

---

## R03
**Perfil:** até 20 anos · já trabalhou em função próxima (< 1 ano) · construiu sozinho(a) um software que chegou ao público · já pediu para IA criar algo, mas não atingiu o objetivo · confiança 4/5
**Declarado:** primeiro passo = perguntar para a IA como se faz, antes de pedir para criar · como pediria = mandando prints/exemplos
**Padrões:** `VAGO-CURTO` `PEDAGOGICO`

> O que é necessário para fazer tal coisa

---

## R04
**Perfil:** 30–34 anos · nunca trabalhou na área · nunca pediu para uma IA criar um app · confiança 3/5
**Declarado:** primeiro passo = pesquisar no Google/YouTube antes · como pediria = não saberia como pedir
**Padrões:** `VAGO-CURTO` `PASSO-A-PASSO`

> Preciso de ajuda para criar um app, vou te mandando aos poucos as coisas que preciso

---

## R05 `DEV`
**Perfil:** 21–25 anos · trabalha com desenvolvimento de software (< 1 ano) · participou da construção de um software em equipe · já pediu para IA criar algo, mas não atingiu o objetivo · confiança 3/5
**Declarado:** primeiro passo = perguntar para a IA como se faz, antes de pedir para criar · como pediria = mandando prints/exemplos
**Padrões:** `PERSONA-TECNICA` `PEDAGOGICO` `REFERENCIA-VISUAL`

> Aja como um engenheiro de software e me explique passo a passo com exemplos de como eu posso criar um aplicativo para celular com sistemas de login, mural de avisos e um sistema de pontos. Caso queira algum tipo de exemplo visual eu irei fixar imagens de onde possa se basear em como eu quero que fique pelo menos em sua estrutura visual.

---

## R06
**Perfil:** até 20 anos · nunca trabalhou na área · nunca pediu para uma IA criar um app · confiança 3/5
**Declarado:** primeiro passo = procurar um app pronto para usar de exemplo · como pediria = pedido curto, e vê o que vem
**Padrões:** `IGNORA-CENARIO` `VAGO-CURTO`

> Estou querendo criar um aplicativo para ajudar a monitorar os oq está faltando e oq já tem em casa como comida, produto de limpeza, etc..

---

## R07
**Perfil:** até 20 anos · já trabalhou em função próxima (< 1 ano) · começou um software mas nunca foi usado por ninguém · já pediu para IA criar algo e ficou utilizável · confiança 5/5
**Declarado:** primeiro passo = escrever/desenhar o que quero · como pediria = por partes, uma tela por vez
**Padrões:** `PASSO-A-PASSO` `PEDAGOGICO`

> Crie a base do app (especificando o maximo que consigo) de maneira funcional e detalhe cada parte do código (podendo ajudar na hora de mexer manualmente) e aponte quais serão os próximos passos necessários ao que desejo

---

## R08
**Perfil:** até 20 anos · já trabalhou em função próxima (< 1 ano) · nunca construiu um software que chegou ao público · já pediu para IA criar algo e ficou utilizável · confiança 3/5
**Declarado:** primeiro passo = escrever/desenhar o que quero · como pediria = por partes, uma tela por vez
**Padrões:** `ESCOPO-CLARO` `PASSO-A-PASSO` `PEDAGOGICO`

> Preciso criar um app mobile, necessário ter tela de login, um mural de avisos e um sistema de pontos, como posso realizar, oq usar para desenvolver, caso possível, montar um passo a passo.

---

## R09
**Perfil:** 21–25 anos · nunca trabalhou na área · nunca pediu para uma IA criar um app · confiança 4/5
**Declarado:** primeiro passo = pesquisar no Google/YouTube antes · como pediria = tudo detalhado de uma só vez
**Padrões:** `VAGO-CURTO` `IGNORA-CENARIO` `JARGAO-DE-FACHADA`

> Quero criar uma app de finanças, me ajude com o código

*Nota: declarou que pediria "tudo detalhado de uma só vez", mas a mensagem real tem uma linha e nenhum detalhe — o maior contraste entre intenção declarada e comportamento real do corpus.*

---

## R10
**Perfil:** até 20 anos · já trabalhou em função próxima (< 1 ano) · nunca construiu um software que chegou ao público · já pediu para IA criar algo e ficou utilizável · confiança 5/5
**Declarado:** primeiro passo = perguntar para a IA como se faz, antes de pedir para criar · como pediria = mandando prints/exemplos
**Padrões:** `ESCOPO-CLARO` `PASSO-A-PASSO`

> estou sem programador disponível e preciso criar um aplicativo de celular com login de inicio, após o login uma aba de mural de avisos e um sistema de pontos do usuário ao lado do seu perfil, no passo a passo vamos começar pela tela de login primeiro

---

## R11
**Perfil:** 21–25 anos · já trabalhou em função próxima (1–3 anos) · construiu sozinho(a) um software que chegou ao público · já pediu para IA criar algo e ficou utilizável · confiança 3/5
**Declarado:** primeiro passo = procurar um app pronto para usar de exemplo · como pediria = por partes, uma tela por vez
**Padrões:** `REFERENCIA-VISUAL` `CONTROLE-ESCOPO` `PASSO-A-PASSO`

> Em anexo segue exemplo de um site modelo coletado no github.
>
> Replique este site com (tais condições e mudanças), não faça mais nada além dessas mudanças para que possamos modelar juntos nos próximos passos.

---

## R12
**Perfil:** até 20 anos · nunca trabalhou na área · nunca pediu para uma IA criar um app · confiança 3/5
**Declarado:** primeiro passo = perguntar para alguém que entende · como pediria = tudo detalhado de uma só vez
**Padrões:** `PERSONA-TECNICA` `VAGO-CURTO`

> Assuma a função de um programador de aplicativos para celular com ampla experiência

*Nota: a mensagem para no meio — invoca o papel técnico e não chega a formular o pedido em si.*

---

## R13
**Perfil:** até 20 anos · já trabalhou em função próxima (< 1 ano) · nunca construiu um software que chegou ao público · já pediu para IA criar algo e ficou utilizável · confiança 3/5
**Declarado:** primeiro passo = perguntar para a IA como se faz, antes de pedir para criar · como pediria = por partes, uma tela por vez
**Padrões:** `ESCOPO-CLARO` `PEDAGOGICO`

> Preciso criar um aplicativo de celular com login, mural de avisos e um sistema de pontos. Não sou programador e dependo da assistência da IA e vídeos da internet. Me ajude introduzindo primeiramente o básico e a parte teórica sobre como funciona e como posso aprender e criar esse aplicativo do zero.

---

## R14 `OUTLIER-TECNICO`
**Perfil:** 21–25 anos · já trabalhou em função próxima (1–3 anos) · construiu sozinho(a) um software que chegou ao público · já pediu para IA criar algo e ficou utilizável · confiança 5/5
**Declarado:** primeiro passo = escrever/desenhar o que quero · como pediria = tudo detalhado de uma só vez
**Padrões:** `OUTLIER-TECNICO`

> Criaria um mvp primeiro em outra ia com os requisitos e espectativas e apos isso geraria um mark down para que a ia de desenvolvimento se baseie na criacao.

*Nota: declara vínculo "função próxima", não desenvolvimento — mas descreve um fluxo de trabalho (MVP → spec em markdown → IA de codificação) típico de quem já pratica produto/engenharia. Candidato a exclusão se a persona leiga precisar de uma amostra mais "pura".*

---

## R15
**Perfil:** até 20 anos · já trabalhou em função próxima (3–6 anos) · participou da construção de um software em equipe · já pediu para IA criar algo, mas não atingiu o objetivo · confiança 4/5
**Declarado:** primeiro passo = pedir o aplicativo inteiro para uma IA de uma só vez · como pediria = mandando prints/exemplos
**Padrões:** `TUDO-DE-UMA-VEZ` `ESCOPO-CLARO` `FOCO-VISUAL`

> Chat, preciso criar um aplicativo de celular com login, mural de avisos e um sistema de pontos.
> Me entregue um design clean

---

## R16 `DEV`
**Perfil:** 21–25 anos · trabalha com desenvolvimento de software (1–3 anos) · participou da construção de um software em equipe · já pediu para IA criar algo e ficou utilizável · confiança 5/5
**Declarado:** primeiro passo = perguntar para a IA como se faz, antes de pedir para criar · como pediria = por partes, uma tela por vez
**Padrões:** `CONTROLE-ESCOPO` `PASSO-A-PASSO`

> Me ajude a criar um app com login mural de avisos e sistema de pontos. Não desenvolva nada ainda, apenas me mostre um plano consistente de desenvolvimento, reúna ideias novas e apresente implicações e desafios. Qualquer dúvida pode interromper e perguntar.

---

## R17
**Perfil:** até 20 anos · já trabalhou em função próxima (< 1 ano) · começou um software mas nunca finalizou · já pediu para IA criar algo e ficou utilizável · confiança 3/5
**Declarado:** primeiro passo = escrever/desenhar o que quero · como pediria = por partes, uma tela por vez
**Padrões:** `JARGAO-DE-FACHADA` `PASSO-A-PASSO`

> Eu preciso do código na linguagem x para desenvolver uma aplicativo móbile onde a primeira tela ele deve receber os dados x e y do usuário para fazer login.

---

## R18
**Perfil:** até 20 anos · nunca trabalhou na área · começou um software mas nunca finalizou · já pediu para IA criar algo, mas não atingiu o objetivo · confiança 4/5
**Declarado:** primeiro passo = perguntar para a IA como se faz, antes de pedir para criar · como pediria = pedido curto, e vê o que vem
**Padrões:** `JARGAO-DE-FACHADA` `PASSO-A-PASSO`

> Preciso criar um aplicativo de celular com login em tal linguagem. O primeiro passo é montar a tela de login, como podemos fazer ?

---

## R19
**Perfil:** até 20 anos · já trabalhou em função próxima (< 1 ano) · participou da construção de um software em equipe · já pediu para IA criar algo e ficou utilizável · confiança 4/5
**Declarado:** primeiro passo = perguntar para a IA como se faz, antes de pedir para criar · como pediria = por partes, uma tela por vez
**Padrões:** `TEMPLATE-LITERAL` `CONTROLE-ESCOPO`

> Me ajude a criar o app X contendo Y informações
> Primeiro vamos definir o escopo base. Depois os detalhes, por fim faça o passo a passo para mim.

---

## R20 `DEV`
**Perfil:** até 20 anos · trabalha com desenvolvimento de software (1–3 anos) · construiu sozinho(a) um software que chegou ao público · já pediu para IA criar algo e ficou utilizável · confiança 3/5
**Declarado:** primeiro passo = escrever/desenhar o que quero · como pediria = por partes, uma tela por vez
**Padrões:** `PERSONA-TECNICA` `TEMPLATE-LITERAL` `PASSO-A-PASSO`

> Você é um desenvolvedor de projetos, trabalhando em uma metodologia ágil para a entrega de um site de [—], defina o escopo inicial do projeto, que deverá contar com as seguintes features e características: [——]. Depois, elabore por etapas um plano de implementação para desenvolver o site, após a definição do plano iremos iniciar o desenvolvimento, etapa por etapa.

---

## R21
**Perfil:** 35+ anos · nunca trabalhou na área · tentou pedir para uma IA criar um app e desistiu · confiança 3/5
**Declarado:** primeiro passo = perguntar para a IA como se faz, antes de pedir para criar · como pediria = por partes, uma tela por vez
**Padrões:** `DELEGA-DECISAO` `VAGO-CURTO`

> Olá chat, se você fosse criar um App, utilizando o modelo (tal disponível), como você faria?

---

## R22
**Perfil:** até 20 anos · nunca trabalhou na área · nunca pediu para uma IA criar um app · confiança 2/5
**Declarado:** primeiro passo = pesquisar no Google/YouTube antes · como pediria = tudo detalhado de uma só vez
**Padrões:** `ESCOPO-CLARO` `TUDO-DE-UMA-VEZ` `FOCO-VISUAL`

> Crie para mim um site, com design moderno, que contenha tela de login, pedindo e-mail/telefone e senha do usuário, um mural de avisos detalhado e simples de entender e um sistema de pontuação embutido ao site.

*Nota: chama o produto de "site", não "app", ao longo de toda a mensagem — os dois termos são usados como sinônimos.*

---

## R23
**Perfil:** até 20 anos · já trabalhou em função próxima (< 1 ano) · nunca pediu para uma IA criar um app · confiança 3/5
**Declarado:** primeiro passo = escrever/desenhar o que quero · como pediria = por partes, uma tela por vez
**Padrões:** `IGNORA-CENARIO` `JARGAO-DE-FACHADA` `FOCO-VISUAL`

> Olá, gostaria que me fizesse um site em Python, parecido com o site de um cardápio de restaurante, primeiro gostaria que fizessse o fundo do site, na cor preta.

---

## R24
**Perfil:** 35+ anos · nunca trabalhou na área · nunca pediu para uma IA criar um app · confiança 5/5
**Declarado:** primeiro passo = pesquisar no Google/YouTube antes · como pediria = tudo detalhado de uma só vez
**Padrões:** `FORA-DE-FOCO` `VAGO-CURTO`

> Olá, preciso de informações pra entender sobre este assunto, (o assunto que eu preciso), passo a passo e onde incluir cada informação na fórmula? E porque seguir esses passos?

*Nota: a resposta não parece se referir ao cenário do app (menciona "fórmula") — provável ruído de quem respondeu de forma genérica ou confundiu o que a pergunta pedia. Mantido no corpus como exemplo desse tipo de dado, não como amostra de linguagem "leiga" válida.*

---

## R25 `OUTLIER-TECNICO`
**Perfil:** até 20 anos · já trabalhou em função próxima (< 1 ano) · começou um software mas nunca finalizou · já pediu para IA criar algo, mas não atingiu o objetivo · confiança 3/5
**Declarado:** primeiro passo = pesquisar no Google/YouTube antes · como pediria = mandando prints/exemplos
**Padrões:** `OUTLIER-TECNICO` `REFERENCIA-VISUAL` `PASSO-A-PASSO`

> utilizando esse rascunho como exemplo, sabendo que estamos desenvolvendo um aplicativo mobile usando java spring boot (intellij) e android studio (também java) e que precisamos de login, mural de avisos e sistemas de pontos no aplicativo, siga os layouts enviados para gerar o código de cada tela conforme eu pedir, e depois realizaremos a integração com o back-end com o volley

*Nota: cita stack real e específica (Java Spring Boot, IntelliJ, Android Studio, Volley) — mensagem indistinguível da de um desenvolvedor júnior, apesar do vínculo declarado ser "função próxima". Mesmo risco de contaminação que R14.*

---

## R26
**Perfil:** 21–25 anos · já trabalhou em função próxima (1–3 anos) · nunca pediu para uma IA criar um app · confiança 1/5
**Declarado:** primeiro passo = perguntar para a IA como se faz, antes de pedir para criar · como pediria = mandando prints/exemplos
**Padrões:** `VAGO-CURTO`

> Oii, preciso de ajuda pra desenvolver um aplicativo, gostaria de uma ajuda

*Nota: menor confiança declarada de todo o corpus (1/5) e uma das mensagens mais curtas — o par vago+pouco confiante aparece junto aqui.*

---

## R27 `DEV`
**Perfil:** 21–25 anos · trabalha com desenvolvimento de software (1–3 anos) · participou da construção de um software em equipe · nunca pediu para uma IA criar um app · confiança 4/5
**Declarado:** primeiro passo = escrever/desenhar o que quero · como pediria = pedido curto, e vê o que vem
**Padrões:** `PERSONA-TECNICA` `PASSO-A-PASSO` `CONTROLE-ESCOPO` `TEMPLATE-LITERAL`

> Atue como um Desenvolvedor de Software Sênior e Arquiteto de Software, com experiência em desenvolvimento de aplicações escaláveis, manutenção de código e boas práticas de engenharia de software.
>
> Preciso desenvolver um aplicativo chamado x, cujo principal objetivo é x y z
>
> Funcionalidades principais
>
> O aplicativo deverá possuir as seguintes funcionalidades:
>
> [FUNCIONALIDADE 1]
> [FUNCIONALIDADE 2]
> [FUNCIONALIDADE 3]
>
> Ao elaborar a solução:
>
> Siga os princípios SOLID;
> Utilize Clean Code;
> Aplique separação de responsabilidades;
> Priorize baixo acoplamento e alta coesão;
> Utilize interfaces quando fizer sentido;
> Evite classes e métodos com responsabilidades excessivas;
> Evite complexidade desnecessária e overengineering;
>
> Crie um plano de implementação passo a passo, contendo:
>
> Apresente a arquitetura recomendada e justifique a escolha.
> Estrutura do projeto
> Mostre uma sugestão de organização de pastas/pacotes.
> Explique a responsabilidade de cada camada.
> Modelagem das classes
> Liste as principais classes e interfaces.
> Explique a responsabilidade de cada uma.
> Mostre os relacionamentos entre elas.
> Implementação das funcionalidades
> Explique como cada funcionalidade deve ser implementada.
> Indique quais classes e métodos estarão envolvidos.
> Fluxo de execução
> Aplicação do SOLID
> Dê exemplos práticos relacionados às classes propostas.
> Tratamento de erros e validações
> Identifique possíveis erros e situações excepcionais.
> Explique como tratá-los.
>
> Não escreva todo o código de uma vez.
>
> Primeiro apresente o plano completo da solução e explique as decisões arquiteturais.

*Nota: o contraponto perfeito no corpus — um template de prompt engineering completo (papel, restrições de arquitetura, placeholders explícitos, faseamento). Útil como referência de "trilha do engenheiro", não de "trilha do leigo".*

---

## R28
**Perfil:** 21–25 anos · nunca trabalhou na área · construiu sozinho(a) um software que chegou ao público · já pediu para IA criar algo, mas não atingiu o objetivo · confiança 5/5
**Declarado:** primeiro passo = perguntar para a IA como se faz, antes de pedir para criar · como pediria = tudo detalhado de uma só vez
**Padrões:** `IGNORA-CENARIO` `REFERENCIA-VISUAL` `JARGAO-DE-FACHADA` `PASSO-A-PASSO`

> [ Anexo da minha ideia 💡 ]
> Crie um passo a posso de como criar um aplicativo de calculadora científica com padrão corporativo e seguindo as melhores práticas do mercado?, Conforme a ideia anexada, o objetivo é desenvolver uma calculadora capaz de realizar operações científicas avançadas e exibir os dados de maneira visual em 2D ou 3D.

---

## Leitura rápida por tag (contagem, apenas não-devs, N=23)

| Tag | Ocorrências |
|---|---|
| `PASSO-A-PASSO` | 9 |
| `VAGO-CURTO` | 8 |
| `IGNORA-CENARIO` | 5 |
| `JARGAO-DE-FACHADA` | 5 |
| `PEDAGOGICO` | 5 |
| `ESCOPO-CLARO` | 5 |
| `REFERENCIA-VISUAL` | 4 |
| `FOCO-VISUAL` | 3 |
| `TUDO-DE-UMA-VEZ` | 2 |
| `CONTROLE-ESCOPO` | 2 |
| `OUTLIER-TECNICO` | 2 |
| `PERSONA-TECNICA` | 1 |
| `DELEGA-DECISAO` | 1 |
| `TEMPLATE-LITERAL` | 1 |
| `FORA-DE-FOCO` | 1 |

A leitura completa dessas contagens — o que fica de fora do pedido, o que se repete, e
como isso deveria informar `prompts/leigo/` — está em `personas/leigo/perfil.md`.
