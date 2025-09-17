# 🎯 Your First Repository - Step by Step

This hands-on example will walk you through creating your first Git repository from scratch.

## Scenario
You're starting a new project called "my-website" and want to track it with Git.

## Step 1: Create Project Directory
```bash
mkdir my-website
cd my-website
```

## Step 2: Initialize Git Repository
```bash
git init
```
**Expected Output:**
```
Initialized empty Git repository in /path/to/my-website/.git/
```

## Step 3: Check Repository Status
```bash
git status
```
**Expected Output:**
```
On branch main

No commits yet

nothing to commit (create/copy files and use "git add" to track)
```

## Step 4: Create Your First File
```bash
echo "# My Awesome Website" > README.md
echo "<!DOCTYPE html>
<html>
<head>
    <title>My Website</title>
</head>
<body>
    <h1>Welcome to My Website</h1>
    <p>This is my first website tracked with Git!</p>
</body>
</html>" > index.html
```

## Step 5: Check Status Again
```bash
git status
```
**Expected Output:**
```
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        README.md
        index.html

nothing added to commit but untracked files present (use "git add" to track)
```

## Step 6: Stage Files
```bash
git add README.md
git add index.html
```
**Or add all files at once:**
```bash
git add .
```

## Step 7: Check Status After Staging
```bash
git status
```
**Expected Output:**
```
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   README.md
        new file:   index.html
```

## Step 8: Make Your First Commit
```bash
git commit -m "Initial commit: Add README and basic HTML page"
```
**Expected Output:**
```
[main (root-commit) abc1234] Initial commit: Add README and basic HTML page
 2 files changed, 12 insertions(+)
 create mode 100644 README.md
 create mode 100644 index.html
```

## Step 9: View Your Commit History
```bash
git log
```
**Expected Output:**
```
commit abc1234567890abcdef1234567890abcdef123456
Author: Your Name <your.email@example.com>
Date:   Wed Sep 17 10:30:00 2025 +0000

    Initial commit: Add README and basic HTML page
```

## Step 10: Make Some Changes
```bash
echo "
## Features
- Responsive design
- Modern HTML5
- Git version control" >> README.md
```

## Step 11: See What Changed
```bash
git status
```
**Expected Output:**
```
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   README.md

no changes added to commit (use "git add" or "git commit -a")
```

```bash
git diff
```
**Expected Output:**
```
diff --git a/README.md b/README.md
index 1234567..abcdefg 100644
--- a/README.md
+++ b/README.md
@@ -1 +1,5 @@
 # My Awesome Website
+
+## Features
+- Responsive design
+- Modern HTML5
+- Git version control
```

## Step 12: Stage and Commit Changes
```bash
git add README.md
git commit -m "docs: add features section to README"
```

## Step 13: View Complete History
```bash
git log --oneline
```
**Expected Output:**
```
def5678 docs: add features section to README
abc1234 Initial commit: Add README and basic HTML page
```

## Step 14: Create a .gitignore File
```bash
echo "# Ignore temporary files
*.tmp
*.log

# Ignore OS files
.DS_Store
Thumbs.db

# Ignore IDE files
.vscode/
.idea/" > .gitignore
```

## Step 15: Add and Commit .gitignore
```bash
git add .gitignore
git commit -m "chore: add .gitignore file"
```

## Final Repository State
```bash
git log --oneline --graph
```
**Expected Output:**
```
* ghi9012 chore: add .gitignore file
* def5678 docs: add features section to README
* abc1234 Initial commit: Add README and basic HTML page
```

## What You've Learned

✅ **Repository Initialization**: `git init`
✅ **File Staging**: `git add`
✅ **Committing Changes**: `git commit`
✅ **Checking Status**: `git status`
✅ **Viewing Changes**: `git diff`
✅ **Viewing History**: `git log`
✅ **Ignoring Files**: `.gitignore`

## Next Steps

1. Try the [Branching Exercise](branching-exercise.md)
2. Learn about [Remote Repositories](remote-setup.md)
3. Practice [Undoing Changes](../intermediate/undoing-changes.md)

## Quick Reference Commands Used

| Command | Purpose |
|---------|---------|
| `git init` | Initialize repository |
| `git status` | Check repository status |
| `git add <file>` | Stage file for commit |
| `git add .` | Stage all files |
| `git commit -m "message"` | Commit with message |
| `git log` | View commit history |
| `git log --oneline` | Compact history view |
| `git diff` | See unstaged changes |

---

**Next Exercise**: [Branching Exercise →](branching-exercise.md)
