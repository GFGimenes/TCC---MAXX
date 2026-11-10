# Review engenheiro, eixo 4. Documentação

- Status: ok
- Tentativa: 1
- Commit avaliado: 076549bbea15649813d347c2618a4b51377e6bdd (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: e699cce9-407e-446c-a623-568c7eab8f18

Texto do revisor, sem edição:

---
# Revisão: eixo 4, Documentação (produto `engenheiro`, commit `076549bb`)

## Nota: 5 (com ressalvas)

## Justificativa

A documentação vai além do nível 5 da rubrica em quase tudo. O que segura o "5 pleno" é a porta de entrada: o README da raiz está vazio e as instruções de execução estão espalhadas. Também há um README secundário desatualizado.

O que existe:

- **Produto.** `docs/produto.md` (728 linhas) é o documento canônico das regras. Cobre papéis, identidade, prêmios, tiers, ciclo de vida, rankings, social, mural, notificações, privacidade e o modo de demonstração. Ele declara o que foi decidido de propósito (§12) e o que fica fora da fase 1 (§13).
- **Arquitetura e convenções.** O `CLAUDE.md` traz o mapa do repositório, as camadas e o sentido das dependências, o idioma do código, um glossário obrigatório, as regras de segurança, a estratégia de testes e as convenções de git. Os seis diagramas de sequência em `docs/fluxos/` mostram os fluxos que passam por várias peças do sistema.
- **Decisões.** São oito ADRs com contexto, opções pesadas com nota, decisão e consequências, incluindo as negativas. O índice em `docs/decisoes/README.md` (801 linhas) registra as demais decisões passo a passo, cada passo com sua tabela de "Limites conhecidos".
- **Plano de evolução.** `docs/plano-mestre.md` tem os 13 passos com grafo de dependências, a fase 2 e os riscos acompanhados.
- **Documentação em dia.** O índice de decisões foi atualizado até o passo 12, e vários limites aparecem marcados como "Resolvido no passo 12".
- **Coerência com o código.** Nomes citados nos documentos existem no código, por exemplo `Feed.Intercalar`, `ConsultaDoMural` e `InstanciaDePeriodo.DiasAteOCongelamento`.

Ressalvas:

1. **README da raiz vazio.** `README.md:1` contém só `# Maxx`. Quem chega ao repositório não tem ponto de entrada além do `CLAUDE.md`, que é um arquivo de instruções para agente.
2. **Instruções de execução fragmentadas.** Não há um "como subir" consolidado. O procedimento só se monta juntando os comentários de `.env.example`, os trechos de `apps/mobile/README.md` (que mostra `docker compose run --rm seeder seed demo`, mas nunca um primeiro `docker compose up`) e o índice de decisões.
3. **`apps/mobile/README.md` desatualizado.** A linha 90 ainda diz "Home (início provisório)… Busca, Mural e Perfil em breve", e a linha 91 cita "as telas 'Em breve'". A tela `navegacao/EmBreve.tsx` já foi removida (o próprio `docs/decisoes/README.md:595` registra isso, e a pasta só tem `LayoutDasAbas.tsx` e `voltar.ts`). O README também para no passo 6 e não descreve as pastas dos passos 7 a 12.
4. **Estado do projeto implícito.** O plano mestre não diz em que passo o projeto está. Só se deduz que o passo 13 (carga, backup, saúde do worker) está pendente porque não existe pasta de k6.

## Evidências

- `README.md:1`: só o título "# Maxx", sem descrição nem instruções.
- `CLAUDE.md:7-19`: tabela "Leia antes de agir", que aponta para os documentos canônicos.
- `CLAUDE.md:51-74`: mapa do repositório, camadas e dependências, idioma do código.
- `CLAUDE.md:86-109`: glossário obrigatório, com proibição de sinônimos no código.
- `docs/produto.md:1-9` e §1 a §13: regras de produto completas.
- `docs/produto.md:700-713`: §12, "Decisões assumidas de propósito".
- `docs/produto.md:266-268`: registra que a regra antiga de progressão de tier foi substituída.
- `docs/decisoes/README.md:13-22`: índice dos 8 ADRs, com a consequência negativa principal de cada um.
- `docs/decisoes/0002-fotos-fora-da-api.md:12-65`: ADR com opções pesadas (9/3, 8/5/4), diagrama Mermaid e consequências negativas.
- `docs/decisoes/README.md:374-385`, `463-472`, `776-787`: tabelas de "Limites conhecidos" por passo, com o destino de cada limite.
- `docs/plano-mestre.md:48-66`: grafo de dependências dos 13 passos.
- `docs/plano-mestre.md:372-394`: fase 2 e riscos acompanhados.
- `docs/fluxos/README.md:8-15`: seis diagramas de sequência, cada um ligado ao passo que o implementa.
- `docs/regras-conquista.md:11-33`: especificação do avaliador declarativo de conquistas.
- `apps/api/src/Maxx.Domain/Social/Feed.cs:15`: `Feed.Intercalar` existe, como documentado em `docs/decisoes/README.md:332`.
- `apps/api/src/Maxx.Domain/Conquistas/InstanciaDePeriodo.cs:14`: `DiasAteOCongelamento = 30` existe, como documentado.
- `apps/mobile/README.md:90-91`: texto desatualizado ("em breve", "Em breve"), que contradiz `docs/decisoes/README.md:595` e o conteúdo de `apps/mobile/src/navegacao/`.
- `.env.example:1-49`: variáveis comentadas, com origem e uso de cada uma. É a melhor instrução de configuração, mas fica isolada.

## Regras ausentes (marcadas como ausentes, sem penalizar)

- Bio e "followed by xxxx and yyyy" no perfil (decisão D10, `docs/decisoes/README.md:361`).
- Progressão "a mesma conquista repetida rende um prêmio de tier acima" (substituída por famílias e períodos, `docs/produto.md:266`).
- Comportamento de colapso do mural com aviso "semi-colapsado" e abertura quase em tela cheia (substituído por "aberto se não lido, recolhido se lido").
- Denúncia de post pelo usuário (adiada para a fase 2).
- Cadastro de professor pelo portal da instituição (as contas vêm do seed, e o primeiro acesso é pela recuperação de senha).
- Cadastro de troféus e medalhas pelo corpo da faculdade por tela (o catálogo entra por seed).

## Decisões do agente dentro deste eixo

- Adotou ADRs com opções pesadas por nota numérica e consequências negativas obrigatórias.
- Criou um índice de decisões em uma linha para as decisões sem troca real, separado dos ADRs.
- Dividiu a documentação em produto (`produto.md`) e decisões técnicas (`decisoes/`), com a regra de que "decisão que não está aqui não foi tomada".
- Criou tabelas de "Limites conhecidos" por passo, com o destino de cada limite, e as atualizou para "Resolvido no passo N".
- Criou a seção "Decisões assumidas de propósito" para antecipar perguntas da banca.
- Escreveu seis diagramas de sequência antes do código, cada um ligado à regra de origem.
- Definiu um glossário obrigatório no `CLAUDE.md`, com proibição de sinônimos em inglês no código.
- Estabeleceu como convenção textual "sem travessões nos documentos".
- Fez uma fase documental (passo 0) antes de qualquer código.
- Deixou o README da raiz vazio, usando o `CLAUDE.md` como ponto de entrada.

## Não verificado

- Se as instruções espalhadas bastam para subir o sistema de fato: não executei `docker compose`.
- A coerência completa entre todos os documentos e o código: conferi por amostragem, com alguns nomes e constantes.
- Quais decisões de documentação vieram do prompt do engenheiro e quais foram iniciativa do agente: não tive acesso aos prompts nem aos exports de sessão.
- Os ADRs 0001 e 0003 a 0008 e os arquivos de fluxo individuais: li só o 0002 e os índices. Os demais foram avaliados pelos resumos do índice.
- Os documentos de design (`design/README.md`, `design/identidade-visual.md`): não foram lidos por completo.

```json
{
  "nota": 5,
  "justificativa": "Documentação de produto (docs/produto.md), arquitetura e convenções (CLAUDE.md, docs/fluxos), decisões (8 ADRs com opções pesadas e consequências negativas, mais um índice de decisões por passo com limites conhecidos) e plano de evolução (docs/plano-mestre.md com 13 passos, fase 2 e riscos) estão completos, coerentes com o código nos nomes conferidos e atualizados até o passo 12. Ressalvas que impedem um 5 pleno: README da raiz contém só '# Maxx'; não há instrução de execução consolidada (fragmentada entre .env.example, apps/mobile/README.md e decisoes/README.md); apps/mobile/README.md está desatualizado (abas 'em breve', EmBreve.tsx já removido e sem as seções dos passos 7 a 12); o estado atual do projeto (passo 13 pendente) não está declarado.",
  "evidencias": [
    {"local": "README.md:1", "descricao": "README da raiz contém apenas o título '# Maxx', sem descrição nem instruções de execução"},
    {"local": "CLAUDE.md:7-19", "descricao": "Tabela 'Leia antes de agir' apontando para os documentos canônicos de produto, decisões, regras e plano"},
    {"local": "CLAUDE.md:51-109", "descricao": "Mapa do repositório, camadas e dependências, idioma do código e glossário obrigatório"},
    {"local": "docs/produto.md:1-728", "descricao": "Regras de produto completas: papéis, identidade, prêmios, tiers, ciclo de vida, rankings, social, mural, notificações, privacidade, demonstração"},
    {"local": "docs/produto.md:700-713", "descricao": "Seção 12, decisões de produto assumidas de propósito"},
    {"local": "docs/decisoes/README.md:13-22", "descricao": "Índice dos 8 ADRs com a consequência negativa principal de cada um"},
    {"local": "docs/decisoes/0002-fotos-fora-da-api.md:12-65", "descricao": "ADR com opções pesadas por nota, diagrama Mermaid, decisão e consequências negativas"},
    {"local": "docs/decisoes/README.md:776-787", "descricao": "Limites conhecidos do passo 12, com o tratamento de cada um; padrão repetido em todos os passos"},
    {"local": "docs/plano-mestre.md:48-66", "descricao": "Grafo de dependências dos 13 passos da fase 1"},
    {"local": "docs/plano-mestre.md:372-394", "descricao": "Fase 2 e riscos acompanhados"},
    {"local": "docs/fluxos/README.md:8-15", "descricao": "Seis diagramas de sequência ligados aos passos que os implementam"},
    {"local": "docs/regras-conquista.md:11-33", "descricao": "Especificação do avaliador declarativo de conquistas"},
    {"local": "apps/api/src/Maxx.Domain/Social/Feed.cs:15", "descricao": "Feed.Intercalar existe, como documentado em docs/decisoes/README.md:332 (coerência doc-código)"},
    {"local": "apps/api/src/Maxx.Domain/Conquistas/InstanciaDePeriodo.cs:14", "descricao": "DiasAteOCongelamento = 30, coerente com produto.md seção 5 e o índice de decisões"},
    {"local": "apps/mobile/README.md:90-91", "descricao": "Desatualizado: diz Busca, Mural e Perfil 'em breve' e cita telas 'Em breve'; docs/decisoes/README.md:595 registra a remoção de EmBreve.tsx, ausente em apps/mobile/src/navegacao/"},
    {"local": ".env.example:1-49", "descricao": "Variáveis comentadas com origem e uso; é a instrução de configuração mais clara, mas isolada, sem um README que a encadeie"}
  ],
  "regras_ausentes": [
    "Bio e 'followed by xxxx and yyyy' no perfil (removidos pela decisão D10)",
    "Progressão em que a mesma conquista repetida rende prêmio de tier acima (substituída por famílias e períodos)",
    "Colapso do mural com aviso semi-colapsado e abertura quase em tela cheia (substituído por aberto/recolhido)",
    "Denúncia de post pelo usuário (adiada para a fase 2)",
    "Cadastro de professor via portal da instituição (contas vêm do seed, primeiro acesso por recuperação de senha)",
    "Cadastro de troféus e medalhas por tela pelo corpo da faculdade (catálogo entra por seed)"
  ],
  "decisoes_do_agente": [
    "Adotar ADRs com opções pesadas por nota numérica e consequências negativas obrigatórias",
    "Manter um índice de decisões em uma linha para decisões sem troca real, separado dos ADRs",
    "Separar documento canônico de produto (produto.md) de decisões técnicas (decisoes/), com a regra 'decisão que não está aqui não foi tomada'",
    "Registrar tabelas de 'Limites conhecidos' por passo e atualizá-las para 'Resolvido no passo N'",
    "Criar a seção 'Decisões assumidas de propósito' para antecipar perguntas da banca",
    "Escrever seis diagramas de sequência antes do código, ligados às regras de origem",
    "Definir glossário obrigatório no CLAUDE.md, proibindo sinônimos em inglês no código",
    "Convenção textual 'sem travessões' nos documentos",
    "Fase documental (passo 0) antes de qualquer código",
    "Deixar o README da raiz vazio, usando o CLAUDE.md como ponto de entrada"
  ],
  "nao_verificado": [
    "Se as instruções de execução espalhadas bastam para subir o sistema (docker compose não foi executado)",
    "Coerência integral entre documentos e código; conferida apenas por amostragem de nomes e constantes",
    "Quais decisões de documentação vieram do prompt do engenheiro e quais foram iniciativa do agente (sem acesso aos prompts e exports de sessão)",
    "Conteúdo dos ADRs 0001 e 0003 a 0008 e dos arquivos individuais de fluxo, avaliados pelos resumos do índice",
    "Documentos de design (design/README.md, design/identidade-visual.md), não lidos por completo"
  ]
}
```
