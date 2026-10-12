ID: eng_00_produto-r1
Trilha: engenheiro
Tela: abertura (resposta 1 do autor aos bloqueadores, lacunas e contradições apontados pelo agente depois do `eng_00_produto`; mesma sessão, antes do `eng_00_tecnica`)
Data: 2026-10-12
Origem: decisões do autor, debatidas item a item com o Cowork (Anthropic) em 11 e 12/10/2026 e redigidas pelo Cowork a partir das palavras do autor; o autor revisou e trocou o fecho. A sessão foi interrompida por reinício do computador em 11/10 e retomada em 12/10 com `claude --resume`, sem perda.

Notas de registro:
- O agente respondeu ao `eng_00_produto` sem código, com 8 bloqueadores, cerca de 40 lacunas em 10 áreas e 4 contradições. Nenhum dos 8 bloqueadores tinha resposta na referência do autor (`docs/contexto-comum.md`); as regras abaixo nasceram aqui.
- Mudanças de produto decididas nesta resposta: três tipos de prêmio (medalhas, prêmios de participação, conquistas) no lugar da progressão por tier; valor fixo por item do catálogo; conquistas por período próprio; janela de contestação de 15 dias; aprovação de quem chega primeiro, decisão de contestação sempre da instituição; área web mínima da instituição; comentários nos posts; ex-aluno não posta; e-mail institucional `@al.unieduk.com.br`.
- O fecho pede que o agente não assuma nada e proponha para revisão: as decisões passam a ser explicitamente do autor ou explicitamente propostas pelo agente (ambas contadas na tabela de custo de entrada).

---
Respostas aos bloqueadores.

1. Fonte da verdade acadêmica: a faculdade abastece a base com os RAs e o curso de cada aluno; aluno novo é inserção na base. O cadastro no app é feito com e-mail institucional, RA (que a faculdade fornece ao aluno) e o nome que ele quer exibir; e-mail + RA fazem o vínculo com o curso. Professores são cadastrados a cada semestre por matéria e turma, como já acontece no app de chamada da UniMax. Na fase 1 tudo isso entra por seed; quando for para uso real, por CSV. Sem integração com o sistema acadêmico agora.

2. Pontos: valor fixo, definido no catálogo, dentro da faixa do tier. Exemplos: medalha Bronze por pontualidade, 20; medalha Bronze por uma nota 10 em prova no semestre, 30; prêmio Bronze por palestra obrigatória, 10; prêmio Bronze por experimento opcional, 20; prêmio Prata por três palestras no semestre, 50. Quem concede escolhe o item do catálogo; ninguém digita valor nem tier.

3. Progressão: substituo a regra de "um tier acima" por três tipos de prêmio. Medalhas: dadas por professor, por nota e presença (fatos que o sistema da UniMax já registra); valor fixo; não são revogadas. Prêmios de participação: eventos, palestras, atividades opcionais, que o sistema da UniMax não registra; exigem comprovação por foto; são os únicos contestáveis e revogáveis. Conquistas: automáticas, por acúmulo dentro do período da própria conquista (bimestre, semestre, ano ou curso). Exemplos: "três notas 10 em provas no bimestre" dá uma conquista Prata de 40 pontos, somando com as três medalhas de 10 (70 no total); "nota 10 em todas as matérias do bimestre" dá uma conquista Diamante baixo; "cinco notas 10 em provas no semestre" conta todas as medalhas do semestre, de qualquer bimestre (duas no bimestre 1 e uma no bimestre 2 são três de cinco). A contagem nunca atravessa o período da conquista: as mesmas duas e uma não fecham a conquista "três no bimestre". Tudo soma. Conquistas contam medalhas e também prêmios de participação, mas o prêmio só entra na contagem depois de ficar definitivo (ver contestação), e por isso conquista nunca é revogada.

4. Estados: aluno envia a comprovação; instituição ou professor da turma aprova, e quem aprovar primeiro vale. Enquanto não aprovado, o prêmio não conta. Comprovação reprovada: o aluno pode reenviar outra foto. Depois de aprovado, só existe contestação (professor da turma ou instituição, com motivo); o prêmio vai para "em averiguação", para de pontuar, e a instituição decide: confirma ou revoga. Não há conflito: aprovação é de quem chega primeiro, decisão de contestação é sempre da instituição.

5. Assiduidade e eventos: a UniMax já tem o sistema de presença (chamada); a integração fica para depois. Na fase 1, regra automática que só conta o que está no Maxx (as conquistas) é calculada pelo sistema; o que depende de presença ou evento entra semeado ou é concedido à mão pela instituição. A demo tem prêmios pré-feitos no seed.

6. Telas: as seis do design são a visão do aluno. Professor usa as mesmas telas com acréscimos: no mural, botão de publicar aviso; no perfil do aluno das turmas dele, um ícone de medalha com "+" que abre um modal para escolher a medalha do catálogo. Instituição tem uma área web pequena, só no navegador: fila de comprovações e contestações (aprovar, revogar), conceder prêmio a um aluno e publicar aviso. Catálogo de prêmios, cursos, turmas e calendário entram por seed; sem tela de cadastro na fase 1. Na banca, quem concede ao vivo sou eu, logado como professor ou na área web.

7. Semestre: dois semestres por ano letivo, cada um com dois bimestres (descontados férias e recesso). Cada semestre tem data de início e fim (seed na fase 1), e é isso que corta o ranking. O prêmio conta no semestre em que foi concedido. Na virada, o ranking do semestre começa do zero e o histórico acumula. Os bimestres importam para as regras de conquista.

8. Feed: quem o aluno segue aparece sempre, mais recomendações aleatórias de outros alunos; aluno novo (e a banca) vê recomendações desde o primeiro acesso. Seguir é livre, sem aprovação.

Lacunas.

Autenticação: contas de instituição vêm do seed (depois CSV). Domínio aceito: o institucional da UniMax, sempre @al.unieduk.com.br. Senha própria com recuperação por e-mail; verificação de e-mail no cadastro fica para a fase 2. Uma pessoa pode ter mais de um papel. Ex-aluno é marcado pela instituição; continua entrando, seguindo e lendo, mas não posta, não recebe prêmio e não pontua.

Posts: foto opcional. O post normalmente é sobre um prêmio ou medalha: ao ganhar, o aluno pode postar só o prêmio ou o prêmio com foto, como está no design; e o "claim" de um prêmio de participação é um post com foto que serve de comprovação. Legenda opcional. Curtidas e comentários nos posts, sim; o que não existe é mensagem direta entre usuários. Post de comprovação é público desde o envio, com marca "pendente" até aprovar. Instituição remove post impróprio; denúncia fica para depois. Post não gera ponto.

Visibilidade: perfil, prêmios e posição são públicos para qualquer usuário logado. "Em averiguação" aparece para o aluno e para a instituição; para os demais o prêmio não aparece até resolver. Prêmio revogado e motivo: só aluno e instituição. Ninguém sai do ranking.

Contestação: janela de 15 dias depois da aprovação do prêmio de participação; dentro dela, professor da turma ou instituição contesta com motivo e a instituição decide. Passada a janela sem contestação, o prêmio é definitivo: não pode mais ser contestado e passa a contar para conquistas. Medalhas e conquistas não se revogam.

Medalhas: sem cota, porque cada medalha corresponde a um fato registrado (nota, presença). Só nas turmas do semestre vigente.

Avisos: escopos faculdade, curso e turma. Texto com uma imagem opcional; sem fixação nem expiração na fase 1. Geram notificação. Somente leitura.

Rankings: desempate por quem atingiu a pontuação primeiro. Mostra o topo e a posição do próprio aluno. Ex-aluno só no histórico. Aluno que troca de curso leva os pontos para o ranking do curso novo.

Catálogo: medalhas e prêmios ainda não obtidos aparecem com o critério; conquistas aparecem com progresso ("2 de 3"). Sem prêmio secreto. Catálogo global, com itens marcados por curso quando for o caso. Vigência por período.

Demo: botão visível na tela de login só com a flag ligada. Lembrança local, some se trocar de aparelho. Aluno demo aparece nos rankings da demo. Fase 1 é só seed, sem conta real. Expurgo manual.

Geral: notificações existem (medalha, aprovação, contestação, aviso), mostradas no sininho; a próxima mensagem detalha. Só pt-BR.

Contradições.

Sem mensagens: motivo de contestação e parecer são registro no próprio prêmio mais notificação; não existe caixa de entrada. Demo: a flag é o item mais sensível, desligada por padrão e sem rota de demo sem ela; a próxima mensagem cobre. Conflito professor e instituição: resolvido no item 4. Instituição: um papel só na fase 1; coordenação e secretaria viram sub-papéis depois, se precisar.

O que não respondi aqui, posso te mandar na proxima mensagem, mas se lembre de não assumir coisas, se tiver alguma sugestão sempre me envie para eu revisar. A próxima mensagem é a parte técnica e onde está o design.
