#!/bin/bash
cd "$(dirname "$0")"
echo "================================"
echo "  🎮 DROP - 地震逃生游戏"
echo "================================"
echo ""
echo "正在启动本地服务器..."

# 尝试 Python 3
if command -v python3 &> /dev/null; then
    echo "✅ 使用 Python3 启动"
    echo "📱 请在浏览器打开: http://127.0.0.1:8137"
    echo ""
    echo "按 Ctrl+C 停止服务器"
    echo "================================"
    python3 -m http.server 8137
    exit 0
fi

# 尝试 Python
if command -v python &> /dev/null; then
    echo "✅ 使用 Python 启动"
    echo "📱 请在浏览器打开: http://127.0.0.1:8137"
    echo ""
    echo "按 Ctrl+C 停止服务器"
    echo "================================"
    python -m http.server 8137
    exit 0
fi

# 尝试 npx
if command -v npx &> /dev/null; then
    echo "✅ 使用 npx serve 启动"
    npx serve . -p 8137
    exit 0
fi

# 尝试 PHP
if command -v php &> /dev/null; then
    echo "✅ 使用 PHP 启动"
    echo "📱 请在浏览器打开: http://127.0.0.1:8137"
    php -S 127.0.0.1:8137
    exit 0
fi

echo "❌ 未找到 Python/Node.js/PHP"
echo "请安装 Python: https://python.org"
read -p "按回车退出..."
