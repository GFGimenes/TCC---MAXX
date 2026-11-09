# Subida do produto falso: não sobe nada, o produto vive em memória no adaptador.
# Contrato de todo subir.ps1: recebe -Checkout, -Dados, -Porta e -Log; devolve
# @{ Base; Porta; ProcessoId (ou $null); Ambiente (hashtable que vai para o relatório) }.
# Variáveis só para o ensaio do rodar.ps1:
#   TESTES_REF_FALSO_FALHAR=1                  simula produto que não sobe
#   TESTES_REF_FALSO_MEXER_NA_ORIGEM=<pasta>   grava um arquivo na origem (deve abortar a gravação)
param(
    [Parameter(Mandatory)][string]$Checkout,
    [Parameter(Mandatory)][string]$Dados,
    [Parameter(Mandatory)][int]$Porta,
    [Parameter(Mandatory)][string]$Log
)
if ($env:TESTES_REF_FALSO_FALHAR -eq '1') {
    Set-Content -LiteralPath $Log -Value 'log simulado: Error: listen EADDRINUSE' -Encoding UTF8
    throw 'O produto falso foi configurado para não subir.'
}
if ($env:TESTES_REF_FALSO_MEXER_NA_ORIGEM) {
    Set-Content -LiteralPath (Join-Path $env:TESTES_REF_FALSO_MEXER_NA_ORIGEM 'mexido-pela-suite.txt') -Value 'x' -Encoding UTF8
}
return [pscustomobject]@{
    Base       = 'falso://memoria'
    Porta      = $Porta
    ProcessoId = $null
    Ambiente   = @{ produto = 'falso em memória' }
}
