ID: eng_04_design-r2
Trilha: engenheiro
Tela: passo 4 (resposta 2 do autor: revisão da etapa 1, tokens tipados e troca de tema persistida)
Data: 2026-11-05
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1: `src/theme/tokens.ts` (cores e tiers do JSON, tamanhos, raios e tipografia como constantes conferidas por teste contra o JSON), `ThemeProvider` com Sistema, Claro e Escuro persistido em AsyncStorage e tolerante a falha de leitura e gravação, controle provisório na tela de status, `useThemeColors` removido, regra de ESLint que faz cor literal virar erro (provada com arquivo de teste), `raios.regra` corrigida no `tokens.json`, e2e novo de troca de tema; 34 Jest, 8 e2e no build real pelo Caddy. Dependência nova: `@react-native-async-storage/async-storage` 2.2.0.
- O agente declarou o que não verificou (nada rodou em nativo; barra de status sem teste próprio), um token sem origem no JSON (`raios.segmentoAtivo` da identidade visual) e a tela em branco até ler a preferência. Capturas em claro e escuro deixadas no scratchpad do CLI.
- Primeira etapa sob a regra nova: a CI roda depois do ok e o resultado por job vem com a etapa seguinte.

---
Etapa 1 aprovada. O raio do segmento ativo vindo da identidade visual fica, registra isso no fechamento. Commita com a mensagem proposta, push, acompanha a CI e me traz o resultado por job junto com a etapa 2; para para a minha revisão no fim dela.
