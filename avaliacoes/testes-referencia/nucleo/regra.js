'use strict';
// Modelo da regra declarada: calcula o total esperado a partir do estado de um aluno.
// O esperado nunca vem do produto; vem só da regra que o adaptador declara.
//
// Estado: { posts, curtidas, comentarios, premios: [idDoPremio, ...] }
//   posts       posts publicados pelo aluno
//   curtidas    curtidas recebidas de outras pessoas
//   comentarios posts alheios comentados (conta uma vez por post, se a regra disser)
//   premios     itens concedidos ao aluno

function estadoVazio() {
  return { posts: 0, curtidas: 0, comentarios: 0, premios: [] };
}

function contagem(estado, conta) {
  if (conta === 'premios') return estado.premios.length;
  return estado[conta] || 0;
}

function valorDoPremio(regra, id) {
  const p = regra.premios.find((x) => x.id === id);
  if (!p) throw new Error(`Prêmio ${id} não está na regra declarada.`);
  return p.pontos;
}

function esperado(regra, parcial) {
  const e = { ...estadoVazio(), ...parcial };
  const a = regra.acoes;
  let total =
    e.posts * (a.publicar || 0) +
    e.curtidas * (a.curtidaRecebida || 0) +
    e.comentarios * (a.comentarioEmPostAlheio || 0);
  for (const id of e.premios) total += valorDoPremio(regra, id);
  for (const m of regra.metas || []) if (contagem(e, m.conta) >= m.meta) total += m.bonus;
  return total;
}

// Descreve o cálculo, para a evidência.
function explicar(regra, parcial) {
  const e = { ...estadoVazio(), ...parcial };
  const partes = [];
  if (e.posts) partes.push(`${e.posts} post(s) x ${regra.acoes.publicar}`);
  if (e.curtidas) partes.push(`${e.curtidas} curtida(s) x ${regra.acoes.curtidaRecebida}`);
  if (e.comentarios) partes.push(`${e.comentarios} comentário(s) x ${regra.acoes.comentarioEmPostAlheio}`);
  for (const id of e.premios) partes.push(`prêmio ${id} ${valorDoPremio(regra, id)}`);
  for (const m of regra.metas || []) if (contagem(e, m.conta) >= m.meta) partes.push(`meta ${m.id} +${m.bonus}`);
  return partes.length ? partes.join(' + ') : 'nada';
}

module.exports = { estadoVazio, esperado, explicar, contagem };
