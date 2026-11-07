ID: eng_05_login-r7
Trilha: engenheiro
Tela: passo 5 (resposta 7 do autor: revisão da etapa 6, recuperação de senha)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor olhou as capturas; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 5 fechada em `58b2fb2`, CI verde.
- Etapa 6: `/esqueci-senha` com resposta idêntica exista ou não a conta; `/redefinir-senha` fora dos grupos, token lido do fragmento e apagado com replaceState, link usado ou vencido com "Pedir link novo", nativo sem fragmento com mensagem própria, sessão local encerrada após a senha nova; apoio `mailpit.ts` no e2e; 282 Jest (13 novos), 55 e2e, spec da recuperação em 3 repetições seguidas. Bug achado pelo e2e: token nulo porque o fragmento sumia antes da montagem; corrigido capturando uma vez no carregamento do bundle. Frase de abertura do pedido corrigida depois das capturas.

---
Etapa 6 aprovada, com a frase nova do pedido. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 7; para para a minha revisão no fim dela, com captura da entrada da demonstração.
