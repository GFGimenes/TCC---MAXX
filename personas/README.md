# Personas de Usuário

Não confundir com as "personas das IAs" (arquiteto sênior/Claude, dev pragmático/GPT
etc., descritas na seção 3.1 do TCC) — isso aqui são as personas de **quem escreve o
prompt**: leigo vs. engenheiro pleno.

- `leigo/` — perfil de usuário sem formação técnica: vocabulário, nível de detalhe,
  suposições e lacunas típicas de quem não sabe o que pedir tecnicamente.
- `engenheiro/` — perfil de engenheiro de software pleno (6 anos de experiência):
  vocabulário técnico preciso, restrições explícitas, revisão crítica da resposta.

Preencha cada pasta com o resultado da sua pesquisa (ex.: `perfil.md` por persona).
Esses perfis são o que orienta a escrita dos prompts em `prompts/`.

## Premissas do experimento

1. **Mesmo objetivo funcional.** As duas personas pedem as mesmas features (definidas
   nos rascunhos descritivos por tela) e o produto final deve ter a mesma usabilidade
   geral — o que varia é o *como* pedem, não o *quê*.
2. **Leigo:** descreve as features no nível básico do usuário final ("quero uma tela de
   login com RA", "quero que dê pra curtir posts"), sem termos técnicos, sem
   restrições de arquitetura/segurança, e sabe apenas o essencial do que quer.
3. **Engenheiro:** pede as mesmas features com vocabulário técnico, restrições
   explícitas (validação, autorização, testes) e revisa criticamente as respostas.
4. Como o objetivo funcional é o mesmo, diferenças de qualidade entre as trilhas são
   atribuíveis à formulação do prompt e à validação do usuário — não ao escopo.
5. **Features emergentes da persona são achado, não exceção.** O engenheiro pode
   antecipar requisitos que o cliente pediria (ex.: log de leitura dos avisos do
   mural) e o leigo não. Essas diferenças de completude devem ser registradas como
   resultado do experimento — evidência de como a experiência técnica altera o
   produto final mesmo partindo do mesmo objetivo.
