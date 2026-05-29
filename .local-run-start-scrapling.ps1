# Scrapling 微服务本地启动脚本 (端口 8001)
$ErrorActionPreference = 'Stop'
chcp 65001 | Out-Null
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$env:PYTHONUTF8 = '1'
$env:PYTHONIOENCODING = 'utf-8'

# 首次使用前需要安装 Playwright 浏览器:
#   pip install playwright
#   playwright install chromium

$env:ALLOW_DIRECT_IP_FETCH = 'true'

Write-Host ">> 启动 Scrapling 微服务 (8001) ..."
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$root\scrapling-service"
if (Test-Path .\venv) {
    .\venv\Scripts\python.exe main.py
} else {
    python main.py
}