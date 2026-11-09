ID: eng_10_mural-r3
Trilha: engenheiro
Tela: passo 10 (resposta 3 do autor: revisão da etapa 2, leitura do mural)
Data: 2026-11-09
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1 em `76cd841`, CI verde nos seis jobs na primeira tentativa.
- Etapa 2 entregue sem commit: `GET /v1/mural` por cursor com ETag e 304, `GET /v1/avisos/{id}`, `PUT /v1/avisos/{id}/leitura` (marca a notificação na mesma transação), `POST /v1/mural/leitura`, `GET /v1/perfis/{id}/avisos`; visibilidade num lugar só; migration `LeituraDeAviso`; purga com teste; 9 testes de integração com prova reversa (sem o filtro, "Ler todos" marca 5 em vez de 3); suíte 1095.
- Dois pontos: (1) avisos de perfil inexistente devolvem lista vazia e não 404, diferente da grade de posts; autor pede 404 por coerência (uma linha); (2) duas migrations no passo, uma por etapa: aceito.

---
Etapa 2 aprovada com um ajuste de uma linha: GET /v1/perfis/{id}/avisos para perfil inexistente devolve 404, como a grade de posts, por coerência do contrato. As duas migrations por etapa estão dentro da regra. Com a suíte verde, commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 3; para para a minha revisão no fim dela.
