ID: eng_08_premios-r4
Trilha: engenheiro
Tela: passo 8 (resposta 4 do autor: revisão da etapa 2, reivindicação como post com foto)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1: D3 ajustada (limite inferior no fim do último semestre letivo encerrado), commit `78e2112`; a CI falhou no job mobile (teste `erros.test.ts` contava 7 arquivos `Codigos*.cs` e achou 8); fix separado `ba4c40a`, CI verde nos seis jobs. Causa declarada pelo agente: não rodou o Jest do app antes do push; passou a rodar o job do app localmente antes de propor commit.
- Etapa 2 entregue sem commit: `PremioParticipacao` e `Comprovacao` no domínio, `Post.Reivindicar` exigindo foto, migration com índice único da chave ativa e `ck_post_um_premio`, `POST /v1/reivindicacoes` numa transação, leitura do post com estado e evento, purga adiantada com teste, 15 códigos com mensagem no app (quatro mensagens de "medalha" viraram "prêmio"), 20 testes de domínio e 20 de integração (corrida de seis pedidos em 409), suíte 842.
- Decisões do autor: trava do post de comprovação registrada no `produto.md` 4.7; matéria do P17 pela matrícula no semestre letivo da data do evento (sem matéria no recesso); trava na remoção pela instituição aceita só até a etapa 4, quando a remoção pela instituição passa a reprovar ou revogar no mesmo ato com motivo "removido pela instituição", porque a instituição não pode depender da fila para tirar do ar uma foto imprópria.
- O agente voltou a escrever em português depois do pedido na r2, com uma frase em inglês isolada ("The CI of the fix and the local suite are both still running").

---
Etapa 2 aprovada. Registra a trava no produto.md 4.7 neste commit. A matéria do P17 pela matrícula no semestre letivo da data do evento fica, com a consequência no recesso. A trava na remoção pela instituição fica por enquanto, mas não é a regra final: na etapa 4, quando existirem reprovação e revogação, a remoção pela instituição passa a resolver o prêmio no mesmo ato, reprovando se pendente e revogando se válido ou em averiguação, com o motivo "removido pela instituição", e só então remove o post; a instituição não pode depender da fila para tirar do ar uma foto imprópria. Anota isso no plano da etapa 4 e no produto.md quando chegar lá. O fix separado da CI da etapa 1 está certo, e a lição de rodar o job do app antes do push vale para o resto do passo. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 3; para para a minha revisão no fim dela.
