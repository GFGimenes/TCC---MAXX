ID: eng_05_login-r2
Trilha: engenheiro
Tela: passo 5 (resposta 2 do autor: revisão da etapa 1, termo de uso na API, e aprovação do texto do termo v1)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor leu o texto do termo; acréscimo da seção "Demonstração" proposto pelo Cowork, aprovado; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1: `TermoDeUso` e `AceiteDeTermo` no domínio, migration `TermoDeUso`, seed base lendo `data/termos/termo-de-uso.v<n>.md` com publicação imutável (texto alterado ou arquivo removido faz o seed falhar), `GET /api/v1/termo-de-uso` anônimo, `versaoDoTermo` obrigatório no cadastro e no registro da demonstração (400 sem o campo, 409 `termo-desatualizado`), aceite na mesma transação da conta; 242 de domínio, 4 de arquitetura, 229 de integração, purga testada com o SQL do README contra banco real; conferido pelo Caddy.
- A rodada de integração interrompida pela queda de rede registrou 15 horas e 116 falhas; na rodada limpa sobrou um teste do agente esperando o código 23503 do Postgres em vez do 23001, corrigido.
- Texto do termo v1 redigido pelo agente só a partir do `produto.md` (visibilidade, ranking, fotos públicas por link, RA reservado, papel da instituição, registro do aceite), sem LGPD, contato, prazo de guarda nem demonstração, por falta de decisão nos docs. O autor aprovou o texto com uma seção "Demonstração" a mais (contas de demonstração são de teste e os dados são apagados ao fim da avaliação); LGPD, contato e prazo de guarda ficam como pendência da fase 1.

---
Etapa 1 aprovada. Texto do termo v1 aprovado com um acréscimo, antes de "Registro do aceite": uma seção "Demonstração" dizendo que contas criadas no modo de demonstração são de teste e que os dados delas são apagados ao fim da avaliação do projeto. LGPD, contato e prazo de guarda ficam fora da fase 1, registrados como pendência. A correção do código 23001 no teste fica. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 2; para para a minha revisão no fim dela.
