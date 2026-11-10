# Revisor de decisões: engenheiro, export eng_04_design-sessao-parte1.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\engenheiro\eng_04_design-sessao-parte1.txt (SHA-256 ff94f7eaef0d0a8bd401a94ba0671cb51795c816044b86142ffaee7a63eac28f)
- Leitura do export: 5452 de 5452 linhas, em 7 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: b7004f0e-24b7-44c1-bd68-2470fc80b6f9

Texto do revisor, sem edição:

---
Li a transcrição inteira, até a última linha. A sessão cobre as oito etapas do passo 4, do plano até o PR #6, e mais o PR #5 da correção do registro simultâneo.

**Como contei.** O que a persona definiu não entrou como decisão: o plano de oito etapas que ela aprovou, as respostas de 1 a 10, as cinco premissas que ela aceitou e as instruções de correção (o traço do PR #5, o corte do XX, `tech.gimenes.maxx`, instalar o `expo-system-ui`). Entrou o que o agente escolheu sozinho. Isso inclui as escolhas que ele já tinha implementado quando pediu confirmação: as tabelas das etapas 4, 5 e 6, o ouro do SVG e o fundo do favicon. A persona confirmou todas depois, mas a escolha foi tomada antes. Por isso aparecem como decisões declaradas, e cada pedido de confirmação aparece também como pergunta.

## 1. Decisões tomadas sem perguntar

| # | Decisão | Tipo | Forma |
|---|---|---|---|
| 1 | Regra do ESLint que proíbe cor literal em `src/` | testes e processo | declarada |
| 2 | O provedor de tema não desenha nada até ler a preferência (tela em branco na abertura) | UX e visual | declarada |
| 3 | Falha ao ler ou gravar no AsyncStorage não trava o app; valor desconhecido volta ao padrão | regra de produto | declarada |
| 4 | A barra de status segue o tema do app, não o do aparelho (`ThemedStatusBar`) | UX e visual | silenciosa |
| 5 | `raios.segmentoAtivo` = 8, tirado da identidade-visual.md | UX e visual | declarada |
| 6 | Controle de tema provisório (segmentado simples) até a etapa 4 | UX e visual | declarada |
| 7 | Uma família de fonte por peso, porque o Android não escolhe arquivo por `fontWeight` | stack e arquitetura | declarada |
| 8 | `FontGate` segura a primeira pintura e, se a carga falhar, usa a fonte do sistema | UX e visual | declarada |
| 9 | Imagem, fontTools e commits do Google Fonts travados, com hash conferido | segurança | declarada |
| 10 | `@types/node`, `*.ttf binary` e manter o plugin expo-font no app.json | stack e arquitetura | declarada |
| 11 | Não reexecutar a CI vermelha da etapa 1 | testes e processo | declarada |
| 12 | Código de recusa `registro-simultaneo` | regra de produto | declarada |
| 13 | Sobrecarga de `PrimeiroLivreAsync` com conjunto de recusados (sem diferenciar maiúsculas) e stub `GravacaoSempreRecusada` (duvidosa) | stack e arquitetura | silenciosa |
| 14 | Push da `rodada/eng_04_design`, que só existia no local, para o remoto | testes e processo | declarada |
| 15 | Tolerância do e2e de fontes de 1 para 2 px | testes e processo | declarada |
| 16 | Esperar a CI terminar antes do próximo push | testes e processo | declarada |
| 17 | Conjunto de 15 ícones, com `alert` e `inbox` para erro e vazio | UX e visual | declarada |
| 18 | Prop `detailColor` para o ícone preenchido com recorte | UX e visual | declarada |
| 19 | `medal` do Lucide como fita | UX e visual | declarada |
| 20 | ApiStatusScreen fica fora do `Screen` e sem `ErrorState` | stack e arquitetura | declarada |
| 21 | Acessibilidade do `Icon`: com rótulo é `role="img"`, sem rótulo é `aria-hidden` | UX e visual | silenciosa |
| 22 | e2e e teste de rota que confirmam que a vitrine fica fora do build de produção | testes e processo | declarada |
| 23 | Anel de foco só por teclado (`:focus-visible` na web) | UX e visual | declarada |
| 24 | Button com variantes primária e secundária | UX e visual | declarada |
| 25 | "Tentar de novo" da tela de status passa a usar o Button | UX e visual | declarada |
| 26 | `outline-style: none` para tirar o contorno do navegador | UX e visual | declarada |
| 27–33 | Etapa 4: chip inativo em contorno; chip com 32 de altura; borda de 1 px no trilho; botão grande em Instrument Sans 700 tamanho 15; campo em 16; rótulo 14/600; segmento ativo desativado mantém `segmentOn` | UX e visual | declaradas |
| 34 | Segmentado navega só com Tab, sem setas | UX e visual | declarada |
| 35 | Chip exposto como checkbox | UX e visual | declarada |
| 36 | Sem teste automatizado da volta da opacidade ao soltar; conferido só no navegador | testes e processo | declarada |
| 37 | Reiniciou o Docker Desktop pela CLI sem avisar antes | testes e processo | declarada |
| 38 | e2e de controles rodado num servidor provisório, sem API, com o Docker fora | testes e processo | declarada |
| 39–44 | Etapa 5: halo sempre em `bg`; altura de 50 mais a área segura, mínimo de 84; texto padrão do erro; ícone 32; iniciais em Archivo 700 a 40%; primeiro e último nome | UX e visual | declaradas |
| 45 | Prop `aboveNav` no `Screen` | stack e arquitetura | declarada |
| 46 | Novidade também no rótulo de acessibilidade | UX e visual | declarada |
| 47 | `StateMessage.tsx` com ação opcional; anúncio ao leitor de tela só no texto | UX e visual | declarada |
| 48–56 | Etapa 6: escala do ornamento no medalhão de 48; 32 raios de 2 px; folga sempre reservada; glifo em contorno a 50%; selo 26/18/Archivo 12; faixa com raio 16; trilha com círculo 36, passo 82 e tracejado 4/4; cartão de título no componente; lacuna sem linha | UX e visual | declaradas |
| 57 | Teste que falha se houver gradiente ou sombra fora dos componentes permitidos | testes e processo | declarada |
| 58 | Conteúdo da FaixaPremio: tier e raridade em texto, pontos à direita, nota e rótulo opcionais | UX e visual | declarada |
| 59 | Vetorização com potrace, alfa ampliado 8 vezes e desfoque de 0,6 px | UX e visual | declarada |
| 60 | Ouro do token (#F5B400) no SVG, aplicado antes de perguntar | UX e visual | declarada |
| 61 | Reabrir os cortes do XX pré-processando o alfa, em vez de editar o caminho à mão | UX e visual | declarada |
| 62 | `gerar.js` rasteriza os ícones com o chromium do Playwright | stack e arquitetura | silenciosa |
| 63 | Medidas dos ícones: 760 em 1024, 620 no adaptativo, monocromático branco, favicon de 64 | UX e visual | declarada |
| 64 | Favicon sobre marinho com cantos arredondados | UX e visual | declarada |
| 65 | Remove `android-icon-background.png` (fundo só por cor); splash com `imageWidth` 200 | stack e arquitetura | declarada |
| 66 | Roda `expo prebuild`, restaura `app.json`/`package.json` e apaga `android/` | testes e processo | declarada |
| 67 | Estrutura e conteúdo dos docs de fechamento, com o aviso sobre prebuild e `android/`/`ios/` fora do git | testes e processo | declarada |
| 68 | Título do PR: "feat(mobile): passo 4, design system" | testes e processo | declarada |

## 2. Perguntas feitas à persona

Foram 23, e a persona respondeu a todas na própria transcrição. A pergunta do ouro foi feita duas vezes: ficou sem resposta na primeira e foi respondida na segunda. Contei como uma só, respondida. Os pedidos de rotina para revisar etapa ("com o seu ok, faço o commit") não entraram.

- Do plano: os itens 1 a 10 e as premissas.
- Como corrigir o job api.
- Se o ajuste do teste de fontes podia ser um commit próprio.
- As confirmações das etapas 4, 5 e 6.
- Duas vezes se o traçado estava aprovado.
- Qual ouro usar.
- Se os ícones estavam aprovados.
- Se o favicon fica sobre marinho.
- Se instala o expo-system-ui.
- Qual o identificador do app.

```json
{
  "decisoes": [
    {"descricao": "Regra do ESLint (no-restricted-syntax) que torna erro qualquer cor literal em src/", "trecho": "eslint.config.js: cor literal em src/ agora é erro de lint, o que cobre o critério de aceite.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "O ThemeProvider não desenha nada até ler a preferência, para não piscar o tema errado", "trecho": "Tela em branco na abertura: o provedor não desenha nada até ler a preferência", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Falha de leitura ou gravação no AsyncStorage não trava o app; valor desconhecido guardado cai no padrão Sistema", "trecho": "Se a leitura ou a gravação falhar, o app não trava.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "A barra de status segue o tema escolhido no app, não o do aparelho", "trecho": "// A barra de status segue o tema do app, que pode diferir do tema do aparelho.", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Raio do segmento ativo (8) tirado da identidade-visual.md, sem origem no tokens.json", "trecho": "Token sem origem no JSON: raios.segmentoAtivo (8) vem da identidade-visual.md", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Controle de tema provisório (segmentado simples) até a etapa 4", "trecho": "Controle provisório: ele é um segmentado simples, e pretendo trocá-lo pelo SegmentedControl na etapa 4.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Uma família de fonte por peso, porque o Android não escolhe arquivo por fontWeight", "trecho": "com uma família por peso, porque o Android não escolhe arquivo por fontWeight", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "FontGate segura a primeira pintura até as fontes carregarem; se falhar, usa a fonte do sistema", "trecho": "FontGate: segura a primeira pintura até as fontes carregarem. Se a carga falhar, segue com a fonte do sistema.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Geração das fontes com imagem, fontTools e commits do Google Fonts travados e hash conferido", "trecho": "rodam em contêiner, com imagem, fontTools e commits do Google Fonts travados, e conferem o hash do que baixam", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Dependências e configuração extras: @types/node, *.ttf binary no .gitattributes, manter o plugin expo-font no app.json", "trecho": "expo-font, @types/node para o teste que lê os TTFs, *.ttf binary no .gitattributes. O expo install também acrescentou o plugin expo-font ao app.json, e mantive.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Não reexecutar a CI vermelha da etapa 1 para não esconder o defeito intermitente", "trecho": "Não reexecutei a CI, porque uma nova execução podia sair verde por sorte e esconder o defeito abaixo.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Código de recusa 'registro-simultaneo' para o 409", "trecho": "Nome do código: escolhi registro-simultaneo, porque prefixo-indisponivel já significa outra coisa no cadastro.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Implementação da correção com sobrecarga de PrimeiroLivreAsync recebendo conjunto de recusados (OrdinalIgnoreCase) e stub GravacaoSempreRecusada no teste", "trecho": "var recusados = new HashSet<string>(StringComparer.OrdinalIgnoreCase);", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Push da rodada/eng_04_design, que só existia localmente, para servir de base do PR", "trecho": "a rodada/eng_04_design só existia localmente, então fiz o push dela sem mudanças, para servir de base do PR", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tolerância do e2e de largura da Archivo ampliada de 1 para 2 px", "trecho": "Ajuste, ainda sem commit: a tolerância passa a 2 px, meio pixel por letra.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Esperar a CI terminar antes do próximo push para não cancelar a execução", "trecho": "Só faço o commit e o push da etapa 3 quando ela terminar, porque um novo push na mesma branch cancelaria a execução em andamento.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conjunto de 15 ícones, com alert e inbox escolhidos para ErrorState e EmptyState", "trecho": "alert e inbox são escolha minha para ErrorState e EmptyState.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Prop detailColor para pintar o desenho interno do ícone preenchido na cor do fundo", "trecho": "criei a prop detailColor para pintar esse desenho na cor do fundo", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Usar o medal do Lucide como ícone da fita", "trecho": "Ícone fita: usei o medal do Lucide, com as fitas acima do círculo", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "ApiStatusScreen fica fora do Screen e sem ErrorState por ser provisória", "trecho": "ApiStatusScreen: não migrei para o Screen, porque é uma tela provisória.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Acessibilidade do Icon: com rótulo vira imagem acessível, sem rótulo fica aria-hidden", "trecho": "? { accessible: true, role: \"img\" as const, \"aria-label\": label } : { \"aria-hidden\": true }", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "e2e e teste de rota que confirmam que a vitrine não existe no build de produção", "trecho": "O e2e também confirma que o texto da vitrine não viaja no bundle de produção.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Anel de foco só para navegação por teclado (:focus-visible na web)", "trecho": "Foco por teclado: anel do token com 2 px de afastamento.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Button com variantes primária e secundária", "trecho": "Button: discreto com 32 de altura e 44 de toque, grande com 50, nas variantes primária e secundária.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "O 'Tentar de novo' da tela de status passa a usar o Button", "trecho": "Fora da sua lista: o \"Tentar de novo\" da tela de status passou a usar o Button", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Remover o contorno do navegador com outline-style: none", "trecho": "Largura 0 não o remove, e a correção é outline-style: none, que o e2e agora confere.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Chip inativo em contorno (line), contra o uso de surface do tokens.json", "trecho": "Fundo do chip inativo | contorno em line", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Chip com 32 de altura e 44 de toque", "trecho": "Altura do chip | 32, com 44 de toque", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Borda de 1 px em line no trilho do segmentado", "trecho": "Borda do trilho do segmentado | 1 px em line", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Texto do botão grande em Instrument Sans 700 tamanho 15", "trecho": "Texto do botão grande | Instrument Sans 700, tamanho 15", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Texto do campo em 16, fora da escala, por causa do zoom do Safari", "trecho": "Texto do campo | tamanho 16, fora da escala", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Rótulo do campo em 14, peso 600", "trecho": "Rótulo do campo | tamanho 14, peso 600", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Segmento ativo desativado mantém segmentOn, sem sombra", "trecho": "Segmento ativo desativado | mantém segmentOn, sem sombra", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Segmentado navega só com Tab, sem as setas de grupo de rádio", "trecho": "Teclado no segmentado: navega com Tab, sem as setas que um grupo de rádio costuma ter.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Chip de filtro exposto como checkbox", "trecho": "Papel do chip: é exposto como checkbox.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Sem teste automatizado da volta da opacidade ao soltar; conferido só no navegador", "trecho": "A volta da opacidade ao soltar não tem teste automatizado, porque não consegui simular o fim do toque no Jest.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Reiniciar o Docker Desktop pela CLI sem avisar a persona antes", "trecho": "Reiniciei o Docker eu mesmo. [...] Rodei docker desktop restart uma vez e voltou.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Rodar o e2e de controles num servidor provisório sem API enquanto o Docker estava fora", "trecho": "contra o build de produção num servidor provisório com o mesmo fallback do Caddy e sem API", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Halo da bolinha de novidade sempre em bg", "trecho": "Halo na aba ativa | sempre em bg, como diz o token", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Altura da navegação de 50 mais a área segura, com mínimo de 84", "trecho": "Altura com área segura | 50 + área segura, com mínimo de 84", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Texto padrão do erro: 'Não deu certo agora.' / 'Tente de novo em instantes.'", "trecho": "Texto padrão do erro | \"Não deu certo agora.\" e \"Tente de novo em instantes.\"", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ícone de 32 nos estados vazio e erro", "trecho": "Tamanho do ícone em vazio e erro | 32", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Iniciais em Archivo 700 a 40% do tamanho do avatar", "trecho": "Fonte das iniciais | Archivo 700, a 40% do tamanho do avatar", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Iniciais do primeiro e do último nome; com um nome só, uma letra", "trecho": "Iniciais | primeiro e último nome; com um nome só, uma letra", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Prop aboveNav no Screen para não somar a área segura duas vezes", "trecho": "Área segura em dobro (pendência da etapa 3): confirmei o problema e criei aboveNav no Screen, com teste.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Novidade também anunciada no rótulo de acessibilidade da aba", "trecho": "O leitor de tela também ouve \"Mural, com novidade\".", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "EmptyState e ErrorState juntos em StateMessage.tsx, com ação opcional e anúncio só no texto", "trecho": "EmptyState e ErrorState: ficam em StateMessage.tsx, com ação opcional.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Medidas do ornamento do token valem para o medalhão de 48 e escalam", "trecho": "Escala do ornamento | medidas do token valem para o medalhão de 48", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Lendário com 32 traços de 2 px", "trecho": "Raios do lendário | 32 traços de 2 px", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Com raridade, sempre reserva a folga do lendário (74 px no de 48)", "trecho": "Espaço do medalhão | com raridade, sempre reserva a folga do lendário: 74 px no de 48", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Glifo em contorno, ocupando 50% do metal", "trecho": "Glifo | contorno, ocupando 50% do metal", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Selo com altura 26, medalhão 18 e nome em Archivo 700 tamanho 12", "trecho": "Selo | altura 26, medalhão 18, nome em Archivo 700 tamanho 12", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Faixa com raio 16 e tier em negrito", "trecho": "Faixa | raio 16, tier em negrito", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Trilha com círculo 36, passo de 82 px, tracejado 4/4 e rótulo em Archivo 700 tamanho 12", "trecho": "Trilha | círculo 36, passo de 82 px, tracejado 4/4, rótulo em Archivo 700 tamanho 12", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cartão de título e resumo da trilha dentro do componente", "trecho": "Título da trilha | o cartão com título e resumo fica dentro do componente", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Lacuna no meio da trilha: os obtidos seguintes mantêm o medalhão, sem linha contínua", "trecho": "Lacuna na trilha | se um passo do meio não foi obtido, os seguintes obtidos seguem com medalhão, sem linha contínua", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Teste de regra que falha com gradiente fora de Medalhao/SeloPremio ou sombra fora do SegmentedControl", "trecho": "Teste novo de regra: falha se gradiente aparecer fora de Medalhao e SeloPremio, ou sombra fora do SegmentedControl.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conteúdo da FaixaPremio: tier e raridade em texto, pontos à direita, nota e rótulo opcionais", "trecho": "FaixaPremio: medalhão, nome, tier e raridade em texto, e pontos à direita, com nota e rótulo opcionais.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Vetorização com potrace sobre o alfa ampliado 8 vezes, com desfoque de 0,6 px", "trecho": "Traçado: potrace 2.1.8, instalado só no scratchpad, sobre o alfa do PNG ampliado 8 vezes, com um desfoque de 0,6 px", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Usar o ouro do token #F5B400 no SVG, antes de perguntar, em vez do #FAB301 do PNG", "trecho": "Usei o gold do token, #F5B400, mas o PNG é #FAB301.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Reabrir os cortes do XX pré-processando o alfa pelo eixo lido no PNG, sem editar o caminho à mão", "trecho": "antes de traçar, reabro os dois cortes com largura de 1 px, seguindo o eixo lido no alfa do PNG. Editar o caminho à mão não foi necessário.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Script design/icones/gerar.js rasteriza os ícones com o chromium do Playwright", "trecho": "const { chromium } = require(", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Medidas dos ícones: logo com 760 px no ícone de 1024, 620 no adaptativo, monocromático em branco, favicon de 64 px", "trecho": "icon.png | 1024 px, logo em ouro sobre marinho #0B2A55, com 760 px de largura", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Favicon com o XX sobre marinho e cantos arredondados", "trecho": "Usei marinho com cantos arredondados, para o ouro não perder contraste em aba clara.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Remover android-icon-background.png (fundo só por cor) e configurar expo-splash-screen com imageWidth 200", "trecho": "entrou expo-splash-screen, e saiu o android-icon-background.png, porque o fundo agora é só a cor.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Rodar expo prebuild para conferir e depois restaurar app.json/package.json e apagar android/", "trecho": "O prebuild alterou o app.json e o package.json e criou a pasta android/; restaurei os dois arquivos e removi a pasta", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Conteúdo e organização dos docs de fechamento, com aviso de que o prebuild mexe no package.json e android/ios ficam fora do git", "trecho": "`npx expo prebuild` gera `android/` e `ios/`, que ficam fora do git. Ele também mexe em `package.json`, e isso não deve entrar em commit.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Título do PR do passo 4", "trecho": "Título do PR: usei feat(mobile): passo 4, design system, porque ele cobre mais do que uma etapa.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false}
  ],
  "perguntas": [
    {"texto": "1. Origem do ícone e do splash: você tem SVG ou versão maior do logo?", "respondida": true},
    {"texto": "2. Arte do ícone: logo em ouro sobre marinho no ícone e no adaptativo, favicon com recorte do XX, splash em ouro sobre o bg de cada tema?", "respondida": true},
    {"texto": "3. Troca de tema: Sistema, Claro e Escuro, padrão Sistema, persistido com AsyncStorage?", "respondida": true},
    {"texto": "4. Dependência de ícones: só react-native-svg com os caminhos do Lucide num Icone nosso?", "respondida": true},
    {"texto": "5. Vitrine: rota só de desenvolvimento (__DEV__), fora do build de produção?", "respondida": true},
    {"texto": "6. Trilha: seguir o produto, TrilhaFamilia por itens, até 5 passos, rolando na horizontal?", "respondida": true},
    {"texto": "7. Anel de foco no claro: seguir o token, com afastamento de 2 px?", "respondida": true},
    {"texto": "8. Pressionado e desativado: desativado com surface2 e ink3, pressionado com opacidade 0,85?", "respondida": true},
    {"texto": "9. Cores de avatar: só o token avatarBg?", "respondida": true},
    {"texto": "10. Raio do chip: raio 8 e corrigir a frase no tokens.json?", "respondida": true},
    {"texto": "Premissas (me corrija se discordar): tokens.json sem mudança de estrutura, fontTools em Docker, pranchetas sem referência de fonte, nomes dos componentes, altura da navegação", "respondida": true},
    {"texto": "Como corrigir o job api? PR separado, commit nesta branch ou reexecutar até passar", "respondida": true},
    {"texto": "Aprovar o ajuste do teste de fontes como commit próprio, sem reescrever o da etapa 2?", "respondida": true},
    {"texto": "Etapa 4: confirma as sete decisões (chip, altura do chip, trilho, botão grande, texto e rótulo do campo, segmento desativado)?", "respondida": true},
    {"texto": "Etapa 5: confirma as seis decisões (halo, altura com área segura, texto do erro, ícone 32, fonte e regra das iniciais)?", "respondida": true},
    {"texto": "Etapa 6: confirma as decisões do medalhão, selo, faixa e trilha?", "respondida": true},
    {"texto": "O traçado do SVG está aprovado? (primeira versão)", "respondida": true},
    {"texto": "Qual ouro usar no SVG, o gold do token #F5B400 ou o #FAB301 do PNG? (feita duas vezes)", "respondida": true},
    {"texto": "O traçado está aprovado? (versão com os cortes do XX reabertos)", "respondida": true},
    {"texto": "Os ícones estão aprovados?", "respondida": true},
    {"texto": "Favicon sobre marinho, ou o XX sem fundo?", "respondida": true},
    {"texto": "Instalar expo-system-ui?", "respondida": true},
    {"texto": "Qual identificador do app? Por exemplo br.com.unimax.maxx, ou deixo para o passo 13?", "respondida": true}
  ],
  "contagem": {"decisoes": 68, "declaradas": 64, "silenciosas": 4, "duvidosas": 1, "perguntas": 23, "perguntas_respondidas": 23}
}
```
