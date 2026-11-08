# Registro da rodada `leigo_00_abertura` (trilha do leigo)

Abertura da trilha: a ideia inteira numa mensagem de 481 caracteres, sem regra de
negócio, sem termo técnico.

| Item | Valor |
|---|---|
| Repositório e branch | `maxx-leigo`, `rodada/leigo_00_abertura` (saída da semente `1577ae9`) |
| Sessão | aberta em 08/11/2026 19:04 UTC, prompt colado às 19:06, encerrada às 19:19 UTC |
| Modelo | `claude-opus-5-5` em todas as 57 mensagens do agente, esforço `medium`, auto mode; `/model` conferido antes do prompt |
| Versão do CLI | 2.1.316 |
| Ambiente | Mesma máquina que a `eng_08_premios`, em andamento em paralelo (decisão de prazo, diário de 08/11). O agente escolheu a porta 3000; nenhum conflito com a pilha do engenheiro |
| Prompts do autor | `leigo_00_abertura`, texto congelado em 11/10/2026, enviado idêntico |
| Turnos humanos | 2: a abertura e "pode ir" (política de reação, confirmação para commitar) |
| Mensagens do agente | 57; 29 usos de ferramenta |
| Tokens (da transcrição) | saída 175.079; cache criado 199.534; cache lido 4.857.568; entrada sem cache 122 |
| Tempo de relógio | 8 min 33 s de trabalho até devolver a palavra; 13 min até o commit |
| Commits do agente | 1: `c446038` "Primeira versão do Maxx, a rede social da UniMax", feito depois do "pode ir" |
| Commits do autor | `rodada/leigo_00_abertura` → `main` com `--no-ff` (`3fdcf1c`) |
| Resultado | App web em Node 22 com Express, SQLite nativo em arquivo (`dados/maxx.db`), HTML renderizado no servidor, CSS próprio, teste automático dos fluxos (`node --test`), script de dados de exemplo; sem framework de front, sem Docker, sem CI |
| Export | `leigo_00_abertura-sessao.txt` (438 linhas) e `leigo_00_abertura-sessao.jsonl` |

## O que saiu

Login e cadastro por e-mail `@unimax.edu.br` sem verificação; feed com post de foto ou
texto, curtida e comentário; perfil; medalha dada pelo professor no perfil do aluno com
mensagem; ranking geral e por curso só de alunos; mural com aviso fixado; administração
pela conta da faculdade (`admin@unimax.edu.br`, senha padrão `unimax-admin` no README).
README em português com passo a passo.

## Perguntas do agente e respostas do autor

- Nenhuma pergunta antes de construir. No fim, ofereceu commitar e "mudar o que não
  ficou do seu jeito": o autor respondeu "pode ir" (política), e o agente commitou.
- Depois do commit, ofereceu três próximos passos (confirmação de e-mail, hospedagem,
  mudanças): sem resposta; a rodada encerrou.

## Decisões do agente sem o prompt pedir

Silenciosas ou declaradas só no relatório final, todas regra de produto ou técnica que
o prompt não determinou: pontos por atividade dentro do app (+10 post, +2 curtida
recebida, +3 comentário em post de colega), e não por eventos ou méritos da faculdade;
medalhas de professor como catálogo fixo com mensagem, valendo 20 a 50 pontos;
conquistas com bônus (primeiro post, 50 curtidas, 5 medalhas); só alunos no ranking;
professor definido pela administração; login por domínio de e-mail sem verificação;
admin com senha padrão; app web em vez de app de celular; SQLite em arquivo; porta
3000; sem hospedagem.

## Observações

- O prompt dizia "premios pelas coisas que fizesse" sem dizer onde; o agente leu como
  atividade no app. A ideia de prêmio por evento, palestra e apresentação, presente na
  trilha do engenheiro, não existe aqui porque ninguém a contou. Achado central para a
  comparação de conteúdo entre personas.
- O agente declarou que não olhou as telas no navegador, só por script, e pediu ao
  autor que avisasse se algo ficasse estranho.
- Parte da narração do agente saiu em inglês ("I'll write the files...", "Now the
  screens"), sem compactação; terceira ocorrência do padrão no experimento.
- O agente listou sozinho três limites antes de "liberar para a faculdade": confirmação
  de e-mail, hospedagem, senha do admin.
