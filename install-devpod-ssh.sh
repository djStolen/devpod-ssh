#!/bin/bash

RC_FILE="$HOME/.bashrc"
FUNC_NAME="devpod-ssh"

# Function to safely remove the block from the rc file
uninstall_func() {
    echo "Removing '$FUNC_NAME' from $RC_FILE..."
    
    # Safely deletes everything from the header comment to the closing bracket
    awk '
        /# DevPod SSH Auto-Connect/ { skip=1 }
        skip==1 && /^}/ { skip=0; next }
        !skip { print }
    ' "$RC_FILE" > "${RC_FILE}.tmp" && mv "${RC_FILE}.tmp" "$RC_FILE"
    
    echo "🗑️  Uninstall complete!"
    echo "⚠️  Run 'source $RC_FILE' or open a new terminal to apply the changes."
}

# Check if the function already exists
if grep -q "^\s*$FUNC_NAME()" "$RC_FILE"; then
    echo "✅ The function '$FUNC_NAME' is already installed."
    read -p "Do you want to UNINSTALL it? [y/N]: " confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        uninstall_func
    else
        echo "Operation cancelled. The function remains installed."
    fi
else
    echo "Installing '$FUNC_NAME' to $RC_FILE..."
    
    # Append the function
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

