ID: eng_00_tecnica-r5
Trilha: engenheiro
Tela: abertura (resposta 5 do autor: revisão da E0.2b, `data/catalogo/conquistas.json` e `docs/regras-conquista.md`)
Data: 2026-11-01
Origem: leitura do Cowork (Anthropic) das 18 conquistas no repo, aprovada pelo autor e redigida pelo Cowork; o autor revisou.

Notas de registro:
- O agente commitou a E0.2a ajustada (`3f1d65e`: campos repetivel e limitePorPeriodo) e entregou a E0.2b com uma simplificação própria: as três formas de contagem previstas colapsaram em duas (contagem e contagemDistinta), sem uso do escape para C#. Calculou a economia de pontos a partir do catálogo (teto anual de 8.650, nota valendo 2,5 vezes presença) e pediu quatro decisões.
- Decisões do autor: instância de curso igual ao aluno (aceite); dois nomes de conquista trocados (C01, C05); variedade real confirmada; literal 4 em C14 aceito.

---
E0.2b aprovada. Duas formas de contagem, não três, com o motivo escrito no regras-conquista.md; o escape para C# fica documentado e sem uso. Economia de pontos aprovada como está; revejo depois do primeiro seed, olhando o ranking. As quatro decisões: período de curso tem instância igual ao aluno e nunca reinicia na troca de curso; nomes aprovados, trocando C05 "Presente na faculdade" por "Presença nos eventos" e C01 "Primeiros passos" por "Cinco no bimestre"; C06 premia variedade real, duas palestras contam como um tipo, confirmado; C14 com o literal 4, anotado como a única regra dependente do calendário. Commita e segue para a E0.2c.
