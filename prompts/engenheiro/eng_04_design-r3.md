ID: eng_04_design-r3
Trilha: engenheiro
Tela: passo 4 (resposta 3 do autor: CI vermelha da etapa 1 por defeito do passo 3, correção em PR separado; revisão da etapa 2, fontes)
Data: 2026-11-05
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor (traço da correção proposto pelo Cowork, aprovado); redigida pelo Cowork, o autor revisou.

Notas de registro:
- Primeira aplicação da regra da CI verde por etapa: a CI do commit da etapa 1 (`858a532`) caiu no job api (449 de 450). O agente não reexecutou, investigou e mostrou defeito intermitente do passo 3: `DemonstracaoTests.Mesmo_nome_registrado_ao_mesmo_tempo_ganha_arrobas_diferentes`, 500 por `ConflitoDeUnicidadeException` em `pk_prefixo_reservado`; o handler tenta 3 vezes e com 4 simultâneos o último pode precisar de 4. Já falhava na `main` (`5b7cb45`) e passou em `46e5bd5`. Defeito real que atingiria a banca (duas pessoas com o mesmo nome entrando juntas).
- Três opções oferecidas (PR separado; commit na branch de design; reexecutar até passar, que o próprio agente desaconselhou). Autor: PR separado `fix/demonstracao-registro-simultaneo` com traço fixado (avançar para a próxima sugestão livre consultando os reservados, até 10 tentativas, 409 amigável se esgotar, teste de oito simultâneos e teste de esgotamento).
- Etapa 2: `design/fontes/` com `gerar.sh` e `instanciar.py` em contêiner (fontTools, commits do Google Fonts travados, hash conferido, geração reprodutível), 7 TTFs (644 KB) com licenças OFL, `fonts.ts` com uma família por peso, `FontGate`; 91 Jest, 12 e2e; sem fvar e com tnum conferidos por leitor de TTF; sem CDN; 112% medido no navegador. Ressalvas declaradas: Archivo "unloaded" até o primeiro uso; nativo não testado; `npm ci` falhou uma vez sem log.

---
Etapa 1 continua aberta, correto não reexecutar. Opção 1: PR fix/demonstracao-registro-simultaneo saindo da rodada/eng_04_design e voltando para ela, assunto único. Traço: em conflito de prefixo o registro não repete a mesma sugestão, avança para a próxima sugestão livre consultando os prefixos já reservados; até 10 tentativas; esgotadas, responde 409 com código amigável, nunca 500; o teste dos quatro simultâneos passa a ser de oito, e entra um teste que esgota as tentativas e confere o 409. Abre o PR, eu reviso e mergeio na rodada, você traz a rodada para a feat/passo-04-design-system e a CI da etapa 1 roda de novo.

Etapa 2 aprovada: as três ressalvas ficam registradas (Archivo "unloaded" até o primeiro uso, a conferir na vitrine; nativo não testado; npm ci intermitente sem log). Commita com a mensagem proposta e push, e a CI dela roda depois do merge da correção, junto com a da etapa 1. Me traz os dois resultados por job com a etapa 3.
