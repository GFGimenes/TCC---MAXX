// Capturas da etapa 5 (passo 14): a entrada da demonstração e os três registros, no claro e
// no escuro, na largura das pranchetas (390 x 844). Só navega: não registra conta nenhuma.
// Uso: node capturar.cjs <raiz do repositório> <pasta de saída>
const path = require("node:path");
const [raiz, saida] = process.argv.slice(2);
const { chromium } = require(path.join(raiz, "node_modules", "@playwright", "test"));

const base = process.env.MAXX_BASE_URL ?? "http://localhost";

(async () => {
  const navegador = await chromium.launch();
  for (const tema of ["light", "dark"]) {
    const nomeDoTema = tema === "light" ? "claro" : "escuro";
    const contexto = await navegador.newContext({
      viewport: { width: 390, height: 844 },
      isMobile: true,
      hasTouch: true,
      colorScheme: tema,
    });
    const pagina = await contexto.newPage();
    const tirar = async (nome) => {
      await pagina.waitForTimeout(400);
      await pagina.screenshot({ path: path.join(saida, `${nome}-${nomeDoTema}.png`), fullPage: true });
    };

    await pagina.goto(`${base}/demonstracao`);
    await pagina.getByRole("button", { name: "Entrar como professor" }).waitFor();
    await tirar("1-escolha");

    for (const [botao, nome] of [
      ["Entrar como aluno", "2-aluno"],
      ["Entrar como professor", "3-professor"],
      ["Entrar como coordenação", "4-coordenacao"],
    ]) {
      await pagina.getByRole("button", { name: botao }).click();
      await pagina.getByRole("button", { name: "Continuar" }).waitFor();
      await tirar(nome);
      // Os erros do formulário vazio, no professor, para conferir o curso obrigatório.
      if (nome === "3-professor") {
        await pagina.getByRole("button", { name: "Continuar" }).click();
        await tirar("5-professor-erros");
      }
      await pagina.getByRole("link", { name: "Voltar" }).click();
      await pagina.getByRole("button", { name: "Entrar como professor" }).waitFor();
    }

    // O termo, vindo da coordenação, com um nome qualquer digitado (nada é enviado).
    await pagina.getByRole("button", { name: "Entrar como coordenação" }).click();
    await pagina.getByLabel("Nome").fill("Conferência Maxx");
    await pagina.getByRole("button", { name: "Continuar" }).click();
    await pagina.getByRole("button", { name: "Aceitar e entrar" }).waitFor();
    await tirar("6-termo");

    await contexto.close();
  }
  await navegador.close();
})().catch((erro) => {
  console.error(erro);
  process.exit(1);
});
