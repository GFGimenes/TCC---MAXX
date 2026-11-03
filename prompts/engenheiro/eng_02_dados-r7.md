ID: eng_02_dados-r7
Trilha: engenheiro
Tela: passo 2 (resposta 7 do autor: revisão da E6, seeder base com catálogo e calendário)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E6: subcomando `seed <base|demo>` com códigos de saída 0, 1 e 2; `DatabaseSeeder` valida catálogo e calendário antes da transação, grava com advisory lock próprio, sobe `versao` só do item cujo conteúdo mudou, falha sem gravar se um item, família ou ano sumiu dos arquivos; calendário em `data/calendario/2026.json` com observação de que as datas são aproximadas; serviço `seeder` no compose entre o migrator e as réplicas; `seed demo` à mão. 191 testes (12 de seed, 3 de domínio), comprovação no compose com banco zerado e segunda rodada sem mudança.
- Cinco escolhas declaradas e aceitas: calendário como arquivo de dados por ano; ano ausente falha o seed; comparação campo a campo por reflexão (regra jsonb como árvore); família sem versão; diretório de dados por configuração `Seed:DiretorioDeDados`.
- Limitação declarada e registrada: troca de posição entre dois itens da mesma família numa rodada pode bater no índice único (família, ordem); nada no catálogo faz isso.

---
E6 aprovada. As cinco escolhas ficam: calendário como arquivo por ano em data/calendario, ano ausente falha o seed, comparação campo a campo por reflexão com a regra como árvore, família sem versão, diretório de dados por configuração. A limitação do índice (família, ordem) fica registrada como está; se um dia precisar, resolve com constraint adiável. Commita com a mensagem proposta, push, e segue para a E7; para para a minha revisão no fim dela.
