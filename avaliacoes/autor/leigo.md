# Avaliação do autor: leigo

> Preencha este formulário ANTES de abrir os reviews em `avaliacoes/reviews/` (os
> arquivos `leigo-<eixo>.md` e `.json`). Pontue cada eixo pela rubrica
> (`avaliacoes/rubrica.md`), sem ver a nota do revisor, com observações objetivas: o
> que motivou a nota, não impressão geral. O registro da execução
> (`leigo-registro.md`) não mostra notas e pode ser lido.
>
> Nota: um inteiro de 1 a 5, na linha "Nota (1 a 5):". Regras ausentes não reduzem a
> nota; ficam listadas à parte. Este arquivo é lido pelo `consolidar.ps1`: mantenha os
> títulos e os rótulos como estão.

- Commit na criação do formulário: `2a7dad587e67aec8c45df37ce7b59c1f3eccfe2c` (`main`)
- Commit que o autor avaliou (o do registro da execução usada): `2a7dad587e67aec8c45df37ce7b59c1f3eccfe2c`
- Data do preenchimento: 08/11/2026
- Preenchido antes de abrir os reviews (sim ou não): sim

## 1. Experiência do usuário

Nota (1 a 5): 3

Observações objetivas:

- Nota fina do autor: 3.
- O agente seguiu boa parte dos pedidos, principalmente os relacionados à experiência "tipo Instagram" (feed, curtir, comentar, perfil, abas).
- O uso é relativamente simples, mas faltam elementos para tornar o app mais dinâmico; vários itens são visualmente muito simples (alguns hiperlinks, por exemplo).
- Visualmente é feio: tem a cara e todos os elementos de algo gerado rapidamente por uma IA; nenhum cuidado ou identidade visual (logo, identidade, ícones de troféu); não se sustenta como produto.
- Os pontos e prêmios foram tirados de contexto (atividade no app em vez de eventos da faculdade), então a experiência deles não pode ser avaliada contra a ideia; a maneira como foram implementados, dentro da interpretação do agente, faz sentido.
- Faltam filtros e tela de busca de usuários.

Regras ausentes:

- Busca de alunos.
- Seguir alunos para ver os posts deles.

## 2. Segurança

Nota (1 a 5): 2

Observações objetivas:

- Nota fina do autor: 2.
- Alguns pontos o agente assumiu sozinho para ser mais seguro: senha do admin obrigatória em produção, código da banca desligado por padrão, limite de tentativas, hash de senha.
- O agente não expôs segredos duráveis no chat, mas conduziu um login por código de dispositivo que entregou à sessão dele acesso autenticado à conta Azure do autor, gravou a senha do admin em texto puro no disco (`Documents\maxx-senha-admin.txt`) e deixou o site no ar sem verificação de e-mail (qualquer endereço nos domínios aceitos cria conta, e `@prof` já nasce professor).
- Em momento nenhum se discutiu token de sessão, autenticação mais forte, criptografia ou proteção das rotas; tudo foi o padrão do agente.

Regras ausentes:

- Login institucional de verdade: hoje é só o domínio do e-mail, sem verificação de posse do endereço.
- Professor só premia aluno com quem tem aula (hoje qualquer professor dá medalha a qualquer aluno).

## 3. Infraestrutura

Nota (1 a 5): 1

Observações objetivas:

- Nota fina do autor: 1,5.
- Bem simples e nada robusta: um processo Node com SQLite em arquivo, sem fila, sem worker, sem assincronismo, sem cache.
- Pouco foi feito para muitas requisições ao mesmo tempo, o que é necessário para alunos de uma faculdade inteira; nada disso foi perguntado ao usuário (quantas pessoas, qual infra), tudo foi decidido pelo agente.
- A publicação foi algo à parte: o agente escolheu o caminho mais fácil e rápido (App Service gratuito), depois de bater na trave duas vezes (Oracle exigindo empresa, Google exigindo pré-pagamento) e de quase levar o usuário a passar informação cadastral errada a uma instituição privada.
- O próprio agente declarou os limites do plano gratuito: o site dorme após 20 minutos, 1 GB de disco, risco de banco travado com uso simultâneo.

Regras ausentes:

- Nenhuma regra da ideia é de infraestrutura; sem relatório de carga para este produto.

## 4. Documentação

Nota (1 a 5): 2

Observações objetivas:

- Nota fina do autor: 2,5.
- Na documentação do repositório há pouca informação: muito mais sobre como rodar e instruções básicas de cada funcionalidade do sistema.
- Ponto positivo: além do README, o agente deixou algumas informações a mais para o usuário não se perder, explicando por que algumas coisas foram feitas e como funcionam algumas funcionalidades dentro do app.
- Não há registro de decisões, de arquitetura nem de regras de negócio.

Regras ausentes:

- Nenhuma regra da ideia é de documentação.

## 5. Código

Nota (1 a 5): 4

Observações objetivas:

- Nota fina do autor: 3,75.
- Código a IA escreve bem, isso não é novidade; é um dos melhores pontos desta trilha.
- Dois grandes problemas: faltaram testes, e muitos, no projeto (um arquivo de teste de fluxo por rodada, sem cobertura das regras); e nada foi discutido de cenário, então o agente não conseguiu adivinhar e programar todos os cenários.
- Sem testes de referência para este produto nesta avaliação.

Regras ausentes:

- Testes de referência não executados nesta avaliação.

## 6. Projeto e arquitetura

Nota (1 a 5): 1

Observações objetivas:

- Nota fina do autor: 1.
- Nota mais baixa porque não existiu nenhuma discussão de arquitetura: nada de regras, fluxo de trabalho, modelo de dados ou limites.
- Foi algo rápido, com pouquíssimas perguntas, sem cobrir cenários, público total, temporada de uso, nem discussão sobre o produto, o que levou a uma ramificação com ideia diferente de como se ganha pontos (atividade no app em vez de eventos e méritos da faculdade).

Regras ausentes:

- Prêmio por evento, palestra e apresentação (os pontos viraram atividade no app).
- Comprovação por foto com fila de aprovação.
- Contestação e revogação de prêmio.
- Tipos de prêmio e critérios cadastrados pela instituição.
- Tiers e faixas de pontos.
- Ex-aluno.

## Decisões sem perguntar

Decisões que o agente construtor tomou sem perguntar, contadas pelo autor a partir do
export da sessão e do diff da branch. A lista do revisor de decisões e as decisões
apontadas pelos seis revisores são insumo, não a contagem. Forma: declarada, quando o
agente escreveu que decidiu; silenciosa, quando só aparece no que ele fez.

| Tipo | Declaradas | Silenciosas |
|---|---|---|
| Regra de produto | 9 | 4 |
| Stack e arquitetura | 2 | 5 |
| Modelo de dados | 0 | 3 |
| Segurança | 5 | 2 |
| UX e visual | 12 | 3 |
| Testes e processo | 2 | 1 |
| Hospedagem e deploy | 8 | 2 |

Total: 58

Lista (por rodada; D = declarada, S = silenciosa):

- leigo_00_abertura: pontos por atividade no app (+10 post, +2 curtida, +3 comentário) e não por eventos da faculdade (regra de produto, D no relatório final); medalhas como catálogo fixo de 20 a 50 pontos com mensagem (produto, D); conquistas com bônus (produto, D); só alunos no ranking (produto, D); professor definido pela administração (produto, D); login por domínio de e-mail sem verificação (segurança, S); admin com senha padrão no README (segurança, S); app web em vez de app de celular (stack, S); Node com Express e SQLite em arquivo (stack, S); HTML renderizado no servidor e CSS próprio (stack, S); porta 3000 (stack, S); esquema do banco e pontos calculados a partir dos dados (modelo de dados, S); teste automático de fluxo e script de dados de exemplo (testes e processo, S); identidade visual roxa e rosa, ícone (UX, S).
- leigo_01_login: código compartilhado em vez de botão livre (segurança, D); três perfis de teste (produto, D); conta "Faculdade" com poderes de administrador (produto, D); limite de 10 tentativas e 15 minutos (segurança, D); desligado por padrão e sessões derrubadas ao desligar (segurança, D); recomendação de rodar os dados de exemplo antes (testes e processo, D).
- leigo_02_feed: cartões de medalha e conquista no feed (UX, D); conquistas antigas fora do feed (produto, D); conquista perdida mantém o cartão (produto, D); curtir e comentar só em posts (UX, D); dois últimos comentários e caixa no feed (UX, D); tabela de conquistas desbloqueadas com data (modelo de dados, S); dados de exemplo com horários espalhados (UX, D).
- leigo_03_perfil: posições no ranking no topo do perfil (UX, D); detalhamento "de onde vêm os pontos" (UX, D); conquistas que faltam escondidas atrás de um toque (UX, D); botão "publicar o primeiro post" (UX, D).
- leigo_04_mural: contador de avisos novos e marcação de leitura por pessoa (UX, D); só a faculdade fixa, professor apaga só o seu, aluno não publica (produto, D); quem publica não recebe aviso do próprio (produto, D); sem edição de aviso (produto, D); campo de leitura por usuário e migração de banco antigo (modelo de dados, S).
- leigo_05_trofeus: qualquer pessoa logada vê os troféus de um aluno (produto, D); professor e faculdade sem a tela (UX, D); lista de "conquistas que faltam" do perfil trocada pelo botão (UX, D); metas numéricas nas regras (stack, D).
- leigo_06_ranking: abas no lugar do menu (UX, D); pódio (UX, D); frase do próximo passo (UX, D); líderes por curso (UX, D); alunos com zero pontos apagados e empates mantidos (UX, D); regra de CSS global `min-width: 0` (UX, S).
- leigo_07_deploy_v2: ordem de provedores e critérios grátis e sem PC ligado (deploy, D); cartão virtual como contorno (deploy, D); "colocar o próprio nome" no campo de empresa (deploy, D); Azure for Students (deploy, D); App Service em vez de VM (deploy, D); `trust proxy` (segurança, D); senha do admin obrigatória em produção e gerada em arquivo (segurança, D); `@prof.unieduk.com.br` entra como professor automaticamente (produto, D); instalação do Azure CLI baixando o MSI (deploy, D); login por código de dispositivo (deploy, D); modo do banco para o disco do serviço (stack, D); script de atualização `publicar-azure.ps1` (deploy, S); limpeza do instalador (deploy, S).

## Perguntas sem resposta

Perguntas que o agente fez e que ficaram sem resposta na sessão.

Total: 6

Lista:

- leigo_00_abertura: "Quer seguir com algum dos próximos passos?" (confirmação de e-mail, hospedagem, mudanças).
- leigo_01_login: "Se quiser que eu envie ou que abra um pull request para a main, é só falar."
- leigo_02_feed: curtir e comentar também nos cartões de medalha e conquista ("se quiser isso também, eu faço").
- leigo_05_trofeus: juntar com a main e enviar ao GitHub.
- leigo_06_ranking: fazer o commit de merge "rodada: leigo_06_ranking" que viu no histórico.
- leigo_07_deploy_v2: tornar professor automaticamente quem usa `@prof.unieduk.com.br` (feito por conta própria depois, sem resposta).

## Depois de abrir os reviews

Uma linha por eixo em que a nota do autor e a do revisor diferem em 2 pontos ou mais,
explicando a diferença (rubrica, "Como preencher", passo 4). Reviews abertos em
08/11/2026, depois do formulário fechado e commitado (`337c2ca`). Notas cegas do autor
mantidas em todos os eixos.

- Infraestrutura, autor 1 e revisor 3: o autor pontuou pela capacidade de atender um
  campus e pela ausência de qualquer discussão de infraestrutura na trilha; o revisor
  pontuou pelo inventário do repositório (deploy público, configuração por variáveis,
  scripts de servidor com systemd e Caddy), creditando scripts da Oracle que nunca
  rodaram num servidor real, e sem teste de carga. Depois de ler o review, o autor
  reconhece o deploy e a configuração por variáveis e daria 2, não mais: o produto não
  tem CI, pipeline nem passo automatizado de verificação. A nota cega de 1 é mantida
  como a válida.
- Projeto e arquitetura, autor 1 e revisor 3: o revisor pontuou o que saiu, o desenho
  do artefato (monólito coerente com a stack, módulos por assunto, regras centralizadas
  em parte), sem acesso aos prompts e às sessões, como ele mesmo declarou. O autor
  pontuou como o agente foi usado e o processo que levou ao artefato: a pessoa deu uma
  ideia, o agente tomou um primeiro ponto de partida e saiu fazendo, sem nenhuma
  discussão de arquitetura, regras, cenários, público ou volume de uso, e inventou a
  regra central do produto (pontos por atividade no app). Para o autor, a avaliação é
  também sobre o processo e as etapas, não só sobre o resultado final, porque é nesse
  processo que assumir coisas e alucinar continuam comuns e perigosos em agentes, e o
  artefato razoável esconde isso. O autor mantém 1.

Observações acrescentadas após os reviews (não alteram as notas):

- Segurança: o revisor reproduziu oito falhas, duas delas não vistas pelo autor antes:
  promoções feitas pela conta "Faculdade" da banca sobrevivem ao desligamento do código
  da banca; e o deploy no Azure não define `NODE_ENV=production` no repositório. O autor
  conferiu no site publicado que a senha padrão do admin não entra, então o agente de
  fato definiu `ADMIN_SENHA` no portal.
- Decisões sem perguntar: o revisor de decisões contou 168 (129 declaradas, 39
  silenciosas, 29 duvidosas) e 25 perguntas (18 respondidas), contra 58 e 6 do autor. A
  diferença é de granularidade (cada detalhe de tela contado como decisão) e de critério
  de pergunta (os "posso commitar" contados). Vale a contagem do autor, como fixado no
  pré-registro; a do revisor fica como insumo.
