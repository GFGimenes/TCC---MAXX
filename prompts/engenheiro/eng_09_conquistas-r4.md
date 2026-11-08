ID: eng_09_conquistas-r4
Trilha: engenheiro
Tela: passo 9 (resposta 4 do autor: fix do tempo limite do Jest na CI e revisão da etapa 3, recálculo na anulação)
Data: 2026-11-08
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 2 commitada em `43d0f64`; job mobile vermelho em três tentativas, sempre o mesmo teste (`comprovacoes.test.tsx`, primeiro do arquivo, carga de módulos acima dos 5 s do Jest no runner), commit só de API e docs. Agente investigou (não é data, é custo de carregamento), registrou o risco no plano mestre e propôs `fix(mobile)` com `testTimeout` global de 15 s. Pela regra do passo 3, a etapa 2 não está pronta até a CI verde, e a etapa 3 ficou sem commit.
- Etapa 3 pronta localmente: `AnularMedalhaHandler` enfileira `recalcular-conquistas-da-medalha`; handler novo trava o aluno, refaz o progresso, reavalia só as conquistas com a medalha nas evidências, remove a insatisfeita com notificação e recálculo de raridade; `DescreverMedalha` no domínio; `ContextoDasConquistas` compartilhado; 5 testes de integração e 1 de domínio; suíte 1006.
- Decisões do autor: fix com limite global de 15 s em commit separado (o problema já pegou três arquivos); a anulação nunca concede, e mudança de catálogo não remove conquista; etapa 3 commitada só depois da CI verde do fix.

---
Fix aprovado com o limite global de 15 s, em commit separado, com a linha do risco junto; commita, push e acompanha a CI; só com ela verde a etapa 2 fecha. Etapa 3 aprovada, com a decisão aceita: a anulação nunca concede, e mudança de catálogo não remove conquista. Depois do fix verde, commita a etapa 3 com a mensagem proposta, push, acompanha a CI e segue para a etapa 4; para para a minha revisão no fim dela.
