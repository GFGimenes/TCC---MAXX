# Revisor de decisões: leigo, export leigo_01_login-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\leigo\leigo_01_login-sessao.txt (SHA-256 418b03fba8b16c1439d4ab09dd316104490d4dba6ef2f870c87554d4b992d4da)
- Leitura do export: 476 de 476 linhas, em 1 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 2be66fe1-42f5-4c83-a6ef-b07ab4478ba5

Texto do revisor, sem edição:

---
# Revisão das decisões do agente: sessão leigo_01_login

Li a introdução da rubrica e a transcrição inteira, que é curta: 476 linhas e dois turnos da persona. O primeiro turno pede a tela de entrar e a de cadastro, diz que só quem é da UniMax pode entrar, pede um jeito fácil de a banca entrar sem cadastro na faculdade e termina com "Faz do jeito que ficar melhor". O segundo turno é só "pode ir".

A persona não definiu como a banca entraria. Por isso, quase tudo sobre esse acesso foi decisão do agente. O agente explicou a maior parte dessas escolhas no resumo final ou no README e não fez nenhuma pergunta antes de implementar.

## 1. Decisões tomadas sem perguntar

| # | Decisão | Trecho | Tipo | Forma | Duvidosa |
|---|---|---|---|---|---|
| 1 | Não mexer nas telas de entrar e cadastrar, que já existiam; fazer só o acesso da banca | "as telas de entrar e de cadastro já existiam no app [...] Não mexi nelas" | regra de produto | declarada | sim (pode ser só uma constatação) |
| 2 | A banca entra com um código de acesso compartilhado, e não com um botão "entrar sem senha" | "Por que escolhi um código em vez de um botão 'entrar sem senha'" | segurança | declarada | não |
| 3 | O acesso fica desligado por padrão e só liga com a variável de ambiente `CODIGO_BANCA` | "Fica DESLIGADO por padrão. Para ligar [...] a variável CODIGO_BANCA" | segurança | declarada | não |
| 4 | O código precisa ter no mínimo 6 caracteres | "a variável CODIGO_BANCA definida (mínimo 6 caracteres)" | segurança | declarada | não |
| 5 | Três perfis de teste: Aluno(a), Professor(a) e Faculdade, este com poderes de administrador | "clica em um de três botões: Aluno(a) [...] Professor(a) [...] Faculdade" | regra de produto | declarada | não |
| 6 | As contas de teste são criadas sozinhas no primeiro acesso | "As contas de teste são criadas sozinhas no primeiro acesso." | modelo de dados | declarada | não |
| 7 | As contas de teste usam e-mails fixos do domínio da faculdade (ex.: `banca.aluno@unimax.edu.br`) | "email: 'banca.aluno@unimax.edu.br'" | modelo de dados | silenciosa | não |
| 8 | As contas de teste não têm senha, e ninguém consegue se cadastrar com os e-mails delas | "As contas de teste não têm senha [...] ninguém consegue se cadastrar com os e-mails delas" | segurança | declarada | não |
| 9 | Ao desligar o acesso, as sessões das contas de teste caem na hora (checagem no middleware) | "até quem estava logado numa conta de teste perde o acesso na hora" | segurança | declarada | não |
| 10 | Depois de 10 códigos errados, o aparelho espera 15 minutos | "Depois de 10 códigos errados, o aparelho tem que esperar 15 minutos" | segurança | declarada | não |
| 11 | O código não diferencia maiúsculas de minúsculas | "(sem ligar para maiúsculas)" … `codigo: 'Banca-Teste'` | segurança | silenciosa | não |
| 12 | Toda a lógica fica num módulo próprio, `src/banca.js`, com a rota nova `POST /banca` | "vou criar um módulo dedicado" / "O endereço /banca em src/app.js" | stack e arquitetura | declarada | não |
| 13 | A banca ganha uma caixa "Banca do TCC" na tela de entrar, com campo de código e um botão por perfil, e borda tracejada | ".banca { margin-top: 1rem; border-style: dashed; }" / "<h2>Banca do TCC</h2>" | UX e visual | declarada | não |
| 14 | Código errado devolve 401 com a mensagem "Código de acesso incorreto" | "assert.match(errado.html, /Código de acesso incorreto/)" | UX e visual | silenciosa | sim (detalhe menor) |
| 15 | Escrever um teste automatizado para o acesso da banca | "Agora um teste para o acesso da banca" | testes e processo | declarada | não |
| 16 | Documentar no README como ligar o acesso, inclusive com comandos para PowerShell e para Mac/Linux | "Agora documento no README" | testes e processo | declarada | não |
| 17 | Não fazer commit sem autorização; depois do "pode ir", fazer o commit na branch `rodada/leigo_01_login` com uma mensagem escolhida por ele | "Fiz o commit [...] com o nome 'Acesso da banca do TCC com código de acesso'" | testes e processo | declarada | sim |
| 18 | Não enviar para o GitHub nem abrir pull request | "Não enviei pro GitHub, o commit está só no seu computador." | testes e processo | declarada | sim |

Recomendações que o agente deu sem implementar não entraram na lista. Exemplos: rodar `npm run demo` e evitar contas de alunos reais.

## 2. Perguntas feitas à persona

O agente não perguntou nada antes de implementar. Só ofereceu ações no fim de cada turno:

1. "Não fiz commit. Se quiser, eu faço na branch rodada/leigo_01_login." A persona respondeu com "pode ir".
2. "Se quiser que eu envie ou que abra um pull request para a main, é só falar." Ficou sem resposta na transcrição.

```json
{
  "decisoes": [
    {"descricao": "Não alterar as telas de entrar/cadastrar que já existiam; implementar só o acesso da banca", "trecho": "as telas de entrar e de cadastro já existiam no app [...] Não mexi nelas", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Acesso da banca por código de acesso compartilhado, em vez de botão 'entrar sem senha'", "trecho": "Por que escolhi um código em vez de um botão \"entrar sem senha\"", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Acesso da banca desligado por padrão, ligado pela variável de ambiente CODIGO_BANCA", "trecho": "Fica DESLIGADO por padrão. Para ligar [...] a variável CODIGO_BANCA", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Código de acesso com no mínimo 6 caracteres", "trecho": "a variável CODIGO_BANCA definida (mínimo 6 caracteres)", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Três perfis de teste: Aluno(a), Professor(a) e Faculdade (administrador)", "trecho": "clica em um de três botões: Aluno(a) [...] Professor(a) [...] Faculdade", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Contas de teste criadas automaticamente no primeiro acesso", "trecho": "As contas de teste são criadas sozinhas no primeiro acesso.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Contas de teste com e-mails fixos no domínio da faculdade (ex.: banca.aluno@unimax.edu.br)", "trecho": "email: 'banca.aluno@unimax.edu.br'", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Contas de teste sem senha e com e-mails bloqueados para cadastro", "trecho": "As contas de teste não têm senha [...] ninguém consegue se cadastrar com os e-mails delas", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ao desligar o acesso, as sessões das contas de teste são invalidadas na hora (checagem no middleware)", "trecho": "até quem estava logado numa conta de teste perde o acesso na hora", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Limite de tentativas: 10 códigos errados bloqueiam o aparelho por 15 minutos", "trecho": "Depois de 10 códigos errados, o aparelho tem que esperar 15 minutos", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Código de acesso sem distinção entre maiúsculas e minúsculas", "trecho": "(sem ligar para maiúsculas) ... codigo: 'Banca-Teste'", "tipo": "segurança", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Lógica em módulo dedicado src/banca.js, com rota nova POST /banca", "trecho": "vou criar um módulo dedicado", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Caixa 'Banca do TCC' na tela de entrar, com campo de código, botões por perfil e borda tracejada", "trecho": ".banca { margin-top: 1rem; border-style: dashed; }", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Código errado devolve 401 com a mensagem 'Código de acesso incorreto'", "trecho": "assert.match(errado.html, /Código de acesso incorreto/)", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Escrever teste automatizado para o acesso da banca", "trecho": "Agora um teste para o acesso da banca", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Documentar no README como ligar o acesso da banca (PowerShell e Mac/Linux)", "trecho": "Agora documento no README", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Não commitar sem autorização; depois, commit na branch rodada/leigo_01_login com mensagem escolhida pelo agente", "trecho": "Fiz o commit [...] com o nome \"Acesso da banca do TCC com código de acesso\"", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true},
    {"descricao": "Não enviar para o GitHub nem abrir pull request", "trecho": "Não enviei pro GitHub, o commit está só no seu computador.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true}
  ],
  "perguntas": [
    {"texto": "Não fiz commit. Se quiser, eu faço na branch rodada/leigo_01_login.", "respondida": true},
    {"texto": "Se quiser que eu envie ou que abra um pull request para a main, é só falar.", "respondida": false}
  ],
  "contagem": {"decisoes": 18, "declaradas": 15, "silenciosas": 3, "duvidosas": 4, "perguntas": 2, "perguntas_respondidas": 1}
}
```
