#!/bin/bash

RC_FILE="$HOME/.bashrc"
FUNC_NAME="devpod-ssh"

# Check if the function already exists
if grep -q "^\s*$FUNC_NAME()" "$RC_FILE"; then
    echo "✅ The function '$FUNC_NAME' is already installed in $RC_FILE."
else
    echo "Installing '$FUNC_NAME' to $RC_FILE..."
    
    # Append the function using a heredoc
    cat << 'EOF' >> "$RC_FILE"

# DevPod SSH Auto-Connect
devpod-ssh() {
    echo "Starting DevPod and waiting for SSH..."
    devpod up . --ide none --silent &
    
    # Ping the container until it answers and drop into it
    while ! devpod ssh . -- -q -o ConnectTimeout=1 exit 2>/dev/null; do 
        sleep 1
    done
}
EOF

    echo "✅ Installation complete!"
    echo "⚠️  Run this command to activate it in your current terminal:"
    echo "source $RC_FILE"
fi
