'use strict';
// Regra de pontos que o maxx-leigo declara, lida no commit 2a7dad5 (main, rodada
// leigo_07_deploy_v2). Cada número tem a fonte, no formato arquivo:linha do produto.
// O esperado dos casos vem daqui, nunca do produto rodando.
//
// Se a main do leigo mudar, confira as fontes antes de rodar: a regra declarada é a do
// commit avaliado, e o relatório registra as duas coisas (este arquivo e o commit).

module.exports = {
  conferidaNoCommit: '2a7dad5',
  fontes: [
    'README.md:90-98 (tabela "Como funcionam os pontos")',
    'src/regras.js:4-8 (PONTOS)',
    'src/regras.js:12-20 (CONQUISTAS)',
    'src/regras.js:23-29 (MEDALHAS_PADRAO)',
    'src/pontos.js:1-3, 18, 32-34 (cálculo e ranking)',
  ],
  acoes: {
    publicar: 10, // README.md:92, src/regras.js:5
    curtidaRecebida: 2, // README.md:93, src/regras.js:7
    comentarioEmPostAlheio: 3, // README.md:94, src/regras.js:6
  },
  limites: {
    comentarioUmaVezPorPost: true, // README.md:94 "conta 1 vez por post"
    acaoSobreProprioConteudoVale: false, // README.md:98 "Curtir ou comentar o próprio post não dá pontos"
    // src/pontos.js:10-13: conta qualquer autor diferente, inclusive professor.
    interacaoComNaoParticipanteVale: true,
  },
  premios: [
    // src/regras.js:23-29; README.md:95 "+20 a +50"
    { id: 'excelencia', nome: 'Excelência acadêmica', pontos: 50 },
    { id: 'projeto', nome: 'Projeto destaque', pontos: 40 },
    { id: 'ideia', nome: 'Ideia brilhante', pontos: 30 },
    { id: 'ajudou', nome: 'Ajudou os colegas', pontos: 30 },
    { id: 'participacao', nome: 'Participação em aula', pontos: 20 },
  ],
  // Nada no README nem no código impede repetir; a tela de troféus conta "vezes" por tipo
  // (src/app.js:319-325) e o total soma cada medalha (src/pontos.js:14-15).
  premioRepetidoSoma: true,
  metas: [
    // src/regras.js:13-19; README.md:96 "+20 a +100". "medalhas" no produto = "premios" aqui.
    { id: 'primeiro_post', conta: 'posts', meta: 1, bonus: 20 },
    { id: 'fotografo', conta: 'posts', meta: 10, bonus: 50 },
    { id: 'bom_de_papo', conta: 'comentarios', meta: 10, bonus: 30 },
    { id: 'popular', conta: 'curtidas', meta: 50, bonus: 50 },
    { id: 'estrela', conta: 'curtidas', meta: 200, bonus: 100 },
    { id: 'medalhista', conta: 'premios', meta: 1, bonus: 20 },
    { id: 'colecionador', conta: 'premios', meta: 5, bonus: 60 },
  ],
  // src/pontos.js:1-3: "se um post ou curtida for apagado, a pontuação se ajusta sozinha".
  desfazer: 'recalcula',
  ranking: {
    participa: ['aluno'], // src/pontos.js:18; README.md:12 "só alunos participam"
    empate: 'mesma-posicao', // src/pontos.js:32 "Empatados ficam na mesma posição"
    ordemNoEmpate: 'nome', // src/pontos.js:34 localeCompare pt-BR
  },
  tiers: null,
  exAlunos: false,
  notas: {
    F8:
      'Ambiguidade: o README.md:94 diz "Comentar no post de um colega", e professor não é colega óbvio; ' +
      'o código (src/pontos.js:10-11) conta o post de qualquer outro autor, inclusive professor. ' +
      'O caso testa o que o código declara; a ambiguidade fica registrada, não é contada como falha. ' +
      'A curtida de professor em post de aluno é "curtida de outra pessoa" (README.md:93), sem ambiguidade.',
  },
};
