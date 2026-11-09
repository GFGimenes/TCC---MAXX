ID: eng_12_instituicao-r6
Trilha: engenheiro
Tela: passo 12 (resposta 6 do autor: revisão da etapa 10, e2e e docs, e fechamento do passo)
Data: 2026-11-09
Origem: leitura do Cowork (Anthropic) do export da sessão; sem capturas nesta etapa; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 9 em `b641a1d`, CI verde nos seis jobs.
- Etapa 10 entregue sem commit: `e2e/tests/instituicao.spec.ts` com quatro casos nos dois temas (entrada pela aba Perfil, fila de comprovações, contestações confirmadas e revogadas; atos pela ficha; aviso de curso recebido pelo aluno; purga de lote com a foto saindo do bucket); correção do "Voltar à ficha" (voltar na pilha); prazo de 90 s nos e2e de medalhas, conquistas e rankings, registrado nas decisões; produto.md, decisões e plano mestre atualizados. Verificação local: Prettier, lint e tipos limpos; Jest 520; e2e 85 sem demonstração (verde em duas rodadas) e 4 com demonstração. Nenhuma etapa do passo precisou de fix.
- Pendências para o passo 13 declaradas pelo agente: lista de domínios de e-mail como configuração; primeiro acesso de professores e instituição do seed dependendo do SMTP; seed demo na VPS com as variáveis do R2; tempo de drenagem da fila na VPS; purga de ensaio pela tela. Limites aceitos: volume local anterior recriado; sem conquista de fechamento no seed; foto do post sem relação com o evento; objetos sem dono no bucket se o seed falhar depois das fotos.
- Tipo de commit `test(mobile)` justificado pelo agente (não existe escopo e2e); aceito.

---
Etapa 10 aprovada, e com ela o passo. O prazo de 90 s nos e2e de vários papéis fica, como você registrou, e o tipo test(mobile) serve. Commita com a mensagem proposta, push, acompanha a CI até o verde e abre o PR da feat/passo-12-instituicao para a rodada/eng_12_instituicao, com a tabela de fechamento no corpo, sem rodapé de ferramenta. Me avisa quando o PR estiver aberto com a CI verde.
