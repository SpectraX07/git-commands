# 🚨 Repository Corruption Recovery - Emergency Guide

Critical procedures for recovering from Git repository corruption and data loss scenarios.

## ⚠️ **EMERGENCY PROTOCOLS**

### 🆘 **STOP! Read This First**

**Before attempting any recovery:**
1. **DO NOT PANIC** - Git is designed to preserve data
2. **STOP all Git operations** immediately
3. **Make a backup** of the current state
4. **Document the problem** for analysis
5. **Follow procedures step by step**

---

## 🔥 **Scenario 1: Repository Corruption**

### **Symptoms**
```bash
fatal: loose object <hash> (stored in .git/objects/<xx>/<hash>) is corrupt
error: Could not read <hash>
fatal: bad object <hash>
```

### **Emergency Response**

#### **Step 1: Immediate Backup**
```bash
# Create emergency backup
cp -r .git .git.emergency-backup-$(date +%Y%m%d-%H%M%S)
cp -r . ../project-emergency-backup-$(date +%Y%m%d-%H%M%S)

echo "✅ Emergency backup created"
```

#### **Step 2: Assess Damage**
```bash
# Check repository integrity
git fsck --full --strict > fsck-report.txt 2>&1

# Check what's corrupted
git fsck --unreachable --dangling --no-reflogs > corruption-analysis.txt 2>&1

# Show the report
cat fsck-report.txt
```

#### **Step 3: Recovery Attempts**

**Method A: Automatic Recovery**
```bash
# Try automatic garbage collection repair
git gc --aggressive --prune=now

# Re-check integrity
git fsck --full
```

**Method B: Manual Object Recovery**
```bash
# Find missing objects
git fsck --lost-found

# Check if objects can be recovered from packfiles
git unpack-objects < .git/objects/pack/pack-*.pack

# Verify recovery
git fsck --full
```

**Method C: Remote Recovery**
```bash
# If you have a remote repository
git remote -v

# Fetch all data from remote
git fetch --all

# Reset to remote state (DESTRUCTIVE!)
git reset --hard origin/main

# Verify integrity
git fsck --full
```

#### **Step 4: Last Resort Recovery**
```bash
# Clone fresh copy from remote
cd ..
git clone <remote-url> project-recovered
cd project-recovered

# Copy any local changes from backup
cp -r ../project-emergency-backup/* . 2>/dev/null || true

# Check what needs to be recovered
git status
```

---

## 💥 **Scenario 2: Accidental Repository Deletion**

### **Symptoms**
- `.git` directory is missing or deleted
- `fatal: not a git repository` error
- All Git history appears lost

### **Emergency Response**

#### **Step 1: Check for Recovery Possibilities**
```bash
# Check if .git directory exists in trash/recycle bin
# Linux/macOS
ls -la ~/.local/share/Trash/files/ | grep -i git
find /tmp -name ".git" -type d 2>/dev/null

# Check for Git bundles or backups
find . -name "*.bundle" -o -name "*.git*" 2>/dev/null
```

#### **Step 2: IDE/Editor Recovery**
```bash
# Check IDE local history (VS Code)
ls -la .vscode/
find ~/.vscode -name "*$(basename $(pwd))*" 2>/dev/null

# Check for editor backups
find . -name "*~" -o -name ".#*" -o -name "#*#" 2>/dev/null
```

#### **Step 3: System-Level Recovery**
```bash
# Check system backups (Time Machine, etc.)
# Linux - check if filesystem supports recovery
debugfs /dev/sda1  # Replace with your device
# Use 'lsdel' command to list deleted inodes

# macOS - Time Machine
tmutil listbackups
```

#### **Step 4: Remote Repository Recovery**
```bash
# If remote exists, clone fresh copy
git clone <remote-url> .
git log --oneline -10

# If no remote, check for other clones
find /home -name ".git" -type d 2>/dev/null | grep -v "$(pwd)"
```

---

## 🔥 **Scenario 3: Massive History Rewrite Disaster**

### **Symptoms**
- Wrong rebase/filter-branch destroyed history
- Commits missing after interactive rebase
- Branch structure completely broken

### **Emergency Response**

#### **Step 1: Reflog Analysis**
```bash
# Check reflog for all references
git reflog --all > reflog-full.txt

# Find the commit before disaster
git reflog | head -20

# Look for the last good state
git log --oneline --graph --all --reflog
```

#### **Step 2: Recovery from Reflog**
```bash
# Find the commit hash before the disaster
# Look for entries like "HEAD@{5}: rebase -i (start)"

# Create recovery branch from good state
git checkout -b emergency-recovery HEAD@{10}  # Adjust number

# Verify this is the correct state
git log --oneline -10
git status
```

#### **Step 3: Reconstruct Branch Structure**
```bash
# If multiple branches were affected
git for-each-ref --format="%(refname:short) %(objectname)" refs/heads/ > branches-before.txt

# Recreate branches from reflog
git reflog show --all | grep "checkout: moving from" | head -20

# Manually recreate important branches
git checkout -b feature-branch <commit-hash>
git checkout -b develop <commit-hash>
```

#### **Step 4: Validate Recovery**
```bash
# Check that all important commits are present
git log --all --oneline | wc -l

# Verify file contents
ls -la
git status

# Check remote synchronization
git remote -v
git fetch --all
git log --oneline origin/main -10
```

---

## 🌊 **Scenario 4: Merge Disaster Recovery**

### **Symptoms**
- Merge created massive conflicts
- Wrong files were committed
- Project is in broken state after merge

### **Emergency Response**

#### **Step 1: Immediate Assessment**
```bash
# Check current state
git status
git log --oneline -5

# Identify the problematic merge
git log --merges --oneline -10
```

#### **Step 2: Undo Merge (If Recent)**
```bash
# If merge is the last commit
git reset --hard HEAD~1

# If merge is not the last commit, revert it
git revert -m 1 <merge-commit-hash>
```

#### **Step 3: Selective Recovery**
```bash
# If some files are correct, others are not
git checkout HEAD~1 -- path/to/correct/file
git checkout <other-branch> -- path/to/other/file

# Stage the corrections
git add .
git commit -m "emergency: fix merge disaster"
```

#### **Step 4: Complete Merge Redo**
```bash
# Reset to state before merge
git reset --hard <commit-before-merge>

# Redo merge with strategy
git merge -X ours <branch-name>    # Prefer our changes
# or
git merge -X theirs <branch-name>  # Prefer their changes

# Manual merge if needed
git merge --no-commit <branch-name>
# Resolve conflicts manually
git commit
```

---

## 🔐 **Scenario 5: Sensitive Data Exposure**

### **Symptoms**
- Passwords, API keys, or secrets committed
- Sensitive files accidentally added
- Data needs immediate removal from history

### **Emergency Response**

#### **Step 1: Immediate Damage Control**
```bash
# If not yet pushed, amend last commit
git rm --cached sensitive-file.txt
git commit --amend --no-edit

# If already pushed, immediate notification
echo "🚨 SECURITY BREACH - Rotate all exposed credentials immediately!"
```

#### **Step 2: Complete History Removal**
```bash
# Using BFG Repo-Cleaner (recommended)
java -jar bfg.jar --delete-files sensitive-file.txt
java -jar bfg.jar --replace-text passwords.txt  # File with old=new passwords

# Clean up
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

#### **Step 3: Alternative Manual Removal**
```bash
# Using git filter-branch (slower but always available)
git filter-branch --force --index-filter \
'git rm --cached --ignore-unmatch sensitive-file.txt' \
--prune-empty --tag-name-filter cat -- --all

# Force push to all remotes (DANGEROUS!)
git push --force-with-lease --all
git push --force-with-lease --tags
```

#### **Step 4: Security Checklist**
```bash
# 1. Rotate all exposed credentials immediately
# 2. Check access logs for unauthorized usage
# 3. Notify security team
# 4. Update .gitignore to prevent recurrence
echo "sensitive-file.txt" >> .gitignore
echo "*.key" >> .gitignore
echo ".env*" >> .gitignore

git add .gitignore
git commit -m "security: prevent sensitive file commits"
```

---

## 🏥 **Recovery Toolkit**

### **Essential Commands**
```bash
# Repository health check
git fsck --full --strict

# Find all references
git for-each-ref

# Show all commits (including unreachable)
git log --all --full-history --oneline

# Find lost commits
git fsck --lost-found
git reflog --all

# Emergency backup
cp -r .git .git.backup-$(date +%Y%m%d-%H%M%S)

# Clone from remote
git clone --mirror <remote-url> emergency-clone
```

### **Recovery Scripts**

#### **Quick Health Check**
```bash
#!/bin/bash
# save as check-repo-health.sh

echo "🏥 Repository Health Check"
echo "========================="

# Basic checks
git --version
echo "Repository: $(basename $(git rev-parse --show-toplevel))"
echo "Current branch: $(git branch --show-current)"

# Integrity check
echo -e "\n🔍 Integrity Check:"
if git fsck --quiet 2>/dev/null; then
    echo "✅ Repository integrity: OK"
else
    echo "❌ Repository integrity: ISSUES FOUND"
    git fsck 2>&1 | head -10
fi

# Object count
echo -e "\n📊 Repository Statistics:"
git count-objects -v

# Recent activity
echo -e "\n📈 Recent Activity:"
git log --oneline -5

echo -e "\n✅ Health check complete"
```

#### **Emergency Backup Script**
```bash
#!/bin/bash
# save as emergency-backup.sh

BACKUP_DIR="emergency-backups"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
REPO_NAME=$(basename $(git rev-parse --show-toplevel))

mkdir -p "$BACKUP_DIR"

echo "🚨 Creating emergency backup..."

# Full repository backup
cp -r . "$BACKUP_DIR/${REPO_NAME}-full-${TIMESTAMP}"

# Git-only backup
cp -r .git "$BACKUP_DIR/${REPO_NAME}-git-${TIMESTAMP}"

# Create bundle
git bundle create "$BACKUP_DIR/${REPO_NAME}-bundle-${TIMESTAMP}.bundle" --all

echo "✅ Emergency backup created in $BACKUP_DIR/"
ls -la "$BACKUP_DIR/"
```

---

## 📞 **Emergency Contacts & Resources**

### **When to Escalate**
- Repository corruption affects multiple developers
- Sensitive data exposure requires legal/compliance notification
- Data loss impacts production systems
- Recovery attempts are making situation worse

### **Documentation to Gather**
- Error messages and screenshots
- Output of `git fsck --full`
- Repository size and commit count
- Timeline of events leading to issue
- List of affected branches/commits

### **Prevention Measures**
```bash
# Set up automatic backups
git config --global alias.backup '!git bundle create backup-$(date +%Y%m%d).bundle --all'

# Enable rerere for conflict resolution reuse
git config --global rerere.enabled true

# Set up pre-commit hooks for sensitive data detection
# (Use templates from templates/hooks/)

# Regular integrity checks
git config --global alias.health 'fsck --full --strict'
```

---

## 🎯 **Recovery Success Checklist**

After any recovery operation:

- [ ] Repository integrity check passes (`git fsck --full`)
- [ ] All important branches are present
- [ ] Recent commits are accessible
- [ ] Working directory is clean
- [ ] Remote synchronization works
- [ ] Team members can clone/pull successfully
- [ ] CI/CD pipelines are functional
- [ ] Backup procedures are updated

---

**Remember**: Most Git "disasters" are recoverable. Stay calm, follow procedures, and don't hesitate to ask for help when needed.

**Next**: [Team Crisis Management →](team-crisis-management.md)
