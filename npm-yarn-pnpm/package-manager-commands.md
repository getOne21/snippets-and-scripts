# 📦 npm / yarn / pnpm Commands

> Essential package manager commands for JavaScript and TypeScript projects — installing, managing, and publishing packages.

---

## 📥 Installation

```bash
# npm (comes with Node.js)
# https://nodejs.org

# yarn
npm install -g yarn                 # Classic (v1)
corepack enable                     # Enable Yarn v2+ via Corepack (Node 16.10+)

# pnpm
npm install -g pnpm
# or
corepack enable && corepack prepare pnpm@latest --activate
# or
curl -fsSL https://get.pnpm.io/install.sh | sh -
```

---

## 🚀 Project Initialization

| Action                    | npm                      | yarn                   | pnpm                   |
| ------------------------- | ------------------------ | ---------------------- | ---------------------- |
| Init new project          | `npm init`               | `yarn init`            | `pnpm init`            |
| Init with defaults        | `npm init -y`            | `yarn init -y`         | `pnpm init`            |

---

## 📦 Installing Dependencies

| Action                    | npm                           | yarn                      | pnpm                      |
| ------------------------- | ----------------------------- | ------------------------- | ------------------------- |
| Install all deps          | `npm install`                 | `yarn`                    | `pnpm install`            |
| Add a package             | `npm install lodash`          | `yarn add lodash`         | `pnpm add lodash`         |
| Add as dev dependency     | `npm install -D jest`         | `yarn add -D jest`        | `pnpm add -D jest`        |
| Add globally              | `npm install -g typescript`   | `yarn global add tsc`     | `pnpm add -g typescript`  |
| Add exact version         | `npm install lodash@4.17.21`  | `yarn add lodash@4.17.21` | `pnpm add lodash@4.17.21` |
| Install from lockfile     | `npm ci`                      | `yarn install --frozen-lockfile` | `pnpm install --frozen-lockfile` |

---

## 🗑️ Removing Dependencies

| Action                    | npm                      | yarn                   | pnpm                   |
| ------------------------- | ------------------------ | ---------------------- | ---------------------- |
| Remove a package          | `npm uninstall lodash`   | `yarn remove lodash`   | `pnpm remove lodash`   |
| Remove global package     | `npm uninstall -g tsc`   | `yarn global remove tsc`| `pnpm remove -g tsc`  |

---

## 🔄 Updating Dependencies

| Action                    | npm                      | yarn                    | pnpm                   |
| ------------------------- | ------------------------ | ----------------------- | ---------------------- |
| Update all                | `npm update`             | `yarn upgrade`          | `pnpm update`          |
| Update specific package   | `npm update lodash`      | `yarn upgrade lodash`   | `pnpm update lodash`   |
| Check for outdated        | `npm outdated`           | `yarn outdated`         | `pnpm outdated`        |
| Interactive upgrade       | `npx npm-check -u`      | `yarn upgrade-interactive` | `pnpm update -i`   |

---

## 🏃 Running Scripts

| Action                    | npm                      | yarn                   | pnpm                   |
| ------------------------- | ------------------------ | ---------------------- | ---------------------- |
| Run a script              | `npm run build`          | `yarn build`           | `pnpm build`           |
| Run start                 | `npm start`              | `yarn start`           | `pnpm start`           |
| Run test                  | `npm test`               | `yarn test`            | `pnpm test`            |
| List available scripts    | `npm run`                | `yarn run`             | `pnpm run`             |
| Run with args             | `npm run build -- --prod`| `yarn build --prod`    | `pnpm build --prod`    |

---

## 📋 Package Info

| Action                    | npm                          | yarn                      | pnpm                      |
| ------------------------- | ---------------------------- | ------------------------- | ------------------------- |
| List installed packages   | `npm list`                   | `yarn list`               | `pnpm list`               |
| List top-level only       | `npm list --depth=0`         | `yarn list --depth=0`     | `pnpm list --depth=0`     |
| View package info         | `npm info lodash`            | `yarn info lodash`        | `pnpm info lodash`        |
| Check for vulnerabilities | `npm audit`                  | `yarn audit`              | `pnpm audit`              |
| Fix vulnerabilities       | `npm audit fix`              | `yarn audit` (manual)     | `pnpm audit --fix`        |

---

## 🔒 Lockfiles

| Manager | Lockfile              | Purpose                              |
| ------- | --------------------- | ------------------------------------ |
| npm     | `package-lock.json`   | Exact dependency tree                |
| yarn    | `yarn.lock`           | Exact dependency tree                |
| pnpm    | `pnpm-lock.yaml`     | Exact dependency tree (content-addressable) |

> **Tip:** Always commit your lockfile to version control. Use `npm ci` / `yarn install --frozen-lockfile` / `pnpm install --frozen-lockfile` in CI.

---

## 🏢 Workspaces (Monorepos)

### npm Workspaces

```json
// package.json
{
  "workspaces": ["packages/*"]
}
```

```bash
npm install                                 # Install all workspace deps
npm run build -w packages/core              # Run script in specific workspace
npm run build --workspaces                  # Run in all workspaces
npm install lodash -w packages/core         # Add dep to specific workspace
```

### yarn Workspaces

```json
// package.json
{
  "workspaces": ["packages/*"]
}
```

```bash
yarn                                        # Install all workspace deps
yarn workspace @myorg/core build            # Run script in workspace
yarn workspaces run build                   # Run in all workspaces
yarn workspace @myorg/core add lodash       # Add dep to workspace
```

### pnpm Workspaces

```yaml
# pnpm-workspace.yaml
packages:
  - 'packages/*'
```

```bash
pnpm install                                # Install all workspace deps
pnpm --filter @myorg/core build             # Run script in workspace
pnpm -r build                               # Run in all workspaces (recursive)
pnpm --filter @myorg/core add lodash        # Add dep to workspace
```

---

## 🔧 Running Binaries / Executables

| Action                    | npm                      | yarn                   | pnpm                   |
| ------------------------- | ------------------------ | ---------------------- | ---------------------- |
| Run local binary          | `npx eslint .`           | `yarn dlx eslint .`    | `pnpm dlx eslint .`    |
| Run without install       | `npx create-react-app`   | `yarn dlx create-react-app` | `pnpm dlx create-react-app` |

---

## 📤 Publishing Packages

```bash
# npm
npm login                           # Login to npm registry
npm publish                         # Publish package
npm publish --access public         # Publish scoped package as public
npm version patch                   # Bump patch version (1.0.0 → 1.0.1)
npm version minor                   # Bump minor version (1.0.0 → 1.1.0)
npm version major                   # Bump major version (1.0.0 → 2.0.0)
npm deprecate pkg@"<1.0.0" "msg"    # Deprecate old versions
npm unpublish pkg@1.0.0             # Unpublish a version (within 72h)
```

---

## 🧹 Cleanup & Cache

| Action                    | npm                      | yarn                     | pnpm                   |
| ------------------------- | ------------------------ | ------------------------ | ---------------------- |
| Clear cache               | `npm cache clean --force`| `yarn cache clean`       | `pnpm store prune`     |
| Remove node_modules       | `rm -rf node_modules`    | `rm -rf node_modules`    | `rm -rf node_modules`  |
| Deduplicate               | `npm dedupe`             | `yarn dedupe`            | `pnpm dedupe`          |

---

## ⌨️ Useful Config

```bash
# npm
npm config set init-author-name "Your Name"
npm config set init-license MIT
npm config set save-exact true              # Pin exact versions by default
npm config list                             # View config

# Set registry
npm config set registry https://registry.npmjs.org/

# .npmrc (project level)
echo "save-exact=true" >> .npmrc
echo "engine-strict=true" >> .npmrc
```

---

## 📚 Resources

- [npm Docs](https://docs.npmjs.com/)
- [Yarn Docs](https://yarnpkg.com/getting-started)
- [pnpm Docs](https://pnpm.io/)
