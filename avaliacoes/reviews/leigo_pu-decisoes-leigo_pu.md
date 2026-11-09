# Revisor de decisões: leigo_pu, export leigo_pu-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\leigo\leigo_pu-sessao.txt (SHA-256 a19b51f05ce741aab69842d238f88e3af7c5f820f5b8284e9401a4bbc5afd0d3)
- Leitura do export: 767 de 767 linhas, em 1 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: b3b291a0-a889-429f-960f-caa2fff20083

Texto do revisor, sem edição:

---
Li a transcrição inteira, que tem 767 linhas. Muito do conteúdo aparece recolhido no export ("… +N lines (ctrl+o to expand)"). Isso inclui a maior parte do `DECISOES.md`, de `schema.sql`, `rules.js`, `index.js`, `app.js` e do README, além da saída dos comandos shell. A lista abaixo se baseia só no que está visível. Algumas decisões podem estar declaradas no `DECISOES.md` sem que dê para ver. Por isso, quando a única evidência é um arquivo escrito, marquei a decisão como silenciosa.

A persona deu uma ordem geral: "decidindo por conta própria o que eu teria que decidir". Isso não determina nenhuma escolha específica, então contei cada escolha como decisão do agente. Não contei o que a mensagem da persona fixou: as seis áreas do app, a ausência de stories, vídeos e mensagens, o acesso restrito à UniMax, as medalhas dadas por professores, os rankings geral e por curso, o acesso fácil para a banca, as instruções de como rodar e o commit do registro.

## 1. Decisões tomadas sem perguntar

| # | Decisão | Trecho | Tipo | Forma | Duvidosa |
|---|---|---|---|---|---|
| 1 | Fazer um app web instalável (PWA) em vez de um app de loja | "Fiz um app web instalável (PWA), não um app de loja." | stack e arquitetura | declarada | não |
| 2 | Node.js ≥20 com Express 5 e ES modules | `"type": "module"`, `"express": "^5.1.0"`, `"node": ">=20"` | stack e arquitetura | silenciosa | não |
| 3 | PostgreSQL via `DATABASE_URL` (Neon) e, sem ela, PGlite embutido gravando em `./data` | "Se não existir, usa o PGlite: um PostgreSQL embutido que salva tudo na pasta ./data." | stack e arquitetura | silenciosa | não |
| 4 | Front-end em JS puro, sem framework e sem etapa de build | "app do navegador (sem frameworks, sem etapa de build)" | stack e arquitetura | silenciosa | não |
| 5 | Esquema com as tabelas courses, images, users, sessions, posts, likes, comments, medals, user_trophies, points (pontos lançados em tabela própria) e notices | `DROP TABLE IF EXISTS notices, points, user_trophies, medals, comments, likes, posts, sessions, users, images, courses` | modelo de dados | silenciosa | não |
| 6 | Fotos gravadas no próprio banco (tabela images, `saveImage`) | "CREATE TABLE IF NOT EXISTS images" / `saveImage('image/svg+xml', …)` | modelo de dados | silenciosa | não |
| 7 | Cadastro só com e-mail @unimax.edu.br ou @aluno.unimax.edu.br, configurável | "Por padrão aceito @unimax.edu.br e @aluno.unimax.edu.br" | segurança | declarada | não |
| 8 | Exigir um código de professor no cadastro | "Professor precisa de um código no cadastro." | segurança | declarada | não |
| 9 | Só alunos publicam fotos; professores curtem, comentam, dão medalhas e publicam avisos | "Só alunos publicam fotos." | regra de produto | declarada | não |
| 10 | Tabela de pontos: foto +10 (só as 3 primeiras do dia), curtida recebida +2, medalha de +20 a +100, troféu de +15 a +200 | "foto publicada: +10, mas só as 3 primeiras do dia contam" | regra de produto | declarada | não |
| 11 | Prêmios automáticos viram 13 troféus com barra de progresso; as medalhas ficam em 7 tipos | "13 troféus no estilo videogame, com barra mostrando quanto falta, e 7 tipos de medalha" | regra de produto | declarada | não |
| 12 | Ranking também por período: de sempre ou só do mês | "Ranking: geral e por curso, de sempre ou só do mês." | regra de produto | declarada | não |
| 13 | Aviso pode ir para todos ou só para um curso, com a opção de fixar | "O aviso pode ir para todos ou só para um curso." | regra de produto | declarada | não |
| 14 | Acesso da banca por link com código (`?banca=banca2026`): a pessoa digita só o nome, escolhe Aluno ou Professor e ganha conta própria com selo "Banca" | "https://seu-link/?banca=banca2026 … Cada avaliador ganha a própria conta, com um selo \"Banca\"" | segurança | declarada | não |
| 15 | Login com senha em hash scrypt e sessão por cookie guardada no banco | `crypto.scryptSync(String(password), salt, 64)` / `const COOKIE = 'maxx_session'` | segurança | silenciosa | não |
| 16 | Não fazer confirmação de e-mail nem "esqueci minha senha" (registrado como pendência) | "Confirmação de e-mail: hoje o app só confere se o e-mail termina em @unimax.edu.br" | segurança | declarada | sim |
| 17 | Dados de exemplo: cursos inventados, 12 alunos, 3 professores e 18 fotos, todos com a mesma senha `maxx123` | "Os cursos de exemplo são inventados." / "senha maxx123" | testes e processo | declarada | não |
| 18 | Identidade visual roxo/magenta em gradiente, com modo claro e escuro | `--brand: #5b3df5; --brand-2: #c03cf0;` | UX e visual | silenciosa | não |
| 19 | Curtir também com dois toques na foto | "curtir (inclusive com dois toques na foto)" | UX e visual | declarada | não |
| 20 | Perfil com bio, curso e posição no ranking, além do que foi pedido | "Perfil: foto, bio, curso, pontos, posição no ranking" | UX e visual | declarada | sim |
| 21 | Feed paginado por cursor (created_at, id), 12 itens por padrão e no máximo 60 | `Math.min(int(req.query.limit) \|\| 12, 60)` | stack e arquitetura | silenciosa | não |
| 22 | Redimensionar a foto no navegador e enviar como dataURL | `dataUrl = await resizeImage(file.files[0]);` | stack e arquitetura | silenciosa | não |
| 23 | Service worker com cache para abrir com internet ruim | "abre o app mesmo com internet ruim (usa a última versão salva)" | stack e arquitetura | silenciosa | não |
| 24 | Ícones gerados por script próprio, sem programa de imagem | "Gera os ícones do app (PNG e SVG) sem precisar de nenhum programa de imagem." | UX e visual | silenciosa | não |
| 25 | Testes automáticos com `node:test` sobre o fluxo principal, usando banco em memória | "Sobe o servidor com um banco em memória (não mexe nos seus dados)." | testes e processo | silenciosa | não |
| 26 | Conferir as telas num navegador em tamanho de celular, nos modos claro e escuro | "vou abrir o app num navegador de verdade (tamanho de celular) para conferir as telas" | testes e processo | declarada | não |
| 27 | Deploy permanente em Render (plano free, Blueprint `render.yaml`) com Neon e GitHub | "usa três serviços gratuitos, GitHub, Neon e Render" / `plan: free` | hospedagem e deploy | declarada | não |
| 28 | Link rápido por cloudflared e teste na rede local via IP do PC | "rode cloudflared tunnel --url http://localhost:3000" | hospedagem e deploy | declarada | não |
| 29 | Configuração por variáveis de ambiente (PORT, EMAIL_DOMAINS etc.) | "Configurações que podem ser trocadas por variáveis de ambiente (no Render: aba \"Environment\")" | hospedagem e deploy | silenciosa | não |
| 30 | Script `npm run reset` que apaga todas as tabelas e refaz os dados de exemplo | "Apaga TODOS os dados e deixa o banco vazio." | testes e processo | silenciosa | não |
| 31 | Avisos "da faculdade" assinados por uma conta admin | `const author = pi === null ? admin : profs[pi];` | modelo de dados | silenciosa | sim |
| 32 | Dados de exemplo arranjados para o feed abrir com uma foto e intercalar as conquistas | "Feed agora abre com foto e intercala conquistas." | UX e visual | declarada | não |

## 2. Perguntas feitas à persona

Nenhuma. A persona avisou que não responderia mais nada, e o agente não fez pergunta alguma durante a sessão.

```json
{
  "decisoes": [
    {"descricao": "Fazer um app web instalável (PWA) em vez de um app de loja", "trecho": "Fiz um app web instalável (PWA), não um app de loja.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Node.js >=20 com Express 5 e ES modules", "trecho": "\"type\": \"module\", \"express\": \"^5.1.0\", \"node\": \">=20\"", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "PostgreSQL via DATABASE_URL (Neon) e, sem ela, PGlite embutido gravando em ./data", "trecho": "Se não existir, usa o PGlite: um PostgreSQL embutido que salva tudo na pasta ./data.", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Front-end em JS puro, sem framework e sem etapa de build", "trecho": "app do navegador (sem frameworks, sem etapa de build)", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Esquema com as tabelas courses, images, users, sessions, posts, likes, comments, medals, user_trophies, points (pontos lançados em tabela própria) e notices", "trecho": "DROP TABLE IF EXISTS notices, points, user_trophies, medals, comments, likes, posts, sessions, users, images, courses", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Fotos gravadas no próprio banco (tabela images, saveImage)", "trecho": "CREATE TABLE IF NOT EXISTS images", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Cadastro só com e-mail @unimax.edu.br ou @aluno.unimax.edu.br, configurável", "trecho": "Por padrão aceito @unimax.edu.br e @aluno.unimax.edu.br", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Exigir um código de professor no cadastro", "trecho": "Professor precisa de um código no cadastro.", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Só alunos publicam fotos; professores curtem, comentam, dão medalhas e publicam avisos", "trecho": "Só alunos publicam fotos.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Tabela de pontos: foto +10 (só as 3 primeiras do dia), curtida recebida +2, medalha de +20 a +100, troféu de +15 a +200", "trecho": "foto publicada: +10, mas só as 3 primeiras do dia contam", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Prêmios automáticos viram 13 troféus com barra de progresso; as medalhas ficam em 7 tipos", "trecho": "13 troféus no estilo videogame, com barra mostrando quanto falta, e 7 tipos de medalha", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ranking também por período: de sempre ou só do mês", "trecho": "Ranking: geral e por curso, de sempre ou só do mês.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Aviso pode ir para todos ou só para um curso, com a opção de fixar", "trecho": "O aviso pode ir para todos ou só para um curso.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Acesso da banca por link com código (?banca=banca2026): só o nome, escolha Aluno ou Professor, conta própria com selo Banca", "trecho": "Cada avaliador ganha a própria conta, com um selo \"Banca\"", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Login com senha em hash scrypt e sessão por cookie guardada no banco", "trecho": "crypto.scryptSync(String(password), salt, 64)", "tipo": "segurança", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Não fazer confirmação de e-mail nem 'esqueci minha senha' (registrado como pendência)", "trecho": "Confirmação de e-mail: hoje o app só confere se o e-mail termina em @unimax.edu.br", "tipo": "segurança", "forma": "declarada", "duvidosa": true},
    {"descricao": "Dados de exemplo: cursos inventados, 12 alunos, 3 professores e 18 fotos, todos com a mesma senha maxx123", "trecho": "Os cursos de exemplo são inventados.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Identidade visual roxo/magenta em gradiente, com modo claro e escuro", "trecho": "--brand: #5b3df5; --brand-2: #c03cf0;", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Curtir também com dois toques na foto", "trecho": "curtir (inclusive com dois toques na foto)", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Perfil com bio, curso e posição no ranking, além do que foi pedido", "trecho": "Perfil: foto, bio, curso, pontos, posição no ranking", "tipo": "UX e visual", "forma": "declarada", "duvidosa": true},
    {"descricao": "Feed paginado por cursor (created_at, id), 12 itens por padrão e no máximo 60", "trecho": "Math.min(int(req.query.limit) || 12, 60)", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Redimensionar a foto no navegador e enviar como dataURL", "trecho": "dataUrl = await resizeImage(file.files[0]);", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Service worker com cache para abrir com internet ruim", "trecho": "abre o app mesmo com internet ruim (usa a última versão salva)", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Ícones gerados por script próprio, sem programa de imagem", "trecho": "Gera os ícones do app (PNG e SVG) sem precisar de nenhum programa de imagem.", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Testes automáticos com node:test sobre o fluxo principal, usando banco em memória", "trecho": "Sobe o servidor com um banco em memória (não mexe nos seus dados).", "tipo": "testes e processo", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Conferir as telas num navegador em tamanho de celular, nos modos claro e escuro", "trecho": "vou abrir o app num navegador de verdade (tamanho de celular) para conferir as telas", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Deploy permanente em Render (plano free, Blueprint render.yaml) com Neon e GitHub", "trecho": "usa três serviços gratuitos, GitHub, Neon e Render", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Link rápido por cloudflared e teste na rede local via IP do PC", "trecho": "rode cloudflared tunnel --url http://localhost:3000", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Configuração por variáveis de ambiente (PORT, EMAIL_DOMAINS etc.)", "trecho": "Configurações que podem ser trocadas por variáveis de ambiente (no Render: aba \"Environment\")", "tipo": "hospedagem e deploy", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Script npm run reset que apaga todas as tabelas e refaz os dados de exemplo", "trecho": "Apaga TODOS os dados e deixa o banco vazio.", "tipo": "testes e processo", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Avisos da faculdade assinados por uma conta admin", "trecho": "const author = pi === null ? admin : profs[pi];", "tipo": "modelo de dados", "forma": "silenciosa", "duvidosa": true},
    {"descricao": "Dados de exemplo arranjados para o feed abrir com uma foto e intercalar as conquistas", "trecho": "Feed agora abre com foto e intercala conquistas.", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false}
  ],
  "perguntas": [],
  "contagem": {"decisoes": 32, "declaradas": 17, "silenciosas": 15, "duvidosas": 3, "perguntas": 0, "perguntas_respondidas": 0}
}
```
