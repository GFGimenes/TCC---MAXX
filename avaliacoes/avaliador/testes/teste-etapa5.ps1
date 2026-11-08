# Teste da etapa 5 (sem sessão): consolidar.ps1 com reviews e formulários fictícios numa
# pasta temporária. Os valores esperados foram calculados à mão a partir das notas abaixo.
# Uso: powershell -ExecutionPolicy Bypass -File testes\teste-etapa5.ps1

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
$avaliador = Split-Path -Parent $PSScriptRoot
. (Join-Path $avaliador 'lib\checkout.ps1')
. (Join-Path $avaliador 'lib\revisor.ps1')
. (Join-Path $avaliador 'lib\registro.ps1')
. (Join-Path $avaliador 'lib\consolidacao.ps1')

$falhas = 0
function Confere {
    param([string]$Descricao, [bool]$Condicao)
    if ($Condicao) { Write-Host "  ok     $Descricao" }
    else { Write-Host "  FALHOU $Descricao"; $script:falhas++ }
}
$tmp = Join-Path (Get-PastaTemporaria) ("teste-etapa5-" + (Get-Date -Format 'yyyyMMdd-HHmmss'))
$rev = Join-Path $tmp 'reviews'; $aut = Join-Path $tmp 'autor'; $sai = Join-Path $tmp 'saida'
New-Item -ItemType Directory -Force -Path $rev, $aut, $sai | Out-Null
$eixos = @($script:Secoes.Keys)  # ux, seguranca, infra, documentacao, codigo, arquitetura

# Notas do autor (ux, seg, infra, doc, cod, arq) e decisões / perguntas sem resposta.
$autor = @{
    leigo      = @{ notas = @(3, 2, 2, 2, 2, 2); dec = 10; per = 4 }
    engenheiro = @{ notas = @(4, 4, 4, 4, 4, 4); dec = 6;  per = 1 }
    leigo_pu   = @{ notas = @(2, 1, 1, 2, 1, 1); dec = 15; per = 3 }
    eng_pu     = @{ notas = @(4, 3, 2, 4, 3, 3); dec = 5;  per = 2 }
}
function Formulario {
    param([string]$Produto, [object[]]$Notas, $Dec, $Per, [string]$Regra, [string]$Explicacao)
    $c = Join-Path $aut "$Produto.md"
    if (Test-Path $c) { Remove-Item $c }
    $null = New-FormularioAutor -Caminho $c -Produto $Produto -Hash ('b' * 40) -Ref main
    $t = Read-TextoArquivo $c
    for ($i = 0; $i -lt 6; $i++) {
        $t = $t.Replace("## $($script:Secoes[$eixos[$i]])`n`nNota (1 a 5): `n", "## $($script:Secoes[$eixos[$i]])`n`nNota (1 a 5): $($Notas[$i])`n")
    }
    $k = $t.IndexOf("Total: `n"); $t = $t.Substring(0, $k) + "Total: $Dec`n" + $t.Substring($k + 8)
    $k = $t.IndexOf("Total: `n"); $t = $t.Substring(0, $k) + "Total: $Per`n" + $t.Substring($k + 8)
    if ($Regra) { $t = $t.Replace("## 2. Segurança`n`nNota (1 a 5): $($Notas[1])`n`nObservações objetivas:`n`n- `n`nRegras ausentes:`n`n- `n", "## 2. Segurança`n`nNota (1 a 5): $($Notas[1])`n`nObservações objetivas:`n`n- algo`n`nRegras ausentes:`n`n- $Regra`n") }
    if ($Explicacao) { $t = $t.TrimEnd() + "`n- $Explicacao`n" }
    Write-TextoArquivo -Texto $t -Caminho $c
}
function Review {
    param([string]$Produto, [string]$Eixo, $Nota, [string]$Status = 'ok', [string[]]$Regras = @(), [string[]]$Decisoes = @())
    ConvertTo-JsonArquivo -Objeto ([ordered]@{ produto = $Produto; eixo = $Eixo; status = $Status; nota = $Nota; regras_ausentes = @($Regras); decisoes_do_agente = @($Decisoes) }) -Caminho (Join-Path $rev "$Produto-$Eixo.json")
}
function Rodar {
    $saidaTerminal = & (Join-Path $avaliador 'consolidar.ps1') -PastaReviews $rev -PastaAutor $aut -PastaSaida $sai 6>&1
    $csv = [System.IO.File]::ReadAllText((Join-Path $sai 'notas.csv'), [System.Text.Encoding]::UTF8) | ConvertFrom-Csv -Delimiter ';'
    return [pscustomobject]@{ terminal = (($saidaTerminal | ForEach-Object { "$_" }) -join "`n"); csv = $csv; md = Read-TextoArquivo (Join-Path $sai 'notas.md') }
}
function Linha { param($Csv, [string]$P, [string]$E) return @($Csv | Where-Object { $_.produto -eq $P -and $_.eixo -eq $E })[0] }

# Reviews: todos 3, com exceções.
foreach ($p in $autor.Keys) { foreach ($e in $eixos) { Review $p $e 3 } }
Review leigo seguranca 4 -Regras @('R1 sem CSRF') -Decisoes @('D1 sessão em cookie', 'D2 senha com bcrypt')
Review leigo ux 3 -Decisoes @('D3 tema escuro')
Remove-Item (Join-Path $rev 'engenheiro-arquitetura.json')
Review engenheiro infra 4 -Status 'a conferir'
Review leigo_pu documentacao 3 -Decisoes @('DEC-LEIGO_PU-SECRETA')
ConvertTo-JsonArquivo -Objeto ([ordered]@{ status = 'a conferir'; totais = [ordered]@{ decisoes = 7; declaradas = 3; silenciosas = 4; duvidosas = 1; perguntas = 2; perguntas_respondidas = 1 } }) -Caminho (Join-Path $rev 'leigo-decisoes.json')

Write-Host '1. Sem formulário nenhum: tudo pendente, revisor oculto'
$r = Rodar
Confere 'nota do autor pendente e do revisor oculta' ((Linha $r.csv leigo ux).nota_autor -eq 'pendente' -and (Linha $r.csv leigo ux).nota_revisor -like 'oculta*')
Confere 'H1, H2 e H3 pendentes' ($r.md.Contains('## H1: pendente') -and $r.md.Contains('## H2: pendente') -and $r.md.Contains('## H3: pendente'))
Confere 'decisões do revisor ocultas no CSV e no MD' ((Linha $r.csv leigo seguranca).decisoes_listadas -like 'oculta*' -and -not $r.md.Contains('D1 sessão em cookie'))
Confere 'vinte e quatro linhas no CSV (4 produtos x 6 eixos)' (@($r.csv).Count -eq 24)

Write-Host '2. Cenário completo'
Formulario leigo $autor.leigo.notas $autor.leigo.dec $autor.leigo.per -Regra 'A1 sem limite de tentativas' -Explicacao 'Segurança: o revisor não viu que a senha fica em texto puro.'
foreach ($p in @('engenheiro', 'leigo_pu', 'eng_pu')) { Formulario $p $autor[$p].notas $autor[$p].dec $autor[$p].per }
$r = Rodar
$l = Linha $r.csv leigo seguranca
Confere 'leigo, Segurança: revisor 4, autor 2, divergência -2*' ($l.nota_revisor -eq '4' -and $l.nota_autor -eq '2' -and $l.divergencia -eq '-2*')
Confere 'leigo, UX: divergência 0' ((Linha $r.csv leigo ux).divergencia -eq '0')
Confere 'engenheiro, UX: autor 4, revisor 3, divergência +1' ((Linha $r.csv engenheiro ux).divergencia -eq '+1')
Confere 'engenheiro, Arquitetura sem review: revisor e divergência pendentes' ((Linha $r.csv engenheiro arquitetura).nota_revisor -eq 'pendente' -and (Linha $r.csv engenheiro arquitetura).divergencia -eq 'pendente')
Confere 'engenheiro, Infra "a conferir": sem número e divergência pendente' ((Linha $r.csv engenheiro infra).nota_revisor -eq 'a conferir' -and (Linha $r.csv engenheiro infra).divergencia -eq 'pendente')
Confere 'regras ausentes do revisor e do autor na mesma célula' ($l.regras_ausentes -eq '[revisor] R1 sem CSRF | [autor] A1 sem limite de tentativas')
Confere 'decisões listadas sem contagem, como texto' ($l.decisoes_listadas -eq 'D1 sessão em cookie | D2 senha com bcrypt')
Confere 'total dos seis eixos do autor (leigo = 13) e do revisor (leigo = 19)' ($r.md.Contains('| Total dos seis eixos | 19 | 13 | |'))
Confere 'total do revisor pendente quando falta review (engenheiro)' ($r.md -match '### engenheiro[\s\S]*?\| Total dos seis eixos \| pendente \| 24 \| \|')
Confere 'H1 apoiada, 5 de 5' ($r.md.Contains('## H1: apoiada') -and $r.md.Contains('Resultado: apoiada, 5 de 5 eixos atendem.'))
Confere 'H1: linha de Infra com eng_pu 2, leigo_pu 1, +1, sim, iterativa +2' ($r.md.Contains('| 3. Infraestrutura | 2 | 1 | +1 | sim | +2 |'))
Confere 'H2 apoiada, nenhum eixo abaixo' ($r.md.Contains('## H2: apoiada') -and $r.md.Contains('Resultado: apoiada, 0 eixo(s)'))
Confere 'H3 apoiada: leigo_pu - eng_pu = +10, leigo - engenheiro = +4' ($r.md.Contains('## H3: apoiada') -and $r.md.Contains('leigo_pu - eng_pu = +10, leigo - engenheiro = +4'))
Confere 'H3 mostra o revisor de decisões como insumo incompleto' ($r.md.Contains('| leigo | 10 | 4 | 7 decisões (1 duvidosas), 2 perguntas (1 respondidas), INCOMPLETO (export a conferir) |'))
Confere 'exploratória de UX: +1, +2, 0, +1, médias 1,5 e 0,5, sim' ($r.md.Contains('| 1. Experiência do usuário | +1 | +2 | 0 | +1 | 1,5 | 0,5 | sim |'))
Confere 'explicação de divergência do autor no MD' ($r.md.Contains('- Segurança: o revisor não viu que a senha fica em texto puro.'))
Confere 'decisões dos revisores juntadas por produto, com o eixo' ($r.md.Contains('- [seguranca] D1 sessão em cookie') -and $r.md.Contains('- [ux] D3 tema escuro'))
Confere 'terminal mostra o estado dos produtos e nenhuma nota' ($r.terminal -match 'leigo\s+reviews 6/6; formulário do autor completo' -and $r.terminal -match 'H1 apoiada' -and -not ($r.terminal -match '(?i)nota\s*\d|\|\s*\d\s*\|'))

Write-Host '3. Formulário incompleto e nota inválida'
$n = @($autor.leigo_pu.notas); $n[5] = ''
Formulario leigo_pu $n $autor.leigo_pu.dec $autor.leigo_pu.per
$r = Rodar
Confere 'leigo_pu com formulário incompleto: revisor oculto nos seis eixos' (@($r.csv | Where-Object { $_.produto -eq 'leigo_pu' -and $_.nota_revisor -like 'oculta*' }).Count -eq 6)
Confere 'decisão listada pelo revisor do leigo_pu não aparece' (-not $r.md.Contains('DEC-LEIGO_PU-SECRETA') -and -not ([System.IO.File]::ReadAllText((Join-Path $sai 'notas.csv'))).Contains('DEC-LEIGO_PU-SECRETA'))
Confere 'H1 pendente, faltando arquitetura' ($r.md.Contains('## H1: pendente') -and $r.md.Contains('faltam notas do autor em: arquitetura'))
$n = @($autor.leigo_pu.notas); $n[5] = '4 talvez'
Formulario leigo_pu $n $autor.leigo_pu.dec $autor.leigo_pu.per
$r = Rodar
Confere 'nota "4 talvez" é inválida, não vira 4' ((Linha $r.csv leigo_pu arquitetura).nota_autor -eq 'inválida' -and $r.md.Contains("nota de arquitetura inválida: '4 talvez'"))

Write-Host '4. Fronteiras de H1 e H2'
Formulario leigo_pu $autor.leigo_pu.notas $autor.leigo_pu.dec $autor.leigo_pu.per
$n = @($autor.eng_pu.notas); $n[2] = 1   # infra: eng_pu 1 = leigo_pu 1; eng_pu 1 < leigo 2
Formulario eng_pu $n $autor.eng_pu.dec $autor.eng_pu.per
$r = Rodar
Confere 'H1 apoiada com 4 de 5' ($r.md.Contains('Resultado: apoiada, 4 de 5 eixos atendem.'))
Confere 'H2 não apoiada, 1 eixo abaixo (Infra: -1)' ($r.md.Contains('## H2: não apoiada') -and $r.md.Contains('| 3. Infraestrutura | 1 | 2 | -1 | sim |'))
$n[3] = 2   # documentação: eng_pu 2 = leigo_pu 2
Formulario eng_pu $n $autor.eng_pu.dec $autor.eng_pu.per
$r = Rodar
Confere 'H1 não apoiada com 3 de 5' ($r.md.Contains('## H1: não apoiada') -and $r.md.Contains('3 de 5 eixos'))
Formulario eng_pu $autor.eng_pu.notas 15 $autor.eng_pu.per
$r = Rodar
Confere 'H3 não apoiada com leigo_pu = eng_pu' ($r.md.Contains('## H3: não apoiada'))

Write-Host '5. Saída'
Confere 'CSV com separador ; e cabeçalho previsto' (([System.IO.File]::ReadAllLines((Join-Path $sai 'notas.csv'), [System.Text.Encoding]::UTF8)[0]) -eq '"produto";"eixo";"nota_revisor";"nota_autor";"divergencia";"regras_ausentes";"decisoes_listadas"')
Confere 'sem travessão no MD nem no CSV' (-not $r.md.Contains([string][char]0x2014) -and -not ([System.IO.File]::ReadAllText((Join-Path $sai 'notas.csv'))).Contains([string][char]0x2014))
Confere 'nada gravado fora da pasta de saída indicada' (@(Get-ChildItem -LiteralPath $sai -File).Count -eq 2)

Remove-PastaSegura -Caminho $tmp
Write-Host ''
if ($falhas -eq 0) { Write-Host 'Etapa 5 (sem sessão): todos os critérios passaram.' } else { Write-Host "Etapa 5 (sem sessão): $falhas critério(s) falharam."; exit 1 }
