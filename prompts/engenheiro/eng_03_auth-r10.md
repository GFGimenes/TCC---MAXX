ID: eng_03_auth-r10
Trilha: engenheiro
Tela: passo 3 (resposta 10 do autor: revisão da E9, recuperação de senha com e-mail em segundo plano)
Data: 2026-11-04
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E9 retomada depois do disco cheio: Docker Desktop reiniciado pelo agente; o `using` removido era efeito de arquivo gerado corrompido em `obj`, regenerado.
- Entrega: `POST /api/v1/auth/recuperacao` (sempre 202) e `/recuperacao/confirmar` (204 ou 400); `IEmailSender` com MailKit, `BackgroundService` com fila em memória (1.000 por réplica), Mailpit 1.33.0 no compose; 425 testes, 14 novos, incluindo SMTP real contra contêiner do Mailpit e duas confirmações simultâneas; fumaça pelo Caddy com primeiro acesso da conta do seed e revogação das sessões.
- Dois desvios aceitos (pacote `Microsoft.Extensions.Hosting.Abstractions`; `App:UrlPublica` na configuração dos testes). Sete decisões aceitas: token no fragmento do link; confirmar sem sessão; `App__UrlPublica` obrigatória fora de desenvolvimento; um código para link inválido; e-mail para o endereço da base; falha de envio só em log até a fila do passo 6; política de senha antes do token.

---
E9 aprovada. Os dois desvios ficam. As sete decisões aceitas: token no fragmento do link com a rota /redefinir-senha no passo 5, confirmar sem abrir sessão, App__UrlPublica obrigatória fora de desenvolvimento, um só código recuperacao-invalida, e-mail para o endereço da base, falha de envio só em log até a fila do passo 6, política de senha antes do token. Registra 1, 3 e 6 no fechamento. Commita com a mensagem proposta, push, e segue para a E10; para para a minha revisão no fim dela.
