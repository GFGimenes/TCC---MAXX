ID: eng_01_fundacao-r7
Trilha: engenheiro
Tela: passo 1 (resposta 7 do autor: revisão da etapa 6, e2e com Playwright contra o build web)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Entrega: workspace `e2e/` com Playwright 1.64.1 só em Chromium, alvo padrão `http://localhost` (trocável por `MAXX_E2E_BASE_URL`), quatro projetos (desktop e celular, claro e escuro) com tags por teste; na CI, uma nova tentativa e relatório HTML com trace; `testID="app-fundo"` no `PhoneFrame` substituindo um XPath frágil.
- O teste do desktop confere moldura de 390 × 844 centralizada nos dois eixos, conteúdo dentro dela, cores batendo com `design/tokens.json` por tema e ausência de sombra; o do celular confere ausência de moldura, largura da janela, sem rolagem horizontal. O "200" vem de chamada real pelo Caddy até a réplica da API.
- O agente provou que o e2e discrimina: com as duas réplicas paradas os quatro testes falham; de volta, passam. Tirou capturas dos quatro casos e conferiu.
- Nenhuma decisão pedida ao autor; aprovação sem ressalva.

---
Etapa 6 aprovada. Commita com a mensagem proposta, push, e segue para a etapa 7; para para a minha revisão no fim dela.
