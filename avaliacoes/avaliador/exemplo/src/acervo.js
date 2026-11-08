// Acervo em memória. Sem persistência: o exemplo existe só para o ensaio do avaliador.
const livros = new Map();

function cadastrarLivro(codigo, titulo) {
  if (!codigo || !titulo) {
    throw new Error('codigo e titulo são obrigatórios');
  }
  livros.set(codigo, { codigo, titulo, disponivel: true });
  return livros.get(codigo);
}

function buscarLivro(codigo) {
  return livros.get(codigo) || null;
}

function marcarDisponivel(codigo, disponivel) {
  const livro = livros.get(codigo);
  if (livro) livro.disponivel = disponivel;
}

module.exports = { cadastrarLivro, buscarLivro, marcarDisponivel };
