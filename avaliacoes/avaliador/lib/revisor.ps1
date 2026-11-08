# Funções da sessão de revisor: montagem do prompt, chamada ao claude -p isolada,
# leitura da saída, auditoria e gravação do review.

Set-StrictMode -Version 2.0

$script:ModeloFixado = 'claude-opus-5-5'
$script:EsforcoFixado = 'medium'
$script:FerramentasRevisor = @('Read', 'Grep', 'Glob')

# Executável chamado. Só os testes trocam isto, por um claude falso que não gasta sessão.
$script:ClaudeArquivo = 'claude'
$script:ClaudePrefixo = ''

$script:Secoes = [ordered]@{
    ux           = '1. Experiência do usuário'
    seguranca    = '2. Segurança'
    infra        = '3. Infraestrutura'
    documentacao = '4. Documentação'
    codigo       = '5. Código'
    arquitetura  = '6. Projeto e arquitetura'
}

$script:CamposRevisor = @('nota', 'justificativa', 'evidencias', 'regras_ausentes', 'decisoes_do_agente', 'nao_verificado')

function ConvertTo-JsonArquivo {
    param([Parameter(Mandatory)]$Objeto, [Parameter(Mandatory)][string]$Caminho)
    $json = $Objeto | ConvertTo-Json -Depth 12
    [System.IO.File]::WriteAllText($Caminho, $json, (New-Object System.Text.UTF8Encoding($false)))
}

function Write-TextoArquivo {
    param([Parameter(Mandatory)][AllowEmptyString()][string]$Texto, [Parameter(Mandatory)][string]$Caminho)
    [System.IO.File]::WriteAllText($Caminho, $Texto, (New-Object System.Text.UTF8Encoding($false)))
}

function Read-TextoArquivo {
    param([Parameter(Mandatory)][string]$Caminho)
    return [System.IO.File]::ReadAllText($Caminho, (New-Object System.Text.UTF8Encoding($false))).TrimStart([char]0xFEFF)
}

# Pasta da sessão: fora de qualquer repositório git (para o CLI não injetar o status de
# git do tcc no contexto do revisor), com cópias da rubrica, da especificação e dos
# encaixes. É a única pasta, além do checkout, que o revisor alcança.
function New-PastaSessao {
    param(
        [Parameter(Mandatory)][string]$PastaExecucao,
        [Parameter(Mandatory)][string]$Nome,
        [Parameter(Mandatory)][string]$RaizTcc
    )
    $pasta = Join-Path $PastaExecucao "sessao-$Nome"
    New-Item -ItemType Directory -Force -Path $pasta | Out-Null
    Copy-Item -LiteralPath (Join-Path $RaizTcc 'avaliacoes\rubrica.md') -Destination (Join-Path $pasta 'rubrica.md')
    Copy-Item -LiteralPath (Join-Path $RaizTcc 'docs\especificacao-telas.md') -Destination (Join-Path $pasta 'especificacao-telas.md')
    return $pasta
}

# Encaixes da rubrica: testes de referência (Código) e relatório de carga (Infra).
# Copia o que existir para a pasta da sessão e devolve a frase do prompt e um aviso.
function Get-Encaixe {
    param(
        [Parameter(Mandatory)][string]$Eixo,
        [Parameter(Mandatory)][string]$Produto,
        [Parameter(Mandatory)][string]$PastaSessao,
        [Parameter(Mandatory)][string]$RaizTcc
    )
    $r = [ordered]@{ frase = ''; aviso = $null; arquivo = $null; hash = $null; presente = $null }
    if ($Eixo -eq 'codigo') {
        $origem = Join-Path $RaizTcc "avaliacoes\reviews\$Produto-testes-referencia.md"
        if (Test-Path -LiteralPath $origem) {
            $destino = Join-Path $PastaSessao 'testes-referencia.md'
            Copy-Item -LiteralPath $origem -Destination $destino
            $r.frase = " O resultado da suíte de testes de referência está em ``$destino``; use-o como critério objetivo."
            $r.arquivo = $origem; $r.hash = Get-HashArquivo $destino; $r.presente = $true
        } else {
            $r.frase = ' Não há resultado da suíte de testes de referência para este produto; declare isso no review e pontue sem ele.'
            $r.aviso = "Sem testes de referência ($origem). O eixo Código segue sem eles."
            $r.presente = $false
        }
    } elseif ($Eixo -eq 'infra') {
        $pastaCarga = Join-Path $RaizTcc 'avaliacoes\carga'
        $arquivos = @(Get-ChildItem -LiteralPath $pastaCarga -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -like "$Produto*" })
        if ($arquivos.Count -gt 0) {
            $destino = Join-Path $PastaSessao 'carga'
            New-Item -ItemType Directory -Force -Path $destino | Out-Null
            $arquivos | ForEach-Object { Copy-Item -LiteralPath $_.FullName -Destination $destino }
            $r.frase = " O relatório do teste de carga está em ``$destino``; use-o como critério objetivo."
            $r.arquivo = ($arquivos | ForEach-Object { $_.FullName }) -join '; '
            $r.hash = Get-HashTexto ((Get-ChildItem -LiteralPath $destino -File | Sort-Object Name | ForEach-Object { Get-HashArquivo $_.FullName }) -join ',')
            $r.presente = $true
        } else {
            $r.frase = ' Não há relatório de teste de carga para este produto; declare isso no review e pontue sem ele.'
            $r.aviso = "Sem relatório de carga em $pastaCarga para '$Produto*'. O eixo Infraestrutura segue sem ele."
            $r.presente = $false
        }
    }
    return [pscustomobject]$r
}

function New-PromptRevisor {
    param(
        [Parameter(Mandatory)][string]$Modelo,
        [Parameter(Mandatory)][string]$Eixo,
        [Parameter(Mandatory)][string]$Produto,
        [Parameter(Mandatory)][string]$Hash,
        [Parameter(Mandatory)][string]$Checkout,
        [Parameter(Mandatory)][string]$PastaSessao,
        [AllowEmptyString()][string]$Encaixe = ''
    )
    $falhas = ''
    if ($Eixo -eq 'seguranca') {
        $falhas = ",`n  `"falhas`": [{`"titulo`": `"<texto>`", `"reproducao`": `"<passos para reproduzir>`", `"local`": `"<arquivo:linha>`"}]"
    }
    return $Modelo.Replace('{{CHECKOUT}}', $Checkout).
        Replace('{{PRODUTO}}', $Produto).
        Replace('{{HASH}}', $Hash).
        Replace('{{SECAO}}', $script:Secoes[$Eixo]).
        Replace('{{SESSAO}}', $PastaSessao).
        Replace('{{ENCAIXE}}', $Encaixe).
        Replace('{{CAMPO_FALHAS}}', $falhas)
}

function ConvertTo-ArgumentoCmd {
    param([string]$Valor)
    if ($Valor -match '[\s"]') { return '"' + ($Valor -replace '"', '\"') + '"' }
    return $Valor
}

# Roda uma sessão do claude -p isolada. O prompt vai por stdin; a saída stream-json vai
# para arquivo. Devolve caminhos, código de saída e se estourou o tempo limite.
function Invoke-SessaoClaude {
    param(
        [Parameter(Mandatory)][string]$Prompt,
        [Parameter(Mandatory)][string]$PastaSessao,
        [Parameter(Mandatory)][string[]]$PastasLeitura,
        [Parameter(Mandatory)][int]$TempoLimiteMin
    )
    $arqPrompt =[System.IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $PastaSessao) ("prompt-" + (Split-Path -Leaf $PastaSessao) + '.txt')))
    $arqSaida = [System.IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $PastaSessao) ("saida-" + (Split-Path -Leaf $PastaSessao) + '.jsonl')))
    $arqErro = [System.IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $PastaSessao) ("erro-" + (Split-Path -Leaf $PastaSessao) + '.txt')))
    Write-TextoArquivo -Texto $Prompt -Caminho $arqPrompt

    $argumentos = @(
        '-p',
        '--model', $script:ModeloFixado,
        '--effort', $script:EsforcoFixado,
        '--output-format', 'stream-json', '--verbose',
        '--tools', ($script:FerramentasRevisor -join ','),
        '--allowedTools', ($script:FerramentasRevisor -join ','),
        '--restricted',
        '--strict-mcp-config',
        '--permission-prompts', 'none'
    )
    foreach ($p in $PastasLeitura) { $argumentos += @('--add-dir', $p) }
    $linha = ($argumentos | ForEach-Object { ConvertTo-ArgumentoCmd $_ }) -join ' '
    if ($script:ClaudePrefixo) { $linha = "$script:ClaudePrefixo $linha" }

    $envAnterior = @{ m = $env:CLAUDE_CODE_DISABLE_AUTO_MEMORY; u = $env:DISABLE_AUTOUPDATER }
    $env:CLAUDE_CODE_DISABLE_AUTO_MEMORY = '1'
    $env:DISABLE_AUTOUPDATER = '1'
    try {
        $inicio = Get-Date
        $proc = Start-Process -FilePath $script:ClaudeArquivo -ArgumentList $linha -WorkingDirectory $PastaSessao `
            -RedirectStandardInput $arqPrompt -RedirectStandardOutput $arqSaida -RedirectStandardError $arqErro `
            -NoNewWindow -PassThru
        $null = $proc.Handle  # sem isto o ExitCode volta vazio no PowerShell 5.1
        $terminou = $proc.WaitForExit($TempoLimiteMin * 60 * 1000)
        if (-not $terminou) {
            & taskkill.exe /PID $proc.Id /T /F | Out-Null
            $proc.WaitForExit()
        }
        $fim = Get-Date
    } finally {
        $env:CLAUDE_CODE_DISABLE_AUTO_MEMORY = $envAnterior.m
        $env:DISABLE_AUTOUPDATER = $envAnterior.u
    }
    return [pscustomobject]@{
        Saida        = $arqSaida
        Erro         = $arqErro
        Prompt       = $arqPrompt
        CodigoSaida  = $(if ($terminou) { $proc.ExitCode } else { $null })
        EstourouTempo = (-not $terminou)
        Inicio       = $inicio
        Fim          = $fim
        LinhaComando = "$script:ClaudeArquivo $linha"
    }
}

# Lê o stream-json: evento de abertura, chamadas de ferramenta e evento final.
function Read-SaidaStream {
    param([Parameter(Mandatory)][string]$Caminho)
    $r = [ordered]@{ init = $null; resultado = $null; ferramentas = @(); linhas_invalidas = 0 }
    if (-not (Test-Path -LiteralPath $Caminho)) { return [pscustomobject]$r }
    foreach ($linha in [System.IO.File]::ReadAllLines($Caminho, (New-Object System.Text.UTF8Encoding($false)))) {
        if (-not $linha.Trim()) { continue }
        try { $o = $linha | ConvertFrom-Json } catch { $r.linhas_invalidas++; continue }
        if ($o.type -eq 'system' -and $o.PSObject.Properties['subtype'] -and $o.subtype -eq 'init') { $r.init = $o }
        elseif ($o.type -eq 'result') { $r.resultado = $o }
        elseif ($o.type -eq 'assistant') {
            foreach ($bloco in @($o.message.content)) {
                if ($bloco -and $bloco.type -eq 'tool_use') {
                    $r.ferramentas += [pscustomobject]@{ nome = $bloco.name; entrada = $bloco.input }
                }
            }
        }
    }
    return [pscustomobject]$r
}

# Caminhos tocados pelas ferramentas do revisor que caem fora das pastas liberadas.
function Get-AcessosFora {
    param([Parameter(Mandatory)][AllowEmptyCollection()][object[]]$Ferramentas, [Parameter(Mandatory)][string[]]$Liberadas, [Parameter(Mandatory)][string]$Cwd)
    $fora = @()
    $raizes = $Liberadas | ForEach-Object { [System.IO.Path]::GetFullPath($_).TrimEnd('\') + '\' }
    foreach ($f in $Ferramentas) {
        $caminhos = @()
        foreach ($campo in @('file_path', 'path', 'notebook_path')) {
            if ($f.entrada -and $f.entrada.PSObject.Properties[$campo] -and $f.entrada.$campo) { $caminhos += [string]$f.entrada.$campo }
        }
        if ($f.nome -eq 'Glob' -and $f.entrada.PSObject.Properties['pattern'] -and [System.IO.Path]::IsPathRooted([string]$f.entrada.pattern)) {
            $caminhos += [string]$f.entrada.pattern
        }
        foreach ($c in $caminhos) {
            $base = ($c -split '[\*\?\{\[]')[0]
            if (-not $base) { $base = $Cwd }
            $cheio = if ([System.IO.Path]::IsPathRooted($base)) { $base } else { Join-Path $Cwd $base }
            try { $cheio = [System.IO.Path]::GetFullPath($cheio) } catch { }
            $dentro = $false
            foreach ($raiz in $raizes) { if (($cheio.TrimEnd('\') + '\').StartsWith($raiz, [System.StringComparison]::OrdinalIgnoreCase)) { $dentro = $true } }
            if (-not $dentro) { $fora += "$($f.nome): $c" }
        }
    }
    return $fora
}

# Transcrição .jsonl que o CLI grava em ~/.claude/projects; dela saem modelo e esforço.
function Find-Transcricao {
    param([Parameter(Mandatory)][string]$SessaoId)
    $base = Join-Path $env:USERPROFILE '.claude\projects'
    return Get-ChildItem -LiteralPath $base -Recurse -File -Filter "$SessaoId.jsonl" -ErrorAction SilentlyContinue | Select-Object -First 1
}

function Get-ModeloEsforcoTranscricao {
    param([Parameter(Mandatory)][string]$Caminho)
    $modelos = @{}; $esforcos = @{}
    foreach ($linha in [System.IO.File]::ReadAllLines($Caminho, (New-Object System.Text.UTF8Encoding($false)))) {
        if ($linha -notmatch '"type"\s*:\s*"assistant"') { continue }
        try { $o = $linha | ConvertFrom-Json } catch { continue }
        if ($o.type -ne 'assistant') { continue }
        if ($o.PSObject.Properties['message'] -and $o.message.PSObject.Properties['model'] -and $o.message.model) { $modelos[[string]$o.message.model] = $true }
        foreach ($onde in @($o, $o.message)) {
            if ($onde -and $onde.PSObject.Properties['effort'] -and $onde.effort) { $esforcos[[string]$onde.effort] = $true }
        }
    }
    if ($esforcos.Count -eq 0) {
        foreach ($m in [regex]::Matches([System.IO.File]::ReadAllText($Caminho), '"effort"\s*:\s*"([^"]+)"')) { $esforcos[$m.Groups[1].Value] = $true }
    }
    return [pscustomobject]@{ modelos = @($modelos.Keys | Sort-Object); esforcos = @($esforcos.Keys | Sort-Object) }
}

# Arquivos de instrução (CLAUDE.md e afins) que o CLI carregou na sessão. Na versão 2.1.316
# eles aparecem na transcrição como anexo do tipo "instructions", com a lista de arquivos
# (conferido com uma contraprova em que o CLAUDE.md isca foi carregado e obedecido).
# Para um revisor isolado a lista tem de vir vazia.
function Get-InstrucoesCarregadas {
    param([Parameter(Mandatory)][string]$Caminho)
    $arquivos = @()
    foreach ($linha in [System.IO.File]::ReadAllLines($Caminho, (New-Object System.Text.UTF8Encoding($false)))) {
        if ($linha -notmatch '"attachment"') { continue }
        try { $o = $linha | ConvertFrom-Json } catch { continue }
        $a = $null
        if ($o.PSObject.Properties['attachment']) { $a = $o.attachment }
        if ($a -and $a.PSObject.Properties['type'] -and $a.type -eq 'instructions' -and $a.PSObject.Properties['files']) {
            foreach ($f in @($a.files)) { if ($f -and $f.PSObject.Properties['path']) { $arquivos += [string]$f.path } }
        }
    }
    if (([System.IO.File]::ReadAllText($Caminho)) -match 'project instructions, checked into the codebase') {
        if ($arquivos.Count -eq 0) { $arquivos += '(texto de instruções de projeto encontrado na transcrição)' }
    }
    return $arquivos
}

# Extrai e valida o último bloco ```json da resposta. Devolve o objeto ou o motivo.
function Get-BlocoJson {
    param(
        [Parameter(Mandatory)][AllowEmptyString()][string]$Texto,
        [Parameter(Mandatory)][string[]]$Campos,
        [hashtable]$Tipos = @{}
    )
    $blocos = [regex]::Matches($Texto, '```json\s*\r?\n(.*?)\r?\n\s*```', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if ($blocos.Count -eq 0) { return [pscustomobject]@{ ok = $false; motivo = 'resposta sem bloco ```json'; dados = $null } }
    $bruto = $blocos[$blocos.Count - 1].Groups[1].Value
    try { $dados = $bruto | ConvertFrom-Json } catch { return [pscustomobject]@{ ok = $false; motivo = "bloco JSON inválido: $($_.Exception.Message)"; dados = $null } }
    if ($dados -isnot [System.Management.Automation.PSCustomObject]) { return [pscustomobject]@{ ok = $false; motivo = 'o bloco JSON não é um objeto'; dados = $null } }
    $presentes = @($dados.PSObject.Properties.Name)
    $faltam = @($Campos | Where-Object { $presentes -notcontains $_ })
    $sobram = @($presentes | Where-Object { $Campos -notcontains $_ })
    if ($faltam.Count) { return [pscustomobject]@{ ok = $false; motivo = "campos ausentes no bloco JSON: $($faltam -join ', ')"; dados = $dados } }
    if ($sobram.Count) { return [pscustomobject]@{ ok = $false; motivo = "campos não previstos no bloco JSON: $($sobram -join ', ')"; dados = $dados } }
    foreach ($campo in $Tipos.Keys) {
        $valor = $dados.$campo
        switch ($Tipos[$campo]) {
            'lista' { if ($null -ne $valor -and $valor -isnot [System.Array]) { return [pscustomobject]@{ ok = $false; motivo = "o campo $campo devia ser lista"; dados = $dados } } }
            'texto' { if ($valor -isnot [string] -or -not $valor.Trim()) { return [pscustomobject]@{ ok = $false; motivo = "o campo $campo devia ser texto não vazio"; dados = $dados } } }
            'nota'  {
                $n = 0
                if (($valor -isnot [int] -and $valor -isnot [long]) -or -not [int]::TryParse([string]$valor, [ref]$n) -or $n -lt 1 -or $n -gt 5) {
                    return [pscustomobject]@{ ok = $false; motivo = "nota fora de 1 a 5 ou não inteira: $valor"; dados = $dados }
                }
            }
        }
    }
    return [pscustomobject]@{ ok = $true; motivo = $null; dados = $dados }
}

function Get-CamposEixo {
    param([Parameter(Mandatory)][string]$Eixo)
    $campos = @($script:CamposRevisor)
    if ($Eixo -eq 'seguranca') { $campos += 'falhas' }
    $tipos = @{ nota = 'nota'; justificativa = 'texto'; evidencias = 'lista'; regras_ausentes = 'lista'; decisoes_do_agente = 'lista'; nao_verificado = 'lista' }
    if ($Eixo -eq 'seguranca') { $tipos['falhas'] = 'lista' }
    return [pscustomobject]@{ campos = $campos; tipos = $tipos }
}

# Próxima tentativa: se já existe review do eixo, ele é renomeado para -t<n> e nunca apagado.
function Get-ProximaTentativa {
    param([Parameter(Mandatory)][string]$PastaSaida, [Parameter(Mandatory)][string]$Base)
    $json = Join-Path $PastaSaida "$Base.json"
    if (-not (Test-Path -LiteralPath $json)) { return 1 }
    $anterior = 1
    try { $anterior = [int]((Read-TextoArquivo $json | ConvertFrom-Json).tentativa) } catch { }
    foreach ($ext in @('json', 'md', 'sessao.jsonl', 'saida.jsonl', 'prompt.txt')) {
        $atual = Join-Path $PastaSaida "$Base.$ext"
        if (Test-Path -LiteralPath $atual) { Move-Item -LiteralPath $atual -Destination (Join-Path $PastaSaida "$Base-t$anterior.$ext") }
    }
    return $anterior + 1
}

function Get-Propriedade {
    param($Objeto, [string]$Nome)
    if ($null -ne $Objeto -and $Objeto.PSObject.Properties[$Nome]) { return $Objeto.$Nome }
    return $null
}

# Um eixo de ponta a ponta. Nunca lança erro por falha do revisor: devolve o status
# (ok, a conferir, falhou) para o script seguir para o próximo eixo.
function Invoke-RevisorEixo {
    param(
        [Parameter(Mandatory)][string]$Eixo,
        [Parameter(Mandatory)][string]$Produto,
        [Parameter(Mandatory)][string]$Repo,
        [Parameter(Mandatory)][string]$Ref,
        [Parameter(Mandatory)][string]$Hash,
        [Parameter(Mandatory)][string]$Checkout,
        [Parameter(Mandatory)][string]$PastaExecucao,
        [Parameter(Mandatory)][string]$PastaSaida,
        [Parameter(Mandatory)][string]$RaizTcc,
        [Parameter(Mandatory)][string]$PastaAvaliador,
        [Parameter(Mandatory)][string]$VersaoCli,
        [Parameter(Mandatory)][int]$TempoLimiteMin,
        # Monta a pasta da sessão, os encaixes e o prompt, grava o prompt e para: sem sessão.
        [switch]$SemClaude,
        # Não escreve a nota no terminal (avaliação real: o autor pontua sem vê-la).
        [switch]$OcultarNota
    )
    $base = "$Produto-$Eixo"
    if ($SemClaude) { $tentativa = $null; $nomeSessao = "$Eixo-semclaude" }
    else { $tentativa = Get-ProximaTentativa -PastaSaida $PastaSaida -Base $base; $nomeSessao = "$Eixo-t$tentativa" }
    $sessao = New-PastaSessao -PastaExecucao $PastaExecucao -Nome $nomeSessao -RaizTcc $RaizTcc
    $encaixe = Get-Encaixe -Eixo $Eixo -Produto $Produto -PastaSessao $sessao -RaizTcc $RaizTcc
    if ($encaixe.aviso) { Write-Warning $encaixe.aviso }

    $modelo = Read-TextoArquivo (Join-Path $PastaAvaliador 'prompts\revisor.md')
    $prompt = New-PromptRevisor -Modelo $modelo -Eixo $Eixo -Produto $Produto -Hash $Hash -Checkout $Checkout -PastaSessao $sessao -Encaixe $encaixe.frase

    if ($SemClaude) {
        $arqPrompt = Join-Path $PastaSaida "$base.prompt.txt"
        Write-TextoArquivo -Texto $prompt -Caminho $arqPrompt
        Write-Host "[$Eixo] sem claude: prompt gravado em $arqPrompt"
        return [pscustomobject][ordered]@{
            produto       = $Produto
            eixo          = $Eixo
            tentativa     = $null
            status        = 'sem claude'
            motivos       = @()
            hash_avaliado = $Hash
            hash_prompt   = Get-HashArquivo $arqPrompt
            encaixe       = [ordered]@{ presente = $encaixe.presente; arquivo = $encaixe.arquivo; hash = $encaixe.hash; aviso = $encaixe.aviso }
            prompt        = $arqPrompt
        }
    }

    Write-Host "[$Eixo] tentativa ${tentativa}: sessão do revisor em andamento (limite de $TempoLimiteMin min)..."
    $exec = Invoke-SessaoClaude -Prompt $prompt -PastaSessao $sessao -PastasLeitura @($Checkout) -TempoLimiteMin $TempoLimiteMin
    $stream = Read-SaidaStream -Caminho $exec.Saida
    $res = $stream.resultado
    $motivos = @()
    $status = 'ok'
    $texto = ''

    if ($exec.EstourouTempo) { $status = 'falhou'; $motivos += "tempo limite de $TempoLimiteMin min estourado" }
    elseif (-not $res) { $status = 'falhou'; $motivos += "sem evento final na saída (código $($exec.CodigoSaida))" }
    elseif ((Get-Propriedade $res 'is_error') -eq $true) { $status = 'falhou'; $motivos += "o CLI terminou com erro: $(Get-Propriedade $res 'subtype') $(Get-Propriedade $res 'api_error_status')" }
    if ($res) { $texto = [string](Get-Propriedade $res 'result') }

    # Bloco JSON.
    $dados = $null
    if ($status -ne 'falhou') {
        $esp = Get-CamposEixo -Eixo $Eixo
        $bloco = Get-BlocoJson -Texto $texto -Campos $esp.campos -Tipos $esp.tipos
        if ($bloco.ok) { $dados = $bloco.dados } else { $status = 'a conferir'; $motivos += $bloco.motivo }
    }

    # Conferências do ambiente da sessão.
    $init = $stream.init
    $ferramentas = @(); $mcp = @(); $modeloInit = $null; $versaoInit = $null
    if ($init) {
        $ferramentas = @(Get-Propriedade $init 'tools' | Sort-Object)
        $mcp = @(Get-Propriedade $init 'mcp_servers')
        $modeloInit = Get-Propriedade $init 'model'
        $versaoInit = Get-Propriedade $init 'claude_code_version'
        if ((@($ferramentas) -join ',') -ne ((@($script:FerramentasRevisor) | Sort-Object) -join ',')) { $motivos += "ferramentas da sessão diferentes de Read, Grep e Glob: $($ferramentas -join ', ')" }
        if (@($mcp | Where-Object { $_ }).Count -gt 0) { $motivos += 'a sessão carregou servidores MCP' }
    } elseif ($status -ne 'falhou') { $motivos += 'sem evento de abertura na saída' }

    $sessaoId = Get-Propriedade $res 'session_id'
    if (-not $sessaoId -and $init) { $sessaoId = Get-Propriedade $init 'session_id' }
    $me = $null
    $instrucoes = @()
    if ($sessaoId) {
        $arq = Find-Transcricao -SessaoId $sessaoId
        if ($arq) {
            Copy-Item -LiteralPath $arq.FullName -Destination (Join-Path $PastaSaida "$base.sessao.jsonl")
            $me = Get-ModeloEsforcoTranscricao -Caminho $arq.FullName
            $instrucoes = @(Get-InstrucoesCarregadas -Caminho $arq.FullName)
        }
    }
    if ($instrucoes.Count -gt 0) { $motivos += "arquivos de instrução carregados na sessão: $($instrucoes -join '; ')" }
    if ($status -ne 'falhou') {
        if (-not $me) { $motivos += 'transcrição .jsonl não encontrada; modelo e esforço não confirmados' }
        else {
            if ((@($me.modelos) -join ',') -ne $script:ModeloFixado) { $motivos += "modelo usado ($($me.modelos -join ', ')) diferente do fixado ($script:ModeloFixado)" }
            if ((@($me.esforcos) -join ',') -ne $script:EsforcoFixado) { $motivos += "esforço usado ($($me.esforcos -join ', ')) diferente do fixado ($script:EsforcoFixado)" }
        }
    }

    $fora = @(Get-AcessosFora -Ferramentas @($stream.ferramentas) -Liberadas @($Checkout, $sessao) -Cwd $sessao)
    if ($fora.Count -gt 0) { $motivos += "acessos fora das pastas liberadas: $($fora -join '; ')" }
    $negadas = @(Get-Propriedade $res 'permission_denials' | Where-Object { $_ })
    if ($negadas.Count -gt 0) { $motivos += "ferramentas negadas durante a sessão: $($negadas.Count)" }

    if ($status -eq 'ok' -and $motivos.Count -gt 0) { $status = 'a conferir' }

    # Saída bruta sempre guardada.
    if (Test-Path -LiteralPath $exec.Saida) { Copy-Item -LiteralPath $exec.Saida -Destination (Join-Path $PastaSaida "$base.saida.jsonl") }
    Copy-Item -LiteralPath $exec.Prompt -Destination (Join-Path $PastaSaida "$base.prompt.txt")

    $uso = Get-Propriedade $res 'usage'
    $registro = [ordered]@{
        produto              = $Produto
        eixo                 = $Eixo
        secao                = $script:Secoes[$Eixo]
        tentativa            = $tentativa
        status               = $status
        motivos              = @($motivos)
        inicio               = $exec.Inicio.ToString('yyyy-MM-ddTHH:mm:sszzz')
        fim                  = $exec.Fim.ToString('yyyy-MM-ddTHH:mm:sszzz')
        duracao_s            = [int]($exec.Fim - $exec.Inicio).TotalSeconds
        repo                 = $Repo
        ref                  = $Ref
        hash_avaliado        = $Hash
        modelo_pedido        = $script:ModeloFixado
        modelo_usado         = $(if ($me) { @($me.modelos) -join ',' } else { $modeloInit })
        esforco_pedido       = $script:EsforcoFixado
        esforco_usado        = $(if ($me) { @($me.esforcos) -join ',' } else { $null })
        versao_cli           = $VersaoCli
        versao_cli_sessao    = $versaoInit
        sessao_id            = $sessaoId
        tokens               = [ordered]@{
            entrada       = Get-Propriedade $uso 'input_tokens'
            saida         = Get-Propriedade $uso 'output_tokens'
            cache_criacao = Get-Propriedade $uso 'cache_creation_input_tokens'
            cache_leitura = Get-Propriedade $uso 'cache_read_input_tokens'
        }
        custo_usd            = Get-Propriedade $res 'total_cost_usd'
        turnos               = Get-Propriedade $res 'num_turns'
        hash_rubrica         = Get-HashArquivo (Join-Path $sessao 'rubrica.md')
        hash_especificacao   = Get-HashArquivo (Join-Path $sessao 'especificacao-telas.md')
        hash_prompt          = Get-HashArquivo $exec.Prompt
        encaixe              = [ordered]@{ presente = $encaixe.presente; arquivo = $encaixe.arquivo; hash = $encaixe.hash; aviso = $encaixe.aviso }
        ferramentas_sessao   = @($ferramentas)
        acessos_fora         = @($fora)
        instrucoes_carregadas = @($instrucoes)
        chamadas_ferramenta  = @($stream.ferramentas).Count
        nota                 = Get-Propriedade $dados 'nota'
        justificativa        = Get-Propriedade $dados 'justificativa'
        evidencias           = @(Get-Propriedade $dados 'evidencias')
        regras_ausentes      = @(Get-Propriedade $dados 'regras_ausentes')
        decisoes_do_agente   = @(Get-Propriedade $dados 'decisoes_do_agente')
        nao_verificado       = @(Get-Propriedade $dados 'nao_verificado')
    }
    if ($Eixo -eq 'seguranca') { $registro['falhas'] = @(Get-Propriedade $dados 'falhas') }
    ConvertTo-JsonArquivo -Objeto $registro -Caminho (Join-Path $PastaSaida "$base.json")

    $corpo = $texto
    if (-not $corpo -and (Test-Path -LiteralPath $exec.Erro)) { $corpo = "Sem resposta do revisor. Saída de erro do CLI:`n`n" + (Read-TextoArquivo $exec.Erro) }
    $resumoMotivos = ''
    if ($motivos.Count) { $resumoMotivos = ' (' + ($motivos -join '; ') + ')' }
    $cabecalho = @(
        "# Review $Produto, eixo $($script:Secoes[$Eixo])",
        '',
        "- Status: $status$resumoMotivos",
        "- Tentativa: $tentativa",
        "- Commit avaliado: $Hash ($Ref)",
        "- Modelo e esforço: $($registro.modelo_usado), $($registro.esforco_usado); CLI $VersaoCli",
        "- Sessão: $sessaoId",
        '',
        'Texto do revisor, sem edição:',
        '',
        '---',
        ''
    ) -join "`n"
    Write-TextoArquivo -Texto ($cabecalho + $corpo + "`n") -Caminho (Join-Path $PastaSaida "$base.md")

    $resumoNota = ''
    if ($null -ne $registro.nota -and -not $OcultarNota) { $resumoNota = ", nota $($registro.nota)" }
    Write-Host "[$Eixo] $status$resumoNota$resumoMotivos"
    return [pscustomobject]$registro
}
