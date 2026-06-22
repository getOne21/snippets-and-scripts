# 🧠 Devin CLI Commands

> A local command-line coding agent with deep Devin Cloud integration — implement features, fix bugs, review code, and automate tasks from your terminal.

---

## 📦 Installation

### macOS / Linux / WSL

```bash
curl -fsSL https://cli.devin.ai/install.sh | bash
```

### macOS (Homebrew)

```bash
brew install --cask devin-cli
brew upgrade --cask devin-cli     # Upgrade to latest
```

### Windows (PowerShell)

```powershell
irm https://static.devin.ai/cli/setup.ps1 | iex
```

> **Note:** Use PowerShell for installation. After installing, Devin CLI works from PowerShell, Windows Terminal, or Git Bash.

### CLI Binary Locations

| OS            | Path                        | Binary           |
| ------------- | --------------------------- | ---------------- |
| macOS / Linux | `~/.local/bin/`             | `devin`          |
| Windows       | `%LOCALAPPDATA%\devin\bin\` | `devin.exe`      |

---

## 🚀 Starting Devin CLI

```bash
devin                            # Start interactive REPL (no prompt)
devin -- your prompt here        # Start REPL with initial prompt
devin -p "prompt"                # Single-turn: print response to stdout and exit
devin -p -- prompt words here    # Same, using -- separator
```

> **Tip:** Use `--` before your prompt so it is interpreted as a prompt and not a subcommand. Type `@` in the prompt input to autocomplete local files/directories.

---

## ⚙️ Global Flags

| Flag                        | Short | Description                                                  |
| --------------------------- | ----- | ------------------------------------------------------------ |
| `--model <model>`           |       | Set the AI model for this session                            |
| `--permission-mode <mode>`  |       | Permission mode: `normal`, `dangerous`, `bypass`             |
| `--continue`                | `-c`  | Resume the most recent session in the current directory      |
| `--resume <id>`             | `-r`  | Resume a specific session by ID                              |
| `--print [PROMPT]`          | `-p`  | Print response and exit (non-interactive mode)               |
| `--prompt-file <file>`      |       | Load the initial prompt from a file                          |
| `--config <path>`           |       | Configuration file path                                      |
| `--export [PATH]`           |       | Export conversation to a file after each turn (ATIF format)  |
| `--respect-workspace-trust` |       | Whether to respect workspace trust settings                  |

---

## 🔐 Authentication

```bash
devin auth login               # Log in to your account
devin auth logout              # Log out and remove stored credentials
devin auth status              # Check authentication status
```

---

## 🔁 Session Management

```bash
devin -c                       # Continue the most recent session
devin --continue
devin -r                       # Pick from recent sessions
devin --resume
devin -r brisk-otter           # Resume a specific session by ID
```

---

## 🔌 MCP Server Management

```bash
devin mcp add <name>           # Add a new MCP server
devin mcp list                 # List all configured MCP servers
devin mcp get <name>           # Show details for a specific MCP server
devin mcp remove <name>        # Remove a configured MCP server
devin mcp login <name>         # Authenticate with an MCP server via OAuth
devin mcp logout <name>        # Remove stored OAuth credentials for an MCP server
```

---

## 📜 Rules Management

```bash
devin rules list               # List all available rules
devin rules show <name>        # Show details for a specific rule
devin rules paths              # Show rule directory locations
```

---

## 🧩 Skills Management

```bash
devin skills list              # List all available skills
devin skills show <name>       # Show details for a specific skill
devin skills paths             # Show skill directory locations
devin skills list --trigger <user|model>  # Filter by trigger type
```

---

## 🛠️ Utility Subcommands

```bash
devin version                  # Show current version
devin update                   # Update to the latest version
devin setup                    # Run initial setup / configuration
devin uninstall                # Uninstall Devin CLI
devin shell                    # Open a shell session
devin list                     # List sessions
devin acp                      # Run as Agent Client Protocol server over stdio
```

---

## 💬 Interactive Slash Commands

### General

| Command             | Description                                        |
| ------------------- | -------------------------------------------------- |
| `/help`             | Show available commands                            |
| `/exit` or `/quit`  | Exit the application                               |
| `/clear` or `/new`  | Clear conversation (start fresh)                   |

### Mode Switching

| Command                | Description                                                     |
| ---------------------- | --------------------------------------------------------------- |
| `/mode`                | Show current mode                                               |
| `/mode <mode>`         | Switch mode (`normal`, `accept-edits`, `plan`, `bypass`)        |
| `/normal`              | Switch to Normal mode (default)                                 |
| `/plan`                | Switch to Plan mode                                             |
| `/ask <question>`      | Ask a question without making code changes (oneshot)            |
| `/bypass`              | Switch to Bypass mode (aliases: `/yolo`, `/dangerous`)          |
| `/accept-edits`        | Accept all edits automatically                                  |

### Session Management

| Command                 | Description                                             |
| ----------------------- | ------------------------------------------------------- |
| `/resume`               | Open the interactive session picker                     |
| `/resume <id>`          | Resume session by ID                                    |
| `/ls`                   | List recent sessions in current directory               |
| `/ls --all`             | List all sessions across all directories                |
| `/continue`             | Resume most recent session                              |
| `/continue <id>`        | Resume session by ID                                    |
| `/rm-session <id>`      | Irreversibly delete a session by ID                     |

### Workspace

| Command                | Description                                             |
| ---------------------- | ------------------------------------------------------- |
| `/workspace`           | List workspace directories                              |

### Cloud Handoff

| Command                          | Description                                       |
| -------------------------------- | ------------------------------------------------- |
| `/handoff`                       | Hand off to cloud Devin (continues automatically) |
| `/handoff <task description>`    | Hand off with a specific task                     |

> **Tip:** Devin CLI packages up the conversation context and current git branch, then creates a cloud Devin session that picks up where you left off.

---

## ⌨️ Useful Examples

```bash
# Start an interactive session
devin

# Ask Devin to implement a feature
devin -- add a dark mode toggle to the settings page

# Single-turn mode for scripts
devin -p "explain the auth flow in this codebase"

# Resume your last session
devin -c

# Use a specific model
devin --model claude-sonnet-4

# Bypass all permission prompts
devin --permission-mode bypass

# Add an MCP server
devin mcp add my-api-server

# Hand off to cloud Devin
/handoff fix the flaky integration tests in CI
```

---

## 📂 Extensibility Directories

| Directory            | Purpose                                             |
| -------------------- | --------------------------------------------------- |
| `.devin/rules/`     | Project-scoped rules for agent behavior             |
| `.devin/skills/`    | Reusable prompt workflows (slash commands or auto)  |
| `.devin/workflows/` | Automated task workflows                            |
| `.devin/plans/`     | Saved plans                                         |

---

## 📚 Resources

- [Devin CLI Quickstart](https://docs.devin.ai/cli)
- [Essential Commands](https://docs.devin.ai/cli/essential-commands)
- [Commands & Flags Reference](https://docs.devin.ai/cli/reference/commands)
- [Extensibility Overview](https://docs.devin.ai/cli/extensibility)
