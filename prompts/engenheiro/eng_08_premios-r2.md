ID: eng_08_premios-r2
Trilha: engenheiro
Tela: passo 8 (resposta 2 do autor: revisão da etapa 1, eventos)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1 entregue sem commit: domínio `Evento` (semeado e texto livre, 27 testes), migration, `data/demo/eventos.json` com 8 eventos de 2026/2, seed falhando sem gravar em cinco casos ruins, `GET /v1/eventos?item=` (12 testes de integração com relógio fixado em 2026), passo de CI conferindo o arquivo sem banco, D3 no `produto.md`. Suíte local 801 testes (795 aprovados, 6 ignorados de antes).
- O agente apontou a consequência da D3 no recesso (sem semestre vigente, ninguém reivindica). O autor reconheceu o furo da própria regra (evento iniciado no recesso ficaria bloqueado para sempre) e ajustou: limite inferior passa a ser o fim do semestre letivo anterior ao vigente.
- Ocorrência: narração do agente em inglês no meio do turno sem compactação, terceira sessão seguida; registrado como padrão da versão.

---
Etapa 1 aprovada, com um ajuste antes do commit. Sobre o recesso: a D3 fica com o limite inferior no fim do semestre letivo anterior ao vigente, não no início do vigente; assim um evento que começa no recesso continua reivindicável e conta para o semestre seguinte, e no recesso a reivindicação não para. Ajusta a regra, o teste de fronteira e o produto.md. O relógio do teste da rota está certo como você fez. E volta a escrever em português; parte das suas mensagens saiu em inglês. Com a suíte verde, commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 2; para para a minha revisão no fim dela.
