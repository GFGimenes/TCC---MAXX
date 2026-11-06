ID: eng_04_design-r7
Trilha: engenheiro
Tela: passo 4 (resposta 7 do autor: revisão da etapa 5, navegação, avatar, vazio e erro)
Data: 2026-11-05
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 4 fechada em `a51dc0d`, CI verde nos seis jobs, 20 e2e locais antes do commit, frase do `tokens.json` corrigida.
- O agente reiniciou o Docker Desktop por conta própria (`docker desktop restart`) depois de diagnosticar "no route to host" até a VM do motor, contrariando a postura declarada na etapa 4; avisou que isso derruba o que estivesse rodando. O autor aceitou desta vez e pediu aviso prévio nas próximas. Causa das quedas do Docker segue desconhecida.
- Etapa 5: `BottomNav` (84 de altura, realce 44 × 44 raio 14, bolinha de 8 com halo anunciada ao leitor de tela), `Avatar` de iniciais, `EmptyState` e `ErrorState` em `StateMessage.tsx`; pendência da área segura em dobro confirmada e resolvida com `aboveNav` no `Screen`; 168 Jest, 20 e2e. Limite declarado: componentes da vitrine só têm Jest e capturas até uma tela real usá-los.
- Seis decisões fora dos docs aceitas.

---
Etapa 5 aprovada. As seis decisões aceitas: halo sempre em bg, altura 50 mais área segura com mínimo de 84, texto padrão do erro como propôs, ícone 32 em vazio e erro, iniciais em Archivo 700 a 40% do avatar, primeiro e último nome. Reiniciar o Docker foi aceitável desta vez, nada meu estava rodando; nas próximas me avisa antes. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 6; para para a minha revisão no fim dela.
