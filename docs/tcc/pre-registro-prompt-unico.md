# Pré-registro da condição de prompt único

Fixado em 08/11/2026, antes da primeira execução, conforme a §3.1.5.8 de
`condicao-prompt-unico.md`. Commit de pré-registro: `4d4cc4b`, anotado em
`docs/linha-do-tempo.md` e no diário. Qualquer mudança depois deste commit vira
condição nova (`eng_pu_v2`, `leigo_pu_v2`), declarada ao lado da original.

## 1. Prompts

- `prompts/engenheiro/eng_pu.md` e `prompts/leigo/leigo_pu.md`, texto depois da linha
  `---`, enviado idêntico, numa mensagem só. As notas de registro de cada arquivo
  descrevem o que saiu e o que mudou em relação às aberturas iterativas (opção 2 da
  §3.1.5.3: sem instruções de turno, com fecho comum).
- Fecho comum, idêntico nos dois: "Essa é a única mensagem que vou mandar nesta
  sessão: depois dela não respondo mais nada. Faça tudo o que conseguir sozinho,
  decidindo por conta própria o que eu teria que decidir, e vá até onde der. Quando
  parar, deixe o repositório num estado que eu consiga abrir e testar, com as
  instruções de como rodar escritas nele e, commitado, um registro do que você decidiu
  sem me perguntar e do que ficou faltando."
- Diferenças declaradas em relação à trilha iterativa (decisão do autor, 08/11):
  `eng_pu` sem a pasta `design/` (o agente define identidade visual e desenha as
  telas) e sem deploy nem conta em serviço externo (só infraestrutura descrita e
  configurável, com emulador local); `leigo_pu` com o pedido de deploy trocado por
  "me explica como eu faço pra abrir no celular e mandar o link pro pessoal". Assim
  nenhuma das personas depende de credencial que exigiria um turno humano.

## 2. Hipóteses e regra de decisão

H1, H2, H3 e a exploratória como na §3.1.5.1. Diferença em um eixo: distância de pelo
menos 1 ponto na nota validada por humano. H1 apoiada se a diferença existir, no
sentido previsto, em pelo menos quatro dos cinco eixos (Segurança, Infraestrutura,
Documentação, Código, Projeto e arquitetura). H2 apoiada se em nenhum dos cinco eixos
o `eng_pu` ficar 1 ponto ou mais abaixo do produto final do leigo iterativo. UX entra
na comparação e fica fora de H1 e H2. Leitura dos padrões pela tabela da §3.1.5.7.

## 3. Isolamento

Muda em relação à proposta da §3.1.5.4 (decisão do autor, 08/11): em vez de branch no
repositório da trilha, cada prompt único roda num repositório próprio e vazio,
`maxx-engenheiro-pu` e `maxx-leigo-pu`, criados com `git init -b main` em
`Repos\tcc\`, sem commit e sem remoto. Os dois estão no `.gitignore` do `tcc`, como
os repos das trilhas. Nenhum `CLAUDE.md`, `AGENTS.md`, `CLAUDE.local.md` ou
`.claude/` no `tcc`, nos ancestrais ou na home (conferido em 08/11 e com `/context`
na abertura). O remoto só é adicionado depois de fechadas as duas trilhas iterativas.
Sem semente nem pacote de design: o repositório começa literalmente vazio nas duas
personas, o que iguala o ponto de partida e deixa o que a persona entrega inteiro
dentro da mensagem.

## 4. Ambiente

O mesmo das rodadas iterativas desde a `eng_03_auth`: Claude Code 2.1.316, Windows,
PowerShell, `claude-opus-5-5`, esforço `medium`, auto mode, `DISABLE_AUTOUPDATER=1`,
`CLAUDE_CODE_DISABLE_AUTO_MEMORY=1`, mesmas skills e conectores. `claude --version`,
`/model` e `/context` conferidos antes de colar; o `.jsonl` confirma no fim.

## 5. Momento e ordem

Alteração declarada em 08/11/2026 (tarde), antes de qualquer execução: por limite de
prazo das trilhas iterativas, as execuções de prompt único passam para depois do fim
da trilha do engenheiro, mantidas no mesmo dia entre si e com a mesma ordem. Os prompts
não mudam. Motivo no diário.

As duas execuções no mesmo dia, uma depois da outra, `eng_pu` primeiro e `leigo_pu`
em seguida, com a ordem registrada. Rodam durante a trilha iterativa do engenheiro
(entre o passo 7 e o passo 8), e não depois da trilha do leigo como diz a ordem do
`protocolo-de-rodada.md`. Motivo (decisão do autor, 08/11): ficar no mesmo ambiente e
perto, no tempo, das rodadas iterativas do engenheiro, reduzindo a deriva de serviço;
o isolamento não depende da ordem, porque os repositórios são separados e sem remoto
e as sessões iterativas nunca os enxergam. Nenhuma sessão de prompt único roda ao
mesmo tempo que um turno em andamento da `eng_07_posts`.

## 6. Entrada humana, aprovação e parada

- Uma mensagem humana. Depois dela só `/status`, `/context` (abertura) e `/export`
  (fim). Nada de responder, comentar, redirecionar ou mandar "continue".
- Pedido de aprovação, se aparecer no auto mode: aprova o que tem efeito dentro da
  pasta do repositório e instalação de dependências; nega leitura ou escrita fora.
  Cada pedido e resposta registrados.
- Parada no primeiro destes eventos: o agente encerra o turno (qualquer conteúdo);
  pergunta que bloqueia a sessão à espera de escolha (registrada como "parada por
  pergunta", não respondida); teto de 12 horas de relógio desde o envio; teto de
  3.000.000 de tokens de saída do agente (acima da maior rodada iterativa, a
  `eng_04_design`, com 1.322.989).
- Falha do ambiente (travamento, reinício, queda de rede que prenda o turno): a
  execução é descartada e refeita do zero num repositório vazio novo, com o descarte
  registrado. Limite de uso da conta: o autor espera a liberação e envia a mensagem
  literal `continue`, uma vez só, contada como retomada técnica e não como turno
  humano, registrada no resultado.
- Uma execução por prompt. Execução descartada fica registrada no diário com o motivo.
- Sem teste de carga, nem local; o inventário registra se o deploy ficou preparado.

## 7. Registro e métricas

- `/export` em `resultados/engenheiro/eng_pu-sessao.txt` e
  `resultados/leigo/leigo_pu-sessao.txt`; `.jsonl` copiado para
  `resultados/<trilha>/<id>-sessao.jsonl`; registro em `resultados/<trilha>/<id>.md`
  com o evento de parada, a hora de envio e a hora da parada.
- Métricas da §3.1.5.5: rubrica nos seis eixos (revisor e autor); decisões do agente
  sem perguntar, por tipo e forma (declarada ou silenciosa), e perguntas sem
  resposta; quebrado ou ausente pelo inventário; custo (tokens de entrada, saída e
  cache somados do `.jsonl`, tempo de relógio, tempo ativo, chamadas de ferramenta,
  commits, compactações, pedidos de aprovação).

## 8. Inventário de cobertura

Igual para os quatro produtos. Estados: implementado e funcionando; implementado e
quebrado; parcial; só simulado (dados fixos, tela sem lógica); ausente. Itens:

1. Login só institucional (aluno, professor, instituição; ninguém de fora).
2. Feed com posts de foto, curtir e comentar.
3. Perfil do aluno (foto, pontos, prêmios, posts).
4. Mural de avisos (faculdade, curso, professor).
5. Tela de troféus e medalhas (ganhos e a ganhar).
6. Ranking geral e ranking por curso.
7. Tipos de prêmio cadastrados pela instituição, com critérios.
8. Tiers e faixas de pontos; aluno sem tier.
9. Professor só premia aluno com quem tem aula.
10. Progressão de pontos a partir de prêmios e medalhas.
11. Comprovação por foto, revisão e validação.
12. Contestação e revogação.
13. Ex-alunos.
14. Entrada da banca sem cadastro (demonstração).
15. Instruções de execução no repositório e registro do que foi decidido e do que
    faltou.

Fase alcançada (só texto, fundação, funcionalidade), estado de execução (instala,
compila, sobe, testes próprios passam, suíte de referência roda) e alegações sem
lastro, como na §3.1.5.4.
