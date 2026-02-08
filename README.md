
# CCOEGPT

A local device focused AI assistant built in Rust — persistent memory, autonomous tasks, ~27MB binary. Inspired by and compatible with OpenClaw.

`cargo install ccoegpt`

## Why CCOEGPT?

- **Single binary** — no Node.js, Docker, or Python required
- **Local device focused** — runs entirely on your machine, your memory data stays yours
- **Persistent memory** — markdown-based knowledge store with full-text and semantic search
- **Autonomous heartbeat** — delegate tasks and let it work in the background
- **Multiple interfaces** — CLI, web UI, desktop GUI
- **Multiple LLM providers** — Anthropic (Claude), OpenAI, Ollama
- **OpenClaw compatible** — works with SOUL, MEMORY, HEARTBEAT markdown files and skills format

## Install

```bash
cargo install ccoegpt
```

## Quick Start

```bash
# Initialize configuration
ccoegpt config init

# Start interactive chat
ccoegpt chat

# Ask a single question
ccoegpt ask "What is the meaning of life?"

# Run as a daemon with heartbeat, HTTP API and web ui
ccoegpt daemon start
```

## How It Works

CCOEGPT uses plain markdown files as its memory:

```
~/.ccoegpt/workspace/
├── MEMORY.md            # Long-term knowledge (auto-loaded each session)
├── HEARTBEAT.md         # Autonomous task queue
├── SOUL.md              # Personality and behavioral guidance
└── knowledge/           # Structured knowledge bank (optional)
    ├── finance/
    ├── legal/
    └── tech/
```

Files are indexed with SQLite FTS5 for fast keyword search, and sqlite-vec for semantic search with local embeddings 

## Configuration

Stored at `~/.ccoegpt/config.toml`:

```toml
[agent]
default_model = "claude-cli/opus"

[providers.anthropic]
api_key = "${ANTHROPIC_API_KEY}"

[heartbeat]
enabled = true
interval = "30m"
active_hours = { start = "09:00", end = "22:00" }

[memory]
workspace = "~/.ccoegpt/workspace"
```

## CLI Commands

```bash
# Chat
ccoegpt chat                     # Interactive chat
ccoegpt chat --session <id>      # Resume session
ccoegpt ask "question"           # Single question

# Daemon
ccoegpt daemon start             # Start background daemon
ccoegpt daemon stop              # Stop daemon
ccoegpt daemon status            # Show status
ccoegpt daemon heartbeat         # Run one heartbeat cycle

# Memory
ccoegpt memory search "query"    # Search memory
ccoegpt memory reindex           # Reindex files
ccoegpt memory stats             # Show statistics

# Config
ccoegpt config init              # Create default config
ccoegpt config show              # Show current config
```

## HTTP API

When the daemon is running:

| Endpoint | Description |
|----------|-------------|
| `GET /health` | Health check |
| `GET /api/status` | Server status |
| `POST /api/chat` | Chat with the assistant |
| `GET /api/memory/search?q=<query>` | Search memory |
| `GET /api/memory/stats` | Memory statistics |

## Blog

[Why I Built CCOEGPT in 4 Nights](https://ccoegpt.app/blog/why-i-built-ccoegpt-in-4-nights) — the full story with commit-by-commit breakdown.

## Built With

Rust, Tokio, Axum, SQLite (FTS5 + sqlite-vec), fastembed, eframe

## Contributors

<a href="https://github.com/ccoegpt-app/ccoegpt/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=ccoegpt-app/ccoegpt" />
</a>

## Stargazers

[![Star History Chart](https://api.star-history.com/svg?repos=ccoegpt-app/ccoegpt&type=Date)](https://star-history.com/#ccoegpt-app/ccoegpt&Date)

## License

[Apache-2.0](LICENSE)
