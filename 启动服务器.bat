@echo off
chcp 65001 >nul
title DROP 游戏服务器
echo ================================
echo   🎮 DROP - 地震逃生游戏
echo ================================
echo.
echo 正在启动本地服务器...
echo.

:: 方案1: 纯 PowerShell (Windows 自带，无需安装)
powershell -Command "Write-Host '✅ 使用 PowerShell 启动服务器 (Windows 内置)'; Write-Host '📱 请在浏览器打开: http://127.0.0.1:8137'; Write-Host ''; Write-Host '按 Ctrl+C 可以停止服务器'; Write-Host '================================'; $listener = New-Object System.Net.HttpListener; $listener.Prefixes.Add('http://+:8137/'); $listener.Start(); Write-Host '服务器已启动!'; $mimeTypes = @{'.html'='text/html; charset=utf-8'; '.js'='application/javascript; charset=utf-8'; '.css'='text/css; charset=utf-8'; '.png'='image/png'; '.jpg'='image/jpeg'; '.gif'='image/gif'; '.svg'='image/svg+xml'; '.ico'='image/x-icon'; '.json'='application/json'}; while ($listener.IsListening) { $ctx = $listener.GetContext(); $req = $ctx.Request; $res = $ctx.Response; $path = $req.Url.LocalPath.TrimStart('/'); if ($path -eq '') { $path = 'index.html' }; $file = Join-Path (Get-Location) $path; if (Test-Path $file -PathType Leaf) { $ext = [IO.Path]::GetExtension($file); $mime = $mimeTypes[$ext]; if (-not $mime) { $mime = 'application/octet-stream' }; $res.ContentType = $mime; $bytes = [IO.File]::ReadAllBytes($file); $res.OutputStream.Write($bytes, 0, $bytes.Length) } else { $res.StatusCode = 404; $msg = [Text.Encoding]::UTF8.GetBytes('404 Not Found'); $res.OutputStream.Write($msg, 0, $msg.Length) }; $res.Close() }"

:: 方案2: Python
python --version >nul 2>&1
if %errorlevel%==0 (
    echo ✅ 使用 Python 启动服务器
    echo 📱 请在浏览器打开: http://127.0.0.1:8137
    echo.
    echo 按 Ctrl+C 可以停止服务器
    echo ================================
    python -m http.server 8137
    goto :end
)

:: 方案3: Node.js
npx --version >nul 2>&1
if %errorlevel%==0 (
    echo ✅ 使用 npx serve 启动服务器
    npx serve . -p 8137
    goto :end
)

echo.
echo ❌ 启动失败，请检查运行环境
pause

:end
