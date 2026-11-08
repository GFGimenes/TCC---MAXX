# Review leigo, eixo 6. Projeto e arquitetura

- Status: ok
- Tentativa: 1
- Commit avaliado: 2a7dad587e67aec8c45df37ce7b59c1f3eccfe2c (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 4325a51f-d8b6-4741-a82b-163e250dff14

Texto do revisor, sem edição:

---
# Revisão do eixo 6 (Projeto e arquitetura): produto `leigo`, commit `2a7dad587e67`

## Nota: 3 de 5

## Justificativa

O projeto é um monólito Node.js/Express pequeno, com páginas HTML geradas no servidor e banco SQLite (`node:sqlite`). Os módulos se separam por assunto de forma razoável, e o código é coerente com essa stack:

| Arquivo | O que faz |
|---|---|
| `config.js` | configuração por instituição |
| `regras.js` | valores de pontos, conquistas e medalhas padrão |
| `pontos.js` | cálculo de pontos e ranking |
| `feed.js` | montagem do feed |
| `db.js` | esquema do banco |
| `html.js` | templates com escape automático |
| `views.js` | telas |
| `app.js` | rotas |
| `banca.js` | acesso da banca |

Os pontos são calculados a partir dos dados reais, sem coluna de saldo que possa ficar inconsistente. Isso é uma escolha sensata.

Nota 4 não cabe, por três motivos:

1. **As regras não ficam num lugar só.** A regra "conquista atingida" (`s[c.conta] >= c.meta`) está em `pontos.js:21` e é refeita em `views.js:437` e `views.js:471-472`. A fórmula de pontos por ação de `pontos.js:23-28` é refeita no extrato do perfil (`views.js:369-371`). Mudar uma regra exige mexer em mais de um arquivo.
2. **Não há camada de dados.** As rotas de `app.js` (483 linhas) misturam roteamento, SQL, autorização e regras de negócio: quem pode apagar, quem pode fixar, quem dá medalha, contagem de avisos não lidos. As views também decidem permissões (`views.js:252`, `views.js:331`, `views.js:689-690`). Nada impede que essas decisões fiquem diferentes das de `app.js`.
3. **O modelo de dados não representa as regras centrais da ideia.** Não há tiers (Bronze, Prata, Ouro, Diamante), períodos (all-time ou semestre), RA nem situação de ex-aluno. Troféus e conquistas não ficam no banco: estão fixos no código (`regras.js:12-20`).

A escala também não foi pensada para o campus inteiro. O ranking recalcula todos os alunos com subconsultas a cada pedido, e `statsDoAluno` faz isso duas vezes a cada visita de perfil (`pontos.js:60-61`).

O produto cobre o pitch geral (rede social da faculdade com feed, perfil, pontos, medalhas de professor, ranking geral e por curso, mural e tela de troféus), mas com lacunas grandes de regra. As lacunas estão listadas como "ausentes" e não reduziram a nota.

## Evidências

- `src/regras.js:4-29` concentra os valores de pontos, as conquistas (meta e bônus) e as medalhas padrão. Esse é o ponto forte de localização das regras.
- `src/pontos.js:7-30` calcula os pontos a partir de contagens em SQL, sem saldo guardado.
- `src/views.js:369-371` repete `s.posts * PONTOS.post` e as outras parcelas, duplicando `pontos.js:23-28`.
- `src/views.js:437` e `src/views.js:471-472` repetem o critério de conquista de `pontos.js:21`.
- `src/views.js:4-5` faz a view importar `banca` e `regras`, então a camada de apresentação depende de módulos de regra.
- `src/app.js:228-465` mistura rotas, SQL embutido e regras de permissão, sem camada de repositório ou serviço.
- `src/app.js:132` coloca a regra da conta da banca dentro do middleware de sessão central. É um acoplamento evitável criado para a demonstração.
- `src/pontos.js:41-45` e `src/pontos.js:56-62`: cada ranking por curso refaz a consulta inteira e filtra em memória, e `statsDoAluno` chama `ranking()` duas vezes por perfil visitado. Fica caro com milhares de alunos.
- `src/pontos.js:77-80` faz uma migração de dados (`PRAGMA user_version`) dentro do módulo de pontos.
- `src/db.js:106-111` faz outra migração ad hoc (`ALTER TABLE`). Não há mecanismo único de migração.
- `src/db.js:20-30`: a tabela `usuarios` não tem RA, semestre nem situação de ex-aluno. O papel é limitado por `CHECK`, o que é adequado.
- `src/db.js:62-78`: `tipos_medalha` tem só `pontos`, sem tier nem "encontrabilidade", e não há tabela de troféus nem de períodos.
- `src/db.js:94-101`: `avisos` não tem categoria (Faculdade, Curso, Professores) nem log de leitura. Fica só `mural_visto_id` em `usuarios`.
- `src/app.js:333-346`: qualquer professor dá medalha a qualquer aluno, sem relação de turma no modelo.
- `src/config.js:9`: os domínios aceitos são `unimax.edu.br` e `unieduk`. A especificação pede `@unimax.com.br`.
- `src/views.js:141` diz que o professor deve pedir liberação, enquanto `config.js:11` e `app.js:177` promovem automaticamente o domínio de professor. A mesma regra de papel aparece de forma incoerente em dois lugares.
- `src/views.js:84-90`: a navegação inferior tem Início, Mural, Postar, Ranking e Perfil. Não tem Busca nem Troféus (a especificação pede Home, Busca, Mural, Troféus e Perfil).
- `src/feed.js:16-27` está bem estruturado (união de posts, medalhas e conquistas com paginação e consultas em lote). As conquistas aparecem como cartões separados, não como selo dentro do post.
- `src/html.js:1-33` é um mini sistema de templates com escape padrão, uma abstração pequena e adequada.
- **Tela Ranking:** a especificação pede 4 visões (Geral, Curso, All-time geral, All-time curso). O produto tem Geral e uma aba por curso (`views.js:552-560`), sem visões por período.

## Regras ausentes

- Tiers Bronze, Prata, Ouro e Diamante, com as faixas de pontos (1–30, 31–70, 71–100, 101–150).
- Progressão de tier ao repetir a mesma conquista.
- Diferença entre troféus (peso maior) e medalhas como entidades próprias.
- Nível de "encontrabilidade" dos prêmios.
- Cadastro de troféus e medalhas pelo corpo da faculdade, pela interface.
- Restrição de que o professor só dá medalha a alunos de quem é professor ou orientador.
- Prova por foto, denúncia e revogação de prêmios.
- Login por RA. RA no cadastro e semestre no perfil.
- Ex-aluno que mantém acesso e posição, mas não pontua mais.
- "Esqueci minha senha".
- Rankings all-time geral e all-time por curso (períodos).
- Seguidores, seguindo e "followed by".
- Sino de notificações no header.
- Busca na navegação.
- Compartilhar post.
- Selo de conquista associado ao post.
- Categorias do mural (Faculdade, Curso, Professores) com filtro e público-alvo por curso.
- Comportamento de colapso e semi-colapso do mural, bolinha amarela por aviso e botão "ler todos".
- Log de leitura dos avisos (quem leu e quando). É diferença de escopo emergente esperada na trilha leiga.
- Troféus de assiduidade, techdays, feiras e acúmulo ligados a eventos acadêmicos.
- Domínio institucional `@unimax.com.br`.

## Decisões do agente

- Stack de monólito Express com HTML no servidor, sem framework de front-end, com template próprio (`html.js`) e SQLite nativo do Node.
- Pontos calculados a partir dos fatos (posts, curtidas, comentários, medalhas), sem saldo guardado.
- Sistema próprio de pontos por ação social: post +10, curtida recebida +2, comentário +3. Esse sistema substitui a pontuação por tier dos prêmios.
- "Conquistas" automáticas definidas no código (`regras.js`) fazem o papel de troféus. As conquistas desbloqueadas ficam numa tabela à parte, só para o feed.
- Medalhas padrão criadas no banco na primeira execução, a partir de constante no código.
- Feed único que mistura posts, medalhas e conquistas, com paginação.
- Só alunos participam do ranking. Professores e admin ficam de fora.
- Papel `admin` ("conta da faculdade") e tela de Administração para mudar papéis.
- Promoção automática a professor por domínio de e-mail.
- Mural com fixação só pelo admin e contador de não lidos por "último id visto".
- Módulo de acesso da banca (`banca.js`) com contas de teste sem senha, ligado por variável de ambiente.
- Migrações ad hoc dentro de `db.js` e `pontos.js`, sem ferramenta de migração.
- Configuração da instituição (cursos, domínios) em `config.js` no código, não no banco.
- Navegação inferior própria (Início, Mural, Postar, Ranking, Perfil), com Troféus acessível pelo perfil.

## O que não pude verificar

Só tive leitura de arquivos, então ficou sem verificação:

- Se a aplicação sobe e se as rotas funcionam de ponta a ponta.
- Se `npm test` passa.
- O desempenho real do ranking e do perfil com muitos alunos.
- Se o deploy citado no README (Azure, `maxx-guilherme.azurewebsites.net`) está no ar e corresponde a este commit.
- O comportamento visual das telas.
- Se `node:sqlite` e `json_each` funcionam na versão de Node indicada.
- Quais regras a persona pediu de fato em cada rodada: não tive acesso aos prompts nem às sessões, então a lista de decisões do agente foi inferida só pelo código.

```json
{
  "nota": 3,
  "justificativa": "Monólito Express+SQLite coerente com a stack, com módulos razoavelmente separados por assunto (config, regras, pontos, feed, db, views, html, app). Valores de pontos e conquistas centralizados em regras.js e pontos calculados a partir dos fatos. Não chega a 4 porque as regras não ficam num lugar só: o critério de conquista e a fórmula de pontos são refeitos em views.js. app.js mistura rotas, SQL embutido e permissões sem camada de dados, e as views também decidem permissões. O acesso da banca está acoplado ao middleware de sessão. O modelo de dados não representa tiers, períodos, RA nem ex-aluno, e troféus e conquistas estão fixos no código. O ranking recalcula todos os alunos a cada pedido (duas vezes por perfil), sem preparo para o campus inteiro. O produto cobre o pitch geral (feed, perfil, pontos, medalhas, ranking geral e por curso, mural, troféus) com lacunas grandes de regra, listadas como ausentes sem reduzir a nota.",
  "evidencias": [
    {"local": "src/regras.js:4-29", "descricao": "Valores de pontos, conquistas e medalhas padrão centralizados num só módulo (ponto forte)."},
    {"local": "src/pontos.js:7-30", "descricao": "Pontos calculados a partir de contagens em SQL, sem saldo guardado."},
    {"local": "src/views.js:369-371", "descricao": "Extrato do perfil repete a fórmula de pontos por ação, duplicando pontos.js:23-28."},
    {"local": "src/views.js:437", "descricao": "Critério 's[c.conta] >= c.meta' repetido na view, duplicando pontos.js:21."},
    {"local": "src/views.js:471-472", "descricao": "Tela de troféus recalcula conquistas ganhas e faltantes em vez de usar stats.conquistas."},
    {"local": "src/views.js:4-5", "descricao": "Camada de apresentação importa banca.js e regras.js (dependência da view em módulos de regra)."},
    {"local": "src/app.js:228-465", "descricao": "Rotas com SQL embutido e regras de permissão misturadas, sem camada de repositório ou serviço."},
    {"local": "src/app.js:132", "descricao": "Regra das contas da banca dentro do middleware central de sessão (acoplamento evitável)."},
    {"local": "src/pontos.js:41-45", "descricao": "Ranking por curso refaz a consulta de todos os alunos e filtra em memória."},
    {"local": "src/pontos.js:56-62", "descricao": "statsDoAluno chama ranking() duas vezes a cada perfil visitado: custo cresce com o número de alunos."},
    {"local": "src/pontos.js:77-80", "descricao": "Migração de dados (PRAGMA user_version) escondida no módulo de pontos."},
    {"local": "src/db.js:106-111", "descricao": "Outra migração ad hoc (ALTER TABLE) em db.js; não há mecanismo único de migração."},
    {"local": "src/db.js:20-30", "descricao": "Tabela usuarios sem RA, semestre ou situação de ex-aluno; papel limitado por CHECK."},
    {"local": "src/db.js:62-78", "descricao": "tipos_medalha só com pontos; sem tier, encontrabilidade, tabela de troféus ou de períodos."},
    {"local": "src/db.js:94-101", "descricao": "avisos sem categoria e sem log de leitura."},
    {"local": "src/app.js:333-346", "descricao": "Qualquer professor dá medalha a qualquer aluno; o modelo não tem relação de turma."},
    {"local": "src/config.js:9", "descricao": "Domínios aceitos unimax.edu.br e unieduk, diferente do @unimax.com.br da especificação."},
    {"local": "src/views.js:141", "descricao": "Texto diz que o professor deve pedir liberação, mas config.js:11 e app.js:177 promovem automaticamente o domínio de professor (regra incoerente em dois lugares)."},
    {"local": "src/views.js:84-90", "descricao": "Navegação inferior sem Busca e sem Troféus, diferente da especificação (Home, Busca, Mural, Troféus, Perfil)."},
    {"local": "src/feed.js:16-27", "descricao": "Feed bem estruturado (união com paginação e carga em lote), mas conquistas como cartões separados, não como selo no post."},
    {"local": "src/html.js:1-33", "descricao": "Mini sistema de templates com escape padrão, abstração pequena e adequada."},
    {"local": "Tela Ranking", "descricao": "Só Geral e uma aba por curso (views.js:552-560); faltam as visões all-time pedidas na especificação."}
  ],
  "regras_ausentes": [
    "Tiers Bronze, Prata, Ouro e Diamante com faixas de pontos 1-30, 31-70, 71-100, 101-150",
    "Progressão de tier ao repetir a mesma conquista",
    "Distinção entre troféus (peso maior) e medalhas como entidades próprias",
    "Nível de encontrabilidade dos prêmios",
    "Cadastro de troféus e medalhas pelo corpo da faculdade pela interface",
    "Professor só dá medalha a alunos de quem é professor ou orientador",
    "Prova por foto, denúncia e revogação de prêmios",
    "Login por RA; RA no cadastro e semestre no perfil",
    "Ex-aluno mantém acesso e posição mas não pontua",
    "Esqueci minha senha",
    "Rankings all-time geral e all-time por curso (períodos)",
    "Seguidores, seguindo e followed by",
    "Sino de notificações no header",
    "Busca na navegação",
    "Compartilhar post",
    "Selo de conquista associado ao post",
    "Categorias do mural (Faculdade, Curso, Professores) com filtro e público-alvo",
    "Colapso e semi-colapso do mural, bolinha amarela por aviso e botão ler todos",
    "Log de leitura dos avisos (diferença de escopo emergente esperada na trilha leiga)",
    "Troféus de assiduidade, techdays, feiras e acúmulo ligados a eventos acadêmicos",
    "Domínio institucional @unimax.com.br"
  ],
  "decisoes_do_agente": [
    "Monólito Express com HTML gerado no servidor, template próprio (html.js) e SQLite nativo do Node",
    "Pontos calculados a partir dos fatos, sem saldo guardado",
    "Sistema próprio de pontos por ação social (post +10, curtida recebida +2, comentário +3) no lugar da pontuação por tier dos prêmios",
    "Conquistas automáticas fixas em regras.js fazendo o papel de troféus, com tabela à parte só para o feed",
    "Medalhas padrão criadas no banco na primeira execução a partir de constante no código",
    "Feed único misturando posts, medalhas e conquistas com paginação",
    "Só alunos participam do ranking",
    "Papel admin (conta da faculdade) e tela de Administração para mudar papéis",
    "Promoção automática a professor por domínio de e-mail",
    "Mural com fixação só pelo admin e contador de não lidos por último id visto",
    "Módulo de acesso da banca com contas de teste sem senha, ligado por variável de ambiente",
    "Migrações ad hoc dentro de db.js e pontos.js sem ferramenta de migração",
    "Configuração da instituição (cursos, domínios) em config.js no código, não no banco",
    "Navegação inferior própria (Início, Mural, Postar, Ranking, Perfil), com Troféus acessível pelo perfil"
  ],
  "nao_verificado": [
    "Se a aplicação sobe e se as rotas funcionam de ponta a ponta",
    "Se npm test passa",
    "Desempenho real do ranking e do perfil com muitos alunos",
    "Se o deploy citado no README (Azure) está no ar e corresponde a este commit",
    "Comportamento visual das telas",
    "Compatibilidade de node:sqlite e json_each com a versão de Node indicada",
    "Quais regras a persona pediu de fato em cada rodada (sem acesso aos prompts e sessões); decisões do agente inferidas só pelo código"
  ]
}
```
