ID: eng_06_medalhas-r3
Trilha: engenheiro
Tela: passo 6 (resposta 3 do autor: revisão da etapa 2, e-mail migrado para a fila)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1 fechada em `4ff1d2d`, CI verde.
- Etapa 2: o pedido de recuperação grava sem token e enfileira só o id; o worker emite o token, grava o hash e envia na transação do trabalho; pedido encerrado não gera e-mail; falha de SMTP desfaz o hash e retenta com outro token; migration `TokenEmitidoNoWorker`; fila em memória removida; variáveis de SMTP saem da API e vão para o worker; 494 testes (4 de domínio e 3 de integração novos), classe de recuperação em três rodadas; fumaça pelo Mailpit no compose.
- Mudança de regra declarada e confirmada pelo autor: validade de 30 minutos contada do envio, não do pedido. Risco aceito e registrado: e-mail enviado com transação não fechada deixa o link inválido; o usuário pede outro.

---
Etapa 2 aprovada. Confirmo a mudança de regra: os 30 minutos contam do envio. O risco do e-mail que sai sem a transação fechar fica registrado como está. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 3; para para a minha revisão no fim dela.
