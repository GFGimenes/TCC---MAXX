ID: eng_13_endurecimento-r5
Trilha: engenheiro
Tela: passo 13 (resposta 5 do autor: aprovação do roteiro do ensaio, etapa 9)
Data: 2026-11-10
Origem: leitura do Cowork (Anthropic) do export da sessão e do `docs/ensaio.md`; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 6 fechada (CI `8a9a0c4`): Node 24 avaliado e rejeitado por um teste do cliente que falha só nele ("recusa da API vira mensagem e a tela continua"), volta ao 22 em `711ff11`, causa como pendência; Trivy v0.76.1 nas duas imagens, apt da API corrigido (`58f0666`), exceção com prazo (05/12/2026) para CVE-2026-78661 no Caddy registrada no índice; npm audit sem mudança (33 achados em ferramental, sem correção sem rebaixar expo e jest).
- Etapa 7 fechada (CI `4467680`): `deploy.sh` implantou `sha-789313a` com dump antes do migrator; timer noturno às 03:00 de São Paulo ativo; `/opt/maxx/backups` 700; teste de restauração tinha falso positivo (comparava dois arquivos vazios) pego e corrigido pelo agente em fix separado; agora 46 tabelas com contagem igual à produção em 1 s.
- Etapa 8 fechada (CI `490ffa9`): k6 de dentro da VPS, 50 usuários virtuais por 2 min, 9.488 pedidos, 0 falha, p95 geral 43 ms, p99 104 ms, máximo 385 ms; por rota: feed 71, recomendação 59, ranking 47 e 39, novidades 35, mural 33, busca 27, perfil 26 ms; micro-cache do feed não entra. Planos: ranking usa índice; feed e busca por varredura sequencial com o volume atual (52 posts, 159 usuários), índices usados com `enable_seqscan = off`; prova com volume real como pendência. Ocorrência: k6 em contêiner sem permissão de ler o arquivo de ids, corrigido rodando como root.
- Etapa 9: roteiro em `docs/ensaio.md` (antes, durante com 10 passos, depois com purga pela tela e conferência no banco e no R2, medidas a registrar). Roteiro pede três conexões; o autor dispõe de duas a esta hora (4G do celular e banda larga do computador), declarado. Lote do ensaio `ensaio-2026-11` definido pelo autor no `.env`; lote da avaliação `banca-2026` volta depois da purga.
- Pendências do autor confirmadas: UptimeRobot depois do passo.

---
Roteiro aprovado como está. Respostas: o e-mail de primeiro acesso da coordenação chegou e a senha já foi definida; o MAXX_DEMO_LOTE do .env está em ensaio-2026-11, só do ensaio, e volto para o lote da avaliação depois da purga; participantes prontos em duas conexões, celular no 4G e computador na banda larga de casa, o que vai declarado no registro como abaixo das três do roteiro. Pode subir com deploy.sh 789313a demo e acompanhar pela VPS. Eu aviso cada passo concluído com o número dele e o tempo medido, e você me diz o que viu no log. Depois da purga, você confere banco e R2 e me avisa para trocar o lote.
