const { buscarLivro, marcarDisponivel } = require('./acervo');

const PRAZO_DIAS = 14;
const LIMITE_POR_LEITOR = 3;
const emprestimos = [];

function emprestar(leitor, codigo, data) {
  const livro = buscarLivro(codigo);
  if (!livro || !livro.disponivel) {
    throw new Error('livro indisponível');
  }
  const abertos = emprestimos.filter((e) => e.leitor === leitor && !e.devolvidoEm);
  if (abertos.length >= LIMITE_POR_LEITOR) {
    throw new Error('limite de empréstimos atingido');
  }
  marcarDisponivel(codigo, false);
  const emprestimo = { leitor, codigo, data, devolvidoEm: null };
  emprestimos.push(emprestimo);
  return emprestimo;
}

function devolver(codigo, data) {
  const emprestimo = emprestimos.find((e) => e.codigo === codigo && !e.devolvidoEm);
  if (!emprestimo) throw new Error('empréstimo não encontrado');
  emprestimo.devolvidoEm = data;
  marcarDisponivel(codigo, true);
  return calcularMulta(emprestimo.data, data);
}

// Multa de R$ 0,50 por dia de atraso, limitada a R$ 10,00.
function calcularMulta(inicio, fim) {
  const dias = Math.floor((fim - inicio) / 86400000);
  const atraso = dias - PRAZO_DIAS;
  if (atraso <= 0) return 0;
  return Math.min(atraso * 0.5, 10);
}

module.exports = { emprestar, devolver, calcularMulta };
