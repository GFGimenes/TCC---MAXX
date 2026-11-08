ID: eng_08_premios-r6
Trilha: engenheiro
Tela: passo 8 (resposta 6 do autor: revisão da etapa 4, contestação e decisão da instituição)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 3 fechada em `1777b8a`, CI verde nos seis jobs.
- Etapa 4 entregue sem commit: `Contestacao` (uma por prêmio, xmin), `Contestar`, `Confirmar`, `Revogar` no domínio; remoção pela instituição resolvendo o prêmio no mesmo ato (reprova, revoga ou decide a contestação revogando, motivo "Removido pela instituição.") como pedido na r4, regra no `produto.md` 4.7; migration `Contestacao`; rotas de contestação, fila da instituição com marca de 7 dias, confirmação e revogação com 409 na corrida, `GET /v1/eu/reivindicacoes` (D9); visibilidade do prêmio em averiguação só para aluno e instituição; purga com contestação; 12 testes de domínio e 12 casos de integração (14 execuções); suíte 891.
- Três pontos para o autor: (1) para quem não é o aluno nem a instituição, o post em averiguação aparece sem o prêmio, leitura do "sem pontos nem tier" do produto.md; aceito. (2) notificação `PremioRevogado` para a revogação pela remoção, fora da lista da seção 8: aceito, registrar na seção 8. (3) corrida rara de remoção com 404: aceito.
- Próxima etapa (5) é de cliente: o autor vai precisar olhar capturas (novo post em modo reivindicação, marcas no cartão, seção Reivindicações em Troféus).

---
Etapa 4 aprovada. Os três pontos pela sua leitura: o post em averiguação aparece sem o prêmio para os outros leitores, como você registrou; a notificação PremioRevogado entra na seção 8 do produto.md antes do commit; a corrida rara com 404 fica. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 5; no fim dela, para para a minha revisão com capturas do novo post em modo reivindicação, das marcas no cartão e da seção Reivindicações em Troféus, no claro e no escuro.
