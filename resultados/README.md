# Resultados

Registro de cada rodada, por trilha, espelhando `prompts/`:

```
resultados/
  leigo/<id>.md
  engenheiro/<id>.md
```

O código gerado vive no repo da trilha (`maxx-leigo` ou `maxx-engenheiro`; um merge
por rodada na `main`, `rodada: <id>`). Aqui fica o que o diff não mostra: resumo da sessão, decisões que a
IA tomou sem o prompt pedir (stack, estrutura de pastas, hospedagem), perguntas que
ela fez e como foram respondidas, avisos e erros, tempo e número de iterações. É sobre
o diff e este registro que a rubrica em `avaliacoes/rubrica.md` é aplicada.
