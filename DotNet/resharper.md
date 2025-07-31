<img src="resharper-icon.png" alt="ReSharper" style="max-width:8%"/>
<b style="font-size:2.0rem; margin: 0px 0px 0px 10px">ReSharper | Installation Guide & Commands </b>

---

[ReSharper](https://www.jetbrains.com/resharper/) is a powerful Visual Studio extension from JetBrains that enhances .NET development with advanced code analysis, refactoring, navigation, and productivity tools.

---

## 🚀 Installation

### Option 1: JetBrains Toolbox (Recommended)

1. Download JetBrains Toolbox from: <https://www.jetbrains.com/toolbox-app/>
2. Install and launch it.
3. Locate **ReSharper** under Tools.
4. Click `Install`.

### Option 2: Manual Installer

1. Go to <https://www.jetbrains.com/resharper/download/>
2. Download and run the installer.
3. Select your installed Visual Studio versions.
4. Complete the setup wizard.

---

## 🔐 Activation

- Use your JetBrains Account or license key.
- You can also use the 30-day trial.
- Use the license reset batch to reset the license after expiration: [ReSharperTrialLicenseReset.bat](Scripts/ReSharperTrialLicenseReset.bat)

---

## ⚙️ Initial Setup

ReSharper will prompt you to select:

- **Keymap**: Choose between Visual Studio, IntelliJ IDEA, or customize.
- **Code Style**: Align with your project or team style.
- **Extensions**: Add extra plugins like `ReSpeller`, `StyleCop`, etc.

---

## 🛠️ Useful Features

### 🔎 Code Analysis

- Highlights errors/warnings in real-time.
- Suggests quick fixes (`Alt+Enter`).

### 🧹 Code Cleanup

- Use `Ctrl+E, C` to clean up code formatting and unused directives.

### 🔁 Refactorings

- Rename (`F2`), Extract Method, Move to File, Convert to Auto-Property, and more.

### 🧭 Navigation

- `Ctrl+T`: Go to Type
- `Ctrl+Shift+T`: Go to File
- `Ctrl+Shift+Alt+N`: Go to Symbol
- `Ctrl+Shift+Backspace`: Navigate to last edit location

### 📊 Code Quality Tools

- Cyclomatic complexity
- Unused code detection
- Code metrics

---

## ⌨️ Productivity Shortcuts

| Action                  | Shortcut           |
|-------------------------|--------------------|
| Show Quick Actions      | `Alt+Enter`        |
| Go to Declaration       | `Ctrl+B / F12`     |
| Find Usages             | `Shift+F12`        |
| Navigate to Base        | `Ctrl+U`           |
| Generate Code (props, ctors, etc) | `Alt+Insert` |
| Refactor This           | `Ctrl+Shift+R`     |

---

## 📁 Shared Settings

You can export/import `.DotSettings` files to apply consistent formatting & inspection rules across teams.

- Export via: `ReSharper → Manage Options → Save`
- Share the `.sln.DotSettings` file with your team.

---

## ⚙️ Performance Tips

- Exclude large folders (like `node_modules`, `bin`, `obj`) via `ReSharper → Options → Code Inspection → Settings`
- Increase memory heap in `.ReSharper` config if needed.
- Disable plugins you don’t use.

---

## 📦 Popular Extensions

- **ReSpeller** – Spell checker
- **StyleCop By JetBrains** – Coding style enforcement
- **ReSharper Postfix Templates** – `if`, `foreach`, `.notnull` style helpers

---

## 📚 Resources

- [ReSharper Docs](https://www.jetbrains.com/resharper/documentation/)
- [Keyboard Shortcut Cheat Sheet](https://resources.jetbrains.com/storage/products/resharper/docs/ReSharperDefaultKeymap.pdf)

---
