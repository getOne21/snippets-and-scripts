# 🔧 Git Commands

---

## 🆕 Initial Setup

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global core.editor "code --wait"
git config --global init.defaultBranch main
```

---

## 📁 Repository Basics

```bash
git init                           # Initialize a new repository
git clone <url>                    # Clone a remote repo
git status                         # Show current changes
git add <file>                     # Stage file
git add .                          # Stage all changes
git commit -m "message"            # Commit staged changes
```

---

## 🔁 Branching & Merging

```bash
git branch                         # List local branches
git branch <name>                  # Create a new branch
git switch <name>                  # Switch to a branch
git checkout -b <name>             # Create and switch in one step
git merge <branch>                 # Merge into current branch
git rebase <branch>                # Rebase onto branch
```

---

## 🌐 Remote Repositories

```bash
git remote -v                      # List remotes
git remote add origin <url>        # Add a remote
git push -u origin main            # Push first time and track
git push                           # Push to tracked branch
git pull                           # Pull latest changes
```

---

## ⏮️ Undo & Reset

```bash
git restore <file>                # Discard unstaged changes
git restore --staged <file>       # Unstage a file
git reset --hard                  # Reset everything to last commit
git reset HEAD~1                  # Undo last commit, keep changes
git revert <commit>               # Revert a specific commit
```

---

## 🔍 Inspection & Logs

```bash
git log                           # Show commit history
git log --oneline --graph         # Visual log
git diff                          # Compare working dir vs index
git diff HEAD                     # Compare vs last commit
git show <commit>                 # Show specific commit
```

---

## 🎯 Stashing

```bash
git stash                         # Save current changes
git stash list                    # Show all stashes
git stash apply                   # Apply latest stash
git stash drop                    # Delete latest stash
```

---

## 📎 Tags

```bash
git tag                           # List tags
git tag <tagname>                 # Create lightweight tag
git tag -a <tagname> -m "msg"     # Annotated tag
git push origin <tagname>         # Push tag to remote
```

---

## 🔄 Submodules

```bash
git submodule add <url> path/     # Add submodule
git submodule update --init       # Clone submodules
git submodule foreach git pull    # Update all submodules
```

---

## ✅ Helpful Shortcuts

```bash
git commit -am "msg"              # Add + commit in one step
git checkout -                    # Switch to previous branch
git push origin --tags            # Push all tags
```

---

## 🧰 Troubleshooting

```bash
git fsck                          # Check repo for issues
git clean -fd                     # Remove untracked files/folders
git reflog                        # View history including resets
git cherry-pick <commit>          # Apply specific commit from another branch
```

---

## 📦 Git Aliases (Example)

```bash
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm "commit -m"
git config --global alias.st status
```

---

## 🔐 Removing Sensitive Data from History

> If you’ve accidentally committed and pushed secrets (like API keys), do the following:

### Remove a file from all history

```bash
git filter-branch --force --index-filter   "git rm --cached --ignore-unmatch path/to/file"   --prune-empty --tag-name-filter cat -- --all
```

Then force-push:

```bash
git push origin --force --all
git push origin --force --tags
```

### Or use BFG Repo-Cleaner (faster & safer for mass cleanup)

```bash
# Download: https://rtyley.github.io/bfg-repo-cleaner/
java -jar bfg.jar --delete-files 'id_rsa'  # Replace with filename or pattern
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push origin --force --all
```

---

## 🚫 Ignore Files

```bash
echo "secrets.env" >> .gitignore
git rm --cached secrets.env
git commit -m "remove secrets.env from version control"
```

---

## ⛔ Prevent Future Secret Commits

Add pre-commit hook (using `git-secrets`):

```bash
brew install git-secrets
git secrets --install
git secrets --register-aws
```

Or use `.pre-commit-config.yaml` with secret scanning tools.

---

## 🧼 Cleaning Large Files from History

Use [git-filter-repo](https://github.com/newren/git-filter-repo):

```bash
pip install git-filter-repo
git filter-repo --path filename --invert-paths
```

---

## 📦 Export Git Repo Without History

```bash
git archive --format=zip --output=repo.zip main
```

---

## 🛑 Stop Tracking a File Already in Git

```bash
git rm --cached filename
echo "filename" >> .gitignore
git commit -m "stop tracking filename"
```

---

## 🚧 Temporarily Work Without Affecting Main History

Use Worktrees:

```bash
git worktree add ../new-feature new-feature-branch
cd ../new-feature
# Work independently from main repo folder
```

---

## 🗃️ Squash Commits

```bash
git rebase -i HEAD~N    # Replace N with number of commits to squash
# Mark all but the first as 'squash' or 's'
git push --force-with-lease
```

---

## 🔄 Change Commit Message (Last)

```bash
git commit --amend -m "New commit message"
git push --force
```

---

## 🧽 Delete Local and Remote Branch

```bash
git branch -d local-branch
git push origin --delete remote-branch
```

---

## 📚 Useful Miscellaneous Git Commands

### View all aliases you've configured

```bash
git config --get-regexp alias
```

---

### Set a default push behavior (e.g., simple)

```bash
git config --global push.default simple
```

---

### Show files changed in a specific commit

```bash
git show --name-only <commit>
```

---

### List files that have changed between two commits

```bash
git diff --name-only <commit1> <commit2>
```

---

### Compare local branch with remote

```bash
git fetch
git diff origin/main..main
```

---

### View branches that have already been merged

```bash
git branch --merged
```

---

### View branches that have **not** been merged yet

```bash
git branch --no-merged
```

---

### Rename current branch

```bash
git branch -m new-name
```

---

### Clean up old branches that are already merged

```bash
git branch --merged | grep -v '\*' | xargs -n 1 git branch -d
```

---

## 📤 Push All Local Branches to Remote

```bash
git push --all
```

---

### 📥 Fetch All Tags and Branches

```bash
git fetch --all --tags
```

---

### 🔍 Search Commit History for Text

```bash
git log -S'someText'                # Find commits that added/removed someText
git grep 'someText'                 # Search working directory
```

---

### 🧮 Count Commits per Author

```bash
git shortlog -s -n
```

---

### 🧾 Get Commit History for a Specific File

```bash
git log --follow <file>
```

---
