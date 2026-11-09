<#
.SYNOPSIS
    Avaliador do experimento do TCC: aplica a rubrica (avaliacoes/rubrica.md) a um
    produto inteiro, com um revisor de IA independente por eixo.

.DESCRIPTION
    Faz o checkout limpo da Ref numa pasta temporária, confere que o repositório de origem
    não foi modificado e roda, em sequência, uma sessão nova e isolada do Claude Code por
    eixo (claude -p, só leitura). Grava avaliacoes/reviews/<produto>-<eixo>.md e .json,
    acrescenta a execução em avaliacoes/reviews/<produto>-registro.md e cria, se ainda não
    existir, o formulário em branco do autor em avaliacoes/autor/<produto>.md.

    Nas avaliações reais de leigo e engenheiro a nota dos revisores não aparece no terminal
    nem no registro: o autor pontua antes de ver. Em leigo_pu e eng_pu não há nota cega
    (pré-registro, §7, alteração de 09/11/2026): a nota aparece no terminal e no registro,
    e o formulário do autor traz, por eixo, a nota do revisor (preenchida a partir do .json)
    para o autor validar ou ajustar depois de ler o review.

.PARAMETER Produto
    leigo, engenheiro, leigo_pu ou eng_pu.

.PARAMETER Repo
    Caminho do repositório do produto. Só é lido, nunca modificado.

.PARAMETER Ref
    Branch ou commit a avaliar (main nas trilhas e nos repositórios do prompt único).

.PARAMETER Eixos
    Eixos a rodar, na ordem dada. Padrão: os seis (mais decisoes, se houver -Export).
    "decisoes" é o revisor de decisões, que roda uma vez por export. No ensaio com
    sessão, um só (padrão documentacao).

.PARAMETER Export
    Um ou mais exports de sessão do agente construtor (.txt, em geral
    resultados/<trilha>/<id>-sessao.txt), lidos e nunca modificados. Cada um ganha uma
    sessão do revisor de decisões e os arquivos <produto>-decisoes-<id>.md e .json; o
    conjunto vai para <produto>-decisoes.md e .json. No ensaio, o padrão é o export
    fictício ensaio/ensaio-sessao.txt.

.PARAMETER TempoLimiteMin
    Tempo limite de cada sessão de revisor, em minutos. Padrão: 60.

.PARAMETER Ensaio
    Usa um repositório de exemplo criado a partir de avaliacoes/avaliador/exemplo/ numa
    pasta temporária e grava em avaliacoes/avaliador/ensaio/saida/ (formulário em
    ensaio/saida/autor/). Dispensa Produto, Repo e Ref.

.PARAMETER SemClaude
    Faz o checkout, monta as pastas de sessão, os encaixes e os prompts, grava os prompts,
    o registro e o formulário, e não chama o modelo. A saída vai para a subpasta
    sem-claude/ da pasta de saída, sem tocar nos reviews. Com -Ensaio, padrão os seis eixos.

.PARAMETER Manter
    Não apaga as pastas temporárias no fim (para inspeção).

.PARAMETER SomenteCheckout
    Para depois do checkout e da conferência da origem, sem sessão, sem registro e sem
    formulário. Usado pelo teste da etapa 1.
#>
[CmdletBinding()]
param(
    [ValidateSet('leigo', 'engenheiro', 'leigo_pu', 'eng_pu')]
    [string]$Produto,
    [string]$Repo,
    [string]$Ref,
    [ValidateSet('ux', 'seguranca', 'infra', 'documentacao', 'codigo', 'arquitetura', 'decisoes')]
    [string[]]$Eixos,
    [string[]]$Export,
    [ValidateRange(1, 600)]
    [int]$TempoLimiteMin = 60,
    [switch]$Ensaio,
    [switch]$SemClaude,
    [switch]$Manter,
    [switch]$SomenteCheckout
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
. (Join-Path $PSScriptRoot 'lib\checkout.ps1')
. (Join-Path $PSScriptRoot 'lib\revisor.ps1')
. (Join-Path $PSScriptRoot 'lib\registro.ps1')
. (Join-Path $PSScriptRoot 'lib\decisoes.ps1')

$pastaAvaliador = $PSScriptRoot
$raizTcc = (Get-Item -LiteralPath (Join-Path $pastaAvaliador '..\..')).FullName
$inicioExecucao = Get-Date
# Sufixo aleatório: duas execuções no mesmo segundo não disputam a mesma pasta temporária.
$carimbo = $inicioExecucao.ToString('yyyyMMdd-HHmmss') + '-' + ('{0:x4}' -f (Get-Random -Maximum 65536))
$temporaria = Get-PastaTemporaria

if ($Ensaio) {
    if ($Produto -or $Repo -or $Ref) {
        throw 'No modo de ensaio não se passa Produto, Repo nem Ref: o repositório é o exemplo.'
    }
    if (-not $Eixos) {
        if ($SemClaude) { $Eixos = @($script:Secoes.Keys) } else { $Eixos = @('documentacao') }
    }
    if (-not $SemClaude -and @($Eixos).Count -ne 1) { throw 'O ensaio com sessão roda um eixo só.' }
    $nomeProduto = 'ensaio'
    $pastaSaida = Join-Path $pastaAvaliador 'ensaio\saida'
    $pastaReviews = $pastaSaida
    $formulario = Join-Path $pastaSaida 'autor\ensaio.md'
} else {
    if (-not $Produto -or -not $Repo -or -not $Ref) {
        throw 'Informe Produto, Repo e Ref (ou use -Ensaio).'
    }
    if (-not $Eixos) {
        $Eixos = @($script:Secoes.Keys)
        if ($Export) { $Eixos += 'decisoes' }
    }
    $nomeProduto = $Produto
    $pastaSaida = Join-Path $raizTcc 'avaliacoes\reviews'
    $pastaReviews = $pastaSaida
    $formulario = Join-Path $raizTcc "avaliacoes\autor\$Produto.md"
    $Repo = (Get-Item -LiteralPath $Repo).FullName
}
if ($Eixos -contains 'decisoes') {
    if (-not $Export) {
        if ($Ensaio) { $Export = @(Join-Path $pastaAvaliador 'ensaio\ensaio-sessao.txt') }
        else { throw 'O revisor de decisões precisa de -Export com o(s) export(s) da sessão.' }
    }
} elseif ($Export) { throw 'Com -Export, inclua decisoes em -Eixos (ou omita -Eixos).' }
$Export = @($Export | Where-Object { $_ } | ForEach-Object {
    if (-not (Test-Path -LiteralPath $_ -PathType Leaf)) { throw "Export não encontrado: $_" }
    if ([System.IO.Path]::GetExtension($_) -ne '.txt') { throw "O export deve ser um .txt: $_" }
    (Get-Item -LiteralPath $_).FullName
})
$ids = @($Export | ForEach-Object { Get-IdExport -Caminho $_ })
if (@($ids | Select-Object -Unique).Count -ne $ids.Count) { throw "Dois exports com o mesmo identificador: $($ids -join ', ')" }
if ($SemClaude) { $pastaSaida = Join-Path $pastaSaida 'sem-claude' }
# leigo_pu e eng_pu: nota validada, sem nota cega. O ensaio segue o modo de sempre.
$validada = (-not $Ensaio) -and (Test-ProdutoValidado $nomeProduto)
# Só depois de validados os parâmetros: o repositório de ensaio nasce numa pasta temporária.
if ($Ensaio) {
    $Repo = New-RepoEnsaio -Exemplo (Join-Path $pastaAvaliador 'exemplo') -Destino (Join-Path $temporaria "ensaio-origem-$carimbo")
    $Ref = 'main'
    Write-Host "Ensaio: repositório de exemplo criado em $Repo"
}
New-Item -ItemType Directory -Force -Path $pastaSaida | Out-Null

try { $versaoCli = ((& claude --version) | Select-Object -First 1).Trim() }
catch {
    if (-not $SemClaude) { throw "Não foi possível consultar a versão do Claude Code: $($_.Exception.Message)" }
    $versaoCli = 'não consultada'
}
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
$avisos = @()
if ($SomenteCheckout) { $Eixos = @() }
foreach ($eixo in $Eixos) {
    if ($eixo -eq 'decisoes') {
        foreach ($exp in $Export) {
            try {
                $resultados += Invoke-RevisorDecisoes -Export $exp -Produto $nomeProduto -Hash $hash -Ref $Ref `
                    -PastaExecucao $pastaExecucao -PastaSaida $pastaSaida -RaizTcc $raizTcc -PastaAvaliador $pastaAvaliador `
                    -VersaoCli $versaoCli -TempoLimiteMin $TempoLimiteMin -SemClaude:$SemClaude
            } catch {
                $rot = "decisoes ($(Get-IdExport -Caminho $exp))"
                Write-Warning "[$rot] erro do avaliador, marcado como falhou: $($_.Exception.Message)"
                $resultados += [pscustomobject]@{ eixo = 'decisoes'; rotulo = $rot; status = 'falhou'; motivos = @("erro do avaliador: $($_.Exception.Message)") }
            }
        }
        if (-not $SemClaude) {
            $conjunto = Update-DecisoesProduto -PastaSaida $pastaSaida -Produto $nomeProduto
            if ($conjunto) { Write-Host "Decisões do produto: $(Join-Path $pastaSaida "$nomeProduto-decisoes.md") ($($conjunto.status))" }
        }
        continue
    }
    try {
        $r = Invoke-RevisorEixo -Eixo $eixo -Produto $nomeProduto -Repo $Repo -Ref $Ref -Hash $hash `
            -Checkout $checkout.Caminho -PastaExecucao $pastaExecucao -PastaSaida $pastaSaida -RaizTcc $raizTcc `
            -PastaAvaliador $pastaAvaliador -VersaoCli $versaoCli -TempoLimiteMin $TempoLimiteMin `
            -SemClaude:$SemClaude -OcultarNota:(-not $Ensaio -and -not $validada)
        if ($r.encaixe.aviso) { $avisos += "[$eixo] $($r.encaixe.aviso)" }
        $resultados += $r
    } catch {
        Write-Warning "[$eixo] erro do avaliador, eixo marcado como falhou: $($_.Exception.Message)"
        $resultados += [pscustomobject]@{ eixo = $eixo; status = 'falhou'; motivos = @("erro do avaliador: $($_.Exception.Message)") }
    }
}

# O checkout não pode ter sido alterado pelos revisores, nem a origem.
$statusCheckout = Invoke-Git -Dir $checkout.Caminho -Argumentos @('status', '--porcelain=v1', '--untracked-files=all')
if ($statusCheckout) { Write-Warning "O checkout foi alterado durante as sessões: $($statusCheckout -join '; ')" }
$estadoFinal = Get-EstadoOrigem -Repo $Repo
$origemInalterada = (@(Compare-EstadoOrigem -Antes $estadoAntes -Depois $estadoFinal).Count -eq 0)
if (-not $origemInalterada) { Write-Warning 'O repositório de origem mudou durante a avaliação.' }

$caminhoRegistro = $null
$formularioCriado = $null
if (-not $SomenteCheckout) {
    $modo = 'avaliação'
    if ($Ensaio) { $modo = 'ensaio' }
    if ($SemClaude) { $modo += ', sem claude (só prompts; nenhuma sessão aberta)' }
    $caminhoRegistro = Join-Path $pastaSaida "$nomeProduto-registro.md"
    $hashes = @{
        'avaliacoes/rubrica.md'        = (Get-HashArquivo (Join-Path $raizTcc 'avaliacoes\rubrica.md'))
        'docs/especificacao-telas.md'  = (Get-HashArquivo (Join-Path $raizTcc 'docs\especificacao-telas.md'))
        'avaliador/prompts/revisor.md' = (Get-HashArquivo (Join-Path $pastaAvaliador 'prompts\revisor.md'))
    }
    if ($Eixos -contains 'decisoes') {
        $hashes['avaliador/prompts/decisoes.md'] = Get-HashArquivo (Join-Path $pastaAvaliador 'prompts\decisoes.md')
        foreach ($exp in $Export) { $hashes["export $(Split-Path -Leaf $exp)"] = Get-HashArquivo $exp }
    }
    Add-RegistroExecucao -Caminho $caminhoRegistro -Produto $nomeProduto -Modo $modo -Repo $Repo -Ref $Ref -Hash $hash `
        -Inicio $inicioExecucao -Fim (Get-Date) -VersaoCli $versaoCli -TempoLimiteMin $TempoLimiteMin `
        -EstadoOrigem $estadoAntes.Hash -OrigemInalterada $origemInalterada -CheckoutInalterado (-not $statusCheckout) `
        -Hashes $hashes -Resultados $resultados -Avisos $avisos -MostrarNota:$validada
    Write-Host "Registro: $caminhoRegistro"

    $formularioCriado = New-FormularioAutor -Caminho $formulario -Produto $nomeProduto -Hash $hash -Ref $Ref -Validada:$validada
    if ($validada) {
        # Notas do revisor a partir dos reviews de verdade (no -SemClaude também: o formulário é o real).
        $avisosForm = @(Set-NotasRevisorFormulario -Caminho $formulario -PastaReviews $pastaReviews -Produto $nomeProduto)
        foreach ($a in $avisosForm) { Write-Warning $a }
        $avisos += $avisosForm
        if ($formularioCriado) { Write-Host "Formulário do autor criado, com as notas do revisor: $formulario" }
        else { Write-Host "Formulário do autor já existia; só as notas do revisor ainda sem número foram preenchidas: $formulario" }
    } elseif ($formularioCriado) { Write-Host "Formulário do autor criado em branco: $formulario" }
    else { Write-Host "Formulário do autor já existia e não foi tocado: $formulario" }
}

Write-Host ''
Write-Host "Resumo ($nomeProduto, $hash):"
foreach ($r in $resultados) {
    $nomeLinha = $r.eixo
    if ($r.PSObject.Properties['rotulo'] -and $r.rotulo) { $nomeLinha = $r.rotulo }
    $linha = "  {0,-13} {1,-11}" -f $nomeLinha, $r.status
    if (($Ensaio -or $validada) -and $r.PSObject.Properties['nota'] -and $null -ne $r.nota) { $linha += " nota $($r.nota)" }
    Write-Host $linha
}
foreach ($a in $avisos) { Write-Host "  Aviso: $a" }
if (-not $Ensaio -and -not $SemClaude -and @($resultados).Count) {
    if ($validada) { Write-Host '  Prompt único, sem nota cega: leia cada review e valide ou ajuste a nota no formulário do autor.' }
    else { Write-Host '  Notas omitidas: preencha o formulário do autor antes de abrir os reviews.' }
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
    registro          = $caminhoRegistro
    formulario        = $formulario
    formulario_criado = $formularioCriado
    nota_validada     = $validada
    checkout_alterado = [bool]$statusCheckout
    avisos            = $avisos
    resultados        = @($resultados | ForEach-Object {
        $rot = $_.eixo
        if ($_.PSObject.Properties['rotulo'] -and $_.rotulo) { $rot = $_.rotulo }
        [pscustomobject]@{ eixo = $_.eixo; rotulo = $rot; status = $_.status; motivos = @($_.motivos) }
    })
}
