# Teste da etapa 4 sem gastar sessão: revisor de decisões. Validação do bloco e da
# contagem, conferência de leitura completa do export, fluxo com claude falso, conjunto
# por produto e parâmetros do avaliar.ps1.
# Uso: powershell -ExecutionPolicy Bypass -File testes\teste-etapa4.ps1

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
$avaliador = Split-Path -Parent $PSScriptRoot
$raizTcc = (Get-Item -LiteralPath (Join-Path $avaliador '..\..')).FullName
. (Join-Path $avaliador 'lib\checkout.ps1')
. (Join-Path $avaliador 'lib\revisor.ps1')
. (Join-Path $avaliador 'lib\registro.ps1')
. (Join-Path $avaliador 'lib\decisoes.ps1')

$falhas = 0
function Confere {
    param([string]$Descricao, [bool]$Condicao)
    if ($Condicao) { Write-Host "  ok     $Descricao" }
    else { Write-Host "  FALHOU $Descricao"; $script:falhas++ }
}
$exportFicticio = Join-Path $avaliador 'ensaio\ensaio-sessao.txt'
$tmp = Join-Path (Get-PastaTemporaria) ("teste-etapa4-" + (Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Force -Path $tmp | Out-Null

Write-Host '1. Identificador do export'
Confere 'eng_07_posts-sessao.txt vira eng_07_posts' ((Get-IdExport -Caminho 'C:\x\eng_07_posts-sessao.txt') -eq 'eng_07_posts')
Confere 'leigo_pu-sessao.txt vira leigo_pu' ((Get-IdExport -Caminho 'leigo_pu-sessao.txt') -eq 'leigo_pu')

Write-Host '2. Bloco do revisor de decisões'
$valido = '{"decisoes": [{"descricao": "a", "trecho": "t", "tipo": "Segurança", "forma": "declarada", "duvidosa": false}, {"descricao": "b", "trecho": "t", "tipo": "UX e visual", "forma": "silenciosa", "duvidosa": true}], "perguntas": [{"texto": "p", "respondida": false}], "contagem": {"decisoes": 2, "declaradas": 1, "silenciosas": 1, "duvidosas": 1, "perguntas": 1, "perguntas_respondidas": 0}}'
$d = $valido | ConvertFrom-Json
Confere 'bloco coerente aceito' (@(Test-BlocoDecisoes -Dados $d).Count -eq 0)
Confere 'tipo sem acento e em minúsculas aceito ("seguranca")' (@(Test-BlocoDecisoes -Dados ($valido.Replace('"Segurança"', '"seguranca"') | ConvertFrom-Json)).Count -eq 0)
Confere 'tipo fora dos sete recusado' (@(Test-BlocoDecisoes -Dados ($valido.Replace('"UX e visual"', '"performance"') | ConvertFrom-Json)).Count -gt 0)
Confere 'forma fora de declarada ou silenciosa recusada' (@(Test-BlocoDecisoes -Dados ($valido.Replace('"silenciosa"', '"implicita"') | ConvertFrom-Json)).Count -gt 0)
Confere 'duvidosa como texto recusada' (@(Test-BlocoDecisoes -Dados ($valido.Replace('"duvidosa": true', '"duvidosa": "sim"') | ConvertFrom-Json)).Count -gt 0)
Confere 'contagem de decisões diferente da lista recusada' (@(Test-BlocoDecisoes -Dados ($valido.Replace('"decisoes": 2', '"decisoes": 3') | ConvertFrom-Json)).Count -gt 0)
Confere 'contagem de duvidosas diferente da lista recusada' (@(Test-BlocoDecisoes -Dados ($valido.Replace('"duvidosas": 1', '"duvidosas": 0') | ConvertFrom-Json)).Count -gt 0)
Confere 'perguntas respondidas diferente da lista recusada' (@(Test-BlocoDecisoes -Dados ($valido.Replace('"perguntas_respondidas": 0', '"perguntas_respondidas": 1') | ConvertFrom-Json)).Count -gt 0)
Confere 'campo a mais na contagem recusado' (@(Test-BlocoDecisoes -Dados ($valido.Replace('"perguntas_respondidas": 0}', '"perguntas_respondidas": 0, "total": 3}') | ConvertFrom-Json)).Count -gt 0)

Write-Host '3. Leitura completa do export'
$arq = Join-Path $tmp 'x-sessao.txt'
$linhasX = 1..10 | ForEach-Object { "linha $_ com acentuação ⏺" }
Write-TextoArquivo -Texto (($linhasX -join "`n") + "`n") -Caminho $arq
function Leitura { param([string]$Caminho, [int]$Inicio, [string[]]$Linhas) [pscustomobject]@{ filePath = $Caminho; startLine = $Inicio; numLines = $Linhas.Count; totalLines = 10; content = ($Linhas -join "`n") } }
$c = Get-CoberturaLeitura -Arquivo $arq -Leituras @(Leitura $arq 1 $linhasX)
Confere 'uma leitura inteira: 10 de 10, completa' ($c.completa -and $c.lidas -eq 10 -and $c.total -eq 10)
$c = Get-CoberturaLeitura -Arquivo $arq -Leituras @((Leitura $arq 1 $linhasX[0..4]), (Leitura $arq 6 $linhasX[5..9]))
Confere 'duas leituras com offset que somam o arquivo: completa' ($c.completa -and $c.chamadas -eq 2)
$c = Get-CoberturaLeitura -Arquivo $arq -Leituras @((Leitura $arq 1 $linhasX[0..4]), (Leitura $arq 8 $linhasX[7..9]))
Confere 'buraco nas linhas 6-7: incompleta, faltando "6-7"' (-not $c.completa -and ($c.faltando -join ',') -eq '6-7')
$cortadas = @($linhasX); $cortadas[2] = 'linha 3 com'
$c = Get-CoberturaLeitura -Arquivo $arq -Leituras @(Leitura $arq 1 $cortadas)
Confere 'linha devolvida cortada não conta como lida' (-not $c.completa -and ($c.faltando -join ',') -eq '3')
$c = Get-CoberturaLeitura -Arquivo $arq -Leituras @(Leitura (Join-Path $tmp 'outro.txt') 1 $linhasX)
Confere 'leitura de outro arquivo não conta' (-not $c.completa -and $c.chamadas -eq 0)
$c = Get-CoberturaLeitura -Arquivo $arq -Leituras @(Leitura ($arq.Replace('\', '/').ToUpper()) 1 $linhasX)
Confere 'mesmo arquivo com barras normais e outra caixa conta' ($c.completa)
$c = Get-CoberturaLeitura -Arquivo $arq -Leituras @()
Confere 'sem leitura nenhuma: incompleta' (-not $c.completa -and $c.lidas -eq 0)

Write-Host '4. Fluxo com claude falso'
$script:ClaudeArquivo = 'powershell.exe'
$script:ClaudePrefixo = '-NoProfile -ExecutionPolicy Bypass -File "' + (Join-Path $PSScriptRoot 'claude-falso.ps1') + '"'
$saida = Join-Path $tmp 'saida'; $exec = Join-Path $tmp 'exec'
New-Item -ItemType Directory -Force -Path $saida, $exec | Out-Null
$hashFicticio = Get-HashArquivo $exportFicticio
$res = @{}
foreach ($modo in @('completo', 'parcial', 'truncada', 'contagem')) {
    # Cada modo com o seu export (cópia), para não virar tentativa do anterior.
    $exp = Join-Path $tmp "f$modo-sessao.txt"
    Copy-Item -LiteralPath $exportFicticio -Destination $exp
    $env:CLAUDE_FALSO_MODO = "decisoes-$modo"
    $res[$modo] = Invoke-RevisorDecisoes -Export $exp -Produto teste -Hash ('a' * 40) -Ref main -PastaExecucao $exec -PastaSaida $saida `
        -RaizTcc $raizTcc -PastaAvaliador $avaliador -VersaoCli falso -TempoLimiteMin 2 6>$null
}
Remove-Item Env:\CLAUDE_FALSO_MODO
$rc = $res['completo']
$totalLinhas = (Get-LinhasArquivo -Caminho $exportFicticio).Count
Confere "completo: export lido inteiro ($($rc.linhas_lidas) de $totalLinhas linhas)" ($rc.leitura_completa -and $rc.linhas_lidas -eq $totalLinhas)
Confere 'completo: 3 decisões, 2 perguntas, 1 respondida' (@($rc.decisoes).Count -eq 3 -and $rc.contagem.perguntas -eq 2 -and $rc.contagem.perguntas_respondidas -eq 1)
Confere 'completo: único motivo é a falta de transcrição (claude falso)' (@($rc.motivos).Count -eq 1 -and $rc.motivos[0] -like '*transcrição*')
Confere 'completo: nenhum acesso fora da pasta da sessão' (@($rc.acessos_fora).Count -eq 0)
Confere 'parcial: "a conferir" com export não lido inteiro (5 linhas)' ($res['parcial'].status -eq 'a conferir' -and ($res['parcial'].motivos -join ' ') -like "*export não lido inteiro: 5 de $totalLinhas*")
Confere 'truncada: "a conferir", falta a linha 4' (($res['truncada'].motivos -join ' ') -like '*não lido inteiro*faltam 4)*')
Confere 'contagem errada: "a conferir" por bloco inconsistente' (($res['contagem'].motivos -join ' ') -like '*bloco JSON inconsistente*contagem.decisoes = 2*')
Confere 'export fictício intacto' ((Get-HashArquivo $exportFicticio) -eq $hashFicticio)
Confere '.md e .json por export gravados' ((Test-Path (Join-Path $saida 'teste-decisoes-fcompleto.md')) -and (Test-Path (Join-Path $saida 'teste-decisoes-fcompleto.json')))
$pr = Read-TextoArquivo (Join-Path $saida 'teste-decisoes-fcompleto.prompt.txt')
Confere 'prompt com o caminho da cópia na sessão, sem marcador sobrando' ($pr.Contains('\sessao-decisoes-fcompleto-t1\fcompleto-sessao.txt') -and -not ($pr -match '\{\{'))

Write-Host '5. Conjunto por produto'
$env:CLAUDE_FALSO_MODO = 'decisoes-completo'
$null = Invoke-RevisorDecisoes -Export (Join-Path $tmp 'fcompleto-sessao.txt') -Produto teste -Hash ('a' * 40) -Ref main -PastaExecucao $exec -PastaSaida $saida `
    -RaizTcc $raizTcc -PastaAvaliador $avaliador -VersaoCli falso -TempoLimiteMin 2 6>$null
Remove-Item Env:\CLAUDE_FALSO_MODO
Confere 'segunda execução do mesmo export vira tentativa 2, a 1 guardada como -t1' ((Test-Path (Join-Path $saida 'teste-decisoes-fcompleto-t1.json')) -and ((Read-TextoArquivo (Join-Path $saida 'teste-decisoes-fcompleto.json') | ConvertFrom-Json).tentativa -eq 2))
$cj = Update-DecisoesProduto -PastaSaida $saida -Produto teste
Confere 'conjunto com os quatro exports, sem as tentativas antigas' (@($cj.exports).Count -eq 4)
Confere 'conjunto "a conferir" e totais incompletos quando há export a conferir' ($cj.status -eq 'a conferir' -and -not $cj.totais_completos -and (Read-TextoArquivo (Join-Path $saida 'teste-decisoes.md')).Contains('INCOMPLETOS'))
# Dois exports ok (JSONs montados à mão): totais somados, conjunto ok.
$ok = Join-Path $tmp 'ok'; New-Item -ItemType Directory -Force -Path $ok | Out-Null
foreach ($par in @(@('r1', 2, 1), @('r2', 3, 0))) {
    $j = [ordered]@{ export_id = $par[0]; status = 'ok'; motivos = @(); leitura_completa = $true; decisoes = @(); perguntas = @()
        contagem = [ordered]@{ decisoes = $par[1]; declaradas = $par[1]; silenciosas = 0; duvidosas = 0; perguntas = $par[2]; perguntas_respondidas = 0 } }
    ConvertTo-JsonArquivo -Objeto $j -Caminho (Join-Path $ok "p-decisoes-$($par[0]).json")
}
$cj = Update-DecisoesProduto -PastaSaida $ok -Produto p
Confere 'dois exports ok: conjunto ok com 5 decisões e 1 pergunta' ($cj.status -eq 'ok' -and $cj.totais.decisoes -eq 5 -and $cj.totais.perguntas -eq 1)

Write-Host '6. Parâmetros do avaliar.ps1'
$r = & (Join-Path $avaliador 'avaliar.ps1') -Ensaio -SemClaude -Eixos decisoes 3>$null 6>$null
$pd = Join-Path $r.pasta_saida 'ensaio-decisoes-ensaio.prompt.txt'
Confere 'ensaio sem claude do revisor de decisões usa o export fictício' ((Test-Path $pd) -and (Read-TextoArquivo $pd).Contains('ensaio-sessao.txt') -and $r.resultados[0].rotulo -eq 'decisoes (ensaio)')
$reg = Read-TextoArquivo $r.registro
Confere 'registro com a linha do revisor de decisões e os hashes do prompt e do export' ($reg.Contains('| decisoes (ensaio) |') -and $reg.Contains('SHA-256 de avaliador/prompts/decisoes.md') -and $reg.Contains('SHA-256 de export ensaio-sessao.txt'))
$erro = $null
try { & (Join-Path $avaliador 'avaliar.ps1') -Ensaio -SemClaude -Eixos ux -Export $exportFicticio 3>$null 6>$null | Out-Null } catch { $erro = $_.Exception.Message }
Confere '-Export sem decisoes em -Eixos é recusado' ($erro -like '*inclua decisoes*')
$erro = $null
try { & (Join-Path $avaliador 'avaliar.ps1') -Ensaio -SemClaude -Eixos decisoes -Export (Join-Path $tmp 'nao-existe.txt') 3>$null 6>$null | Out-Null } catch { $erro = $_.Exception.Message }
Confere 'export inexistente é recusado' ($erro -like '*Export não encontrado*')
$erro = $null
try { & (Join-Path $avaliador 'avaliar.ps1') -Produto leigo -Repo $tmp -Ref main -Eixos decisoes 3>$null 6>$null | Out-Null } catch { $erro = $_.Exception.Message }
Confere 'avaliação real com decisoes e sem -Export é recusada antes do checkout' ($erro -like '*precisa de -Export*')

Remove-PastaSegura -Caminho $tmp
Write-Host ''
if ($falhas -eq 0) { Write-Host 'Etapa 4 (sem sessão): todos os critérios passaram.' } else { Write-Host "Etapa 4 (sem sessão): $falhas critério(s) falharam."; exit 1 }
