# Registro da rodada `eng_05_login` (trilha do engenheiro)

Passo 5 do plano mestre: login, cadastro, termos e entrada da demonstração. As primeiras
telas reais do produto.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_05_login` (saída da `main` em `3818816`); trabalho em `feat/passo-05-login` |
| Sessão | `e325b8fe-be89-44f9-b3a6-dcd18562bced`, aberta em 07/11/2026 02:10 UTC, encerrada em 07/11/2026 20:16 UTC |
| Modelo | `claude-opus-5-5` em todas as 524 mensagens do agente, esforço `medium`, auto mode; `claude --version` e `/model` conferidos antes do primeiro prompt; `/login` renovado na abertura por aviso de expiração |
| Versão do CLI | 2.1.316 do início ao fim |
| Interrupções | Queda de rede de madrugada durante a etapa 1: o turno ficou preso cerca de 15 horas e foi encerrado com Esc pelo autor; retomada na mesma sessão. Sem compactação automática |
| Prompts do autor | `eng_05_login` (abertura), `eng_05_login-r1` (plano) a `r9` (PR e ajustes finais): 10 textos; mais uma mensagem curta de retomada após a queda de rede |
| Turnos humanos | 11 mensagens de conteúdo, mais `/model`, `/login` e 10 `/export` |
| Mensagens do agente | 524 (inclui uso de ferramenta); 302 resultados de ferramenta |
| Tokens (da transcrição) | saída 1.020.451; cache criado 2.285.030; cache lido 225.936.315; entrada sem cache 1.110 |
| Tempo de relógio | 06/11 23:10 a 07/11 17:16 (horário de Brasília), descontadas as cerca de 15 horas do turno preso: perto de 6 h ativas |
| Commits do agente | 10: oito etapas (`c326993`, `2617e36`, `7fafa77`, `0159ab3`, `58b2fb2`, `9f7f1b1`, `5ba31cf`, `f88a419`), um fix de CI da etapa 2 (`4755c70`) e os ajustes finais de docs (`af1f260`), sem rodapé de co-autoria |
| Commits do autor | Merge do PR #7 (`c069c0f`) e `rodada/eng_05_login` → `main` com `--no-ff` (`9115368`) |
| Merge | PR #7 `feat/passo-05-login` → `rodada/eng_05_login`, CI verde nos seis jobs em todos os commits de etapa; `main` em `9115368` |
| Resultado | 292 testes Jest no mobile, 59 e2e com a demonstração desligada e 4 com ela ligada (duas passadas na CI), 242 de domínio e 229 de integração na API |
| Export | `eng_05_login-sessao.txt` (5.905 linhas) e `eng_05_login-sessao.jsonl` (2.854 linhas) |

## O que saiu

Termo de uso versionado na API (publicação imutável pelo seed, `GET /v1/termo-de-uso`,
`versaoDoTermo` obrigatório no cadastro e na demonstração, aceite na mesma transação da
conta), texto da v1 redigido pelo agente e aprovado pelo autor com a seção
"Demonstração"; sessão no cliente com refresh serializado dentro da aba e entre abas
(Web Locks), access só em memória, secure store no nativo, tabela de código para
mensagem com teste que lê os códigos da API; erro de campo, logo vetorial gerado do
SVG, link em texto e moldura comum das telas de autenticação; login pela prancheta com
portão de rotas, início provisório e `/status`; cadastro em três passos (dados, arroba
com debounce de 500 ms, termo); recuperação de senha com token no fragmento e e2e pelo
Mailpit; entrada da demonstração com botão condicionado à API, contas lembradas no
aparelho e mensagens para `registro-simultaneo` e `chave-invalida`; CI do e2e em duas
passadas; docs do passo, plano mestre com a avaliação remota antes de 05/12 e glossário
com `TermoDeUso` e `AceiteDeTermo`.

## Perguntas do agente e respostas do autor

- Plano: sete achados e oito decisões; sete pela recomendação e a do erro de campo pela
  alternativa (borda em `like` como exceção). `r1`, com a decisão de contexto de que não
  há apresentação presencial.
- Etapa 1 com o texto do termo: aprovado com um acréscimo. `r2`. Etapas 2 a 7: sem
  decisão, aprovadas (`r3` a `r8`), com a purga do banco local pedida na `r8`.
- PR: o autor pediu dois ajustes de docs (passo 13 para avaliação remota, glossário) e o
  agente apontou um erro na mensagem do autor ("dois fixes"). `r9`.

## Decisões do agente sem o prompt pedir (declaradas)

Texto do termo redigido só a partir do `produto.md`; dados do cadastro só em memória;
token do fragmento capturado uma vez no carregamento do bundle; `/redefinir-senha` fora
dos grupos de rota; renovação antecipada a 30 s do vencimento; `Object.hasOwn` na
tabela de mensagens; cliente de teste sem coleta de cache; `check` do Lucide; papel
`radio` no `FilterChip`; leitura do Mailpit adiada para a etapa 6; CI em duas passadas;
linha "Etapa pronta" no README de decisões; correção do próprio relatório da etapa 7.

## Observações

- Três bugs do próprio agente pegos pelos próprios testes antes ou depois do commit:
  `in` aceitando `toString` (etapa 2, antes), cache esvaziado ao virar anônimo (etapa
  2, CI vermelha, fix separado), token nulo no fragmento (etapa 6, e2e).
- O agente apontou um erro na mensagem do autor (`r8` pedia "dois fixes") e, no fim,
  dois trechos do README de decisões que ainda supõem apresentação presencial (linha
  "Banca" e justificativa do limite de 60 por IP), deixados para o passo 6.
- Pendências para passos futuros: LGPD, contato e prazo de guarda no termo (fase 2);
  controle de tema no perfil (passo 7); conferência em aparelho e Maestro (passo 13);
  resposta perdida no refresh sem janela de tolerância (ensaio do passo 13).
- Disco: ao fim da rodada o C: estava com 5,2 GB livres; o cache de build do Docker
  volta a crescer a cada rodada e precisa de `docker builder prune` e compactação do
  `.vhdx` antes da próxima.
