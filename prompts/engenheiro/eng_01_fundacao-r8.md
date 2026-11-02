ID: eng_01_fundacao-r8
Trilha: engenheiro
Tela: passo 1 (resposta 8 do autor: revisão da etapa 7, CI com os seis jobs)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Entrega: workflow do GitHub Actions com seis jobs (api, mobile, api-client, e2e, segurança, build), actions fixadas em versão (checkout@v7, setup-node@v7, setup-dotnet@v6, upload-artifact@v7), .NET pelo `global.json` e Node pelo `.nvmrc`; `docs/decisoes/README.md` corrigido para seis jobs (pedido na `r1`).
- O agente validou a CI no Actions antes do commit da etapa, com commits descartáveis em duas branches temporárias e três cenários: tudo verde; formato quebrado no C# e no mobile (api e mobile caem, build e e2e caem em cascata porque `dotnet publish` cobra estilo); só o contrato mudado sem regerar o cliente (só o api-client cai). Na primeira tentativa juntou as três quebras e percebeu que a prova do contrato não valia; repetiu isolado. Branches apagadas; execuções mantidas no histórico por decisão do autor.
- Achado técnico declarado: `dotnet list package --vulnerable` sai com código 0 mesmo com vulnerabilidade; o job filtra o JSON com `jq` por alto e crítico, testado com JSON sintético.
- Decisão do autor: gatilho por push em qualquer branch mais `workflow_dispatch`, sem `pull_request` (repositório sem fork; evita rodar duas vezes por commit).
- Relatório HTML do Playwright e logs do compose sobem como artefato só em caso de falha.

---
Etapa 7 aprovada. Gatilho fica como propôs: push em qualquer branch mais workflow_dispatch, sem pull_request. Repositório sem fork, então o check do push no PR basta e não rodamos a CI duas vezes. Não apaga as execuções das branches temporárias do Actions; elas são registro de que a CI discrimina. O filtro do NuGet com jq e as versões fixas das actions ficam. Commita com a mensagem proposta, push, confirma que a CI passou na branch e segue para a etapa 8; para para a minha revisão no fim dela.
