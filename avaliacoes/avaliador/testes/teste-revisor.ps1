# Teste da etapa 2 sem gastar sessão: leitura do bloco JSON, auditoria de caminhos,
# tentativas e o fluxo de um eixo com um claude falso (testes/claude-falso.ps1).
# Uso: powershell -ExecutionPolicy Bypass -File testes\teste-revisor.ps1

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
$avaliador = Split-Path -Parent $PSScriptRoot
$raizTcc = (Get-Item -LiteralPath (Join-Path $avaliador '..\..')).FullName
. (Join-Path $avaliador 'lib\checkout.ps1')
. (Join-Path $avaliador 'lib\revisor.ps1')

$falhas = 0
function Confere {
    param([string]$Descricao, [bool]$Condicao)
    if ($Condicao) { Write-Host "  ok     $Descricao" }
    else { Write-Host "  FALHOU $Descricao"; $script:falhas++ }
}
function Bloco { param([string]$Json) return "Texto do review.`n`n``````json`n$Json`n``````" }

Write-Host '1. Bloco JSON'
$doc = Get-CamposEixo -Eixo 'documentacao'
$seg = Get-CamposEixo -Eixo 'seguranca'
$valido = '{"nota": 4, "justificativa": "x", "evidencias": [{"local": "a.js:1", "descricao": "y"}], "regras_ausentes": [], "decisoes_do_agente": ["d"], "nao_verificado": []}'
Confere 'bloco válido aceito' ((Get-BlocoJson -Texto (Bloco $valido) -Campos $doc.campos -Tipos $doc.tipos).ok)
Confere 'resposta sem bloco recusada' (-not (Get-BlocoJson -Texto 'sem bloco' -Campos $doc.campos -Tipos $doc.tipos).ok)
Confere 'JSON quebrado recusado' (-not (Get-BlocoJson -Texto (Bloco '{"nota": 4,') -Campos $doc.campos -Tipos $doc.tipos).ok)
Confere 'nota 7 recusada' (-not (Get-BlocoJson -Texto (Bloco ($valido -replace '"nota": 4', '"nota": 7')) -Campos $doc.campos -Tipos $doc.tipos).ok)
Confere 'nota 0 recusada' (-not (Get-BlocoJson -Texto (Bloco ($valido -replace '"nota": 4', '"nota": 0')) -Campos $doc.campos -Tipos $doc.tipos).ok)
Confere 'nota como texto recusada' (-not (Get-BlocoJson -Texto (Bloco ($valido -replace '"nota": 4', '"nota": "4"')) -Campos $doc.campos -Tipos $doc.tipos).ok)
Confere 'nota 3.5 recusada' (-not (Get-BlocoJson -Texto (Bloco ($valido -replace '"nota": 4', '"nota": 3.5')) -Campos $doc.campos -Tipos $doc.tipos).ok)
Confere 'campo a mais recusado' (-not (Get-BlocoJson -Texto (Bloco ($valido -replace '\}$', ', "extra": 1}')) -Campos $doc.campos -Tipos $doc.tipos).ok)
Confere 'nao_verificado ausente recusado' (-not (Get-BlocoJson -Texto (Bloco ($valido -replace ', "nao_verificado": \[\]', '')) -Campos $doc.campos -Tipos $doc.tipos).ok)
Confere 'lista como texto recusada' (-not (Get-BlocoJson -Texto (Bloco ($valido -replace '"regras_ausentes": \[\]', '"regras_ausentes": "nenhuma"')) -Campos $doc.campos -Tipos $doc.tipos).ok)
Confere 'Segurança sem falhas recusada' (-not (Get-BlocoJson -Texto (Bloco $valido) -Campos $seg.campos -Tipos $seg.tipos).ok)
Confere 'Segurança com falhas aceita' ((Get-BlocoJson -Texto (Bloco ($valido -replace '\}$', ', "falhas": []}')) -Campos $seg.campos -Tipos $seg.tipos).ok)
$dois = (Bloco '{"nota": 1}') + "`n" + (Bloco $valido)
$r = Get-BlocoJson -Texto $dois -Campos $doc.campos -Tipos $doc.tipos
Confere 'com dois blocos, vale o último' ($r.ok -and $r.dados.nota -eq 4)

Write-Host '2. Auditoria de caminhos'
$co = 'C:\tmp\exec\repo'; $se = 'C:\tmp\exec\sessao-x'
$f = @(
    [pscustomobject]@{ nome = 'Read'; entrada = [pscustomobject]@{ file_path = 'C:\tmp\exec\repo\src\a.js' } },
    [pscustomobject]@{ nome = 'Glob'; entrada = [pscustomobject]@{ pattern = '**/*.md' } },
    [pscustomobject]@{ nome = 'Read'; entrada = [pscustomobject]@{ file_path = 'C:\tmp\exec\sessao-x\rubrica.md' } }
)
Confere 'leituras dentro das pastas liberadas não acusam' (@(Get-AcessosFora -Ferramentas $f -Liberadas @($co, $se) -Cwd $se).Count -eq 0)
$f2 = @(
    [pscustomobject]@{ nome = 'Read'; entrada = [pscustomobject]@{ file_path = 'C:\Users\x\tcc\avaliacoes\reviews\leigo-ux.md' } },
    [pscustomobject]@{ nome = 'Grep'; entrada = [pscustomobject]@{ pattern = 'senha'; path = 'C:\tmp\exec\repo-irmao' } },
    [pscustomobject]@{ nome = 'Read'; entrada = [pscustomobject]@{ file_path = '..\..\fora.txt' } },
    [pscustomobject]@{ nome = 'Glob'; entrada = [pscustomobject]@{ pattern = 'C:\outro\**\*.md' } }
)
Confere 'quatro acessos fora acusados (outro review, pasta irmã, ..\, Glob absoluto)' (@(Get-AcessosFora -Ferramentas $f2 -Liberadas @($co, $se) -Cwd $se).Count -eq 4)

Write-Host '3. Tentativas'
$tmp = Join-Path (Get-PastaTemporaria) ("teste-revisor-" + (Get-Date -Format 'yyyyMMdd-HHmmss'))
$saida = Join-Path $tmp 'saida'
New-Item -ItemType Directory -Force -Path $saida | Out-Null
Confere 'primeira execução é tentativa 1' ((Get-ProximaTentativa -PastaSaida $saida -Base 'p-documentacao') -eq 1)
Write-TextoArquivo -Texto '{"tentativa": 1}' -Caminho (Join-Path $saida 'p-documentacao.json')
Write-TextoArquivo -Texto 'review 1' -Caminho (Join-Path $saida 'p-documentacao.md')
Confere 'segunda execução é tentativa 2' ((Get-ProximaTentativa -PastaSaida $saida -Base 'p-documentacao') -eq 2)
Confere 'review anterior guardado como -t1, não apagado' ((Test-Path (Join-Path $saida 'p-documentacao-t1.md')) -and (Test-Path (Join-Path $saida 'p-documentacao-t1.json')))

Write-Host '4. Fluxo de eixo com claude falso'
$script:ClaudeArquivo = 'powershell.exe'
$script:ClaudePrefixo = '-NoProfile -ExecutionPolicy Bypass -File "' + (Join-Path $PSScriptRoot 'claude-falso.ps1') + '"'
$origem = New-RepoEnsaio -Exemplo (Join-Path $avaliador 'exemplo') -Destino (Join-Path $tmp 'origem')
$hash = Resolve-RefCommit -Repo $origem -Ref 'main'
$exec = Join-Path $tmp 'exec'
$co = New-CheckoutLimpo -Repo $origem -Hash $hash -Destino (Join-Path $exec 'repo')
$res = @{}
foreach ($caso in @(@('invalido', 'ux'), @('valido', 'documentacao'), @('fora', 'arquitetura'), @('vazio', 'codigo'))) {
    $env:CLAUDE_FALSO_MODO = $caso[0]
    $res[$caso[0]] = Invoke-RevisorEixo -Eixo $caso[1] -Produto 'teste' -Repo $origem -Ref 'main' -Hash $hash -Checkout $co.Caminho `
        -PastaExecucao $exec -PastaSaida $saida -RaizTcc $raizTcc -PastaAvaliador $avaliador -VersaoCli 'falso' -TempoLimiteMin 2
}
Remove-Item Env:\CLAUDE_FALSO_MODO
Confere 'bloco mal formado vira "a conferir"' ($res['invalido'].status -eq 'a conferir' -and ($res['invalido'].motivos -join ' ') -like '*bloco JSON inválido*')
Confere 'bloco mal formado: texto bruto guardado no .md' ((Read-TextoArquivo (Join-Path $saida 'teste-ux.md')) -like '*Review falso.*')
Confere 'o fluxo seguiu para os eixos seguintes' ((Test-Path (Join-Path $saida 'teste-documentacao.json')) -and (Test-Path (Join-Path $saida 'teste-codigo.json')))
Confere 'bloco válido lido (nota 3), mas "a conferir" sem transcrição que confirme modelo e esforço' ($res['valido'].nota -eq 3 -and $res['valido'].status -eq 'a conferir' -and ($res['valido'].motivos -join ' ') -like '*transcrição*')
Confere 'leitura fora das pastas liberadas acusada' (($res['fora'].motivos -join ' ') -like '*acessos fora*win.ini*')
Confere 'sessão sem saída vira "falhou"' ($res['vazio'].status -eq 'falhou')
$j = Read-TextoArquivo (Join-Path $saida 'teste-documentacao.json') | ConvertFrom-Json
$exigidos = @('modelo_pedido', 'modelo_usado', 'esforco_pedido', 'esforco_usado', 'versao_cli', 'hash_avaliado', 'hash_rubrica', 'hash_especificacao', 'inicio', 'fim', 'duracao_s', 'tentativa', 'status')
Confere 'o .json tem os campos exigidos' (@($exigidos | Where-Object { $j.PSObject.Properties.Name -notcontains $_ }).Count -eq 0)
Confere 'hash da rubrica no .json é o da rubrica atual' ($j.hash_rubrica -eq (Get-HashArquivo (Join-Path $raizTcc 'avaliacoes\rubrica.md')))

Remove-PastaSegura -Caminho $tmp
Write-Host ''
if ($falhas -eq 0) { Write-Host 'Etapa 2 (sem sessão): todos os critérios passaram.' } else { Write-Host "Etapa 2 (sem sessão): $falhas critério(s) falharam."; exit 1 }
