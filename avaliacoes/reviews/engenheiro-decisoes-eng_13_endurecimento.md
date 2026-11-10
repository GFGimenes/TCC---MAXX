# Revisor de decisões: engenheiro, export eng_13_endurecimento-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\repos\tcc\resultados\engenheiro\eng_13_endurecimento-sessao.txt (SHA-256 5e4266f52f13ce9c9465205591d0edc5e8a4b07d5b30ebe05a047dbc42e44b22)
- Leitura do export: 6350 de 6350 linhas, em 7 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 33e6ca8d-c565-4424-87f8-89ea1157da35

Texto do revisor, sem edição:

---
Li a transcrição inteira (6.350 linhas, em partes). Contei como determinado pela persona o que estava no plano que ela aprovou ("Plano aprovado com uma mudança de ordem e alguns cortes") e nas respostas dela. Por isso, os detalhes que já estavam no plano ficaram fora da lista: limites de 2 min, 5 min e 24 h da saúde do worker, compose de produção, tags do GHCR, timer às 03:00, dump antes do migrator, comparação exata de domínio. Também ficaram fora as escolhas que o agente informou e a persona aprovou antes de serem executadas. A exceção é o método do k6, que ela aprovou depois de o roteiro estar escrito; ele não entrou na lista, mas a assinatura de tokens na VPS e o auto_explain são decisões do agente que ela ratificou só depois.

## 1. Decisões tomadas sem perguntar

**Hospedagem e deploy**
- Renomeou as imagens para `maxx-engenheiro-api` e `maxx-engenheiro-caddy`, em vez de `maxx-api` e `maxx-caddy` (declarada).
- Publicou com `docker build --provenance=false` para ligar o pacote ao repositório (declarada).
- Limitou o log de cada contêiner a 5 arquivos de 10 MB (declarada).
- Criou no `.gitignore` uma exceção para o `.env.producao.example` (silenciosa).
- Fez a primeira subida na VPS com a sha-c1f2b77, só com o seed base, antes da troca dos e-mails (declarada).
- No backup, escolheu `pg_dump -Fc`, nome com instante UTC e rótulo, conferência com `pg_restore --list` antes do nome final, pasta 700 de root e timer `Persistent` (silenciosa).
- O `deploy.sh` baixa compose e scripts do raw.githubusercontent no mesmo commit, confere o `.env`, troca a si mesmo com `mv` e espera o `/api/ready` (declarada).
- Montou um encadeamento que só implanta se a publicação terminar verde (declarada).
- Escreveu uma rotina de purga em `operacao.md` que desliga a demonstração antes e espera a fila esvaziar (silenciosa).

**Segurança**
- Na verificação do R2, filtrou só as linhas `MAXX_ARMAZENAMENTO_*` para um arquivo temporário com umask 077 (declarada).
- Acrescentou cabeçalhos e diretivas que o plano não previa: X-Frame-Options, COOP, remoção do `Server`, font, worker e manifest-src, form-action (silenciosa).
- Configurou o HSTS com um ano, sem subdomínios nem preload (silenciosa).
- Liberou `style-src 'unsafe-inline'` (declarada; **duvidosa**, porque o plano aprovado já previa o risco).
- Rodou o Trivy com `--ignore-unfixed` e com a varredura de segredos (declarada).
- Pôs `apt-get upgrade` no estágio final da imagem da API (declarada).
- Limitou a exceção do Trivy ao binário do Caddy (declarada; **duvidosa**).
- Rodou o contêiner do k6 como root (declarada).

**Regra de produto**
- Usou dois códigos de recusa: `email-fora-da-faculdade` no cadastro e `dominio-nao-aceito` na correção. O plano previa um código só (declarada).
- Aplicou a checagem de domínio também na sugestão e na disponibilidade do arroba, antes da consulta à base (declarada).

**Stack e arquitetura**
- Usou `UseChunkEncoding = false` no envio ao R2 (declarada).
- Pôs a lista de domínios no `appsettings.json`, igual em todo ambiente. A API não sobe com ela vazia, e não há lista separada para teste. O plano previa o `@maxx.test` só na configuração de teste (declarada).
- O batimento do worker é gravado no máximo a cada 15 s (silenciosa).
- Uma falha ao gravar o batimento só gera aviso no log e o laço segue (silenciosa).
- A `fila-parada` conta a partir do que vier depois entre a chegada e a disponibilidade do trabalho (silenciosa).
- Definiu o formato da resposta do `/health/worker`: campos, códigos de problema e 503 com o mesmo corpo (silenciosa).

**Modelo de dados**
- A tabela `batimento_do_worker` tem a restrição `id = 1` (declarada).
- A janela de trabalho falho usa o `disponivel_em`, sem coluna nova (declarada).

**UX e visual**
- Na correção do passo 6, tocar de novo no prêmio escolhido devolve a lista. Nome e datas ficam, evento e matéria saem, e a correção vale também para a concessão direta da instituição (declarada).

**Testes e processo**
- Mudou o `concurrency` da CI para ref mais evento (declarada).
- Criou um teste de envio direto no `VerificacaoDoR2Tests`, com prova reversa na VPS (declarada).
- Parou o worker em produção para provar o alerta (declarada).
- Fixou o Trivy na v0.76.1 com checksum, pelo critério de ter mais de duas semanas (declarada).
- O laço do Trivy varre as duas imagens antes de falhar (declarada).
- Fixou o k6 na 1.8.2 (declarada).
- Descartou 20 s de aquecimento antes da medida (declarada).
- Pôs no k6 os limites de p95 abaixo de 300 ms por rota e de falha abaixo de 1% (silenciosa).
- Rodou EXPLAIN com `enable_seqscan = off` (declarada).
- Registrou a escolha dos índices com volume real como pendência fora da fase 1 (declarada; **duvidosa**).
- Gravou logs e `docker stats` a cada 10 s durante o ensaio (declarada).
- Fez a captura com um spec temporário do Playwright, nos dois temas (declarada).
- Atualizou os comentários que falavam do "passo 13" como futuro (declarada).
- Publicou no remoto a branch `rodada/eng_13_endurecimento` como base do PR (declarada).

## 2. Perguntas feitas à persona

Foram 16, todas respondidas na transcrição:
- As 10 perguntas do plano: e-mails do seed, textos do código e produto.md, bucket de backup, alerta, imagens antes da main e visibilidade do pacote, papel `maxx_app`, contas e volume do k6, de onde roda o k6, Trivy e Node 24.
- O que fazer depois que a suíte no Node 24 parou por falta de memória.
- Qual opção para a CVE do Caddy.
- Confirmar o lote do ensaio.
- Se o e-mail de primeiro acesso da coordenação chegou.
- O que fazer com o cache da CDN depois da purga.
- Se ajustava o CLAUDE.md.

```json
{
  "decisoes": [
    {"descricao": "Renomeou as imagens do GHCR para maxx-engenheiro-api e maxx-engenheiro-caddy, em vez de maxx-api/maxx-caddy do plano", "trecho": "vou renomeá-lo para maxx-engenheiro-api e maxx-engenheiro-caddy para não colidir com o outro repositório do TCC", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Publicação das imagens com docker build --provenance=false para ligar o pacote ao repositório", "trecho": "Vou tentar publicar com --provenance=false.", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Grupo de concorrência da CI por ref e evento, para o disparo à mão e o push não se cancelarem", "trecho": "group: ci-${{ github.ref }}-${{ github.event_name }}", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Log de cada contêiner de produção limitado a 5 arquivos de 10 MB", "trecho": "log de cada contêiner limitado a 5 arquivos de 10 MB, para não encher o disco", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Exceção no .gitignore para versionar o .env.producao.example", "trecho": "+!.env.producao.example", "tipo": "hospedagem e deploy", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Verificação do R2 filtrando só as linhas MAXX_ARMAZENAMENTO_ para um arquivo temporário privado (umask 077), apagado no fim", "trecho": "Filtro só as linhas do R2 para um arquivo temporário e privado", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Correção do envio ao R2 desligando o chunk encoding do PutObject (UseChunkEncoding = false)", "trecho": "A correção é desligar o chunk encoding no PutObjectRequest, forma que o R2 aceita", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Novo teste de envio direto no VerificacaoDoR2Tests, com prova reversa rodada na VPS", "trecho": "Escrevo primeiro o teste, para rodá-lo na VPS sem a correção (prova reversa)", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Dois códigos de recusa (email-fora-da-faculdade no cadastro, dominio-nao-aceito na correção) em vez do código único do plano", "trecho": "a etapa 3 vai usar dois códigos, um para o cadastro (email-fora-da-faculdade) e outro para a correção (dominio-nao-aceito)", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Checagem de domínio também na sugestão e na disponibilidade do arroba, antes da consulta à base, com código próprio", "trecho": "a checagem no BuscarSemContaAsync (vale para cadastro, sugestão e disponibilidade do arroba)", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Lista de domínios no appsettings.json, igual em todo ambiente e sem lista separada de teste; vazia, nada sobe", "trecho": "não é segredo, e a lista é a mesma em todo ambiente. Vazia ou mal formada, nada sobe.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Batimento do worker gravado no máximo a cada 15 s", "trecho": "Sem batimento há mais de 2 minutos (o worker grava um a cada 15 s)", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Falha ao gravar o batimento só gera aviso no log, e o laço do worker continua", "trecho": "LogFalhaNoBatimento(logger, falha.GetType().Name, falha.Message);", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Tabela batimento_do_worker de uma linha com restrição de checagem id = 1", "trecho": "apenas a tabela de uma linha e a restrição id = 1", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Janela de trabalho falho calculada pelo disponivel_em, sem coluna nova", "trecho": "a consulta das últimas 24 horas não precisa de coluna nova", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Fila parada contada do que vier depois entre a chegada e a disponibilidade do trabalho", "trecho": "contados do que vier depois entre a chegada e a disponibilidade (o seed enfileira com datas passadas)", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Formato da resposta do /health/worker: status, idades, contagens, códigos worker-parado/fila-parada/trabalho-falho, 503 com o mesmo corpo", "trecho": "200 com \"status\": \"ok\", ou 503 com a lista problemas", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Parou o worker em produção por mais de 2 minutos para provar o alerta", "trecho": "Vou parar o worker por pouco mais de 2 minutos para checar o alerta worker-parado na produção", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cabeçalhos e diretivas além do plano: X-Frame-Options DENY, COOP same-origin, remoção do Server, font/worker/manifest-src, form-action, connect-src com data: e blob:", "trecho": "X-Frame-Options \"DENY\" ... Cross-Origin-Opener-Policy \"same-origin\" -Server", "tipo": "segurança", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "HSTS de um ano, sem includeSubDomains nem preload", "trecho": "Um ano, sem subdomínios nem preload: vale só para o app.", "tipo": "segurança", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "style-src com 'unsafe-inline' por causa do react-native-web e do expo-reset", "trecho": "o style-src vai precisar de 'unsafe-inline', como eu tinha previsto, e registro o motivo", "tipo": "segurança", "forma": "declarada", "duvidosa": true},
    {"descricao": "Trivy fixado na v0.76.1, com checksum, escolhendo versão com mais de duas semanas", "trecho": "Fixo a v0.76.1, de 21/10, com a soma conferida pelo arquivo de checksums.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Trivy com --ignore-unfixed e varredura de segredos nas imagens", "trecho": "alto ou crítico e --ignore-unfixed", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "apt-get upgrade no estágio final da imagem da API para corrigir achado do Trivy", "trecho": "o Trivy também ganha um fix próprio para atualizar os pacotes do Ubuntu", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Laço do Trivy varrendo sempre as duas imagens antes de falhar o job", "trecho": "As duas sempre, e o job falha no fim: a primeira com achado não esconde a segunda.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Exceção do Trivy limitada ao binário do Caddy", "trecho": "o .trivyignore.yaml com a exceção limitada ao binário do Caddy e com validade", "tipo": "segurança", "forma": "declarada", "duvidosa": true},
    {"descricao": "Backup com pg_dump -Fc, nome com instante UTC e rótulo, validação por pg_restore --list antes do nome final, pasta 700 de root, timer Persistent", "trecho": "O dump só ganha o nome final depois de o pg_restore --list conseguir lê-lo.", "tipo": "hospedagem e deploy", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "deploy.sh baixa compose e scripts do GitHub no mesmo commit, confere o .env, troca a si mesmo com mv e espera o /api/ready", "trecho": "traz do repositório, no mesmo commit, os arquivos do compose, o .env.producao.example e os scripts de infra/, inclusive ele mesmo", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "k6 fixado em grafana/k6:1.8.2", "trecho": "Fixo a grafana/k6:1.8.2, de 12/10", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Contêiner do k6 rodando como root na VPS", "trecho": "Vou rodar o contêiner do k6 como root, passando a chave só pelo --env-file", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Aquecimento de 20 s descartado antes da medida de carga", "trecho": "depois de 20 s de aquecimento descartado (as réplicas tinham acabado de reiniciar", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Limites no k6: p95 < 300 ms por rota e taxa de falha < 1%", "trecho": "http_req_failed: [\"rate<0.01\"] ... [\"p(95)<300\"]", "tipo": "testes e processo", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "EXPLAIN com enable_seqscan = off na VPS para provar que os índices do feed e de trigramas servem", "trecho": "Vou forçar enable_seqscan = off para confirmar se os índices de trigramas atendem à consulta", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Escolha dos índices pelo planejador com volume real registrada como pendência fora da fase 1", "trecho": "a escolha com volume real fica pendente junto com o cenário de 2.000 usuários", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true},
    {"descricao": "Gravação de logs e docker stats a cada 10 s na VPS durante o ensaio", "trecho": "Vou gravar logs e amostras de docker stats a cada 10 s para cruzar com cada passo", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Correção do passo 6: tocar de novo no prêmio escolhido devolve a lista, mantém nome e datas, limpa evento e matéria; vale também para a concessão da instituição", "trecho": "tocar de novo no prêmio escolhido devolve a lista inteira, com o mesmo efeito do \"Trocar prêmio\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Captura por spec temporário do Playwright, a 390 de largura, nos temas claro e escuro", "trecho": "Vou gravar a captura com uma especificação temporária do Playwright, fora do commit, nos temas claro e escuro", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Rotina de purga em operacao.md com desligar a demonstração antes e esperar a fila esvaziar", "trecho": "1. Desligar a demonstração (dc up -d), para ninguém entrar no lote durante a purga.", "tipo": "hospedagem e deploy", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Atualização de comentários e docs que citavam o passo 13 como futuro", "trecho": "Ficaram cinco referências ao passo 13 escritas como futuro.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Publicou no remoto a branch rodada/eng_13_endurecimento para servir de base do PR", "trecho": "publico-a sem commit novo, como base para o PR", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Primeira subida na VPS com sha-c1f2b77 só com seed base, antes da troca dos e-mails", "trecho": "a primeira subida na VPS com a sha-c1f2b77, usando só o seed base", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Encadeamento que só implanta na VPS se a publicação terminar verde", "trecho": "Escrevo um script de implantação reutilizável; depois de checar que a publicação ficou verde, vou trocar a tag na VPS", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false}
  ],
  "perguntas": [
    {"texto": "E-mails dos professores e da instituição no seed: trocar para endereços em maxx-unimax.com com Email Routing? Ou você prefere outro caminho?", "respondida": true},
    {"texto": "Textos do código dominio-nao-aceito: aprova? E posso passar o produto.md 2.4 para 'configuração da API'?", "respondida": true},
    {"texto": "Bucket de backup separado maxx-backup sem domínio público, com token próprio e retenção de 14 dias: você cria?", "respondida": true},
    {"texto": "Para onde vai o alerta: monitor externo (UptimeRobot) ou cron no host com Brevo?", "respondida": true},
    {"texto": "Imagens antes da main por workflow_dispatch com sha-<curto>; pacote no GHCR público ou privado?", "respondida": true},
    {"texto": "Papel maxx_app com menos privilégio: entra no passo, ou o usuário dono fica, só com a revisão registrada?", "respondida": true},
    {"texto": "Contas e volume do k6: seed carga com cerca de 3.050 alunos como lote carga-k6. Topa? Ou 'volume real' quer dizer outra coisa?", "respondida": true},
    {"texto": "De onde roda o k6: uma CX temporária da Hetzner no mesmo datacenter, criada por você. Pode ser?", "respondida": true},
    {"texto": "Varredura das imagens com Trivy no job build, mesmo corte alto ou crítico. Entra?", "respondida": true},
    {"texto": "Node 24: se o Expo 58 suportar e a CI ficar verde, eu já troco, ou só trago a avaliação para você decidir?", "respondida": true},
    {"texto": "Como você prefere seguir? 1. Derrubo a pilha local e rodo de novo a suíte do Node 24; 2. pulo a suíte local e deixo a CI decidir.", "respondida": true},
    {"texto": "Qual opção para o Caddy? (exceção com prazo no Trivy, compilar com xcaddy, ou Trivy não bloqueante)", "respondida": true},
    {"texto": "O lote do ensaio no MAXX_DEMO_LOTE: o .env já tem um valor; confirme se ele é o do ensaio ou troque.", "respondida": true},
    {"texto": "Se o e-mail de primeiro acesso da coordenação chegou.", "respondida": true},
    {"texto": "Cache da CDN depois da purga: passo manual na rotina, automatizar na API, ou só registrar como limite? Qual você prefere?", "respondida": true},
    {"texto": "O CLAUDE.md tem duas linhas desatualizadas pelo passo 13. Se quiser, ajusto no mesmo PR.", "respondida": true}
  ],
  "contagem": {"decisoes": 42, "declaradas": 32, "silenciosas": 10, "duvidosas": 3, "perguntas": 16, "perguntas_respondidas": 16}
}
```
