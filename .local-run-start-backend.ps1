$ErrorActionPreference = 'Stop'
chcp 65001 | Out-Null
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$env:PYTHONUTF8 = '1'
$env:PYTHONIOENCODING = 'utf-8'
$env:DATABASE_URL = 'sqlite:///./data/basjoo.db'
$env:REDIS_URL = 'redis://localhost:6379/0'
$env:R2R_API_URL = 'http://localhost:7272'
$env:SCRAPLING_SERVICE_URL = 'http://localhost:8001'
$env:SECRET_KEY_FILE = './data/.secret_key'
$env:AGENT_ID_FILE = './data/.agent_id'
$env:ALLOWED_ORIGINS = '*'
$env:ALLOW_DIRECT_IP_FETCH = 'true'
$env:LOG_LEVEL = 'debug'
$env:APP_PORT = '8848'
if (!(Test-Path .\data)) { New-Item -ItemType Directory -Path .\data | Out-Null }
.\venv\Scripts\python.exe main.py
