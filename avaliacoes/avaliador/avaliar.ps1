<#
.SYNOPSIS
    Avaliador do experimento do TCC: aplica a rubrica (avaliacoes/rubrica.md) a um
    produto inteiro, com um revisor de IA independente por eixo.

.DESCRIPTION
    Estado atual (etapa 1): faz o checkout limpo da Ref numa pasta temporária, registra o
    hash avaliado e confere que o repositório de origem não foi modificado. As sessões dos
    revisores entram nas etapas seguintes.

.PARAMETER Produto
    leigo, engenheiro, leigo_pu ou eng_pu.

.PARAMETER Repo
    Caminho do repositório do produto. Só é lido, nunca modificado.

.PARAMETER Ref
    Branch ou commit a avaliar (main nas trilhas; a branch da condição no prompt único).

.PARAMETER Ensaio
    Usa um repositório de exemplo criado a partir de avaliacoes/avaliador/exemplo/ numa
    pasta temporária. Dispensa Produto, Repo e Ref.

.PARAMETER Manter
    Não apaga as pastas temporárias no fim (para inspeção).
#>
[CmdletBinding()]
param(
    [ValidateSet('leigo', 'engenheiro', 'leigo_pu', 'eng_pu')]
    [string]$Produto,
    [string]$Repo,
    [string]$Ref,
    [switch]$Ensaio,
    [switch]$Manter
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
. (Join-Path $PSScriptRoot 'lib\checkout.ps1')

$pastaAvaliador = $PSScriptRoot
$carimbo = Get-Date -Format 'yyyyMMdd-HHmmss'
$temporaria = Get-PastaTemporaria

if ($Ensaio) {
    if ($Produto -or $Repo -or $Ref) {
        throw 'No modo de ensaio não se passa Produto, Repo nem Ref: o repositório é o exemplo.'
    }
    $nomeProduto = 'ensaio'
    $Repo = New-RepoEnsaio -Exemplo (Join-Path $pastaAvaliador 'exemplo') -Destino (Join-Path $temporaria "ensaio-origem-$carimbo")
    $Ref = 'main'
    Write-Host "Ensaio: repositório de exemplo criado em $Repo"
} else {
    if (-not $Produto -or -not $Repo -or -not $Ref) {
        throw 'Informe Produto, Repo e Ref (ou use -Ensaio).'
    }
    $nomeProduto = $Produto
    $Repo = (Get-Item -LiteralPath $Repo).FullName
}

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

$resultado = [pscustomobject]@{
    produto            = $nomeProduto
    repo               = $Repo
    ref                = $Ref
    hash_avaliado      = $hash
    checkout           = $checkout.Caminho
    estado_origem_hash = $estadoAntes.Hash
    origem_inalterada  = $true
}

Write-Host 'Etapa 1: só o checkout está implementado; as sessões dos revisores entram nas etapas 2 e 3.'

if ($Manter) {
    Write-Host "Pastas mantidas para inspeção: $pastaExecucao$(if ($Ensaio) { " e $Repo" })"
} else {
    Remove-PastaSegura -Caminho $pastaExecucao
    if ($Ensaio) { Remove-PastaSegura -Caminho $Repo }
    Write-Host 'Pastas temporárias apagadas.'
}

return $resultado
