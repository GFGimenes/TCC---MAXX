ID: eng_06_medalhas-r8
Trilha: engenheiro
Tela: passo 6 (resposta 8 do autor: revisão da etapa 7, leitura dos prêmios do aluno)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 6 fechada em `1b44566`, CI verde.
- Etapa 7: `GET /api/v1/eu/premios` só para aluno (pontos, 8 famílias, 46 itens com critério, tier, pontos, família, ordem, raridade com percentual e obtidos; anulada fora); seed base enfileira o primeiro recálculo de raridade sem perder a idempotência; 555 testes, 5 de integração novos com o catálogo real.
- Duas decisões do agente aceitas: item restrito a outro curso fora da lista, salvo o já obtido; primeiro recálculo pelo seed. Ponto em aberto levantado pelo agente e decidido pelo autor: cadastro de aluno e registro de demonstração passam a enfileirar o recálculo de raridade (mudam o divisor), com o evento acrescentado ao ADR 0005.

---
Etapa 7 aprovada. As duas decisões ficam: item restrito a outro curso fora da lista salvo o já obtido, e o seed base pedindo o primeiro recálculo. Sobre o ponto em aberto: sim, cadastro de aluno e registro de demonstração passam a enfileirar o recálculo de raridade, e o ADR 0005 ganha esse evento na lista, no mesmo commit. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 8; para para a minha revisão no fim dela, com capturas da lista e do modal.
