# Review leigo_pu, eixo 4. Documentação

- Status: ok
- Tentativa: 1
- Commit avaliado: ce76942b7aa1ebb3a016df705972fc32483cf98f (main)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: e8fd4bbc-8bf0-49b8-896f-f58818bba442

Texto do revisor, sem edição:

---
**Nota: 4/5.** Li a rubrica, a especificação, o `README.md`, o `DECISOES.md` e conferi o que eles dizem contra o código (`rules.js`, `config.js`, `index.js`, `services.js`, `render.yaml`, `package.json` e o arquivo de testes).

## Justificativa

O produto tem dois documentos escritos para quem vai continuar o projeto. O `README.md` cobre o que o produto faz, como rodar, como abrir no celular, como publicar, as variáveis de ambiente e um mapa dos arquivos. O `DECISOES.md` lista as decisões com o motivo de cada uma e uma lista numerada do que falta. Os números que conferi batem com o código:

- 7 tipos de medalha e 13 troféus;
- 3 fotos por dia valendo pontos;
- limite de 4 MB por imagem e de 30 medalhas por dia;
- sessão de 7 dias para o acesso da banca;
- 5 testes;
- todas as variáveis de ambiente e seus padrões.

Uma pessoa nova consegue continuar o projeto. Por isso a nota fica em 4.

Não chega a 5 por três motivos:

1. **Não há documento de arquitetura nem de convenções.** Existe só o mapa de pastas (`README.md:146-165`). O modelo de dados e as rotas da API só aparecem no código (`server/schema.sql`, `server/index.js`).
2. **As decisões não seguem um formato de ADR.** Elas trazem o motivo, mas quase nunca as alternativas e as consequências. As exceções são o PWA comparado ao app de loja e o acesso individual da banca comparado a uma conta compartilhada.
3. **A lista "O que ficou faltando" funciona como inventário de lacunas, não como plano de evolução.** Não há prioridade, ordem nem etapas.

Há ainda duas divergências pequenas:

- **Domínio de e-mail.** O documento adota `unimax.edu.br`; a especificação diz `@unimax.com.br`. O agente reconhece que é uma suposição (`DECISOES.md:19`).
- **Duração da sessão comum.** O código usa 30 dias (`server/auth.js:22`), e isso não está documentado.

## Evidências

- `README.md:1-13`: descrição do produto e das telas, em linguagem simples.
- `README.md:19-47`: como rodar localmente, as contas de teste e os códigos de professor e da banca.
- `README.md:50-102`: três formas de abrir no celular (rede local, Cloudflare Tunnel, Render com Neon) e como instalar como app (PWA).
- `README.md:124-142`: tabela de variáveis de ambiente, que bate com `server/config.js:4-20`.
- `README.md:146-165`: mapa de responsabilidades por arquivo e a stack. É a única descrição de arquitetura.
- `DECISOES.md:5-53`: decisões agrupadas por tema, cada uma com motivo. Alternativas aparecem só em `DECISOES.md:8` e `DECISOES.md:25`.
- `DECISOES.md:30-40`: regras de pontos. Batem com `server/rules.js:4-44` (7 medalhas, 13 troféus, 3 fotos por dia) e com `server/services.js:163` (30 medalhas por dia).
- `DECISOES.md:24` e `server/index.js:164`: a sessão da banca de 7 dias está documentada e implementada igual.
- `DECISOES.md:51` e `server/services.js:15`: o limite de 4 MB está documentado e implementado igual.
- `DECISOES.md:55-68`: limitações conhecidas, incluindo o deploy não testado e a falta de escala. É o equivalente mais próximo de um plano de evolução, mas sem prioridades.
- `DECISOES.md:67` e `test/api.test.js:44,54,67,75,134`: o documento diz que há 5 testes, e há 5.
- `server/rules.js:1-2` e `server/config.js:1`: comentários em português explicam onde mexer nas regras e na configuração.
- `render.yaml:1-25`: o arquivo de deploy é comentado e coerente com a opção C do README.
- `server/auth.js:22`: sessão comum de 30 dias, não documentada.
- `server/schema.sql`: o modelo de dados não é descrito em nenhum documento.

## Regras da ideia ausentes no produto (não penalizadas)

- Login por RA. Só existe e-mail, e o RA não é pedido no cadastro.
- "Esqueci minha senha". A falta está declarada em `DECISOES.md:58`.
- Vínculo da conta pelo portal da instituição.
- Ex-aluno que mantém acesso e posição, mas não pontua mais.
- Tier Diamante e as faixas de pontos por tier (Bronze 1-30, Prata 31-70, Ouro 71-100, Diamante 101-150). Os pontos não seguem o tier: por exemplo, o troféu Lenda é Ouro e vale 200, e Lente de ouro vale 120.
- Tier aplicado às medalhas.
- Nível de "encontrabilidade" dos prêmios.
- Progressão da mesma conquista repetida, subindo de tier até o Diamante.
- Troféus por assiduidade, techdays e feiras, e o cadastro de troféus e medalhas pelo corpo da faculdade (as regras estão fixas no código).
- Prova por foto e denúncia de prêmios. A denúncia está declarada ausente em `DECISOES.md:61`.
- Professor só dar medalha a alunos que leciona ou orienta.
- Troféus valendo mais que medalhas como regra.
- Seguidores e seguindo no perfil.
- Ranking "do curso global".
- Notificações. A falta está declarada em `DECISOES.md:60`.
- Busca geral para alunos. A falta está declarada em `DECISOES.md:64`.
- Compartilhar post.
- Categorias Faculdade, Curso e Professores no mural, o comportamento de colapso e a marca de não lido.
- Registro de quem leu cada aviso e quando.

## Decisões do agente neste eixo (tomadas sem o prompt pedir)

- Criar um `DECISOES.md` separado que registra o que foi decidido sem consultar o usuário e o que ficou faltando.
- Escrever o README para leigos, com passos de instalação do Node e de abrir o terminal no Windows.
- Documentar três caminhos para publicar e abrir no celular, com destaque para o "dia da banca".
- Incluir um roteiro sugerido de demonstração para a banca, além da dica de usar QR code.
- Documentar contas e senhas de teste e os códigos de professor e da banca no próprio README.
- Documentar as variáveis de ambiente numa tabela com os valores padrão.
- Incluir uma seção "Para quem for mexer no código" com o mapa de arquivos.
- Declarar abertamente o que não foi testado: deploy real no Render/Neon e aparelhos iPhone ou Android de verdade.
- Comentar o código e o `render.yaml` em português, apontando o `rules.js` como o único lugar para mudar regras.
- Declarar as limitações de escala e os próximos passos técnicos (cache do ranking, guardar as fotos fora do banco em S3 ou R2).

## O que não pude verificar (só leitura)

- Se o passo a passo do README funciona de fato (`npm install`, `npm start`, o túnel da Cloudflare, o Blueprint do Render com o Neon).
- Se os 5 testes passam.
- A contagem exata de alunos e professores criados nos dados de exemplo (12 e 3, segundo o README); vi só parte do `seed.js`.
- Se as telas correspondem ao que o README descreve.
- Se o histórico de commits mostra a documentação sendo atualizada ao longo do trabalho; não li o `.git`.

```json
{
  "nota": 4,
  "justificativa": "Há documentação de produto, execução, deploy, configuração e decisões: README.md com descrição, passos para rodar e publicar, variáveis de ambiente e mapa de arquivos; DECISOES.md com cada decisão e o motivo, mais uma lista do que falta. Os números conferidos batem com o código (7 medalhas e 13 troféus em rules.js, 3 fotos por dia, 4 MB, 30 medalhas por dia, sessão da banca de 7 dias, 5 testes, variáveis em config.js). Uma pessoa nova consegue continuar. Não é 5 porque não há documento de arquitetura, modelo de dados ou convenções além do mapa de pastas; as decisões não seguem formato ADR e quase nunca trazem alternativas e consequências; a lista de limitações não é um plano de evolução com prioridades. Divergências menores: domínio de e-mail diferente da especificação (assumido e declarado) e sessão comum de 30 dias não documentada.",
  "evidencias": [
    {"local": "README.md:1-13", "descricao": "Descrição do produto e das telas em linguagem simples."},
    {"local": "README.md:19-47", "descricao": "Como rodar localmente, contas de teste e códigos de professor e banca."},
    {"local": "README.md:50-102", "descricao": "Três formas de abrir no celular (rede local, Cloudflare Tunnel, Render+Neon) e instalação como PWA."},
    {"local": "README.md:124-142", "descricao": "Tabela de variáveis de ambiente coerente com server/config.js:4-20."},
    {"local": "README.md:146-165", "descricao": "Mapa de responsabilidades por arquivo e stack; única descrição de arquitetura."},
    {"local": "DECISOES.md:5-53", "descricao": "Decisões por tema com motivo; alternativas só em DECISOES.md:8 (PWA x loja) e DECISOES.md:25 (contas individuais da banca x conta compartilhada)."},
    {"local": "DECISOES.md:30-40", "descricao": "Regras de pontos coerentes com server/rules.js:4-44 e server/services.js:163."},
    {"local": "DECISOES.md:24", "descricao": "Sessão da banca de 7 dias, coerente com server/index.js:164."},
    {"local": "DECISOES.md:51", "descricao": "Limite de 4 MB por imagem, coerente com server/services.js:15."},
    {"local": "DECISOES.md:55-68", "descricao": "Limitações conhecidas (deploy não testado, falta de escala, LGPD); serve como lista de lacunas, sem prioridades nem plano."},
    {"local": "DECISOES.md:67", "descricao": "Diz que há 5 testes; test/api.test.js:44,54,67,75,134 tem exatamente 5."},
    {"local": "server/rules.js:1-2", "descricao": "Comentário em português indicando onde mudar as regras do jogo."},
    {"local": "render.yaml:1-25", "descricao": "Arquivo de deploy comentado e coerente com a opção C do README."},
    {"local": "server/auth.js:22", "descricao": "Sessão comum de 30 dias, não documentada."},
    {"local": "server/schema.sql", "descricao": "Modelo de dados não descrito em nenhum documento."}
  ],
  "regras_ausentes": [
    "Login por RA (só e-mail; RA não é pedido no cadastro)",
    "Esqueci minha senha (falta declarada em DECISOES.md:58)",
    "Vínculo da conta pelo portal da instituição",
    "Ex-aluno que mantém acesso e posição, mas não pontua mais",
    "Tier Diamante e faixas de pontos por tier (Bronze 1-30, Prata 31-70, Ouro 71-100, Diamante 101-150)",
    "Tier aplicado às medalhas",
    "Nível de encontrabilidade dos prêmios",
    "Progressão da mesma conquista repetida subindo de tier até o Diamante",
    "Troféus por assiduidade, techdays e feiras, e cadastro de troféus e medalhas pelo corpo da faculdade",
    "Prova por foto e denúncia de prêmios",
    "Professor só dar medalha a alunos que leciona ou orienta",
    "Troféus valendo mais que medalhas como regra",
    "Seguidores e seguindo no perfil",
    "Ranking do curso global",
    "Notificações",
    "Busca geral para alunos",
    "Compartilhar post",
    "Categorias Faculdade, Curso e Professores no mural, colapso dos avisos e marca de não lido",
    "Registro de quem leu cada aviso e quando"
  ],
  "decisoes_do_agente": [
    "Criar um DECISOES.md separado registrando o que foi decidido sem consultar o usuário e o que ficou faltando",
    "Escrever o README para leigos, com passos de instalação do Node e de abrir o terminal no Windows",
    "Documentar três caminhos para publicar e abrir no celular, com destaque para o dia da banca",
    "Incluir um roteiro sugerido de demonstração para a banca e a dica de usar QR code",
    "Documentar contas e senhas de teste e os códigos de professor e da banca no README",
    "Documentar as variáveis de ambiente numa tabela com os valores padrão",
    "Incluir a seção 'Para quem for mexer no código' com o mapa de arquivos",
    "Declarar abertamente o que não foi testado (deploy real no Render/Neon e aparelhos iPhone ou Android de verdade)",
    "Comentar o código e o render.yaml em português, apontando o rules.js como único lugar para mudar regras",
    "Declarar as limitações de escala e os próximos passos técnicos (cache do ranking, fotos em S3 ou R2)"
  ],
  "nao_verificado": [
    "Se o passo a passo do README funciona (npm install, npm start, túnel da Cloudflare, Blueprint do Render com o Neon)",
    "Se os 5 testes passam",
    "Contagem exata de alunos e professores criados nos dados de exemplo (12 e 3, segundo o README); seed.js lido só em parte",
    "Se as telas correspondem ao que o README descreve",
    "Se o histórico de commits mostra a documentação sendo atualizada ao longo do trabalho (.git não lido)"
  ]
}
```
