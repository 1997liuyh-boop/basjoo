$ErrorActionPreference = 'Continue'
$key = 'tp-cl9yu6roic3hd7h7vt3fs2la7o3sgh97d6djdtguwnasnj4x'
$body = '{"model":"mimo-v2.5-pro","messages":[{"role":"user","content":"hi"}],"max_tokens":10}'
$base = 'https://token-plan-cn.xiaomimimo.com'

$tests = @(
    @{Label='1. OpenAI /anthropic/chat/completions'; Uri="$base/anthropic/chat/completions"; Headers=@{Authorization="Bearer $key";'Content-Type'='application/json'}},
    @{Label='2. Anthropic /anthropic/v1/messages';  Uri="$base/anthropic/v1/messages"; Headers=@{'x-api-key'=$key;'anthropic-version'='2023-06-01';'Content-Type'='application/json'}},
    @{Label='3. Anthropic /anthropic/messages';     Uri="$base/anthropic/messages"; Headers=@{'x-api-key'=$key;'anthropic-version'='2023-06-01';'Content-Type'='application/json'}},
    @{Label='4. Anthropic /v1/messages (root)';     Uri="$base/v1/messages"; Headers=@{'x-api-key'=$key;'anthropic-version'='2023-06-01';'Content-Type'='application/json'}},
    @{Label='5. OpenAI /v1/chat/completions (root)';Uri="$base/v1/chat/completions"; Headers=@{Authorization="Bearer $key";'Content-Type'='application/json'}}
)

foreach ($t in $tests) {
    Write-Host "=== $($t.Label) ==="
    try {
        $r = Invoke-RestMethod -Uri $t.Uri -Method Post -Headers $t.Headers -Body $body -TimeoutSec 15
        Write-Host "OK: $($r | ConvertTo-Json -Depth 3)"
    } catch {
        Write-Host "FAIL: $($_.Exception.Message)"
    }
}