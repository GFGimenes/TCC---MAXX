'use strict';
// Grava o resultado em <saida>/<produto>-testes-referencia.md e .json.

const fs = require('node:fs');
const path = require('node:path');
const { GRUPOS } = require('./casos');

const celula = (t) => String(t).replace(/\|/g, '\\|').replace(/\r?\n/g, ' ');

function cabecalho(meta) {
  const amb = meta.ambiente || {};
  const linhas = [
    `# Testes de referência: ${meta.produto}`,
    '',
    `- Commit avaliado: \`${meta.commit}\` (Ref \`${meta.ref}\` de \`${meta.repo}\`)`,
    `- Data: ${meta.data}`,
    `- Suíte: \`avaliacoes/testes-referencia\` no commit \`${meta.suite}\` do tcc, adaptador \`${meta.adaptador}\``,
    `- Ambiente: ${Object.entries(amb).map(([k, v]) => `${k} ${v}`).join('; ')}`,
  ];
  if (meta.porta) linhas.push(`- Porta do produto: ${meta.porta}${meta.notaPorta ? ` (${meta.notaPorta})` : ''}`);
  if (meta.duracaoCasosS !== undefined) linhas.push(`- Duração dos casos: ${meta.duracaoCasosS} s`);
  return linhas;
}

function gerarMarkdown(meta, resultado) {
  const md = cabecalho(meta);
  md.push('');
  if (!resultado) {
    md.push('## O produto não subiu', '', 'Nenhum caso foi executado.', '', '```', String(meta.falhaSubida || 'sem detalhe'), '```', '');
    return md.join('\n');
  }
  const { resumo, linhas, regra, capacidades } = resultado;
  md.push(`## Resumo`, '', `${linhas.length} casos: ${resumo.passou} passou, ${resumo.falhou} falhou, ${resumo.ausente} ausente.`, '');
  md.push('Critérios: o esperado vem só da regra declarada pelo produto (abaixo). Entrada inválida passa quando o produto recusa com 4xx e os pontos não mudam. Regra que o produto não tem sai "ausente", nunca como falha (rubrica, "Regra ausente").', '');
  md.push('## Regra declarada usada como esperado', '');
  md.push(`- Fontes: ${regra.fontes.map((f) => `\`${f}\``).join(', ')}`);
  md.push(`- Ações: ${Object.entries(regra.acoes).map(([k, v]) => `${k} ${v}`).join(', ')}`);
  md.push(`- Prêmios: ${regra.premios.map((p) => `${p.nome} ${p.pontos}`).join(', ') || 'nenhum'}`);
  md.push(`- Metas: ${(regra.metas || []).map((m) => `${m.id} (${m.conta} >= ${m.meta}, +${m.bonus})`).join(', ') || 'nenhuma'}`);
  md.push(`- Ranking: participa ${regra.ranking.participa.join(', ')}; empate "${regra.ranking.empate}"; ordem no empate "${regra.ranking.ordemNoEmpate || 'não declarada'}"`);
  md.push(`- Tiers: ${regra.tiers ? regra.tiers.map((t) => `${t.nome} ${t.min}-${t.max}`).join(', ') : 'não tem'}; ex-alunos: ${regra.exAlunos ? 'tem' : 'não tem'}`);
  for (const [k, v] of Object.entries(regra.notas || {})) md.push(`- Nota (${k}): ${v}`);
  md.push(`- Capacidades informadas pelo adaptador: ${JSON.stringify(capacidades)}`, '');

  for (const [g, nome] of Object.entries(GRUPOS)) {
    const doGrupo = linhas.filter((l) => l.grupo === g);
    if (!doGrupo.length) continue;
    md.push(`## ${g}. ${nome}`, '', '| Caso | Descrição | Resultado | Evidência |', '|---|---|---|---|');
    for (const l of doGrupo) {
      const res = l.estado === 'falhou' ? '**falhou**' : l.estado;
      md.push(`| ${l.id} | ${celula(l.titulo)} | ${res} | ${l.evidencia.map(celula).join('<br>')} |`);
    }
    md.push('');
  }

  md.push('## Pedidos HTTP por caso', '', 'Método, caminho e status de cada pedido do caso (os do meio omitidos quando passam de 12).', '');
  for (const l of linhas.filter((x) => x.pedidos.length)) {
    md.push(`- **${l.id}** (${l.totalPedidos} pedidos, ${l.duracaoMs} ms): ${l.pedidos.map((p) => `\`${p}\``).join(', ')}`);
  }
  md.push('');
  return md.join('\n');
}

function gravar({ saida, meta, resultado }) {
  fs.mkdirSync(saida, { recursive: true });
  const base = path.join(saida, `${meta.produto}-testes-referencia`);
  const json = { ...meta, resultado: resultado || null };
  fs.writeFileSync(`${base}.json`, JSON.stringify(json, null, 2) + '\n', 'utf8');
  fs.writeFileSync(`${base}.md`, gerarMarkdown(meta, resultado), 'utf8');
  return { md: `${base}.md`, json: `${base}.json` };
}

module.exports = { gravar, gerarMarkdown };
