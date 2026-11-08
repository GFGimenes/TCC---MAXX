# Roda os testes sem sessão (custo zero) das etapas 1 a 5 e resume.
# Uso: powershell -ExecutionPolicy Bypass -File avaliacoes\avaliador\testes\rodar-testes.ps1

$ErrorActionPreference = 'Stop'
$testes = @('teste-checkout', 'teste-revisor', 'teste-etapa3', 'teste-etapa4', 'teste-etapa5')
$falhou = @()
foreach ($t in $testes) {
    Write-Host "== $t"
    & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "$t.ps1") | Select-String -CaseSensitive -Pattern 'FALHOU|critérios passaram|falharam' | ForEach-Object { Write-Host "   $_" }
    if ($LASTEXITCODE -ne 0) { $falhou += $t }
}
Write-Host ''
if ($falhou.Count -eq 0) { Write-Host "Testes sem sessão: os $($testes.Count) passaram." }
else { Write-Host "Testes sem sessão: falharam $($falhou -join ', ')."; exit 1 }
