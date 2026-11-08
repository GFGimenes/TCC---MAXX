# Claude falso para os testes: não chama modelo nenhum. Lê o prompt do stdin e imprime um
# stream-json mínimo conforme a variável CLAUDE_FALSO_MODO:
#   valido    resposta com bloco JSON correto (eixo documentacao)
#   invalido  resposta com bloco JSON mal formado
#   fora      resposta válida, mas com uma leitura fora das pastas liberadas
#   vazio     termina sem imprimir nada
# Revisor de decisões (o caminho do export sai do prompt):
#   decisoes-completo   lê o export inteiro e devolve 3 decisões e 2 perguntas
#   decisoes-parcial    lê só as 5 primeiras linhas do export
#   decisoes-truncada   lê o export inteiro, mas uma linha volta cortada
#   decisoes-contagem   lê o export inteiro, mas a contagem não bate com as listas
[Console]::InputEncoding = New-Object System.Text.UTF8Encoding($false)
[Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false)
$prompt = [Console]::In.ReadToEnd()
$modo = $env:CLAUDE_FALSO_MODO
if ($modo -eq 'vazio') { exit 1 }

$init = '{"type":"system","subtype":"init","session_id":"00000000-0000-0000-0000-000000000000","tools":["Glob","Grep","Read"],"mcp_servers":[],"model":"claude-opus-5-5","claude_code_version":"falso"}'
$bloco = '{"nota": 3, "justificativa": "texto", "evidencias": [], "regras_ausentes": [], "decisoes_do_agente": [], "nao_verificado": []}'
if ($modo -eq 'invalido') { $bloco = '{"nota": 3, "justificativa": "texto", "evidencias": [' }
$linhas = @($init)

if ($modo -like 'decisoes-*') {
    $export = [regex]::Match($prompt, 'O arquivo `([^`]+)` é a transcrição').Groups[1].Value
    $texto = [System.IO.File]::ReadAllText($export, (New-Object System.Text.UTF8Encoding($false)))
    $todas = @($texto -split "`n" | ForEach-Object { $_.TrimEnd("`r") })
    if ($todas[-1] -eq '') { $todas = $todas[0..($todas.Count - 2)] }
    $devolvidas = $todas
    if ($modo -eq 'decisoes-parcial') { $devolvidas = $todas[0..4] }
    if ($modo -eq 'decisoes-truncada') { $devolvidas = @($todas); $devolvidas[3] = $devolvidas[3].Substring(0, [Math]::Max(0, $devolvidas[3].Length - 4)) }
    $uso = [ordered]@{ type = 'tool_use'; id = 'toolu_falso'; name = 'Read'; input = @{ file_path = $export } }
    $linhas += ([ordered]@{ type = 'assistant'; message = [ordered]@{ model = 'claude-opus-5-5'; content = @($uso) } } | ConvertTo-Json -Compress -Depth 6)
    $arquivo = [ordered]@{ filePath = $export; content = ($devolvidas -join "`n"); numLines = $devolvidas.Count; startLine = 1; totalLines = $todas.Count }
    $linhas += ([ordered]@{ type = 'user'; message = [ordered]@{ role = 'user'; content = @([ordered]@{ type = 'tool_result'; tool_use_id = 'toolu_falso'; content = 'conteúdo' }) }; tool_use_result = [ordered]@{ type = 'text'; file = $arquivo } } | ConvertTo-Json -Compress -Depth 6)
    $nDec = 3
    if ($modo -eq 'decisoes-contagem') { $nDec = 2 }
    $bloco = '{"decisoes": [' +
        '{"descricao": "senhas com bcrypt", "trecho": "Decidi guardar as senhas com hash bcrypt", "tipo": "segurança", "forma": "declarada", "duvidosa": false},' +
        '{"descricao": "Express como servidor", "trecho": "const express = require", "tipo": "stack e arquitetura", "forma": "silenciosa", "duvidosa": false},' +
        '{"descricao": "multa de R$ 0,50 por dia com teto de R$ 10", "trecho": "defini que a multa por atraso", "tipo": "regra de produto", "forma": "declarada", "duvidosa": false}],' +
        ' "perguntas": [{"texto": "quer login?", "respondida": true}, {"texto": "qual o prazo?", "respondida": false}],' +
        ' "contagem": {"decisoes": ' + $nDec + ', "declaradas": 2, "silenciosas": 1, "duvidosas": 0, "perguntas": 2, "perguntas_respondidas": 1}}'
}

$textoResposta = "Review falso.`n`n``````json`n$bloco`n``````"
$resultado = [ordered]@{
    type = 'result'; subtype = 'success'; is_error = $false; result = $textoResposta
    session_id = '00000000-0000-0000-0000-000000000000'; num_turns = 1; total_cost_usd = 0
    usage = @{ input_tokens = 1; output_tokens = 1; cache_creation_input_tokens = 0; cache_read_input_tokens = 0 }
    permission_denials = @()
}
if ($modo -eq 'fora') {
    $linhas += '{"type":"assistant","message":{"model":"claude-opus-5-5","content":[{"type":"tool_use","name":"Read","input":{"file_path":"C:\\Windows\\win.ini"}}]}}'
}
$linhas += ($resultado | ConvertTo-Json -Compress -Depth 5)
$linhas | ForEach-Object { [Console]::Out.WriteLine($_) }
