# Revisor de decisões: engenheiro, export eng_11_rankings-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\engenheiro\eng_11_rankings-sessao.txt (SHA-256 64fd74a269cefcacd860a83bd1d2b779aa71078be36f3bdcd1d45b928455d4a5)
- Leitura do export: 5337 de 5337 linhas, em 1 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 7b20448b-da4a-4850-a03a-4de2cb515ba0

Texto do revisor, sem edição:

---
Li a rubrica e a transcrição inteira, do pedido do plano até a abertura do PR #13.

**Critério usado.** Não contei como decisão do agente o que a persona fechou: as seis perguntas, as propostas A a G e o plano de seis etapas que ela aprovou. Também não contei o que ela pediu depois: o "#29" no feed e em Troféus, o fix em commit separado e os itens da etapa 6. As quatro "decisões de detalhe" da etapa 4 entram na lista. Elas foram tomadas sem perguntar e só depois comunicadas e aceitas.

## 1. Decisões tomadas sem perguntar

**Regra de produto**
- **Recesso sem semestre seguinte.** O prêmio de evento do recesso, quando o calendário ainda não tem o semestre seguinte, pontua no histórico e em nenhum semestre. É declarada ("Uma consequência para você conferir…"), e a persona aprovou depois.
- **Semestres abertos.** Os semestres "abertos" incluem o que ainda não começou. Declarada.
- **Quem pede só a raridade.** Cadastro, demonstração e seed pedem só a raridade, e a reprovação e a remoção de post pendente não pedem o recálculo. Declarada. Marquei como duvidosa porque é uma extensão do plano.
- **"Quem eu sigo".** O filtro inclui a linha do próprio aluno. Declarada.
- **Filas de comprovação e contestação.** A posição do autor vem nula nessas filas. Declarada.
- **Concessão direta (passo 12).** No plano-mestre, a concessão direta da instituição também pede o recálculo. Declarada. Marquei como duvidosa porque o instante dela já tinha sido proposto na pergunta 2.

**Modelo de dados**
- **Tabela `posicao_no_ranking`.** Checks no banco, índices únicos com NULLS NOT DISTINCT e id identity. Declarada.
- **Chaves estrangeiras em cascata.** A linha é dado derivado e sai com o aluno na purga. Declarada.
- **Formato da resposta.** A resposta do ranking traz rótulo do semestre, nome, arroba, curso, semestre, ex-aluno e foto, e `eu` vem nulo para quem não é aluno. Declarada.

**Stack e arquitetura**
- **Seed base.** Pede o recálculo quando o calendário muda ou o ranking nunca foi calculado. Declarada.
- **Worker.** Trava a própria linha com FOR UPDATE e tira o curso atual do CadastroElegivel. Declarada.
- **Ponto único.** `fila.PedirRecalculos()` substitui o pedido antigo em 11 lugares. Declarada.
- **Parâmetros em texto.** Os parâmetros de query são texto com AllowedValues, como no mural. Declarada.
- **Sem ETag.** O ranking fica sem ETag. Declarada.
- **Filtro de visão.** A consulta usa IS NULL literal para o índice atender, mais um teste com EXPLAIN. É silenciosa.
- **Rota padrão.** A rota `/rankings?visao=` abre o geral do semestre quando a visão não é conhecida. Silenciosa.
- **Cursor.** O cursor é codificado em Base64. Silenciosa e duvidosa: só aparece num import.

**Segurança**
- **Parâmetro ausente.** A ausência de escopo ou período é barrada no endpoint, com 400 `visao-incompleta`. Declarada.
- **Respostas 403.** Escopo curso para professor ou instituição responde 403 `ranking-de-curso-so-para-aluno`. Curso no semestre para ex-aluno responde 403 `ex-aluno-so-no-historico`. Declarada.

**UX e visual**
- **Tela na pilha.** A tela de Rankings fica na pilha, sem a navegação inferior. Declarada.
- **Rótulo acima do segmentado.** Declarada.
- **Curso pela sigla.** A linha do ranking mostra a sigla do curso, não o nome. Declarada.
- **Detalhes da tela.** Logo e sininho no topo; tocar numa linha abre o perfil; "Ver prêmios" abre Troféus; textos e marcas próprios para o ex-aluno. Declarada.
- **"#N" no perfil.** A posição também aparece na linha de curso do perfil. Declarada.
- **Perfil de outra pessoa.** A posição não é tocável no perfil de outra pessoa, e o toque sem posição ainda abre o ranking. Declarada.
- **Atalhos da Busca.** São dois botões secundários; o do curso só aparece para aluno, e o ex-aluno vai ao histórico do curso. Declarada.

**Testes e processo**
- **Falha de timeout.** Foi tratada como instabilidade do ambiente sem confirmação. Declarada.
- **Testes antigos e da etapa 2.** Foram ajustados, incluindo o avanço de 10 s. Declarada.
- **Capturas.** Pilha local reconstruída e roteiros e2e temporários, apagados depois. Declarada.
- **Expressão regular nos e2e.** Os testes antigos passaram a aceitar "N pts( · #N)?". Declarada.
- **Asserção removida.** Saiu uma asserção e2e que dependia do estado do banco. Declarada.
- **Commit e push antes da revisão.** A etapa 6 foi commitada e enviada antes da revisão da persona. Declarada.
- **Menções antigas na documentação.** "Chega no passo 11" virou "Resolvido no passo 11". Declarada.
- **Rodada no remoto.** O agente enviou a `rodada/eng_11_rankings` para o remoto sem perguntar, para conseguir abrir o PR. Declarada.
- **Corpo do PR.** Segue o formato do PR do passo 10. Declarada.

## 2. Perguntas à persona

Foram 8 perguntas, todas respondidas na transcrição:
- As seis perguntas do plano: semestre das conquistas de ano e de curso; instante de desempate; aluno sem pontos; posição mostrada no perfil; "Todos / Quem eu sigo"; quem vê o ranking por curso.
- Se a regra entrava no produto.md já na etapa 1.
- Se o "#29" do feed e de Troféus entrava na etapa 5.

```json
{
  "decisoes": [
    {"descricao": "Prêmio de evento no recesso sem semestre seguinte no calendário pontua no histórico e em nenhum semestre", "trecho": "um prêmio de evento no recesso, sem o semestre seguinte no calendário, já pontua no histórico, mas em nenhum semestre", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Semestres abertos (reescritos) incluem o que ainda não começou", "trecho": "Abertos: os semestres não congelados, inclusive o que ainda não começou.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tabela posicao_no_ranking com checks no banco, índices únicos NULLS NOT DISTINCT e id identity", "trecho": "Dois índices únicos com NULLS NOT DISTINCT", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Chaves estrangeiras em cascata para aluno, semestre e curso", "trecho": "Chaves estrangeiras em cascata: aluno, semestre e curso. A linha é dado derivado e sai junto com o aluno na purga", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Seed base pede recálculo quando o calendário muda ou o ranking nunca foi calculado", "trecho": "Seed base: pede o recálculo quando o calendário é novo ou mudou, ou quando o ranking nunca foi calculado.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Worker trava a linha ranking com FOR UPDATE e lê o curso atual do CadastroElegivel", "trecho": "Usa a própria linha ranking em recalculo, com FOR UPDATE.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Falha de timeout na suíte inteira tratada como instabilidade de ambiente sem confirmar", "trecho": "tomo como instabilidade do ambiente, mas não confirmei", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ponto único PedirRecalculos enfileirando ranking e raridade, substituindo o pedido em 11 lugares", "trecho": "Vou unificar \"a pontuação mudou\" em um ponto único que enfileira raridade e ranking, trocando-o nos 11 lugares afetados", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cadastro, demonstração e seed pedem só raridade; reprovação e remoção de post pendente não pedem recálculo", "trecho": "cadastro, demonstração e seed seguem pedindo só a raridade", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Ajuste de testes antigos e do teste da etapa 2 (avanço de 10 s) para a nova fila", "trecho": "Testes antigos ajustados (3 arquivos)... Teste da etapa 2 ajustado", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Parâmetros escopo e periodo como texto com valores permitidos, como no mural", "trecho": "Parâmetros de query em texto. escopo e periodo aparecem como string no contrato", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ausência de escopo/período recusada no endpoint com 400 visao-incompleta", "trecho": "a ausência é checada no endpoint, com o código visao-incompleta", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "\"Quem eu sigo\" inclui a linha do próprio aluno", "trecho": "\"Quem eu sigo\" inclui a linha do próprio aluno, além de quem ele segue", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Sem ETag no ranking até o k6 do passo 13", "trecho": "Sem ETag no ranking. Seria uma decisão de cache", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "403 com códigos próprios para escopo curso de professor/instituição e curso no semestre para ex-aluno", "trecho": "O escopo curso para professor e instituição responde 403 ranking-de-curso-so-para-aluno", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conteúdo da resposta do ranking: rótulo do semestre, linha com nome, arroba, curso, semestre, ex-aluno e foto; eu nulo para não-aluno", "trecho": "Cada linha traz nome, arroba, curso, semestre do aluno, ex-aluno e foto.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Consulta da visão com IS NULL literal para usar o índice, verificada por EXPLAIN", "trecho": "O nulo vira IS NULL literal, e o valor, igualdade simples", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Cursor da paginação codificado em Base64", "trecho": "using System.Buffers.Text;", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Tela de Rankings na pilha sobre as abas, sem navegação inferior", "trecho": "Sem a navegação inferior. A tela fica na pilha sobre as abas", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Rótulo acima do segmentado, em largura cheia", "trecho": "o rótulo veio para cima e o segmentado ocupa a largura toda", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Curso pela sigla na linha do ranking", "trecho": "Curso pela sigla na linha. A prancheta mostra o nome do curso", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Detalhes da tela: logo e sininho, toque na linha abre perfil, Ver prêmios abre Troféus, textos e marca do ex-aluno", "trecho": "Tocar numa linha abre o perfil daquele aluno.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Posição #N também na linha de curso do perfil", "trecho": "e o \"#43\" na linha do curso", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "No perfil de outra pessoa a posição não é tocável; sem posição o toque ainda abre o ranking", "trecho": "No próprio perfil, o toque abre o ranking no chip Histórico; no de outra pessoa, só mostra.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Atalhos da Busca como dois botões secundários; do curso só para aluno, ex-aluno vai ao histórico do curso", "trecho": "O do curso só aparece para aluno, e para o ex-aluno abre o histórico do curso.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Rota /rankings?visao= com padrão no geral do semestre para visão desconhecida", "trecho": "Sem visão conhecida, o geral do semestre.", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Capturas tiradas com pilha local reconstruída e roteiros e2e temporários apagados depois", "trecho": "O roteiro de captura era temporário e já foi apagado.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Posição do autor nula nas filas de comprovação e contestação", "trecho": "nas filas de comprovação e de contestação, vem nula", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Testes e2e antigos passam a aceitar \"N pts( · #N)?\"", "trecho": "os testes e2e liam o texto exato \"N pts\" do cabeçalho... Vou corrigir as duas num commit fix", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Remoção de asserção e2e dependente do estado do banco", "trecho": "Uma das asserções, porém, depende de quantos alunos já pontuaram no banco... Removo essa linha.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Commit e push da etapa 6 antes da revisão da persona", "trecho": "fiz o commit e o push da etapa 6 antes da sua revisão", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Reescrita das menções antigas \"chega no passo 11\" nos documentos para \"Resolvido no passo 11\"", "trecho": "Atualizo as menções antigas a \"chega no passo 11\" nos documentos dos passos anteriores", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Pendência no plano-mestre: a concessão direta da instituição também pede o recálculo", "trecho": "A concessão direta da instituição também pede o recálculo, e o instante dela é o do desempate.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Envio da rodada/eng_11_rankings ao remoto para abrir o PR", "trecho": "Envio a rodada como está (d4ac193, sem mudança) e abro o PR.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Corpo do PR no formato do PR do passo 10", "trecho": "Corpo: segue o formato do PR do passo 10", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true}
  ],
  "perguntas": [
    {"texto": "Em que semestre pontuam as conquistas de ano e de curso?", "respondida": true},
    {"texto": "O instante de desempate de cada fonte (medalha, prêmio, conquista, e id do aluno)?", "respondida": true},
    {"texto": "Aluno sem pontos aparece no ranking?", "respondida": true},
    {"texto": "Que posição e que pontos o perfil mostra?", "respondida": true},
    {"texto": "O controle \"Todos / Quem eu sigo\" da prancheta entra?", "respondida": true},
    {"texto": "Quem vê o ranking por curso?", "respondida": true},
    {"texto": "Se preferir que a regra entre no produto.md junto com o código que a implementa, incluo neste mesmo commit?", "respondida": true},
    {"texto": "Quer que eu inclua os dois \"#29\" (feed e Troféus) nesta etapa, deixe para a etapa 6, ou fique sem?", "respondida": true}
  ],
  "contagem": {"decisoes": 35, "declaradas": 32, "silenciosas": 3, "duvidosas": 4, "perguntas": 8, "perguntas_respondidas": 8}
}
```
