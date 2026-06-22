# 🤖 GitHub Copilot CLI Commands

> AI-powered coding assistant directly in your terminal — build, debug, and understand code through natural language conversations.

---

## 📦 Installation

### Install via npm

```bash
npm install -g @githubnext/github-copilot-cli
```

### Install via Homebrew (macOS)

```bash
brew install gh
gh extension install github/gh-copilot
```

> **Note:** The `gh copilot` extension has been deprecated in favor of the standalone **GitHub Copilot CLI** (`copilot`).

### Install Standalone Copilot CLI

```bash
# macOS / Linux
brew install github/copilot-cli/copilot

# Or download from https://github.com/github/copilot-cli
```

---

## 🔐 Authentication

```bash
copilot login                              # Authenticate via OAuth device flow
copilot login --host https://example.ghe.com  # Authenticate with GitHub Enterprise
```

**Environment variable auth (for automation):**

Copilot CLI checks these in order of precedence:

1. `COPILOT_GITHUB_TOKEN`
2. `GH_TOKEN`
3. `GITHUB_TOKEN`

Supported token types: fine-grained PATs with "Copilot Requests" permission, OAuth tokens from Copilot CLI or GitHub CLI.

---

## 🚀 Core Commands

| Command                   | Description                                            |
| ------------------------- | ------------------------------------------------------ |
| `copilot`                 | Launch the interactive user interface                  |
| `copilot login`           | Authenticate with Copilot via OAuth                    |
| `copilot init`            | Initialize Copilot custom instructions for the repo    |
| `copilot version`         | Display version info and check for updates             |
| `copilot update`          | Download and install the latest version                |
| `copilot help [TOPIC]`    | Display help (`billing`, `config`, `commands`, etc.)   |
| `copilot completion SHELL`| Print shell completion script (`bash`, `zsh`, `fish`)  |

---

## 🧠 Programmatic / Non-Interactive Mode

```bash
copilot -p "explain what this Dockerfile does"       # Single-turn prompt, print and exit
copilot -p "write a bash script to clean up Docker images" -s  # Suppress decoration, script-friendly
```

### Key Flags

| Flag                  | Description                                                        |
| --------------------- | ------------------------------------------------------------------ |
| `-p PROMPT`           | Execute prompt in non-interactive mode; exits when done            |
| `-s`                  | Suppress stats/decoration, output only the response (great for piping) |
| `--model=MODEL`       | Choose the AI model (e.g. `gpt-5.2`, `claude-sonnet-4`)       |
| `--agent=AGENT`       | Specify a custom agent to use                                      |
| `--add-dir=DIRECTORY` | Add a directory to the allowed-paths list                          |
| `--allow-all`         | Allow all permissions (alias: `--yolo`)                            |
| `--allow-tool=TOOL`   | Grant permission for a specific tool (comma-separated list)        |
| `--allow-url=URL`     | Allow the agent to fetch a specific URL or domain                  |

---

## 💬 Interactive Slash Commands

### General

| Command       | Description                                        |
| ------------- | -------------------------------------------------- |
| `/help`       | Show help for interactive commands                 |
| `/clear`      | Clear session history and context                  |
| `/exit`       | Exit the Copilot session (alias: `/quit`)          |
| `/session`    | Manage or view current session info                |
| `/diff`       | Review changes in current directory / branch diff  |
| `/env`        | Show loaded environment details (MCP, skills, etc.)|

### Model & Agent

| Command            | Description                                  |
| ------------------ | -------------------------------------------- |
| `/model`           | Select the AI model to use                   |
| `/agent`           | Browse and select from available agents      |
| `/cwd [PATH]`      | Change the working directory                 |

### Scheduling (Experimental)

| Command                            | Description                                           |
| ---------------------------------- | ----------------------------------------------------- |
| `/after DELAY PROMPT`              | Schedule a one-time prompt (e.g. `/after 30m remind me`) |
| `/every INTERVAL PROMPT`           | Schedule a recurring prompt (e.g. `/every 1h run tests`) |

---

## 🔌 MCP Server Management

```bash
# Command-line
copilot mcp                        # Manage MCP server configurations

# Interactive slash commands
/mcp show                          # List available MCP servers
/mcp add                           # Add a new MCP server
/mcp edit                          # Edit an existing MCP server
/mcp delete                        # Delete an MCP server
/mcp disable                       # Disable an MCP server
/mcp enable                        # Enable an MCP server
/mcp auth                          # Authenticate with an MCP server
/mcp reload                        # Reload MCP server configs
/mcp search                        # Search for MCP servers
```

---

## 🧩 Plugin Management

```bash
copilot plugin install SPECIFICATION  # Install a plugin
copilot plugin uninstall NAME         # Remove a plugin
copilot plugin list                   # List installed plugins
copilot plugin update NAME            # Update a plugin (use --all for all)
copilot plugin enable NAME            # Enable a disabled plugin
copilot plugin disable NAME           # Disable a plugin without uninstalling
```

### Plugin Marketplaces

```bash
copilot plugin marketplace add SPEC     # Register a marketplace
copilot plugin marketplace list         # List registered marketplaces
copilot plugin marketplace browse NAME  # Browse marketplace plugins
copilot plugin marketplace remove NAME  # Unregister a marketplace
```

---

## 🔗 Legacy `gh copilot` Extension (Deprecated)

> Deprecated in October 2025. Migrate to the standalone Copilot CLI.

```bash
gh extension install github/gh-copilot   # Install the extension

gh copilot suggest "Install git"                     # Get a command suggestion
gh copilot explain "traceroute github.com"           # Explain a command

gh copilot alias                         # Generate shell-specific aliases
gh copilot config                        # Configure options
```

---

## ⌨️ Useful Examples

```bash
# Start interactive session
copilot

# Ask Copilot to suggest a git command
copilot -p "how to squash last 3 commits"

# Use in a script
RESULT=$(copilot -p -s "generate a .gitignore for a Node.js project")
echo "$RESULT" > .gitignore

# Use a specific model
copilot --model=claude-sonnet-4

# Allow all file and tool permissions
copilot --allow-all
```

---

## 📚 Resources

- [GitHub Copilot CLI Docs](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-command-reference)
- [Copilot CLI Repo](https://github.com/github/copilot-cli)
- [Copilot CLI Plugin Reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-plugin-reference)
