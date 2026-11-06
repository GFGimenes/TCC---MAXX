ID: eng_05_login
Trilha: engenheiro
Tela: passo 5 do plano mestre (login, cadastro, termos e entrada da demonstração; primeiras telas reais)
Data: a preencher no envio
Origem: rascunho do Cowork (Anthropic) no molde dos passos 1 a 3, a partir do plano mestre do repo em 05/11/2026 (`main` em `5b7cb45`). Antes do envio, conferir contra o plano mestre atualizado, porque passos anteriores podem ter acrescentado itens a este. Ao enviar, mover para `prompts/engenheiro/eng_05_login.md`, preencher a data e registrar o ambiente (`claude --version`, `/model`).

Notas de registro:
- Texto relembra o que fecha o passo pelo plano mestre, sem regra nova, mais a regra da CI verde por etapa fixada na `eng_03_auth-r13`.

---
Passo 5 do plano mestre: login, cadastro, termos e entrada da demonstração. Estamos na rodada/eng_05_login, saída da main com os passos 1 a 4 mergeados. Antes de qualquer código, me traga o plano de etapas, com entrega e critério de aceite por etapa, como combinamos no CLAUDE.md. Vale tudo que está lá: decisão que não está nos docs não foi tomada, então pergunte antes de assumir. Uma regra que fixei no passo 3 e vale daqui em diante: cada etapa só é dada como pronta depois de a CI do push dela passar, e o resultado da CI entra no relatório da etapa. Lembro o que fecha o passo: login e cadastro em claro e escuro conforme as pranchetas; aceite do termo de uso versionado dentro da identidade visual; entrada da demonstração com botão só com a flag ligada, registro simples e lembrança local do dispositivo; refresh serializado no cliente, obrigatório, como está no plano mestre e no README das decisões; debounce na sugestão e na disponibilidade do arroba; tela de senha nova em /redefinir-senha lendo o token do fragmento; e2e de cadastro, login, recuperação de senha e entrada de demonstração. Eu reviso o plano e aí começamos a primeira etapa.
