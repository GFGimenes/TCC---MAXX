ID: eng_14_demo_papeis-r2
Trilha: engenheiro (passo posterior à avaliação, fora do experimento medido)
Tela: passo 14 (resposta 2 do autor: revisão das etapas 1 a 4 e das telas de entrada da etapa 5)
Data: 2026-11-11
Origem: leitura do Cowork (Anthropic) do export; o autor conferiu as 12 capturas (escolha, aluno, professor, coordenação, professor com erros e termo; claro e escuro, 390 x 844), copiadas para `resultados/engenheiro/capturas/eng_14_demo_papeis/etapa5/`; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapas 1 a 4 com commit e CI verde: `6538767` (docs), `c70ce15` (domínio e migração `PapeisNaDemonstracao`), `ec0df1e` (rotas de registro de professor e coordenação, limite de 60 por hora por IP somado, correção de e-mail por conta de demonstração só para `.invalid`), `80dff3a` (fix: mensagem do código novo, exigida por um teste do cliente; única CI vermelha), `6942698` (purga apaga alunos e encerra a equipe do lote, contagens por papel, marca do lote de quem pede). Suíte antes do último push: 1.296 testes na API e 528 no Jest.
- Bug pego pelos testes antes do push: o registro da coordenação não gravava a linha da base e respondia 500.
- Mudança em relação ao plano, declarada e registrada no índice: em vez de barrar conta encerrada na busca de quem age, o token de conta de demonstração leva uma marca e só esses pedidos são conferidos no banco a cada chamada; conta apagada ou encerrada recebe 401 na hora.
- O agente iniciou o Docker Desktop na máquina do autor, que estava parado, e declarou.
- Etapa 5 sem commit: três entradas com linha de apoio, telas "Aluno de teste", "Professor de teste" e "Coordenação de teste", lembrança com papel, 15 testes Jest (6 novos), ajuste mínimo do e2e do aluno. Três decisões fora dos docs, declaradas: tela própria "Aluno de teste"; texto "Na demonstração, use um e-mail terminado em .invalid."; "Abre no navegador." só no aparelho.
- Capturas conferidas pelo autor: fiéis ao padrão visual das telas de login e cadastro.

---
Etapas 1 a 4 aprovadas, e a troca da busca pela marca no token de demonstração fica como você fez e registrou. Etapa 5 aprovada, capturas conferidas no claro e no escuro. As três decisões que você declarou ficam: "Aluno de teste" em tela própria, a mensagem do .invalid e o "Abre no navegador." só no aparelho. Commita a etapa 5, push, CI, e segue para a etapa 6, a tela da purga; para nela com as capturas.
