ID: eng_06_medalhas-r4
Trilha: engenheiro
Tela: passo 6 (resposta 4 do autor: revisão da etapa 3, domínio da medalha)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 2 fechada em `9cbf9f7`, CI verde com o e2e de recuperação passando pelo worker.
- Etapa 3, só domínio: `Medalha.Conceder` com snapshot de item (versão, tier, pontos), turma, matéria, semestre, bimestre da data (também em M10 e M11), ocorrência pela menor vaga livre, chave de deduplicação pelos campos do catálogo (com ocorrência nos repetíveis), auditoria de concessão e anulação em colunas; seis motivos de recusa e quatro erros de quem chama; anulação libera a vaga; 18 testes novos (263 de domínio), com fronteiras de bimestre em America/Sao_Paulo e datas entre bimestres e fora do semestre.

---
Etapa 3 aprovada. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 4; para para a minha revisão no fim dela, com a regra F no produto.md.
