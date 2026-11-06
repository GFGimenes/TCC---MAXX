ID: eng_04_design-r12
Trilha: engenheiro
Tela: passo 4 (resposta 12 do autor: aprovação visual de ícone, splash e favicon; identificador do app; liberação do fechamento)
Data: 2026-11-05
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor olhou a prancha de ícones; decisões do autor (identificador proposto pelo Cowork, aceito); redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 7: `design/icones/gerar.js` gera icon (1024, ouro sobre marinho), adaptativo (frente e monocromático, fundo só cor), splash (ouro sem fundo, bg de cada tema) e favicon (64, recorte do XX sobre marinho) a partir do SVG com as cores do `tokens.json`, reprodutível; procedência do SVG registrada no `design/README.md`; `expo prebuild` só Android (Windows), app.json e package.json restaurados e pasta android/ removida; iOS não conferido; nada rodou em aparelho ou emulador.
- Quatro decisões: prancha aprovada pelo autor; favicon sobre marinho; `expo-system-ui` instalado (aviso do prebuild sobre `userInterfaceStyle`); identificador do app `tech.gimenes.maxx` (o prebuild tinha usado `com.anonymous.maxx`). Limite declarado: o splash nativo segue o tema do aparelho, não a preferência do app.
- Etapa 8 (fechamento) liberada com a lista do que registrar e o PR com as oito etapas mais a correção do PR #5.

---
Ícones aprovados. Favicon sobre marinho com cantos arredondados fica. Instala o expo-system-ui. Identificador do app: tech.gimenes.maxx, nos dois sistemas, registrado nos docs. O limite do splash seguindo o tema do aparelho fica registrado. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 8, o fechamento: decisões 3 a 10 do plano e as das etapas, raio do segmento ativo, limite de 10 do registro simultâneo, procedência do SVG, apps/mobile/README.md, e o PR da feat/passo-04-design-system para a rodada/eng_04_design com a descrição listando as oito etapas e a correção do PR #5. Eu reviso e faço o merge.
