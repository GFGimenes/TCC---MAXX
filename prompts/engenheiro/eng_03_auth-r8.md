ID: eng_03_auth-r8
Trilha: engenheiro
Tela: passo 3 (resposta 8 do autor: revisão da E7, login, refresh rotativo e logout)
Data: 2026-11-03
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E6 commitada em `733ddcf` após a retomada.
- E7: `POST /api/v1/auth/login`, `/refresh`, `/logout`; corpos idênticos para senha errada, RA e e-mail inexistentes e conta do seed sem senha; custo igualado provado por hasher contador; reuso revoga a família com log Warning; concorrência por HTTP (dois refresh simultâneos deixam um 200 e um 401, 5 rodadas); senha e tokens ausentes do log; 398 testes, 17 novos; fumaça pelo Caddy. O agente subiu o Docker Desktop sozinho (estava parado).
- Primeira linha da entrega em inglês ("E7 is ready for your review, not committed."), o resto em português: primeira mensagem depois da compactação automática e do `--resume`. Registrado como efeito da ferramenta; não corrigido no prompt.
- Desvio aceito: coletor de log e gancho de serviços no `MaxxApiFactory`. Sete decisões aceitas; a primeira (refresh simultâneo conta como reuso) torna a serialização no cliente item obrigatório do passo 5. Registro de 1, 4 e 6 no fechamento do passo.

---
E7 aprovada. O desvio do MaxxApiFactory fica. As sete decisões aceitas: refresh simultâneo conta como reuso e a serialização no cliente vira item obrigatório do passo 5; @ decide e-mail ou RA; conta do seed sem senha recebe o mesmo 401; um só código sessao-invalida; logout sempre 204; cookie só com o cabeçalho web; login sem política de senha, com teto de 512. Registra 1, 4 e 6 no fechamento, junto com 2 e 3 da E6. Commita com a mensagem proposta, push, e segue para a E8; para para a minha revisão no fim dela.
