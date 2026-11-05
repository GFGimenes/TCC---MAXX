ID: eng_03_auth-r13
Trilha: engenheiro
Tela: passo 3 (resposta 13 do autor: conferência do PR #4 e encerramento da rodada)
Data: 2026-11-04
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E11 commitada em `4815990` com o limite de 60 por minuto por IP em sugestão e disponibilidade (450 testes). Fechamento dos docs em `1757fbd`: decisões das E6 a E11, tabela de limites, seção "Purga da demonstração" com o SQL por lote, códigos HTTP nos fluxos 01 e 06, passo 5 do plano mestre com serialização do refresh, debounce do arroba e tela `/redefinir-senha` (os dois últimos acrescentados pelo agente, aceitos como consequência da E9 e da E11).
- Falha de processo declarada pelo agente: não conferiu a CI a cada push; E9 e E10 ficaram vermelhas no gitleaks (falso positivo na senha de teste "outra-senha-789", varrida no histórico). Correção em commit próprio: `.gitleaksignore` com os dois achados e o literal movido para constante; gitleaks local na mesma versão sem achados; CI verde. O autor aceitou a exceção delimitada e fixou a regra: etapa só é dada como pronta depois de a CI do push dela passar, com o resultado no relatório.
- O agente corrigiu a própria contagem da E9 (12 testes de recuperação mais o do SMTP, não 13). Publicou a `rodada/eng_03_auth` no remoto para o PR ter base, como nos passos anteriores.
- PR #4 `feat/passo-03-auth` → `rodada/eng_03_auth`, 13 commits, seis checks verdes.

---
PR conferido: treze commits, CI verde, descrição com as onze etapas, a exceção do gitleaks e a correção da contagem. Os dois itens extras do passo 5 ficam, são consequência da E9 e da E11. A exceção do gitleaks fica como está, delimitada aos dois achados. Sobre a CI: daqui em diante, cada etapa só é dada como pronta depois de a CI do push dela passar, e o resultado entra no relatório da etapa. Vou fazer o merge no GitHub e fechar a rodada. Passo 3 encerrado.
