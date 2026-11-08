ID: eng_07_posts-r7
Trilha: engenheiro
Tela: passo 7 (resposta 7 do autor: revisão da etapa 6, perfil, busca e editar perfil na API)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 5 fechada em `76ab6b4`, CI verde.
- Etapa 6: `GET /v1/perfis/{id}` e `/v1/eu/perfil` (RA só no próprio; professor com turmas e medalhas concedidas; instituição 404; ETag fraca com 304 e `Cache-Control: private, no-cache`), grade por cursor em páginas de 18, `GET /v1/perfis/{id}/premios` só obtidos, `PATCH /v1/eu/perfil` tudo ou nada com reserva de prefixo e foto por upload conferido com HEAD, disponibilidade autenticada, busca com `unaccent` e `pg_trgm` (função imutável `maxx_sem_acento`, `%` e `_` como texto, mínimo de 2 caracteres ou filtro), avatar propagado ao feed, comentários e `/v1/eu`; migration `Perfil`; 6 de domínio e 23 de integração novos (744 na API).
- Bug latente do passo 3 descoberto e corrigido: `EditarPrefixo` dependia dos prefixos reservados carregados e `BuscarAsync` não os carregava; criado `BuscarComPrefixosAsync` só para a edição.
- Quatro ressalvas aceitas: busca sem EXPLAIN (k6 do passo 13); ETag poupa banda, não banco; migration exige `CREATE EXTENSION` (vai para a lista do passo 13); fotos de perfil do lote no bucket até a purga do passo 12.

---
Etapa 6 aprovada. A correção do BuscarComPrefixosAsync fica. As quatro ressalvas ficam registradas, e a do privilégio de CREATE EXTENSION entra na lista do passo 13 no plano mestre, na etapa 11. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 7; para para a minha revisão no fim dela, com captura da tela de novo post.
