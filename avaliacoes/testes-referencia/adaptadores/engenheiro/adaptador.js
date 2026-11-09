'use strict';
// Esqueleto do adaptador do maxx-engenheiro: interface completa, nada implementado.
// O desenho (rotas, subida por docker compose, decisões pendentes) está no README.md
// desta pasta. Sem subir.ps1, o rodar.ps1 recusa este adaptador.

const VERBOS = {
  capacidades: 'GET /api/v1/cursos; tiers: true; exAlunos: conferir no passo 12',
  criarAluno: 'usuário do seed demo (decisão pendente 2) + POST /api/v1/auth/login',
  criarProfessor: 'professor do seed demo, com turma + POST /api/v1/auth/login',
  publicar: 'POST /api/v1/uploads + POST /api/v1/posts',
  curtir: 'PUT /api/v1/posts/{id}/curtida',
  descurtir: 'DELETE /api/v1/posts/{id}/curtida',
  comentar: 'POST /api/v1/posts/{id}/comentarios',
  apagarPost: 'DELETE /api/v1/posts/{id}',
  editarPerfil: 'PATCH /api/v1/eu/perfil',
  concederPremio: 'GET /api/v1/professor/turmas + POST /api/v1/professor/turmas/{turmaId}/medalhas',
  pontos: 'GET /api/v1/perfis/{id}',
  posicao: 'GET /api/v1/perfis/{id} (passo 11)',
  ranking: 'rota do passo 11, esperando o worker (ADR 0005)',
  pedidoInvalido: 'mesmos tipos do leigo, ids como GUID',
  bruto: 'pedido JSON cru com o token do ator',
  premioPorTier: 'decisão pendente 1 (catálogo é arquivo, não rota)',
  tierDoAluno: 'GET /api/v1/perfis/{id}',
  formarAluno: 'conferir se o produto tem ex-alunos no commit avaliado',
};

function criar() {
  const adaptador = { historico: [] };
  for (const [verbo, rota] of Object.entries(VERBOS)) {
    adaptador[verbo] = async () => {
      throw new Error(`Adaptador do engenheiro não implementado: ${verbo} (${rota}). Ver adaptadores/engenheiro/README.md.`);
    };
  }
  return adaptador;
}

module.exports = { criar, VERBOS };
