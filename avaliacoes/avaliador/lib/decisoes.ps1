# Revisor de decisões: uma sessão por export de sessão do agente construtor. Lista as
# decisões tomadas sem perguntar e as perguntas feitas. Não é eixo e não dá nota.
# Depende de lib/checkout.ps1, lib/revisor.ps1 e lib/registro.ps1 (tipos de decisão).

Set-StrictMode -Version 2.0

$script:CamposDecisoes = @('decisoes', 'perguntas', 'contagem')
$script:CamposContagem = @('decisoes', 'declaradas', 'silenciosas', 'duvidosas', 'perguntas', 'perguntas_respondidas')

# Identificador do export: nome do arquivo sem extensão e sem o sufixo -sessao.
function Get-IdExport {
    param([Parameter(Mandatory)][string]$Caminho)
    $nome = [System.IO.Path]::GetFileNameWithoutExtension($Caminho)
    return ($nome -replace '-sessao$', '')
}

# Linhas do arquivo como a ferramenta Read as numera: separadas por \n, sem o \r final,
# e sem a linha vazia depois da última quebra.
function Get-LinhasArquivo {
    param([Parameter(Mandatory)][string]$Caminho)
    $texto = [System.IO.File]::ReadAllText($Caminho, (New-Object System.Text.UTF8Encoding($false))).TrimStart([char]0xFEFF)
    $linhas = @($texto -split "`n" | ForEach-Object { $_.TrimEnd("`r") })
    if ($linhas.Count -gt 0 -and $linhas[$linhas.Count - 1] -eq '' -and $texto.EndsWith("`n")) { $linhas = @($linhas[0..($linhas.Count - 2)]) }
    return , $linhas
}

# Confere, linha a linha, se o revisor recebeu o arquivo inteiro pelas leituras (Read)
# registradas no stream. Uma linha conta como lida só se o texto devolvido pela ferramenta
# for igual ao do arquivo (linha truncada não conta).
function Get-CoberturaLeitura {
    param(
        [Parameter(Mandatory)][string]$Arquivo,
        [Parameter(Mandatory)][AllowEmptyCollection()][object[]]$Leituras
    )
    $esperadas = Get-LinhasArquivo -Caminho $Arquivo
    $total = $esperadas.Count
    $lidas = New-Object 'bool[]' ($total + 1)
    $alvo = [System.IO.Path]::GetFullPath($Arquivo)
    $chamadas = 0
    foreach ($l in $Leituras) {
        if (-not $l.PSObject.Properties['filePath']) { continue }
        $caminho = $l.filePath
        try { $caminho = [System.IO.Path]::GetFullPath(($caminho -replace '/', '\')) } catch { }
        if (-not $caminho.Equals($alvo, [System.StringComparison]::OrdinalIgnoreCase)) { continue }
        $chamadas++
        $inicio = [int]$l.startLine
        $conteudo = @(([string]$l.content) -split "`n" | ForEach-Object { $_.TrimEnd("`r") })
        for ($i = 0; $i -lt $conteudo.Count; $i++) {
            $n = $inicio + $i
            if ($n -ge 1 -and $n -le $total -and $conteudo[$i] -eq $esperadas[$n - 1]) { $lidas[$n] = $true }
        }
    }
    $faltando = @()
    $n = 1
    while ($n -le $total) {
        if ($lidas[$n]) { $n++; continue }
        $a = $n
        while ($n -le $total -and -not $lidas[$n]) { $n++ }
        if ($a -eq $n - 1) { $faltando += "$a" } else { $faltando += "$a-$($n - 1)" }
    }
    $cobertas = @(1..([Math]::Max($total, 1)) | Where-Object { $_ -le $total -and $lidas[$_] }).Count
    return [pscustomobject]@{ total = $total; lidas = $cobertas; chamadas = $chamadas; faltando = $faltando; completa = ($total -gt 0 -and $cobertas -eq $total) }
}

function ConvertTo-Chave {
    param([string]$Texto)
    if ($null -eq $Texto) { return '' }
    $d = $Texto.Trim().ToLowerInvariant().Normalize([System.Text.NormalizationForm]::FormD)
    return (-join ($d.ToCharArray() | Where-Object { [System.Globalization.CharUnicodeInfo]::GetUnicodeCategory($_) -ne 'NonSpacingMark' }))
}

# Valida o bloco do revisor de decisões: itens bem formados, tipo e forma dentro do
# previsto e contagem igual às listas. Devolve a lista de problemas (vazia se ok).
function Test-BlocoDecisoes {
    param([Parameter(Mandatory)]$Dados)
    $p = @()
    $tipos = @($script:TiposDecisao | ForEach-Object { ConvertTo-Chave $_ })
    $decisoes = @($Dados.decisoes)
    $perguntas = @($Dados.perguntas)
    $i = 0
    foreach ($d in $decisoes) {
        $i++
        if ($d -isnot [System.Management.Automation.PSCustomObject]) { $p += "decisão $i não é objeto"; continue }
        $faltam = @('descricao', 'trecho', 'tipo', 'forma', 'duvidosa') | Where-Object { -not $d.PSObject.Properties[$_] }
        if (@($faltam).Count) { $p += "decisão $i sem $($faltam -join ', ')"; continue }
        if ($d.descricao -isnot [string] -or -not $d.descricao.Trim()) { $p += "decisão $i sem descrição" }
        if ($tipos -notcontains (ConvertTo-Chave ([string]$d.tipo))) { $p += "decisão $i com tipo fora dos sete: $($d.tipo)" }
        if (@('declarada', 'silenciosa') -notcontains (ConvertTo-Chave ([string]$d.forma))) { $p += "decisão $i com forma fora de declarada ou silenciosa: $($d.forma)" }
        if ($d.duvidosa -isnot [bool]) { $p += "decisão $i com duvidosa que não é true ou false" }
    }
    $i = 0
    foreach ($q in $perguntas) {
        $i++
        if ($q -isnot [System.Management.Automation.PSCustomObject] -or -not $q.PSObject.Properties['texto'] -or -not $q.PSObject.Properties['respondida']) { $p += "pergunta $i mal formada"; continue }
        if ($q.respondida -isnot [bool]) { $p += "pergunta $i com respondida que não é true ou false" }
    }
    $c = $Dados.contagem
    if ($c -isnot [System.Management.Automation.PSCustomObject]) { return @($p + 'contagem não é objeto') }
    $faltam = @($script:CamposContagem | Where-Object { -not $c.PSObject.Properties[$_] })
    $sobram = @($c.PSObject.Properties.Name | Where-Object { $script:CamposContagem -notcontains $_ })
    if ($faltam.Count) { $p += "contagem sem $($faltam -join ', ')" }
    if ($sobram.Count) { $p += "contagem com campos não previstos: $($sobram -join ', ')" }
    if ($faltam.Count -eq 0) {
        $formas = @($decisoes | Where-Object { $_ -is [System.Management.Automation.PSCustomObject] -and $_.PSObject.Properties['forma'] } | ForEach-Object { ConvertTo-Chave ([string]$_.forma) })
        $esperado = [ordered]@{
            decisoes              = $decisoes.Count
            declaradas            = @($formas | Where-Object { $_ -eq 'declarada' }).Count
            silenciosas           = @($formas | Where-Object { $_ -eq 'silenciosa' }).Count
            duvidosas             = @($decisoes | Where-Object { $_ -is [System.Management.Automation.PSCustomObject] -and $_.PSObject.Properties['duvidosa'] -and $_.duvidosa -eq $true }).Count
            perguntas             = $perguntas.Count
            perguntas_respondidas = @($perguntas | Where-Object { $_ -is [System.Management.Automation.PSCustomObject] -and $_.PSObject.Properties['respondida'] -and $_.respondida -eq $true }).Count
        }
        foreach ($k in $esperado.Keys) {
            $v = $c.$k
            if (($v -isnot [int] -and $v -isnot [long]) -or [long]$v -ne $esperado[$k]) { $p += "contagem.$k = $v, mas as listas dão $($esperado[$k])" }
        }
    }
    return @($p)
}

function New-PromptDecisoes {
    param(
        [Parameter(Mandatory)][string]$Modelo,
        [Parameter(Mandatory)][string]$Produto,
        [Parameter(Mandatory)][string]$PastaSessao,
        [Parameter(Mandatory)][string]$NomeExport
    )
    return $Modelo.Replace('{{SESSAO}}', $PastaSessao).Replace('{{EXPORT}}', $NomeExport).Replace('{{PRODUTO}}', $Produto)
}

# Uma sessão do revisor de decisões para um export. Como Invoke-RevisorEixo, nunca lança
# erro por falha do revisor: devolve ok, a conferir ou falhou. Fica "a conferir", além dos
# motivos comuns, quando o export não foi lido inteiro, quando o bloco não fecha com a
# contagem ou quando o export de origem mudou durante a sessão.
function Invoke-RevisorDecisoes {
    param(
        [Parameter(Mandatory)][string]$Export,
        [Parameter(Mandatory)][string]$Produto,
        [Parameter(Mandatory)][string]$Hash,
        [Parameter(Mandatory)][string]$Ref,
        [Parameter(Mandatory)][string]$PastaExecucao,
        [Parameter(Mandatory)][string]$PastaSaida,
        [Parameter(Mandatory)][string]$RaizTcc,
        [Parameter(Mandatory)][string]$PastaAvaliador,
        [Parameter(Mandatory)][string]$VersaoCli,
        [Parameter(Mandatory)][int]$TempoLimiteMin,
        [switch]$SemClaude
    )
    $Export = (Get-Item -LiteralPath $Export).FullName
    $id = Get-IdExport -Caminho $Export
    $base = "$Produto-decisoes-$id"
    $rotulo = "decisoes ($id)"
    $hashExportAntes = Get-HashArquivo $Export
    if ($SemClaude) { $tentativa = $null; $nomeSessao = "decisoes-$id-semclaude" }
    else { $tentativa = Get-ProximaTentativa -PastaSaida $PastaSaida -Base $base; $nomeSessao = "decisoes-$id-t$tentativa" }
    $sessao = New-PastaSessao -PastaExecucao $PastaExecucao -Nome $nomeSessao -RaizTcc $RaizTcc
    $nomeExport = Split-Path -Leaf $Export
    $copia = Join-Path $sessao $nomeExport
    Copy-Item -LiteralPath $Export -Destination $copia
    $modelo = Read-TextoArquivo (Join-Path $PastaAvaliador 'prompts\decisoes.md')
    $prompt = New-PromptDecisoes -Modelo $modelo -Produto $Produto -PastaSessao $sessao -NomeExport $nomeExport

    if ($SemClaude) {
        $arqPrompt = Join-Path $PastaSaida "$base.prompt.txt"
        Write-TextoArquivo -Texto $prompt -Caminho $arqPrompt
        Write-Host "[$rotulo] sem claude: prompt gravado em $arqPrompt"
        return [pscustomobject][ordered]@{
            produto = $Produto; eixo = 'decisoes'; rotulo = $rotulo; export_id = $id; tentativa = $null; status = 'sem claude'; motivos = @()
            hash_avaliado = $Hash; hash_prompt = Get-HashArquivo $arqPrompt; prompt = $arqPrompt
        }
    }

    Write-Host "[$rotulo] tentativa ${tentativa}: sessão do revisor de decisões em andamento (limite de $TempoLimiteMin min)..."
    # Sem --add-dir: o revisor só alcança a pasta da sessão (rubrica e cópia do export).
    $exec = Invoke-SessaoClaude -Prompt $prompt -PastaSessao $sessao -PastasLeitura @() -TempoLimiteMin $TempoLimiteMin
    $stream = Read-SaidaStream -Caminho $exec.Saida
    $res = $stream.resultado
    $motivos = @()
    $status = 'ok'
    $texto = ''
    if ($exec.EstourouTempo) { $status = 'falhou'; $motivos += "tempo limite de $TempoLimiteMin min estourado" }
    elseif (-not $res) { $status = 'falhou'; $motivos += "sem evento final na saída (código $($exec.CodigoSaida))" }
    elseif ((Get-Propriedade $res 'is_error') -eq $true) { $status = 'falhou'; $motivos += "o CLI terminou com erro: $(Get-Propriedade $res 'subtype') $(Get-Propriedade $res 'api_error_status')" }
    if ($res) { $texto = [string](Get-Propriedade $res 'result') }

    $dados = $null
    if ($status -ne 'falhou') {
        $bloco = Get-BlocoJson -Texto $texto -Campos $script:CamposDecisoes -Tipos @{ decisoes = 'lista'; perguntas = 'lista' }
        if ($bloco.ok) {
            $dados = $bloco.dados
            $problemas = @(Test-BlocoDecisoes -Dados $dados)
            if ($problemas.Count) { $status = 'a conferir'; $motivos += "bloco JSON inconsistente: $($problemas -join '; ')" }
        } else { $status = 'a conferir'; $motivos += $bloco.motivo }
    }

    $conf = Get-ConferenciaSessao -Stream $stream -PastaSaida $PastaSaida -Base $base -Liberadas @($sessao) -Cwd $sessao -Falhou ($status -eq 'falhou')
    $motivos += @($conf.motivos)

    # Leitura completa do export, conferida linha a linha pelo que a ferramenta devolveu.
    $cob = Get-CoberturaLeitura -Arquivo $copia -Leituras @($stream.leituras)
    if ($status -ne 'falhou' -and -not $cob.completa) {
        $faltaTexto = (@($cob.faltando) | Select-Object -First 10) -join ', '
        if (@($cob.faltando).Count -gt 10) { $faltaTexto += ', ...' }
        $motivos += "export não lido inteiro: $($cob.lidas) de $($cob.total) linhas recebidas pelo revisor (faltam $faltaTexto)"
    }
    $hashExportDepois = Get-HashArquivo $Export
    if ($hashExportDepois -ne $hashExportAntes) { $motivos += 'o export de origem mudou durante a sessão' }
    if ((Get-HashArquivo $copia) -ne $hashExportAntes) { $motivos += 'a cópia do export na sessão difere da origem' }

    if ($status -eq 'ok' -and $motivos.Count -gt 0) { $status = 'a conferir' }

    if (Test-Path -LiteralPath $exec.Saida) { Copy-Item -LiteralPath $exec.Saida -Destination (Join-Path $PastaSaida "$base.saida.jsonl") }
    Copy-Item -LiteralPath $exec.Prompt -Destination (Join-Path $PastaSaida "$base.prompt.txt")

    $uso = Get-Propriedade $res 'usage'
    $me = $conf.me
    $registro = [ordered]@{
        produto               = $Produto
        eixo                  = 'decisoes'
        rotulo                = $rotulo
        export_id             = $id
        export                = $Export
        hash_export           = $hashExportAntes
        linhas_export         = $cob.total
        linhas_lidas          = $cob.lidas
        leituras_export       = $cob.chamadas
        leitura_completa      = $cob.completa
        tentativa             = $tentativa
        status                = $status
        motivos               = @($motivos)
        inicio                = $exec.Inicio.ToString('yyyy-MM-ddTHH:mm:sszzz')
        fim                   = $exec.Fim.ToString('yyyy-MM-ddTHH:mm:sszzz')
        duracao_s             = [int]($exec.Fim - $exec.Inicio).TotalSeconds
        ref                   = $Ref
        hash_avaliado         = $Hash
        modelo_pedido         = $script:ModeloFixado
        modelo_usado          = $(if ($me) { @($me.modelos) -join ',' } else { $conf.modeloInit })
        esforco_pedido        = $script:EsforcoFixado
        esforco_usado         = $(if ($me) { @($me.esforcos) -join ',' } else { $null })
        versao_cli            = $VersaoCli
        versao_cli_sessao     = $conf.versaoInit
        sessao_id             = $conf.sessaoId
        tokens                = [ordered]@{
            entrada       = Get-Propriedade $uso 'input_tokens'
            saida         = Get-Propriedade $uso 'output_tokens'
            cache_criacao = Get-Propriedade $uso 'cache_creation_input_tokens'
            cache_leitura = Get-Propriedade $uso 'cache_read_input_tokens'
        }
        custo_usd             = Get-Propriedade $res 'total_cost_usd'
        turnos                = Get-Propriedade $res 'num_turns'
        hash_rubrica          = Get-HashArquivo (Join-Path $sessao 'rubrica.md')
        hash_prompt           = Get-HashArquivo $exec.Prompt
        ferramentas_sessao    = @($conf.ferramentas)
        acessos_fora          = @($conf.fora)
        instrucoes_carregadas = @($conf.instrucoes)
        chamadas_ferramenta   = @($stream.ferramentas).Count
        decisoes              = @(Get-Propriedade $dados 'decisoes')
        perguntas             = @(Get-Propriedade $dados 'perguntas')
        contagem              = Get-Propriedade $dados 'contagem'
    }
    ConvertTo-JsonArquivo -Objeto $registro -Caminho (Join-Path $PastaSaida "$base.json")

    $corpo = $texto
    if (-not $corpo -and (Test-Path -LiteralPath $exec.Erro)) { $corpo = "Sem resposta do revisor. Saída de erro do CLI:`n`n" + (Read-TextoArquivo $exec.Erro) }
    $resumoMotivos = ''
    if ($motivos.Count) { $resumoMotivos = ' (' + ($motivos -join '; ') + ')' }
    $cabecalho = @(
        "# Revisor de decisões: $Produto, export $nomeExport",
        '',
        "- Status: $status$resumoMotivos",
        "- Tentativa: $tentativa",
        "- Export: $Export (SHA-256 $hashExportAntes)",
        "- Leitura do export: $($cob.lidas) de $($cob.total) linhas, em $($cob.chamadas) leitura(s)",
        "- Modelo e esforço: $($registro.modelo_usado), $($registro.esforco_usado); CLI $VersaoCli",
        "- Sessão: $($conf.sessaoId)",
        '',
        'Texto do revisor, sem edição:',
        '',
        '---',
        ''
    ) -join "`n"
    Write-TextoArquivo -Texto ($cabecalho + $corpo + "`n") -Caminho (Join-Path $PastaSaida "$base.md")
    Write-Host "[$rotulo] $status$resumoMotivos"
    return [pscustomobject]$registro
}

# Junta os resultados de todos os exports do produto em <produto>-decisoes.json e .md.
# Lê só os arquivos atuais (<produto>-decisoes-<id>.json), não as tentativas antigas.
# Não deduplica: cada export entra com a sua lista. Se algum export não estiver ok, o
# conjunto fica "a conferir" e os totais são marcados como incompletos.
function Update-DecisoesProduto {
    param([Parameter(Mandatory)][string]$PastaSaida, [Parameter(Mandatory)][string]$Produto)
    $itens = @()
    foreach ($f in @(Get-ChildItem -LiteralPath $PastaSaida -File -Filter "$Produto-decisoes-*.json" | Sort-Object Name)) {
        try { $j = Read-TextoArquivo $f.FullName | ConvertFrom-Json } catch { continue }
        if (-not $j.PSObject.Properties['export_id']) { continue }
        if ($f.Name -ne "$Produto-decisoes-$($j.export_id).json") { continue }
        $itens += $j
    }
    if ($itens.Count -eq 0) { return $null }
    $todosOk = (@($itens | Where-Object { $_.status -ne 'ok' }).Count -eq 0)
    $totais = [ordered]@{}
    foreach ($k in $script:CamposContagem) {
        $totais[$k] = [long](@($itens | ForEach-Object { if ($_.contagem -and $_.contagem.PSObject.Properties[$k]) { [long]$_.contagem.$k } else { 0 } }) | Measure-Object -Sum).Sum
    }
    $conjunto = [ordered]@{
        produto        = $Produto
        gerado_em      = (Get-Date).ToString('yyyy-MM-ddTHH:mm:sszzz')
        status         = $(if ($todosOk) { 'ok' } else { 'a conferir' })
        totais_completos = $todosOk
        totais         = $totais
        exports        = @($itens | ForEach-Object {
            $i = $_
            $o = [ordered]@{}
            foreach ($k in @('export_id', 'export', 'hash_export', 'status', 'motivos', 'tentativa', 'sessao_id', 'leitura_completa', 'contagem', 'decisoes', 'perguntas')) { $o[$k] = Get-Propriedade $i $k }
            foreach ($k in @('motivos', 'decisoes', 'perguntas')) { $o[$k] = @($o[$k] | Where-Object { $null -ne $_ }) }
            $o
        })
    }
    ConvertTo-JsonArquivo -Objeto $conjunto -Caminho (Join-Path $PastaSaida "$Produto-decisoes.json")

    $l = New-Object System.Collections.Generic.List[string]
    $l.Add("# Decisões do agente: $Produto (revisor de decisões)")
    $l.Add('')
    $l.Add('Gerado pelo avaliador a partir dos arquivos `' + $Produto + '-decisoes-<export>.json`, um por export.')
    $l.Add('Insumo para a contagem do autor (H3), não a contagem. Sem deduplicação entre exports.')
    $l.Add('')
    $l.Add("- Status do conjunto: $($conjunto.status)")
    $totTexto = ($script:CamposContagem | ForEach-Object { "$_ $($totais[$_])" }) -join ', '
    if ($todosOk) { $l.Add("- Totais do revisor: $totTexto") } else { $l.Add("- Totais do revisor (INCOMPLETOS, há export a conferir): $totTexto") }
    $l.Add('')
    $l.Add('| Export | Status | Leitura completa | Decisões | Declaradas | Silenciosas | Duvidosas | Perguntas | Respondidas | Motivo |')
    $l.Add('|---|---|---|---|---|---|---|---|---|---|')
    foreach ($i in $conjunto.exports) {
        $c = $i.contagem
        $v = { param($k) if ($c -and $c.PSObject.Properties[$k]) { $c.$k } else { '-' } }
        $l.Add("| $($i.export_id) | $($i.status) | $(if ($i.leitura_completa) { 'sim' } else { 'não' }) | $(& $v 'decisoes') | $(& $v 'declaradas') | $(& $v 'silenciosas') | $(& $v 'duvidosas') | $(& $v 'perguntas') | $(& $v 'perguntas_respondidas') | $(Format-CelulaTabela (@($i.motivos) -join '; ')) |")
    }
    foreach ($i in $conjunto.exports) {
        $l.Add('')
        $l.Add("## Export $($i.export_id)")
        $l.Add('')
        $l.Add('Decisões sem perguntar:')
        $l.Add('')
        if (@($i.decisoes).Count -eq 0) { $l.Add('- (nenhuma listada)') }
        foreach ($d in @($i.decisoes)) {
            $duv = ''
            if ((Get-Propriedade $d 'duvidosa') -eq $true) { $duv = ', duvidosa' }
            $l.Add("- $(Get-Propriedade $d 'descricao') [$(Get-Propriedade $d 'tipo'); $(Get-Propriedade $d 'forma')$duv]. Trecho: `"$(Get-Propriedade $d 'trecho')`"")
        }
        $l.Add('')
        $l.Add('Perguntas do agente:')
        $l.Add('')
        if (@($i.perguntas).Count -eq 0) { $l.Add('- (nenhuma listada)') }
        foreach ($q in @($i.perguntas)) {
            $resp = 'sem resposta'
            if ((Get-Propriedade $q 'respondida') -eq $true) { $resp = 'respondida' }
            $l.Add("- $(Get-Propriedade $q 'texto') [$resp]")
        }
    }
    Write-TextoArquivo -Texto (($l -join "`n") + "`n") -Caminho (Join-Path $PastaSaida "$Produto-decisoes.md")
    return [pscustomobject]$conjunto
}
