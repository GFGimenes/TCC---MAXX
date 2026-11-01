ID: eng_00_tecnica-r1
Trilha: engenheiro
Tela: abertura (resposta 1 do autor ao plano mestre v1 devolvido pelo agente depois do `eng_00_tecnica`: seis bloqueantes, oito itens importantes e as decisões técnicas com pesos)
Data: 2026-11-01
Origem: decisões do autor, debatidas item a item com o Cowork (Anthropic) em 24/10 e 01/11/2026 e redigidas pelo Cowork a partir das palavras do autor; o autor revisou.

Notas de registro:
- Decisões próprias do autor, contra ou fora da sugestão do agente: navegação (barra mantida; rankings pelo perfil e pela Busca; histórico como filtro), raridade derivada da escassez com limiares fixos (o agente dava peso 5 a essa opção e 9 à raridade fixa no catálogo), "salvar" removido e "enviar" vira compartilhar, sem plano B local de rede (a banca usa a própria rede móvel; deploy na VPS é o único ambiente).
- Aceites da sugestão do agente: trilha por família de catálogo, idioma do código (domínio em português, técnico em inglês), GitHub Actions, sininho e perfil, R2, leitura pública por chave aleatória, motor declarativo, termo de uso na fase 1, fotos do seed, e todas as recomendações com peso 8 ou mais, mais a leitura do desempate e a ordem dos 13 passos.

---
Respostas, na sua numeração.

Bloqueantes.

1.3 Navegação: a barra fica como está no design, com as cinco abas (Home, Busca, Mural, Troféus, Perfil). Rankings não tem aba; abre de dois jeitos: tocando na própria posição no perfil, e pela Busca, que além de buscar alunos mostra atalhos para o ranking geral e o ranking do curso. Dentro de cada ranking, um filtro alterna semestre atual e histórico. A Busca busca alunos (para seguir) e dá esses atalhos; nada mais na fase 1.

1.1 Raridade: derivada da escassez, não fixa no catálogo. Cada item mostra "desbloqueado por x% dos alunos", e a raridade vem de limiares fixos sobre essa porcentagem, calculada sobre os alunos ativos: Lendário abaixo de 1%, Épico abaixo de 5%, Raro abaixo de 20%, Comum o resto. Item que ninguém tem aparece como Lendário com 0%. O recálculo roda no mesmo worker do ranking. O seed da demo precisa distribuir os prêmios de modo que as quatro raridades apareçam.

1.2 Trilha de progressão: família de catálogo, como você propôs. Itens declaram família e ordem; a trilha mostra o caminho com o próximo em cadeado.

1.4 Enviar e salvar: "salvar" sai da linha de ações na fase 1. "Enviar" vira compartilhar: abre a folha de compartilhamento do sistema com o link do post.

3.15 Idioma do código: domínio em português, técnico em inglês, como você sugeriu. Vai para o CLAUDE.md.

§6 CI: GitHub Actions; o repositório está no GitHub.

Importantes.

1.5 Sininho: fica no cabeçalho do feed; confira nas telas do feed quando formos implementar e, se não estiver, siga a identidade visual.

1.6 e 1.7 Editar perfil: foto e nome de exibição. Professor também tem foto. A foto de perfil segue as mesmas regras de assinatura e derivadas do post.

3.2 Storage: Cloudflare R2 com a CDN da Cloudflare.

3.3 Leitura das fotos: pública para quem tem o link, com chave aleatória, documentado no TCC e coberto pelo termo de uso.

3.5 Motor de conquistas: especificação declarativa em JSON no catálogo mais um avaliador, com escape para regra em C# se precisar; um teste por forma de contagem e um por item.

7.1 Rede na banca: sem plano B local. O deploy na VPS é o único ambiente; se o wifi do campus falhar, a banca entra pela própria rede móvel, e o meu notebook fica roteado pelo celular para a demonstração. O passo 13 inclui o ensaio da apresentação nesse cenário.

7.3 Termo de uso: entra na fase 1, uma tela simples de aceite no cadastro, dentro da identidade visual.

§5 Fotos do seed: a foto do campus que já está no design, mais placeholders gerados, sem pessoas.

Decisões técnicas com peso: aceito todas as suas recomendações de peso 8 ou mais como estão: origem única com o Caddy servindo o web e fazendo proxy de /api; derivadas de imagem geradas no cliente (feed e grade); snapshot de tier e pontos na concessão; ranking em tabela escrita pelo worker com coalescência; auth própria com Argon2id e família de refresh com detecção de reuso, escopo de turma checado no banco; openapi-typescript com openapi-fetch e hooks TanStack escritos à mão; Jest com jest-expo no cliente, Playwright no e2e e Maestro mínimo no endurecimento; quatro projetos (Domain, Application, Infrastructure, Api) com fatias por recurso; migrations em contêiner separado com advisory lock, nunca no startup; semente de sessão dentro do cursor para a recomendação aleatória; catálogo em JSON versionado com seeder idempotente por comando; fonte Archivo instanciada em 112% e embarcada nas três plataformas; .NET 10 e OpenAPI nativo; p95 medido na definição de pronto, com k6 versionado e rodado nos passos de endurecimento; backup com pg_dump noturno para o bucket e dump manual antes de migration; marcação da demo por flag e lote. A sua leitura do desempate serve: instante da última concessão que compõe a pontuação atual. Aprovação em lote por evento fica registrada como fase 2, com a Comprovacao filtrável por evento desde o início.

A ordem dos 13 passos fica como você propôs: fundação, dados, autenticação, design system, primeira tela. Pode escrever o plano do passo 0. Continua sem código até eu aprovar o plano mestre; o passo 0 começa gravando o CLAUDE.md e o catálogo, com raridade por escassez e as famílias de trilha.
