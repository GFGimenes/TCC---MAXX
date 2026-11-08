ID: eng_07_posts-r4
Trilha: engenheiro
Tela: passo 7 (resposta 4 do autor: revisão da etapa 3, post no domínio e na API)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 2 fechada em `9929c99`, CI verde, com `upload_pendente` na purga e a nota de que as fotos do bucket saem no passo 12.
- Etapa 3: `POST`, `GET` e `DELETE /v1/posts`; domínio `Post` (ao menos um entre prêmio, foto e legenda; legenda até 1.000; só aluno ativo; upload do autor e não usado; medalha do autor e ativa); índice único filtrado por prêmio e xmin do upload resolvendo corridas em 409; HEAD das derivadas antes de gravar; remoção física pelo autor e lógica pela instituição com `removido_em` e `removido_por_id`; trabalho `remover-fotos`; D6 no `AnularMedalhaHandler` e no `produto.md` (post perde o vínculo; só medalha é apagado; regra estendida ao prêmio revogado); migration `Post` com índice `(autor_id, criado_em desc, id)`; purga com `post`; onze códigos novos com mensagem; `MundoSocial` como montador de testes; 17 de domínio e 17 de integração novos (668 na API).
- Escolha de implementação da remoção em dois modos aprovada.

---
Etapa 3 aprovada. A remoção em dois modos fica: física pelo autor, lógica pela instituição com registro. A D6 como está. O MundoSocial fica, sem refatorar o UploadTests. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 4; para para a minha revisão no fim dela.
