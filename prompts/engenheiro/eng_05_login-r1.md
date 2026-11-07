ID: eng_05_login-r1
Trilha: engenheiro
Tela: passo 5 (resposta 1 do autor: aprovação do plano de oito etapas e oito decisões pedidas pelo agente)
Data: 2026-11-06
Origem: leitura do Cowork (Anthropic) do export da sessão; decisões do autor (sete pela recomendação, a sétima pela alternativa, por sugestão do Cowork); redigida pelo Cowork, o autor revisou.

Notas de registro:
- Ambiente: Claude Code 2.1.316, `/model` manteve Opus 5.5 (medium). O CLI avisou "Your login expires in 1 day"; o autor renovou com `/login` antes da etapa 1.
- O agente leu docs, pranchetas e código dos passos 3 e 4 e levantou sete achados antes do plano: termo de uso inexistente na API (precisa de migration); prancheta de cadastro sem nome e arroba; texto "Portal UniMax" contradizendo o produto; serialização do refresh em memória insuficiente na web (duas abas; `navigator.locks`); massa do e2e consumindo linhas do cadastro elegível; token `like` só em ícone; specs antigos dependentes da rota `/`.
- Oito etapas: termo na API; sessão e refresh serializado; peças da autenticação; login e portão de rotas; cadastro em três telas; recuperação de senha; entrada da demonstração; fechamento. Quatro riscos declarados: resposta perdida no refresh sem janela de tolerância (vai para o ensaio do passo 13); limites de taxa no e2e; calendário sem semestre vigente em dezembro; nativo só com Jest.
- Decisão de contexto do autor registrada aqui: não haverá apresentação presencial e a avaliação acontece antes de 05/12/2026, dentro do semestre vigente do calendário declarado; o ensaio do passo 13 passa a ser de demonstração, não de sala.

---
Plano do passo 5 aprovado, oito etapas, um PR da feat/passo-05-login para a rodada/eng_05_login. Decisões 1 a 6 e 8 pela sua recomendação: três telas de cadastro com a conta nascendo na última; texto do primeiro acesso sem link no lugar do Portal UniMax; você redige a v1 do termo a partir do produto.md e eu aprovo, arquivo em data/termos/, seed base, servido pela API; aceitam cadastro e registro da demonstração, professor e instituição não, sem novo aceite na fase 1; versaoDoTermo obrigatório como exceção registrada; início provisório com arroba, tema e Sair, status em /status; botão grande na ação principal das telas de autenticação, com a identidade corrigida. Na 7, a alternativa: borda em like no campo com erro, além do ícone e do texto, registrada como exceção à regra do like só em ícone. Sobre o calendário: a avaliação acontece antes de 05/12 e não há apresentação presencial, então o semestre vigente cobre; registra isso no risco. Os outros três riscos ficam registrados. Começa pela etapa 1 e para para a minha revisão no fim dela, com o texto do termo para eu aprovar.
