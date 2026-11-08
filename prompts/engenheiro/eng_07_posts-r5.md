ID: eng_07_posts-r5
Trilha: engenheiro
Tela: passo 7 (resposta 5 do autor: revisão da etapa 4, curtida, comentário e seguir)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 3 fechada em `8097034`, CI verde.
- Etapa 4: curtida (PUT/DELETE idempotentes, oito simultâneas viram uma), comentários por cursor opaco (base64url de instante e id, comparação de linha no Postgres, 400 `cursor-invalido`; teste com 45 comentários no mesmo instante), remoção de comentário nos dois modos, seguir pela D9 com `ProfessorEnsinaAlunoAsync` no banco; migration `Social`; purga com `curtida`, `comentario`, `seguimento`; 14 de domínio e 16 de integração novos (698 na API); teste do app contando 6 arquivos de códigos.
- Dois pontos confirmados pelo autor: ordem dos comentários do mais antigo ao mais novo; conta de professor e instituição interage como professora.

---
Etapa 4 aprovada. Confirmo os dois pontos: comentários do mais antigo ao mais novo, e a conta de professor e instituição segue, curte e comenta como professora. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 5; para para a minha revisão no fim dela.
