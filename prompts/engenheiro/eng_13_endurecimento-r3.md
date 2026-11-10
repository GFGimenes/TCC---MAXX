ID: eng_13_endurecimento-r3
Trilha: engenheiro
Tela: passo 13 (resposta 3 do autor: etapa 6 interrompida por falta de memória)
Data: 2026-11-09
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapas 2 a 5 fechadas sem parada do autor, cada uma com commit, CI verde e conferência no ar: etapa 2 (`cf65243` e-mails do seed e roteiro; `925e16a` fix do envio ao R2 sem assinatura em pedaços, provado por teste reverso na VPS; seed demo com 150 alunos, 1.178 medalhas, 975 trabalhos drenados em 21 s, 412 linhas de ranking; e-mail da coordenação aceito pelo Brevo e primeiro acesso confirmado pelo autor pelo Gmail), etapa 3 (`7694b94` domínios aceitos), etapa 4 (CSP e cabeçalhos, `sha-fd16c39` no ar, `style-src 'unsafe-inline'` registrado pelo react-native-web; três e2e falharam em paralelo e passaram em série, declarado), etapa 5 (saúde do worker com `/api/health/worker`, alerta 503 e 200 conferidos na VPS com o worker parado e religado; prova reversa refeita depois de um aviso CS9113 virar erro de build).
- Ocorrências: `API Error: Connection dropped (ECONNRESET)` às 21h40, coincidindo com a troca de rede do autor; o agente retomou sozinho. Etapa 6 interrompida pelo Claude Code por falta de memória na máquina do autor (pilha local inteira do compose no ar mais `npm ci` em contêiner `node:24`, 23 min); o agente parou o contêiner e trouxe duas opções em vez de reiniciar por conta própria.
- Pendência do autor declarada pelo agente: monitor do UptimeRobot em `/api/health/worker` (roteiro em `docs/operacao.md`).
- Estado da etapa 6 na árvore, sem commit: `.nvmrc` 24, `engines >=24.3`, `node:24-alpine` no Caddy; Trivy v0.76.1 no job build com soma conferida, corte alto ou crítico e `--ignore-unfixed`; npm audit revisado sem mudança (33 achados em glob, minimatch e deepmerge, só ferramental; sem correção sem rebaixar expo e jest).

---
Opção 2, por prazo: pula a suíte local no Node 24 e o Trivy local; derruba a pilha local do compose para liberar memória, commita a etapa 6 como está, push, e a CI decide com o Node do .nvmrc e o Trivy no job build. Se a CI não ficar verde de primeira, volta ao Node 22 num fix separado, mantém o Trivy e registra a avaliação do Node 24 como pendência. O registro do npm audit sem mudança fica como você descreveu. Depois segue para a 7 e a 8 sem me esperar; a pilha local só volta a subir se alguma etapa precisar do e2e. O UptimeRobot eu crio depois do passo.
