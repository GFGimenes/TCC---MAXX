ID: eng_01_fundacao-r6
Trilha: engenheiro
Tela: passo 1 (resposta 6 do autor: revisão da etapa 5, compose com Postgres, migração, duas réplicas de API e Caddy)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisões do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Entrega: `apps/api/Dockerfile` (mesma imagem para API e migrador, usuário sem privilégio), `infra/caddy/Dockerfile` e `Caddyfile` (`/api/*` em rodízio para as réplicas descobertas pelo DNS do compose, resto estático com fallback para `index.html`), `docker-compose.yml` (postgres 18 alpine, migrador com `migrate`, duas réplicas de API que só sobem após o migrador, Caddy), `.env.example`, `.dockerignore`.
- O agente foi além do critério e testou resiliência: uma réplica parada (20 de 20 com 200), distribuição exata 10 e 10, as duas paradas (503 em 8 s), dados sobrevivendo à recriação do contêiner do Postgres, migração idempotente na segunda subida.
- No mesmo commit entraram as consequências da revisão da etapa 4: proxy de `/api` no Metro só em desenvolvimento, com aviso no código e no README, e o item dos ícones reais no plano do passo 4. O agente ofereceu separar; o autor manteve um commit por etapa.
- Três correções declaradas pelo agente e aceitas: recursão no proxy do Metro; `Gss Encryption Mode=Disable` por ruído de Kerberos do Npgsql (autor pediu comentário com o motivo no compose); `tsconfig.json` reescrito pelo `expo start`.
- Decisões do autor: `infra/` entra no mapa do repositório do `CLAUDE.md` no commit da etapa 8; só a porta 80 por enquanto, 443, HSTS e CSP no passo 13.

---
Etapa 5 aprovada. Um commit só, com a mensagem proposta: a convenção é um commit por etapa, e o proxy do Metro e o item do plano são consequência da revisão da etapa 4, então ficam juntos. Push.

Decisões: 1, infra/ entra no mapa do repositório do CLAUDE.md no commit da etapa 8. 2, só a porta 80 por enquanto; 443, HSTS e CSP ficam no passo 13, como está no plano.

As três correções do caminho aceitas: a guarda do middleware no proxy do Metro, o Gss Encryption Mode=Disable na string de conexão do compose (registra num comentário no compose o motivo, para ninguém remover achando que é sobra), e o tsconfig.json reescrito pelo Expo.

Segue para a etapa 6 e para na revisão.
