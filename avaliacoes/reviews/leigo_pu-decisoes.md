# Decisões do agente: leigo_pu (revisor de decisões)

Gerado pelo avaliador a partir dos arquivos `leigo_pu-decisoes-<export>.json`, um por export.
Insumo para a contagem do autor (H3), não a contagem. Sem deduplicação entre exports.

- Status do conjunto: ok
- Totais do revisor: decisoes 32, declaradas 17, silenciosas 15, duvidosas 3, perguntas 0, perguntas_respondidas 0

| Export | Status | Leitura completa | Decisões | Declaradas | Silenciosas | Duvidosas | Perguntas | Respondidas | Motivo |
|---|---|---|---|---|---|---|---|---|---|
| leigo_pu | ok | sim | 32 | 17 | 15 | 3 | 0 | 0 | - |

## Export leigo_pu

Decisões sem perguntar:

- Fazer um app web instalável (PWA) em vez de um app de loja [stack e arquitetura; declarada]. Trecho: "Fiz um app web instalável (PWA), não um app de loja."
- Node.js >=20 com Express 5 e ES modules [stack e arquitetura; silenciosa]. Trecho: ""type": "module", "express": "^5.1.0", "node": ">=20""
- PostgreSQL via DATABASE_URL (Neon) e, sem ela, PGlite embutido gravando em ./data [stack e arquitetura; silenciosa]. Trecho: "Se não existir, usa o PGlite: um PostgreSQL embutido que salva tudo na pasta ./data."
- Front-end em JS puro, sem framework e sem etapa de build [stack e arquitetura; silenciosa]. Trecho: "app do navegador (sem frameworks, sem etapa de build)"
- Esquema com as tabelas courses, images, users, sessions, posts, likes, comments, medals, user_trophies, points (pontos lançados em tabela própria) e notices [modelo de dados; silenciosa]. Trecho: "DROP TABLE IF EXISTS notices, points, user_trophies, medals, comments, likes, posts, sessions, users, images, courses"
- Fotos gravadas no próprio banco (tabela images, saveImage) [modelo de dados; silenciosa]. Trecho: "CREATE TABLE IF NOT EXISTS images"
- Cadastro só com e-mail @unimax.edu.br ou @aluno.unimax.edu.br, configurável [segurança; declarada]. Trecho: "Por padrão aceito @unimax.edu.br e @aluno.unimax.edu.br"
- Exigir um código de professor no cadastro [segurança; declarada]. Trecho: "Professor precisa de um código no cadastro."
- Só alunos publicam fotos; professores curtem, comentam, dão medalhas e publicam avisos [regra de produto; declarada]. Trecho: "Só alunos publicam fotos."
- Tabela de pontos: foto +10 (só as 3 primeiras do dia), curtida recebida +2, medalha de +20 a +100, troféu de +15 a +200 [regra de produto; declarada]. Trecho: "foto publicada: +10, mas só as 3 primeiras do dia contam"
- Prêmios automáticos viram 13 troféus com barra de progresso; as medalhas ficam em 7 tipos [regra de produto; declarada]. Trecho: "13 troféus no estilo videogame, com barra mostrando quanto falta, e 7 tipos de medalha"
- Ranking também por período: de sempre ou só do mês [regra de produto; declarada]. Trecho: "Ranking: geral e por curso, de sempre ou só do mês."
- Aviso pode ir para todos ou só para um curso, com a opção de fixar [regra de produto; declarada]. Trecho: "O aviso pode ir para todos ou só para um curso."
- Acesso da banca por link com código (?banca=banca2026): só o nome, escolha Aluno ou Professor, conta própria com selo Banca [segurança; declarada]. Trecho: "Cada avaliador ganha a própria conta, com um selo "Banca""
- Login com senha em hash scrypt e sessão por cookie guardada no banco [segurança; silenciosa]. Trecho: "crypto.scryptSync(String(password), salt, 64)"
- Não fazer confirmação de e-mail nem 'esqueci minha senha' (registrado como pendência) [segurança; declarada, duvidosa]. Trecho: "Confirmação de e-mail: hoje o app só confere se o e-mail termina em @unimax.edu.br"
- Dados de exemplo: cursos inventados, 12 alunos, 3 professores e 18 fotos, todos com a mesma senha maxx123 [testes e processo; declarada]. Trecho: "Os cursos de exemplo são inventados."
- Identidade visual roxo/magenta em gradiente, com modo claro e escuro [UX e visual; silenciosa]. Trecho: "--brand: #5b3df5; --brand-2: #c03cf0;"
- Curtir também com dois toques na foto [UX e visual; declarada]. Trecho: "curtir (inclusive com dois toques na foto)"
- Perfil com bio, curso e posição no ranking, além do que foi pedido [UX e visual; declarada, duvidosa]. Trecho: "Perfil: foto, bio, curso, pontos, posição no ranking"
- Feed paginado por cursor (created_at, id), 12 itens por padrão e no máximo 60 [stack e arquitetura; silenciosa]. Trecho: "Math.min(int(req.query.limit) || 12, 60)"
- Redimensionar a foto no navegador e enviar como dataURL [stack e arquitetura; silenciosa]. Trecho: "dataUrl = await resizeImage(file.files[0]);"
- Service worker com cache para abrir com internet ruim [stack e arquitetura; silenciosa]. Trecho: "abre o app mesmo com internet ruim (usa a última versão salva)"
- Ícones gerados por script próprio, sem programa de imagem [UX e visual; silenciosa]. Trecho: "Gera os ícones do app (PNG e SVG) sem precisar de nenhum programa de imagem."
- Testes automáticos com node:test sobre o fluxo principal, usando banco em memória [testes e processo; silenciosa]. Trecho: "Sobe o servidor com um banco em memória (não mexe nos seus dados)."
- Conferir as telas num navegador em tamanho de celular, nos modos claro e escuro [testes e processo; declarada]. Trecho: "vou abrir o app num navegador de verdade (tamanho de celular) para conferir as telas"
- Deploy permanente em Render (plano free, Blueprint render.yaml) com Neon e GitHub [hospedagem e deploy; declarada]. Trecho: "usa três serviços gratuitos, GitHub, Neon e Render"
- Link rápido por cloudflared e teste na rede local via IP do PC [hospedagem e deploy; declarada]. Trecho: "rode cloudflared tunnel --url http://localhost:3000"
- Configuração por variáveis de ambiente (PORT, EMAIL_DOMAINS etc.) [hospedagem e deploy; silenciosa]. Trecho: "Configurações que podem ser trocadas por variáveis de ambiente (no Render: aba "Environment")"
- Script npm run reset que apaga todas as tabelas e refaz os dados de exemplo [testes e processo; silenciosa]. Trecho: "Apaga TODOS os dados e deixa o banco vazio."
- Avisos da faculdade assinados por uma conta admin [modelo de dados; silenciosa, duvidosa]. Trecho: "const author = pi === null ? admin : profs[pi];"
- Dados de exemplo arranjados para o feed abrir com uma foto e intercalar as conquistas [UX e visual; declarada]. Trecho: "Feed agora abre com foto e intercala conquistas."

Perguntas do agente:

- (nenhuma listada)
