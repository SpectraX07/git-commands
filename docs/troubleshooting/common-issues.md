# 🆘 Git Troubleshooting Guide - Common Issues & Solutions

Comprehensive solutions to the most common Git problems developers encounter.

## 🎯 Quick Problem Finder

**Jump to your issue:**
- [Authentication Problems](#-authentication-problems)
- [Merge Conflicts](#-merge-conflicts)  
- [Commit Issues](#-commit-issues)
- [Branch Problems](#-branch-problems)
- [Remote Repository Issues](#-remote-repository-issues)
- [File and Directory Issues](#-file-and-directory-issues)
- [History and Recovery](#-history-and-recovery)
- [Performance Issues](#-performance-issues)

---

## 🔐 Authentication Problems

### Issue: Permission Denied (SSH)

**Error Message:**
```
Permission denied (publickey).
fatal: Could not read from remote repository.
```

**Solutions:**

**Solution 1: Check SSH Key**
```bash
# Test SSH connection
ssh -T git@github.com

# Check if SSH key exists
ls -la ~/.ssh/

# Generate new SSH key if needed
ssh-keygen -t ed25519 -C "your.email@example.com"

# Add key to SSH agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy public key to clipboard (Linux)
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard

# Copy public key to clipboard (macOS)
cat ~/.ssh/id_ed25519.pub | pbcopy
```

**Solution 2: Fix SSH Key Permissions**
```bash
# Set correct permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
chmod 600 ~/.ssh/config
```

**Solution 3: Configure SSH Config**
```bash
# Create/edit SSH config
nano ~/.ssh/config

# Add configuration
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
```

### Issue: Authentication Failed (HTTPS)

**Error Message:**
```
fatal: Authentication failed for 'https://github.com/user/repo.git'
```

**Solutions:**

**Solution 1: Use Personal Access Token**
```bash
# Update remote URL with token
git remote set-url origin https://username:token@github.com/user/repo.git

# Or configure credential helper
git config --global credential.helper store
git push  # Enter username and token when prompted
```

**Solution 2: Configure Credential Helper**
```bash
# For Windows
git config --global credential.helper manager-core

# For macOS
git config --global credential.helper osxkeychain

# For Linux
git config --global credential.helper cache --timeout=3600
```

---

## ⚔️ Merge Conflicts

### Issue: Automatic Merge Failed

**Error Message:**
```
Auto-merging file.txt
CONFLICT (content): Merge conflict in file.txt
Automatic merge failed; fix conflicts and then commit the result.
```

**Solutions:**

**Solution 1: Manual Resolution**
```bash
# Check conflicted files
git status

# Open file and look for conflict markers
# <<<<<<< HEAD
# Your changes
# =======
# Their changes
# >>>>>>> branch-name

# Edit file to resolve conflicts, then:
git add resolved-file.txt
git commit -m "resolve: merge conflict in file.txt"
```

**Solution 2: Use Merge Tool**
```bash
# Configure merge tool
git config --global merge.tool vimdiff

# Launch merge tool
git mergetool

# After resolving conflicts
git commit -m "resolve: merge conflicts"
```

**Solution 3: Choose One Side**
```bash
# Keep your version
git checkout --ours conflicted-file.txt

# Keep their version
git checkout --theirs conflicted-file.txt

# Stage and commit
git add conflicted-file.txt
git commit -m "resolve: choose appropriate version"
```

**Solution 4: Abort Merge**
```bash
# If conflicts are too complex, abort and try different approach
git merge --abort

# Alternative: Use rebase instead of merge
git rebase main
```

### Issue: Merge Conflicts in Binary Files

**Error Message:**
```
warning: Cannot merge binary files: image.png (HEAD vs. feature-branch)
```

**Solution:**
```bash
# Choose which version to keep
git checkout --ours image.png    # Keep your version
git checkout --theirs image.png  # Keep their version

# Or manually replace with correct file
cp /path/to/correct/image.png image.png

git add image.png
git commit -m "resolve: use correct binary file"
```

---

## 📝 Commit Issues

### Issue: Empty Commit Message

**Error Message:**
```
Aborting commit due to empty commit message.
```

**Solutions:**

**Solution 1: Add Commit Message**
```bash
# Recommit with proper message
git commit -m "feat: add user authentication system"

# Or use editor for longer message
git commit
```

**Solution 2: Amend Last Commit**
```bash
# If you already committed but want to change message
git commit --amend -m "better commit message"
```

### Issue: Committed to Wrong Branch

**Error Message:**
*No error, but you realize you committed to the wrong branch*

**Solutions:**

**Solution 1: Move Commit to Correct Branch**
```bash
# If commit is the latest one
git reset --soft HEAD~1  # Undo commit, keep changes staged
git stash                # Stash the changes
git checkout correct-branch
git stash pop           # Apply changes to correct branch
git commit -m "correct commit message"
```

**Solution 2: Cherry-pick to Correct Branch**
```bash
# Note the commit hash
git log --oneline -1

# Switch to correct branch
git checkout correct-branch

# Cherry-pick the commit
git cherry-pick <commit-hash>

# Remove from wrong branch
git checkout wrong-branch
git reset --hard HEAD~1
```

### Issue: Accidentally Committed Sensitive Information

**Error Message:**
*No error, but you committed passwords, API keys, etc.*

**Solutions:**

**Solution 1: Remove from Last Commit (Not Pushed)**
```bash
# Remove file and amend commit
git rm --cached sensitive-file.txt
echo "sensitive-file.txt" >> .gitignore
git add .gitignore
git commit --amend -m "feat: add feature (remove sensitive data)"
```

**Solution 2: Remove from History (Dangerous)**
```bash
# Use BFG Repo-Cleaner (recommended)
java -jar bfg.jar --delete-files sensitive-file.txt
git reflog expire --expire=now --all && git gc --prune=now --aggressive

# Or use git filter-branch (more complex)
git filter-branch --force --index-filter \
'git rm --cached --ignore-unmatch sensitive-file.txt' \
--prune-empty --tag-name-filter cat -- --all
```

---

## 🌿 Branch Problems

### Issue: Branch Already Exists

**Error Message:**
```
fatal: A branch named 'feature-branch' already exists.
```

**Solutions:**

**Solution 1: Use Different Name**
```bash
git checkout -b feature-branch-v2
```

**Solution 2: Delete Existing Branch**
```bash
# Delete local branch (if safe to do so)
git branch -d feature-branch

# Force delete if needed
git branch -D feature-branch

# Then create new branch
git checkout -b feature-branch
```

**Solution 3: Switch to Existing Branch**
```bash
git checkout feature-branch
```

### Issue: Cannot Delete Branch Currently Checked Out

**Error Message:**
```
error: Cannot delete branch 'main' checked out at '/path/to/repo'
```

**Solution:**
```bash
# Switch to different branch first
git checkout develop
# or
git checkout -b temp-branch

# Then delete the branch
git branch -d main
```

### Issue: Detached HEAD State

**Error Message:**
```
You are in 'detached HEAD' state.
```

**Solutions:**

**Solution 1: Create Branch from Current State**
```bash
git checkout -b new-branch-name
```

**Solution 2: Return to Main Branch**
```bash
git checkout main
```

**Solution 3: Discard Changes and Return**
```bash
git checkout main
# Changes in detached HEAD will be lost
```

---

## 🌐 Remote Repository Issues

### Issue: Updates Were Rejected

**Error Message:**
```
! [rejected] main -> main (fetch first)
error: failed to push some refs to 'origin'
```

**Solutions:**

**Solution 1: Pull First, Then Push**
```bash
git pull origin main
git push origin main
```

**Solution 2: Pull with Rebase**
```bash
git pull --rebase origin main
git push origin main
```

**Solution 3: Force Push (Dangerous)**
```bash
# Only if you're sure and it's your private branch
git push --force-with-lease origin main
```

### Issue: Remote Branch Doesn't Exist

**Error Message:**
```
error: src refspec main does not match any
error: failed to push some refs to 'origin'
```

**Solutions:**

**Solution 1: Create Remote Branch**
```bash
# Push and set upstream
git push -u origin main
```

**Solution 2: Check Branch Name**
```bash
# Verify current branch name
git branch --show-current

# Push correct branch
git push -u origin <correct-branch-name>
```

### Issue: Refusing to Merge Unrelated Histories

**Error Message:**
```
fatal: refusing to merge unrelated histories
```

**Solution:**
```bash
# Allow unrelated histories (use with caution)
git pull origin main --allow-unrelated-histories
```

---

## 📁 File and Directory Issues

### Issue: File Not Found / Pathspec Did Not Match

**Error Message:**
```
fatal: pathspec 'filename.txt' did not match any files
```

**Solutions:**

**Solution 1: Check File Exists**
```bash
# List files in current directory
ls -la

# Check current directory
pwd

# Use correct file path
git add path/to/actual/file.txt
```

**Solution 2: Check File Status**
```bash
# See what files Git knows about
git ls-files

# See untracked files
git status
```

### Issue: Large File Rejected

**Error Message:**
```
remote: error: File large-file.zip is 150.00 MB; this exceeds GitHub's file size limit of 100.00 MB
```

**Solutions:**

**Solution 1: Remove Large File**
```bash
# Remove from staging
git reset HEAD large-file.zip

# Add to .gitignore
echo "large-file.zip" >> .gitignore
git add .gitignore
git commit -m "chore: ignore large files"
```

**Solution 2: Use Git LFS**
```bash
# Install Git LFS
git lfs install

# Track large files
git lfs track "*.zip"
git add .gitattributes

# Add and commit large file
git add large-file.zip
git commit -m "feat: add large file with LFS"
```

**Solution 3: Remove from History**
```bash
# Remove large file from all history
git filter-branch --force --index-filter \
'git rm --cached --ignore-unmatch large-file.zip' \
--prune-empty --tag-name-filter cat -- --all

# Force push to update remote
git push --force-with-lease --all
```

### Issue: Line Ending Problems

**Error Message:**
```
warning: LF will be replaced by CRLF in file.txt
```

**Solutions:**

**Solution 1: Configure Line Endings (Windows)**
```bash
git config --global core.autocrlf true
```

**Solution 2: Configure Line Endings (Mac/Linux)**
```bash
git config --global core.autocrlf input
```

**Solution 3: Disable Warning**
```bash
git config --global core.autocrlf false
```

**Solution 4: Use .gitattributes**
```bash
# Create .gitattributes file
echo "* text=auto" > .gitattributes
echo "*.txt text" >> .gitattributes
echo "*.jpg binary" >> .gitattributes
git add .gitattributes
git commit -m "chore: configure line endings"
```

---

## 🔄 History and Recovery

### Issue: Accidentally Deleted Commits

**Error Message:**
*No error, but commits are missing after reset/rebase*

**Solutions:**

**Solution 1: Use Reflog**
```bash
# Find lost commits
git reflog

# Recover from reflog
git reset --hard HEAD@{5}  # Adjust number based on reflog
```

**Solution 2: Find Dangling Commits**
```bash
# Find unreachable commits
git fsck --lost-found

# Show dangling commit
git show <commit-hash>

# Create branch from lost commit
git checkout -b recovered-branch <commit-hash>
```

### Issue: Accidentally Deleted Branch

**Error Message:**
*No error, but branch is gone*

**Solution:**
```bash
# Find branch in reflog
git reflog

# Look for branch creation/checkout entries
# Recreate branch from commit hash
git checkout -b recovered-branch <commit-hash>
```

### Issue: Wrong Commit Author

**Error Message:**
*No error, but commit has wrong author information*

**Solutions:**

**Solution 1: Fix Last Commit**
```bash
# Change author of last commit
git commit --amend --author="Correct Name <correct.email@example.com>"
```

**Solution 2: Fix Multiple Commits**
```bash
# Interactive rebase to fix multiple commits
git rebase -i HEAD~5

# For each commit to fix, change 'pick' to 'edit'
# When rebase stops at each commit:
git commit --amend --author="Correct Name <correct.email@example.com>"
git rebase --continue
```

---

## ⚡ Performance Issues

### Issue: Git Operations Are Slow

**Symptoms:**
- Slow git status, add, commit
- Large repository size
- Long clone times

**Solutions:**

**Solution 1: Repository Maintenance**
```bash
# Garbage collection
git gc --aggressive --prune=now

# Repack repository
git repack -ad

# Check repository size
git count-objects -vH
```

**Solution 2: Shallow Clone**
```bash
# Clone only recent history
git clone --depth 1 <repository-url>

# Convert to full repository later if needed
git fetch --unshallow
```

**Solution 3: Sparse Checkout**
```bash
# Only checkout specific directories
git config core.sparseCheckout true
echo "src/" > .git/info/sparse-checkout
git read-tree -m -u HEAD
```

### Issue: Large .git Directory

**Solution:**
```bash
# Find large objects
git rev-list --objects --all | \
git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
sed -n 's/^blob //p' | \
sort --numeric-sort --key=2 | \
tail -10

# Remove large files from history (use with caution)
git filter-branch --force --index-filter \
'git rm --cached --ignore-unmatch large-file.dat' \
--prune-empty --tag-name-filter cat -- --all
```

---

## 🛠️ Diagnostic Commands

### General Diagnostics

```bash
# Check Git version
git --version

# Check repository status
git status

# Check configuration
git config --list

# Check remote repositories
git remote -v

# Check repository integrity
git fsck --full

# Check object database
git count-objects -v
```

### Advanced Diagnostics

```bash
# Show all references
git show-ref

# Show reflog
git reflog --all

# Show unreachable objects
git fsck --unreachable

# Show repository statistics
git count-objects -vH

# Check for corruption
git fsck --strict --full
```

## 🚨 Emergency Recovery Procedures

### Complete Repository Recovery

```bash
# 1. Stop all Git operations
# 2. Backup current state
cp -r .git .git.backup

# 3. Try to recover from reflog
git reflog --all

# 4. If reflog is corrupted, try fsck
git fsck --full --strict

# 5. Recover from backup if available
# 6. Clone fresh copy if all else fails
```

### Data Recovery Checklist

1. **Don't Panic** - Git rarely loses data permanently
2. **Stop Making Changes** - Avoid making the situation worse
3. **Check Reflog** - Most "lost" commits are in reflog
4. **Use fsck** - Find dangling commits
5. **Check Backups** - Remote repositories, local backups
6. **Document the Issue** - For future prevention

---

## 📞 Getting Help

### Built-in Help

```bash
# General help
git help

# Command-specific help
git help commit
git help rebase

# Quick reference
git <command> --help
```

### Online Resources

- **Git Documentation**: https://git-scm.com/doc
- **Git Book**: https://git-scm.com/book
- **Stack Overflow**: Search for specific error messages
- **GitHub Community**: https://github.community/

### Community Support

- **Git Mailing List**: git@vger.kernel.org
- **IRC**: #git on Libera.Chat
- **Discord/Slack**: Various Git communities

---

**Remember**: Most Git problems have solutions, and Git is designed to preserve your data. When in doubt, make a backup and seek help before attempting risky operations.

**Related**: [Recovery Guide](recovery.md) | [Performance Optimization](../advanced/performance.md)
