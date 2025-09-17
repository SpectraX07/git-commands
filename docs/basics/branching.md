# 🌿 Branching & Merging

## Understanding Branches

Branches allow you to diverge from the main line of development and work on features in isolation. Think of them as parallel universes of your code.

```
main     A---B---C---F---G
              \         /
feature        D---E---/
```

## Branch Operations

### Creating Branches
```bash
git branch <name>                 # Create new branch
git branch <name> <start-point>   # Create branch from specific commit
git checkout -b <name>            # Create and switch to new branch
git switch -c <name>              # Modern way (Git 2.23+)
```

### Switching Branches
```bash
git checkout <branch>             # Switch to branch
git switch <branch>               # Modern way (Git 2.23+)
git checkout -                    # Switch to previous branch
git switch -                      # Modern way to switch to previous
```

### Listing Branches
```bash
git branch                        # List local branches
git branch -r                     # List remote branches
git branch -a                     # List all branches
git branch -v                     # List with last commit info
git branch --merged               # List merged branches
git branch --no-merged            # List unmerged branches
```

### Deleting Branches
```bash
git branch -d <name>              # Delete branch (safe)
git branch -D <name>              # Force delete branch
git push origin --delete <branch> # Delete remote branch
```

### Renaming Branches
```bash
git branch -m <old-name> <new-name>  # Rename branch
git branch -m <new-name>             # Rename current branch
```

## Merging

### Basic Merging
```bash
git checkout main                 # Switch to target branch
git merge <feature-branch>        # Merge feature branch
```

### Merge Types

#### Fast-Forward Merge
When target branch hasn't diverged:
```bash
git merge feature                 # Fast-forward merge
```

#### No Fast-Forward Merge
Always create a merge commit:
```bash
git merge --no-ff feature         # Create merge commit
```

#### Squash Merge
Combine all commits into one:
```bash
git merge --squash feature        # Squash all commits
git commit -m "Add feature X"     # Manual commit required
```

### Merge Strategies
```bash
git merge -X ours <branch>        # Prefer current branch in conflicts
git merge -X theirs <branch>      # Prefer incoming branch in conflicts
git merge --strategy=recursive <branch>  # Default strategy
```

## Handling Merge Conflicts

### When Conflicts Occur
```bash
git status                        # See conflicted files
# Edit files to resolve conflicts
git add <resolved-files>          # Stage resolved files
git commit                        # Complete merge
```

### Conflict Markers
```
<<<<<<< HEAD
Your changes
=======
Incoming changes
>>>>>>> feature-branch
```

### Conflict Resolution Tools
```bash
git mergetool                     # Launch merge tool
git config --global merge.tool vimdiff  # Set merge tool
```

### Aborting Merge
```bash
git merge --abort                 # Cancel merge process
```

## Rebasing

Rebasing rewrites history by moving commits to a new base.

### Basic Rebase
```bash
git checkout feature
git rebase main                   # Rebase feature onto main
```

### Interactive Rebase
```bash
git rebase -i HEAD~3              # Interactive rebase last 3 commits
git rebase -i <commit>            # Rebase from specific commit
```

### Interactive Rebase Commands
- `pick` (p): Use commit as-is
- `reword` (r): Use commit but edit message
- `edit` (e): Use commit but stop for amending
- `squash` (s): Combine with previous commit
- `fixup` (f): Like squash but discard message
- `drop` (d): Remove commit

### Rebase vs Merge

**Use Rebase When:**
- You want a linear history
- Working on feature branches
- Cleaning up commits before merging

**Use Merge When:**
- You want to preserve context
- Working with public branches
- You want to see when features were integrated

## Advanced Branching

### Cherry-Picking
Apply specific commits to current branch:
```bash
git cherry-pick <commit>          # Apply single commit
git cherry-pick <commit1>..<commit2>  # Apply range of commits
git cherry-pick --no-commit <commit>  # Apply without committing
```

### Branch Tracking
```bash
git branch -u origin/main         # Set upstream for current branch
git branch --set-upstream-to=origin/main  # Alternative syntax
git push -u origin feature        # Push and set upstream
```

### Branch Comparison
```bash
git diff main..feature            # Compare branches
git log main..feature             # Commits in feature not in main
git log --left-right main...feature  # Show commits from both sides
```

## Workflow Examples

### Feature Branch Workflow
```bash
# Start new feature
git checkout main
git pull origin main
git checkout -b feature/user-auth

# Work on feature
git add .
git commit -m "feat: add login form"
git push -u origin feature/user-auth

# Merge feature (after PR approval)
git checkout main
git pull origin main
git merge --no-ff feature/user-auth
git push origin main
git branch -d feature/user-auth
```

### Hotfix Workflow
```bash
# Create hotfix from main
git checkout main
git checkout -b hotfix/critical-bug

# Fix the bug
git add .
git commit -m "fix: resolve critical security issue"
git push -u origin hotfix/critical-bug

# Merge to main and develop
git checkout main
git merge hotfix/critical-bug
git push origin main

git checkout develop
git merge hotfix/critical-bug
git push origin develop

# Clean up
git branch -d hotfix/critical-bug
git push origin --delete hotfix/critical-bug
```

### Rebase Workflow
```bash
# Keep feature branch up to date
git checkout feature/new-feature
git fetch origin
git rebase origin/main

# Interactive cleanup before merging
git rebase -i HEAD~5              # Clean up last 5 commits

# Force push after rebase (use with caution)
git push --force-with-lease origin feature/new-feature
```

## Best Practices

### Branch Naming Conventions
```bash
feature/user-authentication       # New features
bugfix/fix-login-error           # Bug fixes
hotfix/security-patch            # Critical fixes
release/v1.2.0                   # Release preparation
experiment/new-ui-framework      # Experimental work
```

### Branching Guidelines

1. **Keep branches focused**: One feature per branch
2. **Use descriptive names**: Clear purpose and scope
3. **Regular updates**: Rebase or merge from main regularly
4. **Clean history**: Use interactive rebase before merging
5. **Delete merged branches**: Keep repository clean

### Merge vs Rebase Decision Tree

```
Is this a shared/public branch?
├─ Yes → Use merge
└─ No → Is history important?
    ├─ Yes → Use merge
    └─ No → Use rebase for cleaner history
```

## Troubleshooting

### Common Issues

**Detached HEAD State:**
```bash
git checkout -b new-branch        # Create branch from current state
```

**Merge Conflicts:**
```bash
git status                        # See conflicted files
# Resolve conflicts manually
git add .
git commit
```

**Accidental Branch Deletion:**
```bash
git reflog                        # Find commit hash
git checkout -b recovered-branch <hash>
```

**Wrong Branch for Commits:**
```bash
git reset --soft HEAD~1           # Undo commit, keep changes
git stash                         # Stash changes
git checkout correct-branch       # Switch to correct branch
git stash pop                     # Apply changes
git commit -m "correct message"   # Commit to correct branch
```

---

**Previous**: [← Basic Commands](basic-commands.md) | **Next**: [Remote Repositories →](../advanced/remote-repositories.md)
