# 🐙 GitHub CLI (`gh`) Commands

> Manage pull requests, issues, repos, and workflows directly from the terminal — deeply integrated with GitHub.

---

## 📦 Installation

```bash
# macOS
brew install gh

# Windows
choco install gh
winget install --id GitHub.cli

# Linux (Debian/Ubuntu)
sudo apt install gh

# Linux (Fedora)
sudo dnf install gh
```

---

## 🔐 Authentication

```bash
gh auth login                      # Interactive login (browser or token)
gh auth login --with-token < token.txt  # Login with a PAT from file
gh auth status                     # Check current auth status
gh auth logout                     # Log out
gh auth refresh                    # Refresh stored credentials
gh auth token                      # Print the current auth token
```

---

## 📁 Repository Management

```bash
gh repo create myrepo --public     # Create a new public repo
gh repo create myrepo --private    # Create a new private repo
gh repo clone owner/repo           # Clone a repo
gh repo fork owner/repo            # Fork a repo
gh repo view                       # View current repo info
gh repo view owner/repo --web      # Open repo in browser
gh repo list owner                 # List repos for a user/org
gh repo archive owner/repo         # Archive a repo
gh repo delete owner/repo --yes    # Delete a repo
gh repo rename new-name            # Rename the current repo
```

---

## 🔀 Pull Requests

```bash
gh pr create                       # Create a PR interactively
gh pr create --title "Fix bug" --body "Details"  # Create with title & body
gh pr create --draft                # Create a draft PR
gh pr create --base main --head feature  # Specify base and head branches

gh pr list                         # List open PRs
gh pr list --state all             # List all PRs (open, closed, merged)
gh pr list --author @me            # List your PRs

gh pr view 42                      # View PR #42 details
gh pr view 42 --web                # Open PR in browser
gh pr diff 42                      # View PR diff

gh pr checkout 42                  # Check out PR branch locally
gh pr merge 42                     # Merge a PR
gh pr merge 42 --squash            # Squash and merge
gh pr merge 42 --rebase            # Rebase and merge
gh pr merge 42 --auto              # Enable auto-merge

gh pr close 42                     # Close a PR
gh pr reopen 42                    # Reopen a closed PR
gh pr ready 42                     # Mark draft PR as ready for review

gh pr review 42 --approve          # Approve a PR
gh pr review 42 --request-changes --body "Fix X"  # Request changes
gh pr review 42 --comment --body "Looks good"     # Leave a comment

gh pr edit 42 --add-reviewer user1,user2  # Add reviewers
gh pr edit 42 --add-label "bug"    # Add labels
gh pr checks 42                    # View CI status for a PR
```

---

## 🐛 Issues

```bash
gh issue create                    # Create an issue interactively
gh issue create --title "Bug" --body "Steps to reproduce"
gh issue create --label "bug,urgent"  # Create with labels
gh issue create --assignee @me     # Assign to yourself

gh issue list                      # List open issues
gh issue list --label "bug"        # Filter by label
gh issue list --assignee @me       # List your issues

gh issue view 10                   # View issue details
gh issue view 10 --web             # Open in browser

gh issue close 10                  # Close an issue
gh issue reopen 10                 # Reopen an issue
gh issue edit 10 --add-label "fix" # Add label
gh issue comment 10 --body "Working on it"  # Add a comment
gh issue pin 10                    # Pin an issue
gh issue transfer 10 owner/other-repo  # Transfer to another repo
```

---

## 🚀 GitHub Actions / Workflows

```bash
gh run list                        # List recent workflow runs
gh run list --workflow build.yml   # Filter by workflow
gh run view 12345                  # View run details
gh run view 12345 --log            # View full run logs
gh run watch 12345                 # Watch a run in real-time
gh run rerun 12345                 # Re-run a failed run
gh run cancel 12345                # Cancel a running workflow
gh run download 12345              # Download run artifacts

gh workflow list                   # List all workflows
gh workflow view build.yml         # View workflow details
gh workflow run build.yml          # Manually trigger a workflow
gh workflow enable build.yml       # Enable a disabled workflow
gh workflow disable build.yml      # Disable a workflow
```

---

## 🔑 Secrets & Variables

```bash
gh secret set MY_SECRET            # Set a repo secret (prompted for value)
gh secret set MY_SECRET < secret.txt  # Set from file
gh secret list                     # List repo secrets
gh secret delete MY_SECRET         # Delete a secret

gh variable set MY_VAR --body "value"  # Set a repo variable
gh variable list                   # List repo variables
gh variable delete MY_VAR          # Delete a variable
```

---

## 📦 Releases

```bash
gh release create v1.0.0           # Create a release interactively
gh release create v1.0.0 --title "v1.0.0" --notes "First release"
gh release create v1.0.0 ./dist/*  # Upload assets with release
gh release create v1.0.0 --draft   # Create as draft
gh release create v1.0.0 --prerelease  # Mark as pre-release

gh release list                    # List releases
gh release view v1.0.0             # View release details
gh release download v1.0.0         # Download release assets
gh release delete v1.0.0 --yes     # Delete a release
gh release edit v1.0.0 --draft=false  # Publish a draft release
```

---

## 🌐 Gists

```bash
gh gist create file.txt            # Create a gist from a file
gh gist create --public file.txt   # Create a public gist
gh gist create -d "Description" file.txt  # With description
echo "code" | gh gist create       # Create from stdin

gh gist list                       # List your gists
gh gist view <id>                  # View gist content
gh gist edit <id>                  # Edit a gist
gh gist clone <id>                 # Clone a gist
gh gist delete <id>                # Delete a gist
```

---

## 🔍 Search

```bash
gh search repos "kubernetes" --language go    # Search repos
gh search issues "bug" --repo owner/repo      # Search issues
gh search prs "fix" --state open              # Search PRs
gh search commits "refactor" --repo owner/repo  # Search commits
gh search code "func main" --language go      # Search code
```

---

## 🔌 Extensions

```bash
gh extension install owner/gh-ext  # Install an extension
gh extension list                  # List installed extensions
gh extension upgrade --all         # Upgrade all extensions
gh extension remove gh-ext         # Remove an extension
gh extension search "copilot"      # Search for extensions
```

---

## 🛠️ API Access

```bash
gh api repos/owner/repo            # GET request to GitHub API
gh api repos/owner/repo --method POST --field name=value  # POST request
gh api graphql -f query='{ viewer { login } }'  # GraphQL query
gh api /user --jq '.login'         # Use jq to filter JSON output
```

---

## ⚙️ Configuration

```bash
gh config set editor "code --wait" # Set default editor
gh config set git_protocol ssh     # Use SSH for git operations
gh config set prompt disabled      # Disable interactive prompts
gh config list                     # List all config values
```

---

## ⌨️ Useful Aliases

```bash
gh alias set co 'pr checkout'      # gh co 42 → checkout PR #42
gh alias set pv 'pr view --web'    # gh pv → open PR in browser
gh alias set mypr 'pr list --author @me'  # gh mypr → list your PRs
gh alias list                      # List all aliases
gh alias delete co                 # Delete an alias
```

---

## 📚 Resources

- [GitHub CLI Docs](https://cli.github.com/manual/)
- [GitHub CLI Repo](https://github.com/cli/cli)
