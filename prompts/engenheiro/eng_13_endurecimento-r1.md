# eng_13_endurecimento, rodada 1

Resposta do autor ao plano de 11 etapas e às 10 perguntas. Decisões: deploy sobe para o começo do passo; cortes declarados por prazo (papel maxx_app, k6 a 2.000 usuários, bucket de backup separado) ficam registrados como pendência fora da fase 1.

---

Plano aprovado com uma mudança de ordem e alguns cortes. Respostas às perguntas primeiro, depois a ordem nova.

Perguntas

1. Sim: os 9 endereços passam para maxx-unimax.com e o domínio entra na lista aceita. Eu configuro o Email Routing da Cloudflare com catch-all para a minha caixa antes da etapa do deploy. Mantenha os nomes locais (coordenacao@, renata.albuquerque@ e os demais), só troca o domínio.
2. Textos aprovados como estão. Pode passar o produto.md 2.4 para "configuração da API".
3. Não vou criar bucket agora. O backup fica no disco da VPS, em /opt/maxx/backups, com rotação de 14 dias feita pelo próprio script. Registre o envio para um bucket sem domínio público como pendência fora da fase 1. As três variáveis MAXX_BACKUP_* saem do .env.
4. Monitor externo. Eu crio o UptimeRobot depois do deploy, apontando para /api/health/worker a cada 5 minutos; nada de cron com SMTP no host. Isso não entra em etapa sua, só no roteiro de operação.
5. Sim ao workflow_dispatch na branch com a tag sha-<curto>, latest só da main. Pacote público no GHCR: os repositórios já são públicos e as imagens não carregam segredo. Sem token na VPS.
6. Não entra. O usuário dono fica, com a revisão do privilégio registrada no índice de decisões. Pendência fora da fase 1.
7 e 8. Corto a carga a 2.000 usuários por prazo. No lugar, com a demonstração carregada na VPS: EXPLAIN (ANALYZE) do feed, da busca e do ranking com o volume do seed demo, planos registrados, e um k6 pequeno, 50 usuários virtuais por 2 minutos, rodando de dentro da própria VPS só nas rotas anônimas ou com as contas já existentes do seed demo, sem seed de carga novo. O p95 dessa rodada entra no registro com a ressalva de que não é o cenário do ADR 0005; o cenário completo fica como pendência.
9. Entra. Trivy nas duas imagens, no job build, mesmo corte.
10. Se o Expo 58 suportar e a suíte e a CI ficarem verdes de primeira, troca. Qualquer atrito, mantém o 22 e registra a avaliação.

Ordem nova

O deploy vem antes do endurecimento, porque as etapas seguintes precisam ser conferidas no ar e eu preciso do produto acessível de fora o quanto antes.

1. Compose de produção, imagens no GHCR e job publicar (sua etapa 5, mais o workflow_dispatch da pergunta 5).
2. Primeiro deploy na VPS (sua etapa 7). Você para antes dela e me passa a lista final de variáveis; eu escrevo o /opt/maxx/.env e aviso com "env feito". Você confere só os nomes. O teste do R2 roda do jeito que você descreveu.
3. Domínios de e-mail aceitos (sua etapa 1).
4. Cabeçalhos de segurança e CSP (sua etapa 2).
5. Saúde do worker (sua etapa 3).
6. Node 24, npm audit e Trivy (suas etapas 4 e 9 juntas).
7. Backup local com rotação e deploy.sh com dump antes do migrator (sua etapa 8 reduzida).
8. Planos e carga reduzida (sua etapa 9 reduzida, conforme as perguntas 7 e 8).
9. Ensaio da demonstração remota (sua etapa 10). Para aqui e me entrega o roteiro.
10. Registro do passo (sua etapa 11), incluindo os cortes acima como pendências.

Depois de cada etapa de 3 a 7 que muda a API ou o Caddy, publica a imagem pela branch e atualiza a VPS com pull e up, para que o aceite seja conferido no ar e não só na CI. A etapa 3 pode ser emendada direto com os textos aprovados.

Paradas: antes da etapa 2 (lista de variáveis), na etapa 9 (ensaio) e qualquer número que estoure um alvo. Fora isso, emenda as etapas em sequência, cada uma com commit, push e CI verde, sem me esperar entre elas.

Processo: comandos longos (build de imagem, e2e, k6) em segundo plano, com trabalho independente em paralelo; suíte inteira só antes do push. Nenhum valor de credencial sai da VPS nem entra no chat; só nomes de variáveis.

Pode começar pela etapa 1.
