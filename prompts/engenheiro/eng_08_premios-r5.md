ID: eng_08_premios-r5
Trilha: engenheiro
Tela: passo 8 (resposta 5 do autor: revisão da etapa 3, fila de comprovações)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 2 fechada em dois commits: `b093836` saiu sem a frase do `produto.md` porque o agente commitou antes de ver que a edição tinha falhado (erro declarado por ele); a frase entrou em `9ec311a` (docs), sem amend, CI verde nos seis jobs; a CI do `b093836` foi cancelada pelo concurrency.
- Etapa 3 entregue sem commit: aprovar, reprovar com motivo (1 a 500), `TornarDefinitivoSeAJanelaFechou`, marca dos 7 dias, notificações novas, migration `DecisaoDaComprovacao`, policy `aprovador`, `GET /v1/comprovacoes` por cursor com escopo no banco, `GET /v1/comprovacoes/eventos` para o chip, aprovação enfileirando notificação, raridade e o trabalho dos 15 dias, reprovação desvinculando o post; pontos do perfil e de Troféus somando prêmios válidos e definitivos; 12 testes de domínio e 13 casos de integração (corrida de seis decisões); suíte 867; auxiliar `MundoDePremios`.
- Dois adiantamentos da etapa 4 declarados: handler `tornar-premio-definitivo` (porque trabalho sem handler conta como falha) e raridade contando prêmios de participação. Aceitos.
- Sem decisão nova de produto. Regra da remoção pela instituição anotada para a etapa 4, como pedido na r4.

---
Etapa 3 aprovada. Os dois adiantamentos ficam, com a justificativa que você deu; o commit docs separado para a frase da trava está certo, e a regra de só commitar depois de ver o resultado das edições vale daqui em diante. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 4, já com a remoção pela instituição resolvendo o prêmio no mesmo ato e a regra no produto.md; para para a minha revisão no fim dela.
