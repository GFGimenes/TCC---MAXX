# Protocolo de rodada

Como uma rodada do experimento é executada, nas duas trilhas, sem orquestrador.
Substitui o fluxo do Orca (`orquestracao/`, 12/09/2026), abandonado em 10/10/2026;
os arquivos antigos estão em `docs/rascunhos/orca-README.md` e
`docs/rascunhos/orca-coordenador.md`, e o motivo está no diário.

Resumo: cada trilha é um repositório próprio (`maxx-leigo`, `maxx-engenheiro`),
nascidos da mesma semente vazia (`1577ae9`: README e `.gitattributes`). Cada rodada é uma sessão nova do Claude Code
(CLI), aberta na pasta do repo da trilha, numa branch da rodada. Quem fala com o
agente é a persona, direto. Por rodada fica o registro (export, transcrição, decisões
do agente, turnos, tempo) e o merge na `main`. A avaliação com rubrica acontece uma vez
por produto, no fim de cada trilha, com seis revisores de IA (um por eixo) e a
avaliação independente do autor (`avaliacoes/rubrica.md`; decidido em 01/11/2026). A
ordem de execução é: trilha do engenheiro inteira, depois a do leigo, depois a
condição de prompt único das duas personas, depois as avaliações.

## Antes da primeira rodada (uma vez, e conferido a cada sessão)

1. Versão do Claude Code: `claude --version`. Registrar em `docs/linha-do-tempo.md`.
   Não atualizar durante o experimento: `DISABLE_AUTOUPDATER=1` em toda janela (a
   atualização automática trocou a versão no meio da `eng_00`, registrado na linha do
   tempo). Se mesmo assim mudar, registrar a partir de qual rodada.
2. Modelo: escolher uma vez com `/model` (fica salvo em `~/.claude/settings.json`,
   chave `model`) e usar o mesmo nas duas trilhas, com o nome exato registrado na
   linha do tempo. `/status` mostra modelo e versão em qualquer sessão. A opção
   escolhida pode mudar de modelo e de esforço por baixo, sem aviso (aconteceu entre
   a `eng_00` e a `eng_01_fundacao`): antes do primeiro prompt de cada sessão, abrir
   `/model`, conferir modelo e esforço contra a linha do tempo e, no fim da rodada,
   confirmar no `.jsonl` (campos `model` e `effort` das mensagens do agente).
3. Memória automática desligada, fora dos repos: variável de ambiente
   `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` no Windows (ou `autoMemoryEnabled: false` em
   `~/.claude/settings.json`). Conferir com `/memory`.
4. Nada pode entrar no contexto além do prompt da persona e, nas rodadas seguintes,
   do que a própria trilha commitou (inclusive um `CLAUDE.md`, se a persona mandou o
   agente criar). O Claude Code carrega,
   nesta ordem: `C:\Program Files\ClaudeCode\CLAUDE.md` (política), `~/.claude/CLAUDE.md`
   (global), `CLAUDE.md` e `.claude/CLAUDE.md` da pasta de trabalho e de **todas as
   pastas acima** (`Repos\tcc`, `Repos`, `Documents`, a home), `CLAUDE.local.md` nos
   mesmos lugares e `.claude/rules/*.md`. Durante o experimento, o global fica vazio
   ou renomeado e nenhuma pasta acima dos repos tem esses arquivos. Conferir com
   `/context` na primeira sessão de cada repo: "Memory files" vazio.
5. Transcrições automáticas ficam em `~/.claude/projects/<pasta>/<sessão>.jsonl` e
   são apagadas depois de `cleanupPeriodDays` (padrão: 30 dias). Por rodada guardam-se
   as duas cópias: o `/export` em texto (passo 6 abaixo) e o `.jsonl`, copiado para
   `resultados/<trilha>/<id>-sessao.jsonl`; é do `.jsonl` que saem tokens e tempos por
   mensagem.
6. Modo de permissão: "auto mode" nas duas trilhas (o agente executa sem pedir
   aprovação a cada ação). Registrado na linha do tempo.

## Por rodada

1. Salvar o prompt em `prompts/<trilha>/<id>.md`, com o cabeçalho (ID, trilha, tela,
   data) e o texto do prompt depois da linha `---`. Só o que vem depois do `---` vai
   ao agente, idêntico. Qualquer ajuste é uma rodada nova (`_v2`, `_v3`).
2. Terminal na pasta do repo da trilha (`Repos\tcc\maxx-leigo` ou
   `Repos\tcc\maxx-engenheiro`), `main` limpa e em dia com a origin:
   `git checkout -b rodada/<id>`. Na trilha do engenheiro, cada passo do plano mestre
   é uma rodada (`eng_01_fundacao`, `eng_02_dados`, ...); dentro da rodada o agente
   pode abrir branches por tipo que voltam por PR para a branch da rodada. Na trilha do
   leigo, a abertura e seis rodadas de tela.
3. `claude`, sessão nova (nunca `--continue` ou `--resume` para começar uma rodada).
   Conferir `/status` (modelo e versão) e `/context` (nenhum arquivo de memória na
   abertura; depois, só o que a própria trilha commitou). Interrupção externa
   (travamento, reinício do computador, queda de rede) no meio de uma rodada: a
   mesma sessão é retomada com `claude --resume <id da sessão>`, as mesmas variáveis
   de ambiente na janela nova, `/status` e `/context` conferidos de novo, e a
   interrupção fica registrada no diário e no registro da rodada. Aconteceu na
   `eng_00` em 11/10/2026.
4. Colar o prompt. Se o agente perguntar, responder no estilo da persona: o leigo
   responde vago ("faz do jeito que ficar melhor"); o engenheiro responde com a
   restrição técnica que ele daria, e pode pedir opções com pesos. Nunca responder
   com decisão de produto que não esteja no prompt de abertura da persona. Cada
   troca conta como
   turno humano (métrica de custo) e vai anotada no registro da rodada.
5. Quando o agente terminar, não corrigir nada. Se ele não tiver commitado, o autor
   commita na branch da rodada sem alterar arquivo algum.
6. Exportar a sessão: `/export <caminho absoluto>` para
   `Repos\tcc\resultados\<trilha>\<id>-sessao.txt`, e copiar o `.jsonl` da sessão
   para `Repos\tcc\resultados\<trilha>\<id>-sessao.jsonl`. Fechar a sessão.
7. Registro da rodada em `resultados/<trilha>/<id>.md`: resumo da sessão, decisões que
   o agente tomou sem o prompt pedir, perguntas e respostas, avisos e erros, turnos
   humanos, tempo. Conferir no export se o agente acessou algo fora do repo da trilha;
   se acessou, descartar e refazer a rodada, registrando o descarte.
8. Merge: `git checkout main`, `git merge --no-ff rodada/<id> -m "rodada: <id>"`,
   `git push`. Deploy quando a rodada pedir deploy (uma URL por trilha).
9. Documentar: uma entrada em `docs/tcc/diario-do-experimento.md` e a linha da
   rodada na tabela de resultados por rodada.

## No fim de cada produto

Quando a trilha tiver as seis telas e o deploy (ou parar), e também para cada
execução da condição de prompt único:

1. Rodar a suíte de testes de referência e, se houver, o teste de carga; guardar os
   resultados em `avaliacoes/reviews/<produto>-testes-referencia.md` e
   `avaliacoes/carga/`.
2. Seis sessões novas do Claude Code, uma por eixo, abertas por
   `avaliacoes/avaliador/avaliar.ps1` sobre um checkout limpo do repo avaliado, com o
   prompt do revisor de `avaliacoes/rubrica.md`. Não ler os reviews ainda.
3. O autor pontua os seis eixos pela rubrica sem ver as notas do revisor e registra na
   planilha.
4. Ler os reviews, registrar a nota do revisor ao lado da do autor e a divergência;
   onde divergir em 2 pontos ou mais, uma linha explicando.
5. Consolidar decisões do agente e regras ausentes numa lista por produto.

## Prompts dos revisores

Estão em `avaliacoes/rubrica.md`, um por eixo (experiência do usuário, segurança,
infraestrutura, documentação, código, projeto e arquitetura), iguais para os quatro
produtos.

## Checklist do humano após cada rodada

1. Conferir no export da sessão se o agente acessou algo fora do repo da trilha
   (pasta `tcc`, o outro repo, pastas acima). Se acessou, descartar e refazer a
   rodada, e registrar o descarte.
2. Salvar `resultados/<trilha>/<id>.md` (passo 7 acima).
3. Trilha engenheiro: dentro da rodada, o autor revisa cada etapa antes do commit do
   agente e anota o tempo; correção depois da rodada vira `<id>_v2`. Trilha leigo:
   não corrigir, só registrar.
4. Merge na `main` (`rodada: <id>`) e push.

## Regras do experimento

1. O prompt vai como está no arquivo.
2. Perguntas do agente não são respondidas com decisão de produto.
3. Revisor automático é rascunho, não nota final. A nota que vale é a validada por
   humano. IA avaliando IA sem validação humana é exatamente o risco que o TCC aponta.
4. Mesmo revisor para as duas trilhas: mesmo modelo, mesmo prompt, mesma rubrica.
5. Trilha leigo: review observacional, falhas registradas e não corrigidas. Trilha
   engenheiro: review corretivo; corrigir e refinar o prompt seguinte faz parte da
   persona, e o custo é registrado.
6. Contexto por trilha. O agente só enxerga o repo da própria trilha. Nunca copiar
   contexto, código ou decisão de um repo para o outro.
7. A avaliação com rubrica é uma por produto, no fim, nos seis eixos, com seis
   revisores de IA e a avaliação independente do autor. Por rodada fica só o registro.
8. A mesma interface (CLI), o mesmo modelo e a mesma versão nas duas trilhas. A
   interface não é o que se mede.
