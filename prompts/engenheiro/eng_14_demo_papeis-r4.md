ID: eng_14_demo_papeis-r4
Trilha: engenheiro (passo posterior à avaliação, fora do experimento medido)
Tela: passo 14 (resposta 4 do autor: fechamento)
Data: 2026-11-11
Origem: leitura do Cowork (Anthropic) do export; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 6 em `cff38e3` com a concordância no singular pedida na `r3`, coberta pelo Jest. A largura da folha de confirmação vem do passo 12 (`6eca0ec`) e foi registrada como limite conhecido de tela nos limites do passo 12.
- Etapa 7 em `81bf896`: caso `@demo` novo nos três papéis (aluno registra em CC; professor concede medalha a esse aluno pela lista da turma; coordenação acha o aluno pela ficha e vê "Seu lote" sem purgar). Ocorrência declarada: 3 testes falharam localmente com a suíte em paralelo e passaram rodados de novo; CI verde.
- Etapa 8: `rodada/eng_14_demo_papeis` enviada ao GitHub no commit de partida para o PR ter base; imagem `sha-81bf896` publicada pela branch e implantada com `deploy.sh <sha> demo`, dump antes da migração, `/api/ready` 200, worker sem problema; os 2 alunos que já estavam no lote `banca-2026` mantidos. Conferência no ar só de leitura, por navegador automatizado, com as contas "Conferência Maxx" nos três papéis (o professor recebeu o sufixo numérico por colisão de prefixo, pela regra). Registro em `docs/operacao.md` (`b73f4fd`). PR #16 aberto, CI verde.
- O agente leu do `.env` da VPS só a linha do lote e a da versão no ar, e declarou.

---
Passo 14 aprovado. Vou revisar e mergear o PR #16 e levar a rodada para a main. Antes de encerrar, derruba o compose local (docker compose stop), que eu preciso da máquina livre.
