# Revisor de decisões: engenheiro, export eng_07_posts-sessao.txt

- Status: a conferir (bloco JSON inconsistente: contagem.decisoes = 59, mas as listas dão 60; contagem.declaradas = 59, mas as listas dão 60; contagem.duvidosas = 5, mas as listas dão 4; export não lido inteiro: 6788 de 14167 linhas recebidas pelo revisor (faltam 5900-6839, 7000-8742, 8868-10396, 10527-11426, 11557-13823))
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\engenheiro\eng_07_posts-sessao.txt (SHA-256 e36792b9fd5084eca8de7e205876d7615162e737d95e8d3942c1071a01123bc5)
- Leitura do export: 6788 de 14167 linhas, em 8 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 81ba59b5-ae1a-4284-aaa4-c29391a37cca

Texto do revisor, sem edição:

---
Li a transcrição de forma parcial. Li por inteiro as linhas 1 a ~5.900, que cobrem o plano, as perguntas D1 a D14 e as etapas 1 a 6. Também li por inteiro todas as mensagens da persona, o relatório de cada etapa (7, 8, 9, 10 e 11), a correção da etapa 10 e o fechamento (linhas 13.824 a 14.167). Pulei, por limite de contexto, os blocos de trabalho intermediário das etapas 7 a 11: linhas ~5.900–6.840, 7.000–8.743, 8.867–10.397, 10.526–11.427 e 11.556–13.824. Esses trechos são sobretudo diffs e comandos. Decisões silenciosas que aparecem só ali podem ter ficado de fora. Pela rubrica, este export deve ficar **"a conferir"**.

## 1. Decisões tomadas sem perguntar

As decisões D1 a D14 não entram aqui: o agente as apresentou como perguntas, e a persona respondeu. Também ficam de fora o que a persona fixou: as regras da CI, a purga do upload_pendente, os chips de semestre por curso e a separação em dois commits.

Quase todas as decisões são **declaradas**, porque o agente descreve as próprias escolhas nos relatórios das etapas. Muitas foram aprovadas depois, mas a escolha foi feita e implementada antes da aprovação. A lista completa, com trecho, tipo e forma, está no JSON abaixo. Os temas principais:

- **Armazenamento e infraestrutura:**
  - perfil do compose ligado só pelo `.env.example`;
  - variáveis do bucket obrigatórias;
  - CORS e leitura anônima no bucket local;
  - variáveis `MAXX_ARMAZENAMENTO_*` em vez de `MAXX_R2_*`;
  - teste do R2 opcional por flag, no lugar do script que o plano previa.
- **Regras de produto que nenhum documento fixava:**
  - quem pode enviar foto;
  - o pedido recusado também conta no limite de taxa;
  - o professor não remove post;
  - a instituição não curte nem comenta;
  - post removido pela instituição não é afetado pela anulação da medalha;
  - edição de perfil "tudo ou nada";
  - foto de melhor esforço na demonstração.
- **Modelo de dados:**
  - remoção física pelo autor e lógica pela instituição;
  - FK sem cascata;
  - campo `postId` nos prêmios;
  - foto do autor no post, no comentário e em `/v1/eu`.
- **UX:**
  - layout da tela de novo post;
  - nome no cartão sem "@";
  - aba Perfil provisória;
  - perfil de outro aluno fora das abas;
  - linha do arroba sob o nome;
  - formatos em português do Brasil.
- **Processo no fim da sessão:** o próprio agente diz que fez três coisas "sem perguntar antes":
  - branch temporária só para rodar a CI do fix;
  - push da base `rodada/eng_07_posts`;
  - pilha `maxx` deixada rodando.

**Duvidosas:**
- a branch `feat/passo-07-posts`;
- o teste com seqscan desligado;
- o relógio de teste de 100 ms;
- a ampliação da correção dos semestres para a validação da API;
- a pilha `maxx` deixada rodando.

## 2. Perguntas à persona

- **D1 a D14 do plano:** 14 perguntas, cada uma com recomendação, todas aceitas em bloco na segunda mensagem da persona.
- **Durante as etapas:**
  - troca do MinIO, por AskUserQuestion;
  - seed da D13, por AskUserQuestion;
  - os dois modos de remoção;
  - a ordem dos comentários;
  - a conta que é professora e instituição ao mesmo tempo;
  - a barra de abas no perfil de outro aluno;
  - separar os commits;
  - rodar a suíte de novo.

Foram 22 perguntas no total, todas respondidas na própria transcrição.

```json
{
  "decisoes": [
    {"descricao": "Branch feat/passo-07-posts saindo da rodada e voltando por PR", "trecho": "Branch: feat/passo-07-posts, saindo da rodada/eng_07_posts e voltando a ela por PR.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true},
    {"descricao": "Adaptador de armazenamento com AWSSDK.S3 e dois endereços (interno e público)", "trecho": "O adaptador IArmazenamentoDeFotos na Infrastructure, com AWSSDK.S3 ... ArmazenamentoOptions com dois endereços", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Emulador num perfil do compose ligado só pelo .env.example (COMPOSE_PROFILES), com as variáveis do bucket obrigatórias e sem padrão", "trecho": "vou colocar o emulador num perfil do compose ativado só pelo .env.example, para que nunca suba na VPS", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Contêiner de inicialização com o AWS CLI 2.38.0 que cria o bucket com leitura anônima de objeto, listagem recusada e CORS só para a origem do app e o Expo", "trecho": "O init cria o bucket com leitura anônima de objeto e CORS só para a origem do app e para o Expo de desenvolvimento.", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Validação da pilha num projeto compose isolado (outra sub-rede e outras portas), sem tocar na pilha do usuário", "trecho": "vou testar só o emulador e a inicialização do bucket num projeto separado, com outra sub-rede e outra porta", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tabela upload_pendente com chaves ULID <ULID>/feed.jpg e <ULID>/grade.jpg; ULID escrito à mão, sem dependência", "trecho": "O ULID tem 80 bits de gerador criptográfico e foi escrito à mão, sem dependência nova.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Matriz de quem envia foto: post só de aluno ativo; foto de perfil de aluno, ex-aluno e professor; a instituição não envia", "trecho": "post só de aluno ativo; foto de perfil de aluno (ex-aluno inclusive) e de professor; a instituição não envia nada.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "O limite de taxa conta todo pedido de upload, inclusive o recusado", "trecho": "30 por hora por usuário, contando todo pedido, inclusive o recusado.", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "A limpeza apaga a linha antes dos objetos, e a corrida com a confirmação é decidida pelo xmin", "trecho": "Corrida com a confirmação: o xmin na linha decide.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Chave estrangeira de upload_pendente para usuario sem cascata", "trecho": "chave estrangeira sem cascata para usuario", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Frase acrescentada ao README dizendo que as fotos do bucket não saem pela purga SQL", "trecho": "Acrescentei também uma frase dizendo que as fotos do bucket não saem por esse SQL", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Remoção em dois modos: o autor apaga fisicamente; a instituição remove logicamente, com removido_em e removido_por_id (aprovada depois)", "trecho": "o autor apaga de fato, e a instituição remove logicamente, registrando quem e quando", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "O professor não remove post (403); o ex-aluno apaga o próprio post", "trecho": "Ninguém mais remove, nem o professor (403). O ex-aluno ainda apaga o próprio post.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Limites de legenda e de comentário contam emoji como um caractere", "trecho": "Legenda de até 1.000 caracteres, contando emoji como um.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Extensão da D6: na anulação, o post já removido pela instituição fica como estava", "trecho": "O post já removido pela instituição fica como estava, para não perder o registro de quem removeu.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ajudante de testes compartilhado MundoSocial", "trecho": "vou criar um auxiliar compartilhado, MundoSocial", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "A instituição não curte nem comenta (403 interacao-nao-permitida)", "trecho": "A instituição recebe 403 interacao-nao-permitida.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Comentários paginados de 20 em 20", "trecho": "Comentários do mais antigo ao mais novo, 20 por página", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cursor opaco em base64url de instante e id, sem assinatura, com a comparação de linha do Postgres", "trecho": "O cursor é opaco para o app: base64url de \"<ticks UTC>.<id>\". Não é segredo nem assinatura", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Feed em SQL direto, com md5(semente||id), COLLATE \"C\", recomendações nas posições 4, 8 e 12 e a semente sorteada na primeira página", "trecho": "com a comparação de linha, o md5 da semente e COLLATE \"C\" na ordem das chaves", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Não tratar a repetição de post ao seguir alguém no meio da sessão, porque o feed não guarda estado no servidor", "trecho": "Não tratei porque exigiria guardar os já vistos, e o feed não tem estado no servidor.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Leitura dos posts em lote (uma consulta para os posts e outra para as medalhas)", "trecho": "trocar a consulta de posts por uma versão em lote", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Teste do índice com enable_seqscan desligado; relógio do teste avançando 100 ms", "trecho": "o teste desliga a varredura (enable_seqscan = off)", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true},
    {"descricao": "Grade do perfil com 18 posts por página e busca com 20 por página", "trecho": "18 por página (seis linhas de três)", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "ETag fraca com Cache-Control: private, no-cache no perfil", "trecho": "ETag fraca calculada do conteúdo e Cache-Control: private, no-cache", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conta só de instituição sem perfil social (404)", "trecho": "Conta só de instituição: não tem perfil social e recebe 404.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Edição de perfil tudo ou nada; trocar e remover a foto no mesmo pedido recebe 400", "trecho": "a edição é tudo ou nada ... Trocar e remover no mesmo pedido recebe 400 foto-de-perfil-ambigua", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Foto de perfil (derivada da grade) no autor do post, no autor do comentário e em /v1/eu", "trecho": "Avatar em todo lugar: a derivada da grade aparece no autor do post e do feed, no autor do comentário e no GET /v1/eu.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Função imutável maxx_sem_acento e índices GIN de trigramas no nome e no prefixo; % e _ tratados como texto", "trecho": "uma função imutável maxx_sem_acento, porque o unaccent sozinho não pode entrar em índice", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "BuscarComPrefixosAsync só para a edição, sem Include nas outras buscas", "trecho": "Criei BuscarComPrefixosAsync, usado só pela edição", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Layout da tela de novo post: área quadrada de foto, Trocar e Remover foto, contador 45/1.000, prêmio por concessão desmarcável, volta ao início depois de publicar", "trecho": "Foto: área quadrada em cima, como no \"novo post\" do Instagram.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Botão provisório \"Novo post\" no início até a etapa 8", "trecho": "Entrada: botão \"Novo post\" no início provisório, só para aluno", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Derivadas sem ampliar foto menor e segunda tentativa mais comprimida quando passam do limite", "trecho": "Se uma derivada passar do limite da API, uma segunda tentativa mais comprimida", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Reaproveitar o upload já feito quando a publicação falha, sem gastar o limite", "trecho": "a nova tentativa reaproveita o upload já feito, sem gastar outro pedido do limite", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Campo postId nos prêmios de /v1/eu/premios", "trecho": "API, um campo novo: postId em cada prêmio obtido de /v1/eu/premios", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Plugin do seletor no app.json com texto de permissão em português e sem câmera; ícones do Lucide", "trecho": "o app.json ganhou o plugin do seletor, com texto de permissão em português e sem câmera", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "HEIC na web sem conversão, com mensagem amigável", "trecho": "HEIC na web: o Chrome não abre HEIC. Quem escolher um vê \"Não deu para abrir essa foto.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Nome no cartão do feed sem @ e sem sufixo", "trecho": "Nome de usuário: o arroba sem \"@\" e sem sufixo (anaSouza)", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Faixa do prêmio refeita, com matéria e bimestre numa linha de detalhe sob o tier", "trecho": "A comparação me fez corrigir a faixa do prêmio.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Menu \"...\" só para o autor e a instituição, com confirmação na folha; a instituição não vê o coração", "trecho": "Menu \"...\": só para o autor (\"Apagar post\") e para a instituição (\"Remover post\")", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Números no formato brasileiro e tempo relativo (\"há 2 horas\")", "trecho": "tempo (\"há 2 horas\"). Números no formato brasileiro.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Retorno depois do login restrito a /post/:id e aos comentários dele", "trecho": "O retorno aceita só /post/:id e os comentários dele. ... Restringi.", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Aba Perfil provisória até a etapa 9, com tema, Minhas turmas e Sair", "trecho": "O início provisório virou a aba Perfil até a etapa 9", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Linha do arroba sob o nome no perfil, fora da prancheta", "trecho": "Linha do arroba: a prancheta não tem; incluí sob o nome", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Perfil de outro aluno em /usuarios/:id, fora das abas, com voltar", "trecho": "Perfil de outro sem a barra de abas: ele abre em /usuarios/:id, fora das abas, com voltar.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Professor escolhe a turma antes de conceder medalha quando o aluno está em mais de uma; perfil do professor sem pontos e sem abas", "trecho": "Se o aluno estiver em mais de uma turma dele, o professor escolhe a turma antes.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Botão Editar perfil abrindo \"Em breve.\" até a etapa 10", "trecho": "até lá o botão abre um \"Em breve.\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Paliativo test.slow() no e2e de medalha (aceito depois)", "trecho": "marquei só esse caso com test.slow() (limite de 90 s)", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Nova rota GET /v1/cursos para os chips da busca", "trecho": "API: GET /v1/cursos (sigla e nome, por sigla), para os chips.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Busca com debounce de 500 ms reaproveitado do cadastro", "trecho": "consultado 500 ms depois que a digitação para (o mesmo debounce do cadastro, agora exportado)", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Foto da demonstração de melhor esforço: se falhar, a pessoa entra assim mesmo", "trecho": "É de melhor esforço: se o envio falhar (429, rede), a pessoa entra do mesmo jeito", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Salvar desativado sem mudança, envio só do que mudou, prefixo atual não consultado", "trecho": "Salvar: fica desativado sem mudança ou com erro, manda só o que mudou e volta.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Remoção do teto de 8 na validação de semestre da API de busca, além dos chips pedidos", "trecho": "a busca só recusa valores menores que 1 e o teto de 8 sai do código", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Grupo (app) trocado de Slot para Stack e replace por dismissTo; hook useDestinoDepoisDoLogin", "trecho": "Fix: (app) is now a Stack with no header, so the tabs stay mounted underneath.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Seed e anulação no e2e por docker compose exec no worker, com a remoção do test.slow()", "trecho": "the seed and the annulment now run with docker compose exec -T worker", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Verificação do R2 como classe de teste opcional (MAXX_VERIFICAR_R2=1), no lugar do script previsto", "trecho": "Off by default. It runs only with MAXX_VERIFICAR_R2=1", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Variáveis de produção MAXX_ARMAZENAMENTO_* em vez de MAXX_R2_*", "trecho": "the environment variables are MAXX_ARMAZENAMENTO_* ... not MAXX_R2_* as I wrote there", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Push numa branch temporária ci/passo-07-fix-mobile só para rodar a CI do fix, apagada depois", "trecho": "enviei ele numa branch temporária (ci/passo-07-fix-mobile) e apaguei essa branch", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Push da branch base rodada/eng_07_posts ao remoto para abrir o PR", "trecho": "A base rodada/eng_07_posts existe só localmente ... Vou enviá-la sem alterações", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Pilha maxx deixada rodando depois do reinício do Docker", "trecho": "Deixei rodando, porque a suíte usa os próprios Postgres", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true}
  ],
  "perguntas": [
    {"texto": "D1. Emulador: MinIO na última tag comunitária, ou Garage/SeaweedFS?", "respondida": true},
    {"texto": "D2. Formato: só image/jpeg, feed 1080×1080 até 1 MB, grade 320×320 até 200 KB, recorte quadrado central?", "respondida": true},
    {"texto": "D3. Tempos: assinatura de 15 min, limpeza em 24 h, HEAD na criação, remoção pela fila?", "respondida": true},
    {"texto": "D4. Limite de upload: manter 30 por hora por usuário?", "respondida": true},
    {"texto": "D5. Post: legenda até 1.000, comentário até 500, não editável, o autor apaga, o prêmio fica livre?", "respondida": true},
    {"texto": "D6. O que acontece com o post quando a medalha é anulada?", "respondida": true},
    {"texto": "D7. Instituição no app: remoção de post e comentário já no passo 7, ou só API e comando administrativo?", "respondida": true},
    {"texto": "D8. Feed: páginas de 12, 3 para 1, opção A (hash da semente) ou B? Quero o seu aval explícito.", "respondida": true},
    {"texto": "D9. Regras de quem segue quem?", "respondida": true},
    {"texto": "D10. Perfil: tirar bio, \"Seguida por\" e Compartilhar; conteúdo das abas e da grade; perfil do professor?", "respondida": true},
    {"texto": "D11. Busca: por trecho, sem acento, ativos e ex-alunos, mínimo de 2 caracteres?", "respondida": true},
    {"texto": "D12. Incluir \"Remover foto\" e a foto opcional no registro da demonstração?", "respondida": true},
    {"texto": "D13. Semear posts sem foto para os 20 alunos do mundo de demonstração?", "respondida": true},
    {"texto": "D14. Registrar que as fotos de demonstração saem na purga da área web, no passo 12?", "respondida": true},
    {"texto": "A D1 (MinIO) não se sustenta... Qual entra no compose e no Testcontainers? (VersityGW ou outra)", "respondida": true},
    {"texto": "A D13 esbarra numa regra existente (alunos sem conta). O que faço na etapa 5?", "respondida": true},
    {"texto": "Uma escolha de implementação da D5 e da D7 para você aprovar: autor apaga de verdade, instituição remove de forma lógica", "respondida": true},
    {"texto": "Confirmar: ordem dos comentários do mais antigo ao mais novo", "respondida": true},
    {"texto": "Confirmar: conta de professor e instituição segue, curte e comenta como professora", "respondida": true},
    {"texto": "Perfil de outro sem a barra de abas: se você preferir com a barra, é uma troca de pasta da rota", "respondida": true},
    {"texto": "If you'd rather keep them apart, I can split them into a separate fix(mobile) commit.", "respondida": true},
    {"texto": "The full API suite still needs to run once before the commit. If you say so, I'll rerun it", "respondida": true}
  ],
  "contagem": {"decisoes": 59, "declaradas": 59, "silenciosas": 0, "duvidosas": 5, "perguntas": 22, "perguntas_respondidas": 22}
}
```
