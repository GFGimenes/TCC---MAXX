'use strict';
// Ponto de entrada chamado pelo rodar.ps1.
//
//   node cli.js --adaptador <pasta> --base <url> --meta <meta.json> --saida <pasta>
//   node cli.js --adaptador <pasta> --meta <meta.json> --saida <pasta> --falha-subida <arquivo>
//
// Saída 0: relatório gravado. Saída 2: erro da suíte, nada gravado.

const fs = require('node:fs');
const path = require('node:path');
const { executar } = require('./executor');
const { gravar } = require('./relatorio');

function argumentos(argv) {
  const r = {};
  for (let i = 0; i < argv.length; i += 2) r[argv[i].replace(/^--/, '')] = argv[i + 1];
  return r;
}

async function main() {
  const args = argumentos(process.argv.slice(2));
  const pasta = path.resolve(args.adaptador);
  const meta = JSON.parse(fs.readFileSync(args.meta, 'utf8').replace(/^﻿/, ''));
  meta.adaptador = path.basename(pasta);

  if (args['falha-subida']) {
    meta.falhaSubida = fs.readFileSync(args['falha-subida'], 'utf8');
    const arq = gravar({ saida: args.saida, meta, resultado: null });
    console.log(`Relatório provisório (produto não subiu), na pasta temporária: ${arq.md}`);
    return;
  }

  const regra = require(path.join(pasta, 'regra.js'));
  const { criar } = require(path.join(pasta, 'adaptador.js'));
  const opcoes = args.opcoes ? JSON.parse(args.opcoes) : {};
  const adaptador = criar({ base: args.base, regra, ...opcoes });
  const inicio = Date.now();
  const resultado = await executar({
    adaptador,
    regra,
    aoTerminarCaso: (l) => console.error(`  ${l.estado.padEnd(7)} ${l.id} (${l.duracaoMs} ms)`),
  });
  resultado.regra = regra;
  meta.duracaoCasosS = Math.round((Date.now() - inicio) / 1000);
  const arq = gravar({ saida: args.saida, meta, resultado });
  const { passou, falhou, ausente } = resultado.resumo;
  console.log(`Resumo: ${passou} passou, ${falhou} falhou, ${ausente} ausente.`);
  console.log(`Relatório provisório, na pasta temporária: ${arq.md}`);
}

main().catch((e) => {
  console.error(`ERRO DA SUÍTE, nada gravado: ${e.message}`);
  if (e.causa && e.causa.stack) console.error(e.causa.stack);
  else if (e.stack) console.error(e.stack);
  process.exit(2);
});
