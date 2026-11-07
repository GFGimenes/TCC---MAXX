ID: eng_05_login-r4
Trilha: engenheiro
Tela: passo 5 (resposta 4 do autor: revisão da etapa 3, peças da autenticação)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 2: CI do commit `2617e36` falhou no e2e por bug do agente (ao passar de "restaurando" para "anônimo" o cache de consultas era esvaziado e apagava o `/health` em carga); corrigido em `4755c70` (`fix(mobile)`), commit separado sem amend, com teste novo; CI verde. Etapa 2 fechada com dois commits, dentro da regra de correção depois do push.
- Etapa 3: `TextField` com erro (borda em `like`, exceção registrada no código; ícone, texto, aria-invalid, altura inalterada), logo em vetor gerado de `design/assets/maxx-ouro.svg` por `design/icones/logoVetor.js` com teste que falha se o SVG mudar sem regenerar, `TextLink`, `TelaDeAutenticacao` (logo, frase, segmentado, conteúdo, selo "Rede UniEduk" no pé), `Screen` com rolagem ocupando ao menos a altura da tela; 241 Jest, 15 novos; capturas da vitrine em claro e escuro.

---
Etapa 3 aprovada, e o fix da etapa 2 em commit separado está certo. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 4; para para a minha revisão no fim dela, com as capturas do login ao lado das pranchetas.
