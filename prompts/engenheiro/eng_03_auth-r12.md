ID: eng_03_auth-r12
Trilha: engenheiro
Tela: passo 3 (resposta 12 do autor: revisão da E11, limite de taxa, e fechamento do PR)
Data: 2026-11-04
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor (limite de 60 por minuto por IP proposto pelo Cowork, aprovado); redigida pelo Cowork, o autor revisou.

Notas de registro:
- E10 commitada em `15ff8f3`.
- E11: limitadores nativos de `System.Threading.RateLimiting` aplicados por filtro de endpoint (chaves no corpo), janela fixa sem fila, chave normalizada, 429 em ProblemDetails com `Retry-After`, IP real só da rede do Caddy; 449 testes, 7 novos; fumaça pelo Caddy mostrando o limite por réplica (duas réplicas, limite efetivo até o dobro, como decidido).
- Sete decisões; seis aceitas. Na quarta o agente apontou que sugestão e disponibilidade do cadastro ficaram sem limite e são caminho de enumeração; o autor fixou 60 por minuto por IP nas duas, com debounce no cliente no passo 5.
- Fechamento do passo pedido: decisões das E6 a E11 no README das decisões, códigos HTTP nos fluxos 01 e 06, purga por lote como procedimento, serialização do refresh como item obrigatório do passo 5; commit `docs(docs)` separado; PR da `feat/passo-03-auth` para a `rodada/eng_03_auth` com as onze etapas.

---
E11 aprovada. Decisões 1, 2, 3, 5, 6 e 7 aceitas. Na 4: põe limite por IP de 60 por minuto em sugestão e disponibilidade, com teste do 61º dando 429 e a nota de que o cliente do passo 5 faz debounce na digitação. Entra na tabela de limites. Commita com a mensagem proposta, push, e faz o fechamento do PR como você descreveu: decisões das E6 a E11 no README das decisões, códigos HTTP nos fluxos 01 e 06, purga por lote como procedimento, serialização do refresh no cliente como item obrigatório do passo 5 no plano-mestre. Commit docs(docs) separado, push, confere a CI e abre o PR da feat/passo-03-auth para a rodada/eng_03_auth com a descrição listando as onze etapas. Eu reviso e faço o merge.
