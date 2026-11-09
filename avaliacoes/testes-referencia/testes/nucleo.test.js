'use strict';
// Testes do núcleo com o produto falso (sem produto real, sem rede).
//   node avaliacoes\testes-referencia\testes\nucleo.test.js

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

const { executar } = require('../nucleo/executor');
const { esperado } = require('../nucleo/regra');
const { posicoesEsperadas } = require('../nucleo/casos');
const { gravar } = require('../nucleo/relatorio');
const { ErroSuite, ErroProduto } = require('../nucleo/erros');
const regra = require('../adaptadores/falso/regra');
const { criar } = require('../adaptadores/falso/adaptador');

const naoPassaram = (r) => r.linhas.filter((l) => l.estado !== 'passou').map((l) => `${l.id}:${l.estado}`).sort();

test('modelo da regra soma ações, prêmios e metas', () => {
  assert.equal(esperado(regra, {}), 0);
  assert.equal(esperado(regra, { posts: 1 }), 30);
  assert.equal(esperado(regra, { posts: 3 }), 55);
  assert.equal(esperado(regra, { posts: 1, curtidas: 4 }), 30 + 8 + 7);
  assert.equal(esperado(regra, { premios: ['p20', 'p50'] }), 79);
});

test('posições pela política de empate', () => {
  const l = [{ pontos: 9 }, { pontos: 5 }, { pontos: 5 }, { pontos: 1 }];
  assert.deepEqual(posicoesEsperadas(l, 'mesma-posicao'), [1, 2, 2, 4]);
  assert.deepEqual(posicoesEsperadas(l, 'posicoes-distintas'), [1, 2, 3, 4]);
});

test('produto falso correto passa em todos os casos', async () => {
  const r = await executar({ adaptador: criar({}), regra });
  assert.deepEqual(naoPassaram(r), []);
  assert.equal(r.linhas.length, 46);
  for (const l of r.linhas) assert.ok(l.evidencia.length > 0, `${l.id} sem evidência`);
});

const DEFEITOS = {
  'curtida-vale-3': ['F1-curtida:falhou', 'F3-popular:falhou', 'F6:falhou', 'F7:falhou', 'F8:falhou'],
  'empate-posicoes-sequenciais': ['R2:falhou'],
  'professor-no-ranking': ['E2-naoparticipa:falhou', 'R3:falhou'],
  'aceita-tipo-texto': ['E1-texto:falhou'],
  'erro-500-post-inexistente': ['E4-curtir-inexistente:falhou'],
  'comentario-conta-sempre': ['E6-comentario:falhou'],
  'tier-30-prata': ['T2:falhou'],
};
for (const [defeito, esperadas] of Object.entries(DEFEITOS)) {
  test(`defeito plantado "${defeito}" falha exatamente onde deve`, async () => {
    const r = await executar({ adaptador: criar({ defeitos: [defeito] }), regra });
    assert.deepEqual(naoPassaram(r), esperadas);
  });
}

test('produto sem tiers e sem ex-alunos: casos ausentes, nunca falha', async () => {
  const r = await executar({ adaptador: criar({ tiers: false, exAlunos: false }), regra: { ...regra, tiers: null, exAlunos: false } });
  assert.deepEqual(naoPassaram(r), ['R6:ausente', 'T1:ausente', 'T2:ausente', 'T3:ausente', 'T4:ausente', 'T5:ausente', 'T6:ausente']);
  assert.match(r.linhas.find((l) => l.id === 'T1').evidencia[0], /sem tiers/);
});

test('regra sem prêmios nem metas: F2 e F3 ausentes', async () => {
  const r = await executar({ adaptador: criar({}), regra: { ...regra, premios: [], metas: [] }, filtro: (c) => c.id === 'F2' || c.id === 'F3' });
  assert.deepEqual(naoPassaram(r), ['F2:ausente', 'F3:ausente']);
});

test('ErroProduto numa ação válida vira falha com evidência', async () => {
  const a = criar({});
  a.concederPremio = async () => {
    throw new ErroProduto('conceder prêmio respondeu 500');
  };
  const r = await executar({ adaptador: a, regra, filtro: (c) => c.id === 'F2-p50' });
  assert.equal(r.linhas[0].estado, 'falhou');
  assert.match(r.linhas[0].evidencia[0], /respondeu 500/);
});

test('erro da suíte aborta em vez de virar falha', async () => {
  const a = criar({});
  a.pontos = async () => {
    throw new TypeError('seletor quebrado');
  };
  await assert.rejects(executar({ adaptador: a, regra, filtro: (c) => c.id === 'F1-publicar' }), (e) => e instanceof ErroSuite && /F1-publicar/.test(e.message));
});

test('relatório grava .md e .json com uma linha por caso', async () => {
  const r = await executar({ adaptador: criar({ defeitos: ['tier-30-prata'] }), regra });
  r.regra = regra;
  const pasta = fs.mkdtempSync(path.join(os.tmpdir(), 'testes-ref-'));
  try {
    const meta = { produto: 'falso', repo: 'x', ref: 'main', commit: 'abc123', data: '2026-11-08', suite: 'def456', adaptador: 'falso', ambiente: { node: process.version } };
    const arq = gravar({ saida: pasta, meta, resultado: r });
    const md = fs.readFileSync(arq.md, 'utf8');
    const json = JSON.parse(fs.readFileSync(arq.json, 'utf8'));
    assert.match(md, /Commit avaliado: `abc123`/);
    assert.match(md, /\| T2 \| .* \| \*\*falhou\*\* \|/);
    for (const l of r.linhas) assert.ok(md.includes(`| ${l.id} |`), `${l.id} fora do .md`);
    assert.equal(json.resultado.linhas.length, r.linhas.length);
    assert.equal(json.commit, 'abc123');
    const semSubir = gravar({ saida: pasta, meta: { ...meta, produto: 'nao-subiu', falhaSubida: 'porta ocupada' }, resultado: null });
    assert.match(fs.readFileSync(semSubir.md, 'utf8'), /O produto não subiu[\s\S]*porta ocupada/);
  } finally {
    fs.rmSync(pasta, { recursive: true, force: true });
  }
});
