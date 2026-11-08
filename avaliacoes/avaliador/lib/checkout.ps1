# Funções de checkout do avaliador.
#
# Regra central: o repositório de origem nunca é modificado. Por isso:
# - não se usa git worktree (grava metadados no .git da origem);
# - toda leitura da origem roda com GIT_OPTIONAL_LOCKS=0 (o git status não reescreve o
#   índice) e sem fsmonitor;
# - o estado da origem é fotografado antes e depois, e qualquer diferença interrompe a
#   avaliação.

Set-StrictMode -Version 2.0

function Invoke-Git {
    param(
        [Parameter(Mandatory)][string]$Dir,
        [Parameter(Mandatory)][string[]]$Argumentos,
        [switch]$PermitirFalha
    )
    $anterior = $env:GIT_OPTIONAL_LOCKS
    $env:GIT_OPTIONAL_LOCKS = '0'
    try {
        $saida = & git -c core.fsmonitor=false -c gc.auto=0 -C $Dir @Argumentos
        $codigo = $LASTEXITCODE
    } finally {
        $env:GIT_OPTIONAL_LOCKS = $anterior
    }
    if ($codigo -ne 0 -and -not $PermitirFalha) {
        throw "git falhou (código $codigo) em '$Dir': git $($Argumentos -join ' ')"
    }
    return $saida
}

function Get-HashTexto {
    param([AllowEmptyString()][string]$Texto)
    $sha = [System.Security.Cryptography.SHA256]::Create()
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Texto)
    return ([System.BitConverter]::ToString($sha.ComputeHash($bytes)) -replace '-', '').ToLower()
}

function Get-HashArquivo {
    param([Parameter(Mandatory)][string]$Caminho)
    if (-not (Test-Path -LiteralPath $Caminho)) { return 'inexistente' }
    return (Get-FileHash -LiteralPath $Caminho -Algorithm SHA256).Hash.ToLower()
}

# Fotografia do estado da origem: HEAD, refs, worktrees, status, objetos, e o conteúdo
# do índice e da configuração. Só leitura.
function Get-EstadoOrigem {
    param([Parameter(Mandatory)][string]$Repo)
    $gitDir = (Invoke-Git -Dir $Repo -Argumentos @('rev-parse', '--absolute-git-dir')) | Select-Object -First 1
    $partes = [ordered]@{
        head      = (Get-Content -LiteralPath (Join-Path $gitDir 'HEAD') -Raw)
        refs      = ((Invoke-Git -Dir $Repo -Argumentos @('for-each-ref', '--format=%(refname) %(objectname)')) -join "`n")
        worktrees = ((Invoke-Git -Dir $Repo -Argumentos @('worktree', 'list', '--porcelain')) -join "`n")
        status    = ((Invoke-Git -Dir $Repo -Argumentos @('status', '--porcelain=v1', '--untracked-files=all', '--ignored')) -join "`n")
        objetos   = ((Invoke-Git -Dir $Repo -Argumentos @('count-objects', '-v')) -join "`n")
        indice    = (Get-HashArquivo (Join-Path $gitDir 'index'))
        config    = (Get-HashArquivo (Join-Path $gitDir 'config'))
    }
    $texto = ($partes.GetEnumerator() | ForEach-Object { "## $($_.Key)`n$($_.Value)" }) -join "`n"
    return [pscustomobject]@{
        GitDir = $gitDir
        Partes = $partes
        Hash   = (Get-HashTexto $texto)
    }
}

function Compare-EstadoOrigem {
    param([Parameter(Mandatory)]$Antes, [Parameter(Mandatory)]$Depois)
    $diferencas = @()
    foreach ($chave in $Antes.Partes.Keys) {
        if ($Antes.Partes[$chave] -ne $Depois.Partes[$chave]) { $diferencas += $chave }
    }
    return $diferencas
}

function Resolve-RefCommit {
    param([Parameter(Mandatory)][string]$Repo, [Parameter(Mandatory)][string]$Ref)
    $hash = Invoke-Git -Dir $Repo -Argumentos @('rev-parse', '--verify', '--quiet', "$Ref^{commit}") -PermitirFalha
    if (-not $hash) {
        throw "A Ref '$Ref' não existe em '$Repo'."
    }
    return ($hash | Select-Object -First 1).Trim()
}

# Clone local com cópia dos objetos (sem hardlink), checkout destacado no commit avaliado,
# sem remoto, sem outras branches e sem objetos inalcançáveis. O resultado contém só o
# que foi commitado até o commit avaliado.
function New-CheckoutLimpo {
    param(
        [Parameter(Mandatory)][string]$Repo,
        [Parameter(Mandatory)][string]$Hash,
        [Parameter(Mandatory)][string]$Destino
    )
    if (Test-Path -LiteralPath $Destino) { throw "O destino do checkout já existe: $Destino" }
    $pai = Split-Path -Parent $Destino
    New-Item -ItemType Directory -Force -Path $pai | Out-Null

    Invoke-Git -Dir $pai -Argumentos @('clone', '--quiet', '--no-hardlinks', '--no-checkout', '--no-tags', $Repo, $Destino) | Out-Null
    Invoke-Git -Dir $Destino -Argumentos @('checkout', '--quiet', '--detach', $Hash) | Out-Null

    $branches = Invoke-Git -Dir $Destino -Argumentos @('for-each-ref', '--format=%(refname:short)', 'refs/heads')
    foreach ($b in @($branches)) {
        if ($b) { Invoke-Git -Dir $Destino -Argumentos @('branch', '--quiet', '-D', $b) | Out-Null }
    }
    Invoke-Git -Dir $Destino -Argumentos @('remote', 'remove', 'origin') | Out-Null
    Invoke-Git -Dir $Destino -Argumentos @('reflog', 'expire', '--expire=now', '--all') | Out-Null
    Invoke-Git -Dir $Destino -Argumentos @('gc', '--quiet', '--prune=now') | Out-Null

    # Conferências do próprio checkout.
    $head = ((Invoke-Git -Dir $Destino -Argumentos @('rev-parse', 'HEAD')) | Select-Object -First 1).Trim()
    if ($head -ne $Hash) { throw "Checkout em $head, esperado $Hash." }
    $refs = Invoke-Git -Dir $Destino -Argumentos @('for-each-ref')
    if ($refs) { throw "O checkout ainda tem refs além do HEAD: $($refs -join '; ')" }
    $remotos = Invoke-Git -Dir $Destino -Argumentos @('remote')
    if ($remotos) { throw "O checkout ainda tem remoto: $($remotos -join ', ')" }
    $status = Invoke-Git -Dir $Destino -Argumentos @('status', '--porcelain=v1', '--untracked-files=all')
    if ($status) { throw "O checkout não está limpo: $($status -join '; ')" }

    return [pscustomobject]@{
        Caminho = $Destino
        Hash    = $Hash
    }
}

# Repositório git temporário criado a partir de avaliacoes/avaliador/exemplo/, para o
# modo de ensaio. Recebe de propósito três coisas que o revisor nunca pode ver: um
# arquivo não rastreado, uma alteração não commitada num arquivo rastreado e um commit
# numa outra branch.
function New-RepoEnsaio {
    param(
        [Parameter(Mandatory)][string]$Exemplo,
        [Parameter(Mandatory)][string]$Destino
    )
    if (Test-Path -LiteralPath $Destino) { throw "O destino do repositório de ensaio já existe: $Destino" }
    New-Item -ItemType Directory -Force -Path $Destino | Out-Null
    Copy-Item -Path (Join-Path $Exemplo '*') -Destination $Destino -Recurse -Force

    Invoke-Git -Dir $Destino -Argumentos @('init', '--quiet', '--initial-branch=main') | Out-Null
    Invoke-Git -Dir $Destino -Argumentos @('config', 'user.name', 'ensaio do avaliador') | Out-Null
    Invoke-Git -Dir $Destino -Argumentos @('config', 'user.email', 'ensaio@exemplo.invalid') | Out-Null
    Invoke-Git -Dir $Destino -Argumentos @('config', 'core.autocrlf', 'false') | Out-Null
    Invoke-Git -Dir $Destino -Argumentos @('add', '--all') | Out-Null
    Invoke-Git -Dir $Destino -Argumentos @('commit', '--quiet', '-m', 'exemplo do ensaio') | Out-Null

    Invoke-Git -Dir $Destino -Argumentos @('checkout', '--quiet', '-b', 'outra-branch') | Out-Null
    Set-Content -LiteralPath (Join-Path $Destino 'segredo-de-outra-branch.txt') -Value 'MARCA-OUTRA-BRANCH' -Encoding UTF8
    Invoke-Git -Dir $Destino -Argumentos @('add', '--all') | Out-Null
    Invoke-Git -Dir $Destino -Argumentos @('commit', '--quiet', '-m', 'commit que o revisor não pode ver') | Out-Null
    Invoke-Git -Dir $Destino -Argumentos @('checkout', '--quiet', 'main') | Out-Null

    Set-Content -LiteralPath (Join-Path $Destino 'nao-commitado.txt') -Value 'MARCA-NAO-RASTREADO' -Encoding UTF8
    Add-Content -LiteralPath (Join-Path $Destino 'README.md') -Value 'MARCA-NAO-COMMITADA' -Encoding UTF8

    return $Destino
}

function Get-PastaTemporaria {
    $base = (Get-Item -LiteralPath ([System.IO.Path]::GetTempPath())).FullName
    return (Join-Path $base 'avaliador-tcc')
}

function Remove-PastaSegura {
    param([Parameter(Mandatory)][string]$Caminho)
    $raiz = Get-PastaTemporaria
    $cheio = (Get-Item -LiteralPath $Caminho).FullName
    if (-not $cheio.StartsWith($raiz, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Recusado: só apago pastas dentro de $raiz (pedido: $cheio)."
    }
    # O git marca objetos como somente leitura; tira o atributo antes de apagar.
    Get-ChildItem -LiteralPath $cheio -Recurse -Force -File | ForEach-Object { $_.Attributes = 'Normal' }
    Remove-Item -LiteralPath $cheio -Recurse -Force
}
