$ErrorActionPreference = 'SilentlyContinue'

# 清理旧进程
$ports = @(8848, 3001, 8002)
foreach ($port in $ports) {
    Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue |
        ForEach-Object { Stop-Process -Id $_.OwningProcess -Force -ErrorAction SilentlyContinue }
}
Start-Sleep -Milliseconds 500

# 清理前端缓存
Remove-Item -Recurse -Force 'D:\demo3\basjoo\frontend-nextjs\.next' -ErrorAction SilentlyContinue

$root = 'D:\demo3\basjoo'

# 后端
Start-Process powershell -ArgumentList '-NoProfile','-NoExit','-Command',
    "cd '$root\backend'; `$env:APP_PORT='8848'; `$env:DATABASE_URL='sqlite:///./data/basjoo.db'; `$env:REDIS_URL='redis://localhost:6379/0'; `$env:R2R_API_URL='http://localhost:7272'; `$env:SCRAPLING_SERVICE_URL='http://localhost:8001'; `$env:SECRET_KEY_FILE='./data/.secret_key'; `$env:AGENT_ID_FILE='./data/.agent_id'; `$env:ALLOWED_ORIGINS='*'; `$env:ALLOW_DIRECT_IP_FETCH='true'; `$env:LOG_LEVEL='debug'; .\venv\Scripts\python.exe main.py"

# 前端 (端口 3001)
Start-Process powershell -ArgumentList '-NoProfile','-NoExit','-Command',
    "cd '$root\frontend-nextjs'; `$env:BACKEND_PROXY_TARGET='http://localhost:8848'; npm run dev -- --port 3001"

# Widget
Start-Process powershell -ArgumentList '-NoProfile','-NoExit','-Command',
    "cd '$root\widget'; npm run dev -- --serve=8002"

Write-Host 'All services started:'
Write-Host '  后端:   http://localhost:8848/health'
Write-Host '  前端:   http://localhost:3001'
Write-Host '  Widget: http://localhost:8002'