# Registro da rodada `eng_03_auth` (trilha do engenheiro)

Passo 3 do plano mestre: autenticação e autorização. Rodada mais longa até aqui, em
duas noites, com três interrupções de ambiente.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-engenheiro`, `rodada/eng_03_auth` (saída da `main` em `a84a868`); trabalho em `feat/passo-03-auth` |
| Sessão | `6bcebf88-d5de-4e57-b310-ecac3a872113`, aberta em 04/11/2026 00:03 UTC, encerrada em 05/11/2026 01:15 UTC |
| Modelo | `claude-opus-5-5` em todas as 737 mensagens do agente, esforço `medium`, auto mode (igual ao ambiente fixo). `/model` na abertura registrou "Kept model as Opus 5.5" |
| Versão do CLI | **2.1.316** do início ao fim. O CLI atualizou entre a `eng_02_dados` e esta sessão apesar de `DISABLE_AUTOUPDATER=1` (provável instalação por janela sem a variável). Declarada a partir desta rodada; modelo e esforço, que são o que se compara, não mudaram |
| Interrupções | (1) Janela do CLI fechada sem querer depois do export da E6; retomada com `claude --resume` na mesma sessão; o CLI mostrou "Compacted while idle" (compactação automática do contexto) e, a partir daí, a primeira frase de cada entrega saiu em inglês. (2) Docker Desktop parado na primeira entrega da E4 e reiniciado sozinho na E8. (3) Disco C: com 0 GB livres na E9; o agente parou sem commitar, diagnosticou e esperou; o autor liberou espaço fora do experimento |
| Prompts do autor | `eng_03_auth` (abertura), `eng_03_auth-r1` (plano) a `r13` (PR e encerramento): 14 textos; mais duas mensagens curtas de retomada de ambiente ("Docker de pé", "Disco liberado"), não numeradas |
| Turnos humanos | 17 mensagens de conteúdo, mais `/model` e 12 `/export` |
| Mensagens do agente | 737 (inclui uso de ferramenta); 361 resultados de ferramenta |
| Tokens (da transcrição) | saída 1.272.646; cache criado 1.802.291; cache lido 182.009.190; entrada sem cache 1.528 |
| Tempo de relógio | Duas noites: 03/11 21:03 a 04/11 00:10 e 04/11 20:15 a 22:15 (horário de Brasília), cerca de 5 h 10 min de sessão ativa |
| Commits do agente | 13: onze etapas (`c373c3e`, `7c896cd`, `2ef32f6`, `1e76bcc`, `7ca81a5`, `733ddcf`, `95b942e`, `27a3a2c`, `6ff97f4`, `15ff8f3`, `4815990`), docs de fechamento (`1757fbd`) e exceção do gitleaks (`46e5bd5`), sem rodapé de co-autoria |
| Commits do autor | 2 merges: PR #4 (`11bf764`) e `rodada/eng_03_auth` → `main` com `--no-ff` (`5b7cb45`) |
| Merge | PR #4 `feat/passo-03-auth` → `rodada/eng_03_auth`, 13 commits, seis checks verdes; depois `main` |
| Resultado | 94 arquivos, 11.778 linhas; 450 testes (domínio, arquitetura e integração com Postgres real, SMTP real contra Mailpit) |
| Export | `eng_03_auth-sessao-parte1.txt` (3.682 linhas, até a E6, antes da compactação) e `eng_03_auth-sessao.txt` (3.368 linhas, histórico compactado mais o restante); `eng_03_auth-sessao.jsonl` (3.868 linhas, íntegro) |

## O que saiu

Domínio de identidade (usuário 1:1 com o cadastro elegível, prefixo de arroba com
sugestão e reserva permanente, sufixo por papel, política de senha, família de sessão
com refresh rotativo e detecção de reuso, recuperação de senha), migrations
`Identidade` e `Demonstracao`, Argon2id (PHC, OWASP, NFC), JWT HS256 de 15 minutos só
com sub e papel, cadastro com sugestão e disponibilidade de arroba, login por RA ou
e-mail com respostas e custo iguais, refresh e logout, cookie HttpOnly na web e corpo no
nativo, policies por papel com `/v1` fechado por padrão, escopo de turma do professor
checado no banco no semestre vigente, recuperação de senha por e-mail (MailKit, fila em
memória, Mailpit no compose, token no fragmento do link), modo de demonstração atrás de
flag (rotas nem mapeadas quando desligada, chave de dispositivo, lote, purga por lote),
limite de taxa nativo por identificador, RA, e-mail e IP real do Caddy. Docs: `produto.md`
2.3.1, 2.5 e 11, README de decisões com seção de autenticação e tabela de limites, fluxo
06 novo, códigos HTTP nos fluxos 01 e 06, passo 5 do plano mestre com serialização do
refresh, debounce do arroba e tela `/redefinir-senha`.

## Perguntas do agente e respostas do autor

- Plano: onze etapas e onze decisões com recomendação; todas aceitas. `r1`.
- E1 (docs): 3 consequências. `r2`. E2: 5 comportamentos, limite de 60 no nome. `r3`.
  E3: 4 pontos, invalidação dos resets pendentes. `r4`. E4: entregue duas vezes (Docker
  parado), `prefixo_reservado`. `r5`. E5: 3 desvios, 5 decisões, NFC. `r6`. E6: 4
  decisões. `r7`. E7: 7 decisões. `r8`. E8: 3 desvios, 3 decisões (FallbackPolicy
  quebraria o 404 da demonstração). `r9`. E9: disco cheio, depois 7 decisões. `r10`.
  E10: 7 decisões, purga. `r11`. E11: 7 decisões, a quarta decidida pelo autor (60 por
  minuto por IP em sugestão e disponibilidade). `r12`. PR: `r13`.

## Decisões do agente sem o prompt pedir (declaradas)

Etapa inicial só de docs; unicidade do arroba pelo prefixo; `prefixo_reservado` com o
prefixo como chave primária; xmin como token de concorrência; ProblemDetails com
`codigo` em kebab-case; cabeçalho `X-Maxx-Cliente`; refresh simultâneo contado como
reuso; `/v1` fechado no grupo em vez de FallbackPolicy; `/v1/eu` lendo do banco; rotas de
teste no host de teste; token de recuperação no fragmento do link; rotas de demonstração
não mapeadas com a flag desligada; `docker-compose.demo.yml`; limite por filtro de
endpoint; `.gitleaksignore` delimitado; dois itens extras no passo 5 do plano mestre;
publicação da `rodada/eng_03_auth` no remoto para o PR ter base.

## Observações

- Falha de processo declarada pelo próprio agente no fechamento: não conferiu a CI a
  cada push, e a E9 e a E10 ficaram vermelhas no gitleaks (falso positivo numa senha de
  teste) até o fim. O autor fixou a regra para as próximas rodadas: etapa só é dada como
  pronta com a CI do push verde e o resultado no relatório.
- O agente corrigiu a própria contagem de testes da E9 sem ser perguntado.
- O agente subiu o Docker Desktop sozinho na E7 e recriou o contêiner do Caddy na E8;
  no disco cheio, não liberou nada por conta própria porque as imagens podiam ser de
  outros projetos do autor.
- Efeitos da compactação automática: primeira frase das entregas em inglês da E7 em
  diante; o `/export` passou a gravar o histórico compactado, por isso o export ficou em
  duas partes (o `.jsonl` é íntegro).
- Itens deixados para passos futuros: serialização do refresh, debounce do arroba e
  tela `/redefinir-senha` (passo 5); fila do Postgres para o e-mail (passo 6); limite de
  upload (passo 7); provedor SMTP da VPS e porta 443 (passo 13).
