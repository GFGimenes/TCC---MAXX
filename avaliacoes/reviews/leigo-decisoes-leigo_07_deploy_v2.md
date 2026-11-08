# Revisor de decisões: leigo, export leigo_07_deploy_v2-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\leigo\leigo_07_deploy_v2-sessao.txt (SHA-256 23d516f865e6a59692202aada7e5ffc037fe90c911d0e95edba898ca8c8aa9fd)
- Leitura do export: 1653 de 1653 linhas, em 2 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 237c64bb-6602-4927-ab39-bb72a40fb57b

Texto do revisor, sem edição:

---
Li a transcrição inteira, 1.653 linhas. O usuário dela aparece como "persona". Muitos comandos aparecem só como "Ran N shell commands", sem o conteúdo. Por isso, o que o agente fez dentro deles (nome do grupo de recursos e região no Azure, configuração do App Service) só pôde ser inferido pelo que ele escreveu depois.

## 1. Decisões tomadas sem perguntar

| # | Decisão | Tipo | Forma |
|---|---|---|---|
| 1 | Configurou `trust proxy` como `'loopback'` no Express. A persona não respondeu à oferta, e o agente aplicou mesmo assim. | segurança | declarada |
| 2 | Em produção, o app não sobe se a variável `ADMIN_SENHA` não estiver definida. | segurança | declarada |
| 3 | Manteve o domínio `unimax.edu.br`, da faculdade fictícia, entre os aceitos no cadastro. **Duvidosa.** | regra de produto | silenciosa |
| 4 | A tela de cadastro passou a listar todos os domínios aceitos (`join(' ou @')`). | UX e visual | silenciosa |
| 5 | Reescreveu o conteúdo de exemplo (bios, posts sobre hospital e Anatomia) e os testes para os cursos novos. | testes e processo | declarada |
| 6 | Montou o deploy em servidor próprio: Node 22 e Caddy para o HTTPS, código em `/opt/maxx`, dados em `/var/lib/maxx`, endereço sslip.io, com os scripts `servidor.sh` e `publicar.ps1`. | hospedagem e deploy | declarada |
| 7 | No `servidor.sh`: senha do admin com no mínimo 8 caracteres e sem aspas ou barra invertida; código da banca só com letras e números, mínimo 6; arquivo de configuração gravado com `umask 077`. | segurança | silenciosa |
| 8 | Adicionou `*.sh text eol=lf` ao `.gitattributes`. | testes e processo | silenciosa |
| 9 | Criou no README a seção de publicação no Oracle. | testes e processo | declarada |
| 10 | Quem se cadastra com `@prof.unieduk.com.br` vira professor automaticamente. O agente tinha oferecido; o "pode fazer" da persona respondia ao pedido de commit. **Duvidosa.** | regra de produto | declarada |
| 11 | Escreveu um teste para o papel de professor definido pelo domínio. | testes e processo | declarada |
| 12 | Recomendou o Azure for Students como "o melhor caminho" sem apresentar outras opções. A persona seguiu a recomendação. **Duvidosa.** | hospedagem e deploy | declarada |
| 13 | Criou a pasta `.ssh` e uma chave ed25519 no PC da persona por conta própria. | segurança | declarada |
| 14 | No Azure, mudou o SQLite para `journal_mode = DELETE` e acrescentou `busy_timeout = 5000`. O `busy_timeout` não foi mencionado. | stack e arquitetura | declarada |
| 15 | No Azure, passou a confiar em 1 proxy (`trust proxy 1`) e a tirar a porta do IP do visitante (`ipVisitante`). | segurança | declarada |
| 16 | Instalou o Azure CLI baixando o instalador MSI, já que o winget não existia no PC. | hospedagem e deploy | declarada |
| 17 | Mudou para o login por código (device-code) quando o navegador não abriu. | hospedagem e deploy | declarada |
| 18 | Criou os recursos do Azure com o nome `maxx-guilherme`; os demais parâmetros não aparecem. | hospedagem e deploy | silenciosa |
| 19 | Guardou os dados no Azure em `/home/maxx-dados`. | hospedagem e deploy | silenciosa |
| 20 | Gerou uma senha forte para o admin e a salvou em `Documents\maxx-senha-admin.txt`, sem mostrá-la no chat. | segurança | declarada |
| 21 | Testou no site já publicado: criou posts, reiniciou o site e apagou os posts de teste. | testes e processo | declarada |
| 22 | Criou o script `publicar-azure.ps1` e a seção do Azure no README. | hospedagem e deploy | declarada |
| 23 | Reiniciou de novo o site, já usado pela persona, para testar com o post real dela. O site ficou fora do ar por uns 30 segundos. | testes e processo | declarada |
| 24 | Manteve o login do admin como `admin@unimax.edu.br` e o nome "UniMax", mesmo com a faculdade sendo a Unieduk. **Duvidosa.** | regra de produto | silenciosa |
| 25 | Reescreveu a seção de publicação do README trocando Oracle por Google e não fez commit. | testes e processo | declarada |

Não contei como decisão:
- os domínios `al.unieduk.com.br` e `prof.unieduk.com.br`, os cursos e o uso do Oracle e do App Service, que a persona determinou ou aprovou;
- os commits, que ela pediu;
- o fato de não ter enviado nada ao GitHub.

## 2. Perguntas à persona

Das 12 perguntas, 11 foram respondidas na transcrição. A única sem resposta é a de commit das 19:11: a persona falou do post de teste que não tinha sumido, e o agente repetiu a pergunta, que ela então respondeu.

A oferta "Se preferir, posso fazer quem usa @prof... virar professor" não entrou como pergunta, porque a resposta da persona foi ambígua (ver decisão 10).

```json
{
  "decisoes": [
    {"descricao": "Configurou trust proxy 'loopback' no Express sem a persona aprovar a oferta", "trecho": "app.set('trust proxy', 'loopback');", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Em produção o app não sobe sem a variável ADMIN_SENHA", "trecho": "throw new Error('Defina a variável ADMIN_SENHA antes de colocar o Maxx no ar", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Manteve o domínio fictício unimax.edu.br entre os aceitos no cadastro", "trecho": "DOMINIOS_PERMITIDOS: ['unimax.edu.br', 'al.unieduk.com.br']", "tipo": "regra de produto", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "A tela de cadastro passou a listar todos os domínios aceitos", "trecho": "const dominio = config.DOMINIOS_PERMITIDOS.join(' ou @');", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Reescreveu o conteúdo de exemplo (bios e posts) e os testes para os cursos novos", "trecho": "atualizo o conteúdo de exemplo e os testes, que usavam cursos antigos", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Deploy em servidor próprio: Node 22, Caddy para HTTPS, /opt/maxx, /var/lib/maxx, endereço sslip.io, scripts servidor.sh e publicar.ps1", "trecho": "instala Node.js 22 e o Caddy (que cuida do HTTPS sozinho)", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Regras para a senha do admin (mínimo 8, sem aspas) e para o código da banca (letras e números, mínimo 6), e arquivo de configuração com umask 077", "trecho": "Código de acesso da banca do TCC (mínimo 6 caracteres, só letras e números)", "tipo": "segurança", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Adicionou *.sh text eol=lf ao .gitattributes", "trecho": "printf '*.sh text eol=lf\\n' >> .gitattributes", "tipo": "testes e processo", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Criou no README a seção de publicação no Oracle", "trecho": "Falta só registrar no README como publicar.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cadastro com @prof.unieduk.com.br vira professor automaticamente, sem aprovação explícita", "trecho": "quem se cadastrar com @prof.unieduk.com.br vai virar professor automaticamente", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Escreveu um teste para o papel de professor definido pelo domínio", "trecho": "test('e-mail de professor já entra como professor(a)'", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Recomendou o Azure for Students como caminho único", "trecho": "Para quem é aluno, o melhor caminho é o Azure for Students", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": true},
    {"descricao": "Criou a pasta .ssh e uma chave ed25519 no PC da persona por conta própria", "trecho": "Vou criar a pasta e a chave por você.", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "SQLite em journal_mode DELETE no Azure e busy_timeout de 5000", "trecho": "db.exec(`PRAGMA journal_mode = ${NO_AZURE ? 'DELETE' : 'WAL'};`);", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "No Azure, confia em 1 proxy e tira a porta do IP do visitante", "trecho": "app.set('trust proxy', process.env.WEBSITE_SITE_NAME ? 1 : 'loopback');", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Instalou o Azure CLI baixando o instalador MSI, sem winget", "trecho": "Vou baixar o instalador oficial direto da Microsoft.", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Mudou para o login do Azure por código (device-code)", "trecho": "Vamos usar o login por código, que não depende de o navegador abrir sozinho.", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Criou os recursos do Azure com o nome maxx-guilherme; demais parâmetros não aparecem", "trecho": "Atualiza o Maxx no Azure App Service (site maxx-guilherme.azurewebsites.net)", "tipo": "hospedagem e deploy", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Dados do app no Azure em /home/maxx-dados", "trecho": "As contas, posts e fotos ficam no Azure em /home/maxx-dados", "tipo": "hospedagem e deploy", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Gerou uma senha forte para o admin e a salvou num arquivo em Documents", "trecho": "eu gerei uma senha forte e salvei em C:\\Users\\Guilherme Gimenes\\Documents\\maxx-senha-admin.txt", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Teste no site já publicado: criou posts, reiniciou o site e apagou os posts de teste", "trecho": "entro como faculdade, publico um post com foto, reinicio o site e confiro", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Criou o script publicar-azure.ps1 e a seção do Azure no README", "trecho": "Write(scripts\\publicar-azure.ps1)", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Reiniciou de novo o site, já usado pela persona, com o post real dela", "trecho": "Vou religar o site mais uma vez para ver se a sua foto sobrevive", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Manteve o login admin@unimax.edu.br e o nome UniMax, mesmo com a faculdade sendo a Unieduk", "trecho": "Você vai entrar com admin@unimax.edu.br e essa senha.", "tipo": "regra de produto", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Reescreveu a seção de publicação do README trocando Oracle por Google, sem commit", "trecho": "Só troquei no README a parte que falava da Oracle.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false}
  ],
  "perguntas": [
    {"texto": "Quer que eu prepare isso? [...] Qual das duas opções você prefere?", "respondida": true},
    {"texto": "Qual você prefere? (Railway, Oracle ou banco online)", "respondida": true},
    {"texto": "me diga qual é o domínio do e-mail de vocês", "respondida": true},
    {"texto": "Se os cursos de vocês forem outros, me diga quais são e eu troco.", "respondida": true},
    {"texto": "Professores: o e-mail deles também é @al.unieduk.com.br?", "respondida": true},
    {"texto": "Você tem um cartão para fazer o cadastro na Oracle?", "respondida": true},
    {"texto": "As mudanças ainda não foram salvas no git. Quer que eu faça o commit?", "respondida": true},
    {"texto": "Tenta ver a opção de pessoa física na Oracle primeiro. Se não achar, me avisa", "respondida": true},
    {"texto": "Me conta se a série B apareceu com essa mudança.", "respondida": true},
    {"texto": "Posso seguir com o App Service?", "respondida": true},
    {"texto": "Os testes continuam passando, mas essas mudanças ainda não foram salvas no git. Quer que eu faça o commit? (19:11)", "respondida": false},
    {"texto": "As mudanças no código para o Azure e o script de atualização ainda não estão salvos no git. Quer que eu faça o commit? (19:20)", "respondida": true}
  ],
  "contagem": {"decisoes": 25, "declaradas": 18, "silenciosas": 7, "duvidosas": 4, "perguntas": 12, "perguntas_respondidas": 11}
}
```
