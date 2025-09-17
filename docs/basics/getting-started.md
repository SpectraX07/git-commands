# 🚀 Getting Started with Git

## What is Git?

Git is a distributed version control system that tracks changes in files and coordinates work among multiple people. It's essential for modern software development.

## Installation

### Windows
```bash
# Download from https://git-scm.com/download/win
# Or use chocolatey
choco install git

# Or use winget
winget install --id Git.Git -e --source winget
```

### macOS
```bash
# Using Homebrew
brew install git

# Using MacPorts
sudo port install git

# Xcode Command Line Tools
xcode-select --install
```

### Linux
```bash
# Ubuntu/Debian
sudo apt update && sudo apt install git

# CentOS/RHEL/Fedora
sudo yum install git
# or
sudo dnf install git

# Arch Linux
sudo pacman -S git
```

## First-Time Setup

### Configure Your Identity
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Set Default Branch Name
```bash
git config --global init.defaultBranch main
```

### Configure Your Editor
```bash
# VS Code
git config --global core.editor "code --wait"

# Vim
git config --global core.editor "vim"

# Nano
git config --global core.editor "nano"

# Sublime Text
git config --global core.editor "subl -n -w"
```

### Verify Configuration
```bash
git config --list
git config --global --list
```

## Your First Repository

### Initialize a New Repository
```bash
mkdir my-project
cd my-project
git init
```

### Clone an Existing Repository
```bash
git clone https://github.com/username/repository.git
cd repository
```

## Basic Workflow

### 1. Check Status
```bash
git status
```

### 2. Add Files
```bash
# Add specific file
git add filename.txt

# Add all files
git add .

# Add all files including deletions
git add -A
```

### 3. Commit Changes
```bash
git commit -m "Your commit message"
```

### 4. Push to Remote
```bash
git push origin main
```

## Understanding Git States

```
Working Directory → Staging Area → Repository
     (add)            (commit)
```

- **Working Directory**: Your local files
- **Staging Area**: Files ready to be committed
- **Repository**: Committed snapshots

## Next Steps

1. Read [Basic Commands](../basics/basic-commands.md)
2. Learn about [Branching](../basics/branching.md)
3. Practice with [Beginner Examples](../../examples/beginner/)
4. Set up [Git Hooks](../../templates/hooks/)

## Quick Reference

| Command | Description |
|---------|-------------|
| `git init` | Initialize repository |
| `git clone <url>` | Clone repository |
| `git status` | Check status |
| `git add <file>` | Stage file |
| `git commit -m "msg"` | Commit changes |
| `git push` | Push to remote |
| `git pull` | Pull from remote |

---

**Next**: [Basic Commands →](basic-commands.md)
