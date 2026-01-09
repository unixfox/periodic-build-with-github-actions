#!/bin/bash
set -e

export PATH="$HOME/.local/bin:$PATH"

echo "Starting OpenCode Web UI..."
echo "OpenCode: $(which opencode 2>/dev/null || echo 'not found')"

cd /workspace

echo "Starting OpenCode web server..."
exec opencode web --port 8080
