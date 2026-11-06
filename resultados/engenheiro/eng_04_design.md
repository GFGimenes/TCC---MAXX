# Registro da rodada `eng_04_design` (trilha do engenheiro)

Passo 4 do plano mestre: design system. Primeira rodada com peso visual e primeira
inteira sob a regra da CI verde por etapa.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_04_design` (saída da `main` em `5b7cb45`); trabalho em `feat/passo-04-design-system`; correção em `fix/demonstracao-registro-simultaneo` (PR #5) |
| Sessão | `1b9eb21c-2a7a-43c5-840d-e810444ce321`, aberta em 06/11/2026 00:41 UTC, encerrada em 06/11/2026 22:16 UTC |
| Modelo | `claude-opus-5-5` em todas as 407 mensagens do agente, esforço `medium`, auto mode; `claude --version` e `/model` conferidos antes do primeiro prompt |
| Versão do CLI | 2.1.316 do início ao fim |
| Interrupções | Esc acidental do autor durante a etapa 1 (retomada com mensagem curta); Docker Desktop parado na etapa 4 (reiniciado pelo autor) e reiniciado pelo próprio agente na etapa 5, com aviso; duas compactações automáticas do contexto em espera ("Compacted while idle"), sem perda no export |
| Prompts do autor | `eng_04_design` (abertura), `eng_04_design-r1` (plano) a `r13` (PR e encerramento): 14 textos; mais uma mensagem curta de retomada após o Esc |
| Turnos humanos | 15 mensagens de conteúdo, mais `/model` e 13 `/export` |
| Mensagens do agente | 407 (inclui uso de ferramenta); 250 resultados de ferramenta |
| Tokens (da transcrição) | saída 1.322.989; cache criado 2.377.757; cache lido 99.689.109; entrada sem cache 888 |
| Tempo de relógio | Duas sessões de trabalho: 05/11 21:41 a 06/11 00:50 e 06/11 12:20 a 19:16 (horário de Brasília), cerca de 10 h ativas, com etapas de 20 a 30 minutos por causa das capturas e dos e2e |
| Commits do agente | 11: oito etapas (`858a532`, `f442155`, `1467003`, `a51dc0d`, `48814a9`, `d4257ef`, `be81c9d`, `b992ab3`), correção do passo 3 (`eb660d3`, PR #5), ajuste do teste de fontes (`46944ad`) e merge da rodada na feat (`adfae37`), sem rodapé de co-autoria |
| Commits do autor | Merges dos PRs #5 (`e88b977`) e #6 (`22d4ead`) e dois merges `--no-ff` na `main` com a mesma mensagem (`8457c92`, só com o PR #5, e `3818816`, com o resto), porque o comando foi executado antes e depois do merge do PR #6 |
| Merge | PR #6 `feat/passo-04-design-system` → `rodada/eng_04_design`, CI verde; depois `main` em `3818816` |
| Resultado | 79 arquivos e 5.038 linhas no PR #6, mais 7 arquivos no PR #5; 201 testes Jest e 20 e2e no mobile; 450 testes na API |
| Export | `eng_04_design-sessao.txt` (5.471 linhas, completo) e `eng_04_design-sessao-parte1.txt` (cópia de segurança antes da compactação); `eng_04_design-sessao.jsonl` (2.839 linhas) |

## O que saiu

Tema com tokens tipados conferidos contra o `tokens.json`, troca Sistema/Claro/Escuro
persistida, cor literal como erro de lint; Archivo instanciada em 112% e Instrument Sans
por script reprodutível em contêiner, TTFs e licenças OFL no repo, `FontGate`; ícones
do Lucide num componente próprio sobre `react-native-svg`, `Screen` com a grade da
identidade, vitrine só em desenvolvimento; `Button`, `TextField`, `SegmentedControl`,
`FilterChip` com estados; `BottomNav` com bolinha de novidade acessível, `Avatar`,
`EmptyState`, `ErrorState`; `Medalhao`, `SeloPremio`, `FaixaPremio`, `TrilhaFamilia`
com teste de regra de gradiente e sombra; logo vetorizado do PNG (potrace, cortes do
XX reabertos), ícone, adaptativo, splash e favicon gerados por script; identificador
`tech.gimenes.maxx`. Correção do passo 3 no registro simultâneo de demonstração (PR #5).
Docs: seção "Design system (passo 4)" no README de decisões, `design/README.md` com a
procedência do SVG, `apps/mobile/README.md`.

## Perguntas do agente e respostas do autor

- Plano: oito etapas e dez decisões (cinco sem doc, cinco contradições entre fontes de
  design). `r1`, com vetorização do logo e recorte do XX decididos pelo autor.
- Etapa 1: 1 ponto. `r2`. Etapa 2: CI vermelha da etapa 1 por defeito intermitente do
  passo 3, PR separado com traço do autor; 3 ressalvas. `r3`. PR #5 e etapa 3. `r4`.
  CI das etapas 1 a 3 verde. `r5`. Etapa 4: 7 decisões. `r6`. Etapa 5: 6 decisões. `r7`.
  Etapa 6: 9 decisões. `r8`. Etapa 7 em três paradas: SVG (`r9`), correção do XX
  apontada pelo autor (`r10`, `r11`), ícones e identificador (`r12`). PR: `r13`.

## Decisões do agente sem o prompt pedir (declaradas)

Ícones próprios em vez do pacote Lucide (glossário e bundle); vitrine em `__DEV__`;
cor literal como erro de lint; `FontGate`; `detailColor` nos ícones preenchidos;
`aboveNav` no `Screen`; `outline-style: none` por cima do anel de foco; teste de regra
de gradiente e sombra; `StateMessage` compartilhado; tolerância do teste de fontes;
`.gitattributes` para TTF; remoção do `android-icon-background.png`; reinício do Docker
Desktop na etapa 5; dezenas de medidas estimadas pela prancheta, todas listadas e
aceitas.

## Observações

- A regra da CI verde por etapa pegou um defeito real do passo 3 na primeira aplicação:
  o agente não reexecutou a CI, investigou, mostrou que já falhava na `main` e propôs o
  PR separado. Defeito que atingiria a banca (duas pessoas de mesmo nome entrando
  juntas).
- Ao longo da rodada o agente declarou o que não verificou em cada etapa: nada rodou em
  Android ou iOS; componentes da vitrine só têm Jest e capturas até uma tela real; Archivo
  em produção; intermitências locais sem causa (npm ci, Jest sem memória, Docker).
- O autor fez três aprovações visuais (SVG, SVG corrigido, prancha de ícones) e apontou
  um defeito que as métricas do agente (IoU 98,97%) não mostravam: os dois X fundidos no
  cruzamento. Primeiro caso na trilha de revisão por olho do autor mudando o resultado.
- Disco: depois da rodada o C: estava de novo em 14,7 GB livres (31 GB antes dela). `docker system df` mostrou 15,45 GB de cache de build do compose (249 entradas, nenhuma em uso); limpo com `docker builder prune -a -f`, volumes e imagens intactos. Causa provável do disco cheio na `eng_03_auth`: cada `docker compose up --build` do agente acumula camadas. Rotina adotada: `docker builder prune -f` antes de abrir sessão.
- A `main` ficou com dois merges de mesma mensagem por um comando repetido do autor;
  mantido como está.
- Itens para passos futuros: erro de campo, mensagem de `registro-simultaneo`,
  serialização do refresh, debounce do arroba e tela `/redefinir-senha` (passo 5);
  controle de tema no perfil (passo 7); anel dourado do próprio aluno (passos 7 e 11);
  conferência em emulador Android e iOS (a relatar à parte).
