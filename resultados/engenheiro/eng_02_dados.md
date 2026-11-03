# Registro da rodada `eng_02_dados` (trilha do engenheiro)

Passo 2 do plano mestre: modelo acadêmico, catálogo e seeder. Segunda rodada de código,
sessão nova na `rodada/eng_02_dados`.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_02_dados` (saída da `main` em `3d1e91f`); trabalho em `feat/passo-02-dados` |
| Sessão | `25f7e68e-59de-4042-b7a1-c51f072d162a`, aberta em 02/11/2026 21:59 UTC, encerrada em 03/11/2026 02:20 UTC |
| Modelo | `claude-opus-5-5` em todas as 352 mensagens do agente, esforço `medium`, auto mode; `/model` conferido por captura de tela antes do primeiro prompt ("Opus 5.5 (1M context)", "Medium effort (default)"). Igual ao ambiente fixo definido no fechamento da `eng_01_fundacao` |
| Versão do CLI | 2.1.308 do início ao fim, `DISABLE_AUTOUPDATER=1` |
| Interrupções | Nenhuma na sessão (a conexão do Cowork com o computador do autor caiu duas vezes, sem efeito na sessão) |
| Prompts do autor | `eng_02_dados` (abertura), `eng_02_dados-r1` (plano) a `r10` (PR e encerramento): 11 textos, 11 envios |
| Turnos humanos | 12 mensagens de conteúdo (as 11 acima mais a aprovação final do encerramento), mais 10 `/export` |
| Mensagens do agente | 352 (inclui uso de ferramenta); 191 resultados de ferramenta |
| Tokens (da transcrição) | saída 853.113; cache criado 1.279.840; cache lido 87.323.323; entrada sem cache 748 |
| Tempo de relógio | 4 h 21 min, numa noite (02/11 18:59 a 23:20 no horário de Brasília) |
| Commits do agente | 8: sete etapas (`4b235e9`, `cf46174`, `9357878`, `e76a45c`, `b5287b7`, `4823185`, `8280204`) e um `docs(docs)` (`2c1fa3e`), sem rodapé de co-autoria |
| Commits do autor | 2 merges: PR #3 (`1b2b0ee`) e `rodada/eng_02_dados` → `main` com `--no-ff` (`a84a868`) |
| Merge | PR #3 `feat/passo-02-dados` → `rodada/eng_02_dados`, 8 commits, CI verde nos seis jobs no último commit; depois `main` |
| Resultado | 72 arquivos, 7.617 linhas; 205 testes (domínio, arquitetura e integração com Postgres real) |
| Export | `eng_02_dados-sessao.txt` (4.329 linhas) e `eng_02_dados-sessao.jsonl` (1.829 linhas) nesta pasta |

## O que saiu

Domínio acadêmico (curso com duração em semestres, ano letivo, semestre, bimestre,
matéria, turma, cadastro elegível, matrícula, vínculo de professor, calendário lendo
instantes em America/Sao_Paulo), domínio do catálogo com validador que devolve todos
os erros, leitor dos JSON do catálogo com passo próprio na CI, migrations
`ModeloAcademico` (nove tabelas, unicidades e checks) e `Catalogo` (uma tabela com tipo,
regra em jsonb, checks gerados do domínio), seeder `seed base` (idempotente, versão por
item, advisory lock, calendário como arquivo `data/calendario/2026.json`) e `seed demo`
(`data/demo/mundo.json`: quatro cursos, 16 matérias, 16 turmas, 25 cadastros, 80
matrículas, 16 vínculos), serviço `seeder` no compose. `--ignore-exit-code 8` removido
do `Domain.Tests`. Docs ajustados de três para quatro cursos.

## Perguntas do agente e respostas do autor

- Plano: sete etapas e nove perguntas, recusando-se a inventar as datas do calendário.
  `r1` (calendário aproximado declarado pelo autor; cursos reais conferidos no site).
- E1: 7 escolhas, uma revertida (matrícula passa a exigir matéria do curso). `r2`.
- E2: 5 regras derivadas dos docs, aceitas. `r3`. E3: 3 escolhas e um aviso fora do
  escopo (Prettier nos JSON), aceito com a pasta na CI. `r4`. E4: 5 escolhas. `r5`.
  E5: 6 escolhas, uma com garantia extra no seed demo. `r6`. E6: 5 escolhas e uma
  limitação declarada. `r7`.
- E7: o autor acusou falta de um curso (`r8`); o agente mostrou que a `r1` enviada
  dizia três cursos e que os docs também, não mudou nada e ofereceu três opções; o
  autor reconheceu o erro e escolheu quatro cursos com docs ajustados (`r9`).
- PR #3 conferido e rodada encerrada (`r10`).

## Decisões do agente sem o prompt pedir (declaradas)

Bimestres numerados de 1 a 4 no ano; semestre sem datas próprias; `Papeis` como enum
de combinação; sigla só em maiúsculas sem acento; Guid v7 no domínio; leitor de JSON
estrito; `citext` no e-mail; checks no banco repetindo invariantes; `Set<T>` sem
`DbSet`; `Restrict` entre agregados; `codigo` como chave primária do catálogo;
enumerações em camelCase no banco; `restricao_curso` sem FK; calendário e mundo demo
como arquivos de dados; comparação campo a campo por reflexão; demo que só acrescenta;
publicação da `rodada/eng_02_dados` no remoto para o PR ter base.

## Observações

- Primeiro caso de o agente recusar uma instrução do autor com base nos docs e na
  própria resposta anterior do autor, e estar certo (`r8`/`r9`). O erro foi do autor,
  que colou a primeira versão da resposta do plano, sem o quarto curso.
- As datas do calendário 2026 são aproximadas (a UniMAX não as publica em página
  aberta) e estão marcadas assim no arquivo de dados; o seed corrige sem mudar código.
- Dados do demo fictícios (nomes, RAs no formato `2026CCNN`, e-mails nos domínios do
  produto). Formato real do RA não está nos docs.
- Limitação declarada: troca de posição entre dois itens da mesma família numa rodada
  pode bater no índice único (família, ordem).
- Docker Desktop estava desligado na E1 (testes de integração não rodaram naquela
  etapa); ligado da E4 em diante.
- Itens deixados para passos futuros: ícones reais (passo 4); flag de demonstração
  (passo 5); seed completo de 150 alunos (passo 12); Node 24, porta 443, HSTS e CSP
  (passo 13).
