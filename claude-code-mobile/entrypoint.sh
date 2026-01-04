#!/bin/bash
set -e

echo "Loading configuration..."
if [ -f "/config/config.env" ]; then
    source /config/config.env
    echo "Config loaded"
fi

export PATH="$HOME/.local/bin:$PATH"

echo "Starting Happy service for mobile access..."
echo "Claude: $(which claude 2>/dev/null || echo 'not found')"
echo "Happy: $(which happy 2>/dev/null || echo 'not found')"

echo "Auto-starting Happy service..."

cd /workspace

if [ -f "/root/.happy/access.key" ]; then
    echo "Authentication found, starting Happy with auto-config..."
    expect -c "
    set timeout -1
    spawn happy
    expect {
        \"Choose the text style\" {
            puts \"Auto-selecting dark mode...\"
            send \"\r\"
            exp_continue
        }
        \"Press Enter to continue\" {
            puts \"Accepting security notes...\"
            send \"\r\"
            exp_continue
        }
        \"Welcome\" {
            puts \"Happy service ready!\"
            interact
        }
        eof { exit 0 }
    }
    "
else
    echo "No authentication found. First time setup needed:"
    echo "docker exec -it <container> happy"
    tail -f /dev/null
fi
