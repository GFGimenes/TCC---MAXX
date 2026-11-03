ID: eng_02_dados-r2
Trilha: engenheiro
Tela: passo 2 (resposta 2 do autor: revisão da E1, modelo acadêmico e calendário no domínio)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Entrega com TDD: 47 testes de domínio e 4 de arquitetura, `--ignore-exit-code 8` removido, calendário com fronteiras lidas em America/Sao_Paulo, `Curso.DuracaoEmSemestres`, `Papeis` como enum de combinação (só professor e instituição podem coexistir), Guid v7 gerado no domínio.
- Sete escolhas declaradas; seis aceitas. A sexta (matrícula sem conferir se a matéria é do curso do aluno) foi revertida pelo autor: o domínio passa a recusar.
- Testes de integração não rodaram na E1 porque o Docker Desktop estava desligado; o autor liga antes da E4.

---
E1 aprovada. As escolhas 1, 2, 3, 4, 5 e 7 ficam como estão. A 6 muda: a matrícula só aceita turma de matéria do curso do aluno; aluno de Administração não entra em turma de Algoritmos. Adiciona o teste que recusa e o que aceita. Commita com a mensagem proposta, push, e segue para a E2; para para a minha revisão no fim dela. O Docker Desktop vai estar ligado a partir da E4.
