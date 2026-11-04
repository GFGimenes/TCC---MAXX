ID: eng_03_auth-r3
Trilha: engenheiro
Tela: passo 3 (resposta 3 do autor: revisão da E2, usuário, arroba e política de senha no domínio)
Data: 2026-11-03
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor (limite de 60 proposto pelo Cowork, aprovado); redigida pelo Cowork, o autor revisou.

Notas de registro:
- E2 com TDD: `PrefixoDeArroba` (validação, comparação sem maiúsculas, sugestões na ordem aprovada), `Sufixo` e record `Arroba`, `PoliticaDeSenha` (8 a 128 caracteres, contados como caractere), `Usuario` (`CadastrarAluno`, `CriarPeloSeed`, troca de prefixo com reserva, troca de curso, ex-aluno); 204 testes de domínio, 78 novos.
- Cinco comportamentos fixados pelo agente: nome curto numerado e longo cortado em 30; hífen e apóstrofo descartados; troca só de maiúsculas não cria reserva; ex-aluno edita prefixo mantendo -EX; nome de exibição sem máximo (o agente pediu um limite). Autor aceitou os quatro primeiros, pediu o registro de 1 e 2 no `produto.md` 2.3.1 e fixou 60 caracteres para o nome de exibição.

---
E2 aprovada. Os comportamentos 1 a 4 ficam, e registra o 1 e o 2 no produto.md 2.3.1 neste commit. No 5, nome de exibição com máximo de 60 caracteres, e isso também vai para o 2.3.1. Commita com a mensagem proposta, push, e segue para a E3; para para a minha revisão no fim dela.
