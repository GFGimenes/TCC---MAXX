# Claude falso para os testes: não chama modelo nenhum. Lê o prompt do stdin e imprime um
# stream-json mínimo conforme a variável CLAUDE_FALSO_MODO:
#   valido    resposta com bloco JSON correto (eixo documentacao)
#   invalido  resposta com bloco JSON mal formado
#   fora      resposta válida, mas com uma leitura fora das pastas liberadas
#   vazio     termina sem imprimir nada
$null = [Console]::In.ReadToEnd()
$modo = $env:CLAUDE_FALSO_MODO
if ($modo -eq 'vazio') { exit 1 }

$init = '{"type":"system","subtype":"init","session_id":"00000000-0000-0000-0000-000000000000","tools":["Glob","Grep","Read"],"mcp_servers":[],"model":"claude-opus-5-5","claude_code_version":"falso"}'
$bloco = '{"nota": 3, "justificativa": "texto", "evidencias": [], "regras_ausentes": [], "decisoes_do_agente": [], "nao_verificado": []}'
if ($modo -eq 'invalido') { $bloco = '{"nota": 3, "justificativa": "texto", "evidencias": [' }
$texto = "Review falso.`n`n``````json`n$bloco`n``````"
$resultado = [ordered]@{
    type = 'result'; subtype = 'success'; is_error = $false; result = $texto
    session_id = '00000000-0000-0000-0000-000000000000'; num_turns = 1; total_cost_usd = 0
    usage = @{ input_tokens = 1; output_tokens = 1; cache_creation_input_tokens = 0; cache_read_input_tokens = 0 }
    permission_denials = @()
}
$linhas = @($init)
if ($modo -eq 'fora') {
    $linhas += '{"type":"assistant","message":{"model":"claude-opus-5-5","content":[{"type":"tool_use","name":"Read","input":{"file_path":"C:\\Windows\\win.ini"}}]}}'
}
$linhas += ($resultado | ConvertTo-Json -Compress -Depth 5)
$linhas | ForEach-Object { [Console]::Out.WriteLine($_) }
