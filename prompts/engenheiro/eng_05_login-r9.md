ID: eng_05_login-r9
Trilha: engenheiro
Tela: passo 5 (resposta 9 do autor: conferência do PR #7, dois ajustes de docs, encerramento)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 7 (`5ba31cf`) e etapa 8 (`f88a419`) com CI verde; as duas passadas do e2e funcionaram na CI de primeira (59 mais 1 pulado; 4 de 4 com demonstração).
- Purga do banco local com o SQL do README, lote `e2e-local`: 3 usuários, 5 famílias de sessão, 0 recuperações, 12 matrículas, 3 cadastros; aceites e prefixos em cascata. O agente corrigiu o próprio relatório da etapa 7 (o aluno da captura estava no lote `e2e-local`).
- Etapa 8: README de decisões (termo, aceite, exceção às mudanças só aditivas, seção "Autenticação no cliente (passo 5)" com 16 decisões, linha "Etapa pronta" em Processo), fluxos 01 e 06 com a parte do cliente, `apps/mobile/README.md`, `produto.md` 2.6, 11 e 13 (pendência de LGPD), identidade visual (botão grande e borda em `like`), plano mestre (quatro riscos novos, pendência do termo em Fase 2, achados do npm audit no passo 13).
- PR #7 `feat/passo-05-login` → `rodada/eng_05_login`, 9 commits. O agente apontou que a `r8` pedia "dois fixes" e há só um commit de fix (erro do autor, reconhecido). Duas decisões: reescrever o risco e o ensaio do passo 13 para a avaliação remota sem apresentação presencial; acrescentar `TermoDeUso` e `AceiteDeTermo` ao glossário do `CLAUDE.md`. Autor aprovou as duas num commit de docs antes do merge.

---
PR conferido; o "dois fixes" foi engano meu, só há o da etapa 2 e a descrição está certa. Dois ajustes antes do merge, num commit docs separado: 1, no plano mestre, troca o risco "Rede do campus na apresentação" e o item de ensaio do passo 13 pela realidade nova: não há apresentação presencial, a avaliação é remota antes de 05/12, cada avaliador entra pela própria conexão; o ensaio passa a ser de demonstração remota, com a purga de ensaio mantida. 2, acrescenta TermoDeUso e AceiteDeTermo ao glossário do CLAUDE.md. Push, confere a CI e me avisa. Depois eu faço o merge no GitHub e fecho a rodada. Passo 5 encerrado.
