ID: eng_13_endurecimento-r4
Trilha: engenheiro
Tela: passo 13 (resposta 4 do autor: CI vermelha depois do fix na etapa 6, achado do Trivy no Caddy)
Data: 2026-11-09
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 6 em três commits: `cec612a` (Node 24 e Trivy na CI), `711ff11` (volta ao Node 22, porque um teste do cliente falha no 24 de forma comportamental; CI do mobile confirmou), `58f0666` (apt upgrade na imagem da API pelos dois achados altos do Trivy e laço corrigido para varrer as duas imagens). Ocorrência declarada: os arquivos da etapa 7 entraram no commit do fix por engano e foram retirados antes do push, com o fix refeito só com o Node.
- Parada pela regra "CI vermelha depois do fix": o Trivy, agora varrendo a segunda imagem, acusa CVE-2026-78661 (golang.org/x/net v0.60.0, DoS no parser HTML) no binário do Caddy 2.11.9, sem versão corrigida publicada. Três opções trazidas: exceção com prazo no `.trivyignore.yaml`, compilar o Caddy com xcaddy forçando x/net 0.62.0, ou Trivy não bloqueante para o Caddy (desaconselhada pelo próprio agente).
- Etapa 7 pronta sem commit (backup.sh com dump, `pg_restore --list` e rotação de 14 dias; timer systemd 03:00 São Paulo; restaurar-teste.sh com contagem por tabela; deploy.sh com dump antes do migrator); etapa 8 com roteiro k6 em `carga/leitura.js`, tokens assinados na própria VPS com a chave do `.env` de lá (chave não sai da VPS), planos por auto_explain numa rodada curta separada da medida.
- Vigia da CI terminou com código -1 sem resultado; o agente consultou a rodada direto. Ocorrência de ambiente.

---
Opção 1. .trivyignore.yaml só com a CVE-2026-78661, com a justificativa que você escreveu (Caddy só serve estáticos e faz proxy de /api, sem templates nem markdown) e validade 05/12/2026. Registra no índice de decisões que a exceção expira e que a troca pela imagem corrigida do Caddy é a saída quando ela sair. O método do k6 está aprovado: tokens assinados na VPS com a chave de lá, sem a chave sair, e auto_explain só na rodada curta. Faz o fix, fecha a 6 e segue 7 e 8 sem me esperar; para na 9 com o roteiro do ensaio.
