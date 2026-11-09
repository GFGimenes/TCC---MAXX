# Ensaio do rodar.ps1 com o produto falso, sem produto real:
#   powershell -ExecutionPolicy Bypass -File avaliacoes\testes-referencia\testes\ensaio-rodar.ps1
#
# Confere: grava .md e .json com o commit da origem; a origem fica idêntica; a pasta
# temporária é apagada; produto que não sobe gera o relatório de "não subiu"; origem
# alterada durante a execução aborta sem gravar.

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$aqui = Split-Path -Parent $MyInvocation.MyCommand.Path
$suite = Split-Path -Parent $aqui
$raizTcc = (Resolve-Path (Join-Path $suite '..\..')).Path
. (Join-Path $raizTcc 'avaliacoes\avaliador\lib\checkout.ps1')
$rodar = Join-Path $suite 'rodar.ps1'

$falhas = 0
function Confere {
    param([string]$Nome, [bool]$Ok, [string]$Detalhe = '')
    if ($Ok) { Write-Host "  ok     $Nome" }
    else { Write-Host "  FALHA  $Nome $Detalhe" -ForegroundColor Red; $script:falhas++ }
}

function Get-PastasDaSuite { @(Get-ChildItem -LiteralPath (Get-PastaTemporaria) -Directory -Filter 'testes-ref-falso-*' -ErrorAction SilentlyContinue) }

$base = Join-Path (Get-PastaTemporaria) ("ensaio-testes-ref-" + (Get-Date).ToString('yyyyMMdd-HHmmss'))
$repo = New-RepoEnsaio -Exemplo (Join-Path $raizTcc 'avaliacoes\avaliador\exemplo') -Destino (Join-Path $base 'repo')
$saida = Join-Path $base 'saida'
$hash = (Invoke-Git -Dir $repo -Argumentos @('rev-parse', 'main') | Select-Object -First 1).Trim()
$pastasAntes = @(Get-PastasDaSuite).Count

try {
    Write-Host 'Ensaio 1: execução normal'
    $antes = Get-EstadoOrigem -Repo $repo
    & powershell -NoProfile -ExecutionPolicy Bypass -File $rodar -Produto falso -Repo $repo -Ref main -Saida $saida
    Confere 'saída 0' ($LASTEXITCODE -eq 0) "código $LASTEXITCODE"
    $md = Join-Path $saida 'falso-testes-referencia.md'
    $json = Join-Path $saida 'falso-testes-referencia.json'
    Confere '.md e .json gravados' ((Test-Path $md) -and (Test-Path $json))
    if (Test-Path $json) {
        $j = Get-Content -LiteralPath $json -Raw -Encoding UTF8 | ConvertFrom-Json
        Confere 'commit avaliado no .json' ($j.commit -eq $hash) "$($j.commit) <> $hash"
        Confere '46 casos, todos passaram' (($j.resultado.linhas.Count -eq 46) -and ($j.resultado.resumo.passou -eq 46)) "$($j.resultado.resumo | ConvertTo-Json -Compress)"
        Confere 'ambiente registrado' ([bool]$j.ambiente.node -and [bool]$j.ambiente.SO -and [bool]$j.porta)
        Confere '.md com o commit' ((Get-Content -LiteralPath $md -Raw -Encoding UTF8) -match [regex]::Escape($hash))
    }
    $mudou = @(Compare-EstadoOrigem -Antes $antes -Depois (Get-EstadoOrigem -Repo $repo))
    Confere 'origem idêntica' ($mudou.Count -eq 0) ($mudou -join ', ')
    Confere 'pasta temporária apagada' (@(Get-PastasDaSuite).Count -eq $pastasAntes)

    Write-Host 'Ensaio 2: produto que não sobe'
    Remove-Item -LiteralPath $md, $json -Force -ErrorAction SilentlyContinue
    $env:TESTES_REF_FALSO_FALHAR = '1'
    & powershell -NoProfile -ExecutionPolicy Bypass -File $rodar -Produto falso -Repo $repo -Ref main -Saida $saida
    $codigo = $LASTEXITCODE
    $env:TESTES_REF_FALSO_FALHAR = $null
    Confere 'saída 3 (não subiu)' ($codigo -eq 3) "código $codigo"
    Confere 'relatório de "não subiu" com o log' ((Test-Path $md) -and ((Get-Content -LiteralPath $md -Raw -Encoding UTF8) -match 'O produto não subiu[\s\S]*EADDRINUSE'))
    Confere 'pasta temporária apagada' (@(Get-PastasDaSuite).Count -eq $pastasAntes)

    Write-Host 'Ensaio 3: origem alterada durante a execução'
    Remove-Item -LiteralPath $md, $json -Force -ErrorAction SilentlyContinue
    $env:TESTES_REF_FALSO_MEXER_NA_ORIGEM = $repo
    & powershell -NoProfile -ExecutionPolicy Bypass -File $rodar -Produto falso -Repo $repo -Ref main -Saida $saida
    $codigo = $LASTEXITCODE
    $env:TESTES_REF_FALSO_MEXER_NA_ORIGEM = $null
    Confere 'saída 1 (abortado)' ($codigo -eq 1) "código $codigo"
    Confere 'nada gravado' (-not (Test-Path $md) -and -not (Test-Path $json))
    Confere 'pasta temporária apagada' (@(Get-PastasDaSuite).Count -eq $pastasAntes)
} finally {
    $env:TESTES_REF_FALSO_FALHAR = $null
    $env:TESTES_REF_FALSO_MEXER_NA_ORIGEM = $null
    Remove-PastaSegura -Caminho $base
}

if ($falhas) { Write-Host "Ensaio do rodar.ps1: $falhas falha(s)." -ForegroundColor Red; exit 1 }
Write-Host 'Ensaio do rodar.ps1: tudo ok.'
