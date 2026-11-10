ID: eng_13_endurecimento-r6
Trilha: engenheiro
Tela: passo 13 (resposta 6 do autor: ensaio feito, purga conferida, cache da CDN)
Data: 2026-11-10
Origem: ensaio executado pelo autor (iPhone 12, Safari; 5G Claro no passo 1, Wi-Fi nos demais; professor e instituição pelo computador); leitura do Cowork (Anthropic) do export; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Ensaio em 10/11/2026, 14h47 a 15h06: tela de login em 4 s no 5G com cache limpo; entrada pela demonstração com foto; post com foto no feed; curtida, comentário e seguir; Troféus, rankings, Mural e sininho; reivindicação com foto; medalha concedida pela professora Renata (CC) e posição no ranking mudada em 2 s; reivindicação aprovada pela fila; aviso de curso pela coordenação visível no Mural na hora; volta pela lembrança do aparelho. Duas conexões em vez de três, declarado. O professor Cláudio (IA) não enxerga o aluno de CC, regra de escopo confirmada em uso.
- Achado de tela no passo 6: na folha de reivindicação, o prêmio selecionado não pode ser trocado. Correção como fix separado com Jest e captura para revisão do autor antes da etapa 10.
- Purga pela tela às 15h06: lote `ensaio-2026-11`, 2 alunos e 6 fotos; conferência do agente: 0 contas do lote, 0 posts, 0 linhas de demonstração, registro em `purga_da_demonstracao`, fila sem falha, bucket sem as fotos (404 direto e HEAD). Resíduo: cache de borda da Cloudflare ainda servindo a URL exata (`cf-cache-status: HIT`, Age 20 min). Três opções trazidas; autor escolhe a limpeza manual do cache como passo da rotina, executada agora (Purge Everything na zona; só `fotos.` passa pelo proxy). Lote de volta a `banca-2026` pelo autor.

---
Opção 1: a limpeza do cache de fotos.maxx-unimax.com no painel da Cloudflare entra como passo da rotina depois da purga, no docs/ensaio.md e no docs/operacao.md, e o cache de borda fica registrado como limite conhecido com essa mitigação. Acabei de executar esse passo para o lote do ensaio, Purge Everything na zona; confira que a URL exata da foto passou a dar 404. O MAXX_DEMO_LOTE já está em banca-2026: sobe de novo com deploy.sh 789313a demo e confira o lote nas réplicas. Em seguida corrija o achado do passo 6 (trocar o prêmio selecionado na folha de reivindicação) como fix separado, com Jest, e pare com a captura para a minha revisão antes da etapa 10.
