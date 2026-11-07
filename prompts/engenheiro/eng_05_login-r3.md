ID: eng_05_login-r3
Trilha: engenheiro
Tela: passo 5 (resposta 3 do autor: revisão da etapa 2, sessão e refresh serializado no cliente)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1 fechada em `c326993` com a seção "Demonstração" no termo, CI verde nos seis jobs.
- Etapa 2: `GerenciadorDeSessao` (access só em memória, uma renovação por vez, renovação antecipada a 30 s do vencimento, 401 renova e repete uma vez, `/auth/*` fora do ciclo), plataforma nativa com `expo-secure-store` e web com cookie, cabeçalho `X-Maxx-Cliente: web` e Web Locks API entre abas, `SessaoProvider` com restaurando, anônimo, autenticado e sem conexão, tabela única de código para mensagem com teste que lê `CodigosDeRecusa.cs` e `DomainExceptionHandler.cs`; 226 Jest, 25 novos, incluindo teste de contraste (sem a fila entre abas a sessão cai). Bug do agente pego pelo próprio teste (`in` aceitando `toString`), corrigido com `Object.hasOwn`. 33 achados do npm audit abaixo do corte, registrados.
- e2e com duas abas reais fica para a etapa 4, como no plano.

---
Etapa 2 aprovada. O teste que lê CodigosDeRecusa.cs e falha com código sem mensagem fica como regra. Os 33 achados do npm audit abaixo do corte ficam registrados. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 3; para para a minha revisão no fim dela.
