ID: eng_04_design-r4
Trilha: engenheiro
Tela: passo 4 (resposta 4 do autor: merge do PR #5 de correção, ajuste do teste de fontes, revisão da etapa 3, base e vitrine)
Data: 2026-11-05
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- PR #5 `fix/demonstracao-registro-simultaneo` → `rodada/eng_04_design`, um commit, CI verde; causa confirmada (3 de 3 falhas com oito simultâneos antes, 5 de 5 passando depois); segue o traço da `r3`; código `registro-simultaneo` (o agente explicou que `prefixo-indisponivel` já tem outro sentido); limite real de 10 pedidos simultâneos com o mesmo nome declarado. Mergeado pelo autor no GitHub antes desta resposta.
- CI da etapa 2 rodou antes do merge (a CI dispara em todo push) e caiu no e2e por um teste do próprio agente: tolerância de 1 px na medida dos quatro "M" (412 no Linux da CI por arredondamento). Ajuste para 2 px aprovado como commit próprio da etapa 2, dentro da regra de correção de CI por commit separado.
- Etapa 3: `react-native-svg` 15.16.0, `Icon` com 15 ícones do Lucide 1.70.0 (traço 1.8, grade 24, contorno e preenchido, `detailColor` para o recorte interno, `taca` e `fita` pelo glossário), `Screen` com margem 16, respiro 24 e área segura, `/vitrine` só em `__DEV__` (e2e confirma que não vai para o bundle de produção); 118 Jest, 16 e2e. Ressalva da Archivo "unloaded" verificada na vitrine: sem troca visível de fonte.

---
PR #5 mergeado na rodada. O código registro-simultaneo e o limite de 10 ficam, registra o limite nos docs no fechamento. Ajuste do teste de fontes aprovado como commit próprio, com a mensagem proposta; é correção de CI depois de revisão, dentro da regra do passo 3. Etapa 3 aprovada: detailColor, o medal como fita, alert e inbox, área segura a conferir na etapa 5, ApiStatusScreen fora do Screen. Segue a ordem que propôs: sobe o ajuste, traz a rodada para a feat, me traz o resultado por job das etapas 1, 2 e 3, e para antes da etapa 4.
