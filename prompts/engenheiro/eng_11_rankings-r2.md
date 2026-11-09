ID: eng_11_rankings-r2
Trilha: engenheiro
Tela: passo 11 (resposta 2 do autor: revisão da etapa 1, domínio do ranking)
Data: 2026-11-09
Origem: leitura do Cowork (Anthropic) do export da sessão; sem capturas nesta etapa; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1 entregue sem commit: `Maxx.Domain.Ranking` com `ParcelaDoRanking` (o que pontua, em que semestre, com que instante; nulo para medalha anulada, prêmio reivindicado, reprovado, em averiguação ou revogado, conquista removida), `Classificacao` (soma, ordem por pontos, instante mais antigo e id; aluno sem pontos sem linha; ex-aluno só no histórico; curso atual) e `SemestresDoRanking` (atual, congelado reaproveitando `InstanciaDePeriodo.Congelamento`, abertos); 40 testes novos com fronteiras (03/01 aceita, 04/01 congelado; recesso com e sem semestre seguinte; 31/01 e 01/02); domínio 581 testes, format e build limpos.
- Um ponto para conferir: prêmio de evento no recesso sem semestre seguinte no calendário pontua no histórico, mas em nenhum semestre até o calendário ganhar esse semestre (na conquista, no mesmo caso, o prêmio ainda não vira fato): aceito, coerente com a regra do passo 9.
- Pergunta: registrar as respostas 1 a 3 no produto.md agora ou na etapa 6: autor manteve a etapa 6, como no plano aprovado.

---
Etapa 1 aprovada. O caso do prêmio de evento no recesso sem semestre seguinte fica como você fez: pontua no histórico e espera o calendário para entrar num semestre, coerente com o passo 9. O registro das respostas 1 a 3 no produto.md fica na etapa 6, como no plano. Commita com a mensagem proposta, push, acompanha a CI e, com ela verde, segue para a etapa 2; para para a minha revisão no fim dela, com a mensagem de commit antes de commitar.
