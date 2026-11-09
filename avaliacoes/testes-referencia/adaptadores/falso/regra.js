'use strict';
// Regra do produto falso: parecida com a do leigo, com tiers e ex-alunos, para que
// todos os casos tenham o que verificar. Só para testar a suíte.
module.exports = {
  fontes: ['adaptadores/falso/adaptador.js'],
  acoes: { publicar: 10, curtidaRecebida: 2, comentarioEmPostAlheio: 3 },
  limites: { comentarioUmaVezPorPost: true, acaoSobreProprioConteudoVale: false, interacaoComNaoParticipanteVale: true },
  premios: [
    { id: 'p50', nome: 'Grande', pontos: 50 },
    { id: 'p20', nome: 'Pequeno', pontos: 20 },
  ],
  premioRepetidoSoma: true,
  metas: [
    { id: 'primeiro_post', conta: 'posts', meta: 1, bonus: 20 },
    { id: 'tres_posts', conta: 'posts', meta: 3, bonus: 5 },
    { id: 'popular', conta: 'curtidas', meta: 4, bonus: 7 },
    { id: 'falante', conta: 'comentarios', meta: 2, bonus: 4 },
    { id: 'medalhista', conta: 'premios', meta: 2, bonus: 9 },
  ],
  desfazer: 'recalcula',
  ranking: { participa: ['aluno'], empate: 'mesma-posicao', ordemNoEmpate: 'nome' },
  tiers: [
    { nome: 'Bronze', min: 1, max: 30 },
    { nome: 'Prata', min: 31, max: 70 },
    { nome: 'Ouro', min: 71, max: 100 },
    { nome: 'Diamante', min: 101, max: 150 },
  ],
  exAlunos: true,
};
