# Teste da etapa 3 sem gastar sessão: modo -SemClaude com os seis eixos, avisos dos
# encaixes, registro da execução, formulário do autor (criado uma vez, nunca sobrescrito),
# nota fora do terminal e do registro nos produtos de nota cega e, nos de nota validada
# (leigo_pu, eng_pu), formulário com a nota do revisor e nota visível.
# Uso: powershell -ExecutionPolicy Bypass -File testes\teste-etapa3.ps1

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
$avaliador = Split-Path -Parent $PSScriptRoot
$raizTcc = (Get-Item -LiteralPath (Join-Path $avaliador '..\..')).FullName
. (Join-Path $avaliador 'lib\checkout.ps1')
. (Join-Path $avaliador 'lib\revisor.ps1')
. (Join-Path $avaliador 'lib\registro.ps1')

$falhas = 0
function Confere {
    param([string]$Descricao, [bool]$Condicao)
    if ($Condicao) { Write-Host "  ok     $Descricao" }
    else { Write-Host "  FALHOU $Descricao"; $script:falhas++ }
}
$travessao = [string][char]0x2014

# O formulário do ensaio pode existir de um ensaio anterior: guardado e devolvido no fim.
$form = Join-Path $avaliador 'ensaio\saida\autor\ensaio.md'
$formAntes = $null
if (Test-Path -LiteralPath $form) { $formAntes = Read-TextoArquivo $form; Remove-Item -LiteralPath $form }
$registro = Join-Path $avaliador 'ensaio\saida\sem-claude\ensaio-registro.md'
$secoesAntes = 0
if (Test-Path -LiteralPath $registro) { $secoesAntes = ([regex]::Matches((Read-TextoArquivo $registro), '(?m)^## Execução ')).Count }

try {
    Write-Host '1. -SemClaude no ensaio, seis eixos'
    $r = & (Join-Path $avaliador 'avaliar.ps1') -Ensaio -SemClaude 3>$null 6>$null
    $saida = $r.pasta_saida
    Confere 'saída na subpasta sem-claude' ($saida -like '*\ensaio\saida\sem-claude')
    Confere 'seis eixos com status "sem claude"' (@($r.resultados | Where-Object { $_.status -eq 'sem claude' }).Count -eq 6)
    $prompts = @($script:Secoes.Keys | ForEach-Object { Join-Path $saida "ensaio-$_.prompt.txt" } | Where-Object { Test-Path -LiteralPath $_ })
    Confere 'seis prompts gravados' ($prompts.Count -eq 6)
    Confere 'nenhum marcador {{...}} sobrando nos prompts' (@($prompts | Where-Object { (Read-TextoArquivo $_) -match '\{\{' }).Count -eq 0)
    Confere 'cada prompt cita a sua seção da rubrica' (@($script:Secoes.Keys | Where-Object { (Read-TextoArquivo (Join-Path $saida "ensaio-$_.prompt.txt")).Contains($script:Secoes[$_]) }).Count -eq 6)
    Confere 'prompt de Código com a frase de ausência dos testes de referência' ((Read-TextoArquivo (Join-Path $saida 'ensaio-codigo.prompt.txt')).Contains('Não há resultado da suíte de testes de referência'))
    Confere 'prompt de Infra com a frase de ausência do relatório de carga' ((Read-TextoArquivo (Join-Path $saida 'ensaio-infra.prompt.txt')).Contains('Não há relatório de teste de carga'))
    Confere 'prompt de Segurança com o campo falhas' ((Read-TextoArquivo (Join-Path $saida 'ensaio-seguranca.prompt.txt')).Contains('"falhas"'))
    Confere 'dois avisos de encaixe ausente (Código e Infra)' (@($r.avisos).Count -eq 2 -and ($r.avisos -join ' ') -like '*testes de referência*' -and ($r.avisos -join ' ') -like '*relatório de carga*')
    Confere 'nenhum review .json gravado no modo sem claude' (@(Get-ChildItem -LiteralPath $saida -Filter '*.json' -File).Count -eq 0)

    $reg = Read-TextoArquivo $registro
    Confere 'registro criado com uma seção nova' (([regex]::Matches($reg, '(?m)^## Execução ')).Count -eq $secoesAntes + 1)
    Confere 'registro com commit, CLI, modelo e esforço' ($reg.Contains($r.hash_avaliado) -and $reg -match 'Claude Code: \S' -and $reg.Contains("$script:ModeloFixado, $script:EsforcoFixado"))
    Confere 'registro com hashes da rubrica, especificação e prompt' ($reg.Contains('SHA-256 de avaliacoes/rubrica.md') -and $reg.Contains('SHA-256 de docs/especificacao-telas.md') -and $reg.Contains('SHA-256 de avaliador/prompts/revisor.md'))
    Confere 'registro com os dois avisos' ($reg.Contains('Sem testes de referência') -and $reg.Contains('Sem relatório de carga'))
    Confere 'registro com seis linhas de eixo' (([regex]::Matches($reg, '(?m)^\| (ux|seguranca|infra|documentacao|codigo|arquitetura) \|')).Count -ge 6)

    $f = Read-TextoArquivo $form
    Confere 'formulário criado (formulario_criado = true)' ($r.formulario_criado -eq $true -and $r.formulario -eq $form)
    Confere 'formulário com os seis eixos e "Nota (1 a 5):"' (@($script:Secoes.Values | Where-Object { $f.Contains("## $_`n`nNota (1 a 5): ") }).Count -eq 6)
    Confere 'formulário com observações objetivas e regras ausentes por eixo' (([regex]::Matches($f, '(?m)^Observações objetivas:')).Count -eq 6 -and ([regex]::Matches($f, '(?m)^Regras ausentes:')).Count -eq 6)
    Confere 'formulário com "Decisões sem perguntar" e "Perguntas sem resposta"' ($f.Contains('## Decisões sem perguntar') -and $f.Contains('## Perguntas sem resposta'))
    Confere 'formulário com os sete tipos de decisão' (@($script:TiposDecisao | Where-Object { $f.Contains("| $_ |") }).Count -eq 7)
    Confere 'formulário com a instrução de preencher antes de abrir os reviews' ($f.Contains('ANTES de abrir os reviews'))
    Confere 'sem travessão no formulário nem no registro' (-not $f.Contains($travessao) -and -not $reg.Contains($travessao))

    Write-Host '2. Segunda execução não sobrescreve o formulário'
    Write-TextoArquivo -Texto ($f.Replace('Nota (1 a 5): ', 'Nota (1 a 5): 4 MARCA-DO-AUTOR')) -Caminho $form
    $r2 = & (Join-Path $avaliador 'avaliar.ps1') -Ensaio -SemClaude -Eixos ux 3>$null 6>$null
    Confere 'formulario_criado = false na segunda execução' ($r2.formulario_criado -eq $false)
    Confere 'o que o autor escreveu continua no formulário' ((Read-TextoArquivo $form).Contains('4 MARCA-DO-AUTOR'))
    Confere 'registro ganhou outra seção, a anterior ficou' (([regex]::Matches((Read-TextoArquivo $registro), '(?m)^## Execução ')).Count -eq $secoesAntes + 2 -and (Read-TextoArquivo $registro).StartsWith($reg.TrimEnd()))

    Write-Host '3. Encaixes presentes'
    $tmp = Join-Path (Get-PastaTemporaria) ("teste-etapa3-" + (Get-Date -Format 'yyyyMMdd-HHmmss'))
    $raizFalsa = Join-Path $tmp 'tcc'
    New-Item -ItemType Directory -Force -Path (Join-Path $raizFalsa 'avaliacoes\reviews'), (Join-Path $raizFalsa 'avaliacoes\carga'), (Join-Path $tmp 'sessao') | Out-Null
    Write-TextoArquivo -Texto 'suíte: 10 de 12' -Caminho (Join-Path $raizFalsa 'avaliacoes\reviews\leigo-testes-referencia.md')
    Write-TextoArquivo -Texto 'p95 200 ms' -Caminho (Join-Path $raizFalsa 'avaliacoes\carga\leigo-relatorio.md')
    Write-TextoArquivo -Texto 'outro produto' -Caminho (Join-Path $raizFalsa 'avaliacoes\carga\engenheiro-relatorio.md')
    Write-TextoArquivo -Texto 'prompt único do leigo' -Caminho (Join-Path $raizFalsa 'avaliacoes\carga\leigo_pu-relatorio.md')
    $ec = Get-Encaixe -Eixo codigo -Produto leigo -PastaSessao (Join-Path $tmp 'sessao') -RaizTcc $raizFalsa
    $ei = Get-Encaixe -Eixo infra -Produto leigo -PastaSessao (Join-Path $tmp 'sessao') -RaizTcc $raizFalsa
    Confere 'testes de referência copiados para a sessão, sem aviso' ($ec.presente -and -not $ec.aviso -and (Test-Path (Join-Path $tmp 'sessao\testes-referencia.md')) -and $ec.frase.Contains('use-o como critério objetivo'))
    Confere 'relatório de carga do produto copiado, os de outros produtos não (nem o do leigo_pu)' ($ei.presente -and -not $ei.aviso -and (Test-Path (Join-Path $tmp 'sessao\carga\leigo-relatorio.md')) -and -not (Test-Path (Join-Path $tmp 'sessao\carga\engenheiro-relatorio.md')) -and -not (Test-Path (Join-Path $tmp 'sessao\carga\leigo_pu-relatorio.md')))

    Write-Host '4. Nota fora do terminal e do registro (avaliação real, com claude falso)'
    $script:ClaudeArquivo = 'powershell.exe'
    $script:ClaudePrefixo = '-NoProfile -ExecutionPolicy Bypass -File "' + (Join-Path $PSScriptRoot 'claude-falso.ps1') + '"'
    $origem = New-RepoEnsaio -Exemplo (Join-Path $avaliador 'exemplo') -Destino (Join-Path $tmp 'origem')
    $hash = Resolve-RefCommit -Repo $origem -Ref 'main'
    $exec = Join-Path $tmp 'exec'
    $co = New-CheckoutLimpo -Repo $origem -Hash $hash -Destino (Join-Path $exec 'repo')
    $saidaFalsa = Join-Path $tmp 'saida'
    New-Item -ItemType Directory -Force -Path $saidaFalsa | Out-Null
    $env:CLAUDE_FALSO_MODO = 'valido'
    $terminal = & {
        Invoke-RevisorEixo -Eixo documentacao -Produto teste -Repo $origem -Ref main -Hash $hash -Checkout $co.Caminho `
            -PastaExecucao $exec -PastaSaida $saidaFalsa -RaizTcc $raizTcc -PastaAvaliador $avaliador -VersaoCli falso -TempoLimiteMin 2 -OcultarNota
    } 6>&1 3>&1
    Remove-Item Env:\CLAUDE_FALSO_MODO
    $rev = @($terminal | Where-Object { $_.PSObject.Properties['nota'] })[0]
    $mensagens = @($terminal | Where-Object { $_ -is [System.Management.Automation.InformationRecord] -or $_ -is [System.Management.Automation.WarningRecord] })
    $textoTerminal = ($mensagens | ForEach-Object { "$_" }) -join "`n"
    Confere 'o review tem a nota (3) no .json' ($rev.nota -eq 3 -and (Read-TextoArquivo (Join-Path $saidaFalsa 'teste-documentacao.json')) -match '"nota":\s*3')
    Confere "o terminal mostrou o status do eixo ($($mensagens.Count) mensagens) e não mostrou a nota" ($textoTerminal -match '\[documentacao\]' -and -not ($textoTerminal -match 'nota'))
    $regFalso = Join-Path $saidaFalsa 'teste-registro.md'
    Add-RegistroExecucao -Caminho $regFalso -Produto teste -Modo 'avaliação' -Repo $origem -Ref main -Hash $hash -Inicio (Get-Date) -Fim (Get-Date) `
        -VersaoCli falso -TempoLimiteMin 2 -EstadoOrigem ('0' * 64) -OrigemInalterada $true -CheckoutInalterado $true -Hashes @{} -Resultados @($rev)
    $rf = Read-TextoArquivo $regFalso
    $linhaEixo = ($rf -split "`n" | Where-Object { $_ -like '| documentacao |*' })
    Confere 'registro com sessão, tokens, duração e custo do eixo' ($linhaEixo -and $linhaEixo.Contains('00000000-0000-0000-0000-000000000000') -and $linhaEixo.Contains('1 / 1 / 0 / 0'))
    Confere 'registro com a coluna de modelo e esforço confirmados (sem transcrição: modelo do init, esforço "-")' ($rf.Contains('| Modelo e esforço confirmados (transcrição) |') -and $linhaEixo.Contains("| $script:ModeloFixado, - |"))
    Confere 'registro sem coluna de nota, sem a nota e sem a justificativa do revisor' (-not ($rf -match '(?i)\| *nota') -and -not ($rf -match '(?i)\bnota\s*:?\s*3\b') -and -not ($rf -match '\|\s*texto\s*\|'))

    Write-Host '5. Dois modos: produto de nota cega (leigo) e de nota validada (leigo_pu), falsos'
    Confere 'nota validada só em leigo_pu e eng_pu' ((Test-ProdutoValidado leigo_pu) -and (Test-ProdutoValidado eng_pu) -and -not (Test-ProdutoValidado leigo) -and -not (Test-ProdutoValidado engenheiro) -and -not (Test-ProdutoValidado ensaio))
    $autorFalso = Join-Path $tmp 'autor'
    $formCego = Join-Path $autorFalso 'leigo.md'
    $formVal = Join-Path $autorFalso 'leigo_pu.md'
    $null = New-FormularioAutor -Caminho $formCego -Produto leigo -Hash $hash -Ref main -Validada:(Test-ProdutoValidado leigo)
    $null = New-FormularioAutor -Caminho $formVal -Produto leigo_pu -Hash $hash -Ref main -Validada:(Test-ProdutoValidado leigo_pu)
    $fc = Read-TextoArquivo $formCego
    $fv = Read-TextoArquivo $formVal
    Confere 'cego: "Nota (1 a 5):" nos seis eixos, sem as linhas da nota validada' (([regex]::Matches($fc, '(?m)^Nota \(1 a 5\): $')).Count -eq 6 -and -not ($fc -match '(?m)^(Nota do revisor|Validada|Nota validada|Motivo do ajuste)'))
    Confere 'cego: seção "Depois de abrir os reviews" e instrução de preencher antes' ($fc.Contains('## Depois de abrir os reviews') -and $fc.Contains('ANTES de abrir os reviews'))
    $blocoVal = "Nota do revisor: `nValidada (sim ou não): `nNota validada (1 a 5): `nMotivo do ajuste: `n"
    Confere 'validada: as quatro linhas por eixo, logo abaixo do título, nos seis eixos' (@($script:Secoes.Values | Where-Object { $fv.Contains("## $_`n`n$blocoVal") }).Count -eq 6)
    Confere 'validada: sem "Nota (1 a 5):"' (-not ($fv -match '(?m)^Nota \(1 a 5\):'))
    Confere 'validada: sem a seção "Depois de abrir os reviews"' (-not $fv.Contains('Depois de abrir os reviews'))
    Confere 'validada: cabeçalho manda ler o review antes de preencher e cita a §7' ($fv.Contains('LEIA O REVIEW ANTES') -and $fv.Contains('§7') -and -not $fv.Contains('ANTES de abrir os reviews'))
    Confere 'validada: decisões e perguntas iguais às do formulário cego' ($fv.Substring($fv.IndexOf('## Decisões sem perguntar')).TrimEnd() -eq $fc.Substring($fc.IndexOf('## Decisões sem perguntar'), $fc.IndexOf('## Depois de abrir os reviews') - $fc.IndexOf('## Decisões sem perguntar')).TrimEnd())
    Confere 'validada: observações e regras ausentes nos seis eixos' (([regex]::Matches($fv, '(?m)^Observações objetivas:')).Count -eq 6 -and ([regex]::Matches($fv, '(?m)^Regras ausentes:')).Count -eq 6)

    $revFalsos = Join-Path $tmp 'reviews'
    New-Item -ItemType Directory -Force -Path $revFalsos | Out-Null
    $jsonRev = { param($e, $st, $n) ConvertTo-JsonArquivo -Objeto ([ordered]@{ produto = 'leigo_pu'; eixo = $e; status = $st; nota = $n }) -Caminho (Join-Path $revFalsos "leigo_pu-$e.json") }
    & $jsonRev ux ok 4
    & $jsonRev seguranca 'a conferir' 2
    & $jsonRev infra falhou $null
    $av = @(Set-NotasRevisorFormulario -Caminho $formVal -PastaReviews $revFalsos -Produto leigo_pu)
    $fv = Read-TextoArquivo $formVal
    $notaRev = { param($e) if ($fv -match "(?m)## $([regex]::Escape($script:Secoes[$e]))\n\nNota do revisor: (.*)$") { $Matches[1] } else { '?' } }
    Confere 'nota do revisor preenchida do .json: ux 4, seguranca "a conferir (nota 2)", infra "falhou", sem review "pendente"' ((& $notaRev ux) -eq '4' -and (& $notaRev seguranca) -eq 'a conferir (nota 2)' -and (& $notaRev infra) -eq 'falhou' -and (& $notaRev documentacao) -eq 'pendente' -and $av.Count -eq 0)
    $fv = $fv.Replace("## $($script:Secoes['ux'])`n`nNota do revisor: 4`nValidada (sim ou não): `nNota validada (1 a 5): `n", "## $($script:Secoes['ux'])`n`nNota do revisor: 4`nValidada (sim ou não): sim`nNota validada (1 a 5): 4`n").Replace('Total: ', 'Total: 7 MARCA-DO-AUTOR')
    Write-TextoArquivo -Texto ($fv -replace "`n", "`r`n") -Caminho $formVal
    & $jsonRev ux ok 5
    & $jsonRev seguranca ok 2
    & $jsonRev documentacao ok 3
    $av = @(Set-NotasRevisorFormulario -Caminho $formVal -PastaReviews $revFalsos -Produto leigo_pu)
    $fvBruto = Read-TextoArquivo $formVal
    $fv = $fvBruto -replace "`r`n", "`n"
    Confere 'segunda passada: nota já escrita (ux 4) não muda, e sai um aviso com a nota nova' ((& $notaRev ux) -eq '4' -and $av.Count -eq 1 -and $av[0] -like '*ux*4*5*')
    Confere 'segunda passada: status vira nota (seguranca 2), pendente vira nota (documentacao 3)' ((& $notaRev seguranca) -eq '2' -and (& $notaRev documentacao) -eq '3' -and (& $notaRev infra) -eq 'falhou')
    Confere 'o que o autor escreveu continua, com o fim de linha CRLF' ($fv.Contains("Validada (sim ou não): sim`nNota validada (1 a 5): 4") -and $fv.Contains('Total: 7 MARCA-DO-AUTOR') -and ([regex]::Matches($fvBruto, "(?<!`r)`n")).Count -eq 0)
    $antes = [System.IO.File]::GetLastWriteTimeUtc($formVal)
    $av = @(Set-NotasRevisorFormulario -Caminho $formVal -PastaReviews $revFalsos -Produto leigo_pu)
    Confere 'terceira passada sem novidade não regrava o arquivo' ([System.IO.File]::GetLastWriteTimeUtc($formVal) -eq $antes -and $av.Count -eq 1)

    $env:CLAUDE_FALSO_MODO = 'valido'
    $terminalVal = & {
        Invoke-RevisorEixo -Eixo documentacao -Produto leigo_pu -Repo $origem -Ref main -Hash $hash -Checkout $co.Caminho `
            -PastaExecucao $exec -PastaSaida $saidaFalsa -RaizTcc $raizTcc -PastaAvaliador $avaliador -VersaoCli falso -TempoLimiteMin 2 `
            -OcultarNota:(-not (Test-ProdutoValidado leigo_pu))
    } 6>&1 3>&1
    Remove-Item Env:\CLAUDE_FALSO_MODO
    $revVal = @($terminalVal | Where-Object { $_.PSObject.Properties['nota'] })[0]
    $textoVal = (@($terminalVal | Where-Object { $_ -is [System.Management.Automation.InformationRecord] }) | ForEach-Object { "$_" }) -join "`n"
    Confere 'validada: o terminal mostra a nota do eixo' ($textoVal -match '\[documentacao\] [^\n]*nota 3')
    $regVal = Join-Path $saidaFalsa 'leigo_pu-registro.md'
    Add-RegistroExecucao -Caminho $regVal -Produto leigo_pu -Modo 'avaliação' -Repo $origem -Ref main -Hash $hash -Inicio (Get-Date) -Fim (Get-Date) `
        -VersaoCli falso -TempoLimiteMin 2 -EstadoOrigem ('0' * 64) -OrigemInalterada $true -CheckoutInalterado $true -Hashes @{} -Resultados @($revVal) -MostrarNota:(Test-ProdutoValidado leigo_pu)
    $rv = Read-TextoArquivo $regVal
    $linhaVal = ($rv -split "`n" | Where-Object { $_ -like '| documentacao |*' })
    Confere 'validada: registro com a coluna "Nota do revisor" e a nota 3 na linha do eixo' ($rv.Contains('| Eixo | Tentativa | Status | Nota do revisor | Sessão |') -and $linhaVal -like '| documentacao | *| 3 | 00000000-*')
    Confere 'validada: cabeçalho do registro explica que não há nota cega' ($rv.Contains('não há nota cega'))
    Confere 'validada: cabeçalho e separador da tabela com o mesmo número de colunas' ((($rv -split "`n" | Where-Object { $_ -like '| Eixo |*' }).Split('|').Count) -eq (($rv -split "`n" | Where-Object { $_ -like '|---|*' }).Split('|').Count) -and ($linhaVal.Split('|').Count) -eq (($rv -split "`n" | Where-Object { $_ -like '|---|*' }).Split('|').Count))
    Confere 'sem travessão nos formulários e no registro validado' (-not $fv.Contains($travessao) -and -not $fc.Contains($travessao) -and -not $rv.Contains($travessao))
    Remove-PastaSegura -Caminho $tmp
} finally {
    if ($null -ne $formAntes) { Write-TextoArquivo -Texto $formAntes -Caminho $form }
    elseif (Test-Path -LiteralPath $form) { Remove-Item -LiteralPath $form }
}

Write-Host ''
if ($falhas -eq 0) { Write-Host 'Etapa 3 (sem sessão): todos os critérios passaram.' } else { Write-Host "Etapa 3 (sem sessão): $falhas critério(s) falharam."; exit 1 }
