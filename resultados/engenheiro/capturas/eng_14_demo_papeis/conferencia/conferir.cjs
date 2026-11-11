// Conferência no ar do passo 14 (P7): só de leitura. Registra pela demonstração as três
// contas "Conferência Maxx" (aluno e professor de CC, coordenação), abre as telas de cada
// papel e tira capturas. Não concede, não aprova, não publica, não purga.
// Uso: node conferir.cjs <raiz do repositório> <pasta de saída>
const path = require("node:path");
const assert = require("node:assert");
const [raiz, saida] = process.argv.slice(2);
const { chromium, expect } = require(path.join(raiz, "node_modules", "@playwright", "test"));

const base = "https://app.maxx-unimax.com";
const NOME = "Conferência Maxx";

async function registrar(pagina, papel) {
  await pagina.goto(`${base}/login`);
  await pagina.getByRole("button", { name: "Entrar na demonstração" }).click();
  await pagina.getByRole("button", { name: `Entrar como ${papel}` }).click();
  await pagina.getByLabel("Nome", { exact: true }).fill(NOME);
  if (papel !== "coordenação") {
    await pagina.getByRole("radio", { name: "Ciência da Computação" }).click();
  }
  await pagina.getByRole("button", { name: "Continuar" }).click();
  await pagina.getByRole("button", { name: "Aceitar e entrar" }).click();
  await expect(pagina).not.toHaveURL(/\/demonstracao$/, { timeout: 20_000 });
}

(async () => {
  const navegador = await chromium.launch();
  const celular = { viewport: { width: 390, height: 844 }, isMobile: true, hasTouch: true };
  const tirar = (pagina, nome) => pagina.screenshot({ path: path.join(saida, `${nome}.png`) });

  const demo = await (await fetch(`${base}/api/v1/demo`)).json();
  assert.ok(demo.cursos.some((curso) => curso.sigla === "CC"), "a demonstração devia estar ligada, com CC");
  console.log("demonstração ligada, cursos:", demo.cursos.map((curso) => curso.sigla).join(", "));

  // Aluno: o feed e o arroba do curso.
  const aluno = await (await navegador.newContext(celular)).newPage();
  await registrar(aluno, "aluno");
  await aluno.getByRole("tab", { name: "Perfil" }).click();
  await expect(aluno.getByTestId("arroba")).toHaveText(/-CC$/);
  console.log("aluno:", await aluno.getByTestId("arroba").textContent());
  await tirar(aluno, "1-aluno-perfil");
  await aluno.getByRole("tab", { name: "Home" }).click();
  await tirar(aluno, "2-aluno-feed");

  // Professor: o arroba de professor e a lista da turma, sem conceder.
  const professor = await (await navegador.newContext(celular)).newPage();
  await registrar(professor, "professor");
  await professor.getByRole("tab", { name: "Perfil" }).click();
  await expect(professor.getByTestId("arroba")).toHaveText(/-PROF$/);
  console.log("professor:", await professor.getByTestId("arroba").textContent());
  await professor.getByRole("button", { name: "Menu" }).click();
  await professor.getByRole("button", { name: "Minhas turmas" }).click();
  await professor.getByRole("button", { name: /^Banco de Dados/ }).click();
  await expect(professor.getByRole("button", { name: /^Conceder medalha a / }).first()).toBeVisible();
  console.log("professor: alunos na turma de Banco de Dados:", await professor.getByRole("button", { name: /^Conceder medalha a / }).count());
  await tirar(professor, "3-professor-turma");

  // Coordenação: a área no navegador e o próprio lote marcado na purga, sem purgar.
  const coordenacao = await (await navegador.newContext({ viewport: { width: 1280, height: 900 } })).newPage();
  await registrar(coordenacao, "coordenação");
  await coordenacao.getByRole("tab", { name: "Perfil" }).click();
  await coordenacao.getByRole("button", { name: "Área da instituição" }).click();
  await expect(coordenacao.getByRole("button", { name: "Contestações" })).toBeVisible();
  await tirar(coordenacao, "4-coordenacao-area");
  await coordenacao.goto(`${base}/instituicao/purga`);
  const lote = coordenacao.getByTestId("lote-banca-2026");
  await expect(lote.getByText("Seu lote")).toBeVisible();
  await expect(lote.getByText("Vigente")).toBeVisible();
  console.log("coordenação: lote banca-2026:", (await lote.innerText()).split("\n").slice(0, 4).join(" | "));
  await tirar(coordenacao, "5-coordenacao-purga");

  await navegador.close();
})().catch((erro) => {
  console.error(erro);
  process.exit(1);
});
