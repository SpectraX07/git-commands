# 📋 Git Commands Cheat Sheet

## 🚀 Quick Reference

### Repository Setup
```bash
git init                          # Initialize repository
git clone <url>                   # Clone repository
git remote add origin <url>       # Add remote
git remote -v                     # Show remotes
```

### Basic Workflow
```bash
git status                        # Check status
git add <file>                    # Stage file
git add .                         # Stage all files
git commit -m "message"           # Commit changes
git push                          # Push to remote
git pull                          # Pull from remote
```

### Branching
```bash
git branch                        # List branches
git branch <name>                 # Create branch
git checkout <branch>             # Switch branch
git checkout -b <name>            # Create & switch
git merge <branch>                # Merge branch
git branch -d <name>              # Delete branch
```

### Viewing History
```bash
git log                           # Show history
git log --oneline                 # Compact history
git log --graph                   # Visual history
git show <commit>                 # Show commit
git diff                          # Show changes
```

### Undoing Changes
```bash
git checkout -- <file>            # Discard changes
git reset <file>                  # Unstage file
git reset --hard HEAD             # Reset to last commit
git revert <commit>               # Revert commit
```

### Stashing
```bash
git stash                         # Stash changes
git stash pop                     # Apply stash
git stash list                    # List stashes
git stash drop                    # Delete stash
```

---

## 🔧 Advanced Commands

### Interactive Operations
```bash
git add -p                        # Interactive staging
git rebase -i <commit>            # Interactive rebase
git commit --amend                # Amend last commit
```

### Branch Management
```bash
git branch -r                     # Remote branches
git branch -a                     # All branches
git branch --merged               # Merged branches
git branch --no-merged            # Unmerged branches
```

### Remote Operations
```bash
git fetch                         # Fetch changes
git fetch --all                   # Fetch all remotes
git push -u origin <branch>       # Push & set upstream
git push --force-with-lease       # Safe force push
```

### Searching & Finding
```bash
git grep "pattern"                # Search in files
git log --grep="pattern"          # Search commits
git log -S "code"                 # Search code changes
git blame <file>                  # Show file history
```

---

## 🎯 Conventional Commits

### Format
```
type(scope): description

[optional body]

[optional footer]
```

### Types
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `style:` Formatting
- `refactor:` Code restructuring
- `test:` Tests
- `chore:` Maintenance

### Examples
```bash
feat: add user authentication
fix(api): resolve CORS issue
docs(readme): update installation
style: format with prettier
refactor(auth): extract helpers
test: add unit tests
chore: update dependencies
```

---

## 🚨 Emergency Commands

### Undo Last Commit (Keep Changes)
```bash
git reset --soft HEAD~1
```

### Undo Last Commit (Discard Changes)
```bash
git reset --hard HEAD~1
```

### Recover Deleted Branch
```bash
git reflog                        # Find commit hash
git checkout -b <branch> <hash>   # Recreate branch
```

### Fix Wrong Branch Commit
```bash
git reset --soft HEAD~1           # Undo commit
git stash                         # Stash changes
git checkout <correct-branch>     # Switch branch
git stash pop                     # Apply changes
git commit -m "message"           # Commit correctly
```

### Abort Merge
```bash
git merge --abort
```

### Abort Rebase
```bash
git rebase --abort
```

---

## 🔍 Inspection Commands

### File Status
```bash
git status -s                     # Short status
git diff --staged                 # Staged changes
git diff HEAD                     # All changes
git diff <branch1> <branch2>      # Compare branches
```

### Commit Information
```bash
git show HEAD                     # Last commit
git show HEAD~2                   # 2 commits ago
git show <commit>:<file>          # File at commit
```

### Branch Information
```bash
git branch -v                     # Branches with commits
git log <branch1>..<branch2>      # Commits between branches
git merge-base <branch1> <branch2> # Common ancestor
```

---

## ⚙️ Configuration

### User Setup
```bash
git config --global user.name "Name"
git config --global user.email "email"
git config --global init.defaultBranch main
```

### Useful Aliases
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.lg "log --oneline --graph"
```

### Editor Setup
```bash
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "vim"          # Vim
```

---

## 📊 Log Formatting

### Pretty Formats
```bash
git log --oneline                 # Hash + message
git log --stat                    # With file stats
git log --graph                   # With graph
git log --all                     # All branches
```

### Custom Format
```bash
git log --pretty=format:"%h - %an, %ar : %s"
# %h = short hash
# %an = author name
# %ar = author date (relative)
# %s = subject
```

### Date Filtering
```bash
git log --since="2 weeks ago"
git log --until="2023-12-31"
git log --since="2023-01-01" --until="2023-12-31"
```

---

## 🏷️ Tagging

### Create Tags
```bash
git tag v1.0.0                    # Lightweight tag
git tag -a v1.0.0 -m "Release"    # Annotated tag
git tag -a v1.0.0 <commit>        # Tag specific commit
```

### Manage Tags
```bash
git tag                           # List tags
git show v1.0.0                   # Show tag info
git push origin v1.0.0            # Push tag
git push --tags                   # Push all tags
git tag -d v1.0.0                 # Delete local tag
git push origin --delete v1.0.0   # Delete remote tag
```

---

## 🔄 Workflows

### Feature Branch Workflow
```bash
git checkout main
git pull origin main
git checkout -b feature/new-feature
# ... work on feature ...
git add .
git commit -m "feat: add new feature"
git push -u origin feature/new-feature
# ... create pull request ...
git checkout main
git pull origin main
git branch -d feature/new-feature
```

### Hotfix Workflow
```bash
git checkout main
git checkout -b hotfix/critical-fix
# ... fix the issue ...
git add .
git commit -m "fix: resolve critical issue"
git checkout main
git merge hotfix/critical-fix
git push origin main
git branch -d hotfix/critical-fix
```

---

## 💡 Pro Tips

1. **Use `.gitignore`** early and often
2. **Commit frequently** with small changes
3. **Write descriptive** commit messages
4. **Use branches** for all features
5. **Pull before pushing** to avoid conflicts
6. **Review changes** with `git diff --staged`
7. **Use `--force-with-lease`** instead of `--force`
8. **Keep history clean** with interactive rebase

---

## 🆘 Common Issues

### Merge Conflicts
```bash
git status                        # See conflicted files
# Edit files, remove <<<< ==== >>>> markers
git add .                         # Stage resolved files
git commit                        # Complete merge
```

### Detached HEAD
```bash
git checkout -b new-branch        # Create branch from current state
# or
git checkout main                 # Return to main branch
```

### Authentication Issues
```bash
# SSH key setup
ssh-keygen -t ed25519 -C "email@example.com"
ssh-add ~/.ssh/id_ed25519
# Add public key to GitHub/GitLab

# Or use personal access token
git remote set-url origin https://username:token@github.com/user/repo.git
```

---

*Keep this cheat sheet handy for quick reference! 🚀*
