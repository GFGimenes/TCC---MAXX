# Exportação do design (passo 1 da trilha do engenheiro)

Esta pasta guarda a exportação completa das três sessões de Claude Design usadas no
passo 1 da trilha do engenheiro, na forma em que ficaram salvas na plataforma:
código-fonte das pranchetas, tokens de cor e tipografia, componentes, fontes e
imagens. Os prompts que geraram cada sessão estão em `../prompts-design.md`; os PNGs
das telas finais estão em `../` (um por tela, em claro e escuro, mais
`padrao-visual.png`).

Exportado em 27/09/2026 pelo Cowork (Anthropic), lendo os arquivos publicados de
cada artifact. Nenhum arquivo foi reescrito à mão. A única alteração feita nos
fontes está descrita em "Imagens", abaixo.

## O que é cada pasta

| Pasta | Sessão no registro | Tipo de artifact | Versão exportada | Conteúdo |
|---|---|---|---|---|
| `canvas-1/` | Canvas 1 "MAXX" (D1.1 a D1.6). Design final. | Design | `1790468301-6a7f` | `canvas.json` (posição, título e ordem das 15 pranchetas), 15 pranchetas `.dc.html` (login, cadastro, feed, mural, troféus e medalhas, rankings e perfil, cada uma em claro e escuro, mais `Sistema.dc.html`, o "Padrão visual MAXX" em 1280 x 1400), `support.js` e `assets/`. |
| `canvas-2/` | Canvas 2 "MAXX" (D2.1 e D2.2). Exploração descartada, mantida para comparação. | Design | `1790457483-0cce` | `canvas.json`, 13 pranchetas `.dc.html` (seis telas em claro e escuro, mais `Padrao-visual.dc.html`), `support.js` e `assets/`. |
| `canvas-3-design-system/` | Canvas 3 "MAXX · exploração de identidade 3" (D3.1 a D3.4). Origem da paleta Marinho & Ouro. | Design System | `1790465401-3d7a` | `tokens.json` (cores por tema, tipografia, espaçamento, raios), `README.md` (regras da identidade), `design-system.json`, `components/` (renderizadores das telas e dos cartões da prancheta), `fonts/` e `assets/`. |

Os arquivos `../anexos/A11-marinho-ouro-tokens.json` e `../anexos/A11-marinho-ouro-README.md`
são cópias do `tokens.json` e do `README.md` do canvas 3, feitas antes desta
exportação; continuam valendo como anexo A11 do registro.

## Como abrir as pranchetas

Cada `.dc.html` é uma página HTML que depende do `support.js` da mesma pasta (o
runtime do Claude Design, copiado de `artifact-type/dc-runtime.js` do próprio
artifact). Basta abrir o arquivo no navegador; as fontes Archivo e Instrument Sans
vêm do Google Fonts, então é preciso estar conectado para vê-las. Sem o
`support.js`, a página fica em branco, porque a marcação usa as tags `x-dc`,
`sc-if` e `sc-for` e os valores `{{ ... }}` que só o runtime resolve.

As pranchetas do canvas 1 e do canvas 2 são interativas: a navegação inferior leva de
uma tela à outra (o link aponta para o `.dc.html` da tela de destino, no mesmo tema)
e alguns controles mudam o estado da tela (filtros do mural, aviso completo, abas).

O `components/bundle.js` do canvas 3 expõe o namespace `MAXX` (ver
`components/index.d.ts`): `MAXX.tela('feed', 'dark')` devolve o HTML de uma tela,
`MAXX.par('feed')` devolve claro e escuro lado a lado, `MAXX.parte('paleta')` devolve
um cartão da prancheta. Os `preview.html` de cada componente usam essas funções e
precisam do `bundle.css` e das variáveis CSS geradas a partir do `tokens.json`, que a
plataforma injeta ao renderizar; fora dela, servem de referência de leitura.

## Imagens

Na plataforma, as imagens ficam num armazenamento de blobs e as pranchetas apontam
para `/_blob/<id>`. Na exportação, cada blob foi salvo com nome legível em `assets/`
e as referências foram trocadas pelo caminho relativo, para as páginas abrirem fora
da plataforma. Esta é a única alteração nos fontes.

| Pasta | Blob original | Arquivo exportado | O que é |
|---|---|---|---|
| canvas-1 | `f9afca1776a1135a0f01122e826084e3` | `assets/maxx-ouro.png` | Logo MAXX dourado, fundo transparente (338 x 89) |
| canvas-1 | `4e47468d7a4acf49eea2a1382c5a9bce` | `assets/foto-exemplo.jpg` | Foto de exemplo do post (campus) |
| canvas-1 | `b6787ed6136b57ad547a2ae0b5e13dd3` | `assets/unimax.png` | Selo UniMAX sobre marinho (214 x 214) |
| canvas-2 | `845df3e930657e56b960b4967dd6e172` | `assets/maxx-ouro.png` | Logo MAXX dourado (352 x 107) |
| canvas-2 | `775be1f06bc3800ffb7405bcc094407b` | `assets/maxx-branco.png` | Logo MAXX branco (352 x 107) |
| canvas-2 | `b5c6b1b5f161cce5b80dc93d3b7be930` | `assets/foto-exemplo.jpg` | Foto de exemplo do post |
| canvas-3 | `7814cadb857908df7366a990f6ec91c4` | `assets/Logos/maxx-ouro.png` | Logo MAXX dourado (347 x 100) |
| canvas-3 | `71cdfe93f1fc4fbc61a971b30e40069b` | `assets/Logos/maxx-branco.png` | Logo MAXX branco (347 x 100) |
| canvas-3 | `8d103419b23aa2d754813c3e789e14cb` | `assets/Logos/unimax.png` | Selo UniMAX (mesmo arquivo do canvas 1) |
| canvas-3 | `68e7f1feed2bc305fb21c56432a02649` | `assets/Fotos/campus.jpg` | Foto do campus, recorte da tela antiga |

No canvas 3, `design-system.json` continua listando os ids originais dos blobs nos
grupos `Logos` e `Fotos`; o `components/bundle.js` teve os quatro caminhos trocados
pelos arquivos de `assets/`.

Os logos e a foto do campus são os mesmos que o autor anexou nos prompts (anexos
A01 a A06 do registro), recortados pela plataforma.

## PNGs das telas

Os PNGs em `../` foram gerados a partir das pranchetas do canvas 1 desta pasta, com
Chromium (Playwright) em 390 x 844 e escala 2x (780 x 1688 pixels), e
`padrao-visual.png` em 1280 x 1400 na mesma escala. São a mesma marcação e o mesmo
runtime que a plataforma renderiza; diferenças, se houver, ficam por conta da versão
do navegador e das fontes.

## O que não está aqui

- O histórico de versões de cada canvas (só a última versão foi exportada).
- Os arquivos da própria plataforma (`artifact-type/`, `index.html`, `SKILL.md`),
  que são o editor do Claude Design e não fazem parte do design.
- As conversas com o Claude Design. Os prompts estão transcritos em
  `../prompts-design.md`; as respostas não foram exportadas.
