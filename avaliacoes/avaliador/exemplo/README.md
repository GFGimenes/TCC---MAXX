# Empréstimos da biblioteca do bairro

Repositório de exemplo, descartável, usado só no modo de ensaio do avaliador do TCC
(`avaliacoes/avaliador/avaliar.ps1 -Ensaio`). Não tem relação com nenhum produto do
experimento. Pode ser apagado ou trocado a qualquer momento.

O código controla empréstimos de livros de uma biblioteca comunitária: cadastro do
acervo, empréstimo, devolução e cálculo de multa por atraso.

## Como rodar

```
npm test
```

Requer Node.js 18 ou superior. Não há dependências externas.

## Regras

- Cada leitor pode ter no máximo 3 livros emprestados ao mesmo tempo.
- O prazo de empréstimo é de 14 dias.
- A multa é de R$ 0,50 por dia de atraso, limitada a R$ 10,00.
