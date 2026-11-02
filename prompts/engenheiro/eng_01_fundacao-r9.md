ID: eng_01_fundacao-r9
Trilha: engenheiro
Tela: passo 1 (resposta 9 do autor: revisão da etapa 8, cinco diagramas de sequência em docs/fluxos/, e abertura do PR)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisões do autor (o Cowork apresentou as duas leituras do reenvio, o autor escolheu); redigida pelo Cowork, o autor revisou.

Notas de registro:
- CI da etapa 7 passou na branch com os seis jobs verdes (`0b75fa4`).
- Entrega: `docs/fluxos/README.md` e cinco arquivos (login, post com comprovação, concessão de medalha com anulação, contestação, ranking), seis diagramas Mermaid renderizados no mermaid-cli, cada um com tabela "De onde vem cada passo" apontando para `produto.md`, ADR ou `regras-conquista.md`; o agente removeu códigos HTTP que nenhum doc fixava. `CLAUDE.md` com `infra/` e `e2e/` no mapa do repositório.
- O agente encontrou uma ambiguidade real no `produto.md` 4.7 (reenvio após reprovação) e não escolheu. Decisão do autor: reenvio é um post novo de reivindicação; o post reprovado vira post comum; uma reivindicação, um post, uma foto. Correção do 4.7 pedida no mesmo commit.
- O agente enfileirou o recálculo de ranking em todo evento que muda pontuação e declarou como inferência. Decisão do autor: confirma e manda atualizar o ADR 0005, para que a regra não fique só nos diagramas.
- Fechamento do passo: commit, push, CI, PR da `chore/passo-01-esqueleto-monorepo` para a `rodada/eng_01_fundacao` listando as oito etapas; merge pelo autor.

---
Etapa 8 aprovada, com duas correções nos docs no mesmo commit, já que são decisões e não podem ficar só nos diagramas.

1. Reenvio depois da reprovação: é um post novo de reivindicação. O post reprovado perde o vínculo com o prêmio e permanece no feed como post comum; para tentar de novo, o aluno publica outro post com outra foto e reivindica de novo. Cada reivindicação tem um post e uma foto só. Corrige o produto.md 4.7 para dizer isso sem ambiguidade e ajusta o diagrama 02 se precisar.

2. Recálculo de ranking: fica como você desenhou, enfileirado em todo evento que muda pontuação (aprovação de comprovação, contestação, decisão da instituição, anulação de medalha e conquista concedida), com a coalescência do ADR 0005. Atualiza o ADR 0005 para dizer isso explicitamente, em vez de só na concessão de medalha, e tira a marca de inferência das tabelas de fonte.

Depois commita com a mensagem proposta, push, confere a CI e abre o PR da chore/passo-01-esqueleto-monorepo para a rodada/eng_01_fundacao com a descrição listando as oito etapas. Eu reviso e faço o merge.
