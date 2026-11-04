ID: eng_03_auth-r4
Trilha: engenheiro
Tela: passo 3 (resposta 4 do autor: revisão da E3, família de sessão e recuperação de senha no domínio)
Data: 2026-11-03
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E3 com TDD e TimeProvider falso: `FamiliaDeSessao` (abrir, rotacionar com detecção de reuso revogando a família, revogar com motivo), `RecuperacaoDeSenha` (30 minutos, uso único, conclusão revoga todas as famílias; primeiro acesso do seed usa o mesmo caminho); 226 testes de domínio, 20 novos.
- Quatro pontos: o autor aceitou a recomendação de invalidar os outros pedidos de reset pendentes na conclusão (o agente não implementou por não estar decidido); reuso estrito sem janela (cliente serializa a renovação no passo 5); refresh expirado só recusa; concorrência de rotação fica para a E4 e é testada na E7.

---
E3 aprovada. 1: invalida os outros pedidos de reset pendentes na conclusão, com teste, e registra no fluxo 06. 2, 3 e 4 ficam como você descreveu: reuso estrito com a serialização no cliente no passo 5, expirado só recusa, concorrência na E4 e testada na E7. Commita com a mensagem proposta, push, e segue para a E4; para para a minha revisão no fim dela.
