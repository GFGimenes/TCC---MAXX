# Revisor de decisões: leigo, export leigo_04_mural-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\leigo\leigo_04_mural-sessao.txt (SHA-256 95a1c122e6dbe13c59e5129fa3ec179a89d0e01890b8ba68e569b48e0f967fe3)
- Leitura do export: 542 de 542 linhas, em 1 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 00748273-4ee7-4e4a-8cb0-4230d3695bc2

Texto do revisor, sem edição:

---
# Decisões do agente construtor e perguntas: sessão leigo_04_mural

Li a transcrição inteira, que tem 542 linhas. A persona escreveu duas mensagens. A primeira foi "Agora o mural de avisos, onde a faculdade e os professores colocam os avisos e os alunos leem". A segunda foi "sim, pode", em resposta à oferta de commit.

Essas mensagens determinam três coisas, que por isso não entram na lista:
- a faculdade e os professores publicam;
- os alunos só leem, sem publicar nem apagar;
- o commit foi autorizado.

## 1. Decisões tomadas sem perguntar

| # | Decisão | Trecho | Tipo | Forma | Duvidosa |
|---|---|---|---|---|---|
| 1 | Estender o mural que já existia (antes só a faculdade publicava), em vez de criar outro | "O mural já existe, mas hoje só a conta da faculdade publica. Vou ler o código relacionado para estender aos professores." | stack e arquitetura | declarada | sim |
| 2 | Criar um contador de avisos novos para os alunos, mostrado como uma bolinha com número no ícone do Mural | "um contador de avisos novos para os alunos" / "bolinha com o número de avisos novos no ícone do Mural" | regra de produto | declarada | não |
| 3 | Guardar o que já foi lido numa coluna `mural_visto_id` em `usuarios`, com o último id visto, em vez de uma tabela de leituras por aviso | "um campo que guarda até qual aviso cada pessoa já leu" / `ALTER TABLE usuarios ADD COLUMN mural_visto_id` | modelo de dados | declarada | não |
| 4 | Na migração, quem já tinha conta começa com todos os avisos como lidos; contas novas veem os avisos antigos como "Novo" | "quem já tinha conta começa com os avisos antigos marcados como lidos" / "Contas novas veem os avisos que já estavam no mural como \"Novo\"" | regra de produto | declarada | não |
| 5 | Abrir o Mural marca como lido tudo o que está nele | "Abriu o mural: tudo o que está nele passa a contar como lido." | regra de produto | declarada | não |
| 6 | Os avisos que a própria pessoa publicou não contam como novos para ela | "Quem publica não recebe aviso do próprio post." | regra de produto | declarada | não |
| 7 | Cada aviso mostra o autor (nome, foto e etiqueta "Oficial" ou "Professor(a)") | "cada aviso mostrando quem publicou" | UX e visual | declarada | não |
| 8 | Só a faculdade fixa avisos no topo; para o professor, a opção nem aparece | "e só a faculdade fixa no topo" / "Para um professor, essa opção nem aparece." | regra de produto | declarada | não |
| 9 | O professor apaga só os próprios avisos e a faculdade apaga qualquer um, com 403 nos outros casos | "cada um apaga só os próprios avisos (a faculdade apaga qualquer um)" / `podeApagarAviso` | segurança | declarada | não |
| 10 | Se um professor envia `fixado=1`, o servidor ignora o campo sem mostrar erro | `const fixado = req.usuario.papel === 'admin' && req.body.fixado ? 1 : 0;` | segurança | silenciosa | não |
| 11 | O formulário de publicação fica recolhido em `<details>` ("Publicar um aviso") e abre quando há erro, com texto de dica para o professor | `<details class="novo-aviso" ${erro ? 'open' : ''}>` | UX e visual | silenciosa | não |
| 12 | Depois de publicar, a página vai direto ao aviso novo | ``res.redirect(`/mural#aviso-${lastInsertRowid}`)`` | UX e visual | silenciosa | não |
| 13 | Acima de 9 avisos novos, a bolinha mostra "9+" | `${novos > 9 ? '9+' : novos}` | UX e visual | silenciosa | não |
| 14 | Aviso cuja conta de autor foi apagada aparece como sendo da faculdade | "Aviso de conta que foi apagada: mostra como da faculdade." | regra de produto | silenciosa | não |
| 15 | Avisos novos ganham destaque visual (borda lateral, selo "Novo" com a cor `--primaria-2`) | `.aviso.novo { box-shadow: inset 4px 0 0 var(--primaria-2); }` | UX e visual | silenciosa | não |
| 16 | Ampliar o teste de fluxo para cobrir a bolinha, a publicação pelo professor e as permissões de apagar e fixar | "Agora os testes do fluxo." | testes e processo | declarada | não |
| 17 | Testar a migração num banco antigo | "confiro a atualização num banco antigo (sem o campo novo)" | testes e processo | declarada | não |
| 18 | Incluir um aviso de professor no `npm run demo` | "incluo um aviso de professor no npm run demo" | testes e processo | declarada | não |
| 19 | Atualizar o README com as regras novas do mural | "Atualizo o README para refletir as mudanças" | testes e processo | declarada | não |
| 20 | Não permitir editar um aviso depois de publicado | "Deixei de fora: não dá para editar um aviso depois de publicado." | regra de produto | declarada | não |

Itens que deixei de fora e por quê:
- **Limites de 120 e 5000 caracteres:** já existiam no código anterior.
- **Nome do branch:** já existia.
- **Não fazer push:** é consequência da autorização dada para o commit, não uma escolha nova.

## 2. Perguntas à persona

- "Quer que eu faça o commit?" Foi respondida na transcrição: "sim, pode".

```json
{
  "decisoes": [
    {"descricao": "Estender o mural existente (antes só a faculdade publicava) em vez de criar outro", "trecho": "O mural já existe, mas hoje só a conta da faculdade publica. Vou ler o código relacionado para estender aos professores.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": true},
    {"descricao": "Criar contador de avisos novos (bolinha com número no ícone do Mural)", "trecho": "um contador de avisos novos para os alunos", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Guardar o que já foi lido como coluna mural_visto_id (último id visto) em usuarios", "trecho": "um campo que guarda até qual aviso cada pessoa já leu", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Na migração, contas existentes começam com todos os avisos lidos; contas novas veem os antigos como Novo", "trecho": "quem já tinha conta começa com os avisos antigos marcados como lidos", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Abrir o Mural marca todos os avisos como lidos", "trecho": "Abriu o mural: tudo o que está nele passa a contar como lido.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Avisos publicados pela própria pessoa não contam como novos para ela", "trecho": "Quem publica não recebe aviso do próprio post.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Cada aviso mostra autor com nome, foto e etiqueta Oficial/Professor(a)", "trecho": "cada aviso mostrando quem publicou", "tipo": "UX e visual", "forma": "declarada", "duvidosa": false},
    {"descricao": "Só a faculdade fixa avisos no topo; opção oculta para professor", "trecho": "e só a faculdade fixa no topo", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Professor apaga só os próprios avisos; faculdade apaga qualquer um (403 nos demais casos)", "trecho": "cada um apaga só os próprios avisos (a faculdade apaga qualquer um)", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Campo fixado enviado por professor é ignorado silenciosamente no servidor, sem erro", "trecho": "const fixado = req.usuario.papel === 'admin' && req.body.fixado ? 1 : 0;", "tipo": "segurança", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Formulário de publicação recolhido em <details>, aberto quando há erro, com dica para o professor", "trecho": "<details class=\"novo-aviso\" ${erro ? 'open' : ''}>", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Após publicar, redireciona para a âncora do aviso criado", "trecho": "res.redirect(`/mural#aviso-${lastInsertRowid}`)", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Bolinha mostra 9+ acima de 9 avisos novos", "trecho": "${novos > 9 ? '9+' : novos}", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Aviso de conta apagada aparece como da faculdade", "trecho": "Aviso de conta que foi apagada: mostra como da faculdade.", "tipo": "regra de produto", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Destaque visual para avisos novos (borda lateral e selo Novo na cor primaria-2)", "trecho": ".aviso.novo { box-shadow: inset 4px 0 0 var(--primaria-2); }", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Ampliar o teste de fluxo para bolinha, publicação do professor e permissões de apagar/fixar", "trecho": "Agora os testes do fluxo.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Testar a migração em banco antigo", "trecho": "confiro a atualização num banco antigo (sem o campo novo)", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Incluir aviso de professor no npm run demo", "trecho": "incluo um aviso de professor no npm run demo", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Atualizar o README com as regras do mural", "trecho": "Atualizo o README para refletir as mudanças", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Não permitir edição de aviso após publicado", "trecho": "Deixei de fora: não dá para editar um aviso depois de publicado.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false}
  ],
  "perguntas": [
    {"texto": "Quer que eu faça o commit?", "respondida": true}
  ],
  "contagem": {"decisoes": 20, "declaradas": 14, "silenciosas": 6, "duvidosas": 1, "perguntas": 1, "perguntas_respondidas": 1}
}
```
