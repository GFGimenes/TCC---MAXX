# Registro da rodada `eng_14_demo_papeis` (trilha do engenheiro, posterior à avaliação)

Passo 14, fora do plano mestre e fora do experimento medido: a entrada de demonstração
passa a oferecer três papéis (aluno, professor e coordenação), para que a banca alcance
as telas de professor e de instituição no produto no ar. Pedido pelo autor em 10/11/2026,
depois de fechada e avaliada a trilha. Custo, commits, decisões do agente, notas da
rubrica, inventário e testes de referência do experimento referem-se à `main` em
`8910b51`; nada deste registro entra nessas medidas, e os revisores não foram rodados de
novo, por decisão do autor.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_14_demo_papeis` (saída da `main` em `8910b51`); trabalho em `feat/passo-14-demo-papeis` |
| Sessão | `42ff04be-4d5a-4462-93e9-6da00ec430d9`, aberta em 11/11/2026 00:16 UTC, encerrada em 11/11/2026 02:49 UTC |
| Modelo | `claude-opus-5-5` em todas as 595 mensagens do agente, esforço `medium`, auto mode |
| Versão do CLI | 2.1.316 |
| Interrupções | Nenhuma; sem compactação |
| Protocolo | O mesmo dos passos 11 a 13: plano de etapas antes do código, etapas sem tela emendadas, parada com capturas nas etapas com tela e no fechamento |
| Prompts do autor | `eng_14_demo_papeis` (abertura) e `-r1` a `-r4`: 5 textos |
| Mensagens do agente | 595; 346 usos de ferramenta |
| Tokens (da transcrição) | saída 592.454; cache criado 1.086.950; cache lido 192.204.187; entrada sem cache 1.206 |
| Tempo de relógio | 2 h 32 min de ponta a ponta (10/11 21:16 a 23:49 no horário de Brasília), sem intervalo acima de 15 min |
| Commits do agente | 9: `6538767` (docs), `c70ce15`, `ec0df1e`, `80dff3a` (fix), `6942698`, `8d25268`, `cff38e3`, `81bf896`, `b73f4fd`; CI verde ao fim de cada etapa, sem rodapé de co-autoria |
| Commits do autor | Merge do PR #16 (`9081dd8`) e `rodada/eng_14_demo_papeis` → `main` com `--no-ff` (`fde8717`) |
| Resultado | Demonstração com três entradas no ar em `app.maxx-unimax.com` (`sha-81bf896`), lote `banca-2026`; API 1.296 testes, Jest 533, seis casos e2e `@demo` |
| Export | `eng_14_demo_papeis-sessao.txt` (6.702 linhas) e `eng_14_demo_papeis-sessao.jsonl` (3.222 linhas); capturas em `capturas/eng_14_demo_papeis/` (etapa 5, etapa 6 e conferência no ar) |

## O que saiu

Rotas `POST /v1/demo/professores` e `POST /v1/demo/coordenacoes`; conta de professor de
demonstração vinculada às turmas do curso escolhido no semestre vigente, com o escopo de
turma preservado; conta de coordenação de demonstração com os poderes da instituição;
migração `PapeisNaDemonstracao` (coluna `encerrada_em`, checks novos); limite único de 60
registros por hora por IP entre as três rotas; purga que apaga os alunos do lote e encerra
professores e coordenações, mantendo a autoria dos atos; marca no token das contas de
demonstração para conferir no banco a cada chamada; telas "Aluno de teste", "Professor de
teste" e "Coordenação de teste"; tela da purga com contagem por papel, marca "Seu lote",
aviso no modal e "Voltar ao login"; e2e nos três papéis; produto.md 11, índice de
decisões, plano mestre e `docs/operacao.md` atualizados.

## Perguntas do agente e respostas do autor

- Plano (`r1`): oito invariantes do modelo que a mudança quebraria, achadas na leitura do
  código antes do plano; recomendações para as quatro perguntas deixadas em aberto na
  abertura (conta encerrada em vez de apagada, purga do próprio lote com aviso, textos,
  invariantes); e três perguntas novas. A principal: a ordem "a coordenação pode tudo, sem
  exceção" permitiria a um avaliador trocar o e-mail de um aluno do seed por um endereço
  real, disparar e-mail do produto para um terceiro e tomar a conta; o agente propôs
  limitar a correção feita por conta de demonstração a domínios reservados `.invalid` e
  perguntou, por contrariar a instrução. Autor aceitou a exceção.
- Etapas 1 a 5 (`r2`): capturas conferidas; três decisões declaradas aceitas.
- Etapa 6 (`r3`): aprovada com ajuste de concordância no modal; largura da folha de
  confirmação confirmada como herança do passo 12 e registrada como limite conhecido.
- Fechamento (`r4`).

## Decisões do agente sem o prompt pedir (declaradas)

Marca `demo` no token em vez de barrar conta encerrada na busca de quem age; sufixos
`-PROF` e `-UNIMAX` nos arrobas; tela própria "Aluno de teste"; texto da mensagem do
`.invalid`; "Abre no navegador." só no aparelho; id da conta na lembrança do dispositivo;
textos da introdução, do modal e do resultado da purga; lista sem recarregar depois da
purga do próprio lote; nome "Conferência Maxx" nas contas da conferência no ar; envio da
`rodada/eng_14_demo_papeis` ao GitHub como base do PR; início do Docker Desktop na máquina
do autor.

## Observações

- A pergunta sobre a correção de e-mail é o caso mais claro, na trilha, de o agente
  recusar seguir uma instrução ampla do operador ao pé da letra e perguntar: a regra do
  `CLAUDE.md` vale também contra uma ordem do próprio autor quando ela abre um risco que
  os documentos não previram.
- Um bug pego pelos testes antes do push (o registro da coordenação respondia 500) e uma
  CI vermelha (mensagem ausente para um código de erro novo), corrigida em fix separado.
- Três testes de e2e falharam localmente com a suíte em paralelo e passaram rodados de
  novo; a CI passou. Ocorrência de ambiente, declarada.
- O agente leu do `.env` da VPS só a linha do lote e a da versão no ar, e declarou.
- As capturas de todas as etapas com tela e da conferência no ar foram copiadas para o
  repositório do TCC; nos passos anteriores elas ficaram em pastas temporárias e se
  perderam, o que fica como limite do registro.
