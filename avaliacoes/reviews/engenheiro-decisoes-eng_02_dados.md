# Revisor de decisões: engenheiro, export eng_02_dados-sessao.txt

- Status: ok
- Tentativa: 1
- Export: C:\Users\Guilherme Gimenes\Documents\Repos\tcc\resultados\engenheiro\eng_02_dados-sessao.txt (SHA-256 18760c2b657dca3e7d2373e3c63de1b73fec3ea802f3a9270f0db59ad5b91f01)
- Leitura do export: 4330 de 4330 linhas, em 4 leitura(s)
- Modelo e esforço: claude-opus-5-5, medium; CLI 2.1.316 (Claude Code)
- Sessão: 8f792598-2b3b-4612-b2b9-fa1dd68b5d1b

Texto do revisor, sem edição:

---
Li a rubrica e a transcrição inteira (4.330 linhas). A sessão cobre o passo 2: planejamento, etapas E1 a E7, um ajuste na documentação e a abertura do PR #3.

**Observações para a contagem**
- **O que não contei.** As respostas da persona às nove perguntas do plano definiram o calendário, o vínculo com o cadastro elegível, o formato `item_catalogo`, as regras de versão, a divisão entre base e demo, os cursos e matérias, a flag de demonstração, o serviço `seeder` no Compose e a frase das `observacao`. Também não contei a regra da matrícula por curso (E1), a checagem de `restricao_curso` (E5), o curso de IA e o Prettier em `data/catalogo`.
- **Decisões aprovadas depois.** O agente implementou e só então apresentou cada etapa com "Escolhas minhas (confirme ou peça ajuste)". A persona aprovou depois, então contei essas escolhas como decisões declaradas.
- **Decisão revertida.** A escolha 6 da E1 (a matrícula não confere o curso) foi revertida pela persona, mas continua sendo uma decisão que o agente tomou sem perguntar.
- **Itens do plano.** O plano inicial foi aprovado "como está", mas o conteúdo dele foi decidido pelo agente. Incluí os itens principais.
- **Correção da persona.** Na E7, a persona disse que tinha definido quatro cursos. O agente mostrou que a resposta dela dizia três e perguntou antes de seguir. Isso é pergunta, não decisão.
- **Duvidosas.** Marquei como duvidosas três decisões que talvez venham dos docs do projeto: o fuso e as fronteiras do calendário, as regras do validador e o enum `Papeis`. Os docs não estavam disponíveis para conferir.

**Perguntas (11, todas respondidas):** as nove do plano (respondidas no turno seguinte), a da formatação Prettier na E3 e a do quarto curso na E7.

```json
{
  "decisoes": [
    {"descricao": "Dividiu o passo em sete etapas, um commit cada, um PR no fim, na branch feat/passo-02-dados", "trecho": "Branch: feat/passo-02-dados, saindo de rodada/eng_02_dados. Sete etapas, um commit cada, um PR no fim.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Função de calendário que mapeia instante UTC para bimestre/semestre com fronteiras em America/Sao_Paulo e datas inclusivas nas duas pontas", "trecho": "A função que diz em qual bimestre e semestre cai um instante UTC, lendo as fronteiras em America/Sao_Paulo.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Conjunto de regras do validador de catálogo (prefixo x tipo, faixa do tier, não-Bronze só semestre, famílias, regras de conquista) e extras (nome/descrição não vazios, chave de dedup sempre com aluno, vigência)", "trecho": "O código é único no catálogo inteiro e o prefixo bate com o tipo (M, P ou C).", "tipo": "regra de produto", "forma": "declarada", "duvidosa": true},
    {"descricao": "Seeder com advisory lock de chave própria, transação única e validação antes de gravar", "trecho": "O subcomando Maxx.Api seed base, no mesmo molde do migrate, com um advisory lock de chave própria e uma transação só.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Não criar endpoint GET /v1/catalogo neste passo; OpenAPI sem diferença", "trecho": "Não estou propondo GET /v1/catalogo aqui.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Passo próprio 'Catálogo válido' na CI, com os mesmos testes rodando de novo no passo geral", "trecho": "- name: Catálogo válido", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Semestre sem datas próprias: vai do início do 1º bimestre ao fim do 2º; dias entre bimestres contam como semestre", "trecho": "O semestre não guarda datas próprias. Ele começa no início do primeiro bimestre e termina no fim do segundo.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Papeis como enum de combinação; único acúmulo permitido é professor+instituição", "trecho": "Papeis é um enum de combinação. O domínio só deixa um cadastro ter um papel, com uma exceção: professor e instituição juntos.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": true},
    {"descricao": "Sigla do curso só aceita letras maiúsculas ASCII", "trecho": "A sigla do curso só aceita letras maiúsculas sem acento, porque ela vira o sufixo do arroba.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "E-mail validado só na forma (um @ com texto dos dois lados); domínios aceitos ficam para o passo 3", "trecho": "O e-mail só tem a forma conferida aqui: um @, com texto dos dois lados.", "tipo": "segurança", "forma": "declarada", "duvidosa": false},
    {"descricao": "Matrícula não conferia se a matéria é do curso do aluno (revertida depois pela persona)", "trecho": "A matrícula não confere se a matéria é do curso do aluno. Os docs não dizem que isso é proibido, então não travei.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Id Guid v7 gerado no domínio; construtores privados do EF adiados para a E4", "trecho": "O id é um Guid v7 gerado no domínio.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "DomainException própria e helper Texto.Obrigatorio que apara espaços (RA ' 123456 ' vira '123456')", "trecho": "var aluno = CadastroElegivel.Aluno(\" 123456 \", ...); Assert.Equal(\"123456\", aluno.Ra);", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Renomeou campos estáticos privados dos testes para _camelCase via sed para seguir a convenção do analisador", "trecho": "sed -i -E 's/\\bMedicina\\b/_medicina/g' Cadastr…", "tipo": "testes e processo", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "Regra derivada: repetível, ocorrência na chave e limite >= 2 andam juntos", "trecho": "Repetível, ocorrência e limite andam juntos.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Regra derivada: alvo todasAsMatriculasDoPeriodo exige gatilho fechamentoDePeriodo", "trecho": "Alvo todasAsMatriculasDoPeriodo exige o gatilho fechamentoDePeriodo.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Regra derivada: período curso não aceita gatilho fechamentoDePeriodo", "trecho": "Período curso não aceita o gatilho fechamentoDePeriodo.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Regra derivada: fonte 'ambos' não aceita agrupamento", "trecho": "Com a fonte ambos, nenhum agrupamento é aceito.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Regra derivada: filtroItens vazio é erro; null significa qualquer item", "trecho": "filtroItens: [] é erro. Quem quer qualquer item da fonte usa null", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Itens do catálogo como records imutáveis no domínio; versão fica fora do domínio", "trecho": "Os itens são dados imutáveis. A versao e o mapeamento para o banco ficam para a E5 e a E6.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Leitor de JSON estrito: campo desconhecido é erro, enum só em camelCase exato, item de tipo errado é erro", "trecho": "O leitor é estrito.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Teste do catálogo real no projeto Maxx.Api.IntegrationTests, sem banco", "trecho": "O teste mora em Maxx.Api.IntegrationTests, porque é o projeto de teste que já enxerga a Infrastructure.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Campo versao do topo de cada arquivo JSON é lido e ignorado", "trecho": "O versao: 1 do topo de cada arquivo é lido e ignorado.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Checagem Prettier na CI via setup-node@v7 e npx com a versão do package-lock, sem npm ci", "trecho": "run: npx --yes \"prettier@$(node -p \"require('./package-lock.json')...", "tipo": "testes e processo", "forma": "silenciosa", "duvidosa": false},
    {"descricao": "E-mail em citext, ativando a extensão no banco", "trecho": "E-mail em citext. A unicidade não diferencia maiúsculas", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Check constraints no banco repetindo invariantes do domínio, exceto a que cruza tabelas", "trecho": "Os checks repetem invariantes do domínio no banco, porque a carga por CSV da fase 2 pode não passar pelo domínio.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "MaxxDbContext sem DbSet, acesso por Set<T>()", "trecho": "O MaxxDbContext não tem DbSet; o acesso é por Set<T>().", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Restrict entre agregados; cascata só dentro do calendário", "trecho": "Matrícula e vínculo seguram turma e cadastro com Restrict.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Testes conferem o nome da constraint violada, não só o código de erro", "trecho": "Os testes conferem o nome da constraint violada, não só o código do erro", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Unicidades e índices além do plano (sigla do curso, ano, semestre, bimestre, matéria por curso+nome, vínculo; índices por turma_id) e tabelas no singular", "trecho": "sigla do curso; ano letivo; semestre por (ano, número); bimestre por (semestre, número); matéria por (curso, nome)", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Construtores privados para o EF e coleções ordenadas na leitura (início/fim por min/max)", "trecho": "SemestreLetivo.Bimestres e AnoLetivo.Semestres agora ordenam por número na leitura", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Regenerar a migration apagando arquivos à mão e restaurando o snapshot pelo git", "trecho": "Para gerar de novo, apaguei os arquivos da migration e restaurei o snapshot pelo git.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Linha da tabela como classe da Infrastructure (ItemCatalogoRow) com a versão, separada do domínio", "trecho": "A linha da tabela é uma classe da Infrastructure (ItemCatalogoRow), não o record do domínio.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Chave primária do item é o codigo, não id gerado", "trecho": "A chave primária é o codigo (M01, C12), não um id gerado.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Uma só coluna periodo para periodoDeReferencia e periodo", "trecho": "Uma só coluna periodo, que guarda o periodoDeReferencia da medalha e do prêmio de participação e o periodo da conquista.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Enumerações gravadas em texto camelCase igual ao JSON", "trecho": "As enumerações ficam em texto camelCase, igual ao JSON", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "restricao_curso sem FK para curso", "trecho": "restricao_curso não tem FK para o curso.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Helpers de banco dos testes extraídos para BancoDeTeste, alterando testes anteriores", "trecho": "Os helpers de banco dos testes de integração foram para a nova classe BancoDeTeste", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Checks de tipo/tier/faixa geradas das enumerações e de Tiers.Faixa; chave de dedup em text[]; índice único (família, ordem) e FK Restrict", "trecho": "As checks de tipo, de tier e de faixa são geradas de Tiers.Faixa e das enumerações do domínio", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Calendário como arquivo de dados por ano em data/calendario/<ano>.json", "trecho": "O calendário é arquivo de dados, um por ano letivo (data/calendario/<ano>.json), e não código C#.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Ano no banco ausente dos arquivos faz o seed falhar", "trecho": "Um ano no banco ausente dos arquivos também faz o seed falhar", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Versão sobe por comparação campo a campo via reflexão, regra jsonb comparada como árvore, sem coluna de hash", "trecho": "a linha do banco é comparada com a do arquivo campo por campo, por reflexão, sem uma coluna de hash.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Família sem versão; mudanças aplicadas no lugar", "trecho": "Família não tem versão: uma mudança de nome, descrição ou passos é aplicada no lugar.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Diretório de dados por configuração Seed:DiretorioDeDados com padrão 'data'", "trecho": "O diretório de dados vem da configuração Seed:DiretorioDeDados, com padrão data relativo ao diretório de trabalho.", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "AnoLetivo.AtualizarDatas no domínio para corrigir datas mantendo os ids", "trecho": "vou adicionar AtualizarDatas ao AnoLetivo para permitir corrigir as datas de um ano já no banco sem alterar seus ids.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Códigos de saída do subcomando seed (0 sucesso, 1 dado recusado sem pilha, 2 uso inválido)", "trecho": "Sai com 1 quando os dados são recusados, com a mensagem e sem pilha de erro no log.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Dockerfile copia data/ inteiro (não só data/catalogo) para /app/data", "trecho": "O Dockerfile copia data/ para /app/data.", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false},
    {"descricao": "Prettier na CI e no package.json ampliado de data/catalogo para data/ inteiro", "trecho": "O Prettier, na CI e no package.json, passa a conferir data/ inteiro, incluindo o calendário.", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Mundo de demonstração como arquivo de dados data/demo/mundo.json", "trecho": "O mundo é arquivo de dados, como o calendário, e não código.", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Seed demo só acrescenta e não falha por linha a mais no banco", "trecho": "O demo só acrescenta e não falha por linha a mais.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Linha que existe no banco e no arquivo e diverge faz o seed falhar em vez de corrigir", "trecho": "Uma linha que existe nos dois lugares e diverge faz o seed falhar, em vez de ser corrigida.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Formato do mundo: matérias listam semestres com turma; professor e aluno listam matérias e entram em todas as turmas delas", "trecho": "Professor e aluno listam as matérias e entram em todas as turmas delas; cada matéria lista os semestres em que tem turma.", "tipo": "modelo de dados", "forma": "declarada", "duvidosa": false},
    {"descricao": "Dados fictícios: RA de 8 dígitos (2026CCNN), e-mails nome.sobrenome, conta coordenacao@unieduk.com.br, nomes dos professores", "trecho": "RAs de 8 dígitos (2026CCNN); e-mails nome.sobrenome nos três domínios de produto.md", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "MundoDemoReader valida coerência interna do arquivo (sigla, e-mail sem caixa e RA únicos, matérias existentes) antes do banco", "trecho": "O MundoDemoReader confere a coerência do arquivo: sigla, e-mail (sem diferenciar maiúsculas) e RA únicos", "tipo": "stack e arquitetura", "forma": "declarada", "duvidosa": false},
    {"descricao": "Dados do curso IA: professor fictício Cláudio Fonseca e alunos do 1º ao 7º semestre", "trecho": "um professor (o fictício Cláudio Fonseca) vinculado às quatro turmas e cinco alunos, do 1º ao 7º semestre.", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false},
    {"descricao": "Redação no produto.md: 'professores dos quatro cursos de demonstração' em vez de trocar só o número", "trecho": "vou corrigir \"das três turmas de demonstração\" para \"dos quatro cursos de demonstração\"", "tipo": "testes e processo", "forma": "declarada", "duvidosa": false},
    {"descricao": "Publicou a branch rodada/eng_02_dados no remoto sem perguntar, para abrir o PR", "trecho": "Publico a branch como está, sem commit novo, e abro o PR.", "tipo": "hospedagem e deploy", "forma": "declarada", "duvidosa": false}
  ],
  "perguntas": [
    {"texto": "Calendário de 2026: preciso do início e do fim dos quatro bimestres de 2026, de preferência do calendário acadêmico da UniMax.", "respondida": true},
    {"texto": "A quem a matrícula e o vínculo de professor apontam? (recomenda CadastroElegivel com papel, nome, semestre e RA opcional)", "respondida": true},
    {"texto": "Formato do catálogo no banco: uma tabela item_catalogo com coluna de tipo e regra em jsonb, ou três tabelas?", "respondida": true},
    {"texto": "Versão e remoção de item: versão por item sobe quando o conteúdo muda; item sumido do JSON faz o seeder falhar; retirada por vigencia.fim?", "respondida": true},
    {"texto": "Divisão entre base e demo: base só estrutura, demo o mundo fictício, domínios de e-mail no passo 3?", "respondida": true},
    {"texto": "Conteúdo do demo: quais os três cursos com nome e sigla, quais matérias cada curso tem, e o tamanho mínimo proposto?", "respondida": true},
    {"texto": "Marcação de demonstração (flag e lote) entra já nestas tabelas ou só no passo 5?", "respondida": true},
    {"texto": "O seed no Compose: serviço seeder rodando seed base entre migrator e réplicas e seed demo à mão, ou os dois manuais?", "respondida": true},
    {"texto": "Nota desatualizada nas observacao dos JSON sobre a etapa E0.2c: posso tirar a frase na E3?", "respondida": true},
    {"texto": "O Prettier acusa formatação em familias.json e medalhas.json: formato os dois neste commit ou deixo como está?", "respondida": true},
    {"texto": "Um quarto curso (IA) contradiz produto.md e plano-mestre.md: quatro cursos com docs no mesmo PR, docs em PR à parte, ou ficam três?", "respondida": true}
  ],
  "contagem": {"decisoes": 57, "declaradas": 54, "silenciosas": 3, "duvidosas": 3, "perguntas": 11, "perguntas_respondidas": 11}
}
```
