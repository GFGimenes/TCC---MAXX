ID: eng_08_premios-r9
Trilha: engenheiro
Tela: passo 8 (resposta 9 do autor: revisão da etapa 7, e2e e docs, e fechamento do passo)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 6 fechada em `247e611`, CI verde nos seis jobs.
- Etapa 7 entregue sem commit: e2e `premios.spec.ts` (aprovação; reprovação e revogação) no celular nos dois temas, auxiliares em `apoio/premios.ts` com conta de instituição por teste; instabilidade observada uma vez no tema escuro sob carga paralela, não reproduzida em três rodadas depois de reduzir a dependência de API; uma falha isolada do teste de limite de taxa do login (anterior, não tocado), registrada no risco do plano mestre. Docs: seção do passo 8 no README de decisões (D1 a D13 e decisões das etapas), três linhas antigas dos passos 6 e 7 corrigidas, `produto.md` 4.6, fluxos 02 e 04 com "Como ficou no passo 8", plano mestre com pendências e ganchos (9, 10, 11, 12, 13). Suíte 892, Jest 414, e2e 69.
- Decisão do autor: aprovar; commit, CI e PR; instabilidade fica registrada no risco, sem paliativo.

---
Etapa 7 aprovada e passo 8 fechado do meu lado. A instabilidade do e2e fica registrada no risco, sem paliativo, e o teste do limite de taxa do login não se mexe aqui. Commita com a mensagem proposta, push, acompanha a CI e, verde, abre o PR da feat/passo-08-premios para a rodada/eng_08_premios e me manda o link. A pilha pode ficar de pé.
