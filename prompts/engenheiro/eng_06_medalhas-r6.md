ID: eng_06_medalhas-r6
Trilha: engenheiro
Tela: passo 6 (resposta 6 do autor: revisão da etapa 5, anulação de medalha por comando administrativo)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 4 fechada em `e9abe4f`, CI verde, com a regra F e a nuance da entrada pela lista no `produto.md` 4.8.
- Etapa 5: comando `Maxx.Api anular-medalha <id> --instituicao <e-mail>` com códigos de saída 0, 1 e 2; `AnularMedalhaHandler` grava quem e quando e enfileira o recálculo de raridade na mesma transação; concorrência de anulação pelo xmin (migration `MedalhaVersao`); anulada libera a vaga; purga do README ganha `medalha`; 7 testes novos (530 no total), purga testada com dois lotes; comando conferido no contêiner real.

---
Etapa 5 aprovada. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 6; para para a minha revisão no fim dela.
