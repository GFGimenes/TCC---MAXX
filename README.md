# TCC — Vibe Coding com Múltiplas IAs (App Maxx / UniEduk)

Este repositório organiza o experimento prático do TCC: desenvolver o mesmo aplicativo
gamificado (Maxx, rede UniEduk) usando prompts equivalentes em diferentes agentes de IA
(Claude Code e Codex), sob duas personas de usuário (leiga e engenheiro) e duas
qualidades de prompt (bom e ruim), avaliando os resultados em 5 eixos de qualidade de
software.

## Estrutura

```
docs/            Linha do tempo e metodologia do experimento
personas/        Perfis leigo/engenheiro que orientam como cada prompt é escrito
                  (conteúdo a ser preenchido pelo autor a partir de pesquisa)
prompts/         Prompts efetivamente enviados aos agentes, um arquivo por rodada
                  (persona x qualidade do prompt x etapa/tela)
orquestracao/    Notas e fluxos do Orca usados para disparar os prompts em Claude
                  Code e Codex de forma equivalente
resultados/      Saídas geradas por cada agente (claude/ e codex/), organizadas por
                  persona
avaliacoes/      Rubrica de avaliação (5 eixos) e planilha de registro/comparação
                  dos resultados (agent review com pontuação)
```

## Fluxo (referente ao diagrama do autor)

```
Prompt (bom ou ruim, por persona) ──▶ Codex   ──┐
                                    └▶ Claude ──┴─▶ Agent Review (pontuação) ──▶ Documentação
```

Cada rodada de prompt é enviada igualmente para os dois agentes; as respostas são
avaliadas com a mesma rubrica (`avaliacoes/rubrica.md`) e registradas na planilha
(`avaliacoes/registro-avaliacoes.xlsx`); os achados alimentam a documentação final do
TCC (seção 3.3 — Análise Comparativa).

Ver `docs/linha-do-tempo.md` para as fases detalhadas.
