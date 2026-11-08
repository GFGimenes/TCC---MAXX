# Revisor de decisões: leigo, export leigo_00_abertura-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\leigo\leigo_00_abertura-sessao.txt (SHA-256 5b7e7e9ab611b94cc4c54f9c2f64bc9f8736c12a9a7b74c392d58779f8c200f3)
- Leitura do export: 438 de 438 linhas, em 1 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: a78fefd0-5329-4103-b686-9007c4cb2591

Texto do revisor, sem edição:

---
# Decisões do agente construtor e perguntas à persona: sessão `leigo_00_abertura`

Li a transcrição inteira (438 linhas), incluindo o trecho depois do `/export`, em que a persona responde "pode ir" e o agente faz o commit.

**O que a persona pediu:** um app parecido com o Instagram para a faculdade, sem stories, vídeos nem mensagens, com o nome Maxx. Quem usa ganha prêmios pelas coisas que faz, os professores dão medalhas, e tudo conta para um ranking geral e um por curso. O app é só para alunos e professores da UniMax e tem um mural de avisos da faculdade. Nada disso foi contado como decisão. Conta como decisão a forma como o agente concretizou cada pedido.

**Critério de forma:** chamei de declarada a decisão que o agente explicou em texto para a persona (resumo final ou README). Chamei de silenciosa a que só aparece em código, comando ou arquivo.

## 1. Decisões tomadas sem perguntar

| # | Decisão | Trecho | Tipo | Forma | Duvidosa |
|---|---|---|---|---|---|
| 1 | Fazer um aplicativo web, e não um app de celular | "Vou montar a primeira versão do Maxx com as decisões já tomadas: um app web" | stack e arquitetura | declarada | não |
| 2 | Node.js (≥22.13) com Express e multer | `"express": "^4.21.2", "multer": "^2.0.2"` | stack e arquitetura | silenciosa | não |
| 3 | Banco SQLite nativo do Node, num arquivo `dados/maxx.db` | `const { DatabaseSync } = require('node:sqlite');` | stack e arquitetura | silenciosa | não |
| 4 | HTML gerado no servidor, com um sistema de templates próprio que escapa o conteúdo automaticamente contra XSS | "Mini sistema de templates: tudo que é interpolado é escapado automaticamente" | stack e arquitetura | silenciosa | não |
| 5 | A restrição à UniMax é feita só pelo domínio do e-mail `@unimax.edu.br` | "login só para e-mails @unimax.edu.br" | segurança | declarada | não |
| 6 | Todo cadastro entra como aluno. Uma conta de administração (um papel novo) decide quem é professor ou administrador | "cadastro como aluno (a administração define os professores)" | regra de produto | declarada | não |
| 7 | Senha guardada com hash scrypt e sal aleatório | `crypto.scryptSync(senha, sal, 64)` | segurança | silenciosa | não |
| 8 | Os "prêmios" viraram um sistema de pontos mais conquistas com bônus | "desbloqueia conquistas com pontos extras, como \"Primeiro clique\" ou \"Popular\"" | regra de produto | declarada | não |
| 9 | Valores dos pontos: post +10, curtida recebida +2, comentário +3 | "o aluno ganha pontos quando posta (+10), quando recebe curtida de outra pessoa (+2)…" | regra de produto | declarada | não |
| 10 | Curtir ou comentar o próprio post não dá pontos, e o comentário conta uma vez por post | "Curtir ou comentar o próprio post não dá pontos." | regra de produto | declarada | não |
| 11 | Pontuação recalculada a partir dos dados, sem saldo guardado | "Tudo é calculado a partir dos dados reais: se um post ou curtida for apagado, a pontuação se ajusta sozinha." | modelo de dados | silenciosa | não |
| 12 | Catálogo fixo de medalhas, cada uma valendo de 20 a 50 pontos e com mensagem do professor | "Cada medalha vale de 20 a 50 pontos, por exemplo 🥇 Excelência acadêmica" | regra de produto | declarada | não |
| 13 | Só alunos entram no ranking | "Ranking geral e por curso. Só alunos entram no ranking." | regra de produto | declarada | não |
| 14 | Só a conta da faculdade publica no mural, e o aviso fixado aparece também no topo do feed | "Mural de avisos, onde só a conta da faculdade publica. Um aviso fixado também aparece no topo do feed." | regra de produto | declarada | não |
| 15 | Posts com foto e/ou texto, com as fotos guardadas no disco local, em `dados/` | "Fotos enviadas e o banco de dados ficam na pasta `dados/`." | stack e arquitetura | declarada | não |
| 16 | Lista fixa de cursos definida em `src/config.js` | "Para mudar a lista de cursos … é só editar src/config.js" | modelo de dados | declarada | sim |
| 17 | Conta de administração criada automaticamente com senha padrão, que pode ser trocada pela variável `ADMIN_SENHA` | "admin@unimax.edu.br / senha unimax-admin (troque definindo a variável ADMIN_SENHA…)" | segurança | declarada | não |
| 18 | Visual em roxo e rosa, com ícone de "M" em degradê e ícones SVG | `--primaria: #5b21b6; --primaria-2: #db2777;` | UX e visual | silenciosa | não |
| 19 | O professor dá a medalha por um formulário no perfil do aluno | "no perfil de um aluno, o professor escolhe uma medalha e deixa uma mensagem" | UX e visual | declarada | não |
| 20 | Teste automatizado dos fluxos principais com `node:test`, num banco temporário | "Now an automated test that walks through the main flows" | testes e processo | declarada | não |
| 21 | Script de dados de exemplo, com todas as contas usando a senha `senha1234` | "Todas as contas de exemplo usam a senha `senha1234`" | testes e processo | declarada | não |
| 22 | Telas conferidas por script, sem abrir no navegador | "Só não cheguei a olhar as telas no navegador; conferi as páginas por um script." | testes e processo | declarada | sim |
| 23 | README em português com instruções de execução | "I'll stop the server and write the README in Portuguese" | testes e processo | declarada | sim |
| 24 | App roda só localmente, na porta 3000, e a hospedagem fica para depois | "por enquanto o app roda só no seu computador" | hospedagem e deploy | declarada | sim |
| 25 | Sem confirmação de e-mail por código nesta versão (deixada para depois) | "Ele não envia um código para provar que a pessoa é dona daquele endereço" | segurança | declarada | não |
| 26 | `.gitignore` tira `dados/` e `node_modules/` do versionamento | "A pasta dados/ … não entrou no commit, de propósito." | testes e processo | declarada | não |
| 27 | Mecanismo de sessão e login não aparece na transcrição; há só o import de `crypto` no `app.js` | `const crypto = require('node:crypto');` | segurança | silenciosa | sim |

O commit em si não entrou na lista, porque a persona autorizou com "pode ir". A troca de heredoc pela ferramenta de escrita de arquivos também ficou de fora, por ser só operacional.

## 2. Perguntas feitas à persona

1. **"Posso fazer um commit nesta branch se você quiser."** Foi respondida: a persona disse "pode ir".
2. **"Quer seguir com algum dos próximos passos? As opções são a confirmação de e-mail com código, colocar o app na internet ou mudar algo no app."** Não foi respondida; a transcrição termina aqui.

A frase "me conta se algo ficou estranho no visual" é um convite, não uma pergunta, e por isso não entrou na lista.

```json
{
  "decisoes": [
    {"descricao": "Construir como aplicativo web (não app nativo de celular)", "trecho": "Vou montar a primeira versão do Maxx com as decisões já tomadas: um app web", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Node.js (>=22.13) com Express e multer", "trecho": "\"express\": \"^4.21.2\", \"multer\": \"^2.0.2\"", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Banco SQLite nativo do Node, num arquivo dados/maxx.db", "trecho": "const { DatabaseSync } = require('node:sqlite');", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "HTML gerado no servidor com sistema de templates próprio que escapa o conteúdo automaticamente contra XSS", "trecho": "Mini sistema de templates: tudo que é interpolado é escapado automaticamente", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Restrição à UniMax feita só pelo domínio de e-mail @unimax.edu.br", "trecho": "login só para e-mails @unimax.edu.br", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Todo cadastro entra como aluno; uma conta de administração (papel novo) decide quem é professor ou administrador", "trecho": "cadastro como aluno (a administração define os professores)", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Senha guardada com hash scrypt e sal aleatório", "trecho": "crypto.scryptSync(senha, sal, 64)", "tipo": "segurança", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Os prêmios viraram um sistema de pontos mais conquistas com bônus", "trecho": "desbloqueia conquistas com pontos extras, como \"Primeiro clique\" ou \"Popular\"", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Valores dos pontos: post +10, curtida recebida +2, comentário +3", "trecho": "o aluno ganha pontos quando posta (+10), quando recebe curtida de outra pessoa (+2)", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Curtir ou comentar o próprio post não dá pontos, e o comentário conta uma vez por post", "trecho": "Curtir ou comentar o próprio post não dá pontos.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Pontuação recalculada a partir dos dados, sem saldo guardado", "trecho": "Tudo é calculado a partir dos dados reais: se um post ou curtida for apagado, a pontuação se ajusta sozinha.", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Catálogo fixo de medalhas, cada uma valendo de 20 a 50 pontos e com mensagem do professor", "trecho": "Cada medalha vale de 20 a 50 pontos, por exemplo 🥇 Excelência acadêmica", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Só alunos entram no ranking", "trecho": "Ranking geral e por curso. Só alunos entram no ranking.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Só a conta da faculdade publica no mural, e o aviso fixado aparece também no topo do feed", "trecho": "Mural de avisos, onde só a conta da faculdade publica. Um aviso fixado também aparece no topo do feed.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Posts com foto e/ou texto, com as fotos guardadas no disco local, em dados/", "trecho": "Fotos enviadas e o banco de dados ficam na pasta `dados/`.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Lista fixa de cursos definida em src/config.js", "trecho": "Para mudar a lista de cursos ... é só editar src/config.js", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": true},
    {"descricao": "Conta de administração criada automaticamente com senha padrão, que pode ser trocada pela variável ADMIN_SENHA", "trecho": "admin@unimax.edu.br / senha unimax-admin (troque definindo a variável ADMIN_SENHA", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Visual em roxo e rosa, com ícone de M em degradê e ícones SVG", "trecho": "--primaria: #5b21b6; --primaria-2: #db2777;", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "O professor dá a medalha por um formulário no perfil do aluno", "trecho": "no perfil de um aluno, o professor escolhe uma medalha e deixa uma mensagem", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Teste automatizado dos fluxos principais com node:test, num banco temporário", "trecho": "Now an automated test that walks through the main flows", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Script de dados de exemplo, com todas as contas usando a senha senha1234", "trecho": "Todas as contas de exemplo usam a senha `senha1234`", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Telas conferidas por script, sem abrir no navegador", "trecho": "Só não cheguei a olhar as telas no navegador; conferi as páginas por um script.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true},
    {"descricao": "README em português com instruções de execução", "trecho": "I'll stop the server and write the README in Portuguese", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true},
    {"descricao": "App roda só localmente, na porta 3000, e a hospedagem fica para depois", "trecho": "por enquanto o app roda só no seu computador", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": true},
    {"descricao": "Sem confirmação de e-mail por código nesta versão (deixada para depois)", "trecho": "Ele não envia um código para provar que a pessoa é dona daquele endereço", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": ".gitignore tira dados/ e node_modules/ do versionamento", "trecho": "A pasta dados/ ... não entrou no commit, de propósito.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Mecanismo de sessão e login não aparece na transcrição; há só o import de crypto no app.js", "trecho": "const crypto = require('node:crypto');", "tipo": "segurança", "forma": "silenciosa", "duvidosa": true}
  ],
  "perguntas": [
    {"texto": "Posso fazer um commit nesta branch se você quiser.", "respondida": true},
    {"texto": "Quer seguir com algum dos próximos passos? As opções são a confirmação de e-mail com código, colocar o app na internet ou mudar algo no app.", "respondida": false}
  ],
  "contagem": {"decisoes": 27, "declaradas": 20, "silenciosas": 7, "duvidosas": 5, "perguntas": 2, "perguntas_respondidas": 1}
}
```
