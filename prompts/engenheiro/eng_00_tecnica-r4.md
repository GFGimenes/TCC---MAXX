ID: eng_00_tecnica-r4
Trilha: engenheiro
Tela: abertura (resposta 4 do autor: revisão da E0.2a, `data/catalogo/medalhas.json` e `premios-participacao.json`, com a regra de repetibilidade das medalhas)
Data: 2026-11-01
Origem: decisões do autor (estrutura real de avaliação da UniMax por bimestre), redigidas pelo Cowork (Anthropic); o autor revisou.

Notas de registro:
- O agente entregou os dois JSON (11 medalhas, 17 prêmios), validados por script, e precisou decidir três coisas não definidas: repetibilidade da medalha no período (propôs limites por item, teto de 210 pontos por matéria e bimestre), `tipoDeEvento` no item do catálogo e `formaDoEvento` pontual ou período.
- Decisão própria do autor: a repetibilidade vira dois campos do catálogo (repetivel, limitePorPeriodo), com limites derivados da estrutura real de avaliação (por bimestre: prova, prova integrativa, presença ou trabalhos); prova substitutiva ou de recuperação não gera medalha de nota (sugestão do Cowork aceita). Demais: aceites.
- A E0.1 foi commitada pelo agente em `14999e3` na `rodada/eng_00`.

---
E0.2a aprovada com uma mudança na repetibilidade. Cada medalha ganha dois campos: repetivel (sim ou não) e limitePorPeriodo, que é a quantidade de vezes que ela pode ser dada ao mesmo aluno na mesma matéria (pelo professor daquela turma) dentro do período de referência. Os limites saem da estrutura real de avaliação: em cada bimestre uma matéria tem prova, prova integrativa e presença ou trabalhos, a critério do professor; no semestre, duas provas e duas integrativas por matéria, mais alguns trabalhos. Então: M01 nota 10 em prova, até 2 por bimestre (prova e integrativa); M02 melhor nota da turma, até 2 por bimestre; M03 presença integral, M04 pontualidade e M05 evolução, 1 por bimestre; M06 trabalho, até 3 por bimestre; M07 atividade complementar, até 2; M08 plantão ou reposição, até 2; M09 lista de sala, até 4; M10 e M11, 1 por semestre. Prova substitutiva ou de recuperação não gera medalha de nota: é segunda chance, não mérito novo. A ocorrencia entra na chave de deduplicação dos repetíveis. Com isso, "três notas 10 em prova no bimestre" pode vir de duas matérias. tipoDeEvento no item do catálogo, formaDoEvento pontual ou período, P17 com código no fim e M05 no bimestre mais recente: aceitos. Recalcule o teto por matéria e bimestre e me mostre; commita e segue para a E0.2b.
