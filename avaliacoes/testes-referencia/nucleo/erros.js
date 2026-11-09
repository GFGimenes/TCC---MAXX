'use strict';
// Três tipos de interrupção de um caso:
// - Ausente: o produto não tem a regra que o caso verifica (a rubrica manda "ausente").
// - ErroProduto: o produto respondeu de um jeito inesperado a uma ação válida (5xx,
//   recusa de ação válida). Vira "falhou", com a resposta na evidência.
// - Qualquer outro erro é defeito da suíte: aborta a execução e nada é gravado.

class Ausente extends Error {
  constructor(motivo) {
    super(motivo);
    this.name = 'Ausente';
  }
}

class ErroProduto extends Error {
  constructor(mensagem, detalhe) {
    super(mensagem);
    this.name = 'ErroProduto';
    this.detalhe = detalhe;
  }
}

class ErroSuite extends Error {
  constructor(mensagem, causa) {
    super(mensagem);
    this.name = 'ErroSuite';
    this.causa = causa;
  }
}

module.exports = { Ausente, ErroProduto, ErroSuite };
