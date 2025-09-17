# 🎨 Git Workflow Diagrams (ASCII Art)

Visual representations of Git workflows using ASCII art for universal compatibility.

## 🔄 Basic Git Workflow

```
Working Directory → Staging Area → Repository → Remote
      ↓               ↓             ↓          ↓
   [Files]         [Index]      [Commits]   [Origin]
      ↓               ↓             ↓          ↓
   git add         git add     git commit   git push
      ↓               ↓             ↓          ↓
  ┌─────────┐   ┌─────────┐   ┌─────────┐ ┌─────────┐
  │ file.js │──→│ file.js │──→│ commit  │→│ commit  │
  │ (mod)   │   │ (staged)│   │ abc123  │ │ abc123  │
  └─────────┘   └─────────┘   └─────────┘ └─────────┘
```

## 🌿 Git Branching Model

```
                    Feature Branch Workflow
                    
main     A───B───C───F───G───H
              \     /       /
feature        D───E       /
                          /
hotfix                   I
                        /
                       
Legend:
A,B,C,F,G,H,I = Commits
───           = Linear progression  
\             = Branch creation
/             = Merge back
```

## 🔀 Merge vs Rebase

### Merge Strategy
```
Before Merge:
main     A───B───C
              \
feature        D───E

After Merge:
main     A───B───C───F
              \     /
feature        D───E

Result: Preserves branch history with merge commit F
```

### Rebase Strategy
```
Before Rebase:
main     A───B───C
              \
feature        D───E

After Rebase:
main     A───B───C───D'───E'

Result: Linear history, commits D' and E' are new
```

## 🔄 GitFlow Workflow

```
                    GitFlow Branching Model
                    
main        A───────────F───────────L
            │           │           │
            │           │           │
develop     │   B───C───D───G───H───I───J───K
            │   │       │   │       │       │
            │   │       │   │       │       │
feature     │   │       │   │   ────M───N───│
            │   │       │   │  /            │
            │   │       │   │ /             │
release     │   │       │   E               │
            │   │       │  /│               │
            │   │       │ / │               │
hotfix      │   │       │/  │           ────O
            │   │       │   │          /    │
            │   │       │   │         /     │
            └───┴───────┴───┴────────┴──────┘

Legend:
main    = Production releases
develop = Integration branch  
feature = Feature development
release = Release preparation
hotfix  = Emergency fixes
```

## 🚀 GitHub Flow

```
                    GitHub Flow (Simplified)
                    
main        A───B───C───────F───G
                 \         /
feature           D───E───/

Steps:
1. Create feature branch from main
2. Make commits on feature branch  
3. Open Pull Request
4. Code review and discussion
5. Merge to main
6. Deploy from main
```

## 🔧 Git Commands Flow

```
                    Git Command Relationships
                    
┌─────────────┐    git add     ┌─────────────┐    git commit    ┌─────────────┐
│  Working    │───────────────→│   Staging   │─────────────────→│ Repository  │
│ Directory   │                │    Area     │                  │  (.git)     │
└─────────────┘                └─────────────┘                  └─────────────┘
       ↑                              ↑                               ↑
       │                              │                               │
       │ git checkout               git reset                    git reset --hard
       │                              │                               │
       └──────────────────────────────┴───────────────────────────────┘
       
Additional Commands:
- git status    : Show state of working directory and staging area
- git diff      : Show changes between working directory and staging
- git diff --staged : Show changes between staging and repository
- git log       : Show commit history
```

## 📊 Git Object Model

```
                    Git Object Relationships
                    
Repository
├── Objects
│   ├── Commits ──→ Tree ──→ Blob (file content)
│   │     │           │
│   │     │           └──→ Blob (file content)  
│   │     │
│   │     └──→ Parent Commit ──→ Tree ──→ Blob
│   │
│   └── Tags ──→ Commit
│
├── References
│   ├── Heads (branches)
│   │   ├── main ──→ Commit ABC123
│   │   └── feature ──→ Commit DEF456
│   │
│   └── Remotes
│       └── origin/main ──→ Commit ABC123
│
└── HEAD ──→ refs/heads/main
```

## 🔄 Rebase Interactive Process

```
                    Interactive Rebase Flow
                    
Original History:
A───B───C───D───E───F (HEAD)

Interactive Rebase Command: git rebase -i HEAD~4

Editor Opens:
┌─────────────────────────────────────┐
│ pick C commit message C             │
│ squash D commit message D           │  
│ reword E commit message E           │
│ drop F commit message F             │
└─────────────────────────────────────┘

Result:
A───B───C'───E' (HEAD)

Where:
- C' = C + D (squashed)
- E' = E with new message
- F = dropped (removed)
```

## 🌐 Remote Repository Sync

```
                    Remote Synchronization
                    
Local Repository              Remote Repository (origin)
┌─────────────────┐          ┌─────────────────┐
│ main: A─B─C─D   │          │ main: A─B─C     │
│                 │          │                 │
│ origin/main: A─B─C         │                 │
└─────────────────┘          └─────────────────┘
         │                            ↑
         │        git push             │
         └────────────────────────────┘

After Push:
Local Repository              Remote Repository (origin)  
┌─────────────────┐          ┌─────────────────┐
│ main: A─B─C─D   │          │ main: A─B─C─D   │
│                 │          │                 │
│ origin/main: A─B─C─D       │                 │
└─────────────────┘          └─────────────────┘
```

## 🔀 Merge Conflict Resolution

```
                    Merge Conflict Process
                    
Step 1: Attempt Merge
main     A───B───C
              \
feature        D───E (conflicts with C)

Step 2: Git Detects Conflict
┌─────────────────────────────────────┐
│ <<<<<<< HEAD                        │
│ Content from main branch            │
│ =======                             │  
│ Content from feature branch         │
│ >>>>>>> feature                     │
└─────────────────────────────────────┘

Step 3: Manual Resolution
┌─────────────────────────────────────┐
│ Resolved content combining both     │
│ branches appropriately              │
└─────────────────────────────────────┘

Step 4: Complete Merge
main     A───B───C───F
              \     /
feature        D───E

Where F is the merge commit
```

## 📈 Git Workflow Complexity Levels

```
                    Workflow Complexity Scale
                    
Simple ────────────────────────────────────────→ Complex

Level 1: Personal Projects
main ───A───B───C───D

Level 2: Small Team
main     A───B───E───F
          \     /
feature    C───D

Level 3: Medium Team (GitFlow)
main        A───────F───────K
develop     │   B───C───G───H───I───J
feature     │       │   │       │
            │       D───E       │
release     │               ────│
hotfix      └───────────────────L

Level 4: Large Organization
main        A─────────────F─────────────M
develop     │   B─────────C─────────────D
feature/a   │   │     E───│─────────────│
feature/b   │   │         │   G─────────H
release     │   │         │       │     │
hotfix      │   │         │       │     │
integration │   │         │       │     │
staging     │   │         │       │     │
```

## 🎯 Decision Trees

### When to Branch?
```
Need to work on something new?
├─ Yes → Is it experimental?
│   ├─ Yes → Create feature branch
│   └─ No → Is it a bug fix?
│       ├─ Yes → Create bugfix branch
│       └─ No → Create feature branch
└─ No → Work on main (small changes only)
```

### Merge vs Rebase?
```
Ready to integrate changes?
├─ Is branch shared with others?
│   ├─ Yes → Use merge
│   └─ No → Want linear history?
│       ├─ Yes → Use rebase
│       └─ No → Use merge
└─ Not ready → Continue development
```

## 🛠️ Git Hook Workflow

```
                    Git Hooks Execution Flow
                    
Developer Action          Hook Triggered         Result
┌─────────────┐          ┌─────────────┐       ┌─────────────┐
│ git commit  │─────────→│ pre-commit  │──────→│ Allow/Block │
└─────────────┘          └─────────────┘       └─────────────┘
       │                        │                     │
       │                        ↓                     │
       │                 ┌─────────────┐              │
       │                 │ commit-msg  │              │
       │                 └─────────────┘              │
       │                        │                     │
       │                        ↓                     │
       │                 ┌─────────────┐              │
       └────────────────→│ post-commit │←─────────────┘
                         └─────────────┘

Hook Types:
- pre-commit: Run before commit (linting, tests)
- commit-msg: Validate commit message format  
- post-commit: Run after successful commit
- pre-push: Run before push (integration tests)
```

---

These ASCII diagrams provide visual understanding of Git concepts without requiring special software or image viewers. They can be viewed in any text editor or terminal.

**Usage Tips:**
- Copy these diagrams into documentation
- Use in presentations or training materials
- Modify for your specific workflow needs
- Share in text-based communications (chat, email)
