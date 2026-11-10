# Revisor de decisões: engenheiro, export eng_12_instituicao-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\engenheiro\eng_12_instituicao-sessao.txt (SHA-256 efcf1abd2d667145ee9f3374f641c32f6f892e781ca023e1f620961916ca3e79)
- Leitura do export: 10950 de 10950 linhas, em 19 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: cdefbbb4-df6b-417a-b10b-9b41386f9972

Texto do revisor, sem edição:

---
Li a transcrição inteira: 10.950 linhas, em blocos sequenciais. Os trechos recolhidos pelo próprio export ("… +N lines (ctrl+o to expand)") não existem no arquivo, então ficaram fora da leitura. Algumas decisões silenciosas podem estar escondidas neles.

**Contexto.** Esta é a sessão do passo 12, a área web da instituição. A persona aprovou o plano de 10 etapas e as respostas P1 a P9 do jeito que o agente recomendou. Por isso não contei como decisão nada do que essas respostas fixaram. Isso inclui a área em /instituicao, a concessão nascer válida, o e-mail corrigido com ou sem conta, ex-aluno sem volta, o registro de quem fez cada ato, a purga do lote vigente digitando o nome do lote, banco de fotos livre, conta do seed sem senha em domínio reservado e poucas interações sociais.

Também não contei as aprovações que a persona deu depois do fato (fotos CC BY, os dois acréscimos na API, o formulário compartilhado, o prazo de 90 s). Elas continuam na lista porque o agente as tomou sem perguntar antes; a aprovação veio depois.

## 1. Decisões tomadas sem perguntar

**Regra de produto**
- **Busca da instituição** (declarada): mínimo de 2 caracteres, 20 resultados, nome comparado sem acento, RA só inteiro, sem índice próprio. Trecho: "20 por nome. Sem índice próprio".
- **Correção de e-mail** (declarada): repetir o mesmo e-mail não muda nada; trocar só maiúsculas conta como correção.
- **Post do prêmio concedido** (declarada): só prêmio válido ou definitivo pode virar post; o resto responde `premio-indisponivel`.
- **Evento digitado na concessão** (declarada): o evento fica em nome da instituição.
- **Anular de novo** (silenciosa, duvidosa): responde igual e não pede nada novo.
- **Datas dos ex-alunos do seed** (declarada): a marcação cai no dia seguinte ao fim do último semestre cursado.
- **Seed contra correções da instituição** (declarada): o seed acha o aluno pelo RA, e o que a instituição corrigiu vence o arquivo.
- **Fatos do seed uma vez só** (declarada): os fatos nascem na primeira vez que os alunos ganham conta; aluno acrescentado depois não ganha fatos.
- **Medalhas semeadas** (declarada): não geram notificação.
- **Divisão dos prêmios do seed** (silenciosa, duvidosa): uma parte nasce como reivindicação com foto aprovada por professor, o resto como concessão direta sem post.
- **Atos por situação na ficha** (declarada): aluno sem conta só corrige e-mail e troca de curso; ex-aluno só corrige e-mail.

**Modelo de dados**
- **Migration** (silenciosa): preenche `ex_aluno_marcado_por_id` antigo com o id da própria conta e cria uma check constraint.
- **Registros** (silenciosa): correção de e-mail e troca de curso saem em cascata com a linha da base; o registro da purga fica.
- **Conta de aluno do seed** (silenciosa): o nome de exibição é o nome completo.
- **Domínio reservado** (declarada): `al.unieduk.invalid`.
- **Faixas de raridade** (silenciosa, duvidosa): ficaram diferentes das do plano.
- **Geração do seed** (silenciosa): sorteio com semente fixa 20262 e um "empenho" concentrado em poucos alunos.
- **Os 22 eventos** (silenciosa, duvidosa): conteúdo escolhido pelo agente (monitoria, iniciação científica, extensão etc.).
- **Interações sociais** (silenciosa): só entre alunos ativos do mesmo curso, com volumes escolhidos pelo agente.

**Stack e arquitetura**
- **Rotas** (silenciosa): `/v1/instituicao/alunos`, `/instituicao/medalhas/{id}/anulacao` e `/instituicao/demonstracao/lotes`.
- **Purga** (silenciosa): 200 chaves de foto por trabalho de remoção, com `FOR UPDATE` nas contas do lote.
- **Upload pelo seed** (silenciosa): `EnviarAsync` entrou na abstração de armazenamento só para o seed usar.
- **Recálculos do seed** (silenciosa): só enfileira se não houver um pendente.
- **Rotas novas na etapa 8** (declaradas): `GET .../premios-participacao` e o `id` em `GET /v1/cursos`.
- **Seletor da reivindicação** (declarada): generalizado com `FontesDaEscolha`.
- **Formulário de aviso** (declarada): compartilhado entre professor e instituição.

**UX e visual**
- **Silenciosas**: textos de erro novos em `erros.ts`; texto da notificação ("A UniMax te concedeu…").
- **Declaradas**:
  - Ordem dos lotes do mais recente para o mais antigo.
  - Fotos do Wikimedia Commons, ampliando para CC BY e CC BY-SA.
  - 33 fotos recortadas em quadrado e versionadas, cerca de 10 MB.
  - "Confirmar" decide na hora, sem folha de motivo.
  - "Contestar prêmio" acima de "Remover post", indo direto para a folha de motivo.
  - Textos próprios para a instituição.
  - Cartão de contestação sem foto.
  - Debounce de 400 ms na busca.
  - Mensagem própria para prêmio repetido.
  - Entrada "Alunos" no topo da área.
  - "Faculdade" como escopo padrão do aviso.
  - Correção do "Voltar à ficha".

**Testes e processo** (todas declaradas)
- Falha na etapa 1 tratada como intermitente.
- Relógio do `MundoSocial` corrigido.
- Comprovações pendentes movidas da etapa 5 para a 6.
- Durante a queda do GitHub Actions, a etapa 6 foi adiantada localmente sem commit.
- Senhas definidas e um post criado para as capturas.
- Lotes de demonstração deixados no banco local.
- Prazo de 90 s nos e2e de vários papéis.
- Isolamento do e2e.
- Tipo de commit `test(mobile)`.
- Push da branch base `rodada/eng_12_instituicao` para o remoto sem perguntar. É um ato externo.

**Hospedagem e deploy**
- **Seeder do compose** (declarada): passou a receber as variáveis do bucket.

## 2. Perguntas do agente

P1 a P9 do plano foram todas respondidas pela persona na mensagem seguinte. Somam-se a elas duas ofertas no meio do trabalho:
- "Posso encurtar [a linha 'em comum'] para a instituição": respondida, fica como está.
- "Se quiser só domínio público e CC0, troco": respondida, mantém.

Os pedidos de "ok" antes de cada commit seguem a cadência que a persona pediu e não estão contados como perguntas.

```json
{
  "decisoes": [
    {"descricao": "Rotas da área: /v1/instituicao/alunos (PUT email, POST ex-aluno, PUT curso), POST /v1/instituicao/medalhas/{id}/anulacao e /v1/instituicao/demonstracao/lotes", "trecho": "rotas em /v1/instituicao/alunos (busca, ficha, e-mail, ex-aluno, curso)", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Busca da instituição: mínimo de 2 caracteres, 20 resultados, nome sem acento, RA inteiro, sem índice próprio", "trecho": "20 por nome. Sem índice próprio: só a instituição usa. Menos de 2 caracteres: 400 `busca-sem-criterio`", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Correção de e-mail: o mesmo e-mail não gera registro; trocar só maiúsculas conta como correção", "trecho": "O mesmo e-mail, escrito igual, não muda nada e não gera registro; trocar só maiúsculas é correção", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Migration preenche ex_aluno_marcado_por_id das marcações antigas com a própria conta, com check constraint de instante e autor juntos", "trecho": "UPDATE usuario SET ex_aluno_marcado_por_id = id WHERE ex_aluno_desde IS NOT NULL", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Registros de correção e de troca saem em cascata com a linha da base; o registro da purga permanece (FK restrict)", "trecho": "O da purga fica: os dados do lote saem, o registro de que saíram, não.", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Post do prêmio concedido só para prêmio válido ou definitivo; o resto recusa com premio-indisponivel", "trecho": "Prêmio que não está valendo responde premio-indisponivel", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "O evento digitado na concessão direta pertence à instituição", "trecho": "O evento digitado é da própria instituição", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Anular de novo pela área responde igual (204), sem novo pedido", "trecho": "Anular de novo não muda nada e responde igual.", "tipo": "regra de produto", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Purga com 200 chaves de foto por trabalho de remoção e trava FOR UPDATE nas contas do lote", "trecho": "internal const int FotosPorTrabalho = 200;", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Lista de lotes do mais recente ao mais antigo, com o vigente marcado", "trecho": "Os lotes vêm do mais recente ao mais antigo", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Textos das mensagens dos códigos novos em erros.ts", "trecho": "\"aluno-sem-conta\": \"Esse aluno ainda não criou a conta.\"", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Texto e destino da notificação premioConcedido", "trecho": "\"A UniMax te concedeu Monitoria.\", \"/trofeus\"", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Conta de aluno do seed com o nome completo como nome de exibição", "trecho": "com o nome completo como nome de exibição", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Ex-aluno do seed marcado no dia seguinte ao fim do último semestre cursado; conta criada no início do primeiro semestre cursado", "trecho": "o ex-aluno é marcado pela instituição no dia seguinte ao fim do último semestre que cursou", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Seed acha o aluno pelo RA, e a correção feita pela instituição vence o arquivo", "trecho": "O seed acha o aluno pelo RA, e um e-mail ou curso corrigido pela instituição vence o arquivo.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Domínio reservado escolhido: al.unieduk.invalid", "trecho": "Os e-mails estão em al.unieduk.invalid.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Atividade do seed gerada só na primeira população; aluno acrescentado depois não ganha fatos", "trecho": "A atividade nasce uma vez só, na primeira vez em que os alunos do arquivo ganham conta.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Faixas de raridade do seed diferentes das do plano (Épico 2 a 6, Raro 9 a 22, Comum 40 ou mais)", "trecho": "um aluno só no Lendário, de 2 a 6 no Épico, de 9 a 22 no Raro e 40 ou mais no Comum", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Geração determinística com semente fixa e 'empenho' concentrado em poucos alunos", "trecho": "Empenho de 0,15 a 1, concentrado embaixo: poucos alunos ganham muito.", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Conteúdo dos 22 eventos semeados (monitoria, iniciação científica, extensão etc.)", "trecho": "\"codigo\": \"iniciacao-cientifica-2026\"", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Parte dos prêmios do semestre em curso nasce como reivindicação com foto aprovada por professor; o resto como concessão direta sem post", "trecho": "Parte dos prêmios do semestre em curso nasce como o app faz", "tipo": "regra de produto", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Interações sociais do seed só entre alunos ativos do mesmo curso, com volumes escolhidos pelo agente", "trecho": "Seguimentos entre colegas de curso ... Só de alunos ativos", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Medalhas semeadas não geram notificação de medalha recebida", "trecho": "As medalhas semeadas não geram notificação de medalha recebida", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Fotos do Wikimedia Commons em vez de Unsplash/Pexels, ampliando para CC BY e CC BY-SA", "trecho": "Amplio para CC BY e CC BY-SA", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "33 fotos recortadas em quadrado ao centro, com as derivadas versionadas no repositório (~10 MB)", "trecho": "33 fotos geradas, todas dentro dos limites (cerca de 10 MB no total)", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Novo método EnviarAsync na abstração de armazenamento, usado só pelo seed", "trecho": "Task EnviarAsync(string chave, byte[] conteudo", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Seeder do docker-compose passa a receber as variáveis do bucket", "trecho": "O seeder do compose passou a ter o bucket.", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Corrigiu o mundo de teste para criar contas no relógio de teste", "trecho": "Agora o mundo de teste cria as contas no próprio relógio.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Falha na suíte da etapa 1 tratada como intermitente e commit feito assim mesmo", "trecho": "Sozinho, passa (os 19 s apontam para a disputa de recurso", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Moveu as comprovações pendentes da etapa 5 para a 6", "trecho": "Mudei a ordem de uma entrega", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Na queda do GitHub Actions, repetiu a CI e adiantou a etapa 6 localmente sem commit", "trecho": "adiantar a etapa 6 localmente, sem commit até ela ficar verde", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Na fila de contestações, 'Confirmar' decide na hora e só 'Revogar' abre a folha de motivo", "trecho": "\"Confirmar\" decide na hora, como o \"Aprovar\" das comprovações", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "'Contestar prêmio' acima de 'Remover post', indo direto para a folha de motivo", "trecho": "aparece \"Contestar prêmio\" acima de \"Remover post\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Textos próprios para a instituição ('Esta área é da instituição.', 'dos alunos') e o voltar para a área", "trecho": "para outros papéis, \"Esta área é da instituição.\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cartão de contestação sem foto mostra 'Concedido direto pela instituição, sem comprovação.'", "trecho": "\"Concedido direto pela instituição, sem comprovação.\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Para as capturas: senha definida pela recuperação e um aluno do seed fez post", "trecho": "A senha das duas contas no ambiente local é senha-de-captura-12.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Nova rota GET /v1/instituicao/alunos/{cadastroId}/premios-participacao", "trecho": "Vou expor a rota GET /v1/instituicao/alunos/{cadastroId}/premios-participacao", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "GET /v1/cursos passa a devolver o id", "trecho": "Acrescento o id à resposta, como acréscimo.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Busca com debounce de 400 ms e a partir de 2 letras", "trecho": "espera 400 ms depois da digitação e só busca a partir de 2 letras", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Atos por situação: sem conta só corrige e-mail e troca de curso; ex-aluno só corrige e-mail", "trecho": "Sem conta: só corrigir e-mail e trocar de curso. Ex-aluno: só corrigir e-mail.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Mensagem própria para prêmio repetido na concessão", "trecho": "\"O aluno já tem esse prêmio nesse evento.\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Seletor da reivindicação generalizado com fontes injetáveis (FontesDaEscolha)", "trecho": "adapto o seletor da reivindicação para servir também à concessão", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Área como lista de entradas, com 'Alunos' antes de Comprovações e Contestações", "trecho": "Entrada \"Alunos\" na área: fica antes de Comprovações e Contestações.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Formulário de aviso compartilhado entre professor e instituição", "trecho": "Vou tornar o formulário de aviso um componente compartilhado", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Escopo Faculdade como padrão; publicar só com pelo menos um curso no escopo Cursos", "trecho": "escolhe entre Faculdade (o padrão) e Cursos", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Capturas da etapa 9 com a demonstração ligada e lotes ensaio-1 e banca-1 deixados no banco", "trecho": "Registrei 2 alunos de demonstração no lote ensaio-1 e 3 no banca-1", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "'Voltar à ficha' passou a voltar na pilha", "trecho": "\"Voltar à ficha\" passou a voltar na pilha em vez de abrir a ficha de novo", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Prazo de 90 s nos e2e de medalhas, conquistas e rankings", "trecho": "vou dar a medalhas e rankings o mesmo prazo de 90 s", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Isolamento do e2e: nomes únicos, lote da purga criado direto no banco, foto enviada por outra conta", "trecho": "O lote da purga nasce direto no banco com a flag desligada", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tipo de commit test(mobile) na etapa 10", "trecho": "Usei o tipo test com escopo mobile porque não existe escopo e2e", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Push da branch base rodada/eng_12_instituicao para o remoto antes de abrir o PR", "trecho": "The base branch rodada/eng_12_instituicao exists only locally. Before I push it", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Seed enfileira recálculos de raridade e ranking só se não houver um pendente", "trecho": "Um pedido de cada, se ainda não houver um pendente.", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false}
  ],
  "perguntas": [
    {"texto": "P1. Onde fica a área web (mesmo app em /instituicao, entrada pelo menu do perfil, só na web)?", "respondida": true},
    {"texto": "P2. Concessão direta: nasce válida com janela de 15 dias, post com o aluno, notificação premioConcedido?", "respondida": true},
    {"texto": "P3. Corrigir e-mail: linha da base com ou sem conta, forma e unicidade, invalidar recuperações, manter sessões?", "respondida": true},
    {"texto": "P4. Ex-aluno sem volta e sem troca de curso; troca pede curso e semestre, matrículas antigas ficam?", "respondida": true},
    {"texto": "P5. Registrar quem fez e quando nos quatro atos (correção, ex-aluno, troca, purga)?", "respondida": true},
    {"texto": "P6. Purga também do lote vigente, com o nome do lote digitado?", "respondida": true},
    {"texto": "P7. De onde vêm as fotos do seed: fotos suas, banco livre com créditos, ou geradas por script?", "respondida": true},
    {"texto": "P8. Contas dos alunos do seed: fábrica sem senha com criado_em retroativo; domínio reservado ou bloquear recuperação?", "respondida": true},
    {"texto": "P9. Seguimentos, curtidas e comentários no seed: poucos, ou nenhum?", "respondida": true},
    {"texto": "A linha 'em comum' da comprovação fica longa para a instituição; posso encurtar, se quiser?", "respondida": true},
    {"texto": "Se quiser só fotos em domínio público e CC0, troco por fotos suas?", "respondida": true}
  ],
  "contagem": {"decisoes": 52, "declaradas": 37, "silenciosas": 15, "duvidosas": 4, "perguntas": 11, "perguntas_respondidas": 11}
}
```
