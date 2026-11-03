ID: eng_02_dados-r4
Trilha: engenheiro
Tela: passo 2 (resposta 4 do autor: revisão da E3, leitura dos JSON do catálogo e validação na CI)
Data: 2026-11-02
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- `CatalogoReader` lê os quatro JSON e roda o validador; o catálogo real (46 itens, 8 famílias) passou de primeira. 10 testes, sete deles com cópias quebradas de propósito (pontos fora da faixa, referência a M99, enum com maiúscula trocada, campo ausente, campo desconhecido, item de tipo errado, arquivo ausente). Passo "Catálogo válido" no job api da CI. Nota "E0.2c" removida dos JSON.
- Três escolhas declaradas e aceitas: leitor estrito (campo desconhecido é erro, enum só em camelCase exato, tipo errado é erro); teste no projeto de integração sem banco; `versao` do topo do arquivo ignorada.
- O agente apontou, fora do escopo, que dois JSON do catálogo estavam fora do Prettier e que a CI não conferia a pasta; o autor mandou formatar no mesmo commit e incluir `data/catalogo` na checagem.

---
E3 aprovada. As três escolhas ficam: leitor estrito, teste no IntegrationTests sem banco, versao do topo ignorada. Formata os dois JSON neste commit e inclui data/catalogo na checagem do Prettier, para a CI passar a conferir a pasta; é só formatação, sem mudar conteúdo, e o teste dos 46 itens prova isso. Commita com a mensagem proposta, push, e segue para a E4 com o Docker ligado; para para a minha revisão no fim dela.
