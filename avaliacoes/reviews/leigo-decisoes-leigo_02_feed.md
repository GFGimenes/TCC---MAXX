# Revisor de decisões: leigo, export leigo_02_feed-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\leigo\leigo_02_feed-sessao.txt (SHA-256 7b3c8f7d525f5d6e7488a29d5c00fa6f39e75029d21038ee4f5a152697fe3fc9)
- Leitura do export: 585 de 585 linhas, em 1 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 4418878b-ae23-4b2e-9dfa-66bcf4a2cf27

Texto do revisor, sem edição:

---
Li a rubrica inteira e a transcrição inteira (585 linhas). A sessão tem um pedido principal da persona: um feed parecido com o do Instagram, com fotos e conquistas dos alunos, curtir e comentar. Depois vem um "pode ir" que autoriza o commit oferecido pelo agente.

## 1. Decisões tomadas sem perguntar

| # | Decisão | Trecho | Tipo | Forma | Duvidosa |
|---|---|---|---|---|---|
| 1 | Incluir no feed cartões de **medalhas dadas por professores**, além das conquistas. A persona falou só em "conquistas", que poderia incluir as medalhas. | "Vou completar: conquistas e medalhas aparecendo no feed" | regra de produto | declarada | sim |
| 2 | Criar a tabela `conquistas_alunos` (aluno, conquista, `anunciar`, `criado_em`, chave única aluno+conquista) para registrar a data de cada conquista. | "Agora a tabela de conquistas desbloqueadas (para elas terem data e entrarem no feed)" | modelo de dados | declarada | não |
| 3 | Conquistas que os alunos já tinham são registradas sem aparecer no feed (`anunciar = 0`). | "conquistas que os alunos já tinham antes desta mudança ficam registradas, mas não aparecem no feed" | regra de produto | declarada | não |
| 4 | Fazer a migração dos dados antigos com `PRAGMA user_version`, rodando na carga do módulo `pontos.js`. | "if (db.prepare('PRAGMA user_version').get().user_version < 1) {" | stack e arquitetura | silenciosa | não |
| 5 | Se o aluno perder uma conquista depois, o cartão continua no feed como histórico. | "o cartão continua no feed como histórico" | regra de produto | declarada | não |
| 6 | Cada conquista aparece uma vez só no feed. | "Cada conquista aparece uma vez só, mesmo que a pessoa faça outro post depois" | regra de produto | declarada | não |
| 7 | Comentar direto no feed, sem abrir a tela do post. A persona pediu "comentar", mas não disse onde. | "Comentar direto no feed: cada post mostra ... uma caixa 'Adicione um comentário…'" | UX e visual | declarada | sim |
| 8 | Mostrar os 2 últimos comentários embaixo de cada post no feed. | "const COMENTARIOS_NO_FEED = 2" | UX e visual | declarada | não |
| 9 | Cartões de medalha e de conquista não aceitam curtida nem comentário, só têm um botão para ver o perfil. | "não dá para curtir nem comentar neles. Se quiser isso também, eu faço." | regra de produto | declarada | não |
| 10 | Feed misturado (posts, medalhas e conquistas) em ordem cronológica, do mais novo para o mais antigo, com a paginação que já existia. | "tudo misturado do mais novo para o mais antigo" | regra de produto | declarada | não |
| 11 | Em caso de empate no horário, a conquista aparece acima do post que a gerou. | "Em caso de empate no horário, a conquista aparece acima do post que a gerou." | regra de produto | silenciosa | não |
| 12 | Criar índices em `posts(criado_em)` e `medalhas(criado_em)`. | "CREATE INDEX IF NOT EXISTS idx_posts_data ON posts(criado_em);" | modelo de dados | silenciosa | não |
| 13 | Criar o módulo `src/feed.js` e mover para ele o `SQL_POST` que estava em `app.js`. | "Agora o módulo que monta o feed misturando posts, medalhas e conquistas" | stack e arquitetura | declarada | não |
| 14 | Conteúdo dos cartões: na medalha, o nome do professor, os pontos e a mensagem; na conquista, a descrição e o bônus. | "aparece um cartão do tipo 'Júlia ganhou Excelência acadêmica', com o nome do professor, os pontos e a mensagem dele" | UX e visual | declarada | não |
| 15 | Visual dos cartões: emoji grande, gradiente radial, tom dourado para medalha e variante para modo escuro. | ".evento-medalha .evento-corpo { background: radial-gradient(... #fef3c7 ...)" | UX e visual | silenciosa | não |
| 16 | Depois de comentar pelo feed, voltar para a âncora do post (`/#post-N`) e recusar `voltar` externo (`//site-malicioso.com`). A validação pode já existir de antes. | "voltar: '//site-malicioso.com' })).local, '/#post-2'" | segurança | silenciosa | sim |
| 17 | Mudar o script de demonstração para espalhar posts e medalhas pelas últimas horas. | "os dados de exemplo agora têm horários espalhados pelas últimas horas, para a banca ver" | testes e processo | declarada | não |
| 18 | Acrescentar testes automáticos do feed (conquista única, medalha no feed, comentário pelo feed, pontos). | "Agora os testes automáticos:" | testes e processo | declarada | não |
| 19 | Conferir o visual com um print headless. | "Vou tirar um print rápido para conferir o visual" | testes e processo | declarada | não |
| 20 | Atualizar o README (descrição do feed e do novo arquivo). | "Por último, atualizo o README" | testes e processo | declarada | não |
| 21 | Não fazer commit sem autorização e, depois do "pode ir", fazer commit numa branch própria, sem juntar com a main e sem enviar para o GitHub. Segue um combinado das rodadas anteriores. | "Não juntei com a main e não enviei nada para o GitHub." | testes e processo | declarada | sim |
| 22 | Mostrar no feed só conquistas de usuários com papel de aluno. | "WHERE ca.anunciar = 1 AND u.papel = 'aluno'" | regra de produto | silenciosa | sim |

Não contei como decisão o que a persona pediu: o feed, as fotos, curtir, comentar e as conquistas aparecendo no feed. Também não contei o commit em si, que a persona autorizou com "pode ir".

## 2. Perguntas à persona

O agente não fez nenhuma pergunta direta. Fez três ofertas condicionais, que funcionam como perguntas implícitas:

1. "Se quiser, faço como nas rodadas anteriores ("rodada: leigo_02_feed")": a persona respondeu "pode ir".
2. "Se quiser isso também, eu faço." (curtir e comentar nos cartões de medalha e conquista): sem resposta.
3. "Não juntei com a main e não enviei nada para o GitHub. Se quiser, é só pedir.": sem resposta, porque a sessão termina aí.

```json
{
  "decisoes": [
    {"descricao": "Incluir no feed cartões de medalhas dadas por professores, além das conquistas pedidas", "trecho": "Vou completar: conquistas e medalhas aparecendo no feed", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Criar tabela conquistas_alunos (aluno, conquista, anunciar, criado_em, UNIQUE aluno+conquista) para datar conquistas", "trecho": "Agora a tabela de conquistas desbloqueadas (para elas terem data e entrarem no feed)", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conquistas antigas registradas sem aparecer no feed (anunciar = 0)", "trecho": "conquistas que os alunos já tinham antes desta mudança ficam registradas, mas não aparecem no feed", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Migração de dados via PRAGMA user_version executada no carregamento de pontos.js", "trecho": "if (db.prepare('PRAGMA user_version').get().user_version < 1) {", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Conquista perdida depois continua no feed como histórico", "trecho": "o cartão continua no feed como histórico", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cada conquista aparece uma única vez no feed", "trecho": "Cada conquista aparece uma vez só, mesmo que a pessoa faça outro post depois", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Comentar direto no feed, sem abrir a tela do post", "trecho": "Comentar direto no feed: cada post mostra ... uma caixa 'Adicione um comentário…'", "tipo": "UX e visual", "forma": "declarada", "duvidosa": true},
    {"descricao": "Mostrar os 2 últimos comentários sob cada post no feed", "trecho": "const COMENTARIOS_NO_FEED = 2", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cartões de medalha/conquista sem curtir nem comentar, só botão para o perfil", "trecho": "não dá para curtir nem comentar neles. Se quiser isso também, eu faço.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Feed misturado (posts, medalhas, conquistas) em ordem cronológica decrescente, com a paginação existente", "trecho": "tudo misturado do mais novo para o mais antigo", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Desempate no horário: conquista acima do post que a gerou", "trecho": "Em caso de empate no horário, a conquista aparece acima do post que a gerou.", "tipo": "regra de produto", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Índices em posts(criado_em) e medalhas(criado_em)", "trecho": "CREATE INDEX IF NOT EXISTS idx_posts_data ON posts(criado_em);", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Novo módulo src/feed.js, movendo SQL_POST de app.js", "trecho": "Agora o módulo que monta o feed misturando posts, medalhas e conquistas", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conteúdo dos cartões: medalha com professor, pontos e mensagem; conquista com descrição e bônus", "trecho": "com o nome do professor, os pontos e a mensagem dele", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Visual dos cartões de evento: emoji grande, gradiente radial, dourado para medalha, modo escuro", "trecho": ".evento-medalha .evento-corpo { background: radial-gradient(circle at 50% 0%, #fef3c7, transparent 70%); }", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Comentário pelo feed redireciona para âncora do post e recusa 'voltar' externo (pode ser preexistente)", "trecho": "voltar: '//site-malicioso.com' })).local, '/#post-2'", "tipo": "segurança", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Script de demo com horários espalhados nas últimas horas", "trecho": "os dados de exemplo agora têm horários espalhados pelas últimas horas, para a banca ver", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Acrescentar testes automáticos do feed", "trecho": "Agora os testes automáticos:", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conferência visual com print headless", "trecho": "Vou tirar um print rápido para conferir o visual", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Atualizar o README", "trecho": "Por último, atualizo o README", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Commit só após autorização, em branch própria, sem merge na main nem push", "trecho": "Não juntei com a main e não enviei nada para o GitHub.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true},
    {"descricao": "Feed mostra só conquistas de usuários com papel aluno", "trecho": "WHERE ca.anunciar = 1 AND u.papel = 'aluno'", "tipo": "regra de produto", "forma": "silenciosa", "duvidosa": true}
  ],
  "perguntas": [
    {"texto": "Se quiser, faço como nas rodadas anteriores (\"rodada: leigo_02_feed\").", "respondida": true},
    {"texto": "Se quiser isso também, eu faço. (curtir e comentar nos cartões de medalha e conquista)", "respondida": false},
    {"texto": "Não juntei com a main e não enviei nada para o GitHub. Se quiser, é só pedir.", "respondida": false}
  ],
  "contagem": {"decisoes": 22, "declaradas": 16, "silenciosas": 6, "duvidosas": 5, "perguntas": 3, "perguntas_respondidas": 1}
}
```
