# 🔄 Advanced Rebase Strategies

Comprehensive guide to Git rebase strategies for maintaining clean, professional commit histories.

## 🎯 Overview

Git rebase is one of the most powerful tools for maintaining clean project history. This guide covers advanced strategies for using rebase effectively in professional development environments.

## 📚 Rebase Fundamentals

### What is Rebase?

Rebase moves or combines a sequence of commits to a new base commit. Unlike merge, which creates a new commit that ties together two branches, rebase rewrites the project history by creating new commits for each commit in the original branch.

```
Before Rebase:
    A---B---C topic
   /
  D---E---F---G main

After Rebase:
              A'--B'--C' topic
             /
  D---E---F---G main
```

### Types of Rebase

1. **Simple Rebase**: `git rebase main`
2. **Interactive Rebase**: `git rebase -i HEAD~3`
3. **Onto Rebase**: `git rebase --onto main server client`

## 🛠️ Interactive Rebase Commands

### Core Commands

| Command | Action | Use Case |
|---------|--------|----------|
| `pick` | Use commit as-is | Keep commit unchanged |
| `reword` | Use commit but edit message | Fix commit message |
| `edit` | Use commit but stop for amending | Modify commit content |
| `squash` | Combine with previous commit | Merge related commits |
| `fixup` | Like squash but discard message | Clean up small fixes |
| `drop` | Remove commit entirely | Delete unwanted commits |
| `exec` | Run shell command | Run tests or checks |
| `break` | Stop rebase at this point | Manual intervention needed |

### Advanced Interactive Rebase

```bash
# Rebase with automatic fixup commits
git commit --fixup <commit-hash>
git rebase -i --autosquash HEAD~5

# Rebase with automatic execution
git rebase -i HEAD~3 --exec "npm test"

# Rebase from repository root
git rebase -i --root
```

## 🎯 Rebase Strategies by Scenario

### Strategy 1: Feature Branch Cleanup

**Scenario**: Clean up messy feature branch before merging

```bash
# Before: Messy feature branch
* feat: add user authentication
* fix: typo in auth function  
* wip: working on auth
* fix: another typo
* feat: complete auth implementation

# Interactive rebase to clean up
git rebase -i main

# After: Clean feature branch
* feat: implement user authentication system
```

**Rebase Plan**:
```
pick feat: add user authentication
fixup fix: typo in auth function
squash wip: working on auth
fixup fix: another typo
squash feat: complete auth implementation
```

### Strategy 2: Splitting Large Commits

**Scenario**: Break down a large commit into focused pieces

```bash
# Large commit to split
git rebase -i HEAD~1

# In interactive mode, mark commit as 'edit'
edit abc1234 feat: add user system with auth and profiles

# When rebase stops, reset the commit
git reset HEAD~1

# Stage and commit pieces separately
git add auth.js
git commit -m "feat: add user authentication system"

git add profile.js  
git commit -m "feat: add user profile management"

git add validation.js
git commit -m "feat: add input validation utilities"

# Continue rebase
git rebase --continue
```

### Strategy 3: Reordering Commits

**Scenario**: Commits were made in wrong logical order

```bash
# Wrong order
* test: add tests for feature X
* feat: implement feature X  
* docs: add documentation for feature X

# Reorder during interactive rebase
pick feat: implement feature X
pick docs: add documentation for feature X
pick test: add tests for feature X
```

### Strategy 4: Updating Feature Branch

**Scenario**: Keep feature branch up-to-date with main

```bash
# Option 1: Simple rebase (linear history)
git checkout feature-branch
git rebase main

# Option 2: Rebase with merge conflicts strategy
git rebase -X ours main        # Prefer our changes
git rebase -X theirs main      # Prefer their changes

# Option 3: Interactive rebase for cleanup during update
git rebase -i main
```

## 🔀 Advanced Rebase Techniques

### Technique 1: Onto Rebase

Move commits from one branch to another:

```bash
# Move commits from server branch to main, starting from client
git rebase --onto main server client

# Before:
#     A---B---C client
#    /
#   D---E server
#  /
# F---G---H main

# After:
#         A'--B'--C' client
#        /
# F---G---H main
#        \
#         D---E server
```

### Technique 2: Preserving Merges

```bash
# Rebase while preserving merge commits
git rebase --preserve-merges main

# Modern alternative (Git 2.18+)
git rebase --rebase-merges main
```

### Technique 3: Rebase with Exec

```bash
# Run tests after each commit during rebase
git rebase -i HEAD~5 --exec "npm test"

# Run multiple commands
git rebase -i HEAD~3 --exec "npm test && npm run lint"

# Stop on test failure
git rebase -i HEAD~3 --exec "npm test || exit 1"
```

## ⚔️ Conflict Resolution Strategies

### Strategy 1: Preventive Measures

```bash
# Configure merge tool
git config merge.tool vimdiff

# Set up rerere (reuse recorded resolution)
git config rerere.enabled true

# Use patience diff algorithm
git config diff.algorithm patience
```

### Strategy 2: During Conflicts

```bash
# View conflict status
git status
git diff

# Choose resolution strategy
git checkout --ours <file>      # Keep our version
git checkout --theirs <file>    # Keep their version

# Manual resolution, then continue
git add <resolved-files>
git rebase --continue

# Skip problematic commit
git rebase --skip

# Abort if needed
git rebase --abort
```

### Strategy 3: Complex Conflict Resolution

```bash
# Use three-way merge view
git config merge.conflictstyle diff3

# View original, ours, and theirs
git show :1:filename    # Original (base)
git show :2:filename    # Ours (HEAD)
git show :3:filename    # Theirs (branch being rebased)

# Use merge tool for complex conflicts
git mergetool
```

## 🛡️ Safety and Recovery

### Safety Measures

```bash
# Create backup branch before risky rebase
git branch backup-feature-branch

# Use --force-with-lease for safer force push
git push --force-with-lease origin feature-branch

# Check what will be rebased
git log --oneline main..feature-branch
```

### Recovery Techniques

```bash
# Find lost commits in reflog
git reflog
git log --walk-reflogs

# Recover from reflog
git reset --hard HEAD@{5}

# Find dangling commits
git fsck --lost-found

# Create branch from lost commit
git branch recovered-branch <commit-hash>
```

## 📊 Rebase vs Merge Decision Matrix

### Use Rebase When:

- ✅ Working on private feature branches
- ✅ Want linear, clean history
- ✅ Preparing for code review
- ✅ Commits haven't been shared
- ✅ Integrating upstream changes

### Use Merge When:

- ✅ Working on shared/public branches
- ✅ Want to preserve branching context
- ✅ Commits are already pushed
- ✅ Multiple developers on same branch
- ✅ Merge commits add valuable information

### Decision Tree

```
Is the branch shared with others?
├─ Yes → Use Merge
└─ No → Do you want linear history?
    ├─ Yes → Use Rebase
    └─ No → Use Merge
```

## 🎯 Team Rebase Policies

### Policy 1: Feature Branch Rebase

```bash
# Team rule: Always rebase feature branches before merging
git checkout feature-branch
git rebase main
git push --force-with-lease origin feature-branch
# Create pull request
```

### Policy 2: Squash Before Merge

```bash
# Team rule: Squash feature commits into single commit
git rebase -i main
# Squash all commits into one meaningful commit
git push --force-with-lease origin feature-branch
```

### Policy 3: No Rebase on Shared Branches

```bash
# Team rule: Never rebase main, develop, or release branches
# Only rebase private feature branches
```

## 🔧 Automation and Tooling

### Git Aliases for Rebase

```bash
# Useful rebase aliases
git config --global alias.rb rebase
git config --global alias.rbi "rebase -i"
git config --global alias.rbc "rebase --continue"
git config --global alias.rba "rebase --abort"
git config --global alias.rbs "rebase --skip"

# Advanced aliases
git config --global alias.fixup "commit --fixup"
git config --global alias.squash-all "!git rebase -i $(git merge-base HEAD main)"
```

### Pre-rebase Hooks

```bash
# .git/hooks/pre-rebase
#!/bin/sh
# Prevent rebasing main branch
if [ "$1" = "main" ]; then
    echo "Cannot rebase main branch"
    exit 1
fi

# Warn about rebasing shared branches
current_branch=$(git symbolic-ref --short HEAD)
if git branch -r --merged | grep -q "origin/$current_branch"; then
    echo "Warning: This branch exists on remote. Are you sure? (y/n)"
    read -r response
    if [ "$response" != "y" ]; then
        exit 1
    fi
fi
```

## 📈 Measuring Rebase Impact

### History Analysis

```bash
# Compare commit count before/after rebase
git rev-list --count HEAD

# Check for duplicate commits
git log --oneline | sort | uniq -d

# Verify no content lost
git diff HEAD@{1} HEAD  # Should be empty if only history changed
```

### Performance Impact

```bash
# Check repository size impact
git count-objects -v

# Analyze commit graph complexity
git log --graph --oneline --all

# Check for broken references
git fsck --full
```

## 🚀 Advanced Workflows

### Workflow 1: Continuous Rebase

```bash
# Daily workflow: Keep feature branch updated
git checkout feature-branch
git fetch origin
git rebase origin/main
git push --force-with-lease origin feature-branch
```

### Workflow 2: Stack of Branches

```bash
# Managing dependent feature branches
git checkout main
git checkout -b feature-a
# ... work on feature A ...
git checkout -b feature-b
# ... work on feature B (depends on A) ...

# Rebase stack when main updates
git checkout feature-a
git rebase main
git checkout feature-b
git rebase feature-a
```

### Workflow 3: Release Preparation

```bash
# Clean up release branch before tagging
git checkout release/v2.0
git rebase -i v1.9  # Interactive rebase since last release
# Clean up commits, fix messages, remove debug commits
git tag v2.0.0
```

## 🎓 Best Practices Summary

### Do's
- ✅ Always backup important branches before rebasing
- ✅ Use interactive rebase to clean up commit history
- ✅ Rebase private branches to stay updated
- ✅ Write clear, descriptive commit messages
- ✅ Test after each rebase operation
- ✅ Use `--force-with-lease` instead of `--force`

### Don'ts
- ❌ Never rebase commits that have been pushed to shared repositories
- ❌ Don't rebase without understanding the consequences
- ❌ Avoid rebasing merge commits (use `--preserve-merges` if needed)
- ❌ Don't rebase if you're unsure about the history
- ❌ Never rebase main/master branches in team environments

### Emergency Procedures
1. **Stop and assess** if rebase goes wrong
2. **Use `git rebase --abort`** to cancel problematic rebase
3. **Check reflog** for recovery options
4. **Create recovery branch** from reflog if needed
5. **Communicate with team** about any shared history changes

---

**Remember**: Rebase is a powerful tool for maintaining clean history, but it should be used thoughtfully and with respect for team collaboration practices.

**Related**: [Interactive Rebase Exercise](../../examples/advanced/rebase-mastery.md) | [Merge Strategies](merge-strategies.md)
