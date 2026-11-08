ID: eng_07_posts-r5
Trilha: engenheiro
Tela: passo 7 (resposta 5 do autor: revisão da etapa 4, curtida, comentário e seguir)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 3 fechada em `8097034`, CI verde.
- Etapa 4: curtida (PUT/DELETE idempotentes, oito simultâneas viram uma), comentários por cursor opaco (base64url de instante e id, comparação de linha no Postgres, 400 `cursor-invalido`; teste com 45 comentários no mesmo instante), remoção de comentário nos dois modos, seguir pela D9 com `ProfessorEnsinaAlunoAsync` no banco; migration `Social`; purga com `curtida`, `comentario`, `seguimento`; 14 de domínio e 16 de integração novos (698 na API); teste do app contando 6 arquivos de códigos.
- Dois pontos confirmados pelo autor: ordem dos comentários do mais antigo ao mais novo; conta de professor e instituição interage como professora.

---
Etapa 4 aprovada. Confirmo os dois pontos: comentários do mais antigo ao mais novo, e a conta de professor e instituição segue, curte e comenta como professora. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 5; para para a minha revisão no fim dela.

Nota posterior (antes da etapa 5): o agente verificou a premissa da D13 (semear posts para os 20 alunos demo) e mostrou que ela não vale: o seed demo grava os alunos só como cadastro elegível, sem conta, porque aluno só se cadastra pelo app (`produto.md` 2.5) e `Usuario.CriarPeloSeed` recusa aluno; post exige autor com conta. Perguntou por menu interativo com três opções (adiar para o passo 12; criar contas de seed agora com regra nova; abandonar a D13). O autor escolheu adiar para o passo 12, pela recomendação do agente e do Cowork: não mudar regra do passo 3 só para o feed não nascer vazio. D13 registrada como adiada.
