# Linha do Tempo do Experimento

Fases do experimento descrito nas seções 3.1 a 3.3 do TCC, organizadas para execução.
Cada fase lista entregável, pastas envolvidas e critério de "pronto". Datas ficam em
aberto — preencha a coluna à medida que for executando; a ordem e as dependências
entre fases é o que importa manter.

| # | Fase | O que é feito | Pastas envolvidas | Entregável / critério de pronto | Status |
|---|------|----------------|--------------------|----------------------------------|--------|
| 0 | Fundamentação já escrita | Contextualização, objetivos, teoria (vibe coding, LLMs, gamificação) | — (já no PDF do TCC) | Seções 1 e 2 do TCC | ✅ Feito |
| 1 | Engenharia de contexto (personas das IAs) | Definir o núcleo comum de contexto do projeto + a persona atribuída a cada IA (arquiteto sênior/Claude, dev pragmático/GPT, direto/Grok, revisor/Gemini) | `personas/` (arquivos de contexto), Quadro 1 do TCC | Arquivos de persona por IA, reutilizáveis a cada sessão | ✅ Descrito na seção 3.1 |
| 2 | Pesquisa das personas de usuário (leigo x engenheiro) | Levantar como cada persona formularia prompts — bons e ruins — para as mesmas telas/features do app | `personas/leigo/`, `personas/engenheiro/` | Perfil de cada persona + exemplos de vocabulário/nível de detalhe típico | 🔲 Em andamento (você) |
| 3 | Especificação funcional por tela | Consolidar as telas desenhadas (login, feed, perfil, mural, troféus, rankings) como escopo de referência para os prompts | `docs/especificacao-telas.md` | Lista de telas/features com regras de negócio associadas | 🟡 Em consolidação (rascunhos descritivos do autor a caminho) |
| 4 | Escrita dos prompts | Para cada combinação (persona leiga/engenheiro × prompt bom/ruim × tela/feature), escrever o prompt que será enviado igualmente aos dois agentes | `prompts/leigo/`, `prompts/engenheiro/` | 1 arquivo de prompt por rodada, nomeado de forma rastreável (ex.: `leigo_bom_login.md`) | 🔲 A fazer |
| 5 | Orquestração da execução | Configurar no Orca o disparo do mesmo prompt para Claude Code e Codex, preservando o arquivo de persona/contexto de cada IA | `orquestracao/` | Fluxo do Orca documentado e reproduzível | 🔲 A fazer |
| 6 | Execução nos agentes | Rodar cada prompt nos dois agentes e salvar as respostas (código, decisões, artefatos) | `resultados/claude/...`, `resultados/codex/...` | Saída de cada agente salva por persona/rodada | 🔲 A fazer |
| 7 | Validação técnica (testes) | Rodar testes unitários sobre a lógica crítica gerada (ex.: cálculo de tier), conforme seção 3.2 do TCC | dentro de `resultados/<agente>/...` | Suíte de testes + resultado (passou/falhou) por rodada | 🔲 A fazer |
| 8 | Agent review com pontuação (por rodada) | Revisor automático (via orquestração no Orca) pontua **Código e Segurança** de cada resultado; humano valida a nota antes de registrar | `avaliacoes/rubrica.md`, `avaliacoes/reviews/`, `avaliacoes/registro-avaliacoes.xlsx` | 1 linha de pontuação por rodada na planilha, validada por humano | 🔲 A fazer |
| 8b | Auditorias de milestone | Ao fechar cada camada (Autenticação, Banco de Dados, Gamificação, Frontend), avaliar **Arquitetura e Mantenabilidade** sobre o diff acumulado de cada trilha; **UX** ao final de cada feature navegável | `avaliacoes/`, branches das trilhas | 4 auditorias de milestone por trilha (16 no total) | 🔲 A fazer |
| 9 | Consolidação comparativa | Cruzar os dados: Claude x Codex, leigo x engenheiro, prompt bom x ruim | aba "Resumo" da planilha | Tabela/gráficos comparativos com achados quantitativos | 🔲 A fazer |
| 10 | Documentação final do TCC | Atualizar a seção 3.3 (Análise Comparativa) e as Considerações Finais com dados quantitativos, substituindo a análise qualitativa da entrega parcial | PDF do TCC | Versão final do TCC | 🔲 A fazer |

## Regra de revisão por trilha

- Trilhas do **leigo** (`leigo/claude`, `leigo/codex`): revisão **observacional** — as
  falhas encontradas nas rodadas são registradas mas não corrigidas, para medir o
  efeito composto da falta de validação técnica.
- Trilhas do **engenheiro** (`eng/claude`, `eng/codex`): revisão **corretiva** — corrigir
  e refinar prompts faz parte da persona; registrar o custo (tempo/iterações).

## Dependências entre fases

- Fase 4 (prompts) depende da fase 2 (pesquisa de personas) e, opcionalmente, da fase 3
  (especificação por tela) para saber exatamente o que pedir.
- Fase 6 (execução) depende da fase 5 (orquestração) estar validada com pelo menos um
  prompt de teste ponta a ponta antes de rodar o lote completo.
- Fase 8 (pontuação) só deve começar depois que a fase 7 (testes) tiver rodado — a
  rubrica de "Código" (`avaliacoes/rubrica.md`) usa o resultado dos testes como um dos
  critérios objetivos.
- Fase 9 e 10 dependem de ter um volume mínimo de rodadas pontuadas (sugestão: cobrir
  todas as combinações persona × qualidade de prompt × agente pelo menos uma vez antes
  de consolidar).

## Convenção de nomenclatura sugerida

Para manter rastreabilidade entre prompt → resultado → avaliação, use o mesmo ID nos
três lugares, por exemplo:

```
prompts/leigo/leigo_ruim_cadastro.md
resultados/claude/leigo/leigo_ruim_cadastro.md
resultados/codex/leigo/leigo_ruim_cadastro.md
avaliacoes/registro-avaliacoes.xlsx  (linha com ID = leigo_ruim_cadastro)
```
