# ↩️ Mastering Git Undo Operations - Complete Guide

This comprehensive exercise covers every way to undo changes in Git, from simple mistakes to complex history rewriting.

## 🎯 Learning Objectives

- Master different undo strategies for different situations
- Understand the difference between reset, revert, and checkout
- Learn safe vs. dangerous undo operations
- Practice recovery from common mistakes

## 📋 Prerequisites

- Basic Git knowledge
- Understanding of Git's three trees (working directory, staging area, repository)

## 🚀 Exercise Setup

```bash
mkdir undo-practice
cd undo-practice
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Create initial content
echo "# Project Setup
Version: 1.0.0
Status: Initial" > README.md

echo "function hello() {
    console.log('Hello World');
}" > app.js

git add .
git commit -m "feat: initial project setup"
```

## 🔄 Part 1: Undoing Working Directory Changes

### Scenario: Accidental File Modifications

**Step 1: Make Some Changes**
```bash
echo "# Project Setup
Version: 2.0.0
Status: In Development
Author: John Doe" > README.md

echo "function hello() {
    console.log('Hello World');
}

function goodbye() {
    console.log('Goodbye World');
}" > app.js

# Check what changed
git status
git diff
```

**Expected Output:**
```
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   README.md
        modified:   app.js
```

### Undo Strategies for Working Directory

**Strategy 1: Discard All Changes in a File**
```bash
# Restore README.md to last committed version
git checkout -- README.md
# or (modern Git 2.23+)
git restore README.md

# Verify the change was undone
cat README.md
```

**Strategy 2: Discard All Changes in All Files**
```bash
# Restore all modified files
git checkout -- .
# or
git restore .

# Verify all changes are gone
git status
```

**Strategy 3: Discard Specific Lines (Interactive)**
```bash
# Make changes again for demonstration
echo "# Project Setup
Version: 2.0.0
Status: In Development
Author: John Doe
Description: A sample project" > README.md

# Interactively choose what to discard
git checkout -p README.md
# Follow prompts to selectively discard changes
```

## 📦 Part 2: Undoing Staging Area Changes

### Scenario: Accidentally Staged Wrong Files

**Step 1: Create and Stage Changes**
```bash
echo "# Project Setup
Version: 2.0.0
Status: Ready for Production" > README.md

echo "SECRET_KEY=abc123
DATABASE_URL=localhost" > .env

echo "function hello() {
    console.log('Hello Production');
}" > app.js

# Stage everything (including sensitive .env file)
git add .
git status
```

### Unstaging Strategies

**Strategy 1: Unstage Specific Files**
```bash
# Unstage the sensitive file
git reset HEAD .env
# or (modern Git)
git restore --staged .env

# Verify it's unstaged
git status
```

**Strategy 2: Unstage All Files**
```bash
# Unstage everything
git reset HEAD
# or
git restore --staged .

# Verify nothing is staged
git status
```

**Strategy 3: Unstage and Discard Changes**
```bash
# Stage files again
git add README.md app.js

# Unstage and discard changes in one command
git reset --hard HEAD

# Verify everything is back to last commit
git status
```

## 📝 Part 3: Undoing Commits

### Setup: Create Commit History

```bash
# Create a series of commits to practice with
echo "# Project Setup
Version: 1.1.0
Status: Development" > README.md
git add README.md
git commit -m "feat: update to version 1.1.0"

echo "function greet(name) {
    console.log('Hello ' + name);
}" > app.js
git add app.js
git commit -m "feat: add personalized greeting"

echo "# Project Setup
Version: 1.2.0
Status: Testing" > README.md
git add README.md
git commit -m "feat: update to version 1.2.0"

# Add a bug
echo "function greet(name) {
    console.log('Hello ' + name);
}

function buggyFunction() {
    // This has a bug
    return undefined.property;
}" > app.js
git add app.js
git commit -m "feat: add new function with bug"

# View our history
git log --oneline
```

### Undo Strategy 1: Soft Reset (Keep Changes)

**Scenario: Want to undo commit but keep changes**
```bash
# Undo last commit, keep changes staged
git reset --soft HEAD~1

# Check status - changes are still staged
git status
git log --oneline

# You can now modify and recommit
echo "function greet(name) {
    console.log('Hello ' + name);
}

function workingFunction() {
    // Fixed the bug
    return 'Working correctly';
}" > app.js

git add app.js
git commit -m "feat: add working function (fixed bug)"
```

### Undo Strategy 2: Mixed Reset (Default)

**Scenario: Undo commit and unstage changes**
```bash
# Create another commit to undo
echo "Temporary file" > temp.txt
git add temp.txt
git commit -m "temp: add temporary file"

# Undo commit, unstage changes, but keep in working directory
git reset HEAD~1

# Check status - file exists but is unstaged
git status
ls -la

# Clean up
rm temp.txt
```

### Undo Strategy 3: Hard Reset (Dangerous!)

**Scenario: Completely remove commits and changes**
```bash
# Create commits to remove
echo "Bad change 1" >> README.md
git add README.md
git commit -m "bad: first bad commit"

echo "Bad change 2" >> README.md
git add README.md
git commit -m "bad: second bad commit"

# View history
git log --oneline

# DANGER: This will permanently delete commits and changes
git reset --hard HEAD~2

# Verify commits are gone
git log --oneline
cat README.md
```

### Undo Strategy 4: Revert (Safe for Shared History)

**Scenario: Undo commits that have been pushed/shared**
```bash
# Create a commit that needs to be undone
echo "function problematicFeature() {
    // This feature causes issues
    return 'problematic';
}" >> app.js
git add app.js
git commit -m "feat: add problematic feature"

# Create another commit on top
echo "# Project Setup
Version: 1.3.0
Status: Production" > README.md
git add README.md
git commit -m "feat: update to version 1.3.0"

# Safely undo the problematic commit (creates new commit)
git revert HEAD~1

# View history - original commit still exists, but is undone
git log --oneline
cat app.js
```

## 🔍 Part 4: Advanced Undo Scenarios

### Scenario 1: Undo Merge Commits

**Setup: Create a Merge to Undo**
```bash
# Create feature branch
git checkout -b feature/experimental
echo "Experimental feature" > experiment.txt
git add experiment.txt
git commit -m "feat: add experimental feature"

# Merge back to main
git checkout main
git merge feature/experimental --no-ff -m "Merge experimental feature"

# Realize the merge was a mistake
git log --oneline --graph
```

**Undo the Merge**
```bash
# Method 1: Reset (if not pushed yet)
git reset --hard HEAD~1

# Method 2: Revert merge (if already pushed)
# First, recreate the merge for demonstration
git merge feature/experimental --no-ff -m "Merge experimental feature"

# Revert the merge (note the -m 1 flag for merge commits)
git revert -m 1 HEAD

# View result
git log --oneline --graph
```

### Scenario 2: Undo Multiple Commits

**Setup: Create Multiple Commits to Undo**
```bash
echo "Change 1" >> changes.txt && git add changes.txt && git commit -m "change 1"
echo "Change 2" >> changes.txt && git add changes.txt && git commit -m "change 2"  
echo "Change 3" >> changes.txt && git add changes.txt && git commit -m "change 3"

git log --oneline
```

**Undo Multiple Commits**
```bash
# Method 1: Reset multiple commits
git reset --hard HEAD~3

# Method 2: Revert multiple commits (safer for shared history)
# First recreate the commits
echo "Change 1" >> changes.txt && git add changes.txt && git commit -m "change 1"
echo "Change 2" >> changes.txt && git add changes.txt && git commit -m "change 2"  
echo "Change 3" >> changes.txt && git add changes.txt && git commit -m "change 3"

# Revert in reverse order (newest first)
git revert HEAD HEAD~1 HEAD~2 --no-edit

git log --oneline
```

### Scenario 3: Undo File Deletion

**Setup: Accidentally Delete and Commit File**
```bash
# Create a file
echo "Important data" > important.txt
git add important.txt
git commit -m "feat: add important file"

# Accidentally delete it
rm important.txt
git add important.txt
git commit -m "fix: remove file (MISTAKE!)"

# Realize the mistake
ls -la  # File is gone
```

**Recover the Deleted File**
```bash
# Method 1: Revert the deletion commit
git revert HEAD

# Method 2: Checkout file from previous commit
git reset --hard HEAD~1  # Undo the deletion commit
# or
git checkout HEAD~1 -- important.txt  # Just restore the file

# Verify recovery
ls -la
cat important.txt
```

## 🚨 Part 5: Emergency Recovery Scenarios

### Scenario 1: Recover from Hard Reset

**Setup: Simulate Accidental Hard Reset**
```bash
# Create some commits
echo "Important work 1" > work.txt && git add work.txt && git commit -m "important work 1"
echo "Important work 2" >> work.txt && git add work.txt && git commit -m "important work 2"
echo "Important work 3" >> work.txt && git add work.txt && git commit -m "important work 3"

# Note the commit hash
git log --oneline

# Accidentally hard reset
git reset --hard HEAD~3

# Panic! All work seems lost
git log --oneline
```

**Recovery Using Reflog**
```bash
# Git keeps a log of all HEAD movements
git reflog

# Find the commit hash before the reset
# Look for something like "HEAD@{1}: commit: important work 3"

# Recover using the hash (replace with actual hash from reflog)
git reset --hard HEAD@{4}  # or use the actual commit hash

# Verify recovery
git log --oneline
cat work.txt
```

### Scenario 2: Recover Deleted Branch

**Setup: Accidentally Delete Branch**
```bash
# Create and work on a branch
git checkout -b feature/important-work
echo "Critical feature" > feature.txt
git add feature.txt
git commit -m "feat: add critical feature"

# Switch back to main
git checkout main

# Accidentally delete the branch
git branch -D feature/important-work

# Realize the mistake - branch is gone!
git branch -a
```

**Recovery Using Reflog**
```bash
# Find the commit hash from reflog
git reflog

# Look for the commit from the deleted branch
# Recreate the branch from that commit
git checkout -b feature/important-work-recovered <commit-hash>

# Or if you remember the commit hash
git checkout -b feature/important-work-recovered HEAD@{2}

# Verify recovery
git log --oneline
cat feature.txt
```

## 📊 Undo Strategy Decision Tree

### **Working Directory Changes**
```
Unsaved changes in files?
├─ Discard all changes → git restore . or git checkout -- .
├─ Discard specific file → git restore <file>
└─ Discard selectively → git restore -p <file>
```

### **Staging Area Changes**  
```
Accidentally staged files?
├─ Unstage all → git restore --staged . or git reset HEAD
├─ Unstage specific file → git restore --staged <file>
└─ Unstage and discard → git reset --hard HEAD
```

### **Committed Changes**
```
Need to undo commits?
├─ Not pushed yet?
│   ├─ Keep changes → git reset --soft HEAD~n
│   ├─ Unstage changes → git reset HEAD~n  
│   └─ Discard changes → git reset --hard HEAD~n
└─ Already pushed?
    ├─ Single commit → git revert HEAD
    ├─ Multiple commits → git revert HEAD~n..HEAD
    └─ Merge commit → git revert -m 1 HEAD
```

## 🛡️ Safety Guidelines

### **Safe Operations** (Reversible)
- `git revert` - Creates new commits to undo changes
- `git reset --soft` - Only moves HEAD, keeps changes
- `git restore` - Only affects working directory/staging

### **Dangerous Operations** (Permanent)
- `git reset --hard` - Permanently deletes commits and changes
- `git clean -f` - Permanently deletes untracked files
- `git branch -D` - Force deletes branches

### **Recovery Tools**
- `git reflog` - Shows history of HEAD movements
- `git fsck` - Finds dangling commits
- `git log --all --full-history` - Shows all commits

## 🎯 Best Practices

### **Prevention**
1. **Commit frequently** - Smaller commits are easier to undo
2. **Use branches** - Isolate experimental work
3. **Check before reset** - Always verify what you're undoing
4. **Backup important work** - Push to remote or create tags

### **Recovery**
1. **Don't panic** - Git rarely loses data permanently
2. **Check reflog first** - Most "lost" commits are in reflog
3. **Use revert for shared history** - Never rewrite pushed commits
4. **Test after recovery** - Ensure functionality is preserved

## 🔧 Useful Commands Summary

```bash
# Working Directory
git restore <file>              # Discard changes in file
git restore .                   # Discard all changes
git restore -p <file>           # Interactive discard

# Staging Area  
git restore --staged <file>     # Unstage file
git reset HEAD <file>           # Unstage file (older syntax)

# Commits
git reset --soft HEAD~1         # Undo commit, keep changes staged
git reset HEAD~1                # Undo commit, unstage changes
git reset --hard HEAD~1         # Undo commit, discard changes
git revert HEAD                 # Create new commit undoing last commit

# Recovery
git reflog                      # Show HEAD movement history
git checkout <commit-hash>      # Go to specific commit
git checkout -b <branch> <hash> # Create branch from commit

# Emergency
git fsck --lost-found          # Find dangling commits
git show <commit-hash>         # Examine specific commit
```

## 🚀 Next Steps

1. Practice each scenario multiple times
2. Try the [Advanced Git Operations](../advanced/) exercises  
3. Learn about [Interactive Rebase](../advanced/rebase-strategies.md)
4. Explore [Repository Recovery](../advanced/repository-recovery.md)

---

**Remember**: Git is designed to preserve data. Most "lost" work can be recovered with the right commands. When in doubt, check the reflog first!

**Next Exercise**: [Team Workflows →](team-workflows.md)
