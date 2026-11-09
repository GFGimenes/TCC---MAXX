ID: eng_11_rankings-r4
Trilha: engenheiro
Tela: passo 11 (resposta 4 do autor: revisão das etapas 2, 3 e 4 emendadas)
Data: 2026-11-09
Origem: leitura do Cowork (Anthropic) do export da sessão; sem capturas nestas etapas; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Primeira aplicação da cadência por grupo (declarada na `r3`): etapas 2, 3 e 4 com commit próprio e CI verde nos seis jobs cada (`8851bd8`, `a53b88d`, `1681071`), sem fix e sem pergunta de produto; o agente parou antes da etapa 5 como instruído.
- Etapa 3: ponto único `fila.PedirRecalculos()` enfileirando ranking e raridade na transação da escrita, substituindo o pedido de raridade em 11 lugares (medalha concedida e anulada, aprovação, contestação, confirmação e revogação, remoção do post pela instituição, conquista concedida e removida); cadastro, demonstração e seed seguem só com raridade; 16 testes novos, dois de ponta a ponta pelo worker; integração 578.
- Etapa 4: `GET /v1/rankings` com escopo, período, seguidos e cursor de 20; `eu` nulo para não aluno e aluno sem pontos; 403 para curso de professor e instituição e para curso no semestre de ex-aluno; 400 `visao-incompleta`; `posicao` no perfil (histórico geral); OpenAPI e `schema.d.ts` só com acréscimos; 16 testes, com EXPLAIN confirmando o índice; integração 592.
- Quatro decisões de detalhe declaradas e aceitas: "Quem eu sigo" inclui a linha do próprio aluno; sem ETag no ranking (p95 no k6 do passo 13); parâmetros de query em texto como no mural; ausência de parâmetro checada no endpoint.

---
Etapas 2, 3 e 4 aprovadas, com as quatro decisões de detalhe aceitas: o próprio aluno dentro de "Quem eu sigo", sem ETag até o k6 do passo 13, parâmetros em texto como no mural e a ausência checada no endpoint. Segue para a etapa 5, o cliente, com as capturas em claro e escuro nas telas de Rankings, no card sem posição, no perfil com a posição e nos atalhos da Busca; para para a minha revisão no fim dela, com a mensagem de commit antes de commitar.
