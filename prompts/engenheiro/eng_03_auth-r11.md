ID: eng_03_auth-r11
Trilha: engenheiro
Tela: passo 3 (resposta 11 do autor: revisão da E10, modo de demonstração atrás de flag)
Data: 2026-11-04
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E9 commitada em `6ff97f4`.
- E10: `GET /api/v1/demo`, `POST /demo/alunos`, `POST /demo/entrar`, só mapeadas com a flag ligada (404 idêntico ao de rota inexistente, comparado em status, tipo e corpo); teste que lê todo `appsettings*.json` e o `docker-compose.yml` e falha se aparecer `Demo`; migration `Demonstracao` (flag no cadastro, lote no usuário, chave de dispositivo em SHA-256 com índice único, check exigindo lote e chave, papel aluno e sem senha); `docker-compose.demo.yml` liga a flag; 442 testes, 17 novos; fumaça pelo Caddy com registro, volta pela chave e purga por lote.
- Três desvios aceitos (`SugestaoDeArroba` e `SemestreVigente` extraídos para uso compartilhado; arquivo de compose da demonstração). Sete decisões aceitas. Purga por lote registrada como procedimento no fechamento.

---
E10 aprovada. Os três desvios ficam. As sete decisões aceitas: rotas não mapeadas com a flag desligada, flag só pelo docker-compose.demo.yml, lote obrigatório, curso pela sigla entre os vigentes, RA DEMO e e-mail em demonstracao.invalid, sem senha e sem recuperação, chave sempre no corpo. Registra a purga por lote como procedimento no fechamento, junto com as decisões. Commita com a mensagem proposta, push, e segue para a E11; para para a minha revisão no fim dela.
