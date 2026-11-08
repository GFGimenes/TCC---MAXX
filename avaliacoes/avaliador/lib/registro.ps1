# Registro da execução (<produto>-registro.md) e formulário do autor (autor/<produto>.md).
# Nenhum dos dois mostra a nota dos revisores: o autor pontua sem vê-la (rubrica, "Como
# preencher", passo 3).

Set-StrictMode -Version 2.0

$script:TiposDecisao = @('Regra de produto', 'Stack e arquitetura', 'Modelo de dados', 'Segurança', 'UX e visual', 'Testes e processo', 'Hospedagem e deploy')

function Format-CelulaTabela {
    param($Valor)
    if ($null -eq $Valor -or "$Valor" -eq '') { return '-' }
    return ("$Valor" -replace '\|', '/' -replace '\r?\n', ' ')
}

# Acrescenta uma seção ao registro do produto. O arquivo só cresce: cada execução vira uma
# seção nova, e as anteriores ficam como estão.
function Add-RegistroExecucao {
    param(
        [Parameter(Mandatory)][string]$Caminho,
        [Parameter(Mandatory)][string]$Produto,
        [Parameter(Mandatory)][string]$Modo,
        [Parameter(Mandatory)][string]$Repo,
        [Parameter(Mandatory)][string]$Ref,
        [Parameter(Mandatory)][string]$Hash,
        [Parameter(Mandatory)][datetime]$Inicio,
        [Parameter(Mandatory)][datetime]$Fim,
        [Parameter(Mandatory)][string]$VersaoCli,
        [Parameter(Mandatory)][int]$TempoLimiteMin,
        [Parameter(Mandatory)][string]$EstadoOrigem,
        [Parameter(Mandatory)][bool]$OrigemInalterada,
        [Parameter(Mandatory)][bool]$CheckoutInalterado,
        [Parameter(Mandatory)][hashtable]$Hashes,
        [Parameter(Mandatory)][AllowEmptyCollection()][object[]]$Resultados,
        [AllowEmptyCollection()][string[]]$Avisos = @()
    )
    $sim = { param($b) if ($b) { 'sim' } else { 'NÃO' } }
    $l = New-Object System.Collections.Generic.List[string]
    if (-not (Test-Path -LiteralPath $Caminho)) {
        $l.Add("# Registro do avaliador: $Produto")
        $l.Add('')
        $l.Add('Gerado por `avaliacoes/avaliador/avaliar.ps1`; cada execução acrescenta uma seção e')
        $l.Add('nenhuma é reescrita. As notas dos revisores não aparecem aqui: ficam nos reviews,')
        $l.Add('que o autor só abre depois de preencher o formulário dele.')
    }
    $l.Add('')
    $l.Add("## Execução de $($Inicio.ToString('yyyy-MM-dd HH:mm:ss zzz'))")
    $l.Add('')
    $l.Add("- Modo: $Modo")
    $l.Add("- Repositório: ``$Repo``")
    $l.Add("- Ref: ``$Ref``")
    $l.Add("- Commit avaliado: ``$Hash``")
    $l.Add("- Início e fim: $($Inicio.ToString('yyyy-MM-dd HH:mm:ss')) a $($Fim.ToString('yyyy-MM-dd HH:mm:ss')) ($([int]($Fim - $Inicio).TotalSeconds) s)")
    $l.Add("- Claude Code: $VersaoCli")
    $l.Add("- Modelo e esforço fixados: $($script:ModeloFixado), $($script:EsforcoFixado)")
    $l.Add("- Tempo limite por eixo: $TempoLimiteMin min")
    $l.Add("- Repositório de origem inalterado (estado ``$($EstadoOrigem.Substring(0, 12))``): $(& $sim $OrigemInalterada)")
    $l.Add("- Checkout inalterado depois das sessões: $(& $sim $CheckoutInalterado)")
    foreach ($k in ($Hashes.Keys | Sort-Object)) { $l.Add("- SHA-256 de $($k): ``$($Hashes[$k])``") }
    $l.Add('')
    if (@($Avisos).Count) {
        $l.Add('Avisos:')
        $l.Add('')
        foreach ($a in $Avisos) { $l.Add("- $a") }
        $l.Add('')
    }
    $l.Add('| Eixo | Tentativa | Status | Sessão | Modelo e esforço confirmados (transcrição) | Tokens (entrada / saída / cache criação / cache leitura) | Duração (s) | Custo (US$) | Chamadas de ferramenta | Falha ou motivo |')
    $l.Add('|---|---|---|---|---|---|---|---|---|---|')
    foreach ($r in $Resultados) {
        $p = { param($n) if ($r.PSObject.Properties[$n]) { $r.$n } else { $null } }
        $tok = & $p 'tokens'
        $tokTexto = '-'
        if ($tok) { $tokTexto = (@('entrada', 'saida', 'cache_criacao', 'cache_leitura') | ForEach-Object { Format-CelulaTabela $tok[$_] }) -join ' / ' }
        $mot = @(& $p 'motivos' | Where-Object { $_ })
        $me = '-'
        if ((& $p 'modelo_usado') -or (& $p 'esforco_usado')) { $me = "$(Format-CelulaTabela (& $p 'modelo_usado')), $(Format-CelulaTabela (& $p 'esforco_usado'))" }
        $l.Add('| ' + (@(
            (Format-CelulaTabela $(if (& $p 'rotulo') { & $p 'rotulo' } else { & $p 'eixo' })),
            (Format-CelulaTabela (& $p 'tentativa')),
            (Format-CelulaTabela (& $p 'status')),
            (Format-CelulaTabela (& $p 'sessao_id')),
            $me,
            $tokTexto,
            (Format-CelulaTabela (& $p 'duracao_s')),
            (Format-CelulaTabela (& $p 'custo_usd')),
            (Format-CelulaTabela (& $p 'chamadas_ferramenta')),
            (Format-CelulaTabela ($mot -join '; '))
        ) -join ' | ') + ' |')
    }
    $existente = ''
    if (Test-Path -LiteralPath $Caminho) { $existente = (Read-TextoArquivo $Caminho).TrimEnd() + "`n" }
    Write-TextoArquivo -Texto ($existente + ($l -join "`n") + "`n") -Caminho $Caminho
}

# Formulário em branco do autor. Criado só se não existir; nunca sobrescrito.
# Devolve $true se criou, $false se já existia.
function New-FormularioAutor {
    param(
        [Parameter(Mandatory)][string]$Caminho,
        [Parameter(Mandatory)][string]$Produto,
        [Parameter(Mandatory)][string]$Hash,
        [Parameter(Mandatory)][string]$Ref
    )
    if (Test-Path -LiteralPath $Caminho) { return $false }
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Caminho) | Out-Null
    $l = New-Object System.Collections.Generic.List[string]
    $l.Add("# Avaliação do autor: $Produto")
    $l.Add('')
    $l.Add('> Preencha este formulário ANTES de abrir os reviews em `avaliacoes/reviews/` (os')
    $l.Add("> arquivos ``$Produto-<eixo>.md`` e ``.json``). Pontue cada eixo pela rubrica")
    $l.Add('> (`avaliacoes/rubrica.md`), sem ver a nota do revisor, com observações objetivas: o')
    $l.Add('> que motivou a nota, não impressão geral. O registro da execução')
    $l.Add("> (``$Produto-registro.md``) não mostra notas e pode ser lido.")
    $l.Add('>')
    $l.Add('> Nota: um inteiro de 1 a 5, na linha "Nota (1 a 5):". Regras ausentes não reduzem a')
    $l.Add('> nota; ficam listadas à parte. Este arquivo é lido pelo `consolidar.ps1`: mantenha os')
    $l.Add('> títulos e os rótulos como estão.')
    $l.Add('')
    $l.Add("- Commit na criação do formulário: ``$Hash`` (``$Ref``)")
    $l.Add('- Commit que o autor avaliou (o do registro da execução usada): ')
    $l.Add('- Data do preenchimento: ')
    $l.Add('- Preenchido antes de abrir os reviews (sim ou não): ')
    foreach ($eixo in $script:Secoes.Keys) {
        $l.Add('')
        $l.Add("## $($script:Secoes[$eixo])")
        $l.Add('')
        $l.Add('Nota (1 a 5): ')
        $l.Add('')
        $l.Add('Observações objetivas:')
        $l.Add('')
        $l.Add('- ')
        $l.Add('')
        $l.Add('Regras ausentes:')
        $l.Add('')
        $l.Add('- ')
    }
    $l.Add('')
    $l.Add('## Decisões sem perguntar')
    $l.Add('')
    $l.Add('Decisões que o agente construtor tomou sem perguntar, contadas pelo autor a partir do')
    $l.Add('export da sessão e do diff da branch. A lista do revisor de decisões e as decisões')
    $l.Add('apontadas pelos seis revisores são insumo, não a contagem. Forma: declarada, quando o')
    $l.Add('agente escreveu que decidiu; silenciosa, quando só aparece no que ele fez.')
    $l.Add('')
    $l.Add('| Tipo | Declaradas | Silenciosas |')
    $l.Add('|---|---|---|')
    foreach ($t in $script:TiposDecisao) { $l.Add("| $t |  |  |") }
    $l.Add('')
    $l.Add('Total: ')
    $l.Add('')
    $l.Add('Lista:')
    $l.Add('')
    $l.Add('- ')
    $l.Add('')
    $l.Add('## Perguntas sem resposta')
    $l.Add('')
    $l.Add('Perguntas que o agente fez e que ficaram sem resposta na sessão.')
    $l.Add('')
    $l.Add('Total: ')
    $l.Add('')
    $l.Add('Lista:')
    $l.Add('')
    $l.Add('- ')
    $l.Add('')
    $l.Add('## Depois de abrir os reviews')
    $l.Add('')
    $l.Add('Uma linha por eixo em que a nota do autor e a do revisor diferem em 2 pontos ou mais,')
    $l.Add('explicando a diferença (rubrica, "Como preencher", passo 4).')
    $l.Add('')
    $l.Add('- ')
    Write-TextoArquivo -Texto (($l -join "`n") + "`n") -Caminho $Caminho
    return $true
}
