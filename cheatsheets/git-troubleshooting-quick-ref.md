# 🆘 Git Troubleshooting Quick Reference

Fast solutions to common Git problems. Keep this handy for emergency situations!

## 🚨 Emergency Commands

### Undo Last Commit (Keep Changes)
```bash
git reset --soft HEAD~1
```

### Undo Last Commit (Discard Changes)
```bash
git reset --hard HEAD~1
```

### Abort Current Merge
```bash
git merge --abort
```

### Abort Current Rebase
```bash
git rebase --abort
```

### Recover "Lost" Commits
```bash
git reflog
git checkout <commit-hash>
git checkout -b recovery-branch
```

---

## 🔐 Authentication Issues

| Problem | Quick Fix |
|---------|-----------|
| **Permission denied (SSH)** | `ssh-add ~/.ssh/id_ed25519` |
| **Authentication failed (HTTPS)** | Use personal access token instead of password |
| **SSH key not found** | `ssh-keygen -t ed25519 -C "email@example.com"` |

### SSH Quick Setup
```bash
# Generate key
ssh-keygen -t ed25519 -C "your.email@example.com"

# Add to agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy public key
cat ~/.ssh/id_ed25519.pub
# Add to GitHub/GitLab SSH keys
```

---

## ⚔️ Merge Conflicts

### Quick Resolution
```bash
# See conflicted files
git status

# Choose your version
git checkout --ours <file>

# Choose their version  
git checkout --theirs <file>

# After manual resolution
git add <file>
git commit
```

### Conflict Markers
```
<<<<<<< HEAD
Your changes
=======
Their changes
>>>>>>> branch-name
```

---

## 🌿 Branch Problems

| Problem | Solution |
|---------|----------|
| **Branch already exists** | `git checkout existing-branch` or `git branch -D existing-branch` |
| **Can't delete current branch** | `git checkout main` then `git branch -d branch-name` |
| **Detached HEAD** | `git checkout -b new-branch` or `git checkout main` |

### Branch Quick Commands
```bash
# Create and switch
git checkout -b new-branch

# Delete local branch
git branch -d branch-name

# Delete remote branch
git push origin --delete branch-name

# Rename current branch
git branch -m new-name
```

---

## 📝 Commit Issues

| Problem | Quick Fix |
|---------|-----------|
| **Wrong commit message** | `git commit --amend -m "correct message"` |
| **Committed to wrong branch** | See "Move Commit" section below |
| **Forgot to add file** | `git add file && git commit --amend --no-edit` |

### Move Commit to Different Branch
```bash
# Method 1: Recent commit
git reset --soft HEAD~1
git stash
git checkout correct-branch
git stash pop
git commit

# Method 2: Any commit
git checkout correct-branch
git cherry-pick <commit-hash>
git checkout wrong-branch
git reset --hard HEAD~1
```

---

## 🌐 Remote Issues

| Error Message | Solution |
|---------------|----------|
| **Updates were rejected** | `git pull` then `git push` |
| **Non-fast-forward** | `git pull --rebase` or `git push --force-with-lease` |
| **Remote branch doesn't exist** | `git push -u origin branch-name` |

### Remote Quick Commands
```bash
# Add remote
git remote add origin <url>

# Change remote URL
git remote set-url origin <new-url>

# Push new branch
git push -u origin branch-name

# Force push (dangerous!)
git push --force-with-lease
```

---

## 📁 File Issues

| Problem | Solution |
|---------|----------|
| **File not found** | Check path: `git ls-files` |
| **Large file rejected** | Use Git LFS: `git lfs track "*.zip"` |
| **Accidentally committed sensitive data** | See "Remove Sensitive Data" below |

### Remove Sensitive Data
```bash
# From last commit (not pushed)
git rm --cached sensitive-file
git commit --amend

# From history (dangerous!)
git filter-branch --force --index-filter \
'git rm --cached --ignore-unmatch sensitive-file' \
--prune-empty --tag-name-filter cat -- --all
```

---

## 🔄 History Problems

### Recover Deleted Branch
```bash
git reflog
git checkout -b recovered-branch <commit-hash>
```

### Fix Wrong Author
```bash
# Last commit
git commit --amend --author="Name <email@example.com>"

# Multiple commits
git rebase -i HEAD~3
# Change 'pick' to 'edit' for each commit to fix
# At each stop:
git commit --amend --author="Name <email@example.com>"
git rebase --continue
```

---

## 🐛 Common Error Messages

### "fatal: not a git repository"
```bash
# Initialize repository
git init

# Or navigate to correct directory
cd /path/to/git/repo
```

### "Please tell me who you are"
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### "Your branch is ahead of 'origin/main'"
```bash
# Push your commits
git push

# Or reset to remote state
git reset --hard origin/main
```

### "refusing to merge unrelated histories"
```bash
git pull --allow-unrelated-histories
```

---

## 🔍 Diagnostic Commands

### Check Repository State
```bash
git status                    # Current state
git log --oneline -5          # Recent commits
git branch -a                 # All branches
git remote -v                 # Remote repositories
```

### Find Problems
```bash
git fsck                      # Check integrity
git reflog                    # Show all actions
git diff HEAD~1               # Compare with previous commit
git show <commit-hash>        # Examine specific commit
```

---

## 🚑 Emergency Recovery

### Repository Corruption
```bash
# 1. Don't panic!
# 2. Make backup
cp -r .git .git.backup

# 3. Try to recover
git fsck --full
git reflog --all

# 4. If all else fails
git clone <remote-url> recovered-repo
```

### Lost Work Recovery
```bash
# Check reflog first
git reflog

# Find lost commits
git fsck --lost-found

# Recover from dangling commit
git show <commit-hash>
git checkout -b recovery <commit-hash>
```

---

## 📞 Getting Help

### Built-in Help
```bash
git help <command>            # Detailed help
git <command> --help          # Same as above
git <command> -h              # Quick options
```

### Useful Resources
- **Stack Overflow**: Search error message
- **Git Documentation**: https://git-scm.com/doc
- **Interactive Tutorial**: https://learngitbranching.js.org/

---

## 🎯 Prevention Tips

### Daily Habits
- ✅ `git status` before any operation
- ✅ `git pull` before starting work
- ✅ Small, frequent commits
- ✅ Descriptive commit messages
- ✅ Test before pushing

### Safety Measures
- ✅ Use `--force-with-lease` instead of `--force`
- ✅ Create backup branches before risky operations
- ✅ Set up Git aliases for common operations
- ✅ Configure Git hooks for quality checks

---

## 🔧 Essential Aliases

Add these to your Git config for faster troubleshooting:

```bash
git config --global alias.undo 'reset --soft HEAD~1'
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
git config --global alias.pushf 'push --force-with-lease'
git config --global alias.amend 'commit --amend --no-edit'
git config --global alias.wip 'commit -am "WIP: work in progress"'
git config --global alias.cleanup 'branch --merged | grep -v "\*\|main\|develop" | xargs -n 1 git branch -d'
```

---

**Remember**: Most Git problems have solutions. When in doubt, check `git reflog` first - it's your safety net!

**Keep Calm and Git On!** 🚀
