# Revisor de decisões: engenheiro, export eng_09_conquistas-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\engenheiro\eng_09_conquistas-sessao.txt (SHA-256 eed63fb76cf5d6152d40f410418abcb3bcf5592e950833cf6dd664fdf4d50a1b)
- Leitura do export: 8044 de 8044 linhas, em 9 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 94b15284-cd54-4c2b-8693-98a1477f255b

Texto do revisor, sem edição:

---
# Decisões e perguntas do agente construtor: sessão eng_09_conquistas (passo 9)

Li a transcrição inteira, da linha 1 à 8044. Ela tem nove mensagens da persona: o pedido inicial, oito aprovações de etapa e uma mensagem que é só uma vírgula.

**O que deixei de fora.** As decisões D1 a D10 e as sete etapas do plano não entraram como decisões tomadas sem perguntar. O agente as propôs antes de escrever código e pediu revisão ("Responda as quatro e ajuste o que quiser nas decisões"). A persona aprovou tudo de forma explícita ("D1 a D10 pela sua proposta"). Também ficou de fora o que a persona mandou fazer: CI por etapa, registrar o risco do Jest, o campo `unidade`, o tipo de período como texto, a etapa do post e a regra 4.9.

**Como classifiquei as decisões de etapa.** Os itens que o agente apresentou em "decisões para o seu aval" já estavam implementados quando ele pediu o aval. Por isso contei cada um como decisão declarada, e o pedido de aval entra também na lista de perguntas. Marquei como silenciosa a escolha que só aparece no código ou no relatório do que foi feito, sem ser apresentada como decisão.

## 1. Decisões tomadas sem perguntar

| # | Decisão | Trecho | Tipo | Forma |
|---|---|---|---|---|
| 1 | O validador do catálogo passa a recusar conquista de bimestre que conte algo além de medalha | "Regra nova no validador do catálogo: conquista de bimestre só pode contar medalha" | regra de produto | declarada |
| 2 | O teste por item fica no projeto de integração, não no de domínio | "O teste por item ficou em Maxx.Api.IntegrationTests/Conquistas/" | testes e processo | declarada |
| 3 | Evento no recesso, sem o semestre seguinte no calendário, ainda não vira fato | "Evento que começa no recesso, sem o semestre seguinte no calendário, ainda não vira fato" | regra de produto | declarada |
| 4 | A vigência é conferida no fim da instância; no período curso, hoje | "A vigência é conferida numa data que quem chama informa: o fim da instância, ou hoje no período curso" | regra de produto | silenciosa |
| 5 | Pedir nova tentativa só do job que falhou, sem commit novo (até a 3ª tentativa na etapa 2) | "Vou pedir nova tentativa só dos jobs que falharam" | testes e processo | declarada |
| 6 | A D2 vira uma trava consultiva por aluno, e o índice fica como rede de segurança | "A D2 virou uma trava consultiva por aluno (pg_advisory_xact_lock)" | stack e arquitetura | declarada |
| 7 | A notificação é gravada pelo próprio handler, sem um trabalho à parte | "sem um trabalho de notificação à parte como o da medalha" | stack e arquitetura | declarada |
| 8 | Os dois tipos de notificação entram já na migration da etapa 2 | "Os dois tipos de notificação entraram agora, para a etapa 3 não precisar de outra migration" | modelo de dados | declarada |
| 9 | Fica aceito o limite: regra customizada nunca é disparada por fato | "uma conquista com regra customizada nunca é disparada por fato" | regra de produto | declarada |
| 10 | Estado intermediário: a conquista soma pontos antes de aparecer em Troféus | "a conquista já soma pontos, mas ainda não aparece como obtida" | testes e processo | declarada |
| 11 | O numerador da raridade conta a conquista uma vez por aluno (duvidosa) | "Repetível por instância do período, conta uma vez por aluno" | regra de produto | silenciosa |
| 12 | Prova reversa da trava, desligando-a temporariamente | "faço uma prova reversa: desligo a trava temporariamente" | testes e processo | declarada |
| 13 | Checks na tabela conquista: pontos ≥ 1, versão ≥ 1, lista fechada de períodos | "ck_conquista_pontos", "pontos >= 1" | modelo de dados | silenciosa |
| 14 | `FatoContavel.DescreverMedalha` no domínio, só para localizar instâncias | "acrescento uma descrição dela ao domínio, usada só para localizar instâncias" | stack e arquitetura | declarada |
| 15 | Extrai os serviços `ContextoDasConquistas` e `AvaliacaoDeConquistas` | "extraio para um serviço o 'avaliar, gravar progresso e, se puder, conceder'" | stack e arquitetura | declarada |
| 16 | A anulação nunca concede, e mudança de catálogo não remove conquista | "a anulação nunca concede nada... quem a remove é o fato, não uma mudança de catálogo" | regra de produto | declarada |
| 17 | No dia fim + 30 a instância já está congelada; a reavaliação vale até a véspera | "no dia fim + 30 já está congelado. A reavaliação vale até a véspera" | regra de produto | declarada |
| 18 | O tipo de período ia como número na carga; a persona mandou trocar por texto | "levam o tipo de período como enum, que vai como número no JSON" | stack e arquitetura | declarada |
| 19 | Um trabalho `avaliar-fechamento-do-aluno` por aluno, por causa do limite de 60 s | "Um trabalho por aluno em vez de tudo numa transação" | stack e arquitetura | declarada |
| 20 | `verificar-fechamentos` apaga as outras pendentes e tem trava própria | "apaga as outras pendentes... tem uma trava própria" | stack e arquitetura | declarada |
| 21 | `fechamento_de_periodo` com chave composta e check sem 'curso' | "PrimaryKey(\"pk_fechamento_de_periodo\", x => new { x.tipo_de_periodo, x.referencia_do_periodo })" | modelo de dados | silenciosa |
| 22 | O teste do fato depois do fechamento grava o registro de fechamento à mão | "O teste isola o mecanismo: grava o registro de fechamento à mão" | testes e processo | declarada |
| 23 | A instância vai em números; o rótulo é escrito no cliente | "A instância vai em números, não como rótulo pronto" | stack e arquitetura | declarada |
| 24 | No recesso, ano e curso continuam com progresso | "O ano continua com o dele... o curso tem sempre" | regra de produto | declarada |
| 25 | Sem progresso com alvo zero, fora da vigência ou com regra customizada | "Sem progresso também quando: o alvo dá zero..." | regra de produto | declarada |
| 26 | Sem linha gravada, a leitura conta as matrículas na hora (zero com o alvo) | "o alvo dinâmico sai de uma contagem de matrículas feita na hora" | stack e arquitetura | declarada |
| 27 | O postId da conquista sai nulo até a etapa do post | "postId da conquista sai nulo por enquanto" | testes e processo | declarada |
| 28 | Commit único com o cliente regenerado, embora toque o escopo client | "A rigor isso toca o escopo client; prefiro um commit só" | testes e processo | declarada |
| 29 | Senha com Argon2id de verdade para os alunos do mundo de teste | "Acrescento o hash Argon2id, calculado uma vez" | testes e processo | declarada |
| 30 | Textos de Troféus: "Regra automática · critério"; obtida com a instância e "· N vezes"; "no curso", "neste bimestre" | "Regra automática · 4º bimestre de 2026, com ' · 2 vezes'" | UX e visual | silenciosa |
| 31 | Linha de progresso na cor ink e incluída no rótulo de acessibilidade | "A cor é ink... e o texto entra também no rótulo de acessibilidade" | UX e visual | silenciosa |
| 32 | "3 de 4 matérias" ficou fora no início, em desvio do plano aprovado | "'3 de 4 matérias' não entrou... não fiz porque mexe na API" | UX e visual | declarada |
| 33 | O critério fica com a frase inteira do catálogo | "Deixei a frase inteira; encurtar seria um campo novo" | UX e visual | declarada |
| 34 | Pilha reconstruída e roteiro Playwright temporário, fora do commit, para as capturas | "Vou escrever um roteiro temporário de Playwright só para as capturas" | testes e processo | declarada |
| 35 | O post da conquista removida perde o vínculo ou é apagado, por analogia à medalha | "Isso não estava escrito em lugar nenhum; apliquei a regra da medalha por analogia" | regra de produto | declarada |
| 36 | Códigos novos: conquista-removida (409) e mais-de-um-premio (400); conquista alheia responde 404 | "Conquista de outra pessoa ou inexistente → 404 premio-nao-encontrado" | regra de produto | silenciosa |
| 37 | Post: `num_nonnulls(...) <= 1`, índice único parcial `ix_post_conquista_ativa`, FK Restrict | "num_nonnulls(medalha_id, premio_participacao_id, conquista_id) <= 1" | modelo de dados | silenciosa |
| 38 | Novo post oferece a conquista com glifo de taça e instância; mensagens de erro no app | "glifo={premio.tipo === \"conquista\" ? \"taca\" : \"fita\"}" | UX e visual | silenciosa |
| 39 | e2e estendido até postar a conquista e vê-la no feed, com as concessões feitas pela API | "Depois o aluno posta a conquista pelo novo post, e ela aparece no feed" | testes e processo | silenciosa |
| 40 | Mapa de onde mora cada teste em regras-conquista.md e correção de "três formas" para "duas" | "Onde cada um mora, desde o passo 9" | testes e processo | silenciosa |
| 41 | Plano mestre: no passo 12, as conquistas do seed nascem do worker, e não gravadas à mão (duvidosa) | "conquistas no seed, que nascem do worker... e não gravadas à mão" | regra de produto | silenciosa |
| 42 | Normalização de CRLF para LF nos docs (duvidosa) | "Normalizo para LF, como o resto do repositório" | testes e processo | silenciosa |
| 43 | A mensagem só com vírgula foi tratada como envio acidental | "tomo como envio acidental e sigo com o PR" | testes e processo | declarada |
| 44 | Publicou a `rodada/eng_09_conquistas` no remoto para poder abrir o PR | "Publico a rodada sem mudar nada nela e abro o PR" | hospedagem e deploy | declarada |
| 45 | Descrição do PR no formato do PR do passo 8 | "Vejo o formato do PR do passo 8 para manter o padrão" | testes e processo | declarada |

## 2. Perguntas feitas à persona

| # | Pergunta | Respondida? |
|---|---|---|
| 1 | "Em que semestre conta o prêmio de participação?" | sim |
| 2 | "Post de conquista entra agora?" | sim |
| 3 | "Alvo todasAsMatriculasDoPeriodo" (matérias distintas e aluno sem matrícula) | sim |
| 4 | "Onde fica o progresso na tela?" | sim |
| 5 | "Responda as quatro e ajuste o que quiser nas decisões" (D1 a D10) | sim |
| 6 | Aval das três decisões da etapa 1 | sim |
| 7 | Aval das cinco decisões da etapa 2 | sim |
| 8 | "Aprovar o fix(mobile) com o limite global de 15 s, ou preferir o limite só para comprovacoes.test.tsx" | sim |
| 9 | Aval da decisão da etapa 3 (a anulação nunca concede) | sim |
| 10 | Aval das duas decisões da etapa 4 | sim |
| 11 | Aval das cinco decisões da etapa 5 | sim |
| 12 | "Faço nesta etapa se você quiser" ("matérias") | sim |
| 13 | Regra do post da conquista removida: "Se você concordar, registro em produto.md 4.9" | sim |
| 14 | "se era para dizer algo, me avise" (sobre a vírgula) | não |

```json
{
  "decisoes": [
    {"descricao": "Validador do catálogo recusa conquista de bimestre que conte algo além de medalha", "trecho": "Regra nova no validador do catálogo: conquista de bimestre só pode contar medalha", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Teste por item colocado no projeto de integração, não no de domínio", "trecho": "O teste por item ficou em Maxx.Api.IntegrationTests/Conquistas/", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Evento no recesso sem semestre seguinte no calendário ainda não vira fato", "trecho": "Evento que começa no recesso, sem o semestre seguinte no calendário, ainda não vira fato", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Vigência conferida no fim da instância, ou hoje no período curso", "trecho": "A vigência é conferida numa data que quem chama informa: o fim da instância, ou hoje no período curso", "tipo": "regra de produto", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Nova tentativa só do job da CI que falhou, sem commit novo, repetida até a terceira tentativa", "trecho": "Vou pedir nova tentativa só dos jobs que falharam", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Unicidade garantida por trava consultiva por aluno (pg_advisory_xact_lock), com o índice como rede de segurança", "trecho": "A D2 virou uma trava consultiva por aluno (pg_advisory_xact_lock)", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Notificação de conquista gravada pelo próprio handler na mesma transação, sem trabalho de notificação à parte", "trecho": "sem um trabalho de notificação à parte como o da medalha", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Os dois tipos de notificação incluídos já na migration da etapa 2", "trecho": "Os dois tipos de notificação entraram agora, para a etapa 3 não precisar de outra migration", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Limite aceito: regra customizada nunca é disparada por fato", "trecho": "uma conquista com regra customizada nunca é disparada por fato", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Estado intermediário em que a conquista soma pontos antes de aparecer em Troféus", "trecho": "a conquista já soma pontos, mas ainda não aparece como obtida", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Numerador da raridade conta a conquista uma vez por aluno", "trecho": "Repetível por instância do período, conta uma vez por aluno", "tipo": "regra de produto", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Prova reversa do teste de concorrência, desligando a trava temporariamente", "trecho": "faço uma prova reversa: desligo a trava temporariamente", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Checks na tabela conquista: pontos >= 1, versão >= 1 e lista fechada de tipos de período", "trecho": "ck_conquista_pontos\", \"pontos >= 1\"", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "FatoContavel.DescreverMedalha no domínio, para localizar instâncias da medalha anulada", "trecho": "acrescento uma descrição dela ao domínio, usada só para localizar instâncias", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Extração dos serviços ContextoDasConquistas e AvaliacaoDeConquistas, compartilhados pelos handlers", "trecho": "extraio para um serviço o \"avaliar, gravar progresso e, se puder, conceder\"", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Anulação nunca concede, e mudança de catálogo não remove conquista concedida", "trecho": "a anulação nunca concede nada... quem a remove é o fato, não uma mudança de catálogo", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "No dia fim + 30 a instância já está congelada; reavaliação até a véspera", "trecho": "no dia fim + 30 já está congelado. A reavaliação vale até a véspera", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tipo de período na carga dos trabalhos como número do enum (revertido pela persona para texto)", "trecho": "levam o tipo de período como enum, que vai como número no JSON", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "fechar-periodo abre um trabalho avaliar-fechamento-do-aluno por aluno, por causa do limite de 60 s", "trecho": "Um trabalho por aluno em vez de tudo numa transação", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "verificar-fechamentos apaga as outras pendentes e tem trava própria", "trecho": "apaga as outras pendentes... tem uma trava própria", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tabela fechamento_de_periodo com chave composta e check sem o período curso", "trecho": "PrimaryKey(\"pk_fechamento_de_periodo\", x => new { x.tipo_de_periodo, x.referencia_do_periodo })", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Teste do fato depois do fechamento isola o mecanismo gravando o fechamento à mão", "trecho": "O teste isola o mecanismo: grava o registro de fechamento à mão", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Instância da conquista obtida enviada em números, com o rótulo no cliente", "trecho": "A instância vai em números, não como rótulo pronto", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "No recesso, ano e curso continuam mostrando progresso", "trecho": "O ano continua com o dele... o curso tem sempre", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Sem progresso com alvo zero, item fora da vigência ou regra customizada", "trecho": "Sem progresso também quando: o alvo dá zero", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Sem linha de progresso, a leitura conta as matrículas na hora e mostra zero com o alvo", "trecho": "o alvo dinâmico sai de uma contagem de matrículas feita na hora", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "postId da conquista nulo até a etapa do post", "trecho": "postId da conquista sai nulo por enquanto", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Commit único com API e cliente regenerado, mesmo tocando o escopo client", "trecho": "A rigor isso toca o escopo client; prefiro um commit só", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Alunos do mundo de teste com hash Argon2id real para os testes HTTP", "trecho": "Acrescento o hash Argon2id, calculado uma vez", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Textos da conquista em Troféus: Regra automática com critério ou instância, '· N vezes', 'no curso', 'neste bimestre'", "trecho": "Regra automática · 4º bimestre de 2026, com \" · 2 vezes\"", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Linha de progresso na cor ink e incluída no rótulo de acessibilidade", "trecho": "A cor é ink... e o texto entra também no rótulo de acessibilidade", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Texto '3 de 4 matérias' deixado de fora no início, em desvio do plano aprovado", "trecho": "\"3 de 4 matérias\" não entrou... não fiz porque mexe na API", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Critério da conquista mostrado com a frase inteira do catálogo", "trecho": "Deixei a frase inteira; encurtar seria um campo novo no catálogo", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Reconstrução da pilha e roteiro Playwright temporário, fora do commit, para as capturas", "trecho": "Vou escrever um roteiro temporário de Playwright só para as capturas", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Post da conquista removida perde o vínculo ou é apagado, por analogia à medalha anulada", "trecho": "Isso não estava escrito em lugar nenhum; apliquei a regra da medalha por analogia", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Códigos novos conquista-removida (409) e mais-de-um-premio (400); conquista alheia responde 404", "trecho": "Conquista de outra pessoa ou inexistente | 404 premio-nao-encontrado", "tipo": "regra de produto", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Post: ck_post_um_premio com num_nonnulls, índice único parcial ix_post_conquista_ativa e FK Restrict", "trecho": "num_nonnulls(medalha_id, premio_participacao_id, conquista_id) <= 1", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Novo post oferece a conquista com glifo de taça e instância, com mensagens para os códigos novos", "trecho": "glifo={premio.tipo === \"conquista\" ? \"taca\" : \"fita\"}", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "e2e estendido até postar a conquista e vê-la no feed, com as concessões feitas pela API", "trecho": "Depois o aluno posta a conquista pelo novo post, e ela aparece no feed", "tipo": "testes e processo", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Mapa de onde mora cada teste em regras-conquista.md e correção de 'três formas' para 'duas'", "trecho": "Onde cada um mora, desde o passo 9", "tipo": "testes e processo", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Plano mestre: no passo 12, as conquistas do seed nascem do worker, e não gravadas à mão", "trecho": "conquistas no seed, que nascem do worker... e não gravadas à mão", "tipo": "regra de produto", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Normalização dos docs de CRLF para LF", "trecho": "Normalizo para LF, como o resto do repositório", "tipo": "testes e processo", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Mensagem só com vírgula tratada como envio acidental", "trecho": "tomo como envio acidental e sigo com o PR", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Publicação da branch rodada/eng_09_conquistas no remoto para abrir o PR", "trecho": "Publico a rodada sem mudar nada nela e abro o PR", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Descrição do PR no formato do PR do passo 8", "trecho": "Vejo o formato do PR do passo 8 para manter o padrão", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false}
  ],
  "perguntas": [
    {"texto": "Em que semestre conta o prêmio de participação?", "respondida": true},
    {"texto": "Post de conquista entra agora?", "respondida": true},
    {"texto": "Alvo todasAsMatriculasDoPeriodo: matérias distintas das matrículas do período, e aluno sem matrícula não ganha?", "respondida": true},
    {"texto": "Onde fica o progresso na tela?", "respondida": true},
    {"texto": "Responda as quatro e ajuste o que quiser nas decisões (D1 a D10)", "respondida": true},
    {"texto": "Três coisas que decidi na etapa e precisam do seu aval (etapa 1)", "respondida": true},
    {"texto": "Decisões tomadas na etapa (precisam do seu aval) (etapa 2)", "respondida": true},
    {"texto": "Aprovar o fix(mobile) com o limite global de 15 s, ou preferir o limite só para comprovacoes.test.tsx", "respondida": true},
    {"texto": "Uma decisão para o seu aval: a anulação nunca concede nada (etapa 3)", "respondida": true},
    {"texto": "Duas decisões para o seu aval (etapa 4)", "respondida": true},
    {"texto": "Decisões para o seu aval (etapa 5)", "respondida": true},
    {"texto": "Para ter o 'matérias'... Faço nesta etapa se você quiser", "respondida": true},
    {"texto": "Post da conquista removida pela regra da medalha anulada: se você concordar, registro em produto.md 4.9", "respondida": true},
    {"texto": "Recebi uma mensagem sua com só uma vírgula... se era para dizer algo, me avise", "respondida": false}
  ],
  "contagem": {"decisoes": 45, "declaradas": 32, "silenciosas": 13, "duvidosas": 3, "perguntas": 14, "perguntas_respondidas": 13}
}
```
