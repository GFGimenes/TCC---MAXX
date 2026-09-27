Design system do **MAXX**, a rede social gamificada da rede UniEduk (UniMax e UniFaj), na identidade **Marinho & Ouro**: institucional e cerimonial. A UniMax entrega o prêmio; o marinho dá confiança, o ouro aparece só onde há conquista, e os selos são medalhões metálicos como os de uma colação. A prancheta está dividida em cartões (Paleta, Tipografia, Tiers, Componentes) e as sete telas (login, feed, perfil, mural, troféus, medalhas, rankings) aparecem em claro e escuro lado a lado.

## Produto e conteúdo

- A estrutura das telas segue o Instagram: cabeçalho de 52px, avatar de 86px no perfil, botões de perfil baixos (32px) e discretos em `surface`, grade de 3 colunas sem legenda, abas só com ícone, post com foto de largura total e as ações coração, comentário, enviar e salvar.
- Navegação inferior fixa, sempre nesta ordem: Home, Busca, Mural (centro, ícone de jornal, em bloco `primary` com ícone `accent` no claro e `on-primary` no escuro), Troféus, Perfil (avatar).
- Logo MAXX no feed e no login; no perfil, o nome de usuário no cabeçalho. Use `maxx-ouro` sobre fundos claros e sobre marinho; `maxx-branco` só sobre fotos, quando o ouro competir com a imagem.
- Texto em português do Brasil, frases curtas, segunda pessoa implícita ("Marcar todos como lidos", "Editar perfil"). Sem emoji na interface. Números no formato brasileiro: 15.020, #29.
- Login só por e-mail institucional ou RA. Não desenhar botões de login social.

## Prêmios: tier e raridade

- **Tier** define os pontos e é sempre um metal: Bronze 1 a 30, Prata 31 a 70, Ouro 71 a 100, Diamante 101 a 150. Cores em `tier-bronze`, `tier-prata`, `tier-ouro`, `tier-diamante`, com `-hi` (brilho) e `-lo` (sombra e glifo) formando o gradiente do medalhão. Para escrever o nome do tier como texto sobre a tela use `tier-*-text`; sobre o metal, `tier-ink`.
- **Raridade** (Comum, Raro, Épico, Lendário) é o ornamento em volta do medalhão, na cor `primary`: sem anel, anel simples, anel duplo, anel com raios. Nunca usa a cor do tier.
- **Troféu** leva taça; **medalha** leva fita. Troféus vêm da instituição ou de regras automáticas; medalhas vêm de professores e mostram quem deu.
- **Selo compacto** do post: pílula (`radius-pill`) com o gradiente do metal, medalhão de 20px e o nome em `tier-ink`.
- **Progressão**: a mesma conquista repetida rende um prêmio de tier acima. A trilha liga os tiers obtidos com linha contínua e mostra o próximo tracejado com cadeado (ex.: "Média 10 em uma matéria": Bronze 5, Prata 35, Ouro 75, próximo Diamante).
- O aluno não tem tier: só pontos e posição. Nunca pinte avatar ou nome de aluno com cor de tier.

## Telas

- **Login**: logo sobre a faixa `hero`, card com abas Entrar e Cadastrar, campo único "RA ou e-mail institucional", senha com olho, "Esqueci minha senha", botão `primary` largo. Primeiro acesso é vinculado pelo Portal UniMax com o RA. Rodapé com o selo UniMAX e "Rede UniEduk".
- **Feed**: post com cabeçalho (avatar, nome, curso e semestre, selo compacto), foto, ações, faixa do prêmio (medalhão, tier e raridade, pontos), curtidas e legenda.
- **Perfil**: nome de usuário no cabeçalho; pontos, posição geral, seguidores e seguindo (pontos e posição abrem o ranking); último troféu; destaques com os medalhões; abas grade, troféus, medalhas.
- **Mural**: chips Todos, Faculdade, Curso, Professores; o aviso mais recente semi-expandido, os outros só com o título.
- **Conquistas**: abas Troféus e Medalhas com contagem, resumo de pontos e o filtro "Mostrar não obtidos". Cada linha: medalhão de 48px, nome, tier e raridade, origem e pontos à direita. Prêmio não obtido em cinza, com cadeado no lugar dos pontos.
- **Rankings**: chips Geral, Por curso, All-time geral, All-time por curso; saltos de posição marcados com "···"; a linha do próprio aluno em `highlight`. Ex-alunos aparecem com a pontuação final e o rótulo ex-aluno.

## Fundamentos visuais

- Margem lateral de toda tela: `space-4` (16px). Grade de 4px.
- Raios: `radius-sm` em botões, `radius-field` em campos, `radius-md` em cards, `radius-pill` em chips, selo compacto e avatares.
- Texto principal em `ink` sobre `bg` e `surface`; secundário em `ink-2` sobre os mesmos fundos (acima de 4.5:1 nos dois temas). Links em `link`. Nunca escreva texto em `accent` (ouro) sobre fundo claro.
- No escuro, `primary` vira ouro e o texto sobre ele vira marinho (`on-primary`).
- Não lido: bolinha em `accent` com contorno `tier-ouro-lo`, sempre com a palavra "Não lido" ou o título em negrito, porque o ouro sozinho não tem contraste suficiente no branco.
- Curtida preenchida em `like`, só como ícone.
- Sem sombras na interface do app (exceto o card do login sobre a faixa `hero`); separação por `line` de 1px e por `surface`. Sem gradientes, exceto o metal dos prêmios.

## Tipografia

- `display` e `numeral` em Archivo ExtraBold itálico: títulos de tela, pontos e posições. A inclinação ecoa o logo.
- `title`, `body` e `caption` em Figtree: toda a interface, de 12 a 15px.

## Iconografia

Ícones de traço 1.8px em grade de 24px, pontas arredondadas, cor `ink` (ícone ativo da navegação com traço 2.6px), no estilo Lucide. O ícone do Mural reproduz o jornal com dois blocos dos rascunhos. Troque pelo conjunto definitivo quando houver um.

## Imagens

`Fotos/campus.jpg` é o recorte do campus da tela antiga e serve de foto de exemplo. Avatares de exemplo são iniciais sobre tons neutros até haver fotos reais.
