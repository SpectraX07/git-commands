# 🔄 Git Rebase Mastery - Advanced History Management

Master the art of Git rebase for clean, professional commit histories and advanced workflow management.

## 🎯 Learning Objectives

- Master interactive rebase for history cleanup
- Understand rebase vs merge trade-offs
- Learn advanced rebase strategies
- Practice complex history rewriting scenarios
- Handle rebase conflicts like a pro

## 📋 Prerequisites

- Solid understanding of Git basics
- Experience with branching and merging
- Completed intermediate exercises

## ⚠️ Important Safety Note

**Rebase rewrites history!** Never rebase commits that have been pushed to shared repositories unless you're absolutely sure what you're doing and have team agreement.

## 🚀 Exercise Setup

```bash
mkdir rebase-mastery
cd rebase-mastery
git init
git config user.name "Rebase Master"
git config user.email "master@rebase.com"

# Create initial project
echo "# Advanced Git Project
A project for mastering Git rebase techniques." > README.md

echo "function hello() {
    return 'Hello, World!';
}" > src.js

git add .
git commit -m "feat: initial project setup"
```

## 🧹 Part 1: Interactive Rebase Fundamentals

### Scenario: Cleaning Up Messy Commit History

**Step 1: Create Messy History**
```bash
# Simulate a developer's messy work session
echo "function hello() {
    return 'Hello, World!';
}

function add(a, b) {
    return a + b;
}" > src.js
git add src.js
git commit -m "add function"

echo "function hello() {
    return 'Hello, World!';
}

function add(a, b) {
    return a + b;
}

function subtract(a, b) {
    return a - b;
}" > src.js
git add src.js
git commit -m "oops forgot subtract"

echo "function hello() {
    return 'Hello, World!';
}

function add(a, b) {
    return a + b;
}

function subtract(a, b) {
    return a - b;
}

function multiply(a, b) {
    return a * b;
}" > src.js
git add src.js
git commit -m "WIP"

echo "function hello() {
    return 'Hello, World!';
}

function add(a, b) {
    return a + b;
}

function subtract(a, b) {
    return a - b;
}

function multiply(a, b) {
    return a * b;
}

function divide(a, b) {
    if (b === 0) throw new Error('Division by zero');
    return a / b;
}" > src.js
git add src.js
git commit -m "add divide with error handling"

echo "# Advanced Git Project
A project for mastering Git rebase techniques.

## Features
- Basic arithmetic operations
- Error handling for edge cases" > README.md
git add README.md
git commit -m "update readme"

echo "function hello() {
    return 'Hello, World!';
}

function add(a, b) {
    return a + b;
}

function subtract(a, b) {
    return a - b;
}

function multiply(a, b) {
    return a * b;
}

function divide(a, b) {
    if (b === 0) throw new Error('Division by zero');
    return a / b;
}

// TODO: Add more functions" > src.js
git add src.js
git commit -m "add todo comment"

# View the messy history
git log --oneline
```

**Expected Output:**
```
a1b2c3d add todo comment
e4f5g6h update readme
i7j8k9l add divide with error handling
m1n2o3p WIP
q4r5s6t oops forgot subtract
u7v8w9x add function
y1z2a3b feat: initial project setup
```

### Interactive Rebase Cleanup

**Step 2: Clean Up History**
```bash
# Start interactive rebase for last 6 commits
git rebase -i HEAD~6
```

**In the editor, change the commands:**
```
pick u7v8w9x add function
squash q4r5s6t oops forgot subtract
squash m1n2o3p WIP
reword i7j8k9l add divide with error handling
pick e4f5g6h update readme
drop a1b2c3d add todo comment
```

**For the reword commit, change message to:**
```
feat: implement arithmetic operations with error handling

- Add basic arithmetic functions (add, subtract, multiply, divide)
- Include proper error handling for division by zero
- Comprehensive function implementation
```

**For the squash commits, use this combined message:**
```
feat: implement basic arithmetic functions

- Add addition function
- Add subtraction function  
- Add multiplication function
```

**Step 3: Verify Clean History**
```bash
git log --oneline
```

**Expected Clean Output:**
```
x1y2z3a update readme
b4c5d6e feat: implement arithmetic operations with error handling
f7g8h9i feat: implement basic arithmetic functions
j1k2l3m feat: initial project setup
```

## 🔀 Part 2: Advanced Rebase Strategies

### Strategy 1: Rebase onto Different Base

**Step 1: Create Feature Branch**
```bash
git checkout -b feature/advanced-math

echo "function hello() {
    return 'Hello, World!';
}

function add(a, b) {
    return a + b;
}

function subtract(a, b) {
    return a - b;
}

function multiply(a, b) {
    return a * b;
}

function divide(a, b) {
    if (b === 0) throw new Error('Division by zero');
    return a / b;
}

function power(base, exponent) {
    return Math.pow(base, exponent);
}

function sqrt(number) {
    if (number < 0) throw new Error('Cannot calculate square root of negative number');
    return Math.sqrt(number);
}" > src.js

git add src.js
git commit -m "feat: add power and square root functions"

echo "function factorial(n) {
    if (n < 0) throw new Error('Factorial not defined for negative numbers');
    if (n === 0 || n === 1) return 1;
    return n * factorial(n - 1);
}" >> src.js

git add src.js
git commit -m "feat: add factorial function"
```

**Step 2: Meanwhile, Main Branch Evolves**
```bash
git checkout main

echo "# Advanced Git Project
A project for mastering Git rebase techniques.

## Features
- Basic arithmetic operations
- Error handling for edge cases
- Professional code structure

## Usage
\`\`\`javascript
const result = add(5, 3); // 8
const division = divide(10, 2); // 5
\`\`\`" > README.md

git add README.md
git commit -m "docs: add usage examples to README"

echo "// Test file for arithmetic operations
function runTests() {
    console.log('Testing add:', add(2, 3) === 5);
    console.log('Testing subtract:', subtract(5, 2) === 3);
    console.log('Testing multiply:', multiply(4, 3) === 12);
    console.log('Testing divide:', divide(10, 2) === 5);
}

runTests();" > test.js

git add test.js
git commit -m "test: add basic test suite"
```

**Step 3: Rebase Feature onto Updated Main**
```bash
git checkout feature/advanced-math

# View current state
git log --oneline --graph --all

# Rebase onto updated main
git rebase main

# Resolve any conflicts if they occur
# View the result
git log --oneline --graph --all
```

### Strategy 2: Interactive Rebase with Exec

**Step 4: Add Testing to Rebase**
```bash
# Add a commit that should be tested
echo "function fibonacci(n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}" >> src.js

git add src.js
git commit -m "feat: add fibonacci function"

# Interactive rebase with automatic testing
git rebase -i HEAD~3 --exec "node test.js"
```

**In the editor:**
```
pick <hash> feat: add power and square root functions
exec node test.js
pick <hash> feat: add factorial function
exec node test.js
pick <hash> feat: add fibonacci function
exec node test.js
```

## ⚔️ Part 3: Handling Rebase Conflicts

### Scenario: Complex Conflict Resolution

**Step 1: Create Conflicting Changes**
```bash
git checkout main

# Main branch changes
echo "function hello() {
    return 'Hello, Advanced World!';
}

function add(a, b) {
    // Enhanced addition with type checking
    if (typeof a !== 'number' || typeof b !== 'number') {
        throw new Error('Arguments must be numbers');
    }
    return a + b;
}

function subtract(a, b) {
    if (typeof a !== 'number' || typeof b !== 'number') {
        throw new Error('Arguments must be numbers');
    }
    return a - b;
}

function multiply(a, b) {
    if (typeof a !== 'number' || typeof b !== 'number') {
        throw new Error('Arguments must be numbers');
    }
    return a * b;
}

function divide(a, b) {
    if (typeof a !== 'number' || typeof b !== 'number') {
        throw new Error('Arguments must be numbers');
    }
    if (b === 0) throw new Error('Division by zero');
    return a / b;
}" > src.js

git add src.js
git commit -m "feat: add type checking to all functions"

# Create feature branch with different changes
git checkout -b feature/validation

echo "function hello() {
    return 'Hello, Validated World!';
}

function add(a, b) {
    // Input validation
    a = Number(a);
    b = Number(b);
    if (isNaN(a) || isNaN(b)) {
        throw new Error('Invalid input: cannot convert to number');
    }
    return a + b;
}

function subtract(a, b) {
    a = Number(a);
    b = Number(b);
    if (isNaN(a) || isNaN(b)) {
        throw new Error('Invalid input: cannot convert to number');
    }
    return a - b;
}

function multiply(a, b) {
    a = Number(a);
    b = Number(b);
    if (isNaN(a) || isNaN(b)) {
        throw new Error('Invalid input: cannot convert to number');
    }
    return a * b;
}

function divide(a, b) {
    a = Number(a);
    b = Number(b);
    if (isNaN(a) || isNaN(b)) {
        throw new Error('Invalid input: cannot convert to number');
    }
    if (b === 0) throw new Error('Division by zero');
    return a / b;
}" > src.js

git add src.js
git commit -m "feat: add input validation with type conversion"
```

**Step 2: Rebase with Conflicts**
```bash
# This will create conflicts
git rebase main
```

**Expected Conflict:**
```
Auto-merging src.js
CONFLICT (content): Merge conflict in src.js
error: could not apply abc1234... feat: add input validation with type conversion
```

**Step 3: Resolve Conflicts Strategically**
```bash
# View the conflict
git status
cat src.js

# Choose the best approach from both versions
echo "function hello() {
    return 'Hello, Advanced Validated World!';
}

function add(a, b) {
    // Combined approach: type checking + conversion
    if (typeof a !== 'number') {
        a = Number(a);
        if (isNaN(a)) throw new Error('First argument cannot be converted to number');
    }
    if (typeof b !== 'number') {
        b = Number(b);
        if (isNaN(b)) throw new Error('Second argument cannot be converted to number');
    }
    return a + b;
}

function subtract(a, b) {
    if (typeof a !== 'number') {
        a = Number(a);
        if (isNaN(a)) throw new Error('First argument cannot be converted to number');
    }
    if (typeof b !== 'number') {
        b = Number(b);
        if (isNaN(b)) throw new Error('Second argument cannot be converted to number');
    }
    return a - b;
}

function multiply(a, b) {
    if (typeof a !== 'number') {
        a = Number(a);
        if (isNaN(a)) throw new Error('First argument cannot be converted to number');
    }
    if (typeof b !== 'number') {
        b = Number(b);
        if (isNaN(b)) throw new Error('Second argument cannot be converted to number');
    }
    return a * b;
}

function divide(a, b) {
    if (typeof a !== 'number') {
        a = Number(a);
        if (isNaN(a)) throw new Error('First argument cannot be converted to number');
    }
    if (typeof b !== 'number') {
        b = Number(b);
        if (isNaN(b)) throw new Error('Second argument cannot be converted to number');
    }
    if (b === 0) throw new Error('Division by zero');
    return a / b;
}" > src.js

git add src.js
git rebase --continue
```

## 🔧 Part 4: Advanced Rebase Techniques

### Technique 1: Splitting Commits

**Step 1: Create Commit to Split**
```bash
echo "// Utility functions
function isNumber(value) {
    return typeof value === 'number' && !isNaN(value);
}

function validateNumber(value, paramName) {
    if (typeof value !== 'number') {
        value = Number(value);
        if (isNaN(value)) {
            throw new Error(\`\${paramName} cannot be converted to number\`);
        }
    }
    return value;
}

// Logging utility
function logOperation(operation, a, b, result) {
    console.log(\`\${operation}(\${a}, \${b}) = \${result}\`);
}" >> src.js

git add src.js
git commit -m "feat: add utility functions and logging"
```

**Step 2: Split the Commit**
```bash
# Start interactive rebase
git rebase -i HEAD~1

# Change 'pick' to 'edit' for the commit to split
# When rebase pauses, reset the commit but keep changes
git reset HEAD~1

# Stage and commit utilities separately
echo "// Utility functions
function isNumber(value) {
    return typeof value === 'number' && !isNaN(value);
}

function validateNumber(value, paramName) {
    if (typeof value !== 'number') {
        value = Number(value);
        if (isNaN(value)) {
            throw new Error(\`\${paramName} cannot be converted to number\`);
        }
    }
    return value;
}" > utils.js

git add utils.js
git commit -m "feat: add number validation utilities"

# Commit logging separately
echo "// Logging utility
function logOperation(operation, a, b, result) {
    console.log(\`\${operation}(\${a}, \${b}) = \${result}\`);
}" > logger.js

git add logger.js
git commit -m "feat: add operation logging utility"

# Continue rebase
git rebase --continue
```

### Technique 2: Reordering Commits

**Step 3: Create Commits in Wrong Order**
```bash
echo "// Configuration
const config = {
    enableLogging: true,
    precision: 2
};" > config.js

git add config.js
git commit -m "feat: add configuration system"

echo "// Enhanced calculator with config
function enhancedAdd(a, b) {
    a = validateNumber(a, 'first argument');
    b = validateNumber(b, 'second argument');
    const result = a + b;
    if (config.enableLogging) {
        logOperation('add', a, b, result);
    }
    return result;
}" >> src.js

git add src.js
git commit -m "feat: create enhanced calculator functions"

echo "// Tests for enhanced functions
function testEnhancedFunctions() {
    console.log('Testing enhanced add:', enhancedAdd('5', '3') === 8);
    console.log('Testing with config:', config.enableLogging);
}" > enhanced-test.js

git add enhanced-test.js
git commit -m "test: add tests for enhanced functions"
```

**Step 4: Reorder for Logical Flow**
```bash
# Interactive rebase to reorder
git rebase -i HEAD~3

# Reorder commits in the editor:
# 1. Configuration (should be first)
# 2. Enhanced functions (depends on config)  
# 3. Tests (should be last)
```

## 📊 Part 5: Rebase vs Merge Decision Matrix

### When to Use Rebase

**✅ Use Rebase When:**
- Working on private/feature branches
- Want linear, clean history
- Commits haven't been shared/pushed
- Preparing for code review
- Integrating latest changes from main

**❌ Don't Use Rebase When:**
- Commits are already pushed to shared repository
- Working on public/main branches
- Other developers are working on the same branch
- You want to preserve exact timing of integration
- Merge commits provide valuable context

### Practical Decision Tree

```bash
# Create decision helper script
echo "#!/bin/bash
# Rebase vs Merge Decision Helper

echo 'Git Integration Decision Helper'
echo '=============================='

read -p 'Are the commits already pushed to a shared repository? (y/n): ' pushed
if [[ \$pushed == 'y' ]]; then
    echo 'RECOMMENDATION: Use MERGE'
    echo 'Reason: Never rewrite shared history'
    exit 0
fi

read -p 'Are other developers working on this branch? (y/n): ' shared
if [[ \$shared == 'y' ]]; then
    echo 'RECOMMENDATION: Use MERGE'
    echo 'Reason: Avoid disrupting other developers'
    exit 0
fi

read -p 'Do you want a linear, clean history? (y/n): ' linear
if [[ \$linear == 'y' ]]; then
    echo 'RECOMMENDATION: Use REBASE'
    echo 'Reason: Creates clean, linear history'
else
    echo 'RECOMMENDATION: Use MERGE'
    echo 'Reason: Preserves branching context'
fi" > rebase-or-merge.sh

chmod +x rebase-or-merge.sh
git add rebase-or-merge.sh
git commit -m "tool: add rebase vs merge decision helper"
```

## 🚨 Part 6: Emergency Rebase Recovery

### Scenario: Rebase Gone Wrong

**Step 1: Simulate Rebase Disaster**
```bash
# Create some commits to mess up
echo "Important work 1" > important.txt
git add important.txt
git commit -m "important: critical feature 1"

echo "Important work 2" >> important.txt
git add important.txt
git commit -m "important: critical feature 2"

echo "Important work 3" >> important.txt
git add important.txt
git commit -m "important: critical feature 3"

# Note the current state
git log --oneline

# Simulate a bad interactive rebase (accidentally drop commits)
git rebase -i HEAD~3
# In editor, accidentally delete lines or mark as 'drop'
```

**Step 2: Recovery Using Reflog**
```bash
# Don't panic! Git keeps a safety net
git reflog

# Find the commit before the rebase
# Look for something like "HEAD@{1}: rebase -i (start)"
# The commit before that is your safe state

# Recover using reflog
git reset --hard HEAD@{4}  # Adjust number based on your reflog

# Verify recovery
git log --oneline
cat important.txt
```

**Step 3: Alternative Recovery Methods**
```bash
# If reflog doesn't help, try finding lost commits
git fsck --lost-found

# Look for dangling commits
git show <dangling-commit-hash>

# Create branch from recovered commit
git checkout -b recovery-branch <commit-hash>
```

## 🎯 Rebase Best Practices

### **Preparation**
1. **Always backup** important branches before rebasing
2. **Check working directory** is clean before starting
3. **Understand the history** you're about to change
4. **Communicate with team** about rebase plans

### **During Rebase**
1. **Read conflict messages** carefully
2. **Test after each conflict resolution**
3. **Use `git rebase --abort`** if things go wrong
4. **Keep commits focused** during interactive rebase

### **After Rebase**
1. **Test thoroughly** before pushing
2. **Force push carefully** with `--force-with-lease`
3. **Update team** about history changes
4. **Document** significant history rewrites

## 🔧 Advanced Rebase Commands

```bash
# Interactive rebase with different options
git rebase -i HEAD~5                    # Last 5 commits
git rebase -i --root                    # All commits from beginning
git rebase -i main                      # All commits since branching from main

# Rebase with automatic conflict resolution
git rebase -X ours main                 # Prefer our changes
git rebase -X theirs main               # Prefer their changes

# Rebase with exec (run command after each commit)
git rebase -i HEAD~3 --exec "npm test"

# Rebase onto different branch
git rebase --onto main feature~3 feature

# Continue/abort rebase
git rebase --continue                   # After resolving conflicts
git rebase --skip                       # Skip current commit
git rebase --abort                      # Cancel rebase

# Rebase with autosquash
git commit --fixup <commit-hash>        # Create fixup commit
git rebase -i --autosquash HEAD~5       # Automatically squash fixups
```

## 📈 Measuring Rebase Impact

```bash
# Compare before and after rebase
git log --oneline --graph main..feature    # Before rebase
git rebase main
git log --oneline --graph main..feature    # After rebase

# Check for lost commits
git log --walk-reflogs --oneline

# Verify no content was lost
git diff HEAD@{1} HEAD                      # Should be empty if only history changed
```

## 🚀 Next Steps

1. Practice interactive rebase on safe, local branches
2. Learn about [Git Hooks](../../templates/hooks/) for automated checks
3. Explore [Repository Optimization](repository-optimization.md)
4. Master [Advanced Merge Strategies](merge-strategies.md)

---

**Remember**: Rebase is a powerful tool for maintaining clean history, but with great power comes great responsibility. Always prioritize team collaboration over perfect history.

**Next Exercise**: [Repository Optimization →](repository-optimization.md)
