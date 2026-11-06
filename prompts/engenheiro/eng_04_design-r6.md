ID: eng_04_design-r6
Trilha: engenheiro
Tela: passo 4 (resposta 6 do autor: revisão da etapa 4, controles)
Data: 2026-11-05
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 4: `Button` (discreto 32 com 44 de toque, grande 50, primário e secundário), `TextField` (48, borda 1,5 em foco, mostrar senha), `SegmentedControl` (substitui o controle provisório de tema, sombra só no ativo do claro), `FilterChip` (raio 8); estados pressionado (opacidade 0,85), desativado (surface2 e ink3) e foco por teclado (anel do token com 2 px); 144 Jest; 8 e2e novos contra o build de produção num servidor provisório.
- Ambiente: o Docker Desktop parou de responder durante a etapa (erro 500 do motor), terceira queda do Docker na trilha; o agente não reiniciou por ser aplicativo do autor e declarou que 12 e2e não rodaram. Jest caiu duas vezes por falta de memória, sem causa conhecida. O autor reiniciou o Docker antes de responder e pediu o e2e completo antes do commit.
- Dois problemas achados por captura: contorno padrão do navegador por cima do anel de foco (corrigido com `outline-style: none`, agora coberto pelo e2e); limite declarado de não testar a volta da opacidade ao soltar.
- Sete decisões fora dos docs aceitas; a do chip inativo em contorno corrige a frase do `tokens.json`. Erro de campo fica para o passo 5.

---
Docker reiniciado; roda o e2e completo antes do commit. As sete decisões aceitas: chip inativo em contorno e corrige a frase do tokens.json; chip com 32 e 44 de toque; borda de 1 px no trilho do segmentado; botão grande em Instrument Sans 700 tamanho 15; campo em 16 por causa do zoom do Safari; rótulo 14 peso 600; segmento ativo desativado mantém segmentOn sem sombra. O outline-style: none e o Button no "Tentar de novo" ficam. Erro de campo entra no passo 5 junto com o login. Com os 20 e2e verdes, commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 5; para para a minha revisão no fim dela.
