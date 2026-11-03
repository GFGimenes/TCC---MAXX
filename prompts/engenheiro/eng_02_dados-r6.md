ID: eng_02_dados-r6
Trilha: engenheiro
Tela: passo 2 (resposta 6 do autor: revisão da E5, migration do catálogo)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E4 commitada em `e76a45c`.
- E5: migration `Catalogo` com `familia` e `item_catalogo` (três tipos na mesma tabela, coluna `tipo`, `versao` desde 1, campos específicos opcionais, chave de deduplicação em `text[]`, regra em `jsonb`); checks de tipo, tier e faixa gerados das enumerações e de `Tiers.Faixa` do domínio; `CatalogoRowMapper`, `RegraDeConquistaJson`, `NomeJson`; 176 testes, 15 novos com Postgres, ida e volta dos 46 itens e consulta da regra por SQL.
- Seis escolhas declaradas e aceitas: linha da tabela como classe da Infrastructure; `codigo` como chave primária; uma coluna `periodo`; enumerações em camelCase; `restricao_curso` sem FK (o catálogo entra antes dos cursos); helpers de teste em `BancoDeTeste`. Para a quinta, o autor exigiu que o seed demo confira a sigla do curso e falhe se não existir.

---
E5 aprovada. As seis escolhas ficam: linha na Infrastructure com a versão, codigo como chave primária, uma coluna periodo, enumerações em camelCase, restricao_curso sem FK, helpers em BancoDeTeste. Sobre a 5: como o banco não garante, o seed demo confere que toda restricao_curso do catálogo aponta para uma sigla de curso existente, e falha se não apontar. Commita com a mensagem proposta, push, e segue para a E6; para para a minha revisão no fim dela.
