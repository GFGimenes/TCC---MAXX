<#
.SYNOPSIS
    Avaliador do experimento do TCC: aplica a rubrica (avaliacoes/rubrica.md) a um
    produto inteiro, com um revisor de IA independente por eixo.

.DESCRIPTION
    Faz o checkout limpo da Ref numa pasta temporária, confere que o repositório de origem
    não foi modificado e roda, em sequência, uma sessão nova e isolada do Claude Code por
    eixo (claude -p, só leitura). Grava avaliacoes/reviews/<produto>-<eixo>.md e .json.

    Estado atual (etapa 2): sessões por eixo. Registro da execução, formulário do autor e
    modo -SemClaude entram na etapa 3.

.PARAMETER Produto
    leigo, engenheiro, leigo_pu ou eng_pu.

.PARAMETER Repo
    Caminho do repositório do produto. Só é lido, nunca modificado.

.PARAMETER Ref
    Branch ou commit a avaliar (main nas trilhas e nos repositórios do prompt único).

.PARAMETER Eixos
    Eixos a rodar, na ordem dada. Padrão: os seis. No ensaio, um só (padrão documentacao).

.PARAMETER TempoLimiteMin
    Tempo limite de cada sessão de revisor, em minutos. Padrão: 60.

.PARAMETER Ensaio
    Usa um repositório de exemplo criado a partir de avaliacoes/avaliador/exemplo/ numa
    pasta temporária e grava em avaliacoes/avaliador/ensaio/saida/. Dispensa Produto,
    Repo e Ref.

.PARAMETER Manter
    Não apaga as pastas temporárias no fim (para inspeção).

.PARAMETER SomenteCheckout
    Para depois do checkout e da conferência da origem, sem sessão de revisor. Usado pelo
    teste da etapa 1.
#>
[CmdletBinding()]
param(
    [ValidateSet('leigo', 'engenheiro', 'leigo_pu', 'eng_pu')]
    [string]$Produto,
    [string]$Repo,
    [string]$Ref,
    [ValidateSet('ux', 'seguranca', 'infra', 'documentacao', 'codigo', 'arquitetura')]
    [string[]]$Eixos,
    [ValidateRange(1, 600)]
    [int]$TempoLimiteMin = 60,
    [switch]$Ensaio,
    [switch]$Manter,
    [switch]$SomenteCheckout
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
. (Join-Path $PSScriptRoot 'lib\checkout.ps1')
. (Join-Path $PSScriptRoot 'lib\revisor.ps1')

$pastaAvaliador = $PSScriptRoot
$raizTcc = (Get-Item -LiteralPath (Join-Path $pastaAvaliador '..\..')).FullName
$carimbo = Get-Date -Format 'yyyyMMdd-HHmmss'
$temporaria = Get-PastaTemporaria

if ($Ensaio) {
    if ($Produto -or $Repo -or $Ref) {
        throw 'No modo de ensaio não se passa Produto, Repo nem Ref: o repositório é o exemplo.'
    }
    if (-not $Eixos) { $Eixos = @('documentacao') }
    if (@($Eixos).Count -ne 1) { throw 'O ensaio roda um eixo só.' }
    $nomeProduto = 'ensaio'
    $pastaSaida = Join-Path $pastaAvaliador 'ensaio\saida'
    $Repo = New-RepoEnsaio -Exemplo (Join-Path $pastaAvaliador 'exemplo') -Destino (Join-Path $temporaria "ensaio-origem-$carimbo")
    $Ref = 'main'
    Write-Host "Ensaio: repositório de exemplo criado em $Repo"
} else {
    if (-not $Produto -or -not $Repo -or -not $Ref) {
        throw 'Informe Produto, Repo e Ref (ou use -Ensaio).'
    }
    if (-not $Eixos) { $Eixos = @($script:Secoes.Keys) }
    $nomeProduto = $Produto
    $pastaSaida = Join-Path $raizTcc 'avaliacoes\reviews'
    $Repo = (Get-Item -LiteralPath $Repo).FullName
}
New-Item -ItemType Directory -Force -Path $pastaSaida | Out-Null

$versaoCli = ((& claude --version) | Select-Object -First 1).Trim()
Write-Host "Claude Code $versaoCli; modelo $script:ModeloFixado; esforço $script:EsforcoFixado"

$estadoAntes = Get-EstadoOrigem -Repo $Repo
$hash = Resolve-RefCommit -Repo $Repo -Ref $Ref
Write-Host "Ref '$Ref' resolvida para $hash"

$pastaExecucao = Join-Path $temporaria "$nomeProduto-$($hash.Substring(0, 12))-$carimbo"
$checkout = New-CheckoutLimpo -Repo $Repo -Hash $hash -Destino (Join-Path $pastaExecucao 'repo')
Write-Host "Checkout limpo em $($checkout.Caminho)"

$estadoDepois = Get-EstadoOrigem -Repo $Repo
$diferencas = @(Compare-EstadoOrigem -Antes $estadoAntes -Depois $estadoDepois)
if ($diferencas.Count -gt 0) {
    throw "PARADA: o repositório de origem mudou durante o checkout ($($diferencas -join ', ')). Nada foi avaliado."
}
Write-Host "Origem inalterada (estado $($estadoAntes.Hash.Substring(0, 12)) antes e depois)"

$resultados = @()
if ($SomenteCheckout) { $Eixos = @() }
foreach ($eixo in $Eixos) {
    try {
        $resultados += Invoke-RevisorEixo -Eixo $eixo -Produto $nomeProduto -Repo $Repo -Ref $Ref -Hash $hash `
            -Checkout $checkout.Caminho -PastaExecucao $pastaExecucao -PastaSaida $pastaSaida -RaizTcc $raizTcc `
            -PastaAvaliador $pastaAvaliador -VersaoCli $versaoCli -TempoLimiteMin $TempoLimiteMin
    } catch {
        Write-Warning "[$eixo] erro do avaliador, eixo marcado como falhou: $($_.Exception.Message)"
        $resultados += [pscustomobject]@{ eixo = $eixo; status = 'falhou'; motivos = @("erro do avaliador: $($_.Exception.Message)"); nota = $null }
    }
}

# O checkout não pode ter sido alterado pelos revisores, nem a origem.
$statusCheckout = Invoke-Git -Dir $checkout.Caminho -Argumentos @('status', '--porcelain=v1', '--untracked-files=all')
if ($statusCheckout) { Write-Warning "O checkout foi alterado durante as sessões: $($statusCheckout -join '; ')" }
$estadoFinal = Get-EstadoOrigem -Repo $Repo
if (@(Compare-EstadoOrigem -Antes $estadoAntes -Depois $estadoFinal).Count -gt 0) { Write-Warning 'O repositório de origem mudou durante a avaliação.' }

Write-Host ''
Write-Host "Resumo ($nomeProduto, $hash):"
foreach ($r in $resultados) {
    $nota = '-'
    if ($null -ne $r.nota) { $nota = $r.nota }
    Write-Host ("  {0,-13} {1,-11} nota {2}" -f $r.eixo, $r.status, $nota)
}
Write-Host "Saída em $pastaSaida"

if ($Manter) {
    $extra = ''
    if ($Ensaio) { $extra = " e $Repo" }
    Write-Host "Pastas mantidas para inspeção: $pastaExecucao$extra"
} else {
    Remove-PastaSegura -Caminho $pastaExecucao
    if ($Ensaio) { Remove-PastaSegura -Caminho $Repo }
    Write-Host 'Pastas temporárias apagadas.'
}

return [pscustomobject]@{
    produto           = $nomeProduto
    repo              = $Repo
    ref               = $Ref
    hash_avaliado     = $hash
    checkout          = $checkout.Caminho
    pasta_saida       = $pastaSaida
    checkout_alterado = [bool]$statusCheckout
    resultados        = $resultados
}
