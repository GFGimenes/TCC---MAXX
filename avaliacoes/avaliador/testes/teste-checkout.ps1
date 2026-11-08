# Teste da etapa 1 (checkout limpo). Só usa o repositório de exemplo, em pasta
# temporária. Uso: powershell -ExecutionPolicy Bypass -File testes\teste-checkout.ps1

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
$avaliador = Split-Path -Parent $PSScriptRoot
. (Join-Path $avaliador 'lib\checkout.ps1')

$falhas = 0
function Confere {
    param([string]$Descricao, [bool]$Condicao)
    if ($Condicao) { Write-Host "  ok     $Descricao" }
    else { Write-Host "  FALHOU $Descricao"; $script:falhas++ }
}

Write-Host '1. Ensaio ponta a ponta com -Manter'
$r = & (Join-Path $avaliador 'avaliar.ps1') -Ensaio -Manter -SomenteCheckout
$co = $r.checkout
$origem = $r.repo
Confere 'hash avaliado igual ao HEAD da main da origem' ($r.hash_avaliado -eq (Resolve-RefCommit -Repo $origem -Ref 'main'))
Confere 'arquivo não rastreado da origem ausente no checkout' (-not (Test-Path (Join-Path $co 'nao-commitado.txt')))
Confere 'alteração não commitada da origem ausente no checkout' (-not (Select-String -Path (Join-Path $co 'README.md') -Pattern 'MARCA-NAO-COMMITADA' -Quiet))
Confere 'arquivo de outra branch ausente no checkout' (-not (Test-Path (Join-Path $co 'segredo-de-outra-branch.txt')))
$hashOutra = Resolve-RefCommit -Repo $origem -Ref 'outra-branch'
Invoke-Git -Dir $co -Argumentos @('cat-file', '-e', $hashOutra) -PermitirFalha 2>$null | Out-Null
Confere 'commit da outra branch inexistente no .git do checkout' ($LASTEXITCODE -ne 0)
Confere 'checkout sem remoto' (-not (Invoke-Git -Dir $co -Argumentos @('remote')))
Confere 'checkout sem refs além do HEAD' (-not (Invoke-Git -Dir $co -Argumentos @('for-each-ref')))
Confere 'origem ainda tem o arquivo não rastreado' (Test-Path (Join-Path $origem 'nao-commitado.txt'))
Confere 'origem ainda tem a alteração não commitada' (Select-String -Path (Join-Path $origem 'README.md') -Pattern 'MARCA-NAO-COMMITADA' -Quiet)
Confere 'origem ainda tem a outra branch' ([bool](Invoke-Git -Dir $origem -Argumentos @('rev-parse', '--verify', '--quiet', 'outra-branch') -PermitirFalha))
Confere 'origem sem worktree extra' (@(Invoke-Git -Dir $origem -Argumentos @('worktree', 'list')).Count -eq 1)

Write-Host '2. Ref passada como hash de commit'
$antes = Get-EstadoOrigem -Repo $origem
$destino = Join-Path (Get-PastaTemporaria) ("teste-hash-" + (Get-Date -Format 'yyyyMMdd-HHmmss'))
$co2 = New-CheckoutLimpo -Repo $origem -Hash $hashOutra -Destino (Join-Path $destino 'repo')
Confere 'checkout por hash tem o arquivo daquele commit' (Test-Path (Join-Path $co2.Caminho 'segredo-de-outra-branch.txt'))
$depois = Get-EstadoOrigem -Repo $origem
Confere 'estado da origem idêntico antes e depois' (@(Compare-EstadoOrigem -Antes $antes -Depois $depois).Count -eq 0)

Write-Host '2b. Contraprova: a fotografia acusa mudança na origem'
Invoke-Git -Dir $origem -Argumentos @('branch', 'mudanca-proposital') | Out-Null
$mudado = Get-EstadoOrigem -Repo $origem
Confere 'branch nova na origem aparece como diferença em refs' ((@(Compare-EstadoOrigem -Antes $depois -Depois $mudado)) -contains 'refs')
Add-Content -LiteralPath (Join-Path $origem 'package.json') -Value ' '
$mudado2 = Get-EstadoOrigem -Repo $origem
Confere 'arquivo rastreado alterado na origem aparece como diferença em status' ((@(Compare-EstadoOrigem -Antes $mudado -Depois $mudado2)) -contains 'status')

Write-Host '3. Ref inexistente'
$erro = $null
try { Resolve-RefCommit -Repo $origem -Ref 'nao-existe' | Out-Null } catch { $erro = $_.Exception.Message }
Confere 'Ref inexistente interrompe com mensagem clara' ($erro -like "*não existe*")

Write-Host '4. Ensaio sem -Manter apaga as pastas temporárias'
$antesPastas = @(Get-ChildItem (Get-PastaTemporaria) -Directory).Count
& (Join-Path $avaliador 'avaliar.ps1') -Ensaio -SomenteCheckout | Out-Null
$depoisPastas = @(Get-ChildItem (Get-PastaTemporaria) -Directory).Count
Confere 'nenhuma pasta temporária sobra' ($antesPastas -eq $depoisPastas)

Remove-PastaSegura -Caminho $destino
Remove-PastaSegura -Caminho (Split-Path -Parent $co)
Remove-PastaSegura -Caminho $origem

Write-Host ''
if ($falhas -eq 0) { Write-Host 'Etapa 1: todos os critérios passaram.' } else { Write-Host "Etapa 1: $falhas critério(s) falharam."; exit 1 }
