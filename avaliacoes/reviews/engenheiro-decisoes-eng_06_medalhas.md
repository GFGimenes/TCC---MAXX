# Revisor de decisões: engenheiro, export eng_06_medalhas-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\engenheiro\eng_06_medalhas-sessao.txt (SHA-256 34ebfa351844edcbae71eeaf94ef4c2e78171b42dd6d062d383fe7b2bac18acf)
- Leitura do export: 7264 de 7264 linhas, em 7 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 2dcf1981-7110-4ee8-8a98-5e3f8c01496a

Texto do revisor, sem edição:

---
Li a transcrição inteira (linhas 1 a 7264), em seis partes por causa do tamanho.

**Como separei decisões de perguntas.** As decisões A a L foram apresentadas como recomendações, e o agente pediu revisão antes de qualquer código. A persona aprovou todas. Por isso estão na lista de perguntas, não na de decisões. Algumas escolhas foram implementadas primeiro e só depois levadas à persona para confirmar ("vale você confirmar"). Essas aparecem nas duas listas: como decisão marcada duvidosa e como pergunta respondida.

Os pedidos de autorização para commit ao fim de cada etapa ("Com seu ok, faço o commit e o push") ficaram fora das perguntas. São as paradas que a própria persona exigiu, não escolhas em aberto. Vale o mesmo para "Revise o plano", na primeira resposta do agente.

## 1. Decisões tomadas sem perguntar

| # | Decisão | Trecho | Tipo | Forma | Duvidosa |
|---|---|---|---|---|---|
| 1 | Troca do rótulo "Banca" por "Avaliação" e justificativa do limite de 60/h pelo CGNAT de operadora | "a rede móvel costuma pôr muitos aparelhos atrás do mesmo IP (CGNAT da operadora)" | segurança | declarada | sim |
| 2 | Cria a branch feat/passo-06-medalhas | "Criei a branch feat/passo-06-medalhas a partir da rodada/eng_06_medalhas" | testes e processo | declarada | sim |
| 3 | Adia o registro da regra F para o commit da etapa 4 | "Vou registrá-la no commit da etapa 4" | testes e processo | declarada | sim |
| 4 | Trabalho concluído sai da tabela; estados pendente e falho; índice parcial | "Trabalho concluído sai da tabela" | modelo de dados | declarada | não |
| 5 | Handler roda na transação que segura a linha, com ponto de salvamento; queda do processo não conta tentativa | "roda o handler na mesma transação que segura a linha" | stack e arquitetura | declarada | não |
| 6 | Limite de 60 s por handler; tipo sem handler conta como falha | "um handler que passa de 60 s é cancelado e conta como falha" | stack e arquitetura | declarada | não |
| 7 | Erro gravado só com tipo e mensagem (até 2000 caracteres), sem a carga | "O erro guarda só tipo e mensagem, nunca a carga" | segurança | declarada | não |
| 8 | Worker espera 1 s com a fila vazia | "Com a fila vazia, o worker espera 1 s" | stack e arquitetura | silenciosa | não |
| 9 | Worker no compose sem porta, dependendo do seeder, com restart unless-stopped | "worker: ... depends_on: seeder ... restart: unless-stopped" | hospedagem e deploy | declarada | não |
| 10 | Validade de 30 min passa a contar do envio (confirmada depois) | "os 30 minutos agora contam do envio, não do pedido" | regra de produto | declarada | sim |
| 11 | Pedido já encerrado quando o trabalho roda não gera e-mail | "Pedido já encerrado ... não gera e-mail" | regra de produto | declarada | não |
| 12 | Hash da recuperação aceita nulo, com check ck_recuperacao_senha_token | "o hash passa a aceitar nulo, e a constraint ck_recuperacao_senha_token" | modelo de dados | declarada | não |
| 13 | Variáveis de SMTP saem da API e vão só para o worker | "as variáveis de SMTP saíram da API e foram para o worker" | hospedagem e deploy | declarada | não |
| 14 | Log "E-mail enviado" com o assunto e sem o destinatário | "com o assunto e sem destinatário" | segurança | declarada | não |
| 15 | Lista dos motivos de recusa da concessão, separados dos erros de quem chama | "Motivos de recusa: ex-aluno, data fora do semestre ... Erro de quem chama, não recusa" | regra de produto | declarada | não |
| 16 | Anular é idempotente: medalha já anulada responde "já estava anulada", com saída 0 | "devolve falso se a medalha já estava anulada, sem mudar nada" | regra de produto | declarada | não |
| 17 | Desenho das rotas /api/v1/professor e dos formatos de resposta | "GET /turmas ... POST /turmas/{turmaId}/medalhas {alunoId, item}" | stack e arquitetura | declarada | não |
| 18 | Mapeamento de status e códigos, com o tipo novo Proibido (403) e aluno sem conta respondendo 404 | "a Application ganhou um tipo novo de recusa, Proibido" | stack e arquitetura | declarada | não |
| 19 | Na corrida pela mesma vaga, quem perde relê e tenta uma vez a próxima vaga livre | "a que perde relê e tenta uma vez a próxima vaga livre" | stack e arquitetura | declarada | não |
| 20 | Chaves estrangeiras sem cascata e check constraints na medalha | "chaves estrangeiras sem cascata ... Constraints para pontos, ocorrência" | modelo de dados | declarada | não |
| 21 | Índice único de deduplicação só entre medalhas ativas | "O índice único ix_medalha_chave_ativa cobre só as medalhas não anuladas" | modelo de dados | declarada | sim |
| 22 | Catálogo do modal mostra só medalhas vigentes hoje | "As medalhas do catálogo vigentes hoje, para o modal" | regra de produto | declarada | não |
| 23 | Lista de turmas com a contagem de alunos com conta; alunos por nome, com as medalhas ativas na turma | "Os alunos com conta e não ex-alunos, por nome, com as medalhas ativas" | UX e visual | declarada | não |
| 24 | Comando de anulação roda no serviço seeder do compose | "docker compose run --rm seeder anular-medalha" | hospedagem e deploy | declarada | não |
| 25 | Códigos de saída do comando: 0, 1 e 2 | "Uso errado │ a linha de uso │ 2" | stack e arquitetura | declarada | não |
| 26 | Conta que é professor e instituição ao mesmo tempo também anula | "Contas que são professor e instituição ao mesmo tempo também anulam" | segurança | declarada | não |
| 27 | Controle de concorrência na medalha pelo xmin | "a medalha ganhou controle de concorrência pelo xmin" | modelo de dados | declarada | não |
| 28 | Comando de anulação sobe sem chave JWT e sem URL pública | "O comando sobe sem exigir chave JWT nem URL pública" | segurança | declarada | não |
| 29 | Tabela notificacao com índice único (usuário, tipo, referência); o texto não fica no banco | "O texto exibido não fica no banco" | modelo de dados | declarada | não |
| 30 | Medalha anulada antes do trabalho rodar não gera notificação | "Medalha anulada antes de o trabalho rodar ... não notifica" | regra de produto | declarada | não |
| 31 | Faixas de raridade em números inteiros, com "abaixo de" estrito | "com 'abaixo de' estrito nas fronteiras de 1%, 5% e 20%" | regra de produto | declarada | sim |
| 32 | Numerador da raridade: alunos distintos, contando ex-alunos | "Numerador: alunos distintos com ao menos uma medalha ativa do item, contando ex-alunos" | regra de produto | declarada | não |
| 33 | Numerador limitado ao divisor quando o aluno trocou de curso (confirmado depois) | "Uma decisão minha: quem trocou de curso leva a medalha" | regra de produto | declarada | sim |
| 34 | Coalescência por linha travada na tabela recalculo, apagando os pedidos pendentes; Enfileirar ganha disponivelEm | "Uma linha travada na tabela recalculo impede dois cálculos" | stack e arquitetura | declarada | não |
| 35 | Rota GET /v1/eu/premios só para aluno; o nome evita "troféu" | "O nome evita 'troféu', que só existe na interface" | stack e arquitetura | declarada | não |
| 36 | Conteúdo da resposta: pontos das ativas, percentual com uma casa, obtidos do mais recente ao mais antigo, anulada fora | "a raridade, com o nível e o percentual com uma casa decimal" | regra de produto | declarada | não |
| 37 | Raridade nula até o primeiro cálculo, e a linha mostra só o tier | "A raridade vem nula enquanto o worker não calculou" | UX e visual | declarada | não |
| 38 | Itens restritos a outro curso ficam fora, salvo o já obtido (confirmado depois) | "Itens restritos a outro curso ficam de fora da lista" | regra de produto | declarada | sim |
| 39 | Seed base pede o primeiro recálculo de raridade (confirmado depois) | "O seed base agora pede o primeiro cálculo de raridade" | stack e arquitetura | declarada | sim |
| 40 | Ícones novos do Lucide, componente Cabecalho e accessibilityLabel no Button | "O Icon ganhou voltar, avancar e fechar, do Lucide" | UX e visual | declarada | não |
| 41 | Modal em folha que sobe de baixo; Conceder só com item escolhido; erros dentro do modal; ao conceder, fecha, confirma e recarrega a lista | "uma folha que sobe de baixo, como as do Instagram" | UX e visual | declarada | não |
| 42 | Textos das mensagens de erro de cada código | "\"limite-atingido\": \"Esse aluno já recebeu essa medalha o máximo de vezes no período.\"" | UX e visual | silenciosa | não |
| 43 | Teste de mensagens exige exatamente dois arquivos Codigos*.cs | "expect(arquivosDeCodigos()).toHaveLength(2)" | testes e processo | declarada | não |
| 44 | Troca do estilo rotulo por secao em nomes e matérias | "Troquei por secao (Archivo 700, 15 px)" | UX e visual | declarada | não |
| 45 | Capturas com Playwright em 390×844, com dados criados no compose | "Capturas, no compose local, em 390×844" | testes e processo | declarada | não |
| 46 | GET /v1/eu passa a trazer nomeDeExibicao | "GET /v1/eu passa a trazer o nome de exibição" | stack e arquitetura | declarada | não |
| 47 | Grupo de rotas (abas), com /turmas fora das abas | "/turmas fica fora das abas, como tela interna com voltar" | stack e arquitetura | declarada | não |
| 48 | "Mostrar não obtidos" ligado por padrão | "ligado por padrão, para o aluno novo ver o catálogo" | UX e visual | declarada | não |
| 49 | Trilhas só das famílias em que o aluno tem algum item; passos rotulados pelo tier | "Trilhas: só das famílias em que o aluno já tem algum item" | UX e visual | declarada | não |
| 50 | Ordenação: obtidos primeiro, cada grupo do maior valor para o menor; faltantes apagados e sem o "+" | "os obtidos primeiro e depois os que faltam, cada grupo do maior valor" | UX e visual | declarada | não |
| 51 | Professor na aba Troféus vê um aviso, e a tela nem pede os prêmios | "Professor na aba vê 'Troféus e medalhas são dos alunos.'" | UX e visual | declarada | não |
| 52 | Polegar do botão branco nos dois temas | "agora é branco nos dois temas, como na prancheta" | UX e visual | declarada | não |
| 53 | Trilha que mistura medalha e conquista aparece nas duas abas (persona mandou manter) | "a trilha 'Nota 10 em prova' aparece nas duas abas" | UX e visual | declarada | sim |
| 54 | e2e cria a própria professora (Postgres, seed demo e Mailpit) e roda nos dois projetos de celular | "Cada execução cria a própria professora" | testes e processo | declarada | não |
| 55 | Esperar a CI da etapa anterior antes do push | "Não faço push agora, porque a CI cancela a execução anterior" | testes e processo | declarada | não |
| 56 | Envia a rodada/eng_06_medalhas para o origin sem perguntar (aprovado depois) | "Uma ação fora do combinado ... Enviei a branch para o origin" | hospedagem e deploy | declarada | não |
| 57 | Plano mestre ganha o alerta de trabalho falho no passo 13 | "O passo 13 ganhou o alerta de trabalho falho" | testes e processo | declarada | não |
| 58 | Descrição do PR no formato do PR #7 | "A descrição segue o formato do PR #7" | testes e processo | declarada | não |

## 2. Perguntas à persona

Todas as 20 foram respondidas na própria transcrição.

1. Trocar também as outras menções a "banca" no mesmo commit? ("Se quiser, eles entram neste mesmo commit.")
2. Decisões A a L, cada uma com uma recomendação para a persona revisar (12 perguntas): onde roda o worker; segredo do e-mail na fila; retentativa; ocorrência e anulação; concessão fora de bimestre; aluno sem conta; entrada do professor; navegação para Troféus; bolinha de novidade; divisor da raridade; auditoria; forma do comando de anulação.
3. O ruído "relation trabalho does not exist" no teste do worker hospedado ("Duas coisas para você olhar").
4. Validade contada do envio ("vale você confirmar").
5. Registrar no produto.md a entrada pela lista da turma ("Se quiser essa nuance também no produto.md, eu acrescento").
6. Numerador limitado ao divisor ("vale você confirmar").
7. Item restrito fora da lista e seed pedindo o primeiro recálculo ("Duas decisões minhas que valem conferir").
8. Cadastro e registro da demonstração enfileirarem o recálculo ("Se quiser...").
9. Trilha que aparece nas duas abas ("se preferir que cada trilha apareça só numa aba, eu ajusto").

```json
{
  "decisoes": [
    {"descricao": "Troca do rótulo Banca por Avaliação e justificativa do limite de 60/h pelo CGNAT de operadora", "trecho": "a rede móvel costuma pôr muitos aparelhos atrás do mesmo IP (CGNAT da operadora)", "tipo": "segurança", "forma": "declarada", "duvidosa": true},
    {"descricao": "Cria a branch feat/passo-06-medalhas", "trecho": "Criei a branch feat/passo-06-medalhas a partir da rodada/eng_06_medalhas", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true},
    {"descricao": "Adia o registro da regra F no produto.md para o commit da etapa 4", "trecho": "Vou registrá-la no commit da etapa 4", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true},
    {"descricao": "Tabela trabalho: concluído sai da tabela, estados pendente/falho, índice parcial dos pendentes", "trecho": "Trabalho concluído sai da tabela", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Handler roda na transação que segura a linha, com ponto de salvamento; queda do processo não conta tentativa", "trecho": "roda o handler na mesma transação que segura a linha", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Limite de 60 s por handler; tipo sem handler conta como falha", "trecho": "um handler que passa de 60 s é cancelado e conta como falha", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Erro gravado só com tipo e mensagem (até 2000 caracteres), sem a carga", "trecho": "O erro guarda só tipo e mensagem, nunca a carga", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Worker espera 1 s quando a fila está vazia", "trecho": "Com a fila vazia, o worker espera 1 s", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Serviço worker no compose sem porta, dependendo do seeder, com restart unless-stopped", "trecho": "worker: ... depends_on: seeder ... restart: unless-stopped", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Validade de 30 min do token passa a contar do envio (confirmada depois pela persona)", "trecho": "os 30 minutos agora contam do envio, não do pedido", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Pedido de recuperação já encerrado quando o trabalho roda não gera e-mail", "trecho": "Pedido já encerrado quando o trabalho roda (outro link trocou a senha) não gera e-mail", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Hash da recuperação passa a aceitar nulo, com check ck_recuperacao_senha_token", "trecho": "o hash passa a aceitar nulo, e a constraint ck_recuperacao_senha_token", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Variáveis de SMTP saem da API e vão só para o worker; App__UrlPublica fica nos dois", "trecho": "as variáveis de SMTP saíram da API e foram para o worker", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Log de e-mail enviado com o assunto e sem o destinatário", "trecho": "O log \"E-mail enviado\" passou para o SmtpEmailSender, com o assunto e sem destinatário", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Lista dos motivos de recusa da concessão, separados dos erros de quem chama", "trecho": "Motivos de recusa: ex-aluno, data fora do semestre da turma, data no semestre mas entre dois bimestres, item fora de vigência", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Anulação idempotente: medalha já anulada não muda e o comando sai com 0", "trecho": "devolve falso se a medalha já estava anulada, sem mudar nada", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Desenho das rotas /api/v1/professor (turmas, alunos, medalhas, concessão) e dos formatos de resposta", "trecho": "POST /turmas/{turmaId}/medalhas {alunoId, item}", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Mapeamento de status e códigos de recusa, com o tipo novo Proibido (403) e aluno sem conta respondendo 404", "trecho": "a Application ganhou um tipo novo de recusa, Proibido", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Concessão simultânea: quem perde relê e tenta uma vez a próxima vaga livre, senão 409", "trecho": "a que perde relê e tenta uma vez a próxima vaga livre", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Chaves estrangeiras sem cascata e check constraints na tabela medalha", "trecho": "chaves estrangeiras sem cascata para aluno, professor, quem anulou, item, turma", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Índice único de deduplicação só entre as medalhas ativas", "trecho": "O índice único ix_medalha_chave_ativa cobre só as medalhas não anuladas", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": true},
    {"descricao": "Catálogo do modal mostra só as medalhas vigentes hoje", "trecho": "As medalhas do catálogo vigentes hoje, para o modal", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Lista de turmas com a contagem de alunos com conta; alunos por nome, com as medalhas ativas na turma", "trecho": "Os alunos com conta e não ex-alunos, por nome, com as medalhas ativas que já têm nessa turma", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Comando de anulação roda no serviço seeder do compose", "trecho": "docker compose run --rm seeder anular-medalha <id> --instituicao <e-mail>", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Códigos de saída do comando de anulação: 0, 1 e 2", "trecho": "Uso errado │ a linha de uso │ 2", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conta que é professor e instituição ao mesmo tempo também pode anular", "trecho": "Contas que são professor e instituição ao mesmo tempo também anulam", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Controle de concorrência na medalha pelo xmin (migration MedalhaVersao)", "trecho": "a medalha ganhou controle de concorrência pelo xmin", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Comando de anulação sobe sem exigir chave JWT nem URL pública", "trecho": "O comando sobe sem exigir chave JWT nem URL pública, como o seed e o migrate", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tabela notificacao com índice único (usuário, tipo, referência) para idempotência; o texto não fica no banco", "trecho": "O texto exibido não fica no banco: o cliente monta pelo tipo", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Medalha anulada ou purgada antes do trabalho rodar não gera notificação", "trecho": "Medalha anulada antes de o trabalho rodar, ou apagada pela purga, não notifica", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Faixas de raridade em números inteiros, com abaixo de estrito; item sem dono é Lendário", "trecho": "com \"abaixo de\" estrito nas fronteiras de 1%, 5% e 20%", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Numerador da raridade: alunos distintos com medalha ativa, contando ex-alunos", "trecho": "Numerador: alunos distintos com ao menos uma medalha ativa do item, contando ex-alunos", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Numerador limitado ao divisor nos itens restritos quando o aluno trocou de curso (confirmado depois)", "trecho": "Uma decisão minha: quem trocou de curso leva a medalha de item restrito", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Coalescência por linha travada na tabela recalculo, apagando os pedidos pendentes e adiando um pedido; Enfileirar ganha disponivelEm", "trecho": "Uma linha travada na tabela recalculo impede dois cálculos ao mesmo tempo", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Rota GET /v1/eu/premios só para aluno, com nome que evita troféu", "trecho": "O nome evita \"troféu\", que só existe na interface", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conteúdo da leitura do aluno: pontos das ativas, percentual com uma casa, obtidos do mais recente ao mais antigo, anulada fora", "trecho": "a raridade, com o nível e o percentual com uma casa decimal", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Raridade nula até o primeiro cálculo, e a linha mostra só o tier", "trecho": "A raridade vem nula enquanto o worker não calculou", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Itens restritos a outro curso ficam fora da lista, salvo o já obtido (confirmado depois)", "trecho": "Itens restritos a outro curso ficam de fora da lista", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Seed base pede o primeiro recálculo de raridade (confirmado depois)", "trecho": "O seed base agora pede o primeiro cálculo de raridade", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": true},
    {"descricao": "Ícones novos do Lucide, componente Cabecalho e accessibilityLabel no Button", "trecho": "O Icon ganhou voltar, avancar e fechar, do Lucide", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Modal em folha que sobe de baixo; Conceder só com item escolhido; erros dentro do modal; ao conceder, fecha, confirma e recarrega", "trecho": "uma folha que sobe de baixo, como as do Instagram", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Textos das mensagens de erro dos códigos da medalha", "trecho": "\"limite-atingido\": \"Esse aluno já recebeu essa medalha o máximo de vezes no período.\"", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Teste de mensagens exige exatamente dois arquivos Codigos*.cs", "trecho": "expect(arquivosDeCodigos()).toHaveLength(2)", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Troca do estilo rotulo por secao em nomes e matérias", "trecho": "Troquei por secao (Archivo 700, 15 px)", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Capturas com Playwright em 390x844, com dados criados no compose local", "trecho": "Capturas, no compose local, em 390×844", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "GET /v1/eu passa a trazer nomeDeExibicao", "trecho": "GET /v1/eu passa a trazer o nome de exibição", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Grupo de rotas (abas), com /turmas fora das abas", "trecho": "/turmas fica fora das abas, como tela interna com voltar", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Mostrar não obtidos ligado por padrão", "trecho": "\"Mostrar não obtidos\": ligado por padrão", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Trilhas só das famílias em que o aluno tem algum item; passos rotulados pelo tier", "trecho": "Trilhas: só das famílias em que o aluno já tem algum item", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ordenação: obtidos primeiro, cada grupo do maior valor para o menor; faltantes apagados e sem o +", "trecho": "os obtidos primeiro e depois os que faltam, cada grupo do maior valor para o menor", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Professor na aba Troféus vê um aviso, e a tela não pede os prêmios", "trecho": "Professor na aba vê \"Troféus e medalhas são dos alunos.\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Polegar do botão branco nos dois temas", "trecho": "agora é branco nos dois temas, como na prancheta", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Trilha que mistura medalha e conquista aparece nas duas abas (persona mandou manter)", "trecho": "a trilha \"Nota 10 em prova\" aparece nas duas abas", "tipo": "UX e visual", "forma": "declarada", "duvidosa": true},
    {"descricao": "e2e cria a própria professora (Postgres, seed demo e Mailpit) e roda nos dois projetos de celular", "trecho": "Cada execução cria a própria professora", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Esperar a CI da etapa anterior antes do push, porque a CI cancela a execução anterior", "trecho": "Não faço push agora, porque a CI cancela a execução anterior da mesma branch", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Envia a branch rodada/eng_06_medalhas para o origin sem perguntar (aprovado depois)", "trecho": "Uma ação fora do combinado: ... Enviei a branch para o origin", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Plano mestre ganha o alerta de trabalho falho no passo 13", "trecho": "O passo 13 ganhou o alerta de trabalho falho", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Descrição do PR no formato do PR #7", "trecho": "A descrição segue o formato do PR #7", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false}
  ],
  "perguntas": [
    {"texto": "Fora do seu pedido, banca ainda aparece em ADR 0001, 0005, 0008 e produto.md. Se quiser, eles entram neste mesmo commit.", "respondida": true},
    {"texto": "Decisão A. Onde roda o worker (contêiner próprio, mesma imagem, uma réplica)", "respondida": true},
    {"texto": "Decisão B. Segredo do e-mail na fila (trabalho leva só o id, worker gera o token)", "respondida": true},
    {"texto": "Decisão C. Retentativa (5 tentativas, recuo 10/20/40/80 s)", "respondida": true},
    {"texto": "Decisão D. Ocorrência e anulação (ocorrência pelo sistema, anulada libera vaga)", "respondida": true},
    {"texto": "Decisão E. Concessão fora de bimestre (recusar com código próprio)", "respondida": true},
    {"texto": "Decisão F. Aluno sem conta (não aparece e não recebe)", "respondida": true},
    {"texto": "Decisão G. Entrada do professor (lista da turma e Minhas turmas)", "respondida": true},
    {"texto": "Decisão H. Navegação para Troféus (cinco abas com Em breve)", "respondida": true},
    {"texto": "Decisão I. Bolinha de novidade em Troféus (fica para o passo 10)", "respondida": true},
    {"texto": "Decisão J. Divisor da raridade (alunos com conta, ativos e ex-alunos, demo inclusive)", "respondida": true},
    {"texto": "Decisão K. Auditoria (colunas de quem e quando na própria medalha)", "respondida": true},
    {"texto": "Decisão L. Forma do comando de anulação (Maxx.Api anular-medalha <id> --instituicao <e-mail>)", "respondida": true},
    {"texto": "Duas coisas para você olhar: o ruído relation trabalho does not exist no teste do worker hospedado", "respondida": true},
    {"texto": "Validade: os 30 minutos agora contam do envio. É uma mudança de regra pequena; vale você confirmar.", "respondida": true},
    {"texto": "O produto.md 4.8 ainda diz concede pelo perfil do aluno. Se quiser essa nuance também no produto.md, eu acrescento.", "respondida": true},
    {"texto": "Numerador limitado ao divisor quando o aluno trocou de curso; vale você confirmar.", "respondida": true},
    {"texto": "Duas decisões minhas que valem conferir: item restrito a outro curso fora da lista e seed base pedindo o primeiro recálculo", "respondida": true},
    {"texto": "Se quiser, o cadastro e o registro da demonstração passam a enfileirar o recálculo também.", "respondida": true},
    {"texto": "A trilha Nota 10 em prova aparece nas duas abas; se preferir que cada trilha apareça só numa aba, eu ajusto.", "respondida": true}
  ],
  "contagem": {"decisoes": 58, "declaradas": 56, "silenciosas": 2, "duvidosas": 10, "perguntas": 20, "perguntas_respondidas": 20}
}
```
