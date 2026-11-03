ID: eng_02_dados-r3
Trilha: engenheiro
Tela: passo 2 (resposta 3 do autor: revisão da E2, catálogo e validador no domínio)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E1 commitada em `4b235e9` com a mudança pedida (matrícula só em turma de matéria do curso do aluno; `Turma` passou a referenciar `Materia`).
- E2: `Tier`, `ItemCatalogo` em três variantes, `RegraDeConquista`, `Familia`, `Catalogo` e `CatalogoValidator` devolvendo todos os erros com o código do item; 123 testes de domínio e 4 de arquitetura.
- Cinco regras que o agente derivou dos docs sem frase literal, declaradas e aceitas: repetível, ocorrência e limite andam juntos; alvo `todasAsMatriculasDoPeriodo` exige gatilho `fechamentoDePeriodo`; período `curso` não fecha; fonte `ambos` sem agrupamento; `filtroItens: []` é erro, `null` é qualquer item.

---
E2 aprovada. As cinco regras derivadas ficam todas: repetível, ocorrência e limite juntos; todasAsMatriculasDoPeriodo só com fechamentoDePeriodo; período curso nunca fecha; fonte ambos sem agrupamento; filtroItens vazio é erro e null é qualquer item. Commita com a mensagem proposta, push, e segue para a E3; para para a minha revisão no fim dela.
