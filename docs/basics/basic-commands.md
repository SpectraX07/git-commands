# 🔧 Basic Git Commands

## Repository Operations

### Initialize & Clone
```bash
git init                          # Initialize new repository
git clone <url>                   # Clone remote repository
git clone <url> <directory>       # Clone into specific directory
git clone --depth 1 <url>         # Shallow clone (latest commit only)
```

## File Operations

### Checking Status
```bash
git status                        # Show working tree status
git status -s                     # Short format
git status --porcelain            # Machine-readable format
```

### Adding Files (Staging)
```bash
git add <file>                    # Stage specific file
git add .                         # Stage all changes in current directory
git add -A                        # Stage all changes (including deletions)
git add -u                        # Stage modified and deleted files only
git add -p                        # Interactive staging (patch mode)
git add *.js                      # Stage all JavaScript files
```

### Committing Changes
```bash
git commit -m "message"           # Commit with message
git commit -am "message"          # Stage and commit all tracked files
git commit --amend               # Amend last commit
git commit --amend -m "new msg"   # Amend with new message
git commit --amend --no-edit      # Amend without changing message
git commit -v                     # Commit with diff in editor
```

### Viewing Changes
```bash
git diff                          # Show unstaged changes
git diff --staged                 # Show staged changes
git diff --cached                 # Same as --staged
git diff HEAD                     # Show all changes since last commit
git diff <commit1> <commit2>      # Compare two commits
git diff --name-only              # Show only file names
git diff --stat                   # Show statistics
```

## History & Logs

### Basic Log Commands
```bash
git log                           # Show commit history
git log --oneline                 # Compact format
git log --graph                   # Show branch graph
git log --all --graph --oneline   # Complete visual history
git log -p                        # Show patches (diffs)
git log --stat                    # Show file statistics
git log -n 5                      # Show last 5 commits
```

### Filtering Logs
```bash
git log --since="2 weeks ago"     # Filter by date
git log --until="2023-12-31"      # Until specific date
git log --author="John"           # Filter by author
git log --grep="fix"              # Search commit messages
git log --follow -- <file>        # Follow file history through renames
git log -S "function_name"        # Search for code changes
```

### Advanced Log Formatting
```bash
git log --pretty=format:"%h - %an, %ar : %s"
git log --pretty=oneline
git log --pretty=short
git log --pretty=full
git log --pretty=fuller
```

## Viewing Specific Commits
```bash
git show <commit>                 # Show specific commit
git show HEAD                     # Show last commit
git show HEAD~2                   # Show commit 2 steps back
git show HEAD^                    # Show parent commit
git show <commit>:<file>          # Show file at specific commit
```

## File Information
```bash
git blame <file>                  # Show who changed each line
git annotate <file>               # Similar to blame
git ls-files                      # List tracked files
git ls-files --others             # List untracked files
git ls-files --ignored            # List ignored files
```

## Removing & Moving Files
```bash
git rm <file>                     # Remove file from working tree and index
git rm --cached <file>            # Remove from index only (keep local)
git rm -r <directory>             # Remove directory recursively
git mv <old> <new>                # Move/rename file
```

## Ignoring Files
```bash
# Create .gitignore file
echo "node_modules/" >> .gitignore
echo "*.log" >> .gitignore
echo ".env" >> .gitignore

# Global gitignore
git config --global core.excludesfile ~/.gitignore_global
```

## Common .gitignore Patterns
```gitignore
# Dependencies
node_modules/
vendor/

# Build outputs
dist/
build/
*.exe
*.dll

# Logs
*.log
logs/

# Environment files
.env
.env.local
.env.production

# IDE files
.vscode/
.idea/
*.swp
*.swo

# OS files
.DS_Store
Thumbs.db

# Temporary files
*.tmp
*.temp
```

## Useful Shortcuts
```bash
# Stage and commit in one command
git commit -am "message"

# Show last commit
git show

# Show current branch
git branch --show-current

# Show remote URLs
git remote -v

# Show configuration
git config --list
```

## Command Aliases
Add these to your Git config for faster workflows:
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
```

## Tips & Best Practices

1. **Commit Often**: Make small, frequent commits
2. **Write Good Messages**: Be descriptive and consistent
3. **Use .gitignore**: Don't track generated files
4. **Check Before Committing**: Always run `git status` and `git diff`
5. **Stage Selectively**: Use `git add -p` for partial staging

## Common Patterns

### Daily Workflow
```bash
git status                        # Check what's changed
git add .                         # Stage changes
git commit -m "feat: add new feature"  # Commit
git push                          # Push to remote
```

### Checking Changes Before Commit
```bash
git status                        # See what's staged/unstaged
git diff                          # See unstaged changes
git diff --staged                 # See staged changes
git commit -m "message"           # Commit when ready
```

### Fixing Last Commit
```bash
# Add forgotten file to last commit
git add forgotten-file.txt
git commit --amend --no-edit

# Change last commit message
git commit --amend -m "Better message"
```

---

**Previous**: [← Getting Started](getting-started.md) | **Next**: [Branching →](branching.md)
