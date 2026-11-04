ID: eng_03_auth
Trilha: engenheiro
Tela: passo 3 do plano mestre (autenticação e autorização; sem tela)
Data: 2026-11-02
Origem: texto do Cowork (Anthropic) no molde dos passos 1 e 2, aprovado pelo autor. Sessão nova na `rodada/eng_03_auth` (saída da `main` em `a84a868`). Ambiente conferido com `/model` antes do primeiro prompt (ver registro da rodada).

Notas de registro:
- O prompt relembra o que fecha o passo pelo plano mestre, sem acrescentar regra nova.

---
Passo 3 do plano mestre: autenticação e autorização. Estamos na rodada/eng_03_auth, saída da main com os passos 1 e 2 mergeados. Antes de qualquer código, me traga o plano de etapas, com entrega e critério de aceite por etapa, como combinamos no CLAUDE.md. Vale tudo que está lá: decisão que não está nos docs não foi tomada, então pergunte antes de assumir. Lembro o que fecha o passo: cadastro conferindo RA e e-mail na mesma linha do cadastro elegível, um RA uma conta; geração e unicidade do arroba com sufixo por papel e reserva permanente do antigo; login por RA ou e-mail com Argon2id, access token curto, refresh rotativo por família com detecção de reuso e logout revogando; papéis e escopo de turma do professor checado no banco; limite de taxa em login, upload e registro de demonstração; flag da demonstração desligada por padrão, rotas em 404 quando desligada e ausente da configuração de produção; recuperação de senha por e-mail. Eu reviso o plano e aí começamos a primeira etapa.
