# Registro da execução `leigo_pu` (condição de prompt único, persona leiga)

Uma mensagem só, no repositório vazio `maxx-leigo-pu`, sem nenhuma resposta do autor.
Pré-registro em `docs/tcc/pre-registro-prompt-unico.md`; prompt em
`prompts/leigo/leigo_pu.md`.

| Item | Valor |
|---|---|
| Repositório | `maxx-leigo-pu`, `main`, nascido vazio (`git init -b main`), sem remoto |
| Sessão | aberta em 09/11/2026 03:11 UTC (00h11 em Brasília), prompt colado às 03:12, encerrada às 03:37 UTC |
| Modelo | `claude-opus-5-5` em todas as 117 mensagens do agente, esforço `medium`, auto mode; `/model` e `/context` conferidos antes de colar |
| Versão do CLI | 2.1.316 |
| Ambiente | Mesma máquina, em paralelo com a etapa 3 e 4 da `eng_10_mural` (decisão declarada no pré-registro, segunda alteração); o agente usou a porta 3000; sem conflito. Cabeçalho da sessão mostra "Claude Ultra" (plano da conta mudado pelo autor em 09/11; sem efeito no modelo e no esforço, confirmados no `.jsonl`) |
| Entrada humana | 1 mensagem (o prompt). Nenhuma resposta, nenhum comando além de `/export`. Nenhum pedido de aprovação do CLI |
| Evento de parada | O agente encerrou o turno com relatório de conclusão (critério 1 do pré-registro) |
| Mensagens do agente | 117; 72 usos de ferramenta; sem compactação |
| Tokens (da transcrição) | saída 283.314; cache criado 447.665; cache lido 15.016.039; entrada sem cache 234 |
| Tempo de relógio | 24 min 12 s de trabalho declarados pelo CLI; 25 min 44 s do início da sessão à parada |
| Commits do agente | 1: `ce76942` "Maxx: rede social de conquistas da UniMax", na `main`; árvore limpa depois |
| Resultado | App web instalável (PWA) em Node, sem framework, com servidor próprio em `server/`, dados de exemplo, 13 troféus e 7 tipos de medalha, acesso da banca por link com código (`?banca=`), `render.yaml` e passo a passo de deploy (GitHub, Neon, Render) deixado para o autor; 5 testes automáticos; `README.md` e `DECISOES.md` (decisões sem perguntar e o que faltou) |
| Export | `leigo_pu-sessao.txt` (766 linhas) e `leigo_pu-sessao.jsonl` (708 linhas) |

## Defeito de transmissão do prompt (declarado)

O texto chegou ao agente com os caracteres acentuados corrompidos ("O nome Ã© Maxx",
"trofÃ©us", "nÃ£o respondo"), porque o comando que o Cowork deu ao autor para copiar o
prompt (`Get-Content -Raw` sem `-Encoding UTF8`, no Windows PowerShell 5) leu o arquivo
UTF-8 como ANSI. O conteúdo ficou inteiramente legível e o agente respondeu em
português correto a todos os pontos; nenhuma palavra foi perdida ou trocada. Pelo
pré-registro, descarte só por falha de ambiente que interrompa a execução; esta não
interrompeu. A execução vale, com esta ressalva, e o texto efetivamente enviado é o do
export. Para o `eng_pu`, o comando passa a usar `-Encoding UTF8`.

## O que o agente decidiu sem perguntar (declarado em `DECISOES.md` e no relatório)

App web instalável em vez de app de loja; só e-mail da UniMax, com domínios inventados
(`@unimax.edu.br`, `@aluno.unimax.edu.br`) por não saber o real; professor precisa de
código no cadastro; só alunos publicam fotos; regra de pontos (foto +10 até três por
dia, curtida +2, medalha de +20 a +100, troféu de +15 a +200); cursos inventados; acesso
da banca por link com código e conta própria por avaliador com selo "Banca"; ranking
"de sempre" ou "do mês"; deploy em três serviços gratuitos deixado para o autor, com o
aviso de que o plano grátis "dorme".

## O que o agente declarou como faltando

Confirmação de e-mail; "esqueci minha senha"; notificações e denúncia de posts; painel
da secretaria; termos de uso e privacidade.

## Observações

- Comparar com a trilha iterativa do leigo: em 24 minutos e uma mensagem, o produto
  cobre as mesmas seis telas e, diferente da iterativa, já nasce com troféus e medalhas
  como entidades distintas, acesso da banca ligado por padrão e um registro de decisões.
  Os pontos continuam vindo de atividade no app, como na iterativa, porque o prompt não
  diz onde os prêmios nascem.
- O agente testou as telas num navegador simulando celular, nos dois temas, por conta
  própria.
- Inventário de cobertura, formulário do autor e avaliador: a fazer.
