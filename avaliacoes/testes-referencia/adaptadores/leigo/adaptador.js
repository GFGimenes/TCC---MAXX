'use strict';
// Adaptador do maxx-leigo (Node, Express, SQLite, HTML renderizado no servidor).
// Traduz os verbos neutros da suíte em formulários HTTP e lê os números do HTML.
// Rotas lidas no commit 2a7dad5 (src/app.js):
//   POST /cadastrar          nome, email, curso, senha (domínio @prof.unieduk.com.br vira professor)
//   POST /posts              legenda (multer só processa multipart; urlencoded passa direto)
//   POST /posts/:id/curtir   alterna curtir e descurtir
//   POST /posts/:id/comentar texto
//   POST /posts/:id/apagar
//   POST /perfil/editar      nome, bio, curso
//   POST /u/:id/medalha      tipo_id, mensagem (só professor)
//   GET  /u/:id              pontos e posição (bloco "numeros"), lista de posts
//   GET  /ranking[?curso=]   pódio (ol.podio) e lista (ol.ranking)
// Toda leitura de página é feita por um professor observador, que não entra no ranking.

const { ErroProduto } = require('../../nucleo/erros');

const DOMINIO_ALUNO = 'unimax.edu.br';
const DOMINIO_PROFESSOR = 'prof.unieduk.com.br';
const SENHA = 'senha-da-suite-123';
const MEDALHAS_POSICAO = { '🥇': 1, '🥈': 2, '🥉': 3 };

const numero = (t) => Number(String(t).replace(/\./g, '').trim());

// Texto curto da página de erro, para a evidência.
function resumoErro(html) {
  const m = /<main class="conteudo">([\s\S]*?)<\/main>/.exec(html);
  const texto = (m ? m[1] : html).replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim();
  return texto.slice(0, 120);
}

function criar({ base, regra }) {
  if (!base) throw new Error('O adaptador do leigo precisa da URL base.');
  const historico = [];
  let seq = 0;
  let observador = null;
  let ultimoAluno = null; // perfil onde o professor vê o formulário de medalha
  let tiposDeMedalha = null; // nome -> { id, pontos }
  let evidenciaTiers = null;

  async function pedir(usuario, metodo, caminho, corpo) {
    const opcoes = { method: metodo, redirect: 'manual', headers: {} };
    if (usuario && usuario.cookie) opcoes.headers.cookie = usuario.cookie;
    if (corpo) {
      const params = new URLSearchParams();
      for (const [k, v] of Object.entries(corpo)) if (v !== undefined) params.append(k, v);
      opcoes.body = params;
      opcoes.headers['content-type'] = 'application/x-www-form-urlencoded';
    }
    const r = await fetch(base + caminho, opcoes);
    const setCookie = r.headers.get('set-cookie');
    if (usuario && setCookie && /^maxx_sessao=/.test(setCookie)) usuario.cookie = setCookie.split(';')[0];
    const html = await r.text();
    historico.push({ metodo, caminho, status: r.status });
    return { status: r.status, local: r.headers.get('location'), html };
  }

  // Ação válida: espera o redirecionamento de sucesso; qualquer outra coisa é do produto.
  async function acao(usuario, caminho, corpo, descricao) {
    const r = await pedir(usuario, 'POST', caminho, corpo);
    if (r.status !== 302) throw new ErroProduto(`${descricao}: POST ${caminho} respondeu ${r.status}`, resumoErro(r.html));
    return r;
  }

  async function pagina(caminho) {
    const obs = await getObservador();
    const r = await pedir(obs, 'GET', caminho);
    if (r.status !== 200) throw new ErroProduto(`GET ${caminho} respondeu ${r.status}`, resumoErro(r.html));
    return r.html;
  }

  async function cadastrar(papel, { nome, curso }) {
    seq += 1;
    const dominio = papel === 'professor' ? DOMINIO_PROFESSOR : DOMINIO_ALUNO;
    const email = `suite.${Date.now().toString(36)}.${seq}@${dominio}`;
    const u = { nome, curso, papel, email, cookie: null };
    await acao(u, '/cadastrar', { nome, email, curso, senha: SENHA }, `cadastro de ${papel}`);
    // O id do próprio usuário está no link "Perfil" da navegação.
    const r = await pedir(u, 'GET', '/novo');
    const m = /href="\/u\/(\d+)" class="[^"]*" aria-label="Perfil"/.exec(r.html);
    if (!m) throw new Error('Não achei o id do usuário recém-cadastrado na navegação.');
    u.id = Number(m[1]);
    return u;
  }

  async function getObservador() {
    if (!observador) observador = await cadastrar('professor', { nome: 'Observador da Suíte', curso: 'Administração' });
    return observador;
  }

  async function idDoTipo(premioId) {
    if (!tiposDeMedalha) {
      // As opções do formulário de medalha, vistas por um professor no perfil de um aluno
      // já criado pela suíte (criar um aluno só para isso o poria no ranking).
      if (!ultimoAluno) throw new Error('Nenhum aluno criado ainda para ler os tipos de medalha.');
      const html = await pagina(`/u/${ultimoAluno.id}`);
      tiposDeMedalha = {};
      const re = /<option value="(\d+)">\S+ (.+?) \(\+(\d+) pts\)<\/option>/g;
      let m;
      while ((m = re.exec(html))) tiposDeMedalha[m[2]] = { id: m[1], pontos: Number(m[3]) };
      if (!Object.keys(tiposDeMedalha).length) throw new Error('Não achei os tipos de medalha no formulário.');
    }
    const p = regra.premios.find((x) => x.id === premioId);
    const t = p && tiposDeMedalha[p.nome];
    if (!t) throw new ErroProduto(`O produto não oferece a medalha "${p ? p.nome : premioId}" declarada na regra.`);
    return t.id;
  }

  function lerRanking(html) {
    const linhas = [];
    const podio = /<ol class="podio"[^>]*>([\s\S]*?)<\/ol>/.exec(html);
    if (podio) {
      for (const li of podio[1].split(/<li class="podio-/).slice(1)) {
        const id = /href="\/u\/(\d+)"/.exec(li);
        const pts = /<small>([\d.]+) pts<\/small>/.exec(li);
        const pos = /aria-label="(\d+)º lugar"/.exec(li);
        if (!id || !pts || !pos) throw new Error('Linha do pódio fora do formato esperado.');
        linhas.push({ id: Number(id[1]), pontos: numero(pts[1]), posicao: Number(pos[1]) });
      }
    }
    const lista = /<ol class="ranking">([\s\S]*?)<\/ol>/.exec(html);
    if (lista) {
      for (const li of lista[1].split(/<li class="/).slice(1)) {
        const pos = /<span class="pos">([^<]+)<\/span>/.exec(li);
        const id = /href="\/u\/(\d+)"/.exec(li);
        const pts = /<span class="total">([\d.]+) <small>pts<\/small><\/span>/.exec(li);
        if (!id || !pts || !pos) throw new Error('Linha do ranking fora do formato esperado.');
        const p = pos[1].trim();
        linhas.push({ id: Number(id[1]), pontos: numero(pts[1]), posicao: MEDALHAS_POSICAO[p] || Number(p.replace('º', '')) });
      }
    }
    return linhas;
  }

  return {
    historico,
    async capacidades() {
      const r = await pedir(null, 'GET', '/cadastrar');
      const select = /<select name="curso"[^>]*>([\s\S]*?)<\/select>/.exec(r.html);
      if (!select) throw new Error('Não achei a lista de cursos no cadastro.');
      const cursos = [...select[1].matchAll(/<option value="([^"]+)"/g)].map((m) => m[1].replace(/&amp;/g, '&'));
      if (!evidenciaTiers) {
        const telas = [await pagina('/ranking'), await pagina(`/u/${(await getObservador()).id}`)].join('\n');
        const achados = telas.match(/\b(tiers?|bronze|prata|diamante)\b/gi) || [];
        evidenciaTiers =
          'O produto não tem tiers: o código do commit avaliado não tem tier, Bronze, Prata nem Diamante ' +
          '("ouro" só aparece como classe CSS em src/views.js:454); prêmios valem pontos fixos (src/regras.js:23-29). ' +
          `Conferido no ar: telas de ranking e perfil com ${achados.length} menção(ões) a tier${achados.length ? ` (${achados.join(', ')})` : ''}.`;
      }
      return {
        tiers: false,
        exAlunos: false,
        rankingPorCurso: true,
        premios: true,
        cursos,
        evidenciaAusencia: {
          tiers: evidenciaTiers,
          exAlunos: 'O produto não tem ex-alunos: usuarios.papel só admite aluno, professor e admin (src/db.js:25), sem status de formado.',
        },
      };
    },
    async criarAluno({ curso, nome }) {
      ultimoAluno = await cadastrar('aluno', { nome, curso });
      return ultimoAluno;
    },
    async criarProfessor({ nome }) {
      return cadastrar('professor', { nome, curso: 'Administração' });
    },
    async publicar(u, { texto }) {
      await acao(u, '/posts', { legenda: texto }, 'publicar');
      const html = await pagina(`/u/${u.id}`);
      const m = /<a href="\/posts\/(\d+)" class="grade-item"/.exec(html);
      if (!m) throw new ErroProduto('O post publicado não aparece no perfil do autor.');
      return { id: Number(m[1]) };
    },
    async curtir(u, post) {
      await acao(u, `/posts/${post.id}/curtir`, {}, 'curtir');
    },
    async descurtir(u, post) {
      // No leigo, curtir de novo desfaz a curtida (src/app.js:245-252).
      await acao(u, `/posts/${post.id}/curtir`, {}, 'descurtir');
    },
    async comentar(u, post, texto) {
      await acao(u, `/posts/${post.id}/comentar`, { texto }, 'comentar');
    },
    async apagarPost(u, post) {
      await acao(u, `/posts/${post.id}/apagar`, {}, 'apagar post');
    },
    async editarPerfil(u) {
      await acao(u, '/perfil/editar', { nome: u.nome, bio: 'bio editada pela suíte', curso: u.curso }, 'editar perfil');
    },
    async concederPremio(prof, aluno, premioId) {
      const tipo = await idDoTipo(premioId);
      await acao(prof, `/u/${aluno.id}/medalha`, { tipo_id: tipo, mensagem: 'concedida pela suíte' }, 'conceder medalha');
    },
    async pontos(aluno) {
      const html = await pagina(`/u/${aluno.id}`);
      const m = /<div><strong>([\d.]+)<\/strong><span>pontos<\/span><\/div>/.exec(html);
      if (!m) throw new Error(`Não achei os pontos no perfil ${aluno.id}.`);
      return numero(m[1]);
    },
    async posicao(aluno) {
      const html = await pagina(`/u/${aluno.id}`);
      const m = /<div><strong>(\d+|–)º<\/strong><span>no geral<\/span><\/div>/.exec(html);
      if (!m) throw new Error(`Não achei a posição no perfil ${aluno.id}.`);
      return m[1] === '–' ? null : Number(m[1]);
    },
    async ranking({ curso } = {}) {
      return lerRanking(await pagina(curso ? `/ranking?curso=${encodeURIComponent(curso)}` : '/ranking'));
    },
    async pedidoInvalido(tipo, c) {
      const tipoValido = async () => idDoTipo(c.premio);
      const medalha = (alvo, tipoId) => ({ metodo: 'POST', caminho: `/u/${alvo}/medalha`, corpo: { tipo_id: tipoId, mensagem: 'x' } });
      switch (tipo) {
        case 'premio-tipo-ausente': return medalha(c.aluno.id, undefined);
        case 'premio-tipo-vazio': return medalha(c.aluno.id, '');
        case 'premio-tipo-texto': return medalha(c.aluno.id, 'abc');
        case 'premio-tipo-decimal': return medalha(c.aluno.id, '1.5');
        case 'premio-tipo-negativo': return medalha(c.aluno.id, '-1');
        case 'premio-tipo-inexistente': return medalha(c.aluno.id, '999999');
        case 'premio-alvo-inexistente': return medalha(999999, await tipoValido());
        case 'premio-alvo-texto': return medalha('abc', await tipoValido());
        case 'premio-alvo-professor': return medalha(c.alvo.id, await tipoValido());
        case 'premio-por-aluno': return medalha(c.aluno.id, await tipoValido());
        case 'curtir-post-inexistente': return { metodo: 'POST', caminho: '/posts/999999/curtir', corpo: {} };
        case 'curtir-post-id-texto': return { metodo: 'POST', caminho: '/posts/abc/curtir', corpo: {} };
        case 'comentar-post-inexistente': return { metodo: 'POST', caminho: '/posts/999999/comentar', corpo: { texto: 'x' } };
        case 'post-vazio': return { metodo: 'POST', caminho: '/posts', corpo: { legenda: '' } };
        case 'comentario-vazio': return { metodo: 'POST', caminho: `/posts/${c.post.id}/comentar`, corpo: { texto: '' } };
        case 'curtida-repetida': return { metodo: 'POST', caminho: `/posts/${c.post.id}/curtir`, corpo: {} };
        case 'ranking-filtro-invalido': return { metodo: 'GET', caminho: '/ranking?curso=curso-que-nao-existe' };
        case 'premio-repetido': return null;
        default: throw new Error(`Pedido inválido desconhecido: ${tipo}`);
      }
    },
    async bruto(ator, { metodo, caminho, corpo }) {
      const r = await pedir(ator, metodo, caminho, corpo);
      const resumo = r.status === 302 ? `redirecionou para ${r.local}` : resumoErro(r.html);
      return { status: r.status, resumo };
    },
  };
}

module.exports = { criar };
