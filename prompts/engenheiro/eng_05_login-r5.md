ID: eng_05_login-r5
Trilha: engenheiro
Tela: passo 5 (resposta 5 do autor: revisão da etapa 4, login e portão de rotas, primeira tela real)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor olhou as capturas do login ao lado das pranchetas; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 3 fechada em `7fafa77`, CI verde.
- Etapa 4: grupos de rota `(app)` e `(publico)` com portão, estado "sem conexão" sem apagar a sessão, `/status` para a tela antiga; tela de login pela prancheta com o texto do primeiro acesso da decisão 2, erros no campo e abaixo do botão; início provisório com arroba de `GET /v1/eu`, tema e Sair; base do e2e com linha de elegível por teste inserida por psql e conta pela API; passo seed demo na CI; 249 Jest, 35 e2e (RA, e-mail em maiúsculas, recarga, duas abas, limite de taxa). Erro de apoio do e2e (`INSERT 0 1` na contagem do psql) corrigido com `-q`. Leitura do Mailpit adiada para a etapa 6.
- Diferenças declaradas em relação à prancheta: bloco cerca de 25 pontos mais alto, fontes reais, texto novo do primeiro acesso. Autor aceitou a altura.

---
Etapa 4 aprovada. O bloco pode ficar como está; a prancheta é referência de layout, não de medida. Os links para /cadastro e /esqueci-senha ficam assim até as etapas 5 e 6. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 5; para para a minha revisão no fim dela, com as três telas do cadastro em captura.
