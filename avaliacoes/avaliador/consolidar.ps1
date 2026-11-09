<#
.SYNOPSIS
    Consolida as notas dos revisores e do autor em avaliacoes/notas.csv e
    avaliacoes/notas.md, com H1, H2, H3 e a hipótese exploratória.

.DESCRIPTION
    Lê avaliacoes/reviews/<produto>-<eixo>.json (revisor), avaliacoes/autor/<produto>.md
    (autor) e, como insumo, avaliacoes/reviews/<produto>-decisoes.json (revisor de
    decisões). As hipóteses usam a nota do autor (nota validada por humano, pré-registro
    §2) e as contagens de decisões do autor. O que ainda não tem dado fica "pendente".

    Em leigo e engenheiro, enquanto o formulário do autor não tiver as seis notas, nada do
    revisor desse produto aparece (nota, regras ausentes, decisões listadas): o autor
    pontua sem ver o revisor. Em leigo_pu e eng_pu (pré-registro, §7, alteração de
    09/11/2026), a nota do autor é a "Nota validada" do formulário, o revisor nunca fica
    oculto e a divergência sai "n/a (validada)". Não preenche a planilha .xlsx. Não
    escreve nota no terminal.

.PARAMETER PastaReviews
    Padrão: avaliacoes/reviews.

.PARAMETER PastaAutor
    Padrão: avaliacoes/autor.

.PARAMETER PastaSaida
    Onde gravar notas.csv e notas.md. Padrão: avaliacoes.
#>
[CmdletBinding()]
param(
    [string]$PastaReviews,
    [string]$PastaAutor,
    [string]$PastaSaida
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
. (Join-Path $PSScriptRoot 'lib\checkout.ps1')
. (Join-Path $PSScriptRoot 'lib\revisor.ps1')
. (Join-Path $PSScriptRoot 'lib\registro.ps1')
. (Join-Path $PSScriptRoot 'lib\consolidacao.ps1')

$raizTcc = (Get-Item -LiteralPath (Join-Path $PSScriptRoot '..\..')).FullName
if (-not $PastaReviews) { $PastaReviews = Join-Path $raizTcc 'avaliacoes\reviews' }
if (-not $PastaAutor) { $PastaAutor = Join-Path $raizTcc 'avaliacoes\autor' }
if (-not $PastaSaida) { $PastaSaida = Join-Path $raizTcc 'avaliacoes' }
New-Item -ItemType Directory -Force -Path $PastaSaida | Out-Null

$PEND = 'pendente'
$OCULTO = 'oculta (formulário do autor incompleto)'
$NA_VALIDADA = 'n/a (validada)'

# Coleta.
$forms = @{}; $revs = @{}; $notasAutor = @{}; $conjDec = @{}; $visivel = @{}
foreach ($p in $script:Produtos.Keys) {
    # leigo_pu e eng_pu: a nota do autor é a nota validada (pré-registro, §7).
    $forms[$p] = Read-FormularioAutor -Caminho (Join-Path $PastaAutor "$p.md") -Validada:(Test-ProdutoValidado $p)
    # O revisor só fica oculto nos produtos de nota cega, enquanto o formulário está incompleto.
    $visivel[$p] = $forms[$p].completo -or (Test-ProdutoValidado $p)
    $notasAutor[$p] = @{}
    foreach ($e in $script:Secoes.Keys) { $notasAutor[$p][$e] = $forms[$p].notas[$e] }
    $revs[$p] = @{}
    foreach ($e in $script:Secoes.Keys) { $revs[$p][$e] = Read-ReviewEixo -Pasta $PastaReviews -Produto $p -Eixo $e }
    $arqDec = Join-Path $PastaReviews "$p-decisoes.json"
    $conjDec[$p] = $null
    if (Test-Path -LiteralPath $arqDec) { $conjDec[$p] = Read-TextoArquivo $arqDec | ConvertFrom-Json }
}

# Nota do revisor como texto: número, status ("a conferir", "falhou"), pendente ou oculta.
function Get-TextoRevisor {
    param([string]$Produto, [string]$Eixo)
    if (-not $visivel[$Produto]) { return $OCULTO }
    $r = $revs[$Produto][$Eixo]
    if (-not $r.existe) { return $PEND }
    if ($r.status -ne 'ok') { return $r.status }
    return $r.nota
}
function Get-TextoAutor {
    param([string]$Produto, [string]$Eixo)
    $f = $forms[$Produto]
    if ($f.invalidas.Contains($Eixo)) { return 'inválida' }
    if ($null -eq $f.notas[$Eixo]) { return $PEND }
    return $f.notas[$Eixo]
}
function Get-NotaRevisorNumero {
    param([string]$Produto, [string]$Eixo)
    $t = Get-TextoRevisor -Produto $Produto -Eixo $Eixo
    if ($t -is [int]) { return $t }
    return $null
}
# Nos produtos de nota validada não há nota cega, e portanto não há divergência a medir.
function Get-TextoDivergencia {
    param([string]$Produto, [string]$Eixo)
    if (Test-ProdutoValidado $Produto) { return $NA_VALIDADA }
    return (Format-Divergencia -Autor $notasAutor[$Produto][$Eixo] -Revisor (Get-NotaRevisorNumero -Produto $Produto -Eixo $Eixo))
}

# CSV.
$linhasCsv = @()
foreach ($p in $script:Produtos.Keys) {
    foreach ($e in $script:Secoes.Keys) {
        $r = $revs[$p][$e]
        $regras = @()
        if ($visivel[$p]) { $regras += @($r.regras | ForEach-Object { "[revisor] $_" }) }
        $regras += @($forms[$p].regras[$e] | ForEach-Object { "[autor] $_" })
        $decisoes = if ($visivel[$p]) { ($r.decisoes -join ' | ') } else { $OCULTO }
        $linhasCsv += [pscustomobject][ordered]@{
            produto           = $p
            eixo              = $e
            nota_revisor      = Get-TextoRevisor -Produto $p -Eixo $e
            nota_autor        = Get-TextoAutor -Produto $p -Eixo $e
            divergencia       = Get-TextoDivergencia -Produto $p -Eixo $e
            regras_ausentes   = ($regras -join ' | ')
            decisoes_listadas = $decisoes
        }
    }
}
$csv = ($linhasCsv | ConvertTo-Csv -NoTypeInformation -Delimiter ';') -join "`r`n"
[System.IO.File]::WriteAllText((Join-Path $PastaSaida 'notas.csv'), $csv + "`r`n", (New-Object System.Text.UTF8Encoding($true)))

# MD.
function Cel { param($v) if ($null -eq $v) { return $PEND } return (Format-CelulaTabela $v) }
function Soma {
    param([string]$Produto, [string[]]$Eixos, [scriptblock]$Nota)
    $vals = @($Eixos | ForEach-Object { & $Nota $Produto $_ })
    if (@($vals | Where-Object { $_ -isnot [int] }).Count) { return $PEND }
    return [int](($vals | Measure-Object -Sum).Sum)
}
$notaA = { param($p, $e) $notasAutor[$p][$e] }
$notaR = { param($p, $e) Get-NotaRevisorNumero -Produto $p -Eixo $e }

$md = New-Object System.Collections.Generic.List[string]
$md.Add('# Notas consolidadas')
$md.Add('')
$md.Add("Gerado por ``avaliacoes/avaliador/consolidar.ps1`` em $((Get-Date).ToString('yyyy-MM-dd HH:mm')). Fontes:")
$md.Add('`avaliacoes/reviews/<produto>-<eixo>.json` (revisor) e `avaliacoes/autor/<produto>.md`')
$md.Add('(autor). As hipóteses usam a nota do autor, a nota validada por humano do pré-registro')
$md.Add('(§2). "pendente": ainda sem dado. Divergência: nota do autor menos a do revisor, com')
$md.Add('sinal; asterisco quando o módulo é 2 ou mais. Enquanto o formulário do autor de um')
$md.Add('produto de nota cega (leigo, engenheiro) não tem as seis notas, nada do revisor desse')
$md.Add('produto aparece. Em leigo_pu e eng_pu (pré-registro, §7, alteração de 09/11/2026), a')
$md.Add('nota do autor é a nota do revisor confirmada ou ajustada depois de ler o review: o')
$md.Add('revisor nunca fica oculto e a divergência é "n/a (validada)".')

$md.Add('')
$md.Add('## Notas por produto')
foreach ($p in $script:Produtos.Keys) {
    $md.Add('')
    $md.Add("### $p ($($script:Produtos[$p]))")
    $md.Add('')
    if (Test-ProdutoValidado $p) { $md.Add('Nota validada: a coluna Autor é a nota do revisor confirmada ou ajustada pelo autor.'); $md.Add('') }
    if (-not $forms[$p].existe) { $md.Add('Formulário do autor ainda não existe.'); $md.Add('') }
    elseif (@($forms[$p].problemas).Count) { $md.Add("Problemas no formulário do autor: $($forms[$p].problemas -join '; ').") ; $md.Add('') }
    $md.Add('| Eixo | Revisor | Autor | Divergência |')
    $md.Add('|---|---|---|---|')
    foreach ($e in $script:Secoes.Keys) {
        $md.Add("| $($script:Secoes[$e]) | $(Cel (Get-TextoRevisor -Produto $p -Eixo $e)) | $(Cel (Get-TextoAutor -Produto $p -Eixo $e)) | $(Get-TextoDivergencia -Produto $p -Eixo $e) |")
    }
    $revTot6 = if ($visivel[$p]) { Soma $p @($script:Secoes.Keys) $notaR } else { $OCULTO }
    $revTot5 = if ($visivel[$p]) { Soma $p $script:EixosHipoteses $notaR } else { $OCULTO }
    $md.Add("| Total dos seis eixos | $revTot6 | $(Soma $p @($script:Secoes.Keys) $notaA) | |")
    $md.Add("| Total dos cinco eixos de H1 e H2 | $revTot5 | $(Soma $p $script:EixosHipoteses $notaA) | |")
    if (@($forms[$p].explicacoes).Count) {
        $md.Add('')
        $md.Add('Explicações do autor para as divergências:')
        $md.Add('')
        foreach ($x in $forms[$p].explicacoes) { $md.Add("- $x") }
    }
    if (@($forms[$p].ajustes).Count) {
        $md.Add('')
        $md.Add('Ajustes do autor à nota do revisor:')
        $md.Add('')
        foreach ($x in $forms[$p].ajustes) { $md.Add("- $x") }
    }
}

$md.Add('')
$md.Add('## Matriz (nota do autor; em leigo_pu e eng_pu, a nota validada)')
$md.Add('')
$md.Add('| Eixo | ' + (($script:Produtos.Keys) -join ' | ') + ' |')
$md.Add('|---|---|---|---|---|')
foreach ($e in $script:Secoes.Keys) {
    $md.Add("| $($script:Secoes[$e]) | " + ((@($script:Produtos.Keys) | ForEach-Object { Cel $notasAutor[$_][$e] }) -join ' | ') + ' |')
}

$h1 = Get-H1 -Notas $notasAutor
$md.Add('')
$md.Add("## H1: $($h1.resultado)")
$md.Add('')
$md.Add('Com uma mensagem só em cada persona, o produto do engenheiro recebe nota maior que o do')
$md.Add('leigo nos cinco eixos. Regra do pré-registro: diferença de pelo menos 1 ponto, no')
$md.Add('sentido previsto (eng_pu acima de leigo_pu), em pelo menos 4 dos 5 eixos. A coluna da')
$md.Add('trilha iterativa mostra o sentido observado lá, para comparação.')
$md.Add('')
$md.Add('| Eixo | eng_pu | leigo_pu | eng_pu - leigo_pu | Atende (>= 1) | Iterativa (engenheiro - leigo) |')
$md.Add('|---|---|---|---|---|---|')
foreach ($l in $h1.linhas) {
    $at = if ($null -eq $l.atende) { $PEND } elseif ($l.atende) { 'sim' } else { 'não' }
    $dif = if ($null -eq $l.diferenca) { $PEND } else { Format-Sinal $l.diferenca }
    $it = if ($null -eq $l.iterativa) { $PEND } else { Format-Sinal $l.iterativa }
    $md.Add("| $($script:Secoes[$l.eixo]) | $(Cel $l.eng_pu) | $(Cel $l.leigo_pu) | $dif | $at | $it |")
}
$md.Add('')
if ($h1.resultado -eq 'pendente') { $md.Add("Resultado: pendente (faltam notas do autor em: $($h1.faltam -join ', ')).") }
else { $md.Add("Resultado: $($h1.resultado), $($h1.atende) de 5 eixos atendem.") }

$h2 = Get-H2 -Notas $notasAutor
$md.Add('')
$md.Add("## H2: $($h2.resultado)")
$md.Add('')
$md.Add('O prompt único do engenheiro não fica abaixo do produto final da trilha iterativa do')
$md.Add('leigo nos cinco eixos. Regra do pré-registro: apoiada se em nenhum dos cinco eixos o')
$md.Add('eng_pu ficar 1 ponto ou mais abaixo do leigo.')
$md.Add('')
$md.Add('| Eixo | eng_pu | leigo | eng_pu - leigo | 1 ponto ou mais abaixo |')
$md.Add('|---|---|---|---|---|')
foreach ($l in $h2.linhas) {
    $ab = if ($null -eq $l.abaixo) { $PEND } elseif ($l.abaixo) { 'sim' } else { 'não' }
    $dif = if ($null -eq $l.diferenca) { $PEND } else { Format-Sinal $l.diferenca }
    $md.Add("| $($script:Secoes[$l.eixo]) | $(Cel $l.eng_pu) | $(Cel $l.leigo) | $dif | $ab |")
}
$md.Add('')
if ($h2.resultado -eq 'pendente') { $md.Add("Resultado: pendente (faltam notas do autor em: $($h2.faltam -join ', ')).") }
else { $md.Add("Resultado: $($h2.resultado), $($h2.abaixo) eixo(s) com o eng_pu 1 ponto ou mais abaixo.") }

$decAutor = @{}; foreach ($p in $script:Produtos.Keys) { $decAutor[$p] = $forms[$p].decisoes_total }
$h3 = Get-H3 -Decisoes $decAutor
$md.Add('')
$md.Add("## H3: $($h3.resultado)")
$md.Add('')
$md.Add('O agente toma mais decisões sem perguntar no prompt único do leigo do que no do')
$md.Add('engenheiro, e a diferença é maior que nas trilhas iterativas. Contagens do autor')
$md.Add('(formulário, "Decisões sem perguntar", Total), lidas literalmente: apoiada se')
$md.Add('leigo_pu > eng_pu e (leigo_pu - eng_pu) > (leigo - engenheiro). O revisor de decisões')
$md.Add('entra só como insumo.')
$md.Add('')
$md.Add('| Produto | Decisões sem perguntar (autor) | Perguntas sem resposta (autor) | Revisor de decisões (insumo) |')
$md.Add('|---|---|---|---|')
foreach ($p in $script:Produtos.Keys) {
    $ins = 'sem revisor de decisões'
    $c = $conjDec[$p]
    if ($c) {
        if (-not $visivel[$p]) { $ins = $OCULTO }
        else {
            $ins = "$($c.totais.decisoes) decisões ($($c.totais.duvidosas) duvidosas), $($c.totais.perguntas) perguntas ($($c.totais.perguntas_respondidas) respondidas)"
            if ($c.status -ne 'ok') { $ins += ', INCOMPLETO (export a conferir)' }
        }
    }
    $md.Add("| $p | $(Cel $forms[$p].decisoes_total) | $(Cel $forms[$p].perguntas_total) | $ins |")
}
$md.Add('')
if ($h3.resultado -eq 'pendente') { $md.Add("Resultado: pendente (faltam contagens do autor em: $($h3.faltam -join ', ')).") }
else { $md.Add("Resultado: $($h3.resultado); leigo_pu - eng_pu = $(Format-Sinal $h3.dif_pu), leigo - engenheiro = $(Format-Sinal $h3.dif_iter).") }

$ex = Get-Exploratoria -Notas $notasAutor
$md.Add('')
$md.Add('## Exploratória')
$md.Add('')
$md.Add('Em cada eixo, a diferença entre personas dentro de uma mesma condição é maior que a')
$md.Add('diferença entre condições dentro de uma mesma persona. Leitura descritiva, sem regra')
$md.Add('no pré-registro: as quatro diferenças com sinal e a média dos módulos de cada par.')
$md.Add('')
$md.Add('| Eixo | Personas, iterativa (engenheiro - leigo) | Personas, prompt único (eng_pu - leigo_pu) | Condições, engenheiro (engenheiro - eng_pu) | Condições, leigo (leigo - leigo_pu) | Média personas | Média condições | Personas > condições |')
$md.Add('|---|---|---|---|---|---|---|---|')
foreach ($l in $ex) {
    if (-not $l.completo) { $md.Add("| $($script:Secoes[$l.eixo]) | $PEND | $PEND | $PEND | $PEND | $PEND | $PEND | $PEND |"); continue }
    $f = { param($x) ([double]$x).ToString('0.0', [System.Globalization.CultureInfo]::GetCultureInfo('pt-BR')) }
    $md.Add("| $($script:Secoes[$l.eixo]) | $(Format-Sinal $l.p_iter) | $(Format-Sinal $l.p_pu) | $(Format-Sinal $l.c_eng) | $(Format-Sinal $l.c_leigo) | $(& $f $l.media_p) | $(& $f $l.media_c) | $(if ($l.personas_maior) { 'sim' } else { 'não' }) |")
}

$md.Add('')
$md.Add('## Decisões do agente listadas pelos revisores dos eixos')
$md.Add('')
$md.Add('Juntadas dos seis reviews, por produto, sem deduplicar nem contar. Insumo para a')
$md.Add('contagem do autor, como a lista do revisor de decisões')
$md.Add('(`avaliacoes/reviews/<produto>-decisoes.md`).')
foreach ($p in $script:Produtos.Keys) {
    $md.Add('')
    $md.Add("### $p")
    $md.Add('')
    if (-not $visivel[$p]) { $md.Add("- $OCULTO"); continue }
    $algum = $false
    foreach ($e in $script:Secoes.Keys) {
        foreach ($d in $revs[$p][$e].decisoes) { $md.Add("- [$e] $d"); $algum = $true }
    }
    if (-not $algum) { $md.Add('- pendente (nenhum review com decisões listadas)') }
}
Write-TextoArquivo -Texto (($md -join "`n") + "`n") -Caminho (Join-Path $PastaSaida 'notas.md')

# Terminal: só caminhos e o estado de cada produto, sem notas.
Write-Host "Notas consolidadas em $(Join-Path $PastaSaida 'notas.csv') e notas.md"
foreach ($p in $script:Produtos.Keys) {
    $nr = @($script:Secoes.Keys | Where-Object { $revs[$p][$_].existe }).Count
    $estado = if (-not $forms[$p].existe) { 'formulário do autor ausente' } elseif ($forms[$p].completo) { 'formulário do autor completo' } else { 'formulário do autor incompleto' }
    Write-Host ("  {0,-11} reviews {1}/6; {2}" -f $p, $nr, $estado)
}
Write-Host "  H1 $($h1.resultado); H2 $($h2.resultado); H3 $($h3.resultado)"
