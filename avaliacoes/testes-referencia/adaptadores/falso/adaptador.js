'use strict';
// Produto falso em memória, com a interface completa do adaptador. Implementa a regra
// por conta própria (não usa nucleo/regra.js), para que os testes da suíte comparem duas
// implementações independentes. Defeitos podem ser plantados por opção:
//
//   defeitos: [
//     'curtida-vale-3',              curtida recebida vale 3 em vez de 2
//     'empate-posicoes-sequenciais', empatados ganham posições 1, 2, 3...
//     'professor-no-ranking',        professores entram no ranking
//     'aceita-tipo-texto',           prêmio com tipo em texto vira o primeiro prêmio
//     'erro-500-post-inexistente',   curtir post inexistente devolve 500
//     'comentario-conta-sempre',     cada comentário conta, mesmo no mesmo post
//     'tier-30-prata',               30 pontos cai em Prata
//   ]
//   tiers: false, exAlunos: false    o produto não tem a regra

const { ErroProduto } = require('../../nucleo/erros');

const TABELA_TIERS = [
  ['Bronze', 1, 30],
  ['Prata', 31, 70],
  ['Ouro', 71, 100],
  ['Diamante', 101, 150],
];
const PREMIOS = { p50: 50, p20: 20 };
const METAS = [
  ['posts', 1, 20],
  ['posts', 3, 5],
  ['curtidas', 4, 7],
  ['comentarios', 2, 4],
  ['premios', 2, 9],
];

function criar(opcoes = {}) {
  const defeitos = new Set(opcoes.defeitos || []);
  const comTiers = opcoes.tiers !== false;
  const comExAlunos = opcoes.exAlunos !== false;
  const historico = [];
  const usuarios = new Map();
  const posts = new Map();
  const curtidas = new Set();
  const comentarios = [];
  const premios = [];
  let seq = 0;

  const anotar = (caminho, status) => {
    historico.push({ metodo: 'FALSO', caminho, status });
    return status;
  };

  function novoUsuario(papel, { nome, curso }) {
    seq += 1;
    const u = { id: seq, nome, curso: papel === 'aluno' ? curso : null, papel, ex: false };
    usuarios.set(u.id, u);
    anotar(`criar ${papel}`, 201);
    return { ...u };
  }

  function contas(id) {
    const meus = [...posts.values()].filter((p) => p.autor === id && p.conta);
    const recebidas = [...curtidas].map((c) => c.split(':').map(Number)).filter(([pid, uid]) => posts.get(pid)?.autor === id && posts.get(pid).conta && uid !== id);
    const meusComentarios = comentarios.filter((c) => c.autor === id && c.conta && posts.get(c.post)?.autor !== id);
    const comentados = defeitos.has('comentario-conta-sempre') ? meusComentarios.length : new Set(meusComentarios.map((c) => c.post)).size;
    const meusPremios = premios.filter((p) => p.aluno === id);
    return { posts: meus.length, curtidas: recebidas.length, comentarios: comentados, premios: meusPremios.length, valorPremios: meusPremios.reduce((s, p) => s + PREMIOS[p.premio], 0) };
  }

  function total(id) {
    const c = contas(id);
    let t = c.posts * 10 + c.curtidas * (defeitos.has('curtida-vale-3') ? 3 : 2) + c.comentarios * 3 + c.valorPremios;
    for (const [conta, meta, bonus] of METAS) if (c[conta] >= meta) t += bonus;
    return t;
  }

  function lista(curso) {
    const participantes = [...usuarios.values()].filter((u) => u.papel === 'aluno' || (defeitos.has('professor-no-ranking') && u.papel === 'professor'));
    const l = participantes
      .filter((u) => !curso || u.curso === curso)
      .map((u) => ({ id: u.id, nome: u.nome, pontos: total(u.id) }))
      .sort((a, b) => b.pontos - a.pontos || a.nome.localeCompare(b.nome, 'pt-BR'));
    l.forEach((x, i) => {
      x.posicao = defeitos.has('empate-posicoes-sequenciais') ? i + 1 : 1 + l.filter((y) => y.pontos > x.pontos).length;
    });
    return l.map(({ id, pontos, posicao }) => ({ id, pontos, posicao }));
  }

  const ativo = (u) => !usuarios.get(u.id).ex;

  function conceder(prof, alunoId, premio) {
    const p = usuarios.get(prof.id);
    if (!p || p.papel !== 'professor') return 403;
    const alvo = usuarios.get(alunoId);
    if (!alvo) return 404;
    if (alvo.papel !== 'aluno') return 400;
    if (!(premio in PREMIOS)) return 400;
    premios.push({ aluno: alunoId, premio });
    return 302;
  }

  return {
    historico,
    async capacidades() {
      return {
        tiers: comTiers,
        exAlunos: comExAlunos,
        rankingPorCurso: true,
        premios: true,
        cursos: ['Curso A', 'Curso B'],
        evidenciaAusencia: { tiers: 'falso sem tiers (opção tiers: false)', exAlunos: 'falso sem ex-alunos (opção exAlunos: false)' },
      };
    },
    async criarAluno(o) {
      return novoUsuario('aluno', o);
    },
    async criarProfessor(o) {
      return novoUsuario('professor', o);
    },
    async publicar(u) {
      seq += 1;
      posts.set(seq, { id: seq, autor: u.id, conta: ativo(u) });
      anotar('publicar', 302);
      return { id: seq };
    },
    async curtir(u, post) {
      curtidas.add(`${post.id}:${u.id}`);
      anotar(`curtir ${post.id}`, 302);
    },
    async descurtir(u, post) {
      curtidas.delete(`${post.id}:${u.id}`);
      anotar(`descurtir ${post.id}`, 302);
    },
    async comentar(u, post, texto) {
      comentarios.push({ post: post.id, autor: u.id, texto, conta: ativo(u) });
      anotar(`comentar ${post.id}`, 302);
    },
    async apagarPost(u, post) {
      posts.delete(post.id);
      anotar(`apagar ${post.id}`, 302);
    },
    async editarPerfil() {
      anotar('editar perfil', 302);
    },
    async concederPremio(prof, aluno, premio) {
      const s = anotar(`premio ${premio} para ${aluno.id}`, conceder(prof, aluno.id, premio));
      if (s !== 302) throw new ErroProduto(`conceder prêmio respondeu ${s}`);
    },
    async pontos(aluno) {
      anotar(`pontos ${aluno.id}`, 200);
      return total(aluno.id);
    },
    async posicao(aluno) {
      anotar(`posicao ${aluno.id}`, 200);
      return (lista().find((l) => l.id === aluno.id) || {}).posicao ?? null;
    },
    async ranking({ curso } = {}) {
      anotar(`ranking ${curso || 'geral'}`, 200);
      return lista(curso);
    },
    async formarAluno(aluno) {
      usuarios.get(aluno.id).ex = true;
      anotar(`formar ${aluno.id}`, 302);
    },
    async pedidoInvalido(tipo, ctx) {
      return { tipo, ctx };
    },
    async bruto(ator, { tipo, ctx }) {
      let status;
      const prefixo = 'premio-tipo-';
      if (tipo.startsWith(prefixo)) {
        const t = tipo.slice(prefixo.length);
        if (t === 'texto' && defeitos.has('aceita-tipo-texto')) status = conceder(ator, ctx.aluno.id, 'p50');
        else status = conceder(ator, ctx.aluno.id, { ausente: undefined, vazio: '', texto: 'abc', decimal: '1.5', negativo: '-1', inexistente: 'p999' }[t]);
      } else if (tipo === 'premio-alvo-inexistente') status = conceder(ator, 999999, ctx.premio);
      else if (tipo === 'premio-alvo-texto') status = conceder(ator, NaN, ctx.premio);
      else if (tipo === 'premio-alvo-professor') status = conceder(ator, ctx.alvo.id, ctx.premio);
      else if (tipo === 'premio-por-aluno') status = conceder(ator, ctx.aluno.id, ctx.premio);
      else if (tipo === 'curtir-post-inexistente') status = defeitos.has('erro-500-post-inexistente') ? 500 : 404;
      else if (tipo === 'curtir-post-id-texto' || tipo === 'comentar-post-inexistente') status = 404;
      else if (tipo === 'post-vazio' || tipo === 'comentario-vazio') status = 400;
      else if (tipo === 'curtida-repetida') {
        const chave = `${ctx.post.id}:${ator.id}`;
        if (curtidas.has(chave)) curtidas.delete(chave);
        else curtidas.add(chave);
        status = 302;
      } else if (tipo === 'ranking-filtro-invalido') status = 200;
      else throw new Error(`pedido inválido desconhecido no falso: ${tipo}`);
      anotar(`bruto ${tipo}`, status);
      return { status };
    },
    async premioPorTier(prof, pontos) {
      anotar(`premio por tier ${pontos}`, 200);
      if (defeitos.has('tier-30-prata') && pontos === 30) return { aceito: true, tier: 'Prata' };
      const t = TABELA_TIERS.find(([, min, max]) => pontos >= min && pontos <= max);
      return t ? { aceito: true, tier: t[0] } : { aceito: false };
    },
    async tierDoAluno() {
      anotar('tier do aluno', 200);
      return null;
    },
  };
}

module.exports = { criar };
