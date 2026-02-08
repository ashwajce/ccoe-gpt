# CCOEGPT Startup Script

## Purpose

The `start-ccoegpt.sh` script ensures that essential workspace files (like `AZURE_CCOE.md`) are automatically copied to your workspace directory when starting CCOEGPT.

## Usage

Instead of running the daemon directly, use the startup script:

```bash
# Stop current daemon
./target/release/localgpt daemon stop

# Start using the script
./start-ccoegpt.sh
```

## What It Does

1. Creates `~/.ccoegpt/workspace/` if it doesn't exist
2. Copies `AZURE_CCOE.md` to workspace if:
   - File doesn't exist in workspace, OR
   - Repository version is newer than workspace version
3. Starts the CCOEGPT daemon

## Benefits

- ✅ Ensures Azure CCOE constraints are always available
- ✅ Automatically updates workspace file when repository version changes
- ✅ Safe to run multiple times (only copies when needed)
- ✅ Works on fresh installs

## For Kubernetes Deployment

Add this to your Kubernetes deployment's init container or startup command:

```yaml
command: ["/bin/sh", "-c"]
args:
  - |
    cp /app/AZURE_CCOE.md /root/.ccoegpt/workspace/
    /usr/local/bin/ccoegpt daemon start
```
