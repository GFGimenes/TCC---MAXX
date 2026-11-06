ID: eng_04_design-r1
Trilha: engenheiro
Tela: passo 4 (resposta 1 do autor: aprovação do plano de oito etapas e dez decisões pedidas pelo agente)
Data: 2026-11-05
Origem: leitura do Cowork (Anthropic) do export da sessão; decisões do autor (vetorização do logo e recorte do favicon decididos por ele; demais pela recomendação do agente); redigida pelo Cowork, o autor revisou.

Notas de registro:
- O agente incorporou a regra da CI do passo 3 no ciclo de cada etapa (acompanha até o fim e relata por job; correção de CI vira commit próprio depois de revisão).
- Oito etapas: tema, fontes (instanciadas com fontTools em Docker, TTFs versionados), base e vitrine, controles, navegação e estados, prêmios, ícones e splash, fechamento. Dez decisões: cinco sem decisão nos docs (origem e arte do ícone, troca de tema, dependência de ícones, vitrine) e cinco contradições entre as fontes de design (trilha por tier versus família, anel de foco, estados pressionado e desativado, cores de avatar, raio do chip), cada uma com recomendação.
- Ícone: no repo só há o logo em PNG (338 × 89). O autor enviou ao Cowork um SVG (`XAM.svg`) que, renderizado, é "MAX" em traço fino com um X só, desenho diferente do logo "MAXX" em itálico pesado do repo; o Cowork apontou a diferença e o autor decidiu pela vetorização do PNG, com aprovação visual. Favicon com recorte do "XX", também sujeito à aprovação visual na etapa 7.
- O agente observou que as pranchetas parecem renderizadas com fonte substituta e que a tipografia segue o `tokens.json`; premissa aceita.

---
Plano do passo 4 aprovado como está, oito etapas, um PR da feat/passo-04-design-system para a rodada/eng_04_design. Respostas: 1, não há vetor do logo; vetoriza o maxx-ouro.png, guarda o SVG em design/assets/ e eu aprovo o resultado por captura antes de gerar os ícones. 2, logo em ouro sobre marinho no ícone e no adaptativo, splash com o logo em ouro sobre o bg de cada tema, favicon com o recorte do XX; os três passam pela minha aprovação visual na etapa 7. 3, Sistema, Claro e Escuro, padrão Sistema, persistido com AsyncStorage, controle na vitrine e na tela de status por enquanto, lugar definitivo no perfil no passo 7. 4, só react-native-svg com os caminhos do Lucide num componente nosso. 5, vitrine só em __DEV__. 6, segue o produto: TrilhaFamilia por itens, até 5 passos, rolando na horizontal. 7, anel de foco pelo token, com os 2 px de afastamento. 8, desativado com surface2 e ink3, pressionado com opacidade 0,85. 9, avatar só com o token. 10, raio 8 e corrige a frase do tokens.json. As cinco premissas ficam. Registra 3 a 10 nos docs no fechamento. Começa pela etapa 1 e para para a minha revisão no fim dela.
