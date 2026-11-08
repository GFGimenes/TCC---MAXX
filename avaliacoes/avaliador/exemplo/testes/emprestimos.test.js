const test = require('node:test');
const assert = require('node:assert');
const { calcularMulta } = require('../src/emprestimos');

const DIA = 86400000;

test('sem multa dentro do prazo', () => {
  assert.strictEqual(calcularMulta(0, 14 * DIA), 0);
});

test('multa de um dia de atraso', () => {
  assert.strictEqual(calcularMulta(0, 15 * DIA), 0.5);
});

test('multa limitada a dez reais', () => {
  assert.strictEqual(calcularMulta(0, 100 * DIA), 10);
});
