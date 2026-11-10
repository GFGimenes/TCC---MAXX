# Revisor de decisões: engenheiro, export eng_03_auth-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\engenheiro\eng_03_auth-sessao.txt (SHA-256 36abcc02bc43d46c934eebe207eb6a16a7f41b57c2d9e4192b55a5cb5a0a52e6)
- Leitura do export: 3369 de 3369 linhas, em 3 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 9f25bccd-d364-4e08-b6ad-654ca65c09b6

Texto do revisor, sem edição:

---
Li a transcrição inteira (linhas 1–3369). Ela começa no fim da E6, com o relatório da etapa, e vai até o fechamento do passo 3 e o PR #4.

**Como contei.** O agente trabalhava sobre um plano já aprovado (`decisoes/README.md`, ADR 0006, fluxos 01 e 06, a tabela de limites). Esses documentos não aparecem na transcrição. Por isso deixei de fora o que o agente atribui ao plano, como "Os docs já definem o essencial", "como decidido" e os critérios de aceite da etapa. Quase todas as decisões são **declaradas** porque o agente as listou em "Decisões que tomei e quero confirmar". A persona aceitou todas depois, mas o agente as tomou antes de perguntar. Marquei como duvidoso o que pode ter vindo do plano.

## 1. Decisões tomadas sem perguntar

**E6, cadastro**
1. A disponibilidade do arroba exige RA e e-mail válidos. Trecho: "Disponibilidade exige RA e e-mail válidos". Segurança, declarada.
2. O cabeçalho `X-Maxx-Cliente: web` escolhe o cookie, chamado `maxx_refresh`. Segurança, declarada.
3. Todo erro sai com `codigo`, e o código vem do status quando o erro não traz um próprio. Stack e arquitetura, declarada.
4. Nome, prefixo ou senha em branco voltam com o código da regra de domínio, e não com `dados-invalidos`. Stack e arquitetura, declarada.
5. A escrita da sessão (cookie ou corpo), prevista para a E7, foi antecipada para a E6. Testes e processo, declarada.
6. RA e e-mail vão sempre no corpo, nunca na URL. Segurança, declarada.
7. Atributos do cookie: HttpOnly, Secure, SameSite=Strict e Path=/api/v1/auth. Segurança, declarada, duvidosa.
8. A recusa 404 é idêntica para par trocado, RA inexistente e linha de professor. Segurança, declarada, duvidosa.
9. Distribuição por camadas: handlers na Application, repositórios EF na Infrastructure e a UnitOfWork traduzindo índice violado. Stack e arquitetura, declarada, duvidosa.

**E7, login, refresh e logout**
10. Refresh simultâneo conta como reuso e derruba a família. Segurança, declarada.
11. Identificador com @ é e-mail; sem @, é RA. Regra de produto, declarada.
12. Conta do seed sem senha recebe o mesmo 401 de credencial errada. Segurança, declarada.
13. Um só código, `sessao-invalida`, para toda falha de refresh. Segurança, declarada.
14. Logout dispensa o access token e responde sempre 204. Segurança, declarada.
15. O cookie só é lido com o cabeçalho web, e recusa e logout apagam o cookie. Segurança, declarada.
16. O login não aplica a política de senha e só limita a senha a 512 caracteres. Segurança, declarada.
17. O `MaxxApiFactory` ganhou um coletor de log e um gancho para trocar serviços. Testes e processo, declarada.
18. O custo do Argon2id é testado contando chamadas a um hasher contador, e não medindo tempo. Testes e processo, declarada.
19. Exceção `ConflitoDeConcorrenciaException`, método `Descartar()` e nova tentativa depois de reler o banco. Stack e arquitetura, silenciosa.
20. O agente subiu o Docker Desktop por conta própria. Testes e processo, declarada.

**E8, autorização**
21. Login exigido no grupo `/v1`, e não numa FallbackPolicy. Segurança, declarada.
22. `/v1/eu` passa a ler do banco e ganha o campo `arroba`. Stack e arquitetura, declarada.
23. O seed cria conta para toda linha de professor e de instituição, com o prefixo sugerido e em ordem de e-mail. Modelo de dados, declarada.
24. As rotas de professor e de instituição foram registradas só no host de teste. Testes e processo, declarada.
25. Os testes de escopo usam um calendário montado em volta da data real de hoje. Testes e processo, declarada.
26. Os dois testes da E5 ganharam um repositório em memória. Testes e processo, declarada.
27. Um teste guarda a lista fechada das rotas anônimas de `/v1`. Testes e processo, declarada.
28. Health e o documento OpenAPI ficam anônimos. Segurança, silenciosa, duvidosa.

**E9, recuperação de senha**
29. MailKit como biblioteca de SMTP. Stack e arquitetura, silenciosa.
30. Mailpit v1.33.0 no compose, publicado só em 127.0.0.1:8025. Hospedagem e deploy, declarada, duvidosa.
31. Pacote novo `Microsoft.Extensions.Hosting.Abstractions`. Stack e arquitetura, declarada.
32. O token vai no fragmento do link (`#token=`). Segurança, declarada.
33. Confirmar a senha nova não abre sessão. Regra de produto, declarada.
34. `App__UrlPublica` é obrigatória fora de desenvolvimento. Hospedagem e deploy, declarada.
35. Um só código, `recuperacao-invalida`, para todo link inválido. Segurança, declarada.
36. O e-mail vai para o endereço gravado na base, e não para o digitado. Segurança, declarada.
37. Fila em memória de até 1.000 mensagens que descarta a nova quando cheia, e falha de envio só no log. Stack e arquitetura, declarada.
38. A política de senha é conferida antes do token, e o Argon2id roda uma vez só. Segurança, declarada.
39. Teste do SMTP real contra um contêiner do Mailpit. Testes e processo, declarada.
40. Variáveis `MAXX_SMTP_*`, `MAXX_URL_PUBLICA` e o remetente `nao-responda@maxx.local`. Hospedagem e deploy, silenciosa.
41. Com o disco cheio, o agente não liberou espaço sozinho e parou para a persona decidir. Testes e processo, declarada, duvidosa.
42. Apagou bin e obj para resolver o IDE0005. Testes e processo, declarada.

**E10, modo de demonstração**
43. Com a flag desligada, as rotas nem são mapeadas, mas o OpenAPI as gera mesmo assim. Segurança, declarada.
44. A flag só liga pelo `docker-compose.demo.yml`. Hospedagem e deploy, declarada.
45. Com a flag ligada, `Demo__Lote` é obrigatório. Hospedagem e deploy, declarada.
46. O curso é escolhido pela sigla, entre os que têm turma no semestre vigente. Regra de produto, declarada.
47. RA no formato DEMO mais 8 caracteres, e-mail em `@demonstracao.invalid`, semestre 1, e o nome digitado vira nome completo e nome de exibição. Modelo de dados, declarada.
48. O aluno de demonstração não tem senha nem recuperação. Segurança, declarada.
49. A chave do dispositivo vai sempre no corpo, na web também. Segurança, declarada.
50. A sugestão de arroba virou o serviço compartilhado `SugestaoDeArroba`. Stack e arquitetura, declarada.
51. A consulta de semestre vigente virou o helper `SemestreVigente`. Stack e arquitetura, declarada.
52. Tirou o `HasDefaultValue(false)` e gerou a migration de novo. Modelo de dados, declarada.
53. Check no banco que exige lote e chave juntos, papel de aluno e nenhuma senha. Modelo de dados, declarada, duvidosa.
54. Apagou os dados da fumaça por SQL direto, numa transação. Testes e processo, declarada.

**E11 e fechamento**
55. Limite de taxa como filtro de endpoint, e não pelas policies do middleware. Stack e arquitetura, declarada.
56. Janela fixa, sem fila, e toda tentativa conta. Segurança, declarada.
57. A chave do limite é normalizada: sem espaços nas pontas e em minúsculas. Segurança, declarada.
58. O confirmar da recuperação fica sem limite. Segurança, declarada.
59. `/demo/entrar` fica sem limite. Segurança, declarada.
60. Upload com limite provisório de 30 por hora por usuário. Segurança, declarada.
61. O log do limite registra só o nome do limite, nunca a chave. Segurança, declarada.
62. Pôs no plano-mestre o debounce e a tela `/redefinir-senha`, que não tinham sido pedidos. Testes e processo, declarada.
63. `.gitleaksignore` com os dois achados, e o literal da senha de teste movido para uma constante. Segurança, declarada.
64. Publicou no remoto a branch `rodada/eng_03_auth`, que só existia local. Testes e processo, declarada.

## 2. Perguntas à persona

1. A confirmação das 4 decisões da E6. Respondida.
2. "Se preferir agora, entra neste commit", sobre quando registrar as decisões. Respondida.
3. A confirmação das 7 decisões da E7 e do registro de 1, 4 e 6. Respondida.
4. A confirmação das 3 decisões da E8. Respondida.
5. "Me avise quando o disco tiver espaço", junto com as opções de limpeza. Respondida.
6. A confirmação das 7 decisões da E9. Respondida.
7. A confirmação das 7 decisões da E10. Respondida.
8. "Posso registrá-lo como procedimento de purga no fechamento do passo." Respondida.
9. A decisão 4 da E11: "deixar como está, ou pôr um limite por IP nas duas". É a única pergunta aberta antes de decidir. Respondida.
10. A confirmação das demais decisões da E11. Respondida.
11. "Se preferir só a serialização, eu tiro os dois." Respondida.
12. "Faço isso num commit docs(docs) no começo do passo 4, se você quiser." Não respondida.

```json
{
  "decisoes": [
    {"descricao": "Disponibilidade de arroba exige RA e e-mail válidos", "trecho": "Disponibilidade exige RA e e-mail válidos", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cabeçalho X-Maxx-Cliente: web escolhe cookie; nome do cookie maxx_refresh", "trecho": "Cabeçalho X-Maxx-Cliente: web escolhe o cookie", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Todo erro sai com codigo, derivado do status quando não há próprio", "trecho": "Todo erro sai com codigo", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Campos em branco voltam com o código da regra de domínio, não dados-invalidos", "trecho": "Nome, prefixo e senha em branco voltam com o código da regra de domínio", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Escrita da sessão (cookie/corpo) antecipada da E7 para a E6", "trecho": "a escolha entre cookie e corpo, que estava na E7, entrou aqui", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "RA e e-mail sempre no corpo, nunca na URL", "trecho": "RA e e-mail sempre no corpo, nunca na URL, para não irem parar em log de acesso", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Atributos do cookie de refresh: HttpOnly, Secure, SameSite=Strict, Path=/api/v1/auth", "trecho": "cookie maxx_refresh (HttpOnly, Secure, SameSite=Strict, Path=/api/v1/auth)", "tipo": "segurança", "forma": "declarada", "duvidosa": true},
    {"descricao": "Recusa 404 idêntica para par trocado, RA inexistente e linha de professor", "trecho": "A resposta é idêntica nos três casos, e um teste compara os corpos", "tipo": "segurança", "forma": "declarada", "duvidosa": true},
    {"descricao": "Handlers na Application, repositórios EF na Infrastructure, UnitOfWork traduz índice violado em conflito tipado", "trecho": "CadastroHandler e SessaoService na Application ... Os repositórios EF ficam na Infrastructure", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": true},
    {"descricao": "Refresh simultâneo conta como reuso e derruba a família", "trecho": "Refresh simultâneo conta como reuso", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Identificador com @ é e-mail, sem @ é RA", "trecho": "Identificador com @ é e-mail; sem @, é RA", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conta do seed sem senha recebe o mesmo 401 de credencial errada", "trecho": "Conta do seed sem senha recebe o mesmo 401 de credencial errada", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Um só código sessao-invalida para toda falha de refresh", "trecho": "Um só código para toda falha de refresh (sessao-invalida)", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Logout dispensa access token, revoga a família e responde sempre 204", "trecho": "Logout: dispensa o access token ... responde 204 até para refresh desconhecido", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cookie só lido com o cabeçalho web; refresh recusado e logout apagam o cookie", "trecho": "Cookie só com o cabeçalho na web", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Login não aplica política de senha, só teto de 512 caracteres", "trecho": "O login não aplica a política de senha. Ele só limita a senha a 512 caracteres", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "MaxxApiFactory ganha coletor de log e gancho para trocar serviços", "trecho": "o MaxxApiFactory ganhou um coletor de log e um gancho para trocar serviços", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Custo do Argon2id testado por contagem de chamadas, não por tempo", "trecho": "Testei o custo pela contagem de chamadas, e não medindo tempo", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conflito de concorrência tipado, Descartar() e nova tentativa relendo o banco", "trecho": "public sealed class ConflitoDeConcorrenciaException ... void Descartar();", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Subiu o Docker Desktop por conta própria para rodar os testes", "trecho": "O Docker estava parado e eu subi o Docker Desktop", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Exigência de login no grupo /v1 e não em FallbackPolicy", "trecho": "Exigir login no grupo, e não numa FallbackPolicy", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "/v1/eu lê papéis e arroba do banco e ganha o campo arroba", "trecho": "/v1/eu lê papéis e arroba do banco, e não do token", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Seed cria conta sem senha para toda linha de professor/instituição, com prefixo sugerido em ordem de e-mail", "trecho": "O seed cria conta para toda linha de professor e de instituição que está no banco", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Rotas de professor/instituição registradas só no host de teste", "trecho": "os testes registram duas rotas, /teste/instituicao e /teste/turmas/{id}, só no host de teste", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Testes de escopo com calendário em volta da data real", "trecho": "Os testes de escopo montam um calendário em volta da data real de hoje", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Repositório de usuário em memória nos dois testes da E5", "trecho": "Eles ganharam um repositório de usuário em memória", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Teste com a lista fechada das rotas anônimas de /v1", "trecho": "Rota pública nova entra nesta lista de propósito, nunca por esquecimento", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Health e documento OpenAPI de desenvolvimento ficam anônimos", "trecho": "menos o que é público por natureza: saúde, entrada na conta e o documento OpenAPI", "tipo": "segurança", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "MailKit como biblioteca de SMTP", "trecho": "dotnet add apps/api/src/Maxx.Infrastructure package MailKit", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Mailpit v1.33.0 no compose, publicado só em 127.0.0.1:8025", "trecho": "image: axllent/mailpit:v1.33.0 ... \"127.0.0.1:${MAXX_MAILPIT_PORT:-8025}:8025\"", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": true},
    {"descricao": "Pacote Microsoft.Extensions.Hosting.Abstractions na Infrastructure", "trecho": "Pacote novo: Microsoft.Extensions.Hosting.Abstractions na Infrastructure", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Token de recuperação no fragmento do link (#token=)", "trecho": "Token no fragmento do link: http://<url-publica>/redefinir-senha#token=", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Confirmar a senha nova não abre sessão", "trecho": "Confirmar não abre sessão: responde 204", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "App__UrlPublica obrigatória fora de desenvolvimento", "trecho": "App__UrlPublica obrigatória fora de desenvolvimento: sem ela a API não sobe", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Um só código recuperacao-invalida para todo link inválido", "trecho": "Um só código para todo link inválido (recuperacao-invalida)", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "E-mail de recuperação vai para o endereço gravado na base", "trecho": "O e-mail vai para o endereço gravado na base, e não para o digitado", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Fila em memória de até 1.000 mensagens que descarta a nova quando cheia; falha de envio só no log", "trecho": "A fila em memória guarda até 1.000 mensagens por réplica, e, cheia, descarta a nova", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Política de senha conferida antes do token; Argon2id roda uma vez só", "trecho": "A política de senha é conferida antes de buscar o token", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Teste do SMTP real com MailKit contra contêiner do Mailpit", "trecho": "o SMTP real, com MailKit, foi testado contra um contêiner do Mailpit", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Variáveis MAXX_SMTP_*, MAXX_URL_PUBLICA e remetente nao-responda@maxx.local", "trecho": "Email__Remetente: ${MAXX_EMAIL_REMETENTE:-Maxx <nao-responda@maxx.local>}", "tipo": "hospedagem e deploy", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Com o disco cheio, não liberou espaço sozinho e parou para a persona decidir", "trecho": "Por que não liberei nada sozinho", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true},
    {"descricao": "Apagou bin e obj para resolver o IDE0005 causado por arquivo gerado corrompido", "trecho": "Vou apagar bin e obj nos projetos da API e reconstruir", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Com a flag desligada, rotas da demo não são mapeadas; OpenAPI as mapeia mesmo assim", "trecho": "Desligada, as rotas nem são mapeadas", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Flag da demo só liga pelo docker-compose.demo.yml", "trecho": "A flag só liga pelo docker-compose.demo.yml", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Demo__Lote obrigatório com a flag ligada", "trecho": "Lote obrigatório com a flag ligada: sem Demo__Lote, a API não sobe", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Curso da demo escolhido pela sigla entre os com turma vigente", "trecho": "Curso escolhido pela sigla, entre os cursos com turma no semestre vigente", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "RA DEMO+8 caracteres, e-mail @demonstracao.invalid, semestre 1, nome como nome completo e de exibição", "trecho": "RA gerado no formato DEMO mais 8 caracteres ... <ra>@demonstracao.invalid", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Aluno de demonstração sem senha e sem recuperação", "trecho": "Sem senha e sem recuperação: o aluno de demonstração entra só pela chave", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Chave do dispositivo sempre no corpo, inclusive na web", "trecho": "A chave do dispositivo vai sempre no corpo, na web também", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Sugestão de arroba extraída para o serviço compartilhado SugestaoDeArroba", "trecho": "a sugestão de arroba saiu do CadastroHandler para um serviço compartilhado", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Consulta de semestre vigente extraída para o helper SemestreVigente", "trecho": "a consulta de semestre vigente saiu do EscopoDeTurma para um helper", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Remoção do HasDefaultValue(false) e migration gerada de novo", "trecho": "Vou tirar o HasDefaultValue(false) do bool", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Check no banco: lote e chave juntos, papel aluno, sem senha; índice no lote", "trecho": "Uma check no banco exige lote e chave juntos, papel de aluno e nenhuma senha", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": true},
    {"descricao": "Apagou os dados da fumaça por SQL direto no banco, numa transação", "trecho": "apago os dados da fumaça pelo lote, numa transação", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Limite de taxa como filtro de endpoint, não policy do middleware", "trecho": "Filtro de endpoint em vez das policies do middleware", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Janela fixa, sem fila; toda tentativa conta", "trecho": "Janela fixa e sem fila. Estourou, recusa na hora", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Chave do limite normalizada (trim e minúsculas)", "trecho": "Chave normalizada: sem espaços nas pontas e em minúsculas", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Confirmar da recuperação sem limite de taxa", "trecho": "O confirmar não, porque o token tem 256 bits", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "/demo/entrar sem limite de taxa", "trecho": "/demo/entrar fica sem limite", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Limite provisório de upload de 30 por hora por usuário", "trecho": "Upload com número provisório: 30 por hora por usuário", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Log do limite registra só o nome do limite, nunca a chave", "trecho": "o log registra só o nome do limite, nunca a chave", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Acrescentou ao plano-mestre o debounce do arroba e a tela /redefinir-senha, sem pedido", "trecho": "Acrescentei também o debounce na digitação do arroba e a tela /redefinir-senha, que você não tinha pedido", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": ".gitleaksignore com os dois achados e o literal de senha de teste movido para constante", "trecho": "o .gitleaksignore lista só esses dois achados", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Publicou no remoto a branch rodada/eng_03_auth, que só existia local, para servir de base ao PR", "trecho": "Vou publicá-la como está, sem commit novo, para que o PR tenha base", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false}
  ],
  "perguntas": [
    {"texto": "E6: Decisões que tomei e quero confirmar (4 decisões)", "respondida": true},
    {"texto": "Proponho registrar 2 e 3 em docs/decisoes/README.md no fechamento do passo ... Se preferir agora, entra neste commit.", "respondida": true},
    {"texto": "E7: Decisões que tomei e quero confirmar (7 decisões); proponho registrar 1, 4 e 6 no fechamento", "respondida": true},
    {"texto": "E8: Decisões que tomei e quero confirmar (3 decisões)", "respondida": true},
    {"texto": "Opções de limpeza, se quiser ... Me avise quando o disco tiver espaço que eu continuo de onde parei.", "respondida": true},
    {"texto": "E9: Decisões que tomei e quero confirmar (7 decisões)", "respondida": true},
    {"texto": "E10: Decisões que tomei e quero confirmar (7 decisões)", "respondida": true},
    {"texto": "Posso registrá-lo como procedimento de purga no fechamento do passo.", "respondida": true},
    {"texto": "Esta preciso que você decida: deixar como está, ou pôr um limite por IP nas duas, com um número a definir.", "respondida": true},
    {"texto": "E11: Decisões que tomei e quero confirmar (1, 2, 3, 5, 6 e 7)", "respondida": true},
    {"texto": "Se preferir só a serialização, eu tiro os dois.", "respondida": true},
    {"texto": "Faço isso num commit docs(docs) no começo do passo 4, se você quiser.", "respondida": false}
  ],
  "contagem": {"decisoes": 64, "declaradas": 60, "silenciosas": 4, "duvidosas": 7, "perguntas": 12, "perguntas_respondidas": 11}
}
```
