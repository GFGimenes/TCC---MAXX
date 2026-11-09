ID: eng_10_mural-r4
Trilha: engenheiro
Tela: passo 10 (resposta 4 do autor: revisão da etapa 3, notificações e novidades)
Data: 2026-11-09
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 2 em `b0d7e6d` (com o 404 do perfil inexistente), CI verde nos seis jobs.
- Etapa 3 entregue sem commit: `GET /v1/eu/notificacoes` com resumo por tipo (nove tipos), `POST /v1/eu/notificacoes/leitura` com `ate` opcional, `GET /v1/eu/novidades` (sininho, mural, troféus), `PUT /v1/eu/trofeus/visto` com marcador que só anda para a frente; migration `TrofeusVistos`; 5 testes de integração cobrindo os nove tipos pelos fluxos reais, prova reversa do `ate`; suíte 1101. Ajuste de relógio no helper de teste, não no código.
- Quatro pontos aceitos: `ate` como acréscimo contra a corrida entre abrir a lista e marcar; aluno novo vê a bolinha do Mural pelos avisos antigos (regra ao pé da letra, "Ler todos" resolve); prêmio de participação acende Troféus só na aprovação; terceira migration do passo.

---
Etapa 3 aprovada, com os quatro pontos aceitos: o ate na leitura do sininho é acréscimo correto; a bolinha do Mural acesa para aluno novo fica, "Ler todos" é a saída e o aluno vê os avisos antigos da faculdade; prêmio de participação acende Troféus só na aprovação; a terceira migration está dentro da regra. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 4; no fim dela, para para a minha revisão com capturas da aba Mural (não lido aberto e lido recolhido), do aviso aberto com imagem e do estado vazio, no claro e no escuro, conferidas contra a prancheta do mural.
