'use strict';
// Roda os casos contra um adaptador e devolve uma linha por caso:
// { id, grupo, titulo, estado: 'passou' | 'falhou' | 'ausente', evidencia: [..], duracaoMs }.
// Defeito da suíte (qualquer erro que não seja Ausente nem ErroProduto) lança ErroSuite
// e interrompe tudo: nunca vira falha do produto.

const { Ausente, ErroProduto, ErroSuite } = require('./erros');
const { esperado, explicar } = require('./regra');
const { casos: catalogo } = require('./casos');

const MAX_PEDIDOS_NA_EVIDENCIA = 12;

function formatar(v) {
  return typeof v === 'string' ? `"${v}"` : JSON.stringify(v);
}

function resumirPedidos(pedidos) {
  if (pedidos.length <= MAX_PEDIDOS_NA_EVIDENCIA) return pedidos;
  const meio = pedidos.length - MAX_PEDIDOS_NA_EVIDENCIA;
  return [...pedidos.slice(0, 4), `(${meio} pedidos omitidos)`, ...pedidos.slice(-(MAX_PEDIDOS_NA_EVIDENCIA - 4))];
}

async function executar({ adaptador: a, regra, filtro, aoTerminarCaso }) {
  const cap = await a.capacidades();
  const usuarios = new Map(); // id -> { nome, curso, papel }
  const pool = [];
  let seq = 0;

  const registrar = (u, papel) => {
    usuarios.set(u.id, { nome: u.nome, curso: u.curso || null, papel });
    return u;
  };
  const novoAluno = async (opts = {}) => {
    seq += 1;
    const curso = opts.curso || cap.cursos[0];
    return registrar(await a.criarAluno({ curso, nome: opts.nome || `Aluno ${String(seq).padStart(4, '0')}` }), 'aluno');
  };
  const novoProfessor = async () => {
    seq += 1;
    return registrar(await a.criarProfessor({ nome: `Professor ${String(seq).padStart(4, '0')}` }), 'professor');
  };

  const compartilhado = {};
  const linhas = [];
  const lista = catalogo(regra).filter((c) => !filtro || filtro(c));

  for (const caso of lista) {
    const checks = [];
    const notas = [];
    const inicioPedidos = a.historico.length;
    const inicio = Date.now();
    const ctx = {
      a,
      regra,
      cap,
      get dadosRanking() {
        return compartilhado.dadosRanking;
      },
      set dadosRanking(v) {
        compartilhado.dadosRanking = v;
      },
      aluno: novoAluno,
      professor: novoProfessor,
      async pool(n) {
        while (pool.length < n) pool.push(await novoAluno({ nome: `Leitor ${String(pool.length + 1).padStart(4, '0')}` }));
        return pool.slice(0, n);
      },
      nomeDe: (id) => (usuarios.get(id) || {}).nome || `id ${id}`,
      cursoDe: (id) => (usuarios.get(id) || {}).curso,
      idsNaoParticipantes: () => new Set([...usuarios].filter(([, u]) => !regra.ranking.participa.includes(u.papel)).map(([id]) => id)),
      confere(rotulo, esp, obt) {
        const ok = JSON.stringify(esp) === JSON.stringify(obt);
        checks.push({ ok, texto: `${rotulo}: esperado ${formatar(esp)}, obtido ${formatar(obt)}` });
        return ok;
      },
      confereQue(rotulo, cond, detalhe) {
        checks.push({ ok: Boolean(cond), texto: `${rotulo}: ${detalhe}` });
        return Boolean(cond);
      },
      anota(texto) {
        notas.push(texto);
      },
      async pontos(aluno, estado, rotulo) {
        const esp = esperado(regra, estado);
        const obt = await a.pontos(aluno);
        const ok = esp === obt;
        checks.push({ ok, texto: `${rotulo}: esperado ${esp} (${explicar(regra, estado)}), obtido ${obt}` });
        return ok;
      },
    };

    let estado;
    const evidencia = [];
    try {
      await caso.rodar(ctx);
      estado = checks.length && checks.every((c) => c.ok) ? 'passou' : 'falhou';
      if (!checks.length) evidencia.push('o caso não fez nenhuma conferência');
    } catch (e) {
      if (e instanceof Ausente) {
        estado = 'ausente';
        evidencia.push(e.message);
      } else if (e instanceof ErroProduto) {
        estado = 'falhou';
        evidencia.push(`resposta inesperada do produto: ${e.message}${e.detalhe ? ` (${e.detalhe})` : ''}`);
      } else {
        throw new ErroSuite(`Erro da suíte no caso ${caso.id}: ${e.message}`, e);
      }
    }
    for (const c of checks) evidencia.push(`${c.ok ? 'ok' : 'FALHA'}: ${c.texto}`);
    for (const n of notas) evidencia.push(`nota: ${n}`);
    const pedidos = a.historico.slice(inicioPedidos).map((p) => `${p.metodo} ${p.caminho} -> ${p.status}`);
    const linha = {
      id: caso.id,
      grupo: caso.grupo,
      titulo: caso.titulo,
      estado,
      evidencia,
      pedidos: estado === 'ausente' ? [] : resumirPedidos(pedidos),
      totalPedidos: pedidos.length,
      duracaoMs: Date.now() - inicio,
    };
    linhas.push(linha);
    if (aoTerminarCaso) aoTerminarCaso(linha);
  }

  const resumo = { passou: 0, falhou: 0, ausente: 0 };
  for (const l of linhas) resumo[l.estado] += 1;
  return { capacidades: cap, linhas, resumo, usuariosCriados: usuarios.size };
}

module.exports = { executar };
