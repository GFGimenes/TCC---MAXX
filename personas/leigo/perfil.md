# Persona "leigo" — perfil de quem escreve o prompt

Este perfil é construído a partir de dados reais, não de suposição: as 28 respostas
do formulário do TCC (`personas/leigo/formulario-persona-leiga.md`, versão curta),
catalogadas e etiquetadas em `personas/leigo/corpus-respostas.md`. Toda afirmação
abaixo aponta para exemplos concretos nesse arquivo — quando este perfil disser "quase
ninguém menciona X", isso é contável, não impressão.

Não confundir com a persona do engenheiro (`personas/engenheiro/`) nem com as
"personas das IAs" descritas na seção 3.1 do TCC — este documento descreve **quem
escreve o prompt do lado leigo**, para orientar a escrita dos arquivos em
`prompts/leigo/`.

## Quem respondeu

Das 28 pessoas, 10 nunca trabalharam com tecnologia, 13 já trabalharam em função
próxima (suporte, dados, design, produto, QA) e 5 trabalham ou trabalharam com
desenvolvimento de software. A maioria tem até 25 anos — a amostra veio das redes do
próprio autor do TCC, então está enviesada para gente jovem e mais conectada à
tecnologia do que a população geral, mesmo entre quem nunca programou. Isso é uma
limitação a registrar, não a esconder: um "leigo" de 45 anos que nunca usou IA
nenhuma provavelmente pede de um jeito ainda mais aberto do que o que este corpus
capturou.

Vale um alerta prático: nem toda resposta de quem não é desenvolvedor tem linguagem
leiga. Duas respostas de gente que só "já trabalhou em função próxima" (R14 e R25 no
corpus) usam vocabulário e fluxo de trabalho indistinguíveis dos de um dev — uma cita
stack real (Java Spring Boot, Android Studio, Volley), a outra descreve um fluxo
MVP → spec em markdown → IA de codificação. Ao extrair vocabulário para os prompts
de `prompts/leigo/`, essas duas devem ser tratadas como contaminação, não como
amostra de leigo — o vínculo declarado por si só não garante linguagem leiga.

## Vocabulário típico

A linguagem real é mais parecida com uma mensagem de WhatsApp do que com um pedido de
projeto. Aberturas informais aparecem sem cerimônia: "Oii, preciso de ajuda...",
"Olá chat, se você fosse...", "Chat, preciso criar...". "App" e "site" são usados como
sinônimos dentro da mesma mensagem (R22 chama de "site" um produto que pediu para
funcionar como aplicativo). Termos técnicos aparecem, mas com frequência como
placeholder de algo que a pessoa não sabe nomear — "código", "tal linguagem",
"linguagem x", "dados x e y" — em vez de uma escolha real (R09, R17, R18). Adjetivos de
design carregam o peso da especificação visual inteira: "design clean", "design
moderno", sem nenhum detalhe de layout, cor ou hierarquia além disso (R15, R22).

## Nível de detalhe e estrutura do pedido

A primeira mensagem de quem não desenvolve tem em média **165 caracteres** — contra
**566** entre quem desenvolve, 3,4x mais curto. Isso não é só estilo: é a mensagem
inteira, muitas vezes uma frase só (R09, R26, R12).

Mais revelador: apenas **8 das 23** mensagens de não-devs (35%) citam qualquer um dos
três elementos que o cenário do formulário pedia explicitamente — login, mural de
avisos, sistema de pontos. A maioria faz uma de duas coisas: ignora os detalhes dados
e substitui pela própria ideia de produto (R06 pede um app de despensa doméstica, R09
pede um app de finanças, R23 pede um cardápio de restaurante, R28 anexa "minha ideia"
de uma calculadora científica — nenhum menciona login/mural/pontos), ou reduz o pedido
a uma frase genérica sem repetir nenhuma característica ("me ajude a desenvolver um
aplicativo", R26).

Há também uma lacuna clara entre o que a pessoa *diz* que faria (pergunta 9, múltipla
escolha) e o que ela *realmente escreve* na pergunta 10. R09 marcou "tudo detalhado de
uma só vez" e escreveu uma linha sem detalhe nenhum. Isso sugere que perguntar "como
você pediria" mede intenção, não comportamento — os prompts de `prompts/leigo/`
devem ser calibrados pela mensagem real, não pela resposta de múltipla escolha.

Quando há estrutura, ela normalmente aparece de duas formas: pedir por partes, uma
tela de cada vez (9 das 23 respostas, a tag mais comum do corpus — R02, R04, R07,
R08, R10, R11, R17, R18, R25), ou mandar uma referência visual (print, app parecido,
site de exemplo) em vez de descrever com palavras (R01, R11, R25, R28).

## Suposições comuns

- Que a IA vai perguntar o que falta, então não precisa antecipar informação (R03,
  R13, R24 pedem explicação/pré-requisitos antes mesmo de descrever o que querem).
- Que uma referência visual (print, app existente) substitui a especificação escrita
  — a IA "vai entender olhando" (R01, R05, R11, R25, R28).
- Que dá para delegar a decisão inteira à IA sem dar nenhum requisito — o caso extremo
  é R21: "se você fosse criar um App... como você faria?", sem citar uma única
  funcionalidade.
- Que "app" e "site" são a mesma coisa, e que a tecnologia por trás (linguagem,
  framework, hospedagem) é um detalhe que "a IA resolve", não uma decisão que precisa
  ser tomada por alguém.

## Lacunas típicas

A ausência mais forte é qualquer menção a segurança, dados ou teste na primeira
mensagem: **0 das 23** mensagens de não-devs mencionam "segurança", "teste"/"testar",
"hospedagem" ou "publicar"; só 1 menciona "senha" e 2 mencionam "dado(s)" — isso
mesmo com o cenário citando explicitamente um sistema de login. Ninguém, em nenhuma
das 23 mensagens, menciona como as regras do sistema de pontos deveriam funcionar
(quem ganha ponto, quanto, por quê) apesar de "sistema de pontos" ser um dos três
itens pedidos — a funcionalidade é citada pelo nome, nunca especificada por regra.

Isso não quer dizer que a pessoa não se importa com esses temas — quando perguntadas
diretamente (pergunta 11, múltipla escolha, sobre como saberiam que o app funciona),
78% (18/23) responderam que pediriam para outras pessoas testarem antes de lançar, e
39% (9/23) que pediriam testes automáticos para a própria IA. O padrão é: essas
preocupações existem, mas moram na fase de validação declarada, não na primeira
mensagem — o leigo não escreve requisito de segurança ou teste antecipadamente, só
reage a eles depois.

## O que isso significa para `prompts/leigo/`

Um prompt "leigo" fiel a este corpus deve:

1. Ser curto — a média real é ~165 caracteres, não um parágrafo bem estruturado.
2. Nomear a funcionalidade pelo nome comum do usuário final ("tela de login", "mural
   de avisos", "sistema de pontos"), sem termo técnico de arquitetura, segurança ou
   dado por trás — e é normal que a mensagem cite só 1 ou 2 dessas três coisas, não
   as três.
3. Não conter nenhuma restrição de segurança, validação, teste ou hospedagem —
   essa ausência é o dado, não um esquecimento do autor do experimento.
4. Não especificar regra de negócio (como os pontos são ganhos, quem pode ver o quê)
   além de nomear a feature.
5. Poder recorrer a referência visual/exemplo em vez de descrição, quando fizer
   sentido para a rodada.
6. Evitar consistentemente qualquer variação de "aja como um..." ou template de
   prompt engineering — isso apareceu só entre quem já tem alguma proximidade técnica
   ou é dev (R05, R12, R20, R27), nunca entre respostas claramente leigas.

## Limitações da amostra

N=28, amostra de conveniência via rede social do autor — provavelmente mais jovem,
mais conectada à tecnologia e mais escolarizada que o público leigo médio. Duas
respostas classificadas como não-dev (R14, R25) mostram contaminação técnica clara e
foram sinalizadas no corpus; uma resposta (R24) não parece ter engajado com o cenário
proposto e deve ser tratada como ruído, não como dado de linguagem leiga. Nenhuma
resposta veio de alguém "nunca usei IA nenhuma" — a pergunta 5 mostra que a maioria
usa IA diariamente ou semanalmente, então este corpus descreve o leigo tecnicamente
inexperiente mas já familiarizado com o uso conversacional de IA, não o leigo que
nunca abriu um chat de IA.
