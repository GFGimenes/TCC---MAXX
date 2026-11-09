# Sobe o maxx-leigo a partir do checkout limpo, sem alterar o código dele.
#   - npm ci no checkout (precisa de rede; node_modules fica no clone temporário);
#   - banco e uploads em -Dados (MAXX_DADOS), fora do checkout, novos a cada execução;
#   - CODIGO_BANCA vazio (acesso da banca desligado), NODE_ENV fora de production;
#   - espera o produto responder em GET /entrar.
# Contrato: devolve @{ Base; Porta; ProcessoId; Ambiente }.
param(
    [Parameter(Mandatory)][string]$Checkout,
    [Parameter(Mandatory)][string]$Dados,
    [Parameter(Mandatory)][int]$Porta,
    [Parameter(Mandatory)][string]$Log
)
Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$INICIO_ESPERADO = 'node --disable-warning=ExperimentalWarning src/server.js'

# O comando de subida é o do próprio produto; se mudar, o adaptador precisa ser revisto.
$pacote = Get-Content -LiteralPath (Join-Path $Checkout 'package.json') -Raw -Encoding UTF8 | ConvertFrom-Json
if ($pacote.scripts.start -ne $INICIO_ESPERADO) {
    throw "O script start do produto mudou ('$($pacote.scripts.start)'); revise o adaptador do leigo."
}

function Invoke-Npm {
    param([string[]]$Argumentos)
    $saida = "$Log.npm.out"; $erro = "$Log.npm.err"
    $p = Start-Process -FilePath 'npm.cmd' -ArgumentList $Argumentos -WorkingDirectory $Checkout -Wait -PassThru -WindowStyle Hidden -RedirectStandardOutput $saida -RedirectStandardError $erro
    $texto = ((Get-Content -LiteralPath $saida -Raw -ErrorAction SilentlyContinue), (Get-Content -LiteralPath $erro -Raw -ErrorAction SilentlyContinue)) -join "`n"
    Add-Content -LiteralPath $Log -Value "> npm $($Argumentos -join ' ')`n$texto" -Encoding UTF8
    if ($p.ExitCode -ne 0) { throw "npm $($Argumentos -join ' ') falhou (código $($p.ExitCode)): $texto" }
    return $texto.Trim()
}

$versaoNpm = (Invoke-Npm @('--version')).Split("`n")[0].Trim()
Write-Host 'Instalando dependências do produto (npm ci) no checkout temporário...'
Invoke-Npm @('ci', '--no-audit', '--no-fund', '--loglevel=error') | Out-Null

# Ambiente do processo do produto: só para o filho; o da sessão é restaurado em seguida.
$variaveis = @{
    PORT              = "$Porta"
    MAXX_DADOS        = $Dados
    ADMIN_SENHA       = [guid]::NewGuid().ToString('N')
    NODE_ENV          = $null
    CODIGO_BANCA      = $null
    ADMIN_EMAIL       = $null
    WEBSITE_SITE_NAME = $null
}
$anteriores = @{}
foreach ($k in $variaveis.Keys) {
    $anteriores[$k] = [Environment]::GetEnvironmentVariable($k, 'Process')
    [Environment]::SetEnvironmentVariable($k, $variaveis[$k], 'Process')
}
try {
    $processo = Start-Process -FilePath 'node' -ArgumentList @('--disable-warning=ExperimentalWarning', 'src/server.js') `
        -WorkingDirectory $Checkout -PassThru -WindowStyle Hidden `
        -RedirectStandardOutput "$Log.out" -RedirectStandardError "$Log.err"
} finally {
    foreach ($k in $anteriores.Keys) { [Environment]::SetEnvironmentVariable($k, $anteriores[$k], 'Process') }
}

$base = "http://127.0.0.1:$Porta"
$limite = (Get-Date).AddSeconds(30)
$noAr = $false
while ((Get-Date) -lt $limite) {
    if ($processo.HasExited) { break }
    try {
        $r = Invoke-WebRequest -Uri "$base/entrar" -UseBasicParsing -TimeoutSec 2
        if ($r.StatusCode -eq 200) { $noAr = $true; break }
    } catch { }
    Start-Sleep -Milliseconds 300
}
$textoLog = ((Get-Content -LiteralPath "$Log.out" -Raw -ErrorAction SilentlyContinue), (Get-Content -LiteralPath "$Log.err" -Raw -ErrorAction SilentlyContinue)) -join "`n"
Add-Content -LiteralPath $Log -Value "> node src/server.js`n$textoLog" -Encoding UTF8
if (-not $noAr) {
    if (-not $processo.HasExited) { & taskkill.exe /PID $processo.Id /T /F | Out-Null }
    throw "O produto não respondeu em $base/entrar em 30 s."
}

$lock = Join-Path $Checkout 'package-lock.json'
return [pscustomobject]@{
    Base       = $base
    Porta      = $Porta
    ProcessoId = $processo.Id
    Ambiente   = [ordered]@{
        npm                    = $versaoNpm
        'package-lock sha256'  = (Get-FileHash -LiteralPath $lock -Algorithm SHA256).Hash.ToLower().Substring(0, 16)
        'comando do produto'   = $INICIO_ESPERADO
        'dados do produto'     = 'pasta temporária nova (MAXX_DADOS), banco SQLite vazio'
        'acesso da banca'      = 'desligado (CODIGO_BANCA vazio)'
    }
}
