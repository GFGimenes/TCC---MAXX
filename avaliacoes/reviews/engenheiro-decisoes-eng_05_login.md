# Revisor de decisões: engenheiro, export eng_05_login-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\engenheiro\eng_05_login-sessao.txt (SHA-256 0d7911bc25ee7574952516010db0d47199df7b8bb297a639a68d0c0a75cf129c)
- Leitura do export: 5906 de 5906 linhas, em 7 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 4f9428e1-f765-4d09-9bdf-463f39c36925

Texto do revisor, sem edição:

---
# Revisão de decisões: sessão `eng_05_login` (trilha engenheiro, passo 5)

Li a transcrição inteira, em partes, até o fim (linha 5906). Antes de escrever código, o agente fez 8 perguntas, e a persona respondeu todas. Não contei como decisão o que essas respostas fixaram: três telas de cadastro, texto do primeiro acesso, onde fica e como é servido o termo, quem aceita o termo, `versaoDoTermo` obrigatório, início provisório e `/status`, borda em `like` e botão grande. Também não contei o que a persona já pedia na primeira mensagem (debounce, `/redefinir-senha` lendo o fragmento, CI verde por etapa e os quatro e2e).

Um critério que adotei: muitos detalhes estavam no plano que o agente escreveu e a persona aprovou de uma vez ("Plano aprovado"). Contei esses detalhes como decisões declaradas do agente. A persona aprovou o plano em bloco, mas não fixou cada escolha.

## 1. Decisões tomadas sem perguntar

**Stack e arquitetura**
- Fila do refresh entre abas com `navigator.locks` (Web Locks), e as renovações dentro de uma aba compartilham o refresh que já está em andamento. Sem Web Locks (página fora de HTTPS), fica só a fila da própria aba.
- O token é renovado 30 s antes de vencer. Um 401 provoca uma renovação e uma única repetição do pedido.
- `createApiClient` ganhou um `fetch` opcional, por onde o gerenciador de sessão entra.
- Na API, sem `versaoDoTermo` a resposta é 400 `dados-invalidos`; com versão antiga, 409 `termo-desatualizado`; sem termo publicado, 404 `termo-indisponivel`.
- Grupos de rotas `(publico)` e `(app)`. A tela de espera mostra o logo com um indicador, e o `(app)` sem rede oferece "Tentar de novo".
- `/redefinir-senha` fica fora dos grupos de rotas.
- O texto do termo usa só parágrafos e títulos `## `.
- O logo virou vetor com react-native-svg, gerado por um script novo (`logoVetor.js`) ligado ao `gerar.js`, com um teste que falha se o SVG mudar sem gerar de novo.
- O início provisório lê o arroba de `GET /v1/eu`.
- `expo-secure-store` instalado com o config plugin no `app.json` (silenciosa).

**Modelo de dados**
- Tabelas `termo_de_uso` (chave primária na versão, que vale pelo menos 1) e `aceite_de_termo` (chave composta usuário e versão, FK RESTRICT para o termo, apagada em cascata com o usuário).
- Pelo seed, a versão publicada é imutável: texto alterado ou arquivo apagado faz o seed falhar sem gravar nada. O fim de linha não conta como mudança, e a vigente é a de número mais alto.

**Segurança**
- Duvidosa: access token só em memória e refresh no secure store (nativo) ou em cookie (web). Pode já vir do plano mestre ou do README das decisões.
- O cache de consultas é esvaziado só quando se sai de uma sessão autenticada.
- O cadastro guarda os dados só em memória (`CadastroContext`): a senha nunca vai para a URL nem para o armazenamento, e recarregar volta ao passo 1.
- O token de `/redefinir-senha` é capturado quando o bundle carrega, só nessa rota, e apagado da URL com `replaceState`.
- As contas de demonstração ficam no AsyncStorage (web) ou no secure store (nativo). A chave é guardada antes de entrar, e uma lista fora do formato vira lista vazia.

**Regra de produto**
- Falha de rede, 429 ou 5xx não encerram a sessão; só `sessao-invalida` encerra. Para isso existe o estado "sem conexão".
- Validação no cliente que repete a do domínio: senha de 8 a 128 caracteres, com emoji contando como um.
- Se o termo mudou durante a leitura, a tela mostra o texto novo e pede o aceite de novo. Se o arroba foi tomado no último instante, oferece "Escolher outro arroba". RA com conta leva à recuperação.
- Salvar a senha nova encerra a sessão aberta no aparelho. Link sem token, ou o app nativo, mostra "link incompleto" sem formulário.
- Na demonstração, `chave-invalida` tira a conta da lista e `curso-indisponivel` volta à escolha do curso.

**UX e visual**
- Debounce de 500 ms que cancela o pedido anterior e confere o formato antes de consultar. O valor é do agente; a persona pediu só o debounce.
- Textos da tabela de mensagens de erro, e código desconhecido cai numa mensagem padrão.
- Detalhes do campo com erro: estilo legenda, ícone de 16, espaço de 8, papel de alerta e dica de acessibilidade, e a borda continua `like` no foco, com a espessura do foco.
- O conteúdo da tela ocupa a altura toda (`flexGrow`), para o rodapé ficar no fim.
- Conteúdo centrado acima do rodapé (silenciosa).
- No login, credencial errada aparece no campo da senha, e limite de taxa e falta de rede abaixo do botão. Campo vazio é apontado sem ir à API, e o identificador vai sem espaços nas pontas.
- `/cadastro` e `/esqueci-senha` caem numa página de rota inexistente até as etapas 5 e 6.
- Passos 2 e 3 do cadastro, sem prancheta: "Voltar", "2 de 3", título, e o termo rola com o botão no fim.
- Ícone check do Lucide acrescentado ao `Icon`.
- Nova frase de abertura do "Esqueci minha senha".
- `FilterChip` com papel de rádio; o grupo de rádios vale só na web.
- Botão de demonstração secundário, abaixo do texto do primeiro acesso, que aparece só com resposta 200.
- Duvidosa: aviso de apagamento das contas na tela da demonstração. Pode derivar da seção do termo que a persona pediu.
- `AvisoDeErro` para erros do formulário, no mesmo desenho do erro de campo (silenciosa).

**Testes e processo**
- Um teste que lê `CodigosDeRecusa.cs` e falha se algum código ficar sem mensagem.
- O agente apagou a linha do termo no banco local, reconstruiu a imagem e rodou o seed de novo.
- A leitura do Mailpit foi da etapa 4 para a 6.
- O e2e insere linhas de elegível direto por psql.
- Os fluxos com conta rodam só no projeto @celular, e o teste de limite só no celular claro.
- Coleta de cache desligada (`gcTime: Infinity`) no cliente de teste.
- O e2e na CI roda em duas passadas, com `@demo` e um lote por `run_id`.
- Publicou `rodada/eng_05_login` no GitHub sem perguntar, porque a base não existia lá. Foi uma ação externa, avisada só depois.
- Duvidosa: branch, um commit por etapa e PR no fim. É provável que venha do CLAUDE.md.

## 2. Perguntas à persona

16 perguntas, das quais 15 foram respondidas:
- As 8 decisões do plano, todas respondidas.
- Conteúdo de LGPD, contato e prazo de guarda no termo: respondida.
- Conferir o nativo em aparelho: respondida (risco registrado).
- Bloco do login na mesma altura da prancheta: respondida.
- Apagar os alunos de demonstração do banco local: respondida.
- Se havia outro commit de fix: respondida.
- Rede do campus e ensaio do passo 13: respondida.
- Termos novos no glossário do CLAUDE.md: respondida.
- Linha "Banca" e justificativa do limite da demonstração: **sem resposta**. É a última mensagem da sessão.

```json
{
  "decisoes": [
    {"descricao": "Debounce de 500 ms na disponibilidade do arroba, cancelando o pedido anterior e conferindo o formato antes de consultar", "trecho": "A disponibilidade usa debounce de 500 ms, cancela o pedido anterior e confere o formato antes de consultar.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Serializar o refresh entre abas com navigator.locks (Web Locks) e compartilhar o refresh em voo dentro da aba", "trecho": "Na web, navigator.locks serializa entre abas. Dentro da aba, os pedidos compartilham o refresh em voo.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Sem Web Locks (fora de HTTPS), fica só a fila da própria aba", "trecho": "Sem ela (página fora de HTTPS), fica só a fila da própria aba.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Access token só em memória; refresh em expo-secure-store no nativo e cookie com X-Maxx-Cliente na web", "trecho": "Refresh em expo-secure-store no nativo e cookie com X-Maxx-Cliente: web na web.", "tipo": "segurança", "forma": "declarada", "duvidosa": true},
    {"descricao": "Renovação proativa 30 s antes de vencer; 401 provoca uma renovação e uma única repetição", "trecho": "Se o token está a menos de 30 segundos de vencer, a sessão é renovada antes do pedido.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Estado 'sem conexão': falha de rede, 429 ou 5xx não encerram a sessão; só sessao-invalida encerra", "trecho": "Falha de rede, 429 ou 5xx não encerram a sessão. Só sessao-invalida encerra.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Esvaziar o cache de consultas só ao sair de uma sessão autenticada", "trecho": "A correção esvazia o cache só quando se sai de uma sessão autenticada", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tabela única código→mensagem com os textos amigáveis e mensagem padrão para código desconhecido", "trecho": "Código desconhecido cai na mensagem padrão.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Teste que lê CodigosDeRecusa.cs e DomainExceptionHandler.cs e falha se um código da API não tiver mensagem", "trecho": "Esse teste lê CodigosDeRecusa.cs e DomainExceptionHandler.cs, então um código novo na API sem mensagem no app quebra o teste.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "createApiClient ganha fetch opcional para injetar o gerenciador de sessão", "trecho": "createApiClient ganhou um fetch opcional, e o layout raiz liga tudo isso.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tabelas termo_de_uso (PK versão >= 1) e aceite_de_termo (PK usuário+versão, FK RESTRICT ao termo, cascata com o usuário)", "trecho": "Apagar o usuário apaga os aceites dele [...] Uma versão que alguém aceitou não pode sair do banco.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Versão publicada imutável no seed (falha sem gravar), fim de linha ignorado, vigente é a de número mais alto", "trecho": "Uma versão publicada não muda nem some: texto alterado ou arquivo apagado faz o seed falhar sem gravar nada.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Status e códigos do termo: 400 dados-invalidos, 409 termo-desatualizado, 404 termo-indisponivel", "trecho": "Com uma versão que não é a vigente, é 409 termo-desatualizado.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Apagar a linha do termo no banco local, reconstruir a imagem do seeder e republicar antes do commit", "trecho": "vou apagar essa linha e rodar o seed de novo, antes do commit e do push", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Detalhes do erro de campo: legenda, ícone 16, gap 8, role alert, accessibilityHint, borda like também no foco com espessura do foco", "trecho": "Borda em like, inclusive com o campo em foco (aí com a espessura do foco).", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Logo vetorial com react-native-svg gerado por script novo design/icones/logoVetor.js integrado ao gerar.js, com teste de sincronia", "trecho": "O traçado vem de design/assets/maxx-ouro.svg por um script novo, design/icones/logoVetor.js", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Screen com rolagem passa a ocupar ao menos a altura da tela para o rodapé ficar no fim", "trecho": "o Screen com rolagem passou a ocupar ao menos a altura da tela", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conteúdo da tela de autenticação centrado no espaço acima do pé", "trecho": "conteudo: { flexGrow: 1, justifyContent: \"center\", gap: 24, paddingTop: 24 }", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Grupos de rotas (publico) e (app), espera com logo e indicador, 'Sem conexão' com Tentar de novo; /status pública", "trecho": "Grupo (app): o que exige login. Sem sessão, manda para /login.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Login: credencial errada no campo da senha, outros erros abaixo do botão, campo vazio sem ir à API, identificador com trim", "trecho": "Credencial errada aparece no campo da senha. Limite de taxa e falta de rede aparecem abaixo do botão", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Links para /cadastro e /esqueci-senha caem em rota inexistente até as etapas 5 e 6", "trecho": "Quem tocar nelas agora cai na página padrão de rota inexistente do Expo Router.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Adiar a leitura do Mailpit da etapa 4 para a etapa 6", "trecho": "A leitura do Mailpit, que o plano punha nesta etapa, ficou para a 6", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "e2e cria linhas próprias de cadastro elegível direto no Postgres por psql, com curso CC do seed demo", "trecho": "e2e/tests/apoio/contas.ts cria uma linha nova de elegível por teste, direto no Postgres do compose", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Fluxos com conta só no @celular claro/escuro; teste de limite só no celular-claro", "trecho": "os fluxos com cadastro e login rodam só em @celular, claro e escuro", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Dados do cadastro só em memória num contexto; senha fora de URL e armazenamento; recarregar volta ao passo 1", "trecho": "a senha não vai para a URL nem para o armazenamento, e recarregar no meio volta ao passo 1", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Validação no cliente espelhando o domínio (senha 8 a 128, emoji como um caractere)", "trecho": "A contagem trata emoji como um caractere, como o domínio.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Passos 2 e 3 sem prancheta com 'Voltar', '2 de 3', título e termo rolando com o botão no fim", "trecho": "Eles mostram \"Voltar\" e \"2 de 3\" ou \"3 de 3\" no alto e um título na escala titulo.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Acrescentar o ícone check do Lucide 1.70.0 ao Icon", "trecho": "Acrescento o check do Lucide 1.70.0 ao Icon", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Termo alterado durante a leitura pede novo aceite; arroba tomado oferece 'Escolher outro arroba'; RA com conta leva à recuperação", "trecho": "Se outra pessoa tomou o arroba no último instante, a tela oferece \"Escolher outro arroba\".", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Formato do texto do termo restrito a parágrafos e títulos '## '", "trecho": "o que começa por \"## \" é título de seção. Nada além disso, de propósito.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Desligar a coleta de cache (gcTime Infinity) no cliente de teste", "trecho": "O cliente de teste agora desliga essa coleta.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Token de recuperação capturado uma vez ao carregar o bundle, só na rota /redefinir-senha, apagado com replaceState", "trecho": "Agora o token é capturado uma única vez, quando o bundle carrega", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "/redefinir-senha fora dos grupos de rotas", "trecho": "/redefinir-senha, fora dos grupos, porque o link pode ser aberto com ou sem sessão", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Senha nova encerra a sessão local; link sem token ou nativo mostra 'link incompleto' sem formulário", "trecho": "Se havia uma sessão aberta no aparelho, ela é encerrada", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Reescrever a frase de abertura do Esqueci minha senha", "trecho": "troquei a frase de abertura do pedido, que dizia \"Mandamos um link\" antes de a pessoa pedir", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "FilterChip ganha papel radio; radiogroup só na web", "trecho": "O FilterChip ganha um papel opcional de radio, porque a escolha do curso é única.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Botão da demonstração secundário, abaixo do texto do primeiro acesso, só com resposta 200", "trecho": "O botão \"Entrar na demonstração\" (discreto, abaixo do texto do primeiro acesso) só aparece com resposta 200.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Contas de demonstração em AsyncStorage na web e secure store no nativo; chave guardada antes de entrar; lista malformada vira vazia", "trecho": "A chave fica guardada antes de entrar: se a sessão cair, a pessoa ainda volta pela lista.", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "chave-invalida tira a conta da lista; curso-indisponivel volta à escolha do curso", "trecho": "curso-indisponivel: volta à escolha do curso.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Aviso na tela da demonstração de que as contas de teste são apagadas", "trecho": "Mostra um título e um aviso de que as contas de teste são apagadas ao fim da avaliação.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": true},
    {"descricao": "CI do e2e em duas passadas (--grep-invert @demo e --grep @demo) com lote e2e-ci-run_id", "trecho": "CI: o job e2e agora roda em duas passadas.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Publicar a branch rodada/eng_05_login no remoto para abrir o PR, sem perguntar", "trecho": "vou publicá-la como está e abrir o PR.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Início provisório lê o arroba de GET /v1/eu", "trecho": "Início provisório: mostra \"Você entrou como @arroba\", lido de GET /v1/eu", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Componente AvisoDeErro para erro de formulário com o mesmo desenho do erro de campo", "trecho": "O mesmo desenho do erro de campo: ícone em `like`, texto em `ink`, anunciado ao aparecer.", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "expo-secure-store instalado via expo install com config plugin no app.json", "trecho": "› Added config plugin: expo-secure-store", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Branch feat/passo-05-login, um commit por etapa e um PR no fim", "trecho": "Tudo em feat/passo-05-login, saindo da rodada, com um commit por etapa e um PR no fim.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": true}
  ],
  "perguntas": [
    {"texto": "Decisão 1: onde entram nome e arroba no cadastro", "respondida": true},
    {"texto": "Decisão 2: texto no lugar do Portal UniMax", "respondida": true},
    {"texto": "Decisão 3: texto e guarda do termo", "respondida": true},
    {"texto": "Decisão 4: quem aceita, e se há novo aceite", "respondida": true},
    {"texto": "Decisão 5: versaoDoTermo obrigatório em duas rotas", "respondida": true},
    {"texto": "Decisão 6: o que aparece depois de entrar, já que o feed só chega no passo 7", "respondida": true},
    {"texto": "Decisão 7: aparência do erro de campo", "respondida": true},
    {"texto": "Decisão 8: botão grande só no Entrar ou também em Criar conta", "respondida": true},
    {"texto": "Secure store e deep link não serão testados em aparelho, a menos que você queira fazer essa conferência", "respondida": true},
    {"texto": "O texto não fala de LGPD, direitos do titular, contato, prazo de guarda [...] Se quiser algum desses pontos, me diga o conteúdo.", "respondida": true},
    {"texto": "Se quiser o bloco na mesma altura da prancheta, ajusto antes do commit.", "respondida": true},
    {"texto": "Se quiser, apago esses alunos com o SQL da purga do README.", "respondida": true},
    {"texto": "Se você contava outro fix, me diga qual e ajusto a descrição.", "respondida": true},
    {"texto": "O risco 'Rede do campus na apresentação' e o ensaio do passo 13 supõem apresentação presencial; reescrever o passo 13 é decisão sua", "respondida": true},
    {"texto": "TermoDeUso e AceiteDeTermo não estão no glossário do CLAUDE.md. Se quiser, acrescento as duas linhas.", "respondida": true},
    {"texto": "Linha 'Banca' e justificativa do limite de 60 registros por hora ainda supõem apresentação presencial; ficam para quando você quiser revisar", "respondida": false}
  ],
  "contagem": {"decisoes": 46, "declaradas": 43, "silenciosas": 3, "duvidosas": 3, "perguntas": 16, "perguntas_respondidas": 15}
}
```
