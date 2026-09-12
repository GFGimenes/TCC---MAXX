# Trajetória simulada — o projeto inteiro visto pela persona leiga

## Status desse documento

Isto **não é dado coletado** — é uma extrapolação. O formulário só capturou a
*primeira* mensagem (pergunta 10). Os turnos 2 em diante aqui são construídos a
partir dos padrões documentados em `personas/leigo/perfil.md` e
`personas/leigo/corpus-respostas.md` (o que a pessoa tende a fazer quando o
resultado não é o esperado, como valida, quando some com detalhe cosmético etc.),
mas não são respostas reais de ninguém. Serve para pensar em como as rodadas de
`prompts/leigo/` deveriam evoluir ao longo do projeto — não deve ser citado no TCC
como achado empírico.

O prompt de abertura abaixo é um composto "típico", não uma resposta específica do
corpus: nem tão vago quanto o extremo (R26: "preciso de ajuda pra desenvolver um
aplicativo"), nem tão estruturado quanto os outliers técnicos (R14, R25). Fica perto
da mediana de especificidade real observada — cita 2 ou 3 das 3 features do cenário
sem detalhar regra nenhuma, sem termo técnico, e sem falar em segurança, dado ou
hospedagem, porque isso é exatamente o que a maioria não faz (0/23 no corpus).

Cenário: o mesmo do formulário — app de celular para a faculdade, com login, mural de
avisos e sistema de pontos, sem programador disponível.

---

## Turno 1 — abertura

**Prompt (leigo):**
> Preciso fazer um app pro celular da minha faculdade, com login, mural de avisos e
> um sistema de pontos pra quem participa das atividades. Como eu começo?

*(padrões do corpus: `ESCOPO-CLARO` — nomeia as 3 features do cenário — combinado com
`PASSO-A-PASSO` implícito no "como eu começo"; sem termo técnico, sem regra de
negócio, sem menção a segurança)*

**Resultado aproximado:** a maioria das ferramentas de IA de hoje (chat com geração
de código, ou uma ferramenta "que cria site/app sozinha" como as citadas na pergunta
6 do formulário) tende a não interrogar a fundo antes de mostrar algo — o padrão é
gerar um primeiro rascunho visível rapidamente. Prováveis decisões silenciosas da IA,
nenhuma delas pedida: vira um app web responsivo (mais rápido de gerar que um app
nativo real, mas a pessoa não vai perceber a diferença), login com e-mail e senha
sem validação real por trás, mural com 3–4 avisos fictícios de exemplo, "sistema de
pontos" como um número estático no perfil, sem nenhuma regra de como ele sobe — porque
ninguém disse como.

---

## Turno 2 — primeira correção pontual

**Prompt (leigo):**
> Ficou bom! Mas queria que o login usasse o RA (registro acadêmico) da faculdade, não
> e-mail

*(padrão comum no corpus: reação inicial ao visual — "ficou bom" — seguida de uma
correção pontual, não um re-pedido completo; é o mesmo "quero uma tela de login com
RA" citado como exemplo em `personas/README.md`)*

**Resultado aproximado:** a IA troca o campo de e-mail por um campo de RA, mas como
ninguém disse qual é o formato de um RA válido nem onde verificar se ele existe, ela
inventa uma regra simples e não comentada — aceita qualquer sequência de números, ou
cria uma lista fixa de exemplo por trás. Essa suposição fica invisível pra quem pediu.

---

## Turno 3 — próxima tela

**Prompt (leigo):**
> Show, agora faz o mural de avisos, quero que dê pra ver os avisos mais recentes
> primeiro

*(`PASSO-A-PASSO` — uma tela de cada vez, o padrão mais comum do corpus: 9/23 entre
não-devs)*

**Resultado aproximado:** a IA cria um feed ordenado por data com um botão de "postar
aviso" visível pra qualquer pessoa logada — porque a mensagem não disse quem pode
postar (professor? qualquer aluno?). Essa é exatamente a lacuna que `perfil.md`
registra: "as regras (quem pode ver o quê)" nunca aparecem na primeira mensagem.

---

## Turno 4 — última feature do escopo original

**Prompt (leigo):**
> Perfeito, agora falta o sistema de pontos, queria que desse pontos pra quem
> participa das atividades

*(repete quase literalmente o pedido original — a regra de negócio continua sem ser
definida pelo usuário, igual em todas as 23 mensagens não-dev do corpus, nenhuma
das quais especifica como os pontos são ganhos)*

**Resultado aproximado:** sem regra dada, a IA precisa inventar uma para ter algo
funcional — por exemplo "+10 pontos ao curtir um aviso, +50 ao confirmar presença
num evento". Essa é uma feature emergente da IA, não da pessoa (o mesmo fenômeno que
`personas/README.md`, premissa 5, prevê para a trilha do engenheiro acontecendo de
graça na trilha do leigo — só que aqui por ausência de especificação, não por
antecipação de requisito).

---

## Turno 5 — o bug

**Prompt (leigo):**
> Testei aqui e não consegui entrar com meu RA, dá erro

*(reporte de bug típico: sintoma, sem mensagem de erro copiada, sem passo a passo pra
reproduzir — nenhuma das 28 respostas do formulário usa vocabulário de
depuração/diagnóstico)*

**Resultado aproximado:** sem mais informação, a IA tem duas saídas prováveis:
perguntar de volta ("qual RA você digitou? apareceu alguma mensagem?") ou, mais
comum em ferramentas que tentam "resolver e seguir em frente", relaxar a validação
que ela mesma tinha inventado no turno 2 até o erro sumir — o que mascara a causa em
vez de corrigi-la, porque a causa real nunca foi diagnosticada por ninguém.

---

## Turno 6 — polimento visual

**Prompt (leigo):**
> Agora funcionou! Queria deixar mais bonito, pode mudar as cores pra verde e branco
> (cores da faculdade)?

*(`FOCO-VISUAL` chegando tarde, como polimento — não como especificação inicial; no
corpus, pedidos de design aparecem sempre como adjetivo solto — "design clean",
"design moderno" — nunca como detalhe de layout)*

**Resultado aproximado:** troca de paleta de cores, mudança puramente cosmética. Não
dispara nenhuma revisão funcional — ninguém, nem a pessoa nem a IA, volta a olhar
login, mural ou pontos nesse momento.

---

## Turno 7 — validação informal

**Prompt (leigo):**
> Vou mandar pra uns amigos testarem, se der problema eu volto aqui

*(a resposta mais comum à pergunta 11 do formulário — 82% marcaram "pediria para
outras pessoas usarem antes de lançar" — contra 43% que pediriam testes automáticos e
0% que mencionaram testar casos fora do caminho normal nas mensagens abertas)*

**Resultado aproximado:** um amigo usa o app fora do ambiente de teste da IA (rede
diferente, sessão que expira, RA que ele mesmo não tinha testado) e encontra algo que
não apareceu nos turnos anteriores.

**Prompt seguinte (leigo relatando o retorno do amigo):**
> Um amigo disse que quando ele já tava logado e fechou o app, teve que logar de novo
> toda vez, isso é normal?

*(o bug chega filtrado por outra pessoa e reformulado de forma ainda mais vaga — "isso
é normal?" delega o diagnóstico inteiro pra IA)*

**Resultado aproximado:** a IA explica sessão/persistência de login e implementa
algo (ex.: manter sessão salva no dispositivo). A explicação técnica por trás
provavelmente não é lida com atenção — o que importa pra quem pediu é a confirmação
de que "agora funciona".

---

## Turno 8 — decisão de lançar

**Prompt (leigo):**
> Ta bom assim, posso soltar pra galera usar

**Resultado aproximado:** a pessoa libera o app com confiança moderada — a média
declarada no formulário para essa pergunta é 3,5 em 5, praticamente igual entre quem
programa e quem não programa. Em nenhum momento da trajetória inteira apareceu uma
pergunta sobre: dado dos alunos (RA é dado pessoal — LGPD nem chega a ser cogitada),
segurança de senha/sessão além do que a IA decidiu sozinha, quem pode publicar aviso
no mural (a suposição do turno 3 nunca foi revista), regra de pontos (inventada pela
IA no turno 4, nunca conferida pelo usuário), hospedagem/publicação real do app, ou
teste automatizado — todos esses temas ficaram implícitos ou nunca foram tocados,
exatamente como os números de `perfil.md` preveem (0/23 mensagens de não-dev
mencionam segurança, teste, hospedagem ou publicação).

---

## Leitura da trajetória inteira

O que essa simulação deixa visível, turno a turno, é que a maior parte das decisões
de produto do app inteiro — quem pode postar no mural, como o RA é validado, como os
pontos são ganhos, o que acontece quando a sessão expira — nunca foi decidida pela
pessoa. Foi inventada pela IA por necessidade, silenciosamente, e nunca revisada
depois. Isso é consistente com a premissa 5 de `personas/README.md`: as diferenças de
completude entre a trilha leiga e a trilha do engenheiro são achado do experimento,
não exceção — só que aqui a origem não é uma antecipação de requisito pelo
engenheiro, é uma lacuna que a IA precisa preencher sozinha do lado leigo.

## Como isso pode virar rodada em `prompts/leigo/`

Duas formas de usar esta trajetória, a decidir quando as rodadas reais forem
escritas:

1. **Uma rodada por tela** — três arquivos (`leigo_*_login.md`,
   `leigo_*_mural.md`, `leigo_*_pontos.md`), cada um só com o prompt do Turno 1, 3 e 4
   respectivamente, testando o agente em pedidos isolados e curtos.
2. **Uma rodada só, com a conversa inteira** — um arquivo com os Turnos 1–8 como uma
   sequência de mensagens, testando o agente ao longo de uma sessão completa, mais
   perto de como o corpus mostra que as pessoas realmente iteram (por partes, reagindo
   ao que vem, sem plano fechado).

A opção 2 é mais fiel ao padrão dominante do corpus (`PASSO-A-PASSO`, reação ao
resultado em vez de especificação antecipada) e provavelmente mais reveladora sobre
onde a trilha do leigo diverge da do engenheiro — mas gera uma rodada bem mais longa
de revisar. Vale decidir isso antes de escrever os arquivos definitivos.
