ID: eng_01_fundacao-r4
Trilha: engenheiro
Tela: passo 1 (resposta 4 do autor: revisão da etapa 3, cliente OpenAPI)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisões do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Entrega: OpenAPI 3.1.1 em `packages/api-client/openapi.json`, `schema.d.ts` gerado por openapi-typescript 7.13, `src/index.ts` manual sobre openapi-fetch, scripts gerar/verificar/typecheck, npm workspaces na raiz, Prettier, `.nvmrc` com Node 22, `JsonNumberHandling.Strict` na API.
- Cinco decisões declaradas pelo agente e aceitas: geração só sob demanda (o CI verifica, não gera); `JsonNumberHandling.Strict` para a API inteira; duas versões de TypeScript (6.0.3 no app, 5.9.3 no api-client por compatibilidade do gerador) sem `legacy-peer-deps`; `src/index.ts` fica como único arquivo manual do pacote, com o `CLAUDE.md` ajustado para dizer isso; Node 22 agora, com nota no plano para avaliar o 24 no passo 13.
- Endpoint `/api/openapi/v1.json` só em desenvolvimento, pedido pelo autor.
- Achados moderados do `minimatch` no `npm audit` registrados; abaixo do corte do job de segurança.

---
Etapa 3 aprovada. As cinco decisões aceitas: geração só sob demanda; JsonNumberHandling.Strict para a API inteira; as duas versões de TypeScript, sem legacy-peer-deps; src/index.ts fica no pacote, e o CLAUDE.md passa a dizer que openapi.json e schema.d.ts são gerados e nunca editados à mão, e que src/index.ts é o único arquivo manual do pacote; Node 22 agora, com nota no plano para avaliar o 24 no passo 13. Adiciona as duas linhas para servir /api/openapi/v1.json só em desenvolvimento. Os achados moderados do minimatch ficam registrados. Commita com a mensagem proposta, push, e segue para a etapa 4; para para a minha revisão no fim dela.
