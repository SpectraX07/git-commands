# ⚔️ Mastering Merge Conflicts - Interactive Exercise

This exercise teaches you how to handle merge conflicts like a pro through realistic scenarios.

## 🎯 Learning Objectives

By the end of this exercise, you'll be able to:
- Understand why merge conflicts occur
- Resolve conflicts using different strategies
- Use Git tools to make conflict resolution easier
- Prevent conflicts through good practices

## 📋 Prerequisites

- Complete the [Branching Exercise](../beginner/branching-exercise.md)
- Basic understanding of Git branches and merging

## 🚀 Exercise Setup

### Step 1: Create Practice Repository
```bash
mkdir conflict-practice
cd conflict-practice
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

### Step 2: Create Initial Content
```bash
echo "# Team Project
## Overview
This is our main project file.

## Features
- User authentication
- Data processing
- Report generation

## Team Members
- Alice (Backend)
- Bob (Frontend)" > README.md

git add README.md
git commit -m "feat: initial project setup"
```

## 🔥 Scenario 1: Simple Content Conflict

### Create Conflicting Changes

**Step 1: Create Feature Branch (Alice's work)**
```bash
git checkout -b feature/auth-system
```

**Step 2: Alice's Changes**
```bash
# Modify README.md
sed -i 's/- User authentication/- Advanced user authentication with JWT/' README.md
sed -i 's/- Alice (Backend)/- Alice (Backend Lead)/' README.md

git add README.md
git commit -m "feat(auth): enhance authentication system"
```

**Step 3: Switch to Main and Make Conflicting Changes (Bob's work)**
```bash
git checkout main

# Bob's conflicting changes
sed -i 's/- User authentication/- Basic user authentication/' README.md
sed -i 's/- Bob (Frontend)/- Bob (Frontend Lead)/' README.md

git add README.md
git commit -m "feat(auth): add basic authentication"
```

### Trigger the Conflict

**Step 4: Attempt to Merge**
```bash
git merge feature/auth-system
```

**Expected Output:**
```
Auto-merging README.md
CONFLICT (content): Merge conflict in README.md
Automatic merge failed; fix conflicts and then commit the result.
```

### Resolve the Conflict

**Step 5: Examine the Conflict**
```bash
git status
```

**Expected Output:**
```
On branch main
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   README.md
```

**Step 6: View the Conflict Markers**
```bash
cat README.md
```

**Expected Output:**
```
# Team Project
## Overview
This is our main project file.

## Features
<<<<<<< HEAD
- Basic user authentication
=======
- Advanced user authentication with JWT
>>>>>>> feature/auth-system
- Data processing
- Report generation

## Team Members
<<<<<<< HEAD
- Alice (Backend)
- Bob (Frontend Lead)
=======
- Alice (Backend Lead)
- Bob (Frontend)
>>>>>>> feature/auth-system
```

**Step 7: Resolve Conflicts Manually**
Edit README.md to resolve conflicts:
```bash
# Choose the best solution from both sides
cat > README.md << 'EOF'
# Team Project
## Overview
This is our main project file.

## Features
- Advanced user authentication with JWT
- Data processing
- Report generation

## Team Members
- Alice (Backend Lead)
- Bob (Frontend Lead)
EOF
```

**Step 8: Complete the Merge**
```bash
git add README.md
git commit -m "resolve: merge authentication features from both teams"
```

**Step 9: Verify Resolution**
```bash
git log --oneline --graph
```

## ⚡ Scenario 2: File Addition Conflicts

### Setup Conflicting File Additions

**Step 1: Create New Feature Branch**
```bash
git checkout -b feature/config-files
```

**Step 2: Add Configuration File**
```bash
echo "# Database Configuration
host=localhost
port=5432
database=myapp
user=admin
password=secret123" > config.ini

git add config.ini
git commit -m "feat: add database configuration"
```

**Step 3: Switch to Main and Add Different Config**
```bash
git checkout main

echo "# Application Configuration  
debug=true
log_level=INFO
api_url=https://api.example.com
timeout=30" > config.ini

git add config.ini
git commit -m "feat: add application configuration"
```

### Resolve Addition Conflict

**Step 4: Merge and Resolve**
```bash
git merge feature/config-files
```

**Step 5: Combine Both Configurations**
```bash
cat > config.ini << 'EOF'
# Application Configuration  
debug=true
log_level=INFO
api_url=https://api.example.com
timeout=30

# Database Configuration
host=localhost
port=5432
database=myapp
user=admin
password=secret123
EOF

git add config.ini
git commit -m "resolve: combine application and database configurations"
```

## 🛠️ Scenario 3: Using Merge Tools

### Setup for Tool-Assisted Resolution

**Step 1: Create Complex Conflict**
```bash
git checkout -b feature/complex-changes

# Create a more complex file
cat > app.py << 'EOF'
#!/usr/bin/env python3
"""
Main application module
"""

import os
import sys
from datetime import datetime

class App:
    def __init__(self):
        self.version = "1.0.0"
        self.debug = False
        
    def start(self):
        print("Starting application...")
        self.load_config()
        
    def load_config(self):
        print("Loading configuration...")
EOF

git add app.py
git commit -m "feat: add application class structure"
```

**Step 2: Make Changes in Feature Branch**
```bash
# Add method to feature branch
cat >> app.py << 'EOF'
        
    def authenticate_user(self, username, password):
        """Authenticate user with JWT"""
        print(f"Authenticating user: {username}")
        return True
        
    def process_data(self):
        """Process user data"""
        print("Processing data with advanced algorithms...")
EOF

git add app.py
git commit -m "feat: add authentication and data processing"
```

**Step 3: Make Different Changes in Main**
```bash
git checkout main

# Add different methods to main
cat >> app.py << 'EOF'
        
    def login_user(self, username, password):
        """Simple user login"""
        print(f"Logging in user: {username}")
        return True
        
    def generate_report(self):
        """Generate user report"""
        print("Generating report...")
EOF

git add app.py
git commit -m "feat: add login and reporting features"
```

### Use Git's Built-in Merge Tool

**Step 4: Configure Merge Tool (Optional)**
```bash
# Set up vimdiff as merge tool (if you have vim)
git config merge.tool vimdiff

# Or use a simpler approach with git mergetool
git merge feature/complex-changes
```

**Step 5: Resolve Using Manual Edit**
```bash
# Edit the file to include both sets of methods
cat > app.py << 'EOF'
#!/usr/bin/env python3
"""
Main application module
"""

import os
import sys
from datetime import datetime

class App:
    def __init__(self):
        self.version = "1.0.0"
        self.debug = False
        
    def start(self):
        print("Starting application...")
        self.load_config()
        
    def load_config(self):
        print("Loading configuration...")
        
    def authenticate_user(self, username, password):
        """Authenticate user with JWT"""
        print(f"Authenticating user: {username}")
        return True
        
    def login_user(self, username, password):
        """Simple user login - calls authenticate_user"""
        return self.authenticate_user(username, password)
        
    def process_data(self):
        """Process user data"""
        print("Processing data with advanced algorithms...")
        
    def generate_report(self):
        """Generate user report"""
        print("Generating report...")
EOF

git add app.py
git commit -m "resolve: integrate authentication, login, and reporting features"
```

## 🚨 Scenario 4: Emergency Conflict Resolution

### Simulate Production Hotfix Conflict

**Step 1: Create Hotfix Scenario**
```bash
# Simulate working on a feature when hotfix is needed
git checkout -b feature/new-ui

echo "<!-- New UI Components -->
<div class=\"header\">
    <h1>New Design</h1>
    <nav>Navigation</nav>
</div>" > index.html

git add index.html
git commit -m "feat: start new UI design"
```

**Step 2: Emergency Hotfix on Main**
```bash
git checkout main

echo "<!-- Emergency Security Fix -->
<div class=\"header\">
    <h1>Secure App</h1>
    <div class=\"security-notice\">Security Update Applied</div>
</div>" > index.html

git add index.html
git commit -m "fix: critical security update"
```

**Step 3: Feature Branch Needs Hotfix**
```bash
git checkout feature/new-ui
git merge main
```

**Step 4: Quick Resolution Strategy**
```bash
# Combine security fix with new design
cat > index.html << 'EOF'
<!-- New UI Components with Security -->
<div class="header">
    <h1>New Secure Design</h1>
    <div class="security-notice">Security Update Applied</div>
    <nav>Navigation</nav>
</div>
EOF

git add index.html
git commit -m "resolve: integrate security fix with new UI design"
```

## 🔧 Advanced Conflict Resolution Techniques

### Using Git Commands for Conflict Analysis

**Step 1: Analyze Conflict History**
```bash
# See what caused the conflict
git log --merge --oneline

# See the differences that caused conflict
git diff HEAD...MERGE_HEAD
```

**Step 2: Choose Sides Strategically**
```bash
# If you want to keep your version entirely
git checkout --ours conflicted-file.txt

# If you want to keep their version entirely  
git checkout --theirs conflicted-file.txt

# Then add and commit
git add conflicted-file.txt
git commit -m "resolve: choose appropriate version"
```

### Preventing Conflicts

**Step 3: Best Practices Demo**
```bash
# Create a new feature with conflict prevention
git checkout main
git checkout -b feature/conflict-prevention

# Make small, focused changes
echo "# Documentation
This section covers conflict prevention." > docs.md

git add docs.md
git commit -m "docs: add conflict prevention guide"

# Regularly sync with main
git fetch origin
git rebase main  # Instead of merge to keep linear history
```

## 📊 Conflict Resolution Strategies Summary

### **Strategy 1: Manual Resolution**
- **When**: Simple conflicts, clear resolution needed
- **How**: Edit files manually, remove conflict markers
- **Pros**: Full control, custom solutions
- **Cons**: Time-consuming for large conflicts

### **Strategy 2: Choose One Side**
- **When**: One version is clearly better
- **How**: `git checkout --ours` or `git checkout --theirs`
- **Pros**: Quick resolution
- **Cons**: Might lose valuable changes

### **Strategy 3: Merge Tool**
- **When**: Complex conflicts, visual comparison needed
- **How**: `git mergetool` with configured tool
- **Pros**: Visual interface, easier comparison
- **Cons**: Requires tool setup

### **Strategy 4: Abort and Restart**
- **When**: Conflicts too complex, need different approach
- **How**: `git merge --abort`, then plan better strategy
- **Pros**: Clean slate, no partial state
- **Cons**: Lost merge progress

## 🎯 Key Takeaways

### **Conflict Prevention**
1. **Communicate** with team about file changes
2. **Pull frequently** to stay updated
3. **Make small commits** for easier resolution
4. **Use feature branches** for isolated work

### **Conflict Resolution**
1. **Don't panic** - conflicts are normal
2. **Understand the changes** before resolving
3. **Test after resolution** to ensure functionality
4. **Communicate resolution** to team

### **Tools and Commands**
```bash
# Essential conflict commands
git status                    # See conflicted files
git diff                      # See conflict details
git add <file>               # Mark as resolved
git commit                   # Complete merge
git merge --abort            # Cancel merge
git checkout --ours <file>   # Keep your version
git checkout --theirs <file> # Keep their version
```

## 🚀 Next Steps

1. Practice these scenarios multiple times
2. Try the [Advanced Git Operations](../advanced/) exercises
3. Set up a merge tool for your environment
4. Learn about [Rebase vs Merge](../advanced/rebase-strategies.md) strategies

---

**Remember**: Merge conflicts are a normal part of collaborative development. The key is staying calm, understanding the changes, and choosing the best resolution strategy for each situation.

**Next Exercise**: [Undoing Changes →](undoing-changes.md)
