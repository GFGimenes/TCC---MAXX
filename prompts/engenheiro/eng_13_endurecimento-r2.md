ID: eng_13_endurecimento-r2
Trilha: engenheiro
Tela: passo 13 (resposta 2 do autor: parada antes da etapa 2, `.env` da VPS)
Data: 2026-11-09
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor escreveu o `/opt/maxx/.env` na VPS com os valores guardados fora do repositório; nenhum valor passou pelo chat do agente nem pelo Cowork; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 1 fechada em três commits na `chore/passo-13-endurecimento`: compose de produção e job `publicar`; fix renomeando as imagens para `maxx-engenheiro-api` e `maxx-engenheiro-caddy`; fix publicando sem atestado de proveniência (`--provenance=false`), porque sem o rótulo `source` ligando o pacote ao repositório o `GITHUB_TOKEN` não gravava o manifesto. CI verde no push (run 42706980909) e no disparo à mão com `publicar` (run 42706980612, tag `sha-c1f2b77`). VPS puxou as duas imagens sem login.
- Correção declarada pelo agente: o pacote `ghcr.io/gfgimenes/maxx-api` não era do `maxx-leigo`, como ele tinha dito; foi criado pela primeira tentativa dele. Ficou vazio, limpeza a cargo do autor.
- Lista de variáveis entregue só com nomes e observações de formato; `COMPOSE_PROFILES` e `MAXX_ARMAZENAMENTO_ENDPOINT_PUBLICO` de fora; sem aspas nas linhas do R2.
- Já preparado para a etapa 2, sem commit: 9 e-mails do seed em `@maxx-unimax.com` com os testes de integração (60 de 60) e `docs/operacao.md`. Email Routing da Cloudflare com catch-all configurado e testado pelo autor antes desta resposta.

---
env feito. Está em /opt/maxx/.env com permissão 600, todos os nomes da sua lista, sem aspas, MAXX_IMAGEM_TAG em sha-c1f2b77 por enquanto, MAXX_ARMAZENAMENTO_REGIAO em auto e MAXX_SMTP_SEGURANCA em StartTls. O Email Routing com catch-all já está ativo e testado. Confira só os nomes, sem imprimir valor, e segue com a etapa 2. O pacote maxx-api vazio eu apago depois.
