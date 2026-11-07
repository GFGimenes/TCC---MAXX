ID: eng_05_login-r6
Trilha: engenheiro
Tela: passo 5 (resposta 6 do autor: revisão da etapa 5, cadastro em três passos com arroba e termo)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor olhou as capturas; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 4 fechada em `0159ab3`, CI verde.
- Etapa 5: rotas `/cadastro`, `/cadastro/arroba`, `/cadastro/termo` com os dados só em memória (recarregar volta ao passo 1); validações no campo sem ir à API; sugestão pedida ao avançar; disponibilidade com debounce de 500 ms e cancelamento; 429 ou falta de rede na consulta não travam; termo vindo da API com reaceite se a versão mudar; `FalhaDaApi`, `TextoDoTermo`, `useTermoDeUso`, `renderComApi`; ícone `check` do Lucide; 269 Jest (19 novos, dois com relógio falso), 43 e2e. Dois problemas de teste resolvidos: asserções antes da resposta simulada (findBy) e temporizador de coleta de cache do TanStack Query segurando o Jest (explicava a lentidão).
- Passo 1 bate com a prancheta; passos 2 e 3 sem prancheta, pela identidade. Linhas de teste ficam no banco local, declarado.

---
Etapa 5 aprovada. Os passos 2 e 3 sem prancheta ficam como estão. O check do Lucide no Icon e o desligamento da coleta de cache no cliente de teste ficam. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 6; para para a minha revisão no fim dela.
