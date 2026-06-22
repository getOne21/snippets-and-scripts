# 🔷 Azure DevOps CLI (`az devops`) Commands

> Manage Azure DevOps pipelines, repos, work items, and projects directly from the terminal.

---

## 📦 Installation

The Azure DevOps CLI is an extension of the Azure CLI:

```bash
# Install Azure CLI first (if not already)
# macOS
brew install azure-cli

# Windows
choco install azure-cli
winget install -e --id Microsoft.AzureCLI

# Linux (Debian/Ubuntu)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Add the DevOps extension
az extension add --name azure-devops
az extension update --name azure-devops     # Update if already installed
```

---

## 🔐 Authentication & Configuration

```bash
az login                                    # Login to Azure
az devops login                             # Login to Azure DevOps (PAT prompted)

# Set defaults (avoid passing --org and --project every time)
az devops configure --defaults organization=https://dev.azure.com/myorg
az devops configure --defaults project=MyProject
az devops configure --list                  # View current defaults
```

---

## 📁 Projects

```bash
az devops project list                      # List all projects
az devops project show --project MyProject  # Show project details
az devops project create --name NewProject --description "My new project"
az devops project delete --id <project-id> --yes
```

---

## 🔀 Repositories

```bash
az repos list                               # List all repos in project
az repos show --repository MyRepo           # Show repo details
az repos create --name NewRepo              # Create a new repo
az repos delete --id <repo-id> --yes        # Delete a repo

# Clone URL
az repos show --repository MyRepo --query sshUrl -o tsv
az repos show --repository MyRepo --query webUrl -o tsv
```

---

## 🔀 Pull Requests

```bash
# Create
az repos pr create --title "My PR" --source-branch feature --target-branch main
az repos pr create --title "My PR" --source-branch feature --target-branch main \
  --description "PR description" --reviewers user@email.com

# List & View
az repos pr list                            # List active PRs
az repos pr list --status all               # All PRs (active, abandoned, completed)
az repos pr list --creator "user@email.com" # Filter by creator
az repos pr show --id 42                    # Show PR details

# Review & Manage
az repos pr set-vote --id 42 --vote approve       # Approve
az repos pr set-vote --id 42 --vote reject         # Reject
az repos pr set-vote --id 42 --vote wait-for-author  # Wait for author
az repos pr set-vote --id 42 --vote reset          # Reset vote

# Update & Complete
az repos pr update --id 42 --title "Updated title"
az repos pr update --id 42 --status completed      # Complete/merge PR
az repos pr update --id 42 --status abandoned      # Abandon PR

# Reviewers
az repos pr reviewer add --id 42 --reviewers user@email.com
az repos pr reviewer list --id 42

# Work Item linking
az repos pr work-item add --id 42 --work-items 123
az repos pr work-item list --id 42
```

---

## 🔑 Branch Policies

```bash
az repos policy list --repository-id <repo-id>  # List policies
az repos policy create --config policy.json      # Create from JSON config
az repos policy update --id <policy-id> --config policy.json
az repos policy delete --id <policy-id> --yes
```

---

## 🚀 Pipelines

```bash
# List & View
az pipelines list                           # List all pipelines
az pipelines show --id 1                    # Show pipeline details
az pipelines show --name "Build Pipeline"   # Show by name

# Run
az pipelines run --id 1                     # Trigger a pipeline run
az pipelines run --id 1 --branch main       # Run on specific branch
az pipelines run --id 1 --variables key=value  # Run with variables

# Build (runs/executions)
az pipelines build list                     # List recent builds
az pipelines build show --id 123            # Show build details
az pipelines build list --status completed  # Filter by status
az pipelines build list --result succeeded  # Filter by result

# Logs
az pipelines runs show --id 123             # Show run details

# Create & Manage
az pipelines create --name "My Pipeline" --yml-path azure-pipelines.yml \
  --repository MyRepo --repository-type tfsgit
az pipelines delete --id 1 --yes
az pipelines update --id 1 --new-name "Renamed Pipeline"

# Pipeline Variables
az pipelines variable create --name MY_VAR --value "value" --pipeline-id 1
az pipelines variable list --pipeline-id 1
az pipelines variable update --name MY_VAR --value "new" --pipeline-id 1
az pipelines variable delete --name MY_VAR --pipeline-id 1 --yes

# Pipeline Variable Groups
az pipelines variable-group list
az pipelines variable-group show --id 1
az pipelines variable-group create --name "MyVarGroup" --variables key1=val1 key2=val2
az pipelines variable-group variable create --group-id 1 --name newvar --value val
```

---

## 📋 Work Items (Boards)

```bash
# Create
az boards work-item create --title "Fix login bug" --type Bug
az boards work-item create --title "Add feature" --type "User Story"
az boards work-item create --title "Implement API" --type Task \
  --assigned-to user@email.com --area "MyProject\Backend"

# View & List
az boards work-item show --id 123           # Show work item details
az boards work-item show --id 123 --fields "System.Title,System.State"

# Update
az boards work-item update --id 123 --state Active
az boards work-item update --id 123 --assigned-to user@email.com
az boards work-item update --id 123 --discussion "Adding a comment"

# Delete
az boards work-item delete --id 123 --yes

# Relations
az boards work-item relation add --id 123 --relation-type parent --target-id 456
az boards work-item relation remove --id 123 --relation-type parent --target-id 456

# Query
az boards query --wiql "SELECT [System.Id], [System.Title] FROM WorkItems WHERE [System.State] = 'Active'"
```

---

## 🏷️ Iterations & Areas

```bash
# Iterations (Sprints)
az boards iteration team list --team "MyTeam"
az boards iteration team add --id <iteration-id> --team "MyTeam"

# Areas
az boards area team list --team "MyTeam"
az boards area team add --path "MyProject\Backend" --team "MyTeam"
```

---

## 🌐 Wikis

```bash
az devops wiki list                         # List wikis
az devops wiki show --wiki MyWiki           # Show wiki details
az devops wiki create --name MyWiki --type projectWiki
az devops wiki page create --wiki MyWiki --path "Home" --file-path ./content.md
az devops wiki page show --wiki MyWiki --path "Home"
az devops wiki page update --wiki MyWiki --path "Home" --file-path ./content.md \
  --version <etag>
```

---

## 🔐 Service Connections

```bash
az devops service-endpoint list             # List service connections
az devops service-endpoint show --id <id>   # Show details
az devops service-endpoint create --service-endpoint-configuration config.json
az devops service-endpoint delete --id <id> --yes
```

---

## 👥 Teams & Users

```bash
az devops team list                         # List teams
az devops team show --team "MyTeam"         # Show team details
az devops team create --name "NewTeam"      # Create a team

az devops user list                         # List org users
az devops user show --user user@email.com   # Show user details
```

---

## 📊 Artifacts

```bash
az artifacts universal publish --feed MyFeed --name MyPackage --version 1.0.0 --path ./dist
az artifacts universal download --feed MyFeed --name MyPackage --version 1.0.0 --path ./download

az artifacts feed list                      # List feeds
az artifacts feed create --name MyFeed      # Create a feed
```

---

## ⌨️ Useful Tips

```bash
# Output formats
az pipelines list -o table                  # Table format (readable)
az pipelines list -o json                   # JSON format (scriptable)
az pipelines list -o tsv                    # TSV (good for piping)

# JMESPath queries
az repos pr list --query "[?status=='active'].{ID:pullRequestId, Title:title}" -o table

# Use environment variable for PAT
export AZURE_DEVOPS_EXT_PAT=<your-pat>
```

---

## 📚 Resources

- [Azure DevOps CLI Docs](https://learn.microsoft.com/en-us/cli/azure/devops)
- [Azure CLI Reference](https://learn.microsoft.com/en-us/cli/azure/reference-index)
- [Azure DevOps REST API](https://learn.microsoft.com/en-us/rest/api/azure/devops/)
