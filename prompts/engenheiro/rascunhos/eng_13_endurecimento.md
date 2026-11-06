ID: eng_13_endurecimento
Trilha: engenheiro
Tela: passo 13 do plano mestre (endurecimento e ensaio; último passo)
Data: a preencher no envio
Origem: rascunho do Cowork (Anthropic) no molde dos passos 1 a 3, a partir do plano mestre do repo em 05/11/2026 (`main` em `5b7cb45`). Antes do envio, conferir contra o plano mestre atualizado, porque passos anteriores podem ter acrescentado itens a este. Ao enviar, mover para `prompts/engenheiro/eng_13_endurecimento.md`, preencher a data e registrar o ambiente (`claude --version`, `/model`).

Notas de registro:
- Texto relembra o que fecha o passo pelo plano mestre, sem regra nova, mais a regra da CI verde por etapa fixada na `eng_03_auth-r13`.

---
Passo 13 do plano mestre: endurecimento e ensaio. Estamos na rodada/eng_13_endurecimento, saída da main com os passos 1 a 12 mergeados. Antes de qualquer código, me traga o plano de etapas, com entrega e critério de aceite por etapa, como combinamos no CLAUDE.md. Vale tudo que está lá: decisão que não está nos docs não foi tomada, então pergunte antes de assumir. Uma regra que fixei no passo 3 e vale daqui em diante: cada etapa só é dada como pronta depois de a CI do push dela passar, e o resultado da CI entra no relatório da etapa. Lembro o que fecha o passo: k6 a 2.000 usuários virtuais com p95 medido em feed, perfil e ranking, e micro-cache da primeira página do feed só se o número pedir; verificação de saúde do worker e alerta de fila parada; CSP, HSTS e cabeçalhos de segurança, porta 443 pelo Caddy; varredura de dependências e de segredos na CI; backup com pg_dump noturno para o bucket e dump manual antes de migration, com restauração testada uma vez; APK gerado e fumaça mínima com Maestro; ensaio da apresentação com a banca entrando por rede móvel e o notebook roteado pelo celular; purga de ensaio testada; avaliação da troca do Node 22 pelo 24; revisão dos achados moderados do npm audit; provedor SMTP da VPS no lugar do Mailpit. Eu reviso o plano e aí começamos a primeira etapa.
