ID: eng_12_instituicao-r4
Trilha: engenheiro
Tela: passo 12 (resposta 4 do autor: revisão da etapa 8, busca e ficha do aluno)
Data: 2026-11-09
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor conferiu as 20 capturas (área, busca, ficha em duas alturas, quatro folhas de ato, conceder em duas telas; claro e escuro) pelas duas folhas compostas; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 7 em `6dd1e82`, CI verde nos seis jobs.
- Etapa 8 entregue sem commit: entrada "Alunos" na área; busca por nome, arroba, e-mail ou RA com espera de 400 ms e mínimo de 2 letras, linhas com situação (Ativo, Ex-aluno, Sem conta, Demonstração); ficha com dados da base, atos por situação (ativo: quatro; sem conta: e-mail e curso; ex-aluno: e-mail) e medalhas ativas com "Anular"; folhas por ato com a recusa da API dentro; conceder prêmio reaproveitando o seletor da reivindicação com eventos e matérias do aluno; dois acréscimos aditivos na API (`GET /v1/instituicao/alunos/{id}/premios-participacao`, id do curso em `GET /v1/cursos`); 24 Jest novos (514), um teste de integração novo; lint, tipos, formato e contrato limpos. Capturas tiradas sem confirmar nenhum ato.
- Capturas conferidas pelo autor: fiéis.

---
Etapa 8 aprovada, capturas conferidas. Os dois acréscimos na API ficam como você fez. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 9; no fim dela, para para a minha revisão com as capturas do novo aviso da instituição (escopo, chips de cursos, foto) e da tela da purga (lista de lotes e confirmação), em claro e escuro, com a mensagem de commit antes de commitar.
