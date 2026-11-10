# Review engenheiro, eixo 1. Experiência do usuário

- Status: ok
- Tentativa: 1
- Commit avaliado: 076549bbea15649813d347c2618a4b51377e6bdd (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: d889e180-f5dd-45ce-b94f-7d93b5b1a1a9

Texto do revisor, sem edição:

---
# Revisão de UX: produto `engenheiro` (commit `076549bbea15`)

## Nota: 4 de 5

O front-end é Expo/React Native, em `apps/mobile`. As seis telas existem, e as quatro abas da especificação, mais o Perfil, estão na barra inferior. O Mural fica no centro e o Ranking abre a partir dos pontos. A condição da rubrica para a nota 1 não se aplica:
- o login aceita RA ou e-mail;
- o feed curte e comenta;
- o ranking tem as quatro visões.

**Pontos fortes:**
- **Estados tratados em todas as telas.** Cada lista trata carregamento (`ActivityIndicator`), erro com "Tentar de novo" (`ErrorState` com `onRetry`) e vazio com texto próprio de cada tela. A rolagem infinita e o "puxar para atualizar" também têm esses estados.
- **Erros sempre amigáveis.** Todo código de erro da API vira uma frase em português, e há tratamento para a falta de conexão. O erro cru nunca aparece.
- **Visual coerente.** Os tokens de tema são compartilhados, há tema claro e escuro, e os componentes se repetem: `Screen`, `Cabecalho`, `FilterChip`, `StateMessage`, `AvisoDeErro`.
- **Acessibilidade cuidada.** Há `role`, `accessibilityLabel` e `aria-selected`, alvos de toque mínimos e a bolinha de novidade anunciada ao leitor de tela.
- **Fácil para a banca.** O login tem um botão "Entrar na demonstração", e a própria tela explica o primeiro acesso de aluno e de professor.

**Por que não é 5:**
- **O perfil não segue o próprio mockup.** O mockup `design/telas/perfil-claro.png`, desenhado pelo autor, tem bio, "Último troféu", "Seguida por…" e o botão "Compartilhar". O código não tem nenhum desses itens.
- **O Mural não segue o comportamento da especificação.** A especificação pede que o aviso mais recente fique semi-aberto, que os avisos funcionem como sanfona e que o toque abra o aviso quase em tela cheia. O agente trocou isso por outra regra: não lido aberto e lido recolhido. A troca está documentada em `docs/produto.md` (seção 7).
- **O card do feed não tem campo de comentário.** Ele mostra só o link "Ver todos os N comentários", e comentar exige abrir outra tela.
- **A grade do perfil não mistura conteúdos.** Fotos, troféus e medalhas ficam em três abas separadas. A especificação pede uma grade mista.
- **O tema só muda pelo menu do Perfil.** Não há como trocar o tema na tela de login.

São divergências de detalhe, e as soluções adotadas são coerentes entre si. Ainda assim, impedem a nota 5 ("fiel à especificação e aos mockups").

## Evidências

| Local | O que mostra |
|---|---|
| `apps/mobile/src/autenticacao/LoginScreen.tsx:80-90` | Campo único "RA ou e-mail", com validação de campo vazio. |
| `apps/mobile/src/autenticacao/LoginScreen.tsx:47-52, 100-124` | Credencial errada aparece no campo da senha; as outras falhas aparecem abaixo do botão. O botão mostra "Entrando..." e fica desativado durante o envio. |
| `apps/mobile/src/autenticacao/LoginScreen.tsx:108-113, 126-137` | Link "Esqueci minha senha", texto de primeiro acesso e botão de demonstração. |
| `apps/mobile/src/cadastro/DadosScreen.tsx:19-21, 78-125` | O cadastro tem 3 passos (RA, e-mail institucional e senha; arroba; termo). Quando a conta já existe, oferece "Esqueci minha senha". |
| `apps/mobile/src/feed/FeedScreen.tsx:91-131, 138-144` | Feed com estados de carregando, erro e vazio, rolagem infinita, erro de paginação e "puxar para atualizar". |
| `apps/mobile/src/feed/CartaoDePost.tsx:106-121` | A curtida aparece na hora e é desfeita, com mensagem, se a API falhar. |
| `apps/mobile/src/feed/CartaoDePost.tsx:165-178, 240-275` | Selo e faixa do prêmio, curtidas, legenda, "Ver todos os N comentários" e horário. Não há campo de comentário no card. |
| `apps/mobile/src/posts/ComentariosScreen.tsx:167-196` | Comentar fica numa tela separada, com limite de 500 caracteres e estado de envio. |
| `apps/mobile/src/components/BottomNav.tsx:18-22, 85-92` | Ordem das abas: Home, Busca, Mural (centro), Troféus, Perfil (avatar), com bolinha de novidade. |
| `apps/mobile/src/perfil/PerfilScreen.tsx:361-369, 381-392` | Cabeçalho do perfil com pontos e #posição, seguidores e seguindo. A linha de descrição mostra "RA …". |
| `apps/mobile/src/perfil/PerfilScreen.tsx:384-388` | Os pontos abrem o ranking só no próprio perfil. No perfil de outra pessoa, apenas aparecem. |
| `apps/mobile/src/perfil/PerfilScreen.tsx:42-48, 151-169` | Três abas separadas (Posts, Troféus, Medalhas), em vez da grade mista da especificação. |
| `design/telas/perfil-claro.png` e `PerfilScreen.tsx` | Bio, "Último troféu", "Seguida por" e "Compartilhar" estão no mockup e não estão no código (a busca por `bio`, `ultimo` e `followed` em `src/perfil` não acha nada). |
| `apps/mobile/src/mural/MuralScreen.tsx:31-36, 95-158` | Filtros Todos, Faculdade, Curso e Professores. Botão "Ler todos", desativado quando não há nada a ler, com erro próprio. |
| `apps/mobile/src/mural/CartaoDeAviso.tsx:16-24` | Não lido aparece aberto com bolinha dourada; lido aparece recolhido; tocar expande sem registrar leitura. Não há a sanfona da especificação. |
| `apps/mobile/src/mural/AvisoScreen.tsx:39-43, 54` | Abrir o aviso registra a leitura (log de leitura presente). A tela inteira tem botão de voltar no topo à esquerda. |
| `apps/mobile/src/trofeus/TrofeusScreen.tsx:38-41, 61, 122-151` | Abas Troféus/Medalhas, chave "Mostrar não obtidos" (ligada por padrão) e trilhas de progressão. |
| `apps/mobile/src/trofeus/LinhaDePremio.tsx:48-80` | Cada linha mostra tier, raridade ("encontrabilidade") com %, critério, progresso e pontos; o que falta aparece apagado. |
| `apps/mobile/src/rankings/api.ts:23-36, 50-53` | Quatro visões: Geral, Curso, Histórico e Histórico do curso, filtradas por papel e por ex-aluno. |
| `apps/mobile/src/rankings/RankingsScreen.tsx:84-94, 123-144, 148-164` | Voltar, card "Sua posição", filtro "Todos / Quem eu sigo" e textos de vazio próprios. |
| `apps/mobile/src/api/erros.ts:4-121, 147-149` | Tabela de códigos de erro para mensagens em português, com padrão para "sem conexão". |
| `apps/mobile/src/perfil/MenuDoPerfil.tsx:61` | O controle de tema fica só no menu do Perfil; a tela de login segue o tema do aparelho. |

## Regras ausentes (não entram na nota)

- Bio no perfil.
- "Último troféu" em destaque no perfil.
- "Seguida por xxxx e yyyy" no perfil.
- Grade mista no perfil (fotos, troféus e fotos de troféus na mesma grade).
- Mural em sanfona: o mais recente semi-aberto, um aviso por vez e abertura quase em tela cheia.
- Campo "adicionar comentário" e comentários visíveis no próprio card do feed.
- Troca de tema na tela de login.
- Denúncia de prêmio pelo próprio aluno: só professor e instituição contestam (`docs/produto.md:512`).

## Decisões do agente sem pedido do prompt

1. Botão "Entrar na demonstração", com contas prontas, ligado por uma opção de configuração, para a banca usar sem explicação.
2. Cadastro em 3 passos (dados, escolha do arroba, termo de uso).
3. Texto de orientação no login: "Aluno cria a conta em Cadastrar. Professor define a senha em Esqueci minha senha".
4. Erro de credencial mostrado no campo da senha, "como no Instagram"; os outros erros, abaixo do botão.
5. Tabela única que transforma cada código de erro da API em mensagem em português, nunca o erro cru.
6. Curtida que aparece na hora e é desfeita, com mensagem, se a API falhar.
7. "Puxar para atualizar" e rolagem infinita em feed, mural, perfil, ranking e comentários.
8. Feed com recomendações aleatórias, para nunca ficar vazio, e uma ordem nova a cada atualização.
9. Instituição sem curtir e sem comentar: o coração some para esse papel.
10. Regra do Mural trocada: não lido aberto, lido recolhido, a leitura só conta ao abrir o aviso inteiro e "Ler todos" vale para o mural inteiro, não só para o filtro.
11. "Professores" no filtro do Mural mapeado para os avisos de turma.
12. Bolinha de novidade nas abas Mural e Troféus, consultada a cada 60 s; abrir Troféus apaga a bolinha.
13. Ranking sem aba própria: abre como tela empilhada a partir do perfil, de Troféus e da Busca, com filtro "Quem eu sigo" e o card "Sua posição".
14. A posição exibida em perfil, feed e Troféus é a do histórico geral.
15. "Mostrar não obtidos" ligado por padrão.
16. Perfil com três abas (Posts, Troféus, Medalhas) e versão de perfil própria para o professor (turmas do semestre e medalhas concedidas).
17. Botão "Conceder medalha" no perfil do aluno, para o professor que tem turma com ele.
18. RA exibido na linha de descrição do perfil.
19. Preferência de tema (sistema, claro ou escuro) salva no aparelho e acessível pelo menu do Perfil.
20. Botão "Enviar" que copia o link do post quando não há folha de compartilhamento.

## O que não pôde ser verificado

Esta sessão só permite leitura, então não subi o app, não rodei os testes e não comparei telas renderizadas.
- Renderização real das telas e fidelidade visual pixel a pixel aos PNGs de `design/telas`.
- Funcionamento de ponta a ponta com a API: login, cadastro, curtir, comentar, ler aviso, ranking.
- Se os testes de componente (`*.test.tsx`) passam.
- Diferenças entre web e nativo (navegação, folha de compartilhamento, teclado, área segura).
- Contraste real dos temas claro e escuro e tempos de carregamento.
- Os mockups originais do autor fora do repositório (`LOGIN.png`, `paigna de dashboard.png`). Usei como referência apenas as telas em `design/telas`.

```json
{
  "nota": 4,
  "justificativa": "As seis telas existem e se ligam por uma navegação inferior clara (Home, Busca, Mural central, Troféus, Perfil), com Ranking aberto pelos pontos. Login por RA ou e-mail, feed com curtir/comentar/enviar, perfil com pontos e #posição, mural com filtros, 'Ler todos' e log de leitura, troféus com abas, tier, raridade, 'Mostrar não obtidos' e trilha de progressão, e ranking com as 4 visões. Carregamento, erro com nova tentativa, vazio e paginação são tratados de forma uniforme em todas as telas; todo erro vira mensagem amigável; o tema claro/escuro e os componentes compartilhados dão coerência visual; a acessibilidade é cuidada; há modo de demonstração para a banca. Não chega a 5 por divergências de detalhe da especificação e dos mockups: o perfil não tem bio, 'último troféu', 'seguida por' nem 'Compartilhar', que estão no mockup do próprio repositório; o mural trocou a sanfona com aviso semi-aberto por 'não lido aberto, lido recolhido'; o card do feed não tem campo de comentário; a grade do perfil separa posts, troféus e medalhas em abas; o tema não muda no login.",
  "evidencias": [
    {"local": "apps/mobile/src/autenticacao/LoginScreen.tsx:80-124", "descricao": "Campo único 'RA ou e-mail', validação de vazio, erro de credencial no campo da senha, botão 'Entrando...' desativado e link 'Esqueci minha senha'."},
    {"local": "apps/mobile/src/autenticacao/LoginScreen.tsx:126-137", "descricao": "Texto de primeiro acesso para aluno e professor e botão 'Entrar na demonstração'."},
    {"local": "apps/mobile/src/cadastro/DadosScreen.tsx:19-125", "descricao": "Cadastro em 3 passos com RA, e-mail institucional e senha; para conta existente, oferece 'Esqueci minha senha'."},
    {"local": "apps/mobile/src/feed/FeedScreen.tsx:91-144", "descricao": "Estados de carregando, erro com nova tentativa e vazio, rolagem infinita com erro de paginação e 'puxar para atualizar'."},
    {"local": "apps/mobile/src/feed/CartaoDePost.tsx:106-121", "descricao": "Curtida aparece na hora e é desfeita, com mensagem, se a API falhar."},
    {"local": "apps/mobile/src/feed/CartaoDePost.tsx:240-275", "descricao": "Faixa do prêmio, curtidas, legenda, 'Ver todos os N comentários' e horário; não há campo de comentário no card."},
    {"local": "apps/mobile/src/posts/ComentariosScreen.tsx:167-196", "descricao": "Comentar fica em tela separada, com limite de 500 caracteres e estado de envio."},
    {"local": "apps/mobile/src/components/BottomNav.tsx:18-92", "descricao": "Abas Home, Busca, Mural (centro), Troféus e Perfil (avatar), com bolinha de novidade anunciada ao leitor de tela."},
    {"local": "apps/mobile/src/perfil/PerfilScreen.tsx:361-392", "descricao": "Cabeçalho com pontos, #posição, seguidores e seguindo; os pontos abrem o ranking só no próprio perfil."},
    {"local": "apps/mobile/src/perfil/PerfilScreen.tsx:42-48", "descricao": "Abas Posts, Troféus e Medalhas separadas, em vez da grade mista da especificação."},
    {"local": "design/telas/perfil-claro.png e apps/mobile/src/perfil/PerfilScreen.tsx", "descricao": "O mockup tem bio, 'Último troféu', 'Seguida por' e 'Compartilhar'; o código não tem nenhum desses itens."},
    {"local": "apps/mobile/src/mural/MuralScreen.tsx:31-158", "descricao": "Filtros Todos, Faculdade, Curso e Professores; 'Ler todos' desativado sem pendências e com erro próprio."},
    {"local": "apps/mobile/src/mural/CartaoDeAviso.tsx:16-24", "descricao": "Não lido aberto com bolinha dourada e lido recolhido, no lugar da sanfona com o aviso mais recente semi-aberto pedida na especificação."},
    {"local": "apps/mobile/src/mural/AvisoScreen.tsx:39-54", "descricao": "Abrir o aviso registra a leitura (log de leitura); botão de voltar no topo à esquerda."},
    {"local": "apps/mobile/src/trofeus/TrofeusScreen.tsx:38-151", "descricao": "Abas Troféus/Medalhas, chave 'Mostrar não obtidos' e trilhas de progressão por conquista."},
    {"local": "apps/mobile/src/trofeus/LinhaDePremio.tsx:48-80", "descricao": "Cada linha mostra tier, raridade com %, critério, progresso e pontos; o que falta aparece apagado."},
    {"local": "apps/mobile/src/rankings/api.ts:23-53", "descricao": "Visões Geral, Curso, Histórico e Histórico do curso, filtradas por papel e por ex-aluno."},
    {"local": "apps/mobile/src/rankings/RankingsScreen.tsx:84-164", "descricao": "Botão voltar, chips de visão, card 'Sua posição', filtro 'Quem eu sigo' e textos de vazio próprios."},
    {"local": "apps/mobile/src/api/erros.ts:4-149", "descricao": "Tabela de códigos de erro da API para mensagens em português, com padrão para falta de conexão."},
    {"local": "apps/mobile/src/perfil/MenuDoPerfil.tsx:61", "descricao": "Troca de tema só no menu do Perfil; a tela de login segue o tema do aparelho."}
  ],
  "regras_ausentes": [
    "Bio no perfil",
    "'Último troféu' em destaque no perfil",
    "'Seguida por xxxx e yyyy' no perfil",
    "Grade mista no perfil (fotos, troféus e fotos de troféus na mesma grade)",
    "Mural em sanfona: aviso mais recente semi-aberto, um por vez, e abertura quase em tela cheia",
    "Campo 'adicionar comentário' e comentários visíveis no card do feed",
    "Troca de tema claro/escuro na tela de login",
    "Denúncia de prêmio pelo próprio aluno (só professor e instituição contestam)"
  ],
  "decisoes_do_agente": [
    "Botão 'Entrar na demonstração', com contas prontas e ligado por opção de configuração, para a banca",
    "Cadastro em 3 passos (dados, escolha do arroba, termo de uso)",
    "Texto de orientação no login sobre o primeiro acesso de aluno e de professor",
    "Erro de credencial mostrado no campo da senha e demais erros abaixo do botão",
    "Tabela única que transforma cada código de erro da API em mensagem em português, nunca o erro cru",
    "Curtida que aparece na hora e é desfeita, com mensagem, se a API falhar",
    "'Puxar para atualizar' e rolagem infinita em feed, mural, perfil, ranking e comentários",
    "Feed com recomendações aleatórias para nunca ficar vazio, com ordem nova a cada atualização",
    "Instituição sem curtir e sem comentar: o coração some para esse papel",
    "Mural com não lido aberto e lido recolhido; leitura conta só ao abrir o aviso inteiro; 'Ler todos' vale para o mural inteiro",
    "Filtro 'Professores' do mural mapeado para os avisos de turma",
    "Bolinha de novidade nas abas Mural e Troféus, consultada a cada 60 s",
    "Ranking como tela empilhada, sem aba própria, com filtro 'Quem eu sigo' e card 'Sua posição'",
    "Posição exibida em perfil, feed e Troféus é a do histórico geral",
    "'Mostrar não obtidos' ligado por padrão",
    "Perfil com três abas (Posts, Troféus, Medalhas) e versão própria para o professor (turmas e medalhas concedidas)",
    "Botão 'Conceder medalha' no perfil do aluno para o professor que tem turma com ele",
    "RA exibido na linha de descrição do perfil",
    "Preferência de tema (sistema, claro ou escuro) salva no aparelho e acessível pelo menu do Perfil",
    "Botão 'Enviar' que copia o link do post quando não há folha de compartilhamento"
  ],
  "nao_verificado": [
    "Renderização real das telas e fidelidade pixel a pixel aos PNGs de design/telas (app não executado)",
    "Fluxos de ponta a ponta com a API (login, cadastro, curtir, comentar, ler aviso, ranking)",
    "Se os testes de componente (*.test.tsx) passam",
    "Diferenças entre web e nativo (navegação, folha de compartilhamento, teclado, área segura)",
    "Contraste real dos temas claro e escuro e tempos de carregamento",
    "Mockups originais do autor fora do repositório (LOGIN.png, 'paigna de dashboard.png'); usei só as telas de design/telas"
  ]
}
```
