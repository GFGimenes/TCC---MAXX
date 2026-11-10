# Revisor de decisões: engenheiro, export eng_04_design-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\engenheiro\eng_04_design-sessao.txt (SHA-256 39a466245ee79cf1e090f79092e39c63b85fb8d25cd5401ddb0b208a4dca2b9e)
- Leitura do export: 5472 de 5472 linhas, em 7 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: aa758c19-c690-48dc-adf3-870835210479

Texto do revisor, sem edição:

---
Li a transcrição inteira, linhas 1 a 5472. Também li a rubrica, para o contexto.

## Como classifiquei

- **Não contei como decisão** o que a persona fixou ou aprovou antes de o agente agir. Isso inclui as respostas aos itens 1 a 10 do plano e as cinco premissas, que o agente apresentou pedindo "me corrija se discordar". Inclui também o plano de oito etapas, o desenho da correção do registro simultâneo (10 tentativas, 409, teste com oito pedidos) e o identificador `tech.gimenes.maxx`.
- **Contei como decisão** o que o agente já tinha implementado antes de pedir confirmação. É o caso das tabelas "Decisões que preciso que você confirme" das etapas 4, 5 e 6: o próprio agente escreveu "Nenhuma destas estava nos docs, e tomei cada uma para poder mostrar o resultado". Entram como **declaradas**. A persona aprovou todas depois.
- **Perguntas:** cada tabela de confirmação conta como uma pergunta só.

## 1. Decisões tomadas sem perguntar (resumo)

**Etapa 1, tema**
- Regra de ESLint que transforma cor literal em erro.
- O provedor de tema não desenha nada até ler a preferência guardada.
- Se o armazenamento falhar, ou se o valor guardado for desconhecido, o tema cai em Sistema.
- A barra de status segue o tema do app.
- O raio 8 do segmento ativo veio da identidade visual.
- Controle de tema provisório.

**Etapa 2, fontes**
- `FontGate`, que segura a primeira pintura até as fontes carregarem.
- Uma família de fonte por peso.
- Fontes de origem travadas por commit e hash.
- Dependências extras: `@types/node`, `*.ttf binary` e o plugin `expo-font`.
- Medida dos 112% feita no e2e.
- Não reexecutar a CI vermelha.

**Correção do registro simultâneo e CI**
- Nome do código de erro: `registro-simultaneo`.
- Push da `rodada/eng_04_design` para o remoto, onde ela não existia.
- Tolerância do teste de fontes subiu de 1 para 2 px.

**Etapa 3, ícones e vitrine**
- Conjunto de 15 ícones do Lucide 1.70.0.
- Prop `detailColor`.
- O `medal` do Lucide como fita.
- Ícones `alert` e `inbox`.
- `ApiStatusScreen` fora do `Screen`.
- Em produção, a rota `/vitrine` volta para o início.
- Acessibilidade do ícone.

**Etapa 4, controles**
- As sete medidas e estilos da tabela de confirmação.
- Variantes primária e secundária do botão.
- O `Button` no "Tentar de novo" da tela de status.
- `outline-style: none`.
- Anel de foco só por teclado.
- Segmentado sem navegação por setas.
- Chip exposto como checkbox.
- A volta da opacidade ao soltar ficou sem teste automatizado.
- Reinício do Docker Desktop por conta própria.

**Etapa 5, navegação e estados**
- As seis decisões da tabela de confirmação.
- Prop `aboveNav` no `Screen`.
- Novidade incluída no rótulo de acessibilidade.
- Anúncio ao leitor de tela só no texto.
- O erro da tela de status não foi trocado pelo `ErrorState`.

**Etapa 6, prêmios**
- As nove decisões da tabela de confirmação.
- Teste que restringe onde pode haver gradiente e sombra.

**Etapa 7, ícones e splash**
- Parâmetros do potrace.
- Cortes do XX reabertos por algoritmo, sem editar o caminho à mão.
- Gerador de ícones com Chromium.
- Dimensões do ícone, do adaptativo e do splash.
- Remoção de `android-icon-background.png`.
- Dependência `expo-splash-screen`.

**Etapa 8, fechamento**
- Título do PR.
- Organização da documentação.

## 2. Perguntas feitas

São 22 perguntas, todas respondidas na transcrição:

- os dez itens do plano;
- as premissas;
- como corrigir o job `api`;
- o commit separado do ajuste do teste de fontes;
- as três tabelas de confirmação;
- duas vezes, a aprovação do traçado do logo;
- o ouro do SVG, que ficou sem resposta na primeira vez e foi respondido depois de ser repetido;
- a aprovação dos ícones;
- o favicon sobre marinho;
- a instalação do `expo-system-ui`;
- o identificador do app.

```json
{
  "decisoes": [
    {"descricao": "Regra de ESLint (no-restricted-syntax) que proíbe cor literal em src/ como forma de cumprir o critério 'sem cor literal fora dos tokens'", "trecho": "eslint.config.js: cor literal em src/ agora é erro de lint, o que cobre o critério de aceite.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "ThemeProvider não desenha nada até ler a preferência guardada, para não piscar o tema errado", "trecho": "o provedor não desenha nada até ler a preferência, para não piscar o tema errado", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Falha de leitura ou gravação no AsyncStorage não trava o app; valor guardado desconhecido cai no padrão Sistema", "trecho": "Se a leitura ou a gravação falhar, o app não trava.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Barra de status (ThemedStatusBar) segue o tema do app, não o do aparelho", "trecho": "// A barra de status segue o tema do app, que pode diferir do tema do aparelho.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Token raios.segmentoAtivo = 8 tirado da identidade-visual.md, sem origem no tokens.json", "trecho": "Token sem origem no JSON: raios.segmentoAtivo (8) vem da identidade-visual.md", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Controle de tema provisório feito como segmentado simples, a ser trocado na etapa 4", "trecho": "Controle provisório: ele é um segmentado simples, e pretendo trocá-lo pelo SegmentedControl na etapa 4.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "FontGate segura a primeira pintura até as fontes carregarem e cai na fonte do sistema se a carga falhar", "trecho": "FontGate: segura a primeira pintura até as fontes carregarem. Se a carga falhar, segue com a fonte do sistema.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Uma família de fonte por peso (Archivo112-700 etc.), porque o Android não escolhe arquivo por fontWeight", "trecho": "com uma família por peso, porque o Android não escolhe arquivo por fontWeight", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Pipeline de fontes com imagem, fontTools e commits do Google Fonts travados e conferência de hash do que baixa", "trecho": "rodam em contêiner, com imagem, fontTools e commits do Google Fonts travados, e conferem o hash do que baixam", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Inclusão de @types/node, *.ttf binary no .gitattributes e manutenção do plugin expo-font acrescentado pelo expo install", "trecho": "expo-font, @types/node para o teste que lê os TTFs, *.ttf binary no .gitattributes. O expo install também acrescentou o plugin expo-font ao app.json, e mantive.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Verificação dos 112% no e2e pela largura de quatro 'M' em Archivo 800 no navegador", "trecho": "112% de verdade: no navegador, quatro \"M\" em Archivo 800 a 100 px medem cerca de 410 px", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Não reexecutar a CI vermelha da etapa 1 para não mascarar o defeito intermitente", "trecho": "Não reexecutei a CI, porque uma nova execução podia sair verde por sorte e esconder o defeito abaixo.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Nome do código de recusa 'registro-simultaneo' para o 409 de tentativas esgotadas", "trecho": "Nome do código: escolhi registro-simultaneo, porque prefixo-indisponivel já significa outra coisa no cadastro.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Push da rodada/eng_04_design, que só existia localmente, para servir de base do PR #5", "trecho": "a rodada/eng_04_design só existia localmente, então fiz o push dela sem mudanças, para servir de base do PR", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tolerância do e2e de largura da fonte ampliada de 1 px para 2 px por arredondamento no Linux da CI", "trecho": "Ajuste, ainda sem commit: a tolerância passa a 2 px, meio pixel por letra.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conjunto de 15 ícones com caminhos do Lucide 1.70.0 e arquivo LICENSE-lucide.txt junto ao componente", "trecho": "Icon: 15 ícones com caminhos do Lucide 1.70.0 ... A licença do Lucide vai junto", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Prop detailColor para pintar o recorte interno dos ícones preenchidos na cor do fundo", "trecho": "criei a prop detailColor para pintar esse desenho na cor do fundo", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ícone 'fita' feito com o medal do Lucide", "trecho": "Ícone fita: usei o medal do Lucide, com as fitas acima do círculo", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ícones alert e inbox escolhidos para ErrorState e EmptyState", "trecho": "alert e inbox são escolha minha para ErrorState e EmptyState", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "ApiStatusScreen não migrada para o Screen por ser provisória", "trecho": "ApiStatusScreen: não migrei para o Screen, porque é uma tela provisória.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Rota /vitrine com require atrás de __DEV__ e redirecionamento para o início em produção, com e2e conferindo que não entra no bundle", "trecho": "/vitrine: só em __DEV__. Em produção a rota volta para o início.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Acessibilidade do Icon: com rótulo vira imagem acessível; sem rótulo fica aria-hidden", "trecho": "? { accessible: true, role: \"img\" as const, \"aria-label\": label } : { \"aria-hidden\": true }", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Button com variantes primária e secundária, além de discreto e grande", "trecho": "Button: discreto com 32 de altura e 44 de toque, grande com 50, nas variantes primária e secundária.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Chip inativo em contorno (line), contrariando a frase de uso do tokens.json", "trecho": "Fundo do chip inativo | contorno em line", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Altura do chip 32 com 44 de toque", "trecho": "Altura do chip | 32, com 44 de toque", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Borda de 1 px em line no trilho do segmentado", "trecho": "Borda do trilho do segmentado | 1 px em line", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Texto do botão grande em Instrument Sans 700 tamanho 15", "trecho": "Texto do botão grande | Instrument Sans 700, tamanho 15", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Texto do campo em 16, fora da escala, por causa do zoom do Safari", "trecho": "Texto do campo | tamanho 16, fora da escala", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Rótulo do campo em tamanho 14, peso 600", "trecho": "Rótulo do campo | tamanho 14, peso 600", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Segmento ativo desativado mantém segmentOn, sem sombra", "trecho": "Segmento ativo desativado | mantém segmentOn, sem sombra", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Botão 'Tentar de novo' da tela de status passou a usar o Button, fora da lista pedida", "trecho": "Fora da sua lista: o \"Tentar de novo\" da tela de status passou a usar o Button", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Contorno padrão do navegador removido com outline-style: none", "trecho": "a correção é outline-style: none, que o e2e agora confere", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Anel de foco só para navegação por teclado (:focus-visible na web)", "trecho": "O anel de foco dos controles: aparece para quem navega por teclado ... vale a regra do navegador (:focus-visible)", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Segmentado navega com Tab, sem as setas de grupo de rádio", "trecho": "Teclado no segmentado: navega com Tab, sem as setas que um grupo de rádio costuma ter.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "FilterChip exposto como checkbox para acessibilidade", "trecho": "Papel do chip: é exposto como checkbox.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Volta da opacidade ao soltar sem teste automatizado, conferida só no navegador", "trecho": "A volta da opacidade ao soltar não tem teste automatizado ... Conferi no navegador", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Reinício do Docker Desktop pela CLI por conta própria", "trecho": "Reiniciei o Docker eu mesmo. ... Rodei docker desktop restart uma vez e voltou.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Prop aboveNav no Screen para não somar duas vezes a área segura inferior", "trecho": "Área segura em dobro ... confirmei o problema e criei aboveNav no Screen, com teste.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Halo da bolinha de novidade sempre em bg", "trecho": "Halo na aba ativa | sempre em bg, como diz o token", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Altura da navegação = 50 + área segura, com mínimo de 84", "trecho": "Altura com área segura | 50 + área segura, com mínimo de 84", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Texto padrão do erro 'Não deu certo agora.' / 'Tente de novo em instantes.'", "trecho": "Texto padrão do erro | \"Não deu certo agora.\" e \"Tente de novo em instantes.\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ícone de 32 em vazio e erro", "trecho": "Tamanho do ícone em vazio e erro | 32", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Iniciais do avatar em Archivo 700 a 40% do tamanho", "trecho": "Fonte das iniciais | Archivo 700, a 40% do tamanho do avatar", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Iniciais do primeiro e do último nome; com um nome só, uma letra", "trecho": "Iniciais | primeiro e último nome; com um nome só, uma letra", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Novidade da aba também anunciada no rótulo de acessibilidade", "trecho": "O leitor de tela também ouve \"Mural, com novidade\".", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "EmptyState e ErrorState num só arquivo StateMessage.tsx, com ação opcional e anúncio ao leitor de tela só no bloco de texto", "trecho": "{/* O anúncio fica só no texto: envolvendo o botão, ele o esconderia do leitor de tela. */}", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Erro da tela de status não trocado pelo ErrorState", "trecho": "Tela de status: não troquei o erro dela pelo ErrorState, porque ela é provisória", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Medidas do ornamento do token valem para o medalhão de 48 e escalam", "trecho": "Escala do ornamento | medidas do token valem para o medalhão de 48", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Lendário com 32 traços de 2 px", "trecho": "Raios do lendário | 32 traços de 2 px", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Com raridade, sempre reservar a folga do lendário (74 px no de 48)", "trecho": "Espaço do medalhão | com raridade, sempre reserva a folga do lendário: 74 px no de 48", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Glifo em contorno ocupando 50% do metal", "trecho": "Glifo | contorno, ocupando 50% do metal", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Selo com altura 26, medalhão 18 e nome em Archivo 700 tamanho 12", "trecho": "Selo | altura 26, medalhão 18, nome em Archivo 700 tamanho 12", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Faixa com raio 16 e tier em negrito", "trecho": "Faixa | raio 16, tier em negrito", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Trilha com círculo 36, passo de 82 px, tracejado 4/4 e rótulo Archivo 700 12", "trecho": "Trilha | círculo 36, passo de 82 px, tracejado 4/4, rótulo em Archivo 700 tamanho 12", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cartão com título e resumo da trilha dentro do componente TrilhaFamilia", "trecho": "Título da trilha | o cartão com título e resumo fica dentro do componente", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Lacuna na trilha: obtidos depois de um passo não obtido seguem com medalhão, sem linha contínua", "trecho": "Lacuna na trilha | se um passo do meio não foi obtido, os seguintes obtidos seguem com medalhão, sem linha contínua", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Teste que falha se houver gradiente fora de Medalhao/SeloPremio ou sombra fora do SegmentedControl", "trecho": "Teste novo de regra: falha se gradiente aparecer fora de Medalhao e SeloPremio, ou sombra fora do SegmentedControl.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Vetorização com potrace 2.1.8 sobre o alfa ampliado 8x, com desfoque de 0,6 px", "trecho": "Traçado: potrace 2.1.8, instalado só no scratchpad, sobre o alfa do PNG ampliado 8 vezes, com um desfoque de 0,6 px", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cortes do XX reabertos em 1 px pelo eixo lido no alfa antes de traçar, em vez de editar o caminho à mão", "trecho": "antes de traçar, reabro os dois cortes com largura de 1 px, seguindo o eixo lido no alfa do PNG. Editar o caminho à mão não foi necessário.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Script versionado design/icones/gerar.js que gera ícone, adaptativo, splash e favicon pelo Chromium do Playwright", "trecho": "Script: design/icones/gerar.js gera tudo a partir do SVG, com as cores do tokens.json.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Dimensões dos ícones: logo de 760 px no ícone de 1024, 620 px no adaptativo, monocromático branco, favicon de 64 px com cantos arredondados, splash com imageWidth 200", "trecho": "icon.png | 1024 px, logo em ouro sobre marinho #0B2A55, com 760 px de largura", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Remoção do android-icon-background.png, com o fundo do adaptativo só por cor", "trecho": "saiu o android-icon-background.png, porque o fundo agora é só a cor", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Dependência expo-splash-screen e configuração do plugin com fundo por tema", "trecho": "Dependência e limpeza: entrou expo-splash-screen", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Título do PR 'feat(mobile): passo 4, design system'", "trecho": "Título do PR: usei feat(mobile): passo 4, design system, porque ele cobre mais do que uma etapa.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Organização da documentação: limite do registro simultâneo na seção de autenticação e nota no README do mobile de que mudanças do prebuild não entram em commit", "trecho": "Ele também mexe em `package.json`, e isso não deve entrar em commit.", "tipo": "testes e processo", "forma": "silenciosa", "duvidosa": true}
  ],
  "perguntas": [
    {"texto": "1. Origem do ícone e do splash: você tem SVG ou versão maior do logo?", "respondida": true},
    {"texto": "2. Arte do ícone: logo em ouro sobre marinho no ícone e no adaptativo e favicon com recorte do XX? (a decisão é sua)", "respondida": true},
    {"texto": "3. Troca de tema: três opções (Sistema, Claro, Escuro), padrão Sistema, persistidas com AsyncStorage?", "respondida": true},
    {"texto": "4. Dependência de ícones: só react-native-svg com os caminhos do Lucide num Icone nosso?", "respondida": true},
    {"texto": "5. Vitrine: rota só de desenvolvimento (__DEV__), fora do build de produção?", "respondida": true},
    {"texto": "6. Trilha: seguir o produto (TrilhaFamilia por itens, até 5 passos, rolando na horizontal)?", "respondida": true},
    {"texto": "7. Anel de foco no claro: seguir o token, com afastamento de 2 px?", "respondida": true},
    {"texto": "8. Pressionado e desativado: desativado com surface2 e ink3, pressionado com opacidade 0,85?", "respondida": true},
    {"texto": "9. Cores de avatar: só o token?", "respondida": true},
    {"texto": "10. Raio do chip: raio 8 e corrigir a frase no tokens.json?", "respondida": true},
    {"texto": "Premissas (tokens.json sem mudança de estrutura, fontTools em Docker, pranchetas não servem de referência de fonte, nomes dos componentes, altura mínima 84): me corrija se discordar", "respondida": true},
    {"texto": "Como corrigir o job api? (PR separado, commit nesta branch ou reexecutar)", "respondida": true},
    {"texto": "Aprovar o ajuste do teste de fontes como commit próprio, fora do 'um commit por etapa'?", "respondida": true},
    {"texto": "Decisões da etapa 4 que preciso que você confirme (fundo e altura do chip, borda do trilho, texto do botão grande, texto e rótulo do campo, segmento ativo desativado)", "respondida": true},
    {"texto": "Decisões da etapa 5 que preciso que você confirme (halo, altura com área segura, texto do erro, ícone 32, fonte e regra das iniciais)", "respondida": true},
    {"texto": "Decisões da etapa 6 que preciso que você confirme (escala do ornamento, raios do lendário, espaço do medalhão, glifo, selo, faixa, trilha, título, lacuna)", "respondida": true},
    {"texto": "O traçado (SVG do logo) está aprovado? (primeira versão)", "respondida": true},
    {"texto": "Qual ouro usar no SVG? Token #F5B400 ou o #FAB301 do PNG", "respondida": true},
    {"texto": "O traçado está aprovado? (versão com os cortes do XX reabertos)", "respondida": true},
    {"texto": "Os ícones estão aprovados?", "respondida": true},
    {"texto": "Favicon sobre marinho com cantos arredondados, ou o XX sem fundo?", "respondida": true},
    {"texto": "Instalar expo-system-ui?", "respondida": true},
    {"texto": "Qual identificador do app? (ex.: br.com.unimax.maxx, ou deixo para o passo 13?)", "respondida": true}
  ],
  "contagem": {"decisoes": 65, "declaradas": 62, "silenciosas": 3, "duvidosas": 1, "perguntas": 23, "perguntas_respondidas": 23}
}
```
