# Review leigo, eixo 4. Documentação

- Status: ok
- Tentativa: 1
- Commit avaliado: 2a7dad587e67aec8c45df37ce7b59c1f3eccfe2c (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 7e05722d-74f6-4f57-be0d-8343de0765f5

Texto do revisor, sem edição:

---
# Revisão: eixo 4 (Documentação), produto `leigo`, commit `2a7dad5`

## Nota: 3 de 5

## Justificativa

A documentação toda é um único `README.md` (115 linhas), mais comentários no código e nos scripts. Não há pasta `docs/`, registro de decisões (ADR), documento de arquitetura, convenções declaradas, plano de evolução ou `CLAUDE.md`/`AGENTS.md`.

Dentro desse limite, o README é bem feito e foi escrito pensando no projeto, não é um modelo genérico:
- **Regras de produto:** lista o que o app faz e quem pode fazer o quê (`README.md:5-14`) e traz uma tabela de pontos (`README.md:88-99`). Os valores batem com `src/regras.js:4-29` e `src/pontos.js:20-30`.
- **Execução:** explica como rodar localmente, como carregar dados de exemplo, como ligar o acesso da banca e como fazer o deploy no Azure e em servidor Ubuntu (`README.md:16-86`).
- **Estrutura:** mostra os arquivos principais e onde ficam os dados (`README.md:101-114`).

Isso atende ao nível 3 da rubrica ("regras de produto e instruções de execução documentadas; arquitetura só implícita no código"). Não chega ao 4 por três motivos:
- A arquitetura só aparece como uma lista de arquivos, e incompleta.
- As decisões técnicas estão espalhadas em comentários, sem alternativas nem consequências. Exemplos: SQLite sem WAL no Azure (`src/db.js:11-12`), pontos recalculados a partir dos dados (`src/pontos.js:1-3`), proxy confiável no Azure (`src/app.js:113-117`).
- Há trechos do README que não batem com o código (detalhes abaixo).

Uma pessoa nova consegue rodar e publicar o projeto. Para continuar a evolução, precisaria ler o código para entender a arquitetura e o motivo das escolhas.

## Evidências

1. **`README.md:5-14`**: descreve as funções e regras de permissão (só a faculdade fixa avisos; cada professor apaga só os próprios avisos). Confere com `src/app.js:386-439`.
2. **`README.md:88-99`**: a tabela de pontos (+10 post, +2 curtida, +3 comentário uma vez por post, medalhas de +20 a +50, conquistas de +20 a +100) confere com `src/regras.js:4-29`. Também diz onde mudar as regras (`src/regras.js`, `src/config.js`).
3. **`README.md:16-34`**: instruções de execução local com versão do Node (bate com `package.json:12-14`), conta admin padrão e `npm run demo`.
4. **`README.md:36-53`**: documenta o acesso da banca (variável `CODIGO_BANCA`, limite de tentativas, contas sem senha). Confere com `src/banca.js:1-6` e `:35`.
5. **`README.md:62-86`**: deploy no Azure (com a URL de produção) e em servidor Ubuntu. Os scripts têm cabeçalho explicativo (`scripts/servidor.sh:2-10`, `scripts/publicar.ps1:1-4`, `scripts/publicar-azure.ps1:1-5`).
6. **Divergência, `README.md:8`**: diz "só e-mails `@unimax.edu.br` conseguem criar conta". Mas `src/config.js:9` aceita também `al.unieduk.com.br` e `prof.unieduk.com.br`. O próprio README admite isso só mais adiante (`README.md:57`), e a especificação fala em `@unimax.com.br`.
7. **Divergência, `README.md:101-112`**: a seção "Estrutura" omite `src/server.js`, `src/banca.js`, `src/pontos.js`, `src/html.js`, `src/senha.js` e a pasta `scripts/`. Justamente os arquivos de sessão, pontuação e proteção contra XSS ficam sem mapa.
8. **`README.md:12`**: a regra "só alunos participam do ranking" está documentada e confere com `src/pontos.js:18` (`WHERE u.papel = 'aluno'`).
9. **Decisões só em comentários**: `src/db.js:11-12` (modo do SQLite no Azure), `src/pontos.js:1-3` e `:65-80` (pontos derivados dos dados; migração por `user_version`), `src/feed.js:15` (desempate na ordem do feed), `src/html.js:1-2` (escape automático contra XSS). Nenhuma traz alternativas nem consequências.
10. **O que não existe**: nenhum ADR ou registro de decisões, nenhum documento de arquitetura ou modelo de dados (o esquema do banco só está em `src/db.js`), nenhum roadmap, nenhum guia de contribuição ou convenções, nenhuma explicação de como rodar os testes além de "teste automático (npm test)" (`README.md:111`).

## Regras ausentes (não pesam na nota)

Nenhuma destas regras da especificação aparece no código nem na documentação. Busquei por RA, semestre, tier, Bronze, Diamante, categoria, all-time, seguidor, notificação, denúncia, ex-aluno e "esqueci" e não encontrei nada.

**Login e cadastro**
- Login por RA. Só existe login por e-mail.
- RA e semestre no cadastro e no perfil.
- "Esqueci minha senha".
- Ex-aluno que mantém posição no ranking mas deixa de pontuar.

**Troféus e medalhas**
- Tiers Bronze, Prata, Ouro e Diamante, com as faixas 1-30, 31-70, 71-100 e 101-150 pontos.
- Nível de "encontrabilidade" dos prêmios.
- Progressão de tier para a mesma conquista repetida.
- Troféus por assiduidade, techdays, feiras e acúmulo, e cadastro de troféus pela faculdade.
- Prova por foto e denúncia/revogação de prêmios.
- Professor só dá medalha a alunos de quem é professor ou orientador.

**Ranking**
- Rankings all-time (geral e por curso).

**Mural**
- Categorias (Faculdade, Curso, Professores) e filtro de avisos por relevância para o aluno.
- Comportamento de colapso e semi-colapso dos avisos e botão "ler todos".
- Log de leitura (quem leu e quando).

**Perfil e feed**
- Seguidores, seguindo e "followed by".
- Sino de notificações no header.
- Busca na navegação inferior.

## Decisões do agente neste eixo (não pesam na nota)

- Escrever o README inteiro em português e em linguagem para leigos ("Como rodar no seu computador", "o plano grátis cochila").
- Documentar o acesso da banca do TCC (`CODIGO_BANCA`) como funcionalidade, com regras de segurança explicadas.
- Documentar dois caminhos de deploy (Azure App Service F1 e servidor Ubuntu com Caddy e sslip.io), incluindo a URL de produção.
- Documentar limitações do plano gratuito do Azure (hibernação, cerca de 1 GB) e a orientação de fazer backup da pasta `dados/`.
- Publicar no README a senha padrão do admin (`unimax-admin`) e a senha das contas de demonstração (`senha1234`).
- Incluir a tabela "Como funcionam os pontos" com valores que o próprio agente criou (pontos por post, curtida e comentário, e conquistas automáticas), no lugar dos tiers da ideia.
- Explicar decisões técnicas só em comentários no código, sem nenhum registro de decisões.
- Pôr cabeçalhos explicativos nos scripts de deploy e de dados de exemplo.
- Documentar "como liberar um professor" pelo painel de administração e pelo domínio `@prof.unieduk.com.br`.

## O que não pude verificar (sessão só de leitura)

- Se `npm install` / `npm start` sobem o app como o README promete, e se `npm run demo` cria as contas citadas.
- Se os scripts de deploy funcionam e se https://maxx-guilherme.azurewebsites.net está no ar com este commit.
- Se `npm test` passa.
- Se `ADMIN_SENHA` só tem efeito antes do primeiro uso, como o README diz. Não executei o seed de `src/db.js`.
- O histórico do git, para saber se o README foi sendo atualizado a cada rodada. O repositório só tem um packfile, que não dá para ler com estas ferramentas.

```json
{
  "nota": 3,
  "justificativa": "A documentação se resume a um README.md (115 linhas) bem escrito e específico do projeto, mais comentários no código. Documenta as regras de produto (funcionalidades, permissões, tabela de pontos coerente com src/regras.js e src/pontos.js) e as instruções de execução, demo, acesso da banca e deploy (Azure e Ubuntu). Isso atende ao nível 3 da rubrica. Não chega ao 4: não há documento de arquitetura nem de modelo de dados, a seção Estrutura é só uma lista incompleta de arquivos, não há convenções declaradas, as decisões técnicas estão apenas em comentários sem alternativas nem consequências, não há ADR nem plano de evolução, e há pontos do README que não batem com o código (domínios permitidos, arquivos omitidos).",
  "evidencias": [
    {"local": "README.md:5-14", "descricao": "Lista as funcionalidades e regras de permissão (fixar e apagar avisos, medalhas de professores, ranking só de alunos); confere com src/app.js:386-439 e src/pontos.js:18."},
    {"local": "README.md:88-99", "descricao": "Tabela de pontos (+10 post, +2 curtida, +3 comentário uma vez por post, medalhas +20 a +50, conquistas +20 a +100) coerente com src/regras.js:4-29; indica onde alterar as regras."},
    {"local": "README.md:16-34", "descricao": "Instruções de execução local (Node >=22.13, igual a package.json:12-14), conta admin padrão e npm run demo."},
    {"local": "README.md:36-53", "descricao": "Documenta o acesso da banca via CODIGO_BANCA, limite de tentativas e contas sem senha; coerente com src/banca.js:1-6 e :35."},
    {"local": "README.md:62-86", "descricao": "Deploy no Azure App Service (com URL) e em servidor Ubuntu; scripts com cabeçalho explicativo (scripts/servidor.sh:2-10, scripts/publicar.ps1:1-4, scripts/publicar-azure.ps1:1-5)."},
    {"local": "README.md:8", "descricao": "Diz que só e-mails @unimax.edu.br criam conta, mas src/config.js:9 aceita também al.unieduk.com.br e prof.unieduk.com.br; o próprio README só admite isso em README.md:57."},
    {"local": "README.md:101-112", "descricao": "A seção Estrutura omite src/server.js, src/banca.js, src/pontos.js, src/html.js, src/senha.js e scripts/; arquitetura só parcialmente mapeada."},
    {"local": "src/db.js:11-12", "descricao": "Decisão técnica (SQLite sem WAL no Azure) registrada apenas em comentário, sem alternativas nem consequências."},
    {"local": "src/pontos.js:1-3", "descricao": "Decisão de calcular os pontos a partir dos dados reais documentada só em comentário; migração por PRAGMA user_version (src/pontos.js:75-80) também não aparece em documento."},
    {"local": "src/html.js:1-2", "descricao": "Convenção de escape automático contra XSS descrita só no comentário do arquivo, sem guia de convenções do projeto."},
    {"local": "raiz do repositório", "descricao": "Não há pasta docs/, ADR, documento de arquitetura ou modelo de dados, roadmap, CONTRIBUTING nem CLAUDE.md/AGENTS.md; o README é o único documento."}
  ],
  "regras_ausentes": [
    "Login por RA (só e-mail)",
    "RA e semestre no cadastro/perfil",
    "Esqueci minha senha",
    "Ex-aluno mantém posição no ranking sem pontuar",
    "Tiers Bronze/Prata/Ouro/Diamante com faixas 1-30, 31-70, 71-100, 101-150",
    "Nível de encontrabilidade dos prêmios",
    "Progressão de tier para conquista repetida",
    "Troféus por assiduidade, techdays, feiras e acúmulo, com cadastro de troféus pela faculdade",
    "Prova por foto e denúncia/revogação de prêmios",
    "Professor só dá medalha a alunos que leciona/orienta",
    "Rankings all-time geral e por curso",
    "Categorias do mural (Faculdade, Curso, Professores) e filtro por relevância",
    "Colapso/semi-colapso de avisos e botão ler todos",
    "Log de leitura do mural (quem leu e quando)",
    "Seguidores/seguindo/followed by no perfil",
    "Sino de notificações no header",
    "Busca na navegação inferior"
  ],
  "decisoes_do_agente": [
    "Escrever o README em português e em linguagem para leigos",
    "Documentar o acesso da banca do TCC (CODIGO_BANCA) como funcionalidade, com regras de segurança",
    "Documentar dois caminhos de deploy (Azure App Service F1 e Ubuntu com Caddy/sslip.io), incluindo a URL de produção",
    "Documentar limitações do plano gratuito do Azure e a orientação de backup da pasta dados/",
    "Publicar no README a senha padrão do admin (unimax-admin) e a das contas de demonstração (senha1234)",
    "Documentar uma tabela de pontos inventada pelo agente (post, curtida, comentário, conquistas automáticas) no lugar dos tiers da ideia",
    "Registrar decisões técnicas apenas em comentários no código, sem registro de decisões",
    "Pôr cabeçalhos explicativos nos scripts de deploy e de dados de exemplo",
    "Documentar a liberação de professor pelo painel de Administração e pelo domínio @prof.unieduk.com.br"
  ],
  "nao_verificado": [
    "Se npm install / npm start / npm run demo funcionam como descrito no README",
    "Se os scripts de deploy funcionam e se a URL do Azure está no ar com este commit",
    "Se npm test passa",
    "Se ADMIN_SENHA só tem efeito antes do primeiro uso, como o README afirma",
    "O histórico do git, para avaliar se a documentação foi mantida em dia ao longo das rodadas (packfile não legível com as ferramentas disponíveis)"
  ]
}
```
