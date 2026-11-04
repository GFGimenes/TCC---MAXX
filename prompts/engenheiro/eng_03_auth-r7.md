ID: eng_03_auth-r7
Trilha: engenheiro
Tela: passo 3 (resposta 7 do autor: revisão da E6, cadastro do aluno com sugestão de arroba)
Data: 2026-11-03
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- E6: `POST /api/v1/auth/cadastro/sugestao`, `/disponibilidade` e `/cadastro` (RA e e-mail sempre no corpo); recusas com `codigo` (404 idêntico para par trocado, RA inexistente e linha de professor; 409 conta-existente e prefixo-indisponivel; 400 por regra); corridas provadas; sessão em cookie `maxx_refresh` na web (cabeçalho `X-Maxx-Cliente: web`) e no corpo no nativo; `CadastroHandler`, `SessaoService`, repositórios e `IUnitOfWork` na Application, EF na Infrastructure. 381 testes, 21 novos; fumaça pelo Caddy com o seed demo (`@anaSouza-CC`).
- Interrupção externa: a janela do CLI foi fechada sem querer depois do export da E6 e antes de o autor colar esta resposta. Retomada com `claude --resume` na mesma sessão, mesmas variáveis. Ao reabrir, o CLI mostrou "Compacted while idle, before the prompt cache expired": compactação automática do contexto feita pela ferramenta enquanto a sessão estava parada; declarada aqui e no registro da rodada. A tela mostrou esforço `medium`.
- Desvio declarado e aceito: escrita da sessão antecipada da E7. Quatro decisões aceitas; registro das 2 e 3 no fechamento do passo.

---
E6 aprovada. O desvio fica: escrita da sessão já aqui, a E7 reaproveita. As quatro decisões aceitas: disponibilidade exige RA e e-mail válidos, X-Maxx-Cliente escolhe cookie, todo erro com codigo, campo em branco com o código da regra. Registra 2 e 3 no fechamento do passo, junto com os códigos HTTP dos fluxos. Commita com a mensagem proposta, push, e segue para a E7; para para a minha revisão no fim dela.
