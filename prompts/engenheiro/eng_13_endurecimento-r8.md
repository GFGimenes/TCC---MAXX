ID: eng_13_endurecimento-r8
Trilha: engenheiro
Tela: passo 13 (resposta 8 do autor: fechamento do passo e da trilha)
Data: 2026-11-10
Origem: leitura do Cowork (Anthropic) do export; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Correção do passo 6 do ensaio no ar (`sha-060f0b4`, CI e publicação verdes, sete jobs), demonstração ligada com o lote `banca-2026`.
- Etapa 10 em `4e42d75`, CI verde: seção "Endurecimento e ensaio (passo 13)" no índice de decisões (produção, seed e R2, borda, domínios, saúde do worker, backup, Node e npm audit, ensaio com o cache da CDN como limite conhecido, varredura das imagens, carga e planos); cinco linhas antigas de infraestrutura e 13 limites dos passos 7, 10, 11 e 12 atualizados; plano mestre com o fechamento, tabela de pendências fora da fase 1 (carga de 2.000, índices com volume real, backup fora do disco, papel do banco, APK e Maestro, Node 24, Caddy corrigido antes de 05/12, limpeza do cache pela própria purga) e riscos medidos; `docs/ensaio.md` e `docs/operacao.md`; comentários desatualizados em cinco arquivos.
- Ocorrências declaradas: 1 falha intermitente em 523 na suíte local do app (sem identificação no log; rodada nova 523 de 523, CI verde); timeout de conexão com o contêiner de armazenamento na suíte local da API, como no passo 11 (classe sozinha 9 de 9); o agente corrigiu no índice uma anotação própria que dizia que a ocorrência não se repetira.
- Deixado com o autor: duas linhas do `CLAUDE.md` desatualizadas (o agente não mexeu por ser o arquivo de instruções); monitor do UptimeRobot; exceção do Trivy expira em 05/12/2026. Branch com 17 commits sobre a rodada; PR único para o passo.

---
Etapa 10 aprovada, e com ela o passo e a trilha. Ajuste as duas linhas do CLAUDE.md (Maestro fora da fase 1; carga reduzida executada, cenário de 2.000 como pendência) num commit docs separado, com CI, e abra o PR da chore/passo-13-endurecimento para a rodada/eng_13_endurecimento, um só para o passo, com a tabela de fechamento no corpo e sem rodapé de ferramenta. Me avise quando o PR estiver aberto com a CI verde. UptimeRobot e a data do Trivy ficam comigo.
