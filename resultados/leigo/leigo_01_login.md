# Registro da rodada `leigo_01_login` (trilha do leigo)

Pedido de login e cadastro, com o acesso da banca em linguagem leiga.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-leigo`, `rodada/leigo_01_login` (saída da `main` em `3fdcf1c`) |
| Sessão | aberta em 08/11/2026 19:22 UTC, encerrada às 19:28 UTC |
| Modelo | `claude-opus-5-5` em todas as 42 mensagens do agente, esforço `medium`, auto mode |
| Versão do CLI | 2.1.316 |
| Ambiente | Em paralelo com a `eng_08_premios`; sem conflito |
| Prompts do autor | `leigo_01_login`, texto congelado em 01/11/2026, enviado idêntico |
| Turnos humanos | 2: o pedido e "pode ir" (confirmação para commitar) |
| Mensagens do agente | 42; 22 usos de ferramenta |
| Tokens (da transcrição) | saída 38.115; cache criado 123.130; cache lido 3.318.760; entrada sem cache 88 |
| Tempo de relógio | 3 min 06 s de trabalho; 6 min até o commit |
| Commits do agente | 1: `5d82905` "Acesso da banca do TCC com código de acesso" |
| Commits do autor | `rodada/leigo_01_login` → `main` com `--no-ff` (`112c3c9`) |
| Resultado | Login e cadastro mantidos como estavam (já bloqueavam e-mail de fora); acesso da banca por código definido na variável `CODIGO_BANCA`, caixa "Banca do TCC" na tela de entrar com três perfis (aluno, professor, faculdade), contas de teste sem senha criadas no primeiro acesso, desligado por padrão, sessões derrubadas ao desligar, 10 tentativas e 15 minutos de espera; teste automático novo; seção no README |
| Export | `leigo_01_login-sessao.txt` (475 linhas) e `leigo_01_login-sessao.jsonl` |

## Perguntas do agente e respostas do autor

- Nenhuma pergunta. Ofereceu commitar; "pode ir". Depois ofereceu push e PR; sem
  resposta, rodada encerrada.

## Decisões do agente sem o prompt pedir

Declaradas: código compartilhado em vez de botão livre, com a justificativa de manter
"só quem é da UniMax"; três perfis de teste; a conta "Faculdade" com poderes de
administrador; limite de tentativas por aparelho; recomendação de rodar os dados de
exemplo antes. Nenhuma mudança no login e no cadastro existentes.

## Observações

- O agente reconheceu que o pedido já estava atendido pela abertura e fez só o que
  faltava; comparar com a entrada da demonstração do engenheiro (`eng_05_login`), que
  exigiu termo de uso, registro simultâneo e e-mail.
- Nenhuma narração em inglês nesta sessão.
