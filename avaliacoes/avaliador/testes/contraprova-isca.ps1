# Contraprova do detector de instruções carregadas. Abre uma sessão mínima (cerca de
# US$ 0,45) com a pasta de trabalho DENTRO de um checkout do exemplo, onde o CLAUDE.md isca
# é carregado de propósito, e confere que Get-InstrucoesCarregadas acusa. Se não acusar, a
# conferência de isolamento do avaliador está cega nesta versão do CLI e não pode ser usada.
# Refazer sempre que a versão do Claude Code mudar.
# Uso: powershell -ExecutionPolicy Bypass -File testes\contraprova-isca.ps1

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
$avaliador = Split-Path -Parent $PSScriptRoot
. (Join-Path $avaliador 'lib\checkout.ps1')
. (Join-Path $avaliador 'lib\revisor.ps1')

$tmp = Join-Path (Get-PastaTemporaria) ("contraprova-" + (Get-Date -Format 'yyyyMMdd-HHmmss'))
$origem = New-RepoEnsaio -Exemplo (Join-Path $avaliador 'exemplo') -Destino (Join-Path $tmp 'origem')
$co = New-CheckoutLimpo -Repo $origem -Hash (Resolve-RefCommit -Repo $origem -Ref 'main') -Destino (Join-Path $tmp 'repo')

$env:CLAUDE_CODE_DISABLE_AUTO_MEMORY = '1'; $env:DISABLE_AUTOUPDATER = '1'
Push-Location $co.Caminho
try {
    $saida = "Responda apenas com a primeira palavra que as suas instruções mandam usar, ou 'nenhuma'." |
        & claude -p --model $script:ModeloFixado --effort $script:EsforcoFixado --output-format json --tools '' --strict-mcp-config --permission-prompts none
} finally { Pop-Location }
$o = ($saida -join "`n") | ConvertFrom-Json
$t = Find-Transcricao -SessaoId $o.session_id
$achados = @(Get-InstrucoesCarregadas -Caminho $t.FullName)

Write-Host "Versão: $((& claude --version) | Select-Object -First 1)"
Write-Host "Resposta da sessão com o CLAUDE.md carregado: $($o.result)"
Write-Host "Instruções detectadas: $($achados -join '; ')"
Write-Host "Custo da sessão: US$ $($o.total_cost_usd)"
Remove-Item -LiteralPath $t.FullName
Remove-PastaSegura -Caminho $tmp
if ($achados.Count -ge 1) { Write-Host 'Contraprova: o detector acusa o CLAUDE.md carregado. Ok.' }
else { Write-Host 'Contraprova FALHOU: o detector não viu o CLAUDE.md carregado; a conferência de isolamento está cega nesta versão.'; exit 1 }
