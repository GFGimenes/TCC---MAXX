ID: eng_14_demo_papeis-r3
Trilha: engenheiro (passo posterior à avaliação, fora do experimento medido)
Tela: passo 14 (resposta 3 do autor: revisão da etapa 6, tela da purga)
Data: 2026-11-11
Origem: leitura do Cowork (Anthropic) do export; o autor conferiu as 8 capturas (lista, modal, resultado e login; claro e escuro, 1280 x 900), copiadas para `resultados/engenheiro/capturas/eng_14_demo_papeis/etapa6/`; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 5 em `8d25268`, CI verde.
- Etapa 6 sem commit: contagem por papel, marca "Seu lote", aviso no modal, resultado com "Voltar ao login" (tira a conta da lembrança do aparelho, encerra a sessão local e abre o login); a lembrança passa a guardar o id da conta, lido de `/v1/eu` depois de entrar; Jest 533, typecheck e lint limpos; e2e da purga sem mudança. Para as capturas, o script criou no compose local, lote `captura-local`, um aluno, um professor e a coordenação "Conferência Maxx" e purgou o lote, uma vez por tema.
- Três textos fora dos docs, declarados: introdução da tela, frase do modal e frase do resultado.
- Achados do autor nas capturas: no modal, com um aluno só, o verbo ficou no plural ("Saem do banco o aluno do lote ... e tudo o que fizeram"); e a folha de confirmação ocupa a largura inteira da janela no navegador, enquanto a tela é uma coluna estreita.

---
Etapa 6 aprovada, capturas conferidas, com um ajuste de texto antes do commit: no modal, com um aluno só, a frase tem que concordar no singular, "Sai do banco o aluno do lote X e tudo o que fez"; com mais de um, fica como está. Cobre com o Jest que já testa a concordância. Os três textos que você escreveu ficam. Uma observação que não é para corrigir agora: no navegador a folha de confirmação ocupa a largura inteira da janela, enquanto a tela é uma coluna estreita. Se isso já era assim desde o passo 12, registra como limite conhecido de tela no índice de decisões; se foi introduzido agora, me avisa antes de seguir. Depois commita, push, CI, e segue para a etapa 7, o e2e nos três papéis, e para a 8; para na 8 com o PR aberto, a CI verde e a conferência no ar feita.
