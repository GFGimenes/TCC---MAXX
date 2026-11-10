# Review engenheiro, eixo 4. Documentação

- Status: ok
- Tentativa: 1
- Commit avaliado: 8910b51ae7b0ca10582517ead72ee832746683a3 (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 3c1f6e28-86c2-479f-ba95-7e6dd6ef32fd

Texto do revisor, sem edição:

---
# Revisão do eixo 4, Documentação: produto `engenheiro`, commit `8910b51ae7b0`

## Nota: 5

## Justificativa

A documentação é o ponto mais forte do produto. Uma pessoa nova encontra, em arquivos separados e que apontam uns para os outros:
- as regras de produto, em `docs/produto.md`;
- oito ADRs, cada um com contexto, opções pesadas, decisão e consequências negativas;
- um índice de decisões técnicas organizado por passo, com números concretos;
- um plano mestre com os 13 passos, as pendências da fase 2 e os riscos acompanhados;
- especificações de domínio: `docs/regras-conquista.md` e os diagramas de sequência em `docs/fluxos/`;
- roteiros de operação (`docs/operacao.md`) e de ensaio (`docs/ensaio.md`);
- convenções de código, git, glossário e segurança, no `CLAUDE.md`.

A documentação foi atualizada ao longo da construção. O plano mestre fecha o passo 13 em 10/11/2026 (`docs/plano-mestre.md:370-385`), e o índice registra o que foi cortado e por quê: a carga reduzida, o fim do APK e do Maestro, o backup só em disco. Conferi algumas afirmações contra o código e elas batem:
- os limites de taxa (`docs/decisoes/README.md:98-103` contra `apps/api/src/Maxx.Api/LimiteDeTaxa/LimitesDeTaxa.cs:48-56`);
- `Feed.Intercalar` no domínio (`apps/api/src/Maxx.Domain/Social/Feed.cs:15`);
- a saída de `EmBreve.tsx` (`docs/decisoes/README.md:595`; a pasta `src/navegacao/` hoje só tem `LayoutDasAbas.tsx` e `voltar.ts`).

Com isso, o produto cumpre o nível 5: ADRs com alternativas e consequências, plano de evolução e documentação mantida em dia.

As ressalvas existem, mas não derrubam o nível:
1. **O `README.md` da raiz tem uma linha só** (`# Maxx`). Quem chega pelo GitHub não acha ponto de entrada. O mapa de verdade está no `CLAUDE.md`.
2. **Falta um "como rodar localmente do zero"** na raiz (copiar `.env.example`, `docker compose up`, `seed demo`). As instruções estão espalhadas por `apps/mobile/README.md:8-24` e `:69-79`, por `docs/operacao.md` (produção) e pelas decisões.
3. **Há trechos desatualizados pontuais:**
   - `apps/mobile/README.md:90-91` ainda descreve Busca, Mural e Perfil como "Em breve" e as "telas Em breve" em `src/navegacao/`, que já não existem. O README do cliente também para no passo 6.
   - `docs/decisoes/README.md:904-905` ("Processo e qualidade") ainda fala em "Maestro mínimo no endurecimento" e "k6 a 2.000 usuários", o que contradiz o próprio passo 13 (`:883`, `:159`). O `CLAUDE.md:134-135` já está correto.

## Evidências

- `CLAUDE.md:7-19`: tabela "Leia antes de agir", que aponta onde fica cada tipo de decisão.
- `CLAUDE.md:51-62` e `:67-74`: mapa do repositório e regra de dependência entre camadas.
- `CLAUDE.md:86-109`: glossário obrigatório, com a proibição de sinônimos no código.
- `docs/produto.md:1-731`: documento canônico das regras, incluindo:
  - papéis (2.1);
  - tiers 1-30, 31-70, 71-100 e 101-150 (`:212-219`);
  - ciclo de vida do prêmio, com diagrama de estados (`:311-357`);
  - rankings (seção 5);
  - mural com registro de leitura (`:555-569`).
- `docs/produto.md:703-716`: decisões assumidas de propósito, explicadas para a banca.
- `docs/produto.md:269-271`: registra que a regra antiga de progressão de tier por repetição foi substituída, e por quê.
- `docs/decisoes/README.md:11-22`: índice dos 8 ADRs, com a consequência negativa principal de cada um.
- `docs/decisoes/0005-ranking-por-worker.md:17-83`: ADR com contexto, opções pontuadas (9/5/3), decisão, diagrama e consequências negativas.
- `docs/decisoes/README.md:223-909`: decisões por passo (6 a 13), cada passo com uma seção "Limites conhecidos".
- `docs/plano-mestre.md:48-66`: grafo de dependência dos passos. `:389-407`: fase 2 e pendências, com o local onde cada uma está registrada.
- `docs/plano-mestre.md:409-423`: riscos acompanhados, com o estado de cada um.
- `docs/regras-conquista.md:11-60`: especificação do avaliador declarativo de conquistas.
- `docs/fluxos/README.md:8-15`: seis diagramas de sequência, ligados ao passo em que foram implementados.
- `docs/operacao.md`: deploy, backup e restauração, saúde do worker, purga, voltar versão.
- `docs/decisoes/README.md:98-103` contra `apps/api/src/Maxx.Api/LimiteDeTaxa/LimitesDeTaxa.cs:48-56`: números idênticos.
- `README.md:1`: só o título, sem conteúdo.
- `apps/mobile/README.md:90-91`: descrição desatualizada ("Em breve").
- `docs/decisoes/README.md:904-905`: linha de processo que contradiz o passo 13.

## Regras ausentes

Regras da especificação que o produto não implementa. A maioria aparece como decisão documentada, e nenhuma conta contra a nota.

- **Progressão de tier por repetição da mesma conquista.** Foi substituída por famílias de trilha e conquistas repetíveis por período (`docs/produto.md:269-271`).
- **Login e cadastro "via portal da instituição".** O cadastro é contra uma base semeada, e o portal não existe na fase 1 (`docs/decisoes/README.md:214`).
- **Bio e "followed by" no perfil** (D10, `docs/decisoes/README.md:361`).
- **Listas de seguidores e seguindo.** Só há contadores (`docs/decisoes/README.md:326`).
- **Denúncia de post ou prêmio pelo usuário.** Ficou para depois; só a instituição remove ou contesta (`docs/produto.md:515`).
- **Mural com "semi-colapso".** O comportamento virou "não lido aberto, lido recolhido" (`docs/produto.md:567`).
- **Ex-aluno mantém posição "nos rankings".** Só no histórico, não no do semestre (`docs/produto.md:60-61`).
- **"Salvar" post** (`docs/produto.md:514`).

## Decisões do agente neste eixo

Decisões de documentação que o prompt não pediu:
- usar o `CLAUDE.md` como ponto de entrada da documentação, em vez do `README.md`, que ficou só com o título;
- separar regras de produto (`produto.md`) de decisões técnicas (`decisoes/`), com um índice;
- usar ADRs com tabela de opções pontuadas e consequências negativas obrigatórias;
- registrar decisões "de uma linha" num índice por passo, com uma seção "Limites conhecidos" em cada um;
- criar uma seção "Decisões assumidas de propósito", voltada às perguntas da banca;
- manter um glossário obrigatório que proíbe sinônimos em inglês no código;
- escrever os diagramas de sequência antes do código, cada passo apontando para a regra de origem;
- adotar o padrão de texto "sem travessões" em `docs/`;
- escrever roteiros separados de operação (`operacao.md`) e de ensaio (`ensaio.md`);
- registrar a exceção única à regra de mudanças só aditivas na API (`versaoDoTermo`);
- documentar o README do cliente por passo, que parou no passo 6.

## Não verificado

- Não comparei cada decisão do índice com o código; amostrei limites de taxa, `Feed.Intercalar` e `EmBreve`.
- Não verifiquei se as instruções de execução local funcionam de fato (subir a stack, rodar o seed, os e2e).
- Não verifiquei se os números de carga, ensaio e backup registrados aconteceram, nem se a VPS está no ar.
- Não abri os PNGs de `design/telas/` para conferir a coerência com a documentação.
- Não li inteiros `regras-conquista.md`, `decisoes/README.md` (linhas 390-543 e 623-788) e os diagramas individuais de `docs/fluxos/`.

```json
{
  "nota": 5,
  "justificativa": "Documentação completa e atualizada ao longo da construção: regras de produto canônicas (docs/produto.md), 8 ADRs com opções pontuadas e consequências negativas, índice de decisões por passo com limites conhecidos, plano mestre com 13 passos fechado em 10/11/2026, pendências da fase 2 e riscos, especificação do avaliador de conquistas, seis diagramas de sequência, roteiros de operação e de ensaio, e CLAUDE.md com mapa, camadas, glossário, convenções e regras de segurança. Afirmações amostradas batem com o código (limites de taxa, Feed.Intercalar, remoção do EmBreve). Ressalvas que não derrubam o nível: README.md da raiz tem só o título; não há guia único de execução local na raiz; trechos desatualizados em apps/mobile/README.md:90-91 e docs/decisoes/README.md:904-905.",
  "evidencias": [
    {"local": "CLAUDE.md:7-19", "descricao": "Tabela 'Leia antes de agir' que aponta onde fica cada tipo de decisão"},
    {"local": "CLAUDE.md:86-109", "descricao": "Glossário obrigatório do domínio, com proibição de sinônimos"},
    {"local": "docs/produto.md:212-219", "descricao": "Faixas de tier documentadas (Bronze 1-30, Prata 31-70, Ouro 71-100, Diamante 101-150)"},
    {"local": "docs/produto.md:311-357", "descricao": "Ciclo de vida do prêmio de participação com diagrama de estados e regras"},
    {"local": "docs/produto.md:703-716", "descricao": "Decisões assumidas de propósito, com justificativa para a banca"},
    {"local": "docs/decisoes/README.md:11-22", "descricao": "Índice dos 8 ADRs com a consequência negativa principal de cada um"},
    {"local": "docs/decisoes/0005-ranking-por-worker.md:17-83", "descricao": "ADR com opções pontuadas, decisão, diagrama e consequências negativas"},
    {"local": "docs/decisoes/README.md:789-895", "descricao": "Decisões do passo 13 (produção, borda, backup, carga reduzida) com números e cortes declarados"},
    {"local": "docs/plano-mestre.md:389-423", "descricao": "Fase 2, pendências com o local onde estão registradas, e riscos acompanhados"},
    {"local": "docs/regras-conquista.md:11-60", "descricao": "Especificação declarativa do avaliador de conquistas"},
    {"local": "docs/fluxos/README.md:8-15", "descricao": "Seis diagramas de sequência ligados ao passo de implementação"},
    {"local": "docs/operacao.md:39-213", "descricao": "Roteiro de deploy, purga, saúde do worker, backup, restauração e rollback"},
    {"local": "docs/decisoes/README.md:98-103", "descricao": "Limites de taxa idênticos aos de apps/api/src/Maxx.Api/LimiteDeTaxa/LimitesDeTaxa.cs:48-56"},
    {"local": "README.md:1", "descricao": "README da raiz contém só '# Maxx': sem ponto de entrada nem instrução de execução"},
    {"local": "apps/mobile/README.md:90-91", "descricao": "Desatualizado: cita telas 'Em breve' removidas no passo 10 (docs/decisoes/README.md:595); o README do cliente para no passo 6"},
    {"local": "docs/decisoes/README.md:904-905", "descricao": "Linha de processo desatualizada (Maestro no endurecimento, k6 a 2.000 VUs), contradizendo o passo 13 do mesmo arquivo (:159, :883)"}
  ],
  "regras_ausentes": [
    "Progressão de tier por repetição da mesma conquista (substituída por famílias de trilha, docs/produto.md:269-271)",
    "Login/cadastro via portal da instituição",
    "Bio e 'followed by' no perfil",
    "Listas de seguidores e seguindo (só contadores)",
    "Denúncia de post/prêmio pelo usuário",
    "Comportamento de semi-colapso do mural conforme a especificação",
    "Ex-aluno mantendo posição no ranking do semestre (só no histórico)",
    "Salvar post"
  ],
  "decisoes_do_agente": [
    "Usar o CLAUDE.md como ponto de entrada da documentação, deixando o README.md só com o título",
    "Separar regras de produto (docs/produto.md) de decisões técnicas (docs/decisoes/) com índice",
    "Formato de ADR com tabela de opções pontuadas e consequências negativas obrigatórias",
    "Índice de decisões organizado por passo, com seção 'Limites conhecidos' em cada um",
    "Seção 'Decisões assumidas de propósito' voltada às perguntas da banca",
    "Glossário obrigatório que proíbe sinônimos em inglês no código",
    "Diagramas de sequência escritos antes do código, cada passo apontando para a regra de origem",
    "Padrão de texto 'sem travessões' em docs/",
    "Roteiros separados de operação (docs/operacao.md) e de ensaio (docs/ensaio.md)",
    "Registro explícito da exceção única à regra de mudanças só aditivas na API (versaoDoTermo)",
    "README do cliente documentado por passo (parou no passo 6)"
  ],
  "nao_verificado": [
    "Correspondência completa entre cada decisão do índice e o código (feita só por amostragem)",
    "Se as instruções de execução local funcionam de fato (subir a stack, seed, e2e)",
    "Se os números de carga, ensaio e backup registrados ocorreram e se a VPS está no ar",
    "Coerência dos PNGs em design/telas/ com a documentação",
    "Leitura integral de docs/regras-conquista.md, docs/decisoes/README.md (linhas 390-543 e 623-788) e dos diagramas individuais em docs/fluxos/"
  ]
}
```
