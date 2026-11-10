ID: eng_13_endurecimento-r7
Trilha: engenheiro
Tela: passo 13 (resposta 7 do autor: revisão da correção do achado do passo 6 do ensaio)
Data: 2026-11-10
Origem: leitura do Cowork (Anthropic) do export; o autor conferiu as quatro capturas (`passo6-celular-{claro,escuro}-{1-escolhido,2-lista-de-volta}.png`); decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Depois do Purge Everything do autor, a URL exata das fotos purgadas passou a 404 (`cf-cache-status: DYNAMIC`). Lote `banca-2026` no ar com a demonstração ligada, dump antes do deploy, duas réplicas, `GET /api/v1/demo` com os quatro cursos, worker em 200. Ocorrência: o `pkill` que encerrou a gravação do ensaio derrubou a própria sessão de comando antes do deploy; o agente refez o deploy, sem efeito no produto.
- Limpeza do cache da CDN entrou como passo em `docs/ensaio.md` e `docs/operacao.md` (seção "Purga de um lote de demonstração"); limite conhecido vai para o índice na etapa 10.
- Achado do passo 6: causa era o link "Trocar prêmio" discreto e o toque no prêmio marcado sem efeito. Correção em `EscolhaDaReivindicacao.tsx`: tocar de novo devolve a lista, mantendo nome e datas digitados; vale também para a concessão direta da instituição. Jest novo falha antes e passa depois; 47 de 47 nos testes de prêmios e instituição; lint, tipos e formatação limpos. Capturas a 390 px, claro e escuro.

---
Capturas conferidas, fiéis. Correção do passo 6 aprovada: commita como fix(mobile) com a mensagem proposta, push, CI e publicação na VPS. Depois segue para a etapa 10, o registro do passo, com os documentos do ensaio e da operação no mesmo commit; para no fim dela para a minha revisão antes do PR.
