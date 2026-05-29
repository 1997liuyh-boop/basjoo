# Basjoo 本地启动脚本 (后端8848 / 前端3001 / Widget 8002)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

# ---------- 1. 后端 ----------
Write-Host ">> 启动后端 (8848) ..."
Set-Location "$root\backend"
if (!(Test-Path .\data)) { New-Item -ItemType Directory -Path .\data | Out-Null }
$env:DATABASE_URL   = 'sqlite:///./data/basjoo.db'
$env:REDIS_URL      = 'redis://localhost:6379/0'
$env:R2R_API_URL    = 'http://localhost:7272'
$env:SCRAPLING_SERVICE_URL = 'http://localhost:8001'
$env:SECRET_KEY_FILE  = './data/.secret_key'
$env:AGENT_ID_FILE    = './data/.agent_id'
$env:ALLOWED_ORIGINS  = '*'
$env:ALLOW_DIRECT_IP_FETCH = 'true'
$env:LOG_LEVEL        = 'debug'
$env:APP_PORT         = '8848'
Start-Process powershell -ArgumentList '-NoProfile','-NoExit','-Command',
    "`$env:DATABASE_URL='sqlite:///./data/basjoo.db'; `$env:REDIS_URL='redis://localhost:6379/0'; `$env:R2R_API_URL='http://localhost:7272'; `$env:SCRAPLING_SERVICE_URL='http://localhost:8001'; `$env:SECRET_KEY_FILE='./data/.secret_key'; `$env:AGENT_ID_FILE='./data/.agent_id'; `$env:ALLOWED_ORIGINS='*'; `$env:ALLOW_DIRECT_IP_FETCH='true'; `$env:LOG_LEVEL='debug'; `$env:APP_PORT='8848'; .\venv\Scripts\python.exe main.py"

# ---------- 2. 前端 ----------
Write-Host ">> 启动前端 (3001) ..."
Set-Location "$root\frontend-nextjs"
Remove-Item -Recurse -Force .next -ErrorAction SilentlyContinue
Start-Process powershell -ArgumentList '-NoProfile','-NoExit','-Command',
    "Remove-Item -Recurse -Force .next -ErrorAction SilentlyContinue; `$env:BACKEND_PROXY_TARGET='http://localhost:8848'; npm run dev -- --port 3001"

# ---------- 3. Widget ----------
Write-Host ">> 启动 Widget (8002) ..."
Set-Location "$root\widget"
Start-Process powershell -ArgumentList '-NoProfile','-NoExit','-Command',
    "npm run dev -- --serve=8002"

Write-Host ""
Write-Host "============================================"
Write-Host "  后端:   http://localhost:8848/health"
Write-Host "  前端:   http://localhost:3001"
Write-Host "  Widget: http://localhost:8002"
Write-Host "============================================"