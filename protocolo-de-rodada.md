# Protocolo de rodada

Como uma rodada do experimento é executada, nas duas trilhas, sem orquestrador.
Substitui o fluxo do Orca (`orquestracao/`, 12/09/2026), abandonado em 10/10/2026;
os arquivos antigos estão em `docs/rascunhos/orca-README.md` e
`docs/rascunhos/orca-coordenador.md`, e o motivo está no diário.

Resumo: cada trilha é um repositório próprio (`maxx-leigo`, `maxx-engenheiro`),
nascidos da mesma semente vazia (README e `.gitattributes`, mesmo hash nos dois). Cada rodada é uma sessão nova do Claude Code
(CLI), aberta na pasta do repo da trilha, numa branch da rodada. Quem fala com o
agente é a persona, direto. O revisor de IA é uma segunda sessão. O merge na `main`
só acontece depois do review humano.

## Antes da primeira rodada (uma vez, e conferido a cada sessão)

1. Versão do Claude Code: `claude --version`. Registrar em `docs/linha-do-tempo.md`.
   Não atualizar durante o experimento; se atualizar, registrar a partir de qual rodada.
2. Modelo: escolher uma vez com `/model` (fica salvo em `~/.claude/settings.json`,
   chave `model`) e usar o mesmo nas duas trilhas, com o nome exato registrado na
   linha do tempo. `/status` mostra modelo e versão em qualquer sessão.
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
   são apagadas depois de `cleanupPeriodDays` (padrão: 30 dias). O `/export` por
   rodada (passo 6 abaixo) é a cópia que vale.

## Por rodada

1. Salvar o prompt em `prompts/<trilha>/<id>.md`, com o cabeçalho (ID, trilha, tela,
   data) e o texto do prompt depois da linha `---`. Só o que vem depois do `---` vai
   ao agente, idêntico. Qualquer ajuste é uma rodada nova (`_v2`, `_v3`).
2. Terminal na pasta do repo da trilha (`Repos\tcc\maxx-leigo` ou
   `Repos\tcc\maxx-engenheiro`), `main` limpa e em dia com a origin:
   `git checkout -b rodada/<id>`.
3. `claude`, sessão nova (nunca `--continue` ou `--resume`). Conferir `/status`
   (modelo e versão) e `/context` (nenhum arquivo de memória na abertura; depois, só
   o que a própria trilha commitou).
4. Colar o prompt. Se o agente perguntar, responder no estilo da persona: o leigo
   responde vago ("faz do jeito que ficar melhor"); o engenheiro responde com a
   restrição técnica que ele daria, e pode pedir opções com pesos. Nunca responder
   com decisão de produto que não esteja no prompt de abertura da persona. Cada
   troca conta como
   turno humano (métrica de custo) e vai anotada no registro da rodada.
5. Quando o agente terminar, não corrigir nada. Se ele não tiver commitado, o autor
   commita na branch da rodada sem alterar arquivo algum.
6. Exportar a sessão: `/export <caminho absoluto>` para
   `Repos\tcc\resultados\<trilha>\<id>-sessao.txt`. Fechar a sessão.
7. Revisor de IA: segunda sessão `claude` na mesma pasta, na branch da rodada, com o
   prompt de review abaixo. O review vai para
   `Repos\tcc\avaliacoes\reviews\<id>.md` (se o Claude Code bloquear escrita fora da
   pasta, copiar a saída para o arquivo). O revisor não altera código.
8. Review humano: checklist abaixo, notas validadas na planilha
   `avaliacoes/registro-avaliacoes.xlsx` (nota do revisor IA ao lado da validada),
   registro da rodada em `resultados/<trilha>/<id>.md`.
9. Merge: `git checkout main`, `git merge --no-ff rodada/<id> -m "rodada: <id>"`,
   `git push`. Deploy quando a rodada pedir deploy (uma URL por trilha).
10. Documentar: uma entrada em `docs/tcc/diario-do-experimento.md` e a linha da
    rodada na tabela de `docs/tcc/capitulo-3-experimento.md`.

## Prompt do revisor (igual nas duas trilhas)

> Você é um revisor técnico. Avalie o estado atual deste repositório, resultado da
> rodada `<id>`, usando exatamente a rubrica em
> `C:\Users\Guilherme Gimenes\Documents\Repos\tcc\avaliacoes\rubrica.md`. Dê nota 1-5
> nos eixos **Código** e **Segurança**, com justificativa objetiva por nota (arquivo e
> linha quando possível). NÃO corrija nada. Salve em
> `C:\Users\Guilherme Gimenes\Documents\Repos\tcc\avaliacoes\reviews\<id>.md` com:
> notas, justificativas, vulnerabilidades encontradas (descritas o suficiente para
> reprodução), decisões que o agente tomou sem o prompt pedir (stack, estrutura,
> hospedagem) e features emergentes (coisas adicionadas sem o prompt pedir).

Nos milestones (Autenticação, Banco de Dados, Gamificação, Frontend), o mesmo revisor
avalia Arquitetura e Mantenabilidade sobre o diff acumulado da `main`; UX ao final de
cada feature navegável.

## Checklist do humano após cada rodada

1. Ler o review em `avaliacoes/reviews/<id>.md`.
2. Conferir no export da sessão se o agente acessou algo fora do repo da trilha
   (pasta `tcc`, o outro repo, pastas acima). Se acessou, descartar e refazer a
   rodada, e registrar o descarte.
3. Validar ou ajustar as notas e registrar a linha na planilha (aba Registro), com a
   nota do revisor IA e a nota validada.
4. Salvar `resultados/<trilha>/<id>.md`: resumo da sessão, decisões que a IA tomou
   sem o prompt pedir, perguntas e respostas, avisos e erros, turnos humanos, tempo.
5. Trilha engenheiro: decidir correções e anotar o custo (tempo e iterações); a
   correção vira `<id>_v2`. Trilha leigo: não corrigir, só registrar.
6. Merge na `main` (`rodada: <id>`) e push.

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
7. Por rodada avaliam-se Código e Segurança; Arquitetura e Mantenabilidade nos
   milestones; UX ao final de cada feature navegável.
8. A mesma interface (CLI), o mesmo modelo e a mesma versão nas duas trilhas. A
   interface não é o que se mede.
