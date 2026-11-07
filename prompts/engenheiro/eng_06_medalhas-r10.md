ID: eng_06_medalhas-r10
Trilha: engenheiro
Tela: passo 6 (resposta 10 do autor: revisão da etapa 9, tela de Troféus e navegação; liberação do fechamento)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor olhou as capturas; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 8 fechada em `e389889`, CI verde.
- Etapa 9: navegação de cinco abas (Busca, Mural e Perfil em "Em breve"), tela de Troféus pela prancheta (pontos, abas Troféus e Medalhas, "Mostrar não obtidos", trilhas das famílias com item obtido, lista por obtidos e faltantes com medalhão, tier, raridade, critério ou origem e pontos), professor vê aviso; `GET /v1/eu` ganha `nomeDeExibicao` (aditivo); 317 Jest no app (11 novos), 557 na API; três defeitos visuais achados nas capturas e corrigidos (rótulo dos passos da trilha, cor padrão do switch na web, polegar no escuro).
- Decisão: trilha de família que mistura medalha e conquistas aparece nas duas abas (aceita e registrada). Etapa 10 (e2e, docs e PR) liberada.

---
Etapa 9 aprovada. A trilha que mistura medalha e conquista aparece nas duas abas mesmo, registra como decisão. O campo nomeDeExibicao no /v1/eu no mesmo commit está certo. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 10: e2e do professor concedendo, aluno vendo em Troféus e comando anulando; docs do passo (README de decisões com as decisões A a L e as das etapas, fluxos, plano mestre, apps/mobile/README.md); e o PR da feat/passo-06-medalhas para a rodada/eng_06_medalhas com a descrição listando as dez etapas e o commit de docs inicial. Eu reviso e faço o merge.
