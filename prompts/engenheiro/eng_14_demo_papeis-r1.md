ID: eng_14_demo_papeis-r1
Trilha: engenheiro (passo posterior à avaliação, fora do experimento medido)
Tela: passo 14 (resposta 1 do autor: aprovação do plano e das sete perguntas)
Data: 2026-11-11
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Plano do agente: oito etapas (docs; domínio e migração; registros novos; purga; telas de entrada; tela da purga; e2e; PR e implantação), etapas 1 a 4 emendadas, paradas com capturas nas etapas 5 e 6 e na 8.
- Oito invariantes do modelo atual que a mudança quebraria, achadas na leitura antes do plano (check que exige papel de aluno em conta com lote; fábricas só de aluno; 13 colunas de auditoria com Restrict; registro da purga apontando para quem purgou; vínculo de professor; check de contagem de alunos; contagem da tela; token de acesso de 15 min válido depois da purga).
- Recomendações para as quatro perguntas deixadas em aberto: P1 conta encerrada (lápide) para professor e coordenação do lote, mantendo a autoria dos atos em contas do seed; P2 a coordenação pode purgar o próprio lote, com aviso e volta ao login; P3 textos; P4 a tabela de invariantes.
- Três perguntas novas do agente: P5 a correção de e-mail feita por coordenação de demonstração permitiria mandar e-mail do produto a uma pessoa real da rede e tomar a conta de um aluno do seed, e ele propõe restringir ao domínio reservado `.invalid`, apontando que isso abre exceção ao "sem exceção" do autor; P6 limite de taxa único somado entre as três rotas; P7 conferência no ar só de leitura.

---
Plano aprovado, oito etapas, na ordem proposta. Respostas:

P1. Conta encerrada, como você recomendou. Os atos sobre contas do seed ficam com o autor na auditoria; o meu item 5 passa a ler "a purga apaga os alunos do lote e encerra os professores e as coordenações do lote", e vai assim para o produto.md 11.
P2. Aprovado como está: pode purgar o próprio lote, com a marca, o aviso no modal e o "Voltar ao login".
P3. Textos aprovados como estão.
P4. Aprovado; as correções entram nas etapas 2 e 4.
P5. Aceito a exceção, e obrigado por ter perguntado em vez de seguir o "sem exceção" ao pé da letra: correção de e-mail feita por conta de demonstração só para endereço em domínio reservado .invalid. Registra no índice de decisões como exceção única aos poderes da coordenação de demonstração, com o motivo que você deu.
P6. Limite único de 60 por hora por IP, somado entre as três rotas de registro.
P7. Conferência só de leitura, com o nome "Conferência Maxx", nos três papéis.

Pode começar pela etapa 1 e emendar até a 4. Para na 5 com as capturas.
