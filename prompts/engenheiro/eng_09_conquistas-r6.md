ID: eng_09_conquistas-r6
Trilha: engenheiro
Tela: passo 9 (resposta 6 do autor: revisão da etapa 5, leitura de Troféus e perfil)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 4 em `bc72a23`, já com o tipo de período como texto na carga (JsonIgnore na propriedade calculada), CI verde na primeira tentativa.
- Etapa 5 entregue sem commit: `GET /v1/eu/premios` com `obtidos[].instancia` e `itens[].progresso` (opcionais, só acréscimo), conquista obtida em Troféus, perfil público com instância e sem progresso, OpenAPI e cliente regenerados; 4 testes de integração via HTTP (progresso em várias conquistas, recesso, bimestre sem matrícula), senha Argon2id real para os alunos do mundo de teste; suíte 1028.
- Cinco decisões para aval, aceitas: instância em números e rótulo no cliente; sem progresso de bimestre e semestre no recesso, ano e curso continuam; sem progresso com alvo zero, fora da vigência ou regra customizada; contagem simples de matrículas na leitura quando não há linha; `postId` nulo até a etapa do post. Commit único com o cliente regenerado aceito.

---
Etapa 5 aprovada, com as cinco decisões aceitas: instância em números com o rótulo no cliente, sem progresso de bimestre e semestre no recesso e com ano e curso seguindo, sem progresso com alvo zero, fora da vigência ou regra customizada, a contagem simples na leitura, e o postId nulo até a etapa do post. O commit único com o cliente regenerado está certo. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 6; no fim dela, para para a minha revisão com capturas da aba Troféus com a conquista obtida, o rótulo da instância e a linha de progresso, no claro e no escuro.
