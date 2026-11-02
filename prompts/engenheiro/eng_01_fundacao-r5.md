ID: eng_01_fundacao-r5
Trilha: engenheiro
Tela: passo 1 (resposta 5 do autor: revisão da etapa 4, app Expo com tela de estado da API e moldura de celular)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisões do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Entrega: app Expo SDK 58 com Expo Router em `apps/mobile/src/app/`, saída web single, tema claro e escuro automático a partir de `design/tokens.json`, logo lida direto de `design/assets/maxx-ouro.png`, hook `useHealth` sobre `@maxx/api-client` com TanStack Query, mensagens amigáveis com "Tentar de novo", moldura de 390 px a partir de 600 px de janela com teto de 844 px e borda de 1 px nos quatro lados; 7 testes Jest; lint, typecheck e Prettier limpos; `expo export -p web` com 1,3 MB.
- O agente removeu do template do Expo o `AGENTS.md` (instruções para agentes concorrendo com o `CLAUDE.md`), a LICENSE MIT, um `.claude/settings.json` que ligava um plugin, `App.tsx` e `index.ts`. Um `rm -rf` foi bloqueado pela proteção do Claude Code e refeito arquivo por arquivo; declarado pelo próprio agente.
- Três decisões do autor: proxy de `/api` no Metro só em desenvolvimento (mantém a origem única da ADR 0001 sem CORS); moldura só na web, tablet nativo em tela inteira; ícones e splash reais no passo 4, junto com o design system, como item explícito do plano.
- Registrados: 46 achados moderados e 1 baixo do `npm audit` em ferramentas de build e teste, abaixo do corte do job de segurança.

---
Etapa 4 aprovada. Pode commitar com a mensagem proposta e dar push.

Sobre as decisões:

1. Proxy de /api no Metro, só em desenvolvimento. Mantém a origem única sem ligar CORS, e o compose com Caddy continua sendo o caminho de produção na etapa 5. Deixa claro no código ou no README do apps/mobile que o proxy é só dev e não existe no build exportado.

2. Moldura só na web, como você leu. Tablet nativo usa a tela inteira.

3. Ícones e splash reais entram no passo 4, junto com o design system. Registra isso como item explícito no plano do passo 4 para não se perder, e por enquanto os PNGs padrão do Expo ficam.

Registrado: os 46 moderados e 1 baixo do npm audit em ferramentas de build e teste, abaixo do corte do job de segurança, e a borda de 1 px nos quatro lados da moldura.

Segue para a etapa 5 e para na revisão.
