ID: eng_05_login-r8
Trilha: engenheiro
Tela: passo 5 (resposta 8 do autor: revisão da etapa 7, entrada da demonstração; liberação do fechamento)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor olhou as capturas; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 6 fechada em `9f7f1b1`, CI verde.
- Etapa 7: botão "Entrar na demonstração" condicionado à resposta 200 de `GET /api/v1/demo` (sem flag no bundle); `/demonstracao` com lista de contas lembradas no aparelho, criação com nome, curso (FilterChip com papel radio) e termo; chave guardada antes de entrar; mensagens para `registro-simultaneo` (pendência do passo 4), `chave-invalida`, `curso-indisponivel`, `termo-desatualizado`; CI do e2e em duas passadas (produção e `docker-compose.demo.yml` com lote descartável); 292 Jest (10 novos), 59 e2e com flag desligada e 4 com flag ligada. Autor mandou purgar os alunos de demonstração do banco local com o SQL do README, registrando a contagem.
- Etapa 8 (fechamento) liberada com a lista do que registrar e o PR com as oito etapas e os dois fixes.

---
Etapa 7 aprovada. Apaga os alunos de demonstração do banco local com o SQL da purga do README e registra a contagem apagada. Commita com a mensagem proposta, push, acompanha a CI com as duas passadas e segue para a etapa 8, o fechamento: decisões do passo no README das decisões, fluxos e apps/mobile/README.md, ajustes em produto.md 11, identidade visual e lista da purga, riscos registrados incluindo a avaliação antes de 05/12 sem apresentação presencial, e o PR da feat/passo-05-login para a rodada/eng_05_login com a descrição listando as oito etapas e os dois fixes. Eu reviso e faço o merge.
