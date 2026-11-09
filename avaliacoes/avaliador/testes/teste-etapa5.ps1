# Teste da etapa 5 (sem sessão): consolidar.ps1 com reviews e formulários fictícios numa
# pasta temporária. Os valores esperados foram calculados à mão a partir das notas abaixo.
# Cobre os dois modos: nota cega (leigo, engenheiro) e nota validada (leigo_pu, eng_pu).
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
# Formulário falso. Nos produtos de nota cega (leigo, engenheiro), preenche "Nota (1 a 5):".
# Nos de nota validada (leigo_pu, eng_pu), o formulário é o validado: a nota do revisor vem
# dos reviews fictícios, e por padrão o eixo é validado ("sim") quando a nota é a do revisor
# (3) e ajustado ("não", com motivo) quando não é. $Validacao troca esse padrão por eixo.
function Formulario {
    param([string]$Produto, [object[]]$Notas, $Dec, $Per, [string]$Regra, [string]$Explicacao, [hashtable]$Validacao = @{})
    $val = Test-ProdutoValidado $Produto
    $c = Join-Path $aut "$Produto.md"
    if (Test-Path $c) { Remove-Item $c }
    $null = New-FormularioAutor -Caminho $c -Produto $Produto -Hash ('b' * 40) -Ref main -Validada:$val
    if ($val) { $null = Set-NotasRevisorFormulario -Caminho $c -PastaReviews $rev -Produto $Produto }
    $porTitulo = @{}; foreach ($e in $eixos) { $porTitulo[$script:Secoes[$e]] = $e }
    $linhas = @((Read-TextoArquivo $c) -split "`n")
    $sec = $null; $modo = $null
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $x = $linhas[$i]
        if ($x -match '^##\s+(.+)$') { $sec = $porTitulo[$Matches[1]]; $modo = $null; continue }
        if (-not $sec) { continue }
        $n = "$($Notas[[array]::IndexOf($eixos, $sec)])"
        $vEixo = 'não'; if ($n -eq '3') { $vEixo = 'sim' } elseif ($n -eq '') { $vEixo = '' }
        $mEixo = ''; if ($vEixo -eq 'não') { $mEixo = "motivo $sec" }
        if ($Validacao.ContainsKey($sec)) { $vEixo = $Validacao[$sec].validada; $mEixo = $Validacao[$sec].motivo }
        if (-not $val -and $x -eq 'Nota (1 a 5): ') { $linhas[$i] = "Nota (1 a 5): $n" }
        if ($val -and $x -eq 'Nota validada (1 a 5): ') { $linhas[$i] = "Nota validada (1 a 5): $n" }
        if ($val -and $x -eq 'Validada (sim ou não): ') { $linhas[$i] = "Validada (sim ou não): $vEixo" }
        if ($val -and $x -eq 'Motivo do ajuste: ') { $linhas[$i] = "Motivo do ajuste: $mEixo" }
        if ($x -eq 'Regras ausentes:') { $modo = 'regras'; continue }
        if ($Regra -and $sec -eq 'seguranca' -and $modo -eq 'regras' -and $x -eq '- ') { $linhas[$i] = "- $Regra"; $modo = $null }
    }
    $t = $linhas -join "`n"
    $k = $t.IndexOf("Total: `n"); $t = $t.Substring(0, $k) + "Total: $Dec`n" + $t.Substring($k + 8)
    $k = $t.IndexOf("Total: `n"); $t = $t.Substring(0, $k) + "Total: $Per`n" + $t.Substring($k + 8)
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
Review leigo documentacao 3 -Decisoes @('DEC-LEIGO-SECRETA')
Review leigo_pu documentacao 3 -Decisoes @('DEC-LEIGO_PU-VISIVEL')
ConvertTo-JsonArquivo -Objeto ([ordered]@{ status = 'a conferir'; totais = [ordered]@{ decisoes = 7; declaradas = 3; silenciosas = 4; duvidosas = 1; perguntas = 2; perguntas_respondidas = 1 } }) -Caminho (Join-Path $rev 'leigo-decisoes.json')
ConvertTo-JsonArquivo -Objeto ([ordered]@{ status = 'ok'; totais = [ordered]@{ decisoes = 12; declaradas = 5; silenciosas = 7; duvidosas = 0; perguntas = 0; perguntas_respondidas = 0 } }) -Caminho (Join-Path $rev 'leigo_pu-decisoes.json')

Write-Host '1. Sem formulário nenhum: tudo pendente; revisor oculto só na nota cega'
$r = Rodar
Confere 'leigo (cego): nota do autor pendente e do revisor oculta' ((Linha $r.csv leigo ux).nota_autor -eq 'pendente' -and (Linha $r.csv leigo ux).nota_revisor -like 'oculta*')
Confere 'H1, H2 e H3 pendentes' ($r.md.Contains('## H1: pendente') -and $r.md.Contains('## H2: pendente') -and $r.md.Contains('## H3: pendente'))
Confere 'leigo (cego): decisões do revisor ocultas no CSV e no MD' ((Linha $r.csv leigo seguranca).decisoes_listadas -like 'oculta*' -and -not $r.md.Contains('D1 sessão em cookie') -and -not $r.md.Contains('DEC-LEIGO-SECRETA'))
Confere 'leigo_pu (validada): revisor visível (3) sem formulário, autor pendente, divergência n/a (validada)' (@($r.csv | Where-Object { $_.produto -eq 'leigo_pu' -and $_.nota_revisor -eq '3' -and $_.nota_autor -eq 'pendente' -and $_.divergencia -eq 'n/a (validada)' }).Count -eq 6)
Confere 'eng_pu (validada): divergência n/a (validada) nos seis eixos' (@($r.csv | Where-Object { $_.produto -eq 'eng_pu' -and $_.divergencia -eq 'n/a (validada)' }).Count -eq 6)
Confere 'leigo_pu: decisões do revisor visíveis no CSV, no MD e no insumo de H3' ((Linha $r.csv leigo_pu documentacao).decisoes_listadas -eq 'DEC-LEIGO_PU-VISIVEL' -and $r.md.Contains('- [documentacao] DEC-LEIGO_PU-VISIVEL') -and $r.md.Contains('| leigo_pu | pendente | pendente | 12 decisões (0 duvidosas), 0 perguntas (0 respondidas) |'))
Confere 'leigo_pu: total do revisor visível (18)' ($r.md -match '### leigo_pu[\s\S]*?\| Total dos seis eixos \| 18 \| pendente \| \|')
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
$ls = Linha $r.csv leigo_pu seguranca
Confere 'leigo_pu, Segurança: revisor 3, autor 1 (nota validada), divergência n/a (validada)' ($ls.nota_revisor -eq '3' -and $ls.nota_autor -eq '1' -and $ls.divergencia -eq 'n/a (validada)')
Confere 'eng_pu, UX: revisor 3, autor 4, divergência n/a (validada)' ((Linha $r.csv eng_pu ux).nota_autor -eq '4' -and (Linha $r.csv eng_pu ux).divergencia -eq 'n/a (validada)')
Confere 'leigo_pu: totais do revisor (18) e da nota validada (8)' ($r.md.Contains('| Total dos seis eixos | 18 | 8 | |'))
Confere 'ajuste listado com a nota do revisor, a validada e o motivo' ($r.md.Contains('Ajustes do autor à nota do revisor:') -and $r.md.Contains('- 2. Segurança: revisor 3, validada 1. Motivo: motivo seguranca'))
Confere 'eixo validado com "sim" não entra nos ajustes (eng_pu, Segurança 3)' (-not $r.md.Contains('- 2. Segurança: revisor 3, validada 3.'))
Confere 'seis ajustes no leigo_pu, três no eng_pu' (([regex]::Matches($r.md, '(?m)^- \d\. .+: revisor 3, validada [^3]\. Motivo: motivo ')).Count -eq 9)
Confere 'formulários validados coerentes: nenhum problema relatado' (-not $r.md.Contains('Problemas no formulário'))
Confere 'nota cega sem a lista de ajustes (engenheiro)' (-not ($r.md -match '### engenheiro[^#]*Ajustes do autor'))

Write-Host '2b. Coerência do formulário validado'
Formulario eng_pu $autor.eng_pu.notas $autor.eng_pu.dec $autor.eng_pu.per -Validacao @{
    ux           = @{ validada = 'sim'; motivo = '' }      # nota 4 com revisor 3
    infra        = @{ validada = 'não'; motivo = '' }      # ajuste sem motivo
    documentacao = @{ validada = 'talvez'; motivo = 'x' }
}
$r = Rodar
Confere 'validada sim com nota diferente da do revisor vira problema' ($r.md.Contains('ux: validada sim, mas a nota validada (4) difere da do revisor (3)'))
Confere 'ajuste sem motivo vira problema e aparece como "sem motivo"' ($r.md.Contains('infra: nota ajustada sem motivo do ajuste') -and $r.md.Contains('- 3. Infraestrutura: revisor 3, validada 2. Motivo: sem motivo'))
Confere '"Validada" fora de sim ou não vira problema' ($r.md.Contains("documentacao: ""Validada"" deve ser sim ou não (está 'talvez')"))
Confere 'os problemas não invalidam as notas validadas (H1 continua apoiada, 5 de 5)' ($r.md.Contains('Resultado: apoiada, 5 de 5 eixos atendem.'))
Formulario eng_pu $autor.eng_pu.notas $autor.eng_pu.dec $autor.eng_pu.per

Write-Host '3. Formulário incompleto e nota inválida'
$n = @($autor.leigo_pu.notas); $n[5] = ''
Formulario leigo_pu $n $autor.leigo_pu.dec $autor.leigo_pu.per
$n = @($autor.leigo.notas); $n[0] = ''
Formulario leigo $n $autor.leigo.dec $autor.leigo.per
$r = Rodar
Confere 'leigo (cego) com formulário incompleto: revisor oculto nos seis eixos' (@($r.csv | Where-Object { $_.produto -eq 'leigo' -and $_.nota_revisor -like 'oculta*' }).Count -eq 6)
Confere 'decisão listada pelo revisor do leigo não aparece' (-not $r.md.Contains('DEC-LEIGO-SECRETA') -and -not ([System.IO.File]::ReadAllText((Join-Path $sai 'notas.csv'))).Contains('DEC-LEIGO-SECRETA'))
Confere 'leigo_pu (validada) com formulário incompleto: revisor continua visível nos seis eixos' (@($r.csv | Where-Object { $_.produto -eq 'leigo_pu' -and $_.nota_revisor -eq '3' }).Count -eq 6 -and $r.md.Contains('DEC-LEIGO_PU-VISIVEL'))
Confere 'H1 pendente, faltando arquitetura' ($r.md.Contains('## H1: pendente') -and $r.md.Contains('faltam notas do autor em: arquitetura'))
$n = @($autor.leigo_pu.notas); $n[5] = '4 talvez'
Formulario leigo_pu $n $autor.leigo_pu.dec $autor.leigo_pu.per
$r = Rodar
Confere 'nota validada "4 talvez" é inválida, não vira 4' ((Linha $r.csv leigo_pu arquitetura).nota_autor -eq 'inválida' -and $r.md.Contains("nota de arquitetura inválida: '4 talvez'"))

Write-Host '4. Fronteiras de H1 e H2'
Formulario leigo $autor.leigo.notas $autor.leigo.dec $autor.leigo.per
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
