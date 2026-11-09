# Suíte de testes de referência: checkout limpo do commit avaliado, sobe o produto,
# roda os casos e grava avaliacoes/reviews/<produto>-testes-referencia.md e .json.
#
#   .\avaliacoes\testes-referencia\rodar.ps1 -Produto leigo -Repo .\maxx-leigo -Ref main
#
# O repositório do produto é só lido: o estado dele é fotografado antes e depois, e se
# mudar nada é gravado. O produto roda num clone temporário, com dados temporários.

[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$Produto,
    [Parameter(Mandatory)][string]$Repo,
    [Parameter(Mandatory)][string]$Ref,
    [string]$Adaptador,
    [int]$Porta = 0,
    [string]$Saida,
    [switch]$Manter
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$aqui = Split-Path -Parent $MyInvocation.MyCommand.Path
$raizTcc = (Resolve-Path (Join-Path $aqui '..\..')).Path
. (Join-Path $raizTcc 'avaliacoes\avaliador\lib\checkout.ps1')

if (-not $Adaptador) { $Adaptador = $Produto }
$pastaAdaptador = Join-Path $aqui "adaptadores\$Adaptador"
if (-not (Test-Path -LiteralPath (Join-Path $pastaAdaptador 'subir.ps1'))) {
    throw "Adaptador '$Adaptador' não encontrado (ou sem subir.ps1) em $pastaAdaptador."
}
if (-not $Saida) { $Saida = Join-Path $raizTcc 'avaliacoes\reviews' }
$Saida = [System.IO.Path]::GetFullPath($Saida)
$repoCheio = (Resolve-Path -LiteralPath $Repo).Path

function Test-PortaLivre {
    param([int]$N)
    try {
        $l = New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Any, $N)
        $l.Start(); $l.Stop()
        $l6 = New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::IPv6Any, $N)
        $l6.Start(); $l6.Stop()
        return $true
    } catch { return $false }
}

function Get-Porta {
    param([int]$Pedida)
    if ($Pedida -gt 0) {
        if (-not (Test-PortaLivre $Pedida)) { throw "A porta $Pedida está ocupada." }
        return @{ Porta = $Pedida; Nota = 'porta pedida com -Porta' }
    }
    $ocupadas = @()
    for ($p = 3100; $p -lt 3200; $p++) {
        if (Test-PortaLivre $p) {
            $nota = if ($ocupadas.Count) { "portas ocupadas na máquina, puladas: $($ocupadas -join ', ')" } else { 'primeira porta livre a partir de 3100' }
            return @{ Porta = $p; Nota = $nota }
        }
        $ocupadas += $p
    }
    throw 'Nenhuma porta livre entre 3100 e 3199.'
}

function Write-Utf8 {
    param([string]$Caminho, [string]$Texto)
    [System.IO.File]::WriteAllText($Caminho, $Texto, (New-Object System.Text.UTF8Encoding($false)))
}

function Stop-ArvoreDeProcessos {
    param([int]$ProcessoId)
    if (Get-Process -Id $ProcessoId -ErrorAction SilentlyContinue) {
        & taskkill.exe /PID $ProcessoId /T /F | Out-Null
    }
}

# Derruba o produto: derrubar.ps1 do adaptador, se existir, e a árvore do processo.
function Stop-Produto {
    if (-not $script:produtoNoAr) { return }
    $derrubar = Join-Path $pastaAdaptador 'derrubar.ps1'
    if (Test-Path -LiteralPath $derrubar) { & $derrubar -Checkout $checkout -Dados $dados -Porta $script:produtoNoAr.Porta }
    if ($script:produtoNoAr.ProcessoId) { Stop-ArvoreDeProcessos $script:produtoNoAr.ProcessoId }
}

$inicio = Get-Date
$carimbo = $inicio.ToString('yyyyMMdd-HHmmss')
$temp = Join-Path (Get-PastaTemporaria) "testes-ref-$Produto-$carimbo"
$checkout = Join-Path $temp 'checkout'
$dados = Join-Path $temp 'dados'
$saidaTemp = Join-Path $temp 'saida'
$log = Join-Path $temp 'produto.log'
New-Item -ItemType Directory -Force -Path $dados, $saidaTemp | Out-Null

$produtoNoAr = $null
$codigoSaida = 0
try {
    # 1. Origem fotografada e checkout limpo do commit avaliado.
    $hash = Resolve-RefCommit -Repo $repoCheio -Ref $Ref
    $antes = Get-EstadoOrigem -Repo $repoCheio
    Write-Host "Produto $Produto, $Ref = $hash"
    New-CheckoutLimpo -Repo $repoCheio -Hash $hash -Destino $checkout | Out-Null

    $suite = (Invoke-Git -Dir $raizTcc -Argumentos @('rev-parse', '--short', 'HEAD') | Select-Object -First 1).Trim()
    $sujo = Invoke-Git -Dir $raizTcc -Argumentos @('status', '--porcelain', '--', 'avaliacoes/testes-referencia')
    if ($sujo) { $suite += ' (com alterações não commitadas na suíte)' }

    $node = (& node --version)
    $os = (Get-CimInstance Win32_OperatingSystem)
    $meta = [ordered]@{
        produto   = $Produto
        repo      = $Repo
        ref       = $Ref
        commit    = $hash
        data      = $inicio.ToString('yyyy-MM-dd HH:mm:ss zzz')
        suite     = $suite
        adaptador = $Adaptador
        ambiente  = [ordered]@{
            SO         = "$($os.Caption) $($os.Version)"
            PowerShell = $PSVersionTable.PSVersion.ToString()
            node       = $node
        }
    }

    # 2. Sobe o produto pelo adaptador.
    $escolhaPorta = Get-Porta $Porta
    $meta.porta = $escolhaPorta.Porta
    $meta.notaPorta = $escolhaPorta.Nota
    $falhaSubida = $null
    try {
        $produtoNoAr = & (Join-Path $pastaAdaptador 'subir.ps1') -Checkout $checkout -Dados $dados -Porta $escolhaPorta.Porta -Log $log
        foreach ($k in $produtoNoAr.Ambiente.Keys) { $meta.ambiente[$k] = $produtoNoAr.Ambiente[$k] }
        Write-Host "No ar em $($produtoNoAr.Base)"
    } catch {
        $falhaSubida = "$($_.Exception.Message)"
        if (Test-Path -LiteralPath $log) { $falhaSubida += "`n--- log do produto ---`n" + ((Get-Content -LiteralPath $log -Tail 40) -join "`n") }
        Write-Warning "O produto não subiu: $($_.Exception.Message)"
    }

    $arqMeta = Join-Path $temp 'meta.json'
    Write-Utf8 $arqMeta ($meta | ConvertTo-Json -Depth 5)
    $cli = Join-Path $aqui 'nucleo\cli.js'

    # 3. Casos.
    if ($falhaSubida) {
        $arqFalha = Join-Path $temp 'falha-subida.txt'
        Write-Utf8 $arqFalha $falhaSubida
        & node $cli --adaptador $pastaAdaptador --meta $arqMeta --saida $saidaTemp --falha-subida $arqFalha
    } else {
        & node $cli --adaptador $pastaAdaptador --base $produtoNoAr.Base --meta $arqMeta --saida $saidaTemp
    }
    if ($LASTEXITCODE -ne 0) { throw "A suíte terminou com erro (código $LASTEXITCODE). Nada foi gravado." }

    # 4. Derruba o produto antes de conferir a origem.
    Stop-Produto
    $produtoNoAr = $null

    # 5. Origem conferida; só então a saída é copiada para o lugar definitivo.
    $depois = Get-EstadoOrigem -Repo $repoCheio
    $mudou = @(Compare-EstadoOrigem -Antes $antes -Depois $depois)
    if ($mudou.Count) { throw "O repositório de origem mudou durante a execução ($($mudou -join ', ')). Nada foi gravado." }

    New-Item -ItemType Directory -Force -Path $Saida | Out-Null
    foreach ($ext in 'md', 'json') {
        Copy-Item -LiteralPath (Join-Path $saidaTemp "$Produto-testes-referencia.$ext") -Destination (Join-Path $Saida "$Produto-testes-referencia.$ext") -Force
    }
    Write-Host "Gravado em $(Join-Path $Saida "$Produto-testes-referencia.md") e .json"
    if ($falhaSubida) { $codigoSaida = 3 }
} catch {
    Write-Host "ERRO: $($_.Exception.Message)" -ForegroundColor Red
    $codigoSaida = 1
} finally {
    if ($produtoNoAr) { try { Stop-Produto } catch { Write-Warning "Falha ao derrubar o produto: $($_.Exception.Message)" } }
    if ($Manter) {
        Write-Host "Pasta temporária mantida: $temp"
    } elseif (Test-Path -LiteralPath $temp) {
        Start-Sleep -Milliseconds 300
        Remove-PastaSegura -Caminho $temp
    }
}
exit $codigoSaida
