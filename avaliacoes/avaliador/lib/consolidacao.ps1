# Leitura dos reviews e dos formulários do autor, e regras das hipóteses, para o
# consolidar.ps1. Depende de lib/revisor.ps1 (eixos, leitura de arquivos).

Set-StrictMode -Version 2.0

$script:Produtos = [ordered]@{
    leigo      = 'leigo, trilha iterativa'
    engenheiro = 'engenheiro, trilha iterativa'
    leigo_pu   = 'leigo, prompt único'
    eng_pu     = 'engenheiro, prompt único'
}
# Os cinco eixos de H1 e H2 (pré-registro, §2): UX fica de fora.
$script:EixosHipoteses = @('seguranca', 'infra', 'documentacao', 'codigo', 'arquitetura')

# Formulário do autor (gerado por New-FormularioAutor). Uma nota só vale se a linha
# "Nota (1 a 5):" tiver um inteiro de 1 a 5 e nada mais.
function Read-FormularioAutor {
    param([Parameter(Mandatory)][string]$Caminho)
    $r = [ordered]@{
        existe = $false; notas = [ordered]@{}; invalidas = [ordered]@{}; regras = [ordered]@{}
        decisoes_total = $null; perguntas_total = $null; explicacoes = @(); completo = $false; problemas = @()
    }
    foreach ($e in $script:Secoes.Keys) { $r.notas[$e] = $null; $r.regras[$e] = @() }
    if (-not (Test-Path -LiteralPath $Caminho)) { return [pscustomobject]$r }
    $r.existe = $true
    $porTitulo = @{}
    foreach ($e in $script:Secoes.Keys) { $porTitulo[$script:Secoes[$e]] = $e }
    $secao = $null; $modo = $null
    foreach ($linha in ((Read-TextoArquivo $Caminho) -split "`n" | ForEach-Object { $_.TrimEnd("`r") })) {
        if ($linha -match '^##\s+(.+?)\s*$') {
            $titulo = $Matches[1]; $modo = $null
            if ($porTitulo.ContainsKey($titulo)) { $secao = $porTitulo[$titulo] }
            elseif ($titulo -eq 'Decisões sem perguntar') { $secao = '#decisoes' }
            elseif ($titulo -eq 'Perguntas sem resposta') { $secao = '#perguntas' }
            elseif ($titulo -eq 'Depois de abrir os reviews') { $secao = '#depois' }
            else { $secao = $null }
            continue
        }
        if (-not $secao) { continue }
        if ($secao -like '#*') {
            if ($linha -match '^Total:\s*(.*?)\s*$' -and $secao -ne '#depois') {
                $v = $Matches[1]
                $campo = if ($secao -eq '#decisoes') { 'decisoes_total' } else { 'perguntas_total' }
                if ($v -match '^\d+$') { $r[$campo] = [int]$v }
                elseif ($v) { $r.problemas += "total de $($secao.TrimStart('#')) não é um inteiro: '$v'" }
            }
            if ($secao -eq '#depois' -and $linha -match '^-\s+(\S.*)$') { $r.explicacoes += $Matches[1].Trim() }
            continue
        }
        if ($linha -match '^Nota \(1 a 5\):\s*(.*?)\s*$') {
            $v = $Matches[1]
            if ($v -match '^[1-5]$') { $r.notas[$secao] = [int]$v }
            elseif ($v) { $r.invalidas[$secao] = $v; $r.problemas += "nota de $secao inválida: '$v'" }
            continue
        }
        if ($linha -match '^Regras ausentes:') { $modo = 'regras'; continue }
        if ($linha -match '^Observações objetivas:') { $modo = 'obs'; continue }
        if ($modo -eq 'regras' -and $linha -match '^-\s+(\S.*)$') { $r.regras[$secao] += $Matches[1].Trim() }
    }
    $r.completo = (@($script:Secoes.Keys | Where-Object { $null -eq $r.notas[$_] }).Count -eq 0)
    return [pscustomobject]$r
}

function Read-ReviewEixo {
    param([Parameter(Mandatory)][string]$Pasta, [Parameter(Mandatory)][string]$Produto, [Parameter(Mandatory)][string]$Eixo)
    $arq = Join-Path $Pasta "$Produto-$Eixo.json"
    if (-not (Test-Path -LiteralPath $arq)) { return [pscustomobject]@{ existe = $false; status = $null; nota = $null; regras = @(); decisoes = @() } }
    $j = Read-TextoArquivo $arq | ConvertFrom-Json
    return [pscustomobject]@{
        existe   = $true
        status   = [string](Get-Propriedade $j 'status')
        nota     = Get-Propriedade $j 'nota'
        regras   = @(Get-Propriedade $j 'regras_ausentes' | Where-Object { $null -ne $_ } | ForEach-Object { [string]$_ })
        decisoes = @(Get-Propriedade $j 'decisoes_do_agente' | Where-Object { $null -ne $_ } | ForEach-Object { [string]$_ })
    }
}

# Divergência: autor menos revisor, com sinal; asterisco quando o módulo é 2 ou mais.
function Format-Divergencia {
    param($Autor, $Revisor)
    if ($Autor -isnot [int] -or $Revisor -isnot [int]) { return 'pendente' }
    $d = $Autor - $Revisor
    $t = if ($d -gt 0) { "+$d" } else { "$d" }
    if ([Math]::Abs($d) -ge 2) { $t += '*' }
    return $t
}

function Format-Sinal {
    param([int]$Valor)
    if ($Valor -gt 0) { return "+$Valor" }
    return "$Valor"
}

# H1: eng_pu - leigo_pu >= 1 em pelo menos 4 dos 5 eixos. Pendente se faltar nota do autor.
function Get-H1 {
    param([Parameter(Mandatory)][hashtable]$Notas)
    $linhas = @(); $atende = 0; $faltam = @()
    foreach ($e in $script:EixosHipoteses) {
        $a = $Notas['eng_pu'][$e]; $b = $Notas['leigo_pu'][$e]
        $ia = $Notas['engenheiro'][$e]; $ib = $Notas['leigo'][$e]
        $dif = $null; $ok = $null; $difIter = $null
        if ($a -is [int] -and $b -is [int]) { $dif = $a - $b; $ok = ($dif -ge 1); if ($ok) { $atende++ } } else { $faltam += $e }
        if ($ia -is [int] -and $ib -is [int]) { $difIter = $ia - $ib }
        $linhas += [pscustomobject]@{ eixo = $e; eng_pu = $a; leigo_pu = $b; diferenca = $dif; atende = $ok; iterativa = $difIter }
    }
    $res = if ($faltam.Count) { 'pendente' } elseif ($atende -ge 4) { 'apoiada' } else { 'não apoiada' }
    return [pscustomobject]@{ resultado = $res; atende = $atende; faltam = $faltam; linhas = $linhas }
}

# H2: em nenhum dos 5 eixos eng_pu fica 1 ponto ou mais abaixo do leigo iterativo.
function Get-H2 {
    param([Parameter(Mandatory)][hashtable]$Notas)
    $linhas = @(); $abaixo = 0; $faltam = @()
    foreach ($e in $script:EixosHipoteses) {
        $a = $Notas['eng_pu'][$e]; $b = $Notas['leigo'][$e]
        $dif = $null; $ab = $null
        if ($a -is [int] -and $b -is [int]) { $dif = $a - $b; $ab = ($dif -le -1); if ($ab) { $abaixo++ } } else { $faltam += $e }
        $linhas += [pscustomobject]@{ eixo = $e; eng_pu = $a; leigo = $b; diferenca = $dif; abaixo = $ab }
    }
    $res = if ($faltam.Count) { 'pendente' } elseif ($abaixo -eq 0) { 'apoiada' } else { 'não apoiada' }
    return [pscustomobject]@{ resultado = $res; abaixo = $abaixo; faltam = $faltam; linhas = $linhas }
}

# H3, leitura literal de §3.1.5.1: leigo_pu > eng_pu e (leigo_pu - eng_pu) > (leigo - engenheiro),
# com as contagens do autor.
function Get-H3 {
    param([Parameter(Mandatory)][hashtable]$Decisoes)
    $faltam = @($script:Produtos.Keys | Where-Object { $Decisoes[$_] -isnot [int] })
    if ($faltam.Count) { return [pscustomobject]@{ resultado = 'pendente'; faltam = $faltam; dif_pu = $null; dif_iter = $null } }
    $dpu = $Decisoes['leigo_pu'] - $Decisoes['eng_pu']
    $dit = $Decisoes['leigo'] - $Decisoes['engenheiro']
    $res = if ($dpu -gt 0 -and $dpu -gt $dit) { 'apoiada' } else { 'não apoiada' }
    return [pscustomobject]@{ resultado = $res; faltam = @(); dif_pu = $dpu; dif_iter = $dit }
}

# Exploratória, descritiva: por eixo, as duas diferenças entre personas (eng - leigo em
# cada condição) e as duas entre condições (iterativa - prompt único em cada persona), em
# módulo, e a comparação das médias.
function Get-Exploratoria {
    param([Parameter(Mandatory)][hashtable]$Notas)
    $linhas = @()
    foreach ($e in $script:Secoes.Keys) {
        $n = @{}; foreach ($p in $script:Produtos.Keys) { $n[$p] = $Notas[$p][$e] }
        if (@($n.Values | Where-Object { $_ -isnot [int] }).Count) {
            $linhas += [pscustomobject]@{ eixo = $e; completo = $false; p_iter = $null; p_pu = $null; c_eng = $null; c_leigo = $null; media_p = $null; media_c = $null; personas_maior = $null }
            continue
        }
        $pi = $n['engenheiro'] - $n['leigo']; $pp = $n['eng_pu'] - $n['leigo_pu']
        $ce = $n['engenheiro'] - $n['eng_pu']; $cl = $n['leigo'] - $n['leigo_pu']
        $mp = ([Math]::Abs($pi) + [Math]::Abs($pp)) / 2; $mc = ([Math]::Abs($ce) + [Math]::Abs($cl)) / 2
        $linhas += [pscustomobject]@{ eixo = $e; completo = $true; p_iter = $pi; p_pu = $pp; c_eng = $ce; c_leigo = $cl; media_p = $mp; media_c = $mc; personas_maior = ($mp -gt $mc) }
    }
    return $linhas
}
