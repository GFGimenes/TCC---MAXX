'use strict';
// Catálogo de casos em linguagem neutra. Nenhum caso conhece rota, tela ou stack:
// todos falam com o produto pelos verbos do adaptador e tiram o esperado da regra
// declarada (nucleo/regra.js).
//
// Cada caso: { id, grupo, titulo, rodar(ctx) }. O contexto (executor.js) dá:
//   ctx.a, ctx.regra, ctx.cap            adaptador, regra declarada, capacidades
//   ctx.aluno(opts), ctx.professor()     cria usuários próprios do caso
//   ctx.pool(n)                          n alunos reaproveitados (para curtir)
//   ctx.confere(rotulo, esperado, obtido)
//   ctx.confereQue(rotulo, condicao, detalhe)
//   ctx.anota(texto)
//   ctx.pontos(aluno, estado, rotulo)    confere o total do aluno contra a regra

const { Ausente } = require('./erros');
const { esperado } = require('./regra');

const GRUPOS = {
  F: 'Regra de pontos (fronteiras)',
  E: 'Entradas inválidas',
  R: 'Ranking',
  T: 'Tiers',
};

const eh4xx = (s) => s >= 400 && s < 500;

// ---------- helpers ----------

function exigirAcao(ctx, acao) {
  if (ctx.regra.acoes[acao] === undefined) throw new Ausente(`A regra declarada não tem pontos para a ação "${acao}".`);
}

function premioMaisBarato(regra) {
  if (!regra.premios.length) throw new Ausente('A regra declarada não tem itens de prêmio.');
  return [...regra.premios].sort((x, y) => x.pontos - y.pontos)[0].id;
}

// Pedido de entrada inválida: se o produto não tem esse tipo de entrada, o caso é ausente.
// Passa se o produto recusa com 4xx e os pontos dos vigiados não mudam.
async function invalido(ctx, tipo, { ator, contexto, vigiados = [] }) {
  const pedido = await ctx.a.pedidoInvalido(tipo, contexto);
  if (pedido === null) throw new Ausente(`O produto não tem entrada correspondente a "${tipo}".`);
  const r = await ctx.a.bruto(ator, pedido);
  ctx.confereQue('recusa com 4xx', eh4xx(r.status), `status ${r.status}${r.resumo ? `, ${r.resumo}` : ''}`);
  for (const [aluno, estado, rotulo] of vigiados) await ctx.pontos(aluno, estado, rotulo);
  return r;
}

// Posições esperadas de uma lista já na ordem exibida, pela política de empate.
function posicoesEsperadas(lista, politica) {
  if (politica === 'mesma-posicao') {
    return lista.map((x) => 1 + lista.filter((y) => y.pontos > x.pontos).length);
  }
  if (politica === 'posicoes-distintas') return lista.map((_, i) => i + 1);
  throw new Error(`Política de empate desconhecida: ${politica}`);
}

function conferirOrdem(ctx, lista, rotulo) {
  const fora = [];
  for (let i = 1; i < lista.length; i++) if (lista[i].pontos > lista[i - 1].pontos) fora.push(i);
  ctx.confereQue(
    `${rotulo}: pontos em ordem decrescente (${lista.length} linhas)`,
    fora.length === 0,
    fora.length ? fora.slice(0, 3).map((i) => `linha ${i + 1} (${lista[i].pontos}) acima de ${lista[i - 1].pontos}`).join('; ') : 'ok',
  );
}

function conferirEmpate(ctx, lista, rotulo) {
  const { empate, ordemNoEmpate } = ctx.regra.ranking;
  const esperadas = posicoesEsperadas(lista, empate);
  const erradas = lista.map((x, i) => [x, esperadas[i]]).filter(([x, e]) => x.posicao !== e);
  ctx.confereQue(
    `${rotulo}: posições pela política "${empate}"`,
    erradas.length === 0,
    erradas.length ? erradas.slice(0, 3).map(([x, e]) => `id ${x.id} com ${x.pontos} pts na posição ${x.posicao}, esperado ${e}`).join('; ') : 'ok',
  );
  if (ordemNoEmpate === 'nome') {
    const fora = [];
    for (let i = 1; i < lista.length; i++) {
      const a = lista[i - 1];
      const b = lista[i];
      if (a.pontos === b.pontos && ctx.nomeDe(a.id).localeCompare(ctx.nomeDe(b.id), 'pt-BR') > 0) fora.push([a, b]);
    }
    ctx.confereQue(
      `${rotulo}: empatados em ordem de nome`,
      fora.length === 0,
      fora.length ? fora.slice(0, 3).map(([a, b]) => `"${ctx.nomeDe(a.id)}" antes de "${ctx.nomeDe(b.id)}"`).join('; ') : 'ok',
    );
  }
}

// ---------- casos ----------

function casos(regra) {
  const lista = [];
  const caso = (id, titulo, rodar) => lista.push({ id, grupo: id[0], titulo, rodar });

  // F. Regra de pontos

  caso('F1-publicar', 'Publicar um post vale exatamente o declarado', async (ctx) => {
    exigirAcao(ctx, 'publicar');
    const x = await ctx.aluno();
    await ctx.pontos(x, {}, 'antes');
    await ctx.a.publicar(x, { texto: 'post do caso F1' });
    await ctx.pontos(x, { posts: 1 }, 'depois de 1 post');
  });

  caso('F1-curtida', 'Curtida recebida de outra pessoa vale exatamente o declarado', async (ctx) => {
    exigirAcao(ctx, 'curtidaRecebida');
    const autor = await ctx.aluno();
    const leitor = await ctx.aluno();
    const post = await ctx.a.publicar(autor, { texto: 'post do caso F1' });
    await ctx.pontos(autor, { posts: 1 }, 'autor antes da curtida');
    await ctx.a.curtir(leitor, post);
    await ctx.pontos(autor, { posts: 1, curtidas: 1 }, 'autor depois da curtida');
    await ctx.pontos(leitor, {}, 'quem curtiu');
  });

  caso('F1-comentario', 'Comentar post alheio vale exatamente o declarado', async (ctx) => {
    exigirAcao(ctx, 'comentarioEmPostAlheio');
    const autor = await ctx.aluno();
    const leitor = await ctx.aluno();
    const post = await ctx.a.publicar(autor, { texto: 'post do caso F1' });
    await ctx.a.comentar(leitor, post, 'comentário do caso F1');
    await ctx.pontos(leitor, { comentarios: 1 }, 'quem comentou');
    await ctx.pontos(autor, { posts: 1 }, 'autor do post (receber comentário não vale)');
  });

  if (!regra.premios.length) {
    caso('F2', 'Cada item de prêmio vale exatamente o declarado', async () => {
      throw new Ausente('A regra declarada não tem itens de prêmio.');
    });
  }
  for (const p of regra.premios) {
    caso(`F2-${p.id}`, `Prêmio "${p.nome}" vale exatamente ${p.pontos}`, async (ctx) => {
      const prof = await ctx.professor();
      const x = await ctx.aluno();
      await ctx.a.concederPremio(prof, x, p.id);
      await ctx.pontos(x, { premios: [p.id] }, 'depois do prêmio');
    });
  }

  if (!(regra.metas || []).length) {
    caso('F3', 'Metas declaradas: meta-1 sem bônus, meta com bônus', async () => {
      throw new Ausente('A regra declarada não tem metas com bônus.');
    });
  }
  for (const m of regra.metas || []) {
    caso(`F3-${m.id}`, `Meta "${m.id}" (${m.conta} >= ${m.meta}, +${m.bonus}): ${m.meta - 1} sem bônus, ${m.meta} com bônus`, async (ctx) => {
      const x = await ctx.aluno();
      const conferirEm = async (n, estado) => {
        if (n === m.meta - 1 || n === m.meta) await ctx.pontos(x, estado, `${m.conta} = ${n}`);
      };
      if (m.conta === 'posts') {
        await conferirEm(0, {});
        for (let n = 1; n <= m.meta; n++) {
          await ctx.a.publicar(x, { texto: `post ${n} do caso F3` });
          await conferirEm(n, { posts: n });
        }
      } else if (m.conta === 'curtidas') {
        const post = await ctx.a.publicar(x, { texto: 'post do caso F3' });
        const leitores = await ctx.pool(m.meta);
        await conferirEm(0, { posts: 1 });
        for (let n = 1; n <= m.meta; n++) {
          await ctx.a.curtir(leitores[n - 1], post);
          await conferirEm(n, { posts: 1, curtidas: n });
        }
      } else if (m.conta === 'comentarios') {
        const autor = await ctx.aluno();
        const posts = [];
        for (let n = 1; n <= m.meta; n++) posts.push(await ctx.a.publicar(autor, { texto: `post ${n} do caso F3` }));
        await conferirEm(0, {});
        for (let n = 1; n <= m.meta; n++) {
          await ctx.a.comentar(x, posts[n - 1], `comentário ${n} do caso F3`);
          await conferirEm(n, { comentarios: n });
        }
      } else if (m.conta === 'premios') {
        const prof = await ctx.professor();
        const ids = ctx.regra.premioRepetidoSoma
          ? Array(m.meta).fill(premioMaisBarato(ctx.regra))
          : ctx.regra.premios.map((p) => p.id);
        if (ids.length < m.meta) throw new Ausente(`A meta pede ${m.meta} prêmios e a regra não permite repetir.`);
        const recebidos = [];
        await conferirEm(0, {});
        for (let n = 1; n <= m.meta; n++) {
          await ctx.a.concederPremio(prof, x, ids[n - 1]);
          recebidos.push(ids[n - 1]);
          await conferirEm(n, { premios: [...recebidos] });
        }
      } else {
        throw new Error(`Conta de meta desconhecida: ${m.conta}`);
      }
    });
  }

  caso('F4', 'Ação sobre o próprio conteúdo segue a regra (curtir e comentar o próprio post)', async (ctx) => {
    const vale = ctx.regra.limites.acaoSobreProprioConteudoVale;
    if (vale === undefined) throw new Ausente('A regra não declara se ação sobre o próprio conteúdo vale.');
    const x = await ctx.aluno();
    const post = await ctx.a.publicar(x, { texto: 'post do caso F4' });
    await ctx.a.curtir(x, post);
    await ctx.a.comentar(x, post, 'comentário no próprio post');
    await ctx.pontos(x, vale ? { posts: 1, curtidas: 1, comentarios: 1 } : { posts: 1 }, `curtiu e comentou o próprio post (regra: ${vale ? 'vale' : 'não vale'})`);
  });

  caso('F5', 'Ações fora da regra valem 0 (editar perfil, receber comentário, abrir páginas)', async (ctx) => {
    const x = await ctx.aluno();
    const outro = await ctx.aluno();
    const post = await ctx.a.publicar(x, { texto: 'post do caso F5' });
    await ctx.a.comentar(outro, post, 'comentário recebido');
    await ctx.a.editarPerfil(x);
    await ctx.a.ranking({});
    await ctx.a.posicao(x);
    await ctx.pontos(x, { posts: 1 }, 'depois de editar perfil, receber comentário e abrir páginas');
  });

  caso('F6', 'Desfazer a ação tira os pontos (descurtir, apagar post)', async (ctx) => {
    if (ctx.regra.desfazer !== 'recalcula') throw new Ausente('A regra não declara o efeito de desfazer uma ação.');
    const x = await ctx.aluno();
    const leitor = await ctx.aluno();
    const post = await ctx.a.publicar(x, { texto: 'post do caso F6' });
    await ctx.a.curtir(leitor, post);
    await ctx.pontos(x, { posts: 1, curtidas: 1 }, 'com a curtida');
    await ctx.a.descurtir(leitor, post);
    await ctx.pontos(x, { posts: 1 }, 'depois de descurtir');
    await ctx.a.apagarPost(x, post);
    await ctx.pontos(x, {}, 'depois de apagar o post');
  });

  caso('F7', 'Total do perfil igual ao do ranking e à regra, com estado misto', async (ctx) => {
    const prof = await ctx.professor();
    const x = await ctx.aluno();
    const [l1, l2] = await ctx.pool(2);
    const autor = await ctx.aluno();
    const p1 = await ctx.a.publicar(x, { texto: 'post 1 do caso F7' });
    await ctx.a.publicar(x, { texto: 'post 2 do caso F7' });
    await ctx.a.curtir(l1, p1);
    await ctx.a.curtir(l2, p1);
    const pa = await ctx.a.publicar(autor, { texto: 'post alheio do caso F7' });
    const pb = await ctx.a.publicar(autor, { texto: 'post alheio 2 do caso F7' });
    await ctx.a.comentar(x, pa, 'um');
    await ctx.a.comentar(x, pb, 'dois');
    const premio = premioMaisBarato(ctx.regra);
    await ctx.a.concederPremio(prof, x, premio);
    const estado = { posts: 2, curtidas: 2, comentarios: 2, premios: [premio] };
    await ctx.pontos(x, estado, 'perfil');
    const linha = (await ctx.a.ranking({})).find((l) => l.id === x.id);
    ctx.confere('ranking geral', esperado(ctx.regra, estado), linha ? linha.pontos : 'fora do ranking');
  });

  caso('F8', 'Interação com quem não participa do ranking (professor) segue a regra', async (ctx) => {
    const vale = ctx.regra.limites.interacaoComNaoParticipanteVale;
    if (vale === undefined) throw new Ausente('A regra não declara interação com professor.');
    if (ctx.regra.notas && ctx.regra.notas.F8) ctx.anota(ctx.regra.notas.F8);
    const prof = await ctx.professor();
    const x = await ctx.aluno();
    const postProf = await ctx.a.publicar(prof, { texto: 'post do professor, caso F8' });
    await ctx.a.comentar(x, postProf, 'comentário no post do professor');
    await ctx.pontos(x, vale ? { comentarios: 1 } : {}, 'aluno que comentou post de professor');
    const postAluno = await ctx.a.publicar(x, { texto: 'post do aluno, caso F8' });
    await ctx.a.curtir(prof, postAluno);
    await ctx.pontos(x, vale ? { comentarios: 1, posts: 1, curtidas: 1 } : { posts: 1, curtidas: 1 }, 'depois da curtida do professor (curtida de outra pessoa)');
  });

  // E. Entradas inválidas

  const tiposDePremioInvalido = [
    ['ausente', 'campo do tipo ausente (nulo)'],
    ['vazio', 'tipo vazio'],
    ['texto', 'tipo com texto onde se espera id'],
    ['decimal', 'tipo decimal'],
    ['negativo', 'tipo negativo'],
    ['inexistente', 'tipo com id inexistente'],
  ];
  for (const [sufixo, descricao] of tiposDePremioInvalido) {
    caso(`E1-${sufixo}`, `Prêmio com ${descricao} é recusado e não pontua`, async (ctx) => {
      if (!ctx.cap.premios) throw new Ausente('O produto não tem concessão de prêmio.');
      const prof = await ctx.professor();
      const x = await ctx.aluno();
      await invalido(ctx, `premio-tipo-${sufixo}`, { ator: prof, contexto: { professor: prof, aluno: x }, vigiados: [[x, {}, 'aluno alvo']] });
    });
  }

  caso('E2-inexistente', 'Prêmio para aluno inexistente é recusado', async (ctx) => {
    if (!ctx.cap.premios) throw new Ausente('O produto não tem concessão de prêmio.');
    const prof = await ctx.professor();
    await invalido(ctx, 'premio-alvo-inexistente', { ator: prof, contexto: { professor: prof, premio: premioMaisBarato(ctx.regra) } });
  });

  caso('E2-idtexto', 'Prêmio para id de aluno em texto é recusado', async (ctx) => {
    if (!ctx.cap.premios) throw new Ausente('O produto não tem concessão de prêmio.');
    const prof = await ctx.professor();
    await invalido(ctx, 'premio-alvo-texto', { ator: prof, contexto: { professor: prof, premio: premioMaisBarato(ctx.regra) } });
  });

  caso('E2-naoparticipa', 'Prêmio para quem não participa (professor) é recusado', async (ctx) => {
    if (!ctx.cap.premios) throw new Ausente('O produto não tem concessão de prêmio.');
    const prof = await ctx.professor();
    const alvo = await ctx.professor();
    await invalido(ctx, 'premio-alvo-professor', { ator: prof, contexto: { professor: prof, alvo, premio: premioMaisBarato(ctx.regra) } });
    const r = await ctx.a.ranking({});
    ctx.confereQue('professor alvo fora do ranking', !r.some((l) => l.id === alvo.id), r.some((l) => l.id === alvo.id) ? 'aparece' : 'ok');
  });

  caso('E3', 'Prêmio concedido por quem não tem permissão (aluno) é recusado', async (ctx) => {
    if (!ctx.cap.premios) throw new Ausente('O produto não tem concessão de prêmio.');
    const ator = await ctx.aluno();
    const x = await ctx.aluno();
    await invalido(ctx, 'premio-por-aluno', { ator, contexto: { aluno: x, premio: premioMaisBarato(ctx.regra) }, vigiados: [[x, {}, 'aluno alvo'], [ator, {}, 'aluno que tentou']] });
  });

  for (const [sufixo, tipo, descricao] of [
    ['curtir-inexistente', 'curtir-post-inexistente', 'Curtir post inexistente'],
    ['curtir-idtexto', 'curtir-post-id-texto', 'Curtir post com id em texto'],
    ['comentar-inexistente', 'comentar-post-inexistente', 'Comentar post inexistente'],
  ]) {
    caso(`E4-${sufixo}`, `${descricao} é recusado`, async (ctx) => {
      const x = await ctx.aluno();
      await invalido(ctx, tipo, { ator: x, contexto: { aluno: x }, vigiados: [[x, {}, 'quem tentou']] });
    });
  }

  caso('E5-post', 'Post vazio (sem foto e sem texto) é recusado e não pontua', async (ctx) => {
    const x = await ctx.aluno();
    await invalido(ctx, 'post-vazio', { ator: x, contexto: { aluno: x }, vigiados: [[x, {}, 'quem tentou']] });
  });

  caso('E5-comentario', 'Comentário vazio é recusado e não pontua', async (ctx) => {
    const autor = await ctx.aluno();
    const x = await ctx.aluno();
    const post = await ctx.a.publicar(autor, { texto: 'post do caso E5' });
    await invalido(ctx, 'comentario-vazio', { ator: x, contexto: { aluno: x, post }, vigiados: [[x, {}, 'quem tentou'], [autor, { posts: 1 }, 'autor do post']] });
  });

  caso('E6-curtida', 'A mesma curtida repetida não soma duas vezes', async (ctx) => {
    const autor = await ctx.aluno();
    const x = await ctx.aluno();
    const post = await ctx.a.publicar(autor, { texto: 'post do caso E6' });
    await ctx.a.curtir(x, post);
    const pedido = await ctx.a.pedidoInvalido('curtida-repetida', { aluno: x, post });
    const r = await ctx.a.bruto(x, pedido);
    ctx.confereQue('sem erro de servidor', r.status < 500, `status ${r.status}`);
    const obtido = await ctx.a.pontos(autor);
    const uma = esperado(ctx.regra, { posts: 1, curtidas: 1 });
    const nenhuma = esperado(ctx.regra, { posts: 1 });
    ctx.confereQue(
      `autor com no máximo uma curtida (${uma}, ou ${nenhuma} se a repetição desfaz)`,
      obtido === uma || obtido === nenhuma,
      `obtido ${obtido}${obtido === nenhuma ? ' (a repetição desfez a curtida)' : obtido === uma ? ' (a repetição foi ignorada)' : ''}`,
    );
  });

  caso('E6-comentario', 'O mesmo post comentado duas vezes segue a regra declarada', async (ctx) => {
    const autor = await ctx.aluno();
    const x = await ctx.aluno();
    const post = await ctx.a.publicar(autor, { texto: 'post do caso E6' });
    await ctx.a.comentar(x, post, 'primeiro');
    await ctx.a.comentar(x, post, 'segundo');
    const umaVez = ctx.regra.limites.comentarioUmaVezPorPost;
    await ctx.pontos(x, { comentarios: umaVez ? 1 : 2 }, `dois comentários no mesmo post (regra: ${umaVez ? 'conta uma vez' : 'conta cada um'})`);
  });

  caso('E6-premio', 'O mesmo prêmio concedido duas vezes segue a regra declarada', async (ctx) => {
    if (!ctx.cap.premios) throw new Ausente('O produto não tem concessão de prêmio.');
    const prof = await ctx.professor();
    const x = await ctx.aluno();
    const premio = premioMaisBarato(ctx.regra);
    await ctx.a.concederPremio(prof, x, premio);
    if (ctx.regra.premioRepetidoSoma) {
      await ctx.a.concederPremio(prof, x, premio);
      await ctx.pontos(x, { premios: [premio, premio] }, 'prêmio repetido (regra: soma)');
    } else {
      await invalido(ctx, 'premio-repetido', { ator: prof, contexto: { professor: prof, aluno: x, premio }, vigiados: [[x, { premios: [premio] }, 'prêmio repetido (regra: não soma)']] });
    }
  });

  caso('E7', 'Filtro de ranking inválido não quebra', async (ctx) => {
    const x = await ctx.aluno();
    const pedido = await ctx.a.pedidoInvalido('ranking-filtro-invalido', { aluno: x });
    if (pedido === null) throw new Ausente('O ranking não tem filtro.');
    const r = await ctx.a.bruto(x, pedido);
    ctx.confereQue('sem erro de servidor', r.status < 500, `status ${r.status}${r.resumo ? `, ${r.resumo}` : ''}`);
  });

  // R. Ranking

  // Monta três alunos no mesmo curso com pontos diferentes e dois empatados.
  async function montarRanking(ctx) {
    if (ctx.dadosRanking) return ctx.dadosRanking;
    const curso = ctx.cap.cursos[1] || ctx.cap.cursos[0];
    const zero = await ctx.aluno({ curso, nome: 'Ranking Zélia' });
    const um = await ctx.aluno({ curso, nome: 'Ranking Bruno' });
    const empA = await ctx.aluno({ curso, nome: 'Ranking Ícaro' });
    const empB = await ctx.aluno({ curso, nome: 'Ranking Ana' });
    const alto = await ctx.aluno({ curso, nome: 'Ranking Carla' });
    await ctx.a.publicar(um, { texto: 'post do ranking' });
    for (const x of [empA, empB, alto]) {
      await ctx.a.publicar(x, { texto: 'post do ranking' });
      await ctx.a.publicar(x, { texto: 'post do ranking 2' });
    }
    const [l1] = await ctx.pool(1);
    const p = await ctx.a.publicar(alto, { texto: 'post do ranking 3' });
    await ctx.a.curtir(l1, p);
    ctx.dadosRanking = { curso, zero, um, empA, empB, alto };
    return ctx.dadosRanking;
  }

  caso('R1', 'Ranking em ordem decrescente de pontos, no geral e no curso', async (ctx) => {
    const d = await montarRanking(ctx);
    const geral = await ctx.a.ranking({});
    conferirOrdem(ctx, geral, 'geral');
    const ids = geral.map((l) => l.id);
    const [iAlto, iA, iB, iUm, iZero] = [d.alto, d.empA, d.empB, d.um, d.zero].map((x) => ids.indexOf(x.id));
    const ok = [iAlto, iA, iB, iUm, iZero].every((v) => v >= 0) && iAlto < Math.min(iA, iB) && Math.max(iA, iB) < iUm && iUm < iZero;
    ctx.confereQue('alunos montados na ordem esperada (Carla, os dois empatados, Bruno, Zélia)', ok, `linhas ${[iAlto, iA, iB, iUm, iZero].map((v) => v + 1).join(', ')}`);
    if (ctx.cap.rankingPorCurso) conferirOrdem(ctx, await ctx.a.ranking({ curso: d.curso }), `curso ${d.curso}`);
  });

  caso('R2', 'Desempate pela política declarada', async (ctx) => {
    const d = await montarRanking(ctx);
    ctx.anota(`política declarada: empate "${ctx.regra.ranking.empate}", ordem no empate "${ctx.regra.ranking.ordemNoEmpate || 'não declarada'}"`);
    const geral = await ctx.a.ranking({});
    conferirEmpate(ctx, geral, 'geral');
    const a = geral.find((l) => l.id === d.empA.id);
    const b = geral.find((l) => l.id === d.empB.id);
    ctx.confere('pontos dos dois empatados montados', a && a.pontos, b && b.pontos);
    if (ctx.regra.ranking.empate === 'mesma-posicao') ctx.confere('empatados montados na mesma posição', a && a.posicao, b && b.posicao);
    if (ctx.cap.rankingPorCurso) conferirEmpate(ctx, await ctx.a.ranking({ curso: d.curso }), `curso ${d.curso}`);
  });

  caso('R3', 'Quem não participa fica fora do ranking, no geral e no curso', async (ctx) => {
    const prof = await ctx.professor();
    const x = await ctx.aluno();
    const post = await ctx.a.publicar(prof, { texto: 'post do professor, caso R3' });
    await ctx.a.curtir(x, post);
    const naoParticipantes = ctx.idsNaoParticipantes();
    ctx.anota(`participa: ${ctx.regra.ranking.participa.join(', ')}; ${naoParticipantes.size} usuários não participantes criados pela suíte`);
    const geral = await ctx.a.ranking({});
    const intrusos = geral.filter((l) => naoParticipantes.has(l.id));
    ctx.confereQue('geral sem não participantes', intrusos.length === 0, intrusos.length ? `ids ${intrusos.map((l) => l.id).join(', ')}` : 'ok');
    if (ctx.cap.rankingPorCurso) {
      for (const curso of ctx.cap.cursos) {
        const lista = await ctx.a.ranking({ curso });
        const i = lista.filter((l) => naoParticipantes.has(l.id));
        ctx.confereQue(`curso ${curso} sem não participantes`, i.length === 0, i.length ? `ids ${i.map((l) => l.id).join(', ')}` : 'ok');
      }
    }
  });

  caso('R4', 'Ranking por curso só tem alunos do curso e começa em 1', async (ctx) => {
    if (!ctx.cap.rankingPorCurso) throw new Ausente('O produto não tem ranking por curso.');
    await montarRanking(ctx);
    for (const curso of ctx.cap.cursos) {
      const lista = await ctx.a.ranking({ curso });
      if (!lista.length) {
        ctx.anota(`curso ${curso}: vazio`);
        continue;
      }
      const fora = lista.filter((l) => ctx.cursoDe(l.id) !== curso);
      ctx.confereQue(`curso ${curso}: só alunos do curso (${lista.length})`, fora.length === 0, fora.length ? fora.slice(0, 3).map((l) => `id ${l.id} é de ${ctx.cursoDe(l.id) || 'desconhecido'}`).join('; ') : 'ok');
      ctx.confere(`curso ${curso}: primeira posição`, 1, lista[0].posicao);
    }
  });

  caso('R5', 'Posição no perfil igual à do ranking', async (ctx) => {
    const d = await montarRanking(ctx);
    const geral = await ctx.a.ranking({});
    for (const x of [d.alto, d.empA, d.um]) {
      const linha = geral.find((l) => l.id === x.id);
      ctx.confere(`${x.nome}: posição no perfil e no ranking`, linha ? linha.posicao : 'fora do ranking', await ctx.a.posicao(x));
    }
  });

  caso('R6', 'Ex-aluno mantém a posição e não pontua mais', async (ctx) => {
    if (!ctx.cap.exAlunos) throw new Ausente(ctx.cap.evidenciaAusencia?.exAlunos || 'O produto não tem ex-alunos.');
    const x = await ctx.aluno();
    await ctx.a.publicar(x, { texto: 'post antes de formar' });
    const antes = (await ctx.a.ranking({})).find((l) => l.id === x.id);
    await ctx.a.formarAluno(x);
    await ctx.a.publicar(x, { texto: 'post depois de formar' });
    await ctx.pontos(x, { posts: 1 }, 'ex-aluno depois de publicar');
    const depois = (await ctx.a.ranking({})).find((l) => l.id === x.id);
    ctx.confereQue('ex-aluno continua no ranking', Boolean(depois), depois ? `posição ${depois.posicao}` : 'saiu');
    ctx.confere('pontos do ex-aluno no ranking', antes && antes.pontos, depois && depois.pontos);
  });

  // T. Tiers

  const fronteiras = [
    ['T1', 'Fronteira inferior: 0 recusado, 1 é o primeiro tier', [0, 1]],
    ['T2', 'Fronteira 30/31', [30, 31]],
    ['T3', 'Fronteira 70/71', [70, 71]],
    ['T4', 'Fronteira 100/101', [100, 101]],
    ['T5', 'Fronteira superior: 150 aceito, 151 recusado', [150, 151]],
  ];
  for (const [id, titulo, valores] of fronteiras) {
    caso(id, titulo, async (ctx) => {
      if (!ctx.cap.tiers || !ctx.regra.tiers) throw new Ausente(ctx.cap.evidenciaAusencia?.tiers || 'O produto não tem tiers.');
      const prof = await ctx.professor();
      for (const v of valores) {
        const faixa = ctx.regra.tiers.find((t) => v >= t.min && v <= t.max);
        const r = await ctx.a.premioPorTier(prof, v);
        if (!faixa) ctx.confereQue(`${v} pontos recusado`, !r.aceito, r.aceito ? `aceito como ${r.tier}` : 'recusado');
        else ctx.confere(`${v} pontos no tier`, faixa.nome, r.aceito ? r.tier : 'recusado');
      }
    });
  }

  caso('T6', 'Aluno não tem tier', async (ctx) => {
    if (!ctx.cap.tiers || !ctx.regra.tiers) throw new Ausente(ctx.cap.evidenciaAusencia?.tiers || 'O produto não tem tiers.');
    const prof = await ctx.professor();
    const x = await ctx.aluno();
    await ctx.a.concederPremio(prof, x, premioMaisBarato(ctx.regra));
    ctx.confere('tier exibido do aluno', null, await ctx.a.tierDoAluno(x));
  });

  return lista;
}

module.exports = { casos, GRUPOS, posicoesEsperadas };
