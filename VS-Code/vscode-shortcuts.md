# 💻 VS Code / Devin Desktop Shortcuts & Tips

> Keyboard shortcuts, settings, debugging configs, and useful extensions to supercharge your editor.

---

## ⌨️ Essential Keyboard Shortcuts

### General

| Shortcut (Win/Linux)  | Shortcut (macOS)       | Action                          |
| --------------------- | ---------------------- | ------------------------------- |
| `Ctrl+Shift+P`       | `Cmd+Shift+P`         | Command Palette                 |
| `Ctrl+P`             | `Cmd+P`               | Quick Open (file search)        |
| `Ctrl+,`             | `Cmd+,`               | Open Settings                   |
| `Ctrl+``             | `Cmd+``               | Toggle Terminal                  |
| `Ctrl+B`             | `Cmd+B`               | Toggle Sidebar                  |
| `Ctrl+Shift+E`       | `Cmd+Shift+E`         | Explorer panel                  |
| `Ctrl+Shift+G`       | `Cmd+Shift+G`         | Source Control panel            |
| `Ctrl+Shift+X`       | `Cmd+Shift+X`         | Extensions panel                |
| `Ctrl+Shift+D`       | `Cmd+Shift+D`         | Debug panel                     |
| `Ctrl+K Ctrl+S`      | `Cmd+K Cmd+S`         | Keyboard Shortcuts editor       |
| `F11`                | `Ctrl+Cmd+F`          | Toggle Full Screen              |

### Editing

| Shortcut (Win/Linux)  | Shortcut (macOS)       | Action                          |
| --------------------- | ---------------------- | ------------------------------- |
| `Ctrl+D`             | `Cmd+D`               | Select next occurrence          |
| `Ctrl+Shift+L`       | `Cmd+Shift+L`         | Select all occurrences          |
| `Alt+Up/Down`        | `Opt+Up/Down`         | Move line up/down               |
| `Shift+Alt+Up/Down`  | `Shift+Opt+Up/Down`   | Copy line up/down               |
| `Ctrl+Shift+K`       | `Cmd+Shift+K`         | Delete line                     |
| `Ctrl+/`             | `Cmd+/`               | Toggle line comment             |
| `Shift+Alt+A`        | `Shift+Opt+A`         | Toggle block comment            |
| `Ctrl+L`             | `Cmd+L`               | Select entire line              |
| `Ctrl+Shift+\`       | `Cmd+Shift+\`         | Jump to matching bracket        |
| `Ctrl+]` / `Ctrl+[`  | `Cmd+]` / `Cmd+[`     | Indent / Outdent line           |
| `Ctrl+Enter`         | `Cmd+Enter`            | Insert line below               |
| `Ctrl+Shift+Enter`   | `Cmd+Shift+Enter`      | Insert line above               |
| `Ctrl+H`             | `Cmd+H`               | Find and replace                |
| `Ctrl+Shift+H`       | `Cmd+Shift+H`         | Find and replace in files       |

### Multi-Cursor

| Shortcut (Win/Linux)         | Shortcut (macOS)           | Action                    |
| ---------------------------- | -------------------------- | ------------------------- |
| `Alt+Click`                  | `Opt+Click`                | Add cursor                |
| `Ctrl+Alt+Up/Down`          | `Cmd+Opt+Up/Down`         | Add cursor above/below    |
| `Ctrl+Shift+L`              | `Cmd+Shift+L`             | Cursor at all occurrences |
| `Ctrl+U`                    | `Cmd+U`                   | Undo last cursor          |

### Navigation

| Shortcut (Win/Linux)  | Shortcut (macOS)       | Action                          |
| --------------------- | ---------------------- | ------------------------------- |
| `Ctrl+G`             | `Cmd+G`               | Go to line                      |
| `Ctrl+T`             | `Cmd+T`               | Go to symbol in workspace       |
| `Ctrl+Shift+O`       | `Cmd+Shift+O`         | Go to symbol in file            |
| `F12`                | `F12`                 | Go to definition                |
| `Alt+F12`            | `Opt+F12`             | Peek definition                 |
| `Shift+F12`          | `Shift+F12`           | Find all references             |
| `Ctrl+Tab`           | `Ctrl+Tab`            | Switch between open files       |
| `Ctrl+\`             | `Cmd+\`               | Split editor                    |
| `Alt+Left/Right`     | `Ctrl+-` / `Ctrl+Shift+-` | Navigate back/forward      |

---

## 🛠️ Useful Settings (`settings.json`)

Open with `Ctrl+Shift+P` → "Preferences: Open Settings (JSON)":

```json
{
  "editor.fontSize": 14,
  "editor.tabSize": 2,
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.minimap.enabled": false,
  "editor.wordWrap": "on",
  "editor.bracketPairColorization.enabled": true,
  "editor.guides.bracketPairs": true,
  "editor.linkedEditing": true,
  "editor.stickyScroll.enabled": true,
  "editor.inlineSuggest.enabled": true,

  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000,
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,

  "terminal.integrated.defaultProfile.windows": "PowerShell",
  "terminal.integrated.fontSize": 13,

  "workbench.colorTheme": "One Dark Pro",
  "workbench.iconTheme": "material-icon-theme",
  "workbench.startupEditor": "none",

  "explorer.confirmDelete": false,
  "explorer.confirmDragAndDrop": false
}
```

---

## 🐛 Debug Configurations (`launch.json`)

### Node.js

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Launch Program",
      "program": "${workspaceFolder}/src/index.js",
      "skipFiles": ["<node_internals>/**"]
    }
  ]
}
```

### .NET

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": ".NET Core Launch",
      "type": "coreclr",
      "request": "launch",
      "program": "${workspaceFolder}/bin/Debug/net8.0/MyApp.dll",
      "cwd": "${workspaceFolder}",
      "stopAtEntry": false,
      "console": "integratedTerminal"
    }
  ]
}
```

### Chrome (Frontend)

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "chrome",
      "request": "launch",
      "name": "Launch Chrome",
      "url": "http://localhost:4200",
      "webRoot": "${workspaceFolder}/src"
    }
  ]
}
```

---

## 📄 Task Runner (`tasks.json`)

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "build",
      "type": "shell",
      "command": "dotnet build",
      "group": { "kind": "build", "isDefault": true },
      "problemMatcher": "$msCompile"
    },
    {
      "label": "test",
      "type": "shell",
      "command": "dotnet test",
      "group": { "kind": "test", "isDefault": true }
    }
  ]
}
```

---

## 🧩 Must-Have Extensions

### General

| Extension                    | Purpose                              |
| ---------------------------- | ------------------------------------ |
| Prettier                     | Code formatter                       |
| ESLint                       | JavaScript/TypeScript linting        |
| EditorConfig for VS Code     | Consistent coding styles             |
| GitLens                      | Enhanced Git integration             |
| Error Lens                   | Inline error/warning highlights      |
| Todo Tree                    | Highlight and list TODO comments     |
| Better Comments              | Color-coded comment annotations      |
| Path Intellisense            | Autocomplete file paths              |

### .NET / C#

| Extension                    | Purpose                              |
| ---------------------------- | ------------------------------------ |
| C# Dev Kit                   | Full C# development experience       |
| .NET Install Tool            | Manage .NET SDK versions             |
| NuGet Gallery                | Browse and install NuGet packages    |

### Angular / Frontend

| Extension                    | Purpose                              |
| ---------------------------- | ------------------------------------ |
| Angular Language Service     | Angular template intelligence        |
| Tailwind CSS IntelliSense    | Tailwind class autocomplete          |
| Auto Rename Tag              | Rename paired HTML/XML tags          |

### Docker & DevOps

| Extension                    | Purpose                              |
| ---------------------------- | ------------------------------------ |
| Docker                       | Dockerfile & Compose support         |
| Kubernetes                   | K8s cluster management               |
| Remote - SSH                 | Develop on remote machines           |
| Dev Containers               | Develop inside containers            |

### AI

| Extension                    | Purpose                              |
| ---------------------------- | ------------------------------------ |
| GitHub Copilot               | AI code completion                   |
| Devin Desktop (Cascade)      | AI coding agent                      |

---

## ⌨️ Handy Command Palette Commands

| Command                                | Action                               |
| -------------------------------------- | ------------------------------------ |
| `Format Document`                      | Format the current file              |
| `Transform to Uppercase/Lowercase`     | Change text casing                   |
| `Sort Lines Ascending/Descending`      | Sort selected lines                  |
| `Toggle Word Wrap`                     | Enable/disable word wrap             |
| `Reopen Closed Editor`                 | Restore a recently closed tab        |
| `Change Language Mode`                 | Set syntax highlighting              |
| `Compare Active File With...`          | Diff two files                       |
| `Fold All` / `Unfold All`             | Collapse/expand all code blocks      |

---

## 📚 Resources

- [VS Code Docs](https://code.visualstudio.com/docs)
- [VS Code Keyboard Shortcuts (PDF)](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf)
- [Devin Desktop Docs](https://docs.devin.ai/desktop)
