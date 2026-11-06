ID: eng_04_design-r8
Trilha: engenheiro
Tela: passo 4 (resposta 8 do autor: revisão da etapa 6, medalhão, selo, faixa e trilha; liberação da etapa 7 em duas paradas)
Data: 2026-11-05
Origem: leitura do Cowork (Anthropic) do export da sessão; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 5 fechada em `48814a9`, CI verde nos seis jobs.
- Etapa 6: `Medalhao` (gradiente radial do token, anéis de raridade em `rarityRing`, 32 raios no lendário), `SeloPremio`, `FaixaPremio`, `TrilhaFamilia` (2 a 5 passos, próximo com cadeado, demais tracejados, rolagem com 5); teste de regra que falha com gradiente fora de `Medalhao` e `SeloPremio` ou sombra fora do `SegmentedControl`; 201 Jest, 20 e2e. Limite declarado: componentes só com Jest e capturas; gradiente em SVG é o ponto mais sensível no nativo, não testado.
- Nove decisões estimadas pela prancheta, aceitas. Etapa 7 liberada em duas paradas: captura do SVG vetorizado antes de gerar os ícones, e depois ícone, splash e favicon.

---
Etapa 6 aprovada. As nove decisões aceitas: medidas do token para o medalhão de 48, 32 raios no lendário, folga do lendário sempre reservada com raridade, glifo em contorno a 50%, selo 26 com medalhão 18 e Archivo 700 tamanho 12, faixa com raio 16, trilha com círculo 36 e passo 82, cartão de título dentro do componente, lacuna no meio sem linha contínua. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 7: vetoriza o logo primeiro e me mostra a captura do SVG sobre marinho e sobre o bg dos dois temas antes de gerar os ícones; para aí.
