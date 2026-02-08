#!/bin/bash
# Startup script for CCOEGPT
# Ensures essential workspace files are present

WORKSPACE_DIR="${HOME}/.ccoegpt/workspace"
REPO_DIR="$(dirname "$0")"

# Create workspace directory if it doesn't exist
mkdir -p "$WORKSPACE_DIR"

# Copy AZURE_CCOE.md if it doesn't exist or is outdated
if [ ! -f "$WORKSPACE_DIR/AZURE_CCOE.md" ] || [ "$REPO_DIR/AZURE_CCOE.md" -nt "$WORKSPACE_DIR/AZURE_CCOE.md" ]; then
    echo "Copying AZURE_CCOE.md to workspace..."
    cp "$REPO_DIR/AZURE_CCOE.md" "$WORKSPACE_DIR/"
fi

# Start the daemon
exec "$REPO_DIR/target/release/localgpt" daemon start "$@"
