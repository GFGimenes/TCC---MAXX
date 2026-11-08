ID: eng_09_conquistas-r2
Trilha: engenheiro
Tela: passo 9 (resposta 2 do autor: revisão da etapa 1, avaliador no domínio)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1 entregue sem commit: `AvaliadorDeConquista` (duas formas de contagem, alvo dinâmico por matérias distintas, alvo zero nunca satisfeito, restrição de curso e vigência, escape `customizada` por nome), `FatoContavel` (medalha ativa e prêmio definitivo), `InstanciaDePeriodo`, `Conquista` e `EvidenciaDaConquista` com congelamento, `Calendario.SemestreDoEvento` e `AnoDoSemestre`; 490 testes de domínio; 37 testes por item (C01 a C18, fecha e um abaixo) em `IntegrationTests/Conquistas/` sem banco; suíte 985 (979 passaram, 6 ignorados de antes, que o agente não confirmou quais são).
- Três decisões do agente para aval: (1) validador recusa conquista de bimestre contando prêmio de participação, porque ele conta por semestre; nenhuma das 18 afetada; (2) teste por item no projeto de integração porque o leitor do JSON está na Infrastructure; (3) evento iniciado no recesso sem semestre seguinte cadastrado não vira fato até o calendário ganhar o semestre. Aceitas as três.
- O autor pede que os 6 testes não executados sejam identificados no relatório da etapa 2 (provavelmente `VerificacaoDoR2Tests`).

---
Etapa 1 aprovada, com as três decisões aceitas: a regra do validador para conquista de bimestre, o teste por item no projeto de integração pela dependência do leitor, e o evento no recesso sem semestre seguinte esperando o calendário. Uma coisa para o relatório da etapa 2: confirma quais são os 6 testes que não rodaram; se forem os da verificação do R2, só registra. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 2; para para a minha revisão no fim dela.
