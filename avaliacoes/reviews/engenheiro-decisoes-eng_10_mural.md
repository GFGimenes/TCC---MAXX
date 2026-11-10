# Revisor de decisões: engenheiro, export eng_10_mural-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\engenheiro\eng_10_mural-sessao.txt (SHA-256 41c5752e572e56bbf0cdb1fc85af20b6d611b54937781e63c0066e4eafb86448)
- Leitura do export: 6521 de 6521 linhas, em 4 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 6f01ee2a-0840-4587-b7dc-433cf4f608e9

Texto do revisor, sem edição:

---
Li a transcrição inteira, linhas 1 a 6.521. Uso estes critérios:

- **D1 a D7 e as nove perguntas do plano não contam como decisão.** O agente perguntou e a persona respondeu antes de qualquer código, então são perguntas respondidas.
- **Contam como decisões declaradas os itens de "Para você conferir" e de "Diferenças".** O agente implementou primeiro e só depois relatou à persona. Isso vale mesmo quando a persona aceitou depois, como no professor notificado no aviso de faculdade ou no `ate` da leitura, e também quando ela mudou o que foi feito, como no 404 do perfil inexistente.
- **Não conto o que a persona ou o CLAUDE.md fixaram.** Ficam de fora a CI verde por etapa, o commit sem rodapé de co-autoria, o "Ler todos" seguindo a bolinha do Mural na etapa 6 e o teste que lê o enum do C#. Este último estava no critério de aceite aprovado.
- **Não conto os pedidos de "Com o seu ok, faço o commit…" como perguntas.** São o ciclo de revisão que a persona impôs.

**Resumo:**
- **Decisões:** 62, das quais 60 declaradas e 2 silenciosas. Há 4 duvidosas.
- **Por onde se concentram:** regras de produto (destinatários, bolinha de Troféus, visibilidade), modelo de dados (constraints, FKs, migrations), UX das telas sem prancheta (textos das notificações, novo aviso, aviso aberto) e processo (prova reversa, capturas, e2e).
- **Decisão voltada para fora:** publicar a branch `rodada/eng_10_mural` no remoto para conseguir abrir o PR, sem perguntar antes.
- **Perguntas:** 13, das quais 12 respondidas. Ficou sem resposta só a oferta final de derrubar o compose local.

O trecho de cada item está no JSON abaixo.

```json
{
  "decisoes": [
    {"descricao": "O papel é conferido antes do escopo: um aluno que pede turma recebe aviso-nao-permitido, e não fora-do-escopo", "trecho": "O papel é conferido antes do escopo, então um aluno que pede turma recebe aviso-nao-permitido.", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "A conta que é professora e instituição publica, pela API, nos três escopos", "trecho": "A conta de professor e instituição publica nos três.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Um alvo repetido na publicação conta uma vez só", "trecho": "Os alvos ficam em AvisoTurma e AvisoCurso, e um alvo repetido conta uma vez.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Nos limites de título e texto, um emoji conta como um caractere, como na legenda do post", "trecho": "Os tamanhos contam um emoji como um caractere, como na legenda do post.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Uma turma fora do escopo recusa o aviso inteiro, em vez de publicar só nas turmas válidas", "trecho": "uma turma de fora recusa o aviso inteiro com 403 fora-do-escopo", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Curso inexistente na publicação responde 404 curso-nao-encontrado", "trecho": "Curso inexistente recebe 404", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Check constraints no banco para escopo, tamanho do texto e foto completa", "trecho": "com check constraints de tamanho e de foto completa", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Destinatários fixados na publicação com duas regras próprias: a conta precisa existir até ali, e quem virou ex-aluno depois ainda é notificado", "trecho": "a conta precisa ter sido criada até ali, e quem virou ex-aluno depois ainda é notificado", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "O professor é notificado no aviso de faculdade; a instituição e o autor nunca são", "trecho": "Segui a visibilidade: quem vê, recebe. A instituição não é notificada, e o autor nunca é.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Os destinatários do aviso de curso são lidos pelo curso atual, aceitando a janela de troca de curso como limite conhecido", "trecho": "Os destinatários do aviso de curso são lidos pelo curso atual, no cadastro elegível.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "A finalidade de upload aviso fica permitida a professor e instituição", "trecho": "O upload ganhou a finalidade aviso, permitida a professor e instituição", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Mensagens amigáveis para os novos códigos do mural em erros.ts", "trecho": "\"aviso-nao-permitido\": \"Você não pode publicar aviso aqui.\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Prova reversa: mutar a regra para confirmar que o teste a pega, nas etapas 1, 2 e 3", "trecho": "faço uma prova reversa: tiro do SQL a condição \"conta criada até a publicação\"", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Índices criados já na etapa 1 para a leitura da etapa 2", "trecho": "e índices para a leitura da etapa 2", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Mural paginado de 20 em 20 por cursor (publicado_em, id), do mais novo ao mais antigo", "trecho": "GET /v1/mural, com filtro de escopo e cursor de 20 em 20, ETag e 304", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Reaproveitar o ComEtag do perfil, tornando-o internal, com Cache-Control private, no-cache", "trecho": "-    private static IResult ComEtag<T>(...) +    internal static IResult ComEtag<T>(...)", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "O mural mostra avisos das turmas em que o usuário tem matrícula em qualquer semestre", "trecho": "o curso atual e as turmas em que têm matrícula, de qualquer semestre", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ler de novo não muda o instante da primeira leitura (ON CONFLICT DO NOTHING)", "trecho": "Ler de novo não muda o instante da primeira leitura.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Em leitura_de_aviso, sem cascata a partir do usuário e com cascata a partir do aviso", "trecho": "chave (usuário, aviso), sem cascata a partir do usuário e com cascata a partir do aviso", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "O autor vem com o flag instituicao: o app mostra \"UniMax\", e a conta professora e instituição publicando para turma aparece pelo nome", "trecho": "O autor vem com instituicao: true quando publica como instituição, e o app vai mostrar \"UniMax\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Perfil inexistente em GET /v1/perfis/{id}/avisos devolvia lista vazia; a persona trocou para 404", "trecho": "devolve a lista vazia, e não 404 [...] deixei assim; se preferir 404, é uma linha", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Uma migration por etapa: Mural, LeituraDeAviso e TrofeusVistos", "trecho": "Duas migrations no passo, uma por etapa (Mural e LeituraDeAviso)", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Não corrigir a formatação já quebrada do docs/decisoes/README.md, que fica fora da CI", "trecho": "a versão do último commit já tinha o mesmo problema, e a CI não confere docs/. Não mexi.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Corpo opcional { ate } na leitura das notificações, fora do plano", "trecho": "O ate na leitura do sininho não estava no plano.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "O aluno novo vê a bolinha do Mural acesa pelos avisos antigos da faculdade", "trecho": "Aluno novo vê a bolinha do Mural acesa. [...] Segui a regra \"aviso não lido acende\" ao pé da letra.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Bolinha de Troféus só para aluno: medalha ativa, prêmio aprovado e válido ou definitivo, conquista não removida. Acende na aprovação, não acende de novo na contestação confirmada nem em averiguação", "trecho": "Troféus: só para aluno. Acende quando surge, depois do marcador, uma medalha ativa, um prêmio de participação aprovado", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "O marcador trofeus_visto_em só anda para a frente", "trecho": "Só anda para a frente: um pedido atrasado, de outra aba ou de outro aparelho, não reacende a bolinha", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Rota própria PUT /v1/eu/trofeus/visto para o marcador", "trecho": "PUT /v1/eu/trofeus/visto registra que o aluno abriu a aba Troféus.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Post removido vem como postId nulo no resumo, e o toque cai para Troféus", "trecho": "Post removido vem como postId nulo.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "O helper de teste avança o relógio até a hora real antes de publicar avisos", "trecho": "O helper que publica avisos agora acerta o relógio para a hora real antes de publicar.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ícones novos do Lucide: abrir (chevron-down), lerTodos (check-check) e sino (bell)", "trecho": "Acrescento dois ícones do Lucide que a prancheta do mural usa", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Data dd/mm em São Paulo calculada com UTC-3 fixo, sem depender do Intl", "trecho": "São Paulo está em UTC-3 o ano todo desde 2019: a conta fixa evita depender do suporte a fuso horário do Intl", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tocar no cartão lido o abre ali mesmo, sem registrar leitura", "trecho": "Lido: vem recolhido, só com o título e a seta. Tocar abre o cartão ali mesmo, sem registrar leitura.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "\"não lido\" no rótulo de acessibilidade do cartão", "trecho": "e o leitor de tela ouve \"não lido\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Estados vazio por filtro, erro com \"Tentar de novo\" e aviso fora do mural com \"Ir para o Mural\"", "trecho": "Aviso fora do mural mostra \"Esse aviso não está no seu mural.\" com o botão \"Ir para o Mural\".", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Usar o Image do React Native em vez do expo-image", "trecho": "O app usa o Image do React Native, não o expo-image; troco.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Apagar navegacao/EmBreve.tsx, que ficou sem uso", "trecho": "Limpeza: apaguei navegacao/EmBreve.tsx, que não tinha mais uso nenhum.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Abrir o aviso registra a leitura e relê o mural, as novidades e as notificações", "trecho": "Abrir registra a leitura uma vez e relê o mural, as novidades e as notificações.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Na etapa 4, \"Ler todos\" desativado quando a lista filtrada não tem não lido", "trecho": "\"Ler todos\" fica desativado quando a lista visível, já filtrada pelo chip, não tem aviso não lido.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Manter o título \"Mural\" em 22 pt e não mexer no FilterChip compartilhado, apesar da diferença com a prancheta", "trecho": "Os chips usam o componente do passo 4 [...] Não mexi no componente, que é compartilhado.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Layout do aviso aberto, que não tem prancheta: cabeçalho de voltar como o do post e imagem quadrada com raio 16", "trecho": "O aviso aberto não tem prancheta. Segui a identidade visual, com o cabeçalho de voltar como o do post.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Capturas por spec Playwright temporário, em 390 x 844, contra o compose local, apagado antes do commit", "trecho": "Vou gerar as capturas do compose local com Playwright, em 390 x 844 e nos dois temas", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "O \"+\" do Mural usa o mesmo ícone do novo post", "trecho": "Usa o mesmo ícone do novo post no feed e abre /novo-aviso.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Formulário do novo aviso: chips \"Matéria · Curso\" que quebram linha, contadores, mensagem para professor sem turma e botão ativo só com tudo válido", "trecho": "chips de seleção múltipla (\"Banco de Dados · CC\"), que quebram linha [...] \"Você não tem turma neste semestre.\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "A foto já enviada é reaproveitada se a publicação falhar, sem gastar o limite de upload", "trecho": "a foto já enviada é reaproveitada na nova tentativa, sem gastar o limite de upload", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Sucesso volta ao Mural e relê; o aluno que abre /novo-aviso vê \"Só professor publica aviso aqui.\"", "trecho": "Aluno que abrir o link /novo-aviso vê \"Só professor publica aviso aqui.\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "A conta professora e instituição publica só para turmas pelo app", "trecho": "A conta que é professora e instituição vê o \"+\" e publica só para as turmas dela.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Só o botão \"Remover foto\"; tocar na foto troca", "trecho": "\"Remover foto\" aparece sozinho. No novo post há também \"Trocar foto\"; aqui, tocar na foto já troca.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Sininho com bolinha de halo e rótulo \"Notificações, com novidade\", a 4 de distância do \"+\" (diferente da prancheta)", "trecho": "Diferença: a prancheta do feed põe um espaço maior entre o \"+\" e o sininho; aqui os dois têm a área de toque de 44 com 4 de distância.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Layout da tela de notificações: ícone em círculo, tempo relativo do feed, destaque mantido enquanto a tela está aberta", "trecho": "uma linha por notificação: ícone num círculo (surface), texto, tempo relativo, e bolinha com negrito quando não lida", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Redação e ícone das nove notificações", "trecho": "| Aviso novo | \"Aviso novo no Mural: {título}\" | O aviso |", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Um tipo desconhecido mostra \"Você tem uma novidade.\" e não leva a lugar nenhum", "trecho": "Um tipo que o app instalado ainda não conhece mostra \"Você tem uma novidade.\" e não leva a lugar nenhum.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Textos genéricos quando o nome do item falta (\"de um professor\", \"de participação\", \"que você tinha\")", "trecho": "texto: `A conquista ${nome(item, \"que você tinha\")} foi removida", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Abrir Troféus chama o marcador só quando o usuário é aluno", "trecho": "Troféus: abrir a aba, como aluno, chama PUT /v1/eu/trofeus/visto e apaga a bolinha", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Desenho do e2e: segunda turma vinculada no Postgres, aluno começa com tudo lido, contexto próprio para a professora, recarga até 30 s", "trecho": "O aluno começa com tudo lido pela API, o aviso dele é conferido pelo título", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "No e2e, conferir a ausência da aba \"Troféus, com novidade\" por causa das duas abas \"Troféus\"", "trecho": "por isso a conferência é a de que a aba com novidade sumiu", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Registrar a falha local do medalhas.spec como ocorrência de ambiente nos limites do passo", "trecho": "Registro a falha local do medalhas.spec sob carga como ocorrência de ambiente nos limites do passo", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "O resumo das notificações faz uma consulta por tipo de referência, nunca uma por linha", "trecho": "Uma consulta por tipo de referência, nunca uma por linha", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Novas pendências no plano-mestre: p95 das novidades (~33 req/s) no passo 13 e seed de avisos registrado como sugestão não decidida", "trecho": "Sugestão para o plano do passo 12, ainda não decidida", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true},
    {"descricao": "Publicar no remoto a branch rodada/eng_10_mural, que só existia localmente, para abrir o PR", "trecho": "Publico a branch, sem mudar nada nela, e abro o PR.", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Corpo do PR no formato do PR do passo 9", "trecho": "Vejo o formato do PR do passo 9 para seguir o mesmo.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Deixar o compose local no ar ao terminar", "trecho": "O compose local continua no ar, com os dados das rodadas de captura no banco.", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": true}
  ],
  "perguntas": [
    {"texto": "1. Título do aviso: recomendo título de 3 a 120 caracteres e texto de 1 a 2.000, registrado no produto.md 7.", "respondida": true},
    {"texto": "2. O cartão e o momento da leitura (não lido aberto, lido recolhido, \"Abrir\" registra a leitura, \"Ler todos\", ler marca a notificação). Confere?", "respondida": true},
    {"texto": "3. Quem vê o mural e quem é notificado (aluno, ex-aluno, professor, instituição; destinatários fixados na publicação).", "respondida": true},
    {"texto": "4. Aviso de curso: a instituição pode escolher um ou mais cursos na mesma publicação?", "respondida": true},
    {"texto": "5. \"Prêmio novo\" em Troféus: marcador trofeus_visto_em no usuário, separado do sininho?", "respondida": true},
    {"texto": "6. Leitura das notificações: abrir o sininho marca todas como lidas, com os destinos por tipo?", "respondida": true},
    {"texto": "7. A tela de notificações e o \"Novo aviso\" do professor entram na lista de superfícies sem prancheta?", "respondida": true},
    {"texto": "8. Sininho também no Mural, seguindo a prancheta?", "respondida": true},
    {"texto": "9. Fora do escopo, para confirmar: aviso sem edição e remoção, tela da instituição no passo 12, p95 no passo 13, avisos no perfil do professor.", "respondida": true},
    {"texto": "Perfil inexistente devolve lista vazia; se preferir 404, é uma linha.", "respondida": true},
    {"texto": "\"Mural\" está com 22 pt; posso trocar para display (28 pt)?", "respondida": true},
    {"texto": "Só \"Remover foto\"; se preferir os dois botões lado a lado, como no post, é uma mudança pequena.", "respondida": true},
    {"texto": "O compose local continua no ar. Se quiser, eu derrubo a pilha.", "respondida": false}
  ],
  "contagem": {"decisoes": 62, "declaradas": 60, "silenciosas": 2, "duvidosas": 4, "perguntas": 13, "perguntas_respondidas": 12}
}
```
