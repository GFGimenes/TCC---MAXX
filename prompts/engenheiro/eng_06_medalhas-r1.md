ID: eng_06_medalhas-r1
Trilha: engenheiro
Tela: passo 6 (resposta 1 do autor: ajuste de docs do passo 5, aprovação do plano de dez etapas e doze decisões)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisões do autor pela recomendação do agente; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Ambiente: Claude Code 2.1.316, `/model` manteve Opus 5.5 (medium).
- Ajuste de docs: linha "Banca" virou "Avaliação" e a justificativa do limite de 60 por hora por IP passou a citar CGNAT da rede móvel e o ensaio remoto; o agente apontou outros trechos com "banca" (ADRs 0001, 0005, 0008; `produto.md` 1, 6.2, 11, 12) e o autor mandou incluir no mesmo commit.
- Plano de dez etapas: fila e worker; e-mail na fila; domínio da medalha (TDD); concessão na API; anulação por comando; trabalhos do worker (notificação e raridade com coalescência); leitura do aluno; cliente do professor; tela de Troféus; e2e e docs. Doze decisões (A a L) com recomendação, todas aceitas: worker em contêiner próprio com uma réplica; trabalho de e-mail só com o id do pedido e token gerado no worker; 5 tentativas com recuo exponencial; ocorrência atribuída pelo sistema e vaga liberada na anulação; concessão fora de bimestre recusada; aluno sem conta não recebe medalha (registrada como regra nova no produto); "Minhas turmas" no início provisório; navegação de cinco abas entra agora com abas "Em breve"; bolinha de novidade no passo 10; divisor da raridade com ativos, ex-alunos e demonstração; auditoria em colunas da própria medalha; comando `anular-medalha`.

---
Ajuste de docs aprovado; inclui no mesmo commit os outros trechos que supõem apresentação presencial (ADR 0001, 0005, 0008 e produto.md 1, 6.2, 11 e 12), trocando banca por avaliação remota e avaliadores onde couber, sem mudar regra. Plano do passo 6 aprovado, dez etapas, um PR da feat/passo-06-medalhas para a rodada/eng_06_medalhas. Decisões A a L todas pela sua recomendação; registra a F no produto.md como regra, porque é nova: aluno sem conta não recebe medalha e não aparece na lista do professor. Commita e dá push dos docs, me traz a CI e começa a etapa 1; para para a minha revisão no fim dela.
