# 🌿 Branching Exercise - Feature Development

This exercise teaches you how to use branches for feature development through a practical scenario.

## Scenario
You're working on a website and need to add a new "About" page while keeping the main branch stable.

## Prerequisites
- Complete the [First Repository](first-repository.md) exercise
- Or have a Git repository with at least one commit

## Setup (if starting fresh)
```bash
mkdir branching-demo
cd branching-demo
git init
echo "# My Website" > README.md
git add README.md
git commit -m "Initial commit"
```

## Exercise Steps

### Step 1: Check Current Branch
```bash
git branch
```
**Expected Output:**
```
* main
```
The `*` indicates your current branch.

### Step 2: Create a Feature Branch
```bash
git checkout -b feature/about-page
```
**Expected Output:**
```
Switched to a new branch 'feature/about-page'
```

### Step 3: Verify Branch Switch
```bash
git branch
```
**Expected Output:**
```
* feature/about-page
  main
```

### Step 4: Create the About Page
```bash
echo "<!DOCTYPE html>
<html>
<head>
    <title>About Us</title>
</head>
<body>
    <h1>About Our Company</h1>
    <p>We are a innovative tech company focused on creating amazing web experiences.</p>
    <h2>Our Mission</h2>
    <p>To make the web a better place, one website at a time.</p>
</body>
</html>" > about.html
```

### Step 5: Stage and Commit the New File
```bash
git add about.html
git commit -m "feat: add about page with company info"
```

### Step 6: Add Navigation to About Page
```bash
echo "    <nav>
        <a href=\"index.html\">Home</a> | 
        <a href=\"about.html\">About</a>
    </nav>" > nav.html
```

```bash
git add nav.html
git commit -m "feat: add navigation component"
```

### Step 7: View Branch History
```bash
git log --oneline
```
**Expected Output:**
```
def5678 feat: add navigation component
abc1234 feat: add about page with company info
xyz9012 Initial commit
```

### Step 8: Switch Back to Main Branch
```bash
git checkout main
```

### Step 9: Check Files in Main Branch
```bash
ls -la
```
**Notice**: The `about.html` and `nav.html` files are not here! They only exist in the feature branch.

### Step 10: Make a Change in Main Branch
```bash
echo "
## Project Status
- ✅ Basic structure complete
- 🚧 About page in development" >> README.md

git add README.md
git commit -m "docs: update project status"
```

### Step 11: View Diverged History
```bash
git log --oneline --graph --all
```
**Expected Output:**
```
* ghi3456 docs: update project status
| * def5678 feat: add navigation component
| * abc1234 feat: add about page with company info
|/
* xyz9012 Initial commit
```

### Step 12: Merge Feature Branch
```bash
git merge feature/about-page
```
**Expected Output:**
```
Merge made by the 'recursive' strategy.
 about.html | 10 ++++++++++
 nav.html   |  4 ++++
 2 files changed, 14 insertions(+)
 create mode 100644 about.html
 create mode 100644 nav.html
```

### Step 13: View Merged History
```bash
git log --oneline --graph
```
**Expected Output:**
```
*   jkl7890 Merge branch 'feature/about-page'
|\
| * def5678 feat: add navigation component
| * abc1234 feat: add about page with company info
* | ghi3456 docs: update project status
|/
* xyz9012 Initial commit
```

### Step 14: Verify All Files Are Present
```bash
ls -la
```
**Expected Output:**
```
about.html
nav.html
README.md
```

### Step 15: Clean Up Feature Branch
```bash
git branch -d feature/about-page
```
**Expected Output:**
```
Deleted branch feature/about-page (was def5678).
```

### Step 16: Final Branch Check
```bash
git branch
```
**Expected Output:**
```
* main
```

## Alternative: No-Fast-Forward Merge

Let's try another feature with a different merge strategy:

### Step 17: Create Another Feature Branch
```bash
git checkout -b feature/contact-page
```

### Step 18: Add Contact Page
```bash
echo "<!DOCTYPE html>
<html>
<head>
    <title>Contact Us</title>
</head>
<body>
    <h1>Contact Information</h1>
    <p>Email: contact@mywebsite.com</p>
    <p>Phone: (555) 123-4567</p>
</body>
</html>" > contact.html

git add contact.html
git commit -m "feat: add contact page"
```

### Step 19: Merge with No-Fast-Forward
```bash
git checkout main
git merge --no-ff feature/contact-page -m "Merge contact page feature"
```

### Step 20: Compare Merge Strategies
```bash
git log --oneline --graph
```
**Notice**: The `--no-ff` creates an explicit merge commit even when fast-forward is possible.

### Step 21: Clean Up
```bash
git branch -d feature/contact-page
```

## What You've Learned

✅ **Branch Creation**: `git checkout -b <branch-name>`
✅ **Branch Switching**: `git checkout <branch-name>`
✅ **Branch Listing**: `git branch`
✅ **Merging**: `git merge <branch-name>`
✅ **Branch Deletion**: `git branch -d <branch-name>`
✅ **Visual History**: `git log --oneline --graph --all`
✅ **Merge Strategies**: Fast-forward vs no-fast-forward

## Key Concepts

### Branch Isolation
- Changes in feature branches don't affect main
- You can switch between branches freely
- Each branch maintains its own file state

### Merge Types
- **Fast-forward**: Linear history when possible
- **No-fast-forward**: Always creates merge commit
- **Three-way merge**: When branches have diverged

### Best Practices Demonstrated
1. Use descriptive branch names (`feature/about-page`)
2. Make focused commits in feature branches
3. Merge back to main when feature is complete
4. Delete feature branches after merging

## Troubleshooting

### If You Get Merge Conflicts
```bash
# View conflicted files
git status

# Edit files to resolve conflicts
# Look for <<<<<<< ======= >>>>>>> markers

# After resolving conflicts
git add .
git commit -m "resolve merge conflicts"
```

### If You're on Wrong Branch
```bash
# Check current branch
git branch

# Switch to correct branch
git checkout <correct-branch>
```

### If You Need to Undo Merge
```bash
# Only if merge hasn't been pushed
git reset --hard HEAD~1
```

## Next Challenges

Try these variations:
1. Create multiple feature branches simultaneously
2. Practice resolving merge conflicts
3. Try rebasing instead of merging
4. Experiment with `git switch` (modern alternative to checkout)

---

**Previous**: [← First Repository](first-repository.md) | **Next**: [Remote Setup →](remote-setup.md)
