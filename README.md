# 🚀 The Ultimate Git Guide

> **Your complete, go-to resource for Git mastery** - from beginner basics to advanced workflows, automation scripts, and best practices.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Git Version](https://img.shields.io/badge/Git-2.40+-blue.svg)](https://git-scm.com/)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Complete Index](https://img.shields.io/badge/📚_Complete_Index-blue.svg)](INDEX.md)


## 🎯 What's Inside

This repository is your **complete Git solution** - everything you need to master Git, from your first commit to advanced automation workflows.

### 📚 **Documentation**
- **[Getting Started](docs/basics/getting-started.md)** - Installation, setup, and first steps
- **[Basic Commands](docs/basics/basic-commands.md)** - Essential Git operations
- **[Branching & Merging](docs/basics/branching.md)** - Branch workflows and strategies
- **[Advanced Topics](docs/advanced/)** - Complex Git operations and techniques

### 🎯 **Hands-On Examples**
- **[Beginner Exercises](examples/beginner/)** - Step-by-step tutorials
- **[Intermediate Scenarios](examples/intermediate/)** - Real-world problem solving
- **[Advanced Workflows](examples/advanced/)** - Complex Git operations

### 🤖 **Automation & Scripts**
- **[Setup Scripts](scripts/setup/)** - Automated Git configuration
- **[Workflow Automation](scripts/automation/)** - Streamlined Git operations
- **[Utilities](scripts/utilities/)** - Helpful Git tools

### 🛠️ **Templates & Configs**
- **[Git Hooks](templates/hooks/)** - Pre-commit, commit-msg, and more
- **[Configuration Templates](templates/configs/)** - Optimized Git settings
- **[Workflow Templates](templates/workflows/)** - CI/CD and automation

### 📋 **Quick References**
- **[Command Cheat Sheet](cheatsheets/git-commands-cheatsheet.md)** - Quick command reference
- **[Workflow Diagrams](assets/diagrams/)** - Visual Git workflows
- **[Troubleshooting Guide](docs/troubleshooting/)** - Common issues and solutions

---

## 🚀 Quick Start

### 1. **Complete Setup** (Recommended)
```bash
# Clone this repository
git clone https://github.com/SpectraX07/git-guide.git
cd git-guide

# Run the automated setup script
./scripts/setup/git-setup.sh
```

### 2. **Manual Setup**
```bash
# Basic Git configuration
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main

# Install useful aliases
git config --global alias.st status
git config --global alias.lg "log --oneline --graph --all"
```

### 3. **Start Learning**
- **New to Git?** → [Getting Started Guide](docs/basics/getting-started.md)
- **Need practice?** → [First Repository Exercise](examples/beginner/first-repository.md)
- **Want automation?** → [Git Flow Script](scripts/automation/git-flow.sh)

---

## 🎓 Learning Path

### **Beginner** (New to Git)
1. [📖 Getting Started](docs/basics/getting-started.md) - Installation and setup
2. [🎯 First Repository](examples/beginner/first-repository.md) - Hands-on tutorial
3. [🔧 Basic Commands](docs/basics/basic-commands.md) - Essential operations
4. [📋 Command Cheat Sheet](cheatsheets/git-commands-cheatsheet.md) - Quick reference

### **Intermediate** (Some Git experience)
1. [🌿 Branching & Merging](docs/basics/branching.md) - Branch workflows
2. [🎯 Branching Exercise](examples/beginner/branching-exercise.md) - Practice branching
3. [🔄 Workflow Automation](scripts/automation/git-flow.sh) - Streamline operations
4. [🪝 Git Hooks](templates/hooks/) - Automated quality checks

### **Advanced** (Git power user)
1. [⚡ Advanced Operations](docs/advanced/) - Complex Git techniques
2. [🔧 Custom Workflows](examples/advanced/) - Advanced scenarios
3. [🛠️ Repository Optimization](docs/advanced/performance.md) - Performance tuning
4. [🤖 Full Automation](scripts/) - Complete workflow automation

---

## 🛠️ Features & Tools

### **🤖 Automation Scripts**
- **[git-setup.sh](scripts/setup/git-setup.sh)** - Complete Git configuration
- **[git-flow.sh](scripts/automation/git-flow.sh)** - Automated workflows
- **[cleanup.sh](scripts/utilities/cleanup.sh)** - Repository maintenance

### **🪝 Git Hooks**
- **[pre-commit](templates/hooks/pre-commit)** - Code quality checks
- **[commit-msg](templates/hooks/commit-msg)** - Conventional commit validation
- **[pre-push](templates/hooks/pre-push)** - Pre-push testing

### **📋 Templates**
- **[.gitconfig](templates/configs/.gitconfig-template)** - Optimized Git configuration
- **[.gitignore](templates/configs/.gitignore-templates/)** - Language-specific ignores
- **[Workflow templates](templates/workflows/)** - CI/CD configurations

---

## 🎯 Use Cases

### **For Developers**
```bash
# Start new feature
./scripts/automation/git-flow.sh start-feature user-auth

# Quick conventional commit
./scripts/automation/git-flow.sh quick-commit

# Finish and merge feature
./scripts/automation/git-flow.sh finish-feature
```

### **For Teams**
- Set up consistent Git configurations across team
- Enforce commit message standards with hooks
- Automate code quality checks
- Standardize branching workflows

### **For Projects**
- Copy hook templates to enforce standards
- Use workflow templates for CI/CD
- Implement automated testing and linting
- Maintain clean repository history

---

## 📖 Complete Documentation

### 📚 **Core Documentation**
| Topic | Description | Link |
|-------|-------------|------|
| **Getting Started** | Installation, setup, first steps | [📖 Guide](docs/basics/getting-started.md) |
| **Basic Commands** | Essential Git operations | [🔧 Commands](docs/basics/basic-commands.md) |
| **Branching & Merging** | Branch workflows and strategies | [🌿 Branching](docs/basics/branching.md) |
| **Troubleshooting** | Common issues and solutions | [🆘 Help](docs/troubleshooting/) |

### 🎯 **Hands-On Learning**
| Level | Description | Examples |
|-------|-------------|----------|
| **Beginner** | Step-by-step tutorials | [🎯 First Repo](examples/beginner/first-repository.md), [🌿 Branching](examples/beginner/branching-exercise.md) |
| **Intermediate** | Real-world scenarios | [⚡ Merge Conflicts](examples/intermediate/), [🔄 Workflows](examples/intermediate/) |
| **Advanced** | Complex operations | [🚀 Advanced](examples/advanced/), [🛠️ Optimization](examples/advanced/) |

### 🤖 **Automation Tools**
| Script | Purpose | Usage |
|--------|---------|-------|
| **Setup** | Complete Git configuration | `./scripts/setup/git-setup.sh` |
| **Workflow** | Automated Git operations | `./scripts/automation/git-flow.sh start-feature` |
| **Cleanup** | Repository maintenance | `./scripts/utilities/cleanup.sh` |

### 🛠️ **Templates & Configs**
| Type | Description | Location |
|------|-------------|----------|
| **Hooks** | Quality control automation | [📁 hooks/](templates/hooks/) |
| **Configs** | Optimized Git settings | [⚙️ configs/](templates/configs/) |
| **Workflows** | CI/CD templates | [🔄 workflows/](templates/workflows/) |

---

## 🎓 Learning Paths

### **🌱 Complete Beginner**
*"I'm new to Git and version control"*

1. **📖 Read**: [Getting Started Guide](docs/basics/getting-started.md)
2. **🛠️ Setup**: Run `./scripts/setup/git-setup.sh`
3. **🎯 Practice**: [First Repository Exercise](examples/beginner/first-repository.md)
4. **📚 Learn**: [Basic Commands](docs/basics/basic-commands.md)
5. **📋 Reference**: [Command Cheat Sheet](cheatsheets/git-commands-cheatsheet.md)

### **⚡ Some Experience**
*"I know basic Git but want to improve"*

1. **🌿 Master**: [Branching & Merging](docs/basics/branching.md)
2. **🎯 Practice**: [Branching Exercise](examples/beginner/branching-exercise.md)
3. **🤖 Automate**: Use `./scripts/automation/git-flow.sh`
4. **🪝 Implement**: [Git Hooks](templates/hooks/) for quality
5. **📊 Optimize**: [Performance Guide](docs/advanced/performance.md)

### **🚀 Advanced User**
*"I want to master Git completely"*

1. **⚡ Advanced**: [Complex Operations](docs/advanced/)
2. **🎯 Scenarios**: [Advanced Examples](examples/advanced/)
3. **🛠️ Customize**: [Configuration Templates](templates/configs/)
4. **🤝 Contribute**: [Help improve this guide](CONTRIBUTING.md)

---

## 🚀 Quick Start Examples

### **Start a New Project**
```bash
# Initialize with our setup
git init my-project
cd my-project
../scripts/setup/git-setup.sh

# Create first commit
echo "# My Project" > README.md
git add README.md
git commit -m "feat: initial project setup"
```

### **Join an Existing Project**
```bash
# Clone and setup
git clone https://github.com/user/project.git
cd project
../scripts/setup/git-setup.sh

# Start working on a feature
../scripts/automation/git-flow.sh start-feature awesome-feature
```

### **Daily Workflow**
```bash
# Quick status and sync
git status
../scripts/automation/git-flow.sh sync

# Make changes and commit
git add .
../scripts/automation/git-flow.sh quick-commit

# Finish feature
../scripts/automation/git-flow.sh finish-feature
```

---

## 🛠️ Installation & Setup

### **Option 1: Complete Setup (Recommended)**
```bash
# Clone this repository
git clone https://github.com/SpectraX07/git-guide.git
cd git-guide

# Run complete setup
./scripts/setup/git-setup.sh

# Add scripts to PATH (optional)
echo 'export PATH="$PATH:$(pwd)/scripts/automation"' >> ~/.bashrc
source ~/.bashrc
```

### **Option 2: Manual Setup**
```bash
# Basic Git configuration
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main

# Essential aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.lg "log --oneline --graph --all"
```

### **Option 3: Copy What You Need**
Browse the repository and copy specific:
- [Scripts](scripts/) for automation
- [Hooks](templates/hooks/) for quality control
- [Configs](templates/configs/) for optimization
- [Examples](examples/) for learning

---

## 🎯 Real-World Use Cases

### **👨‍💻 Individual Developer**
```bash
# Daily workflow automation
git-flow.sh start-feature user-profile
# ... make changes ...
git-flow.sh quick-commit
git-flow.sh finish-feature

# Repository maintenance
cleanup.sh --auto
```

### **👥 Team Lead**
- Set up consistent Git configuration across team
- Implement quality gates with Git hooks
- Standardize commit message format
- Automate common workflows

### **🏢 Organization**
- Enforce coding standards with pre-commit hooks
- Implement automated testing with pre-push hooks
- Standardize branching strategies
- Optimize repository performance

---

## 🏆 Why This Guide?

### **🎯 Comprehensive Coverage**
- **Beginner to Expert**: Progressive learning path
- **Theory + Practice**: Concepts with hands-on exercises
- **Real-World Focus**: Practical scenarios and solutions

### **🤖 Automation First**
- **Setup Scripts**: Get configured in minutes
- **Workflow Automation**: Streamline daily operations
- **Quality Gates**: Automated checks and validations

### **📚 Multiple Learning Styles**
- **Step-by-Step Tutorials**: For hands-on learners
- **Reference Documentation**: For quick lookup
- **Visual Diagrams**: For visual learners
- **Interactive Examples**: For practical application

### **🔄 Always Current**
- **Regular Updates**: Keep pace with Git evolution
- **Community Driven**: Contributions from real users
- **Battle Tested**: Solutions from actual projects

---

## 🤝 Community & Support

### **💬 Get Help**
- **📖 Documentation**: Comprehensive guides and examples
- **🐛 Issues**: Report bugs or request features
- **💡 Discussions**: Ask questions and share ideas
- **🤝 Contributing**: Help improve this guide

### **🏆 Contributors**
This guide is made possible by amazing contributors:
- [View all contributors](https://github.com/SpectraX07/git-guide/contributors)
- [How to contribute](CONTRIBUTING.md)

### **📞 Support Channels**
- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: Questions and community help
- **Documentation**: Comprehensive guides and examples

---

## 📊 Project Stats

![GitHub stars](https://img.shields.io/github/stars/SpectraX07/git-guide?style=social)
![GitHub forks](https://img.shields.io/github/forks/SpectraX07/git-guide?style=social)
![GitHub issues](https://img.shields.io/github/issues/SpectraX07/git-guide)
![GitHub pull requests](https://img.shields.io/github/issues-pr/SpectraX07/git-guide)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🚀 What's Next?

### **Immediate Actions**
1. **⭐ Star this repository** if you find it helpful
2. **🍴 Fork it** to customize for your needs
3. **📖 Start with** [Getting Started Guide](docs/basics/getting-started.md)
4. **🎯 Try the** [First Repository Exercise](examples/beginner/first-repository.md)

### **Ongoing Learning**
- **📚 Bookmark** this repository for reference
- **🔔 Watch** for updates and new content
- **🤝 Contribute** your own improvements
- **📢 Share** with your team and colleagues

---

*Made with ❤️ by the Git community. Happy coding! 🚀*

---

## 🏷️ Commit Message Conventions

### **Conventional Commits Format:**
```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### **Common Commit Types:**

| Type | Description | Example |
|------|-------------|---------|
| `feat:` | **New features** (adds functionality) | `feat: add user authentication system` |
| `fix:` | **Bug fixes** (fixes broken functionality) | `fix: resolve login validation error` |
| `docs:` | **Documentation** changes | `docs: update API documentation` |
| `style:` | **Code formatting** (no logic changes) | `style: fix indentation and spacing` |
| `refactor:` | **Code restructuring** (no new features or fixes) | `refactor: optimize database queries` |
| `test:` | **Adding or updating tests** | `test: add unit tests for user service` |
| `chore:` | **Maintenance tasks** (build, dependencies, etc.) | `chore: update dependencies to latest` |
| `perf:` | **Performance improvements** | `perf: optimize image loading speed` |
| `ci:` | **CI/CD pipeline** changes | `ci: add automated testing workflow` |
| `build:` | **Build system** changes | `build: update webpack configuration` |

### **Examples:**
```bash
feat(auth): add JWT token refresh mechanism
fix(api): resolve CORS issue in production
docs(readme): add installation instructions
style(components): format React components with Prettier
refactor(utils): extract common validation functions
test(auth): add integration tests for login flow
chore(deps): upgrade Node.js to version 18
perf(db): add database indexing for faster queries
```

---

## 🔧 Basic Git Commands

### **Repository Initialization:**
```bash
git init                          # Initialize new Git repository
git clone <url>                   # Clone remote repository
git clone <url> <directory>       # Clone into specific directory
```

### **Staging & Committing:**
```bash
git status                        # Check repository status
git add <file>                    # Stage specific file
git add .                         # Stage all changes
git add -A                        # Stage all changes (including deletions)
git add -p                        # Interactive staging (patch mode)

git commit -m "message"           # Commit with message
git commit -am "message"          # Stage and commit all tracked files
git commit --amend               # Amend last commit
git commit --amend -m "new msg"   # Amend last commit with new message
```

### **Viewing Changes:**
```bash
git diff                          # Show unstaged changes
git diff --staged                 # Show staged changes
git diff HEAD                     # Show all changes since last commit
git diff <commit1> <commit2>      # Compare two commits
```

---

## 🌿 Branching & Merging

### **Branch Operations:**
```bash
git branch                        # List local branches
git branch -r                     # List remote branches
git branch -a                     # List all branches
git branch <name>                 # Create new branch
git branch -d <name>              # Delete branch (safe)
git branch -D <name>              # Force delete branch
git branch -m <old> <new>         # Rename branch

git checkout <branch>             # Switch to branch
git checkout -b <name>            # Create and switch to new branch
git checkout -b <name> <start>    # Create branch from specific commit

# Modern Git (2.23+)
git switch <branch>               # Switch to branch
git switch -c <name>              # Create and switch to new branch
```

### **Merging:**
```bash
git merge <branch>                # Merge branch into current branch
git merge --no-ff <branch>        # Merge with merge commit (no fast-forward)
git merge --squash <branch>       # Squash merge (combine commits)
git merge --abort                 # Abort merge in case of conflicts
```

### **Rebasing:**
```bash
git rebase <branch>               # Rebase current branch onto another
git rebase -i <commit>            # Interactive rebase
git rebase --continue             # Continue rebase after resolving conflicts
git rebase --abort                # Abort rebase
```

---

## 🌐 Remote Repository Operations

### **Remote Management:**
```bash
git remote                        # List remotes
git remote -v                     # List remotes with URLs
git remote add <name> <url>       # Add remote
git remote remove <name>          # Remove remote
git remote rename <old> <new>     # Rename remote
git remote set-url <name> <url>   # Change remote URL
```

### **Fetching & Pulling:**
```bash
git fetch                         # Fetch from default remote
git fetch <remote>                # Fetch from specific remote
git fetch --all                   # Fetch from all remotes

git pull                          # Fetch and merge from default remote
git pull <remote> <branch>        # Pull from specific remote/branch
git pull --rebase                 # Pull with rebase instead of merge
```

### **Pushing:**
```bash
git push                          # Push to default remote
git push <remote> <branch>        # Push to specific remote/branch
git push -u <remote> <branch>     # Push and set upstream
git push --force-with-lease       # Safe force push
git push --tags                   # Push tags
git push <remote> --delete <branch> # Delete remote branch
```

---

## 📊 Viewing History & Changes

### **Log & History:**
```bash
git log                           # Show commit history
git log --oneline                 # Compact log format
git log --graph                   # Show branch graph
git log --all --graph --oneline   # Complete visual history
git log -p                        # Show patches (diffs)
git log --since="2 weeks ago"     # Filter by date
git log --author="John"           # Filter by author
git log --grep="fix"              # Search commit messages

git show <commit>                 # Show specific commit
git show HEAD                     # Show last commit
git show HEAD~2                   # Show commit 2 steps back
```

### **Blame & Annotations:**
```bash
git blame <file>                  # Show who changed each line
git annotate <file>               # Similar to blame
```

---

## ↩️ Undoing Changes

### **Working Directory:**
```bash
git checkout -- <file>            # Discard changes in working directory
git checkout .                    # Discard all changes
git clean -f                      # Remove untracked files
git clean -fd                     # Remove untracked files and directories
git clean -n                      # Dry run (show what would be removed)
```

### **Staging Area:**
```bash
git reset <file>                  # Unstage file
git reset                         # Unstage all files
git reset --hard                  # Reset to last commit (dangerous!)
```

### **Commits:**
```bash
git reset --soft HEAD~1           # Undo last commit, keep changes staged
git reset --mixed HEAD~1          # Undo last commit, unstage changes
git reset --hard HEAD~1           # Undo last commit, discard changes

git revert <commit>               # Create new commit that undoes changes
git revert HEAD                   # Revert last commit
```

---

## 📦 Stashing

### **Stash Operations:**
```bash
git stash                         # Stash current changes
git stash push -m "message"       # Stash with message
git stash list                    # List all stashes
git stash show                    # Show stash contents
git stash apply                   # Apply most recent stash
git stash apply stash@{2}         # Apply specific stash
git stash pop                     # Apply and remove most recent stash
git stash drop                    # Delete most recent stash
git stash drop stash@{2}          # Delete specific stash
git stash clear                   # Delete all stashes
```

---

## 🏷️ Tagging

### **Tag Operations:**
```bash
git tag                           # List tags
git tag <name>                    # Create lightweight tag
git tag -a <name> -m "message"    # Create annotated tag
git tag -a <name> <commit>        # Tag specific commit
git show <tag>                    # Show tag information
git tag -d <name>                 # Delete local tag
git push origin <tag>             # Push specific tag
git push --tags                   # Push all tags
git push origin --delete <tag>    # Delete remote tag
```

---

## 🔬 Advanced Git Operations

### **Cherry-picking:**
```bash
git cherry-pick <commit>          # Apply specific commit to current branch
git cherry-pick <commit1>..<commit2> # Cherry-pick range of commits
git cherry-pick --no-commit <commit> # Cherry-pick without committing
```

### **Bisecting (Finding Bugs):**
```bash
git bisect start                  # Start bisect session
git bisect bad                    # Mark current commit as bad
git bisect good <commit>          # Mark commit as good
git bisect reset                  # End bisect session
```

### **Submodules:**
```bash
git submodule add <url> <path>    # Add submodule
git submodule init                # Initialize submodules
git submodule update              # Update submodules
git submodule update --init --recursive # Init and update recursively
```

---

## ⚙️ Git Configuration

### **User Configuration:**
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
```

### **Editor & Tools:**
```bash
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "vim"          # Vim
git config --global merge.tool vimdiff         # Merge tool
```

### **Aliases (see section below):**
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
```

### **View Configuration:**
```bash
git config --list                # Show all configuration
git config --global --list       # Show global configuration
git config user.name             # Show specific setting
```

---

## 🎯 Best Practices

### **Commit Guidelines:**
- ✅ **Write clear, descriptive commit messages**
- ✅ **Use conventional commit format**
- ✅ **Make atomic commits** (one logical change per commit)
- ✅ **Commit frequently** with small, focused changes
- ❌ **Don't commit broken code** to main branches
- ❌ **Don't commit sensitive information** (passwords, keys)

### **Branching Strategy:**
```bash
main/master     # Production-ready code
develop         # Integration branch
feature/*       # Feature development
hotfix/*        # Emergency fixes
release/*       # Release preparation
```

### **Workflow Example:**
```bash
# Start new feature
git checkout develop
git pull origin develop
git checkout -b feature/user-authentication

# Work on feature
git add .
git commit -m "feat(auth): add login form validation"
git push -u origin feature/user-authentication

# Create pull request, then merge
git checkout develop
git pull origin develop
git branch -d feature/user-authentication
```

---

## 🚀 Useful Aliases

Add these to your Git configuration for faster workflows:

```bash
# Basic shortcuts
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'

# Advanced aliases
git config --global alias.lg "log --oneline --graph --all"
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
git config --global alias.pushf 'push --force-with-lease'
git config --global alias.amend 'commit --amend --no-edit'
git config --global alias.wip 'commit -am "WIP: work in progress"'
git config --global alias.undo 'reset --soft HEAD~1'
git config --global alias.cleanup 'branch --merged | grep -v "\*\|main\|develop" | xargs -n 1 git branch -d'
```

### **Usage Examples:**
```bash
git st                            # Instead of git status
git co main                       # Instead of git checkout main
git lg                            # Beautiful log with graph
git amend                         # Amend without changing message
git wip                           # Quick work-in-progress commit
git undo                          # Undo last commit, keep changes
git cleanup                       # Delete merged branches
```

---

## 🆘 Emergency Commands

### **"Oh no!" Situations:**

**Committed to wrong branch:**
```bash
git reset --soft HEAD~1           # Undo commit, keep changes
git stash                         # Stash changes
git checkout correct-branch       # Switch to correct branch
git stash pop                     # Apply changes
git commit -m "correct message"   # Commit to correct branch
```

**Need to fix last commit message:**
```bash
git commit --amend -m "corrected message"
```

**Accidentally deleted branch:**
```bash
git reflog                        # Find the commit hash
git checkout -b recovered-branch <hash>
```

**Merge conflicts:**
```bash
git status                        # See conflicted files
# Edit files to resolve conflicts
git add .                         # Stage resolved files
git commit                        # Complete merge
```

---

## 📚 Additional Resources

- **Official Git Documentation:** https://git-scm.com/doc
- **Interactive Git Tutorial:** https://learngitbranching.js.org/
- **Git Cheat Sheet:** https://education.github.com/git-cheat-sheet-education.pdf
- **Conventional Commits:** https://www.conventionalcommits.org/

---

## 💡 Pro Tips

1. **Use `.gitignore`** to exclude files you don't want to track
2. **Write meaningful commit messages** - your future self will thank you
3. **Use branches** for all feature development
4. **Pull before pushing** to avoid conflicts
5. **Review changes** before committing with `git diff --staged`
6. **Use `git stash`** when switching branches with uncommitted changes
7. **Learn interactive rebase** (`git rebase -i`) for cleaning up history
8. **Use `--force-with-lease`** instead of `--force` for safer force pushes

---

## 🚨 Common Errors & Fixes

### **Authentication Errors:**

**Error: `Permission denied (publickey)`**
```bash
# Check SSH key
ssh -T git@github.com

# Generate new SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"

# Add to SSH agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Add public key to GitHub/GitLab
cat ~/.ssh/id_ed25519.pub
```

**Error: `fatal: Authentication failed`**
```bash
# Use personal access token instead of password
git remote set-url origin https://username:token@github.com/user/repo.git

# Or configure credential helper
git config --global credential.helper store
```

### **Merge Conflicts:**

**Error: `Automatic merge failed; fix conflicts and then commit`**
```bash
# View conflicted files
git status

# Open files and resolve conflicts (look for <<<<<<< ======= >>>>>>>)
# After resolving:
git add .
git commit -m "resolve merge conflicts"

# Or abort merge
git merge --abort
```

**Conflict markers in files:**
```
<<<<<<< HEAD
Your changes
=======
Incoming changes
>>>>>>> branch-name
```

### **Branch Issues:**

**Error: `fatal: A branch named 'feature' already exists`**
```bash
# Delete existing branch first
git branch -d feature
# Or force delete
git branch -D feature
# Then create new one
git checkout -b feature
```

**Error: `error: cannot delete branch 'main' checked out at`**
```bash
# Switch to different branch first
git checkout develop
git branch -d main
```

### **Push/Pull Errors:**

**Error: `Updates were rejected because the remote contains work`**
```bash
# Pull first, then push
git pull origin main
git push origin main

# Or force push (dangerous!)
git push --force-with-lease origin main
```

**Error: `fatal: refusing to merge unrelated histories`**
```bash
# Allow unrelated histories
git pull origin main --allow-unrelated-histories
```

**Error: `Your branch is ahead of 'origin/main' by X commits`**
```bash
# Push your commits
git push origin main

# Or reset to remote state
git reset --hard origin/main
```

### **File & Directory Issues:**

**Error: `fatal: pathspec 'file.txt' did not match any files`**
```bash
# Check if file exists
ls -la
# Check current directory
pwd
# Use correct file path
git add path/to/file.txt
```

**Error: `warning: LF will be replaced by CRLF`**
```bash
# Configure line endings (Windows)
git config --global core.autocrlf true

# Configure line endings (Mac/Linux)
git config --global core.autocrlf input

# Disable warning
git config --global core.autocrlf false
```

### **Commit Issues:**

**Error: `fatal: not a git repository`**
```bash
# Initialize repository
git init

# Or navigate to correct directory
cd /path/to/your/project
```

**Error: `Please tell me who you are`**
```bash
# Configure user information
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

**Error: `nothing to commit, working tree clean`**
```bash
# Check status
git status
# Add files first
git add .
# Or check if you're in the right directory
pwd
```

### **Detached HEAD State:**

**Error: `You are in 'detached HEAD' state`**
```bash
# Create branch from current state
git checkout -b new-branch-name

# Or return to main branch
git checkout main
```

### **Large File Issues:**

**Error: `remote: error: File is larger than 100MB`**
```bash
# Remove large file from history
git filter-branch --force --index-filter \
'git rm --cached --ignore-unmatch large-file.zip' \
--prune-empty --tag-name-filter cat -- --all

# Or use Git LFS
git lfs track "*.zip"
git add .gitattributes
git add large-file.zip
git commit -m "add large file with LFS"
```

### **Stash Issues:**

**Error: `error: Your local changes would be overwritten by merge`**
```bash
# Stash changes first
git stash
git pull
git stash pop

# Or commit changes
git add .
git commit -m "WIP: temporary commit"
git pull
```

---

## 🔄 Advanced Workflows

### **GitFlow Workflow:**
```bash
# Initialize GitFlow
git flow init

# Start new feature
git flow feature start new-feature

# Finish feature
git flow feature finish new-feature

# Start release
git flow release start 1.0.0

# Finish release
git flow release finish 1.0.0

# Start hotfix
git flow hotfix start critical-fix

# Finish hotfix
git flow hotfix finish critical-fix
```

### **GitHub Flow (Simplified):**
```bash
# 1. Create feature branch
git checkout -b feature/awesome-feature

# 2. Make changes and commit
git add .
git commit -m "feat: add awesome feature"

# 3. Push and create PR
git push -u origin feature/awesome-feature

# 4. After PR approval, merge and cleanup
git checkout main
git pull origin main
git branch -d feature/awesome-feature
```

### **Semantic Versioning with Git:**
```bash
# Tag versions
git tag -a v1.0.0 -m "Release version 1.0.0"
git tag -a v1.1.0 -m "Minor release 1.1.0"
git tag -a v1.1.1 -m "Patch release 1.1.1"

# Push tags
git push --tags

# List versions
git tag -l "v*"
```

### **Squashing Commits:**
```bash
# Interactive rebase to squash last 3 commits
git rebase -i HEAD~3

# In the editor, change 'pick' to 'squash' for commits to combine
# pick abc1234 First commit
# squash def5678 Second commit  
# squash ghi9012 Third commit
```

---

## 🪝 Git Hooks

### **Pre-commit Hook (Linting):**
Create `.git/hooks/pre-commit`:
```bash
#!/bin/sh
# Run linter before commit
npm run lint
if [ $? -ne 0 ]; then
  echo "Linting failed. Commit aborted."
  exit 1
fi
```

### **Commit Message Hook:**
Create `.git/hooks/commit-msg`:
```bash
#!/bin/sh
# Check commit message format
commit_regex='^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .{1,50}'

if ! grep -qE "$commit_regex" "$1"; then
    echo "Invalid commit message format!"
    echo "Use: type(scope): description"
    exit 1
fi
```

### **Pre-push Hook (Testing):**
Create `.git/hooks/pre-push`:
```bash
#!/bin/sh
# Run tests before push
npm test
if [ $? -ne 0 ]; then
  echo "Tests failed. Push aborted."
  exit 1
fi
```

### **Make Hooks Executable:**
```bash
chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/commit-msg
chmod +x .git/hooks/pre-push
```

---

## ⚡ Performance & Optimization

### **Repository Maintenance:**
```bash
# Cleanup unnecessary files and optimize
git gc --aggressive --prune=now

# Remove unreachable objects
git fsck --full

# Compress repository
git repack -ad

# Show repository size
git count-objects -vH
```

### **Large Repository Optimization:**
```bash
# Shallow clone (faster for large repos)
git clone --depth 1 <url>

# Fetch specific branch only
git clone --single-branch --branch main <url>

# Partial clone (Git 2.19+)
git clone --filter=blob:none <url>
```

### **Cleaning Up:**
```bash
# Remove merged branches
git branch --merged | grep -v "\*\|main\|develop" | xargs -n 1 git branch -d

# Remove remote tracking branches that no longer exist
git remote prune origin

# Clean up reflog
git reflog expire --expire=30.days refs/stash
git reflog expire --expire-unreachable=30.days --all
git gc --prune=30.days
```

### **Ignoring Files After Tracking:**
```bash
# Remove from tracking but keep local file
git rm --cached file.txt
echo "file.txt" >> .gitignore
git add .gitignore
git commit -m "chore: ignore file.txt"

# Remove directory from tracking
git rm -r --cached directory/
echo "directory/" >> .gitignore
```

### **Finding Large Files:**
```bash
# Find large files in repository
git rev-list --objects --all | \
git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
sed -n 's/^blob //p' | \
sort --numeric-sort --key=2 | \
tail -10
```

### **Useful Git Commands for Debugging:**
```bash
# Show file at specific commit
git show commit-hash:path/to/file

# Find when line was changed
git log -S "search-string" --source --all

# Find commits that touched a file
git log --follow -- path/to/file

# Show changes in a merge commit
git show --first-parent commit-hash

# Find commits between dates
git log --since="2023-01-01" --until="2023-12-31"

# Show commits by specific author
git shortlog -s -n --author="John Doe"

# Find commits that introduced a bug
git bisect start
git bisect bad HEAD
git bisect good v1.0.0
# Git will checkout commits to test
git bisect good  # or git bisect bad
git bisect reset # when done
```

### **Advanced Git Configuration:**
```bash
# Improve performance
git config --global core.preloadindex true
git config --global core.fscache true
git config --global gc.auto 256

# Better diff algorithm
git config --global diff.algorithm patience

# Reuse recorded resolutions
git config --global rerere.enabled true

# Default push behavior
git config --global push.default simple

# Automatic stash before rebase
git config --global rebase.autoStash true

# Show original branch name in merge commits
git config --global merge.branchdesc true
```

### **Git Attributes (.gitattributes):**
```bash
# Create .gitattributes file
echo "*.js text eol=lf" >> .gitattributes
echo "*.json text eol=lf" >> .gitattributes
echo "*.md text eol=lf" >> .gitattributes
echo "*.yml text eol=lf" >> .gitattributes
echo "*.png binary" >> .gitattributes
echo "*.jpg binary" >> .gitattributes

# Language detection
echo "*.js linguist-language=JavaScript" >> .gitattributes
echo "*.ts linguist-language=TypeScript" >> .gitattributes
```

### **Backup and Recovery:**
```bash
# Create bundle (complete backup)
git bundle create backup.bundle --all

# Restore from bundle
git clone backup.bundle restored-repo

# Backup specific branch
git bundle create feature-backup.bundle feature-branch

# Verify bundle
git bundle verify backup.bundle
```

---

## 🔍 Troubleshooting Checklist

### **Before Asking for Help:**

1. **Check Git Status:**
   ```bash
   git status
   git log --oneline -5
   ```

2. **Verify Configuration:**
   ```bash
   git config --list
   git remote -v
   ```

3. **Check Network Connectivity:**
   ```bash
   ping github.com
   ssh -T git@github.com
   ```

4. **Update Git:**
   ```bash
   git --version
   # Update if version is old
   ```

5. **Check Repository State:**
   ```bash
   git fsck
   git reflog
   ```

### **Emergency Recovery Commands:**
```bash
# Recover deleted commits
git reflog
git checkout <commit-hash>
git checkout -b recovered-branch

# Recover deleted files
git log --diff-filter=D --summary | grep delete
git checkout <commit-hash>~1 -- <file-path>

# Reset everything to remote state
git fetch origin
git reset --hard origin/main
git clean -fd
```

---

*Happy coding! 🚀*
