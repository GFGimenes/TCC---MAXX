ID: eng_03_auth-r6
Trilha: engenheiro
Tela: passo 3 (resposta 6 do autor: revisão da E5, Argon2id, JWT e borda de autenticação)
Data: 2026-11-03
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E5: `ISenhaHasher`, `ITokenGenerator`, `IAccessTokenIssuer`; Argon2id (Konscious, 19 MiB, t=2, p=1, PHC, comparação em tempo constante, verificação fictícia); JWT HS256 de 15 minutos só com sub e papel; chave obrigatória fora de Development; `DomainExceptionHandler` com ProblemDetails e `codigo`; `AddValidation()`; ForwardedHeaders restrito à rede do Caddy; esquema bearer no OpenAPI; chave no compose e descartável na CI. 359 testes; stack local recriada e `/api/v1/eu` sem token em 401 pelo Caddy.
- Três desvios declarados e aceitos (`/v1/eu` mínimo; teste de senha em log na E7; X-Forwarded-For na E11). Cinco decisões: formato de erro com `codigo` em kebab-case; tolerância de 30 s no JWT; chave gerada por processo em Development; sub-rede fixa no compose; normalização NFC da senha (o agente não fez e recomendou; o autor mandou fazer com teste).
- O agente acrescentou `MAXX_JWT_CHAVE` ao `.env` local do autor (fora do git), declarado.

---
E5 aprovada. Os três desvios ficam: /v1/eu mínimo agora, teste de senha em log na E7, X-Forwarded-For na E11. Decisões 1 a 4 aceitas, e 5 entra: normaliza a senha para NFC no Hash e no Verify, com teste do "ç" composto e decomposto dando o mesmo resultado. Registra 1, 2, 3 e 5 no README das decisões neste commit. Commita com a mensagem proposta, push, e segue para a E6; para para a minha revisão no fim dela.
