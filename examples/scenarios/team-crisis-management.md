# 👥 Team Git Crisis Management - Emergency Protocols

Comprehensive procedures for handling Git emergencies that affect entire development teams.

## 🚨 **TEAM EMERGENCY RESPONSE MATRIX**

| Crisis Level | Response Time | Team Involvement | Escalation |
|--------------|---------------|------------------|------------|
| **🟢 Level 1** | < 30 minutes | Individual developer | Team lead notification |
| **🟡 Level 2** | < 15 minutes | Team lead + affected developers | Manager notification |
| **🔴 Level 3** | < 5 minutes | All hands, stop all work | Executive escalation |

---

## 🔥 **Crisis Level 3: Production Repository Disaster**

### **Scenario: Main Branch Corrupted During Release**

#### **Immediate Response (0-5 minutes)**

**🚨 INCIDENT COMMANDER ACTIONS:**
```bash
# 1. STOP ALL DEVELOPMENT IMMEDIATELY
echo "🚨 PRODUCTION GIT EMERGENCY - ALL STOP 🚨" | slack-notify

# 2. Assess the damage
git fsck --full --strict > crisis-assessment.txt 2>&1
git log --oneline -10 > recent-commits.txt

# 3. Create emergency backup
cp -r .git .git.CRISIS-BACKUP-$(date +%Y%m%d-%H%M%S)

# 4. Document the crisis
echo "CRISIS LOG - $(date)" > crisis-log.txt
echo "Incident: Main branch corruption during release" >> crisis-log.txt
echo "Discovered by: $(git config user.name)" >> crisis-log.txt
echo "Last known good commit: $(git log --oneline -1)" >> crisis-log.txt
```

**📢 TEAM COMMUNICATION:**
```bash
# Immediate team notification
cat << 'EOF' | send-to-team
🚨 CRITICAL GIT EMERGENCY 🚨

STOP ALL GIT OPERATIONS IMMEDIATELY

- Main branch may be corrupted
- Do NOT push any changes
- Do NOT pull from origin
- Join emergency call: [LINK]
- Incident commander: [NAME]

Status updates in #emergency channel
EOF
```

#### **Recovery Phase (5-30 minutes)**

**Step 1: Team Coordination**
```bash
# Gather team status
echo "Team Status Check - Respond ASAP:" | slack-notify
echo "1. Are you currently working on any branches?"
echo "2. Do you have uncommitted changes?"
echo "3. When did you last pull from main?"
echo "4. Do you have local backups?"
```

**Step 2: Identify Clean Repository**
```bash
# Find team member with cleanest repository
for dev in alice bob charlie diana; do
    echo "Checking $dev's repository status..."
    ssh $dev "cd /path/to/project && git fsck --quiet && echo 'CLEAN' || echo 'ISSUES'"
done

# Use the cleanest repository as source of truth
CLEAN_REPO_OWNER="alice"
echo "Using $CLEAN_REPO_OWNER's repository as recovery source"
```

**Step 3: Emergency Recovery**
```bash
# Create new clean remote repository
git clone --bare ssh://$CLEAN_REPO_OWNER/path/to/clean/repo emergency-clean.git

# Update all team members
cat << 'EOF' | send-to-team
RECOVERY PROCEDURE:

1. Backup your current work:
   git stash push -m "EMERGENCY_BACKUP_$(date +%H%M%S)"

2. Add emergency remote:
   git remote add emergency-clean [EMERGENCY_REPO_URL]

3. Fetch clean data:
   git fetch emergency-clean

4. Reset main branch:
   git checkout main
   git reset --hard emergency-clean/main

5. Verify integrity:
   git fsck --full

6. Report status in #emergency channel
EOF
```

---

## ⚡ **Crisis Level 2: Team Workflow Disruption**

### **Scenario: Massive Merge Conflict Affecting Multiple Developers**

#### **Immediate Response (0-15 minutes)**

**🎯 TEAM LEAD ACTIONS:**
```bash
# 1. Identify scope of conflict
git log --merges --oneline -10
git status
git diff --name-only

# 2. Create conflict analysis
echo "MERGE CONFLICT ANALYSIS - $(date)" > conflict-analysis.txt
echo "Affected files:" >> conflict-analysis.txt
git diff --name-only >> conflict-analysis.txt
echo -e "\nConflict details:" >> conflict-analysis.txt
git status >> conflict-analysis.txt

# 3. Notify affected team members
git log --pretty=format:"%an %ae" --since="1 day ago" | sort -u > affected-developers.txt
```

**📋 COORDINATION PROTOCOL:**
```bash
# Create coordination branch
git checkout -b conflict-resolution-$(date +%Y%m%d-%H%M%S)

# Assign conflict resolution tasks
cat << 'EOF' > conflict-assignments.md
# Merge Conflict Resolution Assignments

## Files by Developer Expertise:
- frontend/: @alice @bob
- backend/: @charlie @diana  
- database/: @charlie
- tests/: @diana

## Resolution Protocol:
1. Each developer handles their expertise area
2. Coordinate in #conflict-resolution channel
3. Test changes before committing
4. Final integration by team lead
EOF
```

#### **Coordinated Resolution (15-60 minutes)**

**Step 1: Parallel Resolution**
```bash
# Each developer works on assigned files
# Alice handles frontend conflicts:
git checkout --ours frontend/
git add frontend/
git status

# Charlie handles backend conflicts:
git checkout --theirs backend/api/
git add backend/api/
# Manual resolution for complex conflicts
```

**Step 2: Integration Testing**
```bash
# Create integration test branch
git checkout -b integration-test-$(date +%H%M%S)

# Merge all resolved changes
git merge conflict-resolution-branch

# Run comprehensive tests
npm test
npm run integration-tests
npm run e2e-tests

# Verify build
npm run build
```

**Step 3: Team Validation**
```bash
# Each team member validates their area
for dev in alice bob charlie diana; do
    echo "$dev: Please validate your changes in integration-test branch"
    echo "Run: git checkout integration-test-$(date +%H%M%S)"
    echo "Test your functionality and report status"
done
```

---

## 🟡 **Crisis Level 1: Individual Developer Emergency**

### **Scenario: Developer Accidentally Destroyed Local Work**

#### **Self-Recovery Protocol (0-30 minutes)**

**Step 1: Immediate Assessment**
```bash
# Don't panic - assess the situation
git status
git reflog | head -20
git stash list

# Check for recent backups
ls -la .git/BACKUP* 2>/dev/null || echo "No local backups found"

# Document the issue
echo "RECOVERY LOG - $(date)" > recovery-log.txt
echo "Issue: Accidentally destroyed local work" >> recovery-log.txt
echo "Last known good state: [DESCRIBE]" >> recovery-log.txt
```

**Step 2: Recovery Attempts**
```bash
# Try reflog recovery
git reflog | grep -E "(commit|checkout|merge)" | head -10

# Attempt to recover from reflog
git checkout HEAD@{5}  # Adjust based on reflog
git checkout -b recovery-attempt-$(date +%H%M%S)

# Check if this recovered the work
git log --oneline -5
git status
```

**Step 3: Team Assistance Request**
```bash
# If self-recovery fails, request team help
cat << 'EOF' | send-to-team-lead
🆘 Need Git Recovery Assistance

Developer: $(git config user.name)
Issue: Lost local work after [DESCRIBE WHAT HAPPENED]
Branch: [BRANCH_NAME]
Last known good commit: [COMMIT_HASH if known]
Recovery attempts: [LIST WHAT YOU TRIED]

Available for pair debugging: [TIME_AVAILABILITY]
Priority: [LOW/MEDIUM/HIGH]
EOF
```

---

## 🛠️ **Team Crisis Prevention & Preparedness**

### **Daily Prevention Protocols**

#### **Morning Team Sync**
```bash
#!/bin/bash
# team-sync-check.sh - Run daily before standup

echo "🌅 Daily Team Git Health Check"
echo "=============================="

# Check repository health
git fsck --quiet && echo "✅ Repository integrity: OK" || echo "❌ Repository integrity: ISSUES"

# Check for uncommitted work
if git diff-index --quiet HEAD --; then
    echo "✅ Working directory: Clean"
else
    echo "⚠️ Working directory: Uncommitted changes"
    git status --porcelain
fi

# Check branch status
echo "📊 Branch Status:"
git branch -v

# Check remote sync status
echo "🌐 Remote Sync Status:"
git fetch --dry-run 2>&1 | head -5

# Check for large files
echo "📦 Large Files Check:"
find . -size +10M -not -path "./.git/*" | head -5 || echo "No large files found"

echo "✅ Daily check complete"
```

#### **Weekly Team Backup**
```bash
#!/bin/bash
# weekly-team-backup.sh

BACKUP_DIR="/shared/git-backups/$(date +%Y-%U)"
mkdir -p "$BACKUP_DIR"

# Create team backup bundle
git bundle create "$BACKUP_DIR/$(basename $(pwd))-$(date +%Y%m%d).bundle" --all

# Backup critical branches
for branch in main develop release; do
    if git show-ref --verify --quiet refs/heads/$branch; then
        git archive --format=tar.gz --prefix="${branch}/" $branch > "$BACKUP_DIR/${branch}-$(date +%Y%m%d).tar.gz"
    fi
done

echo "✅ Weekly backup completed: $BACKUP_DIR"
```

### **Emergency Response Kit**

#### **Crisis Communication Templates**

**Template 1: Initial Crisis Alert**
```
🚨 GIT EMERGENCY ALERT 🚨

Severity: [LEVEL 1/2/3]
Incident: [BRIEF DESCRIPTION]
Affected: [SCOPE - individual/team/production]
Incident Commander: [NAME]
Started: [TIME]

IMMEDIATE ACTIONS:
- [ACTION 1]
- [ACTION 2]
- [ACTION 3]

Updates: #emergency-channel
Call: [CONFERENCE_LINK]
```

**Template 2: Status Update**
```
📊 CRISIS UPDATE #[NUMBER]

Time: [TIMESTAMP]
Status: [INVESTIGATING/RESOLVING/RESOLVED]
Progress: [DESCRIPTION]

Completed:
- [COMPLETED ACTION 1]
- [COMPLETED ACTION 2]

Next Steps:
- [NEXT ACTION 1]
- [NEXT ACTION 2]

ETA: [ESTIMATED RESOLUTION TIME]
```

**Template 3: Resolution Notice**
```
✅ CRISIS RESOLVED

Incident: [DESCRIPTION]
Duration: [START_TIME] - [END_TIME]
Root Cause: [BRIEF EXPLANATION]

Resolution:
- [RESOLUTION STEP 1]
- [RESOLUTION STEP 2]

Prevention:
- [PREVENTION MEASURE 1]
- [PREVENTION MEASURE 2]

Post-Mortem: [SCHEDULED_TIME]
```

### **Team Recovery Procedures**

#### **Repository Synchronization Protocol**
```bash
#!/bin/bash
# team-sync-recovery.sh

echo "🔄 Team Repository Synchronization"
echo "=================================="

# Step 1: Identify authoritative source
echo "1. Checking remote repository health..."
git ls-remote --heads origin

# Step 2: Create team sync point
SYNC_BRANCH="team-sync-$(date +%Y%m%d-%H%M%S)"
git checkout -b "$SYNC_BRANCH"

# Step 3: Gather all team changes
echo "2. Gathering team member changes..."
for dev in alice bob charlie diana; do
    echo "Processing $dev's changes..."
    git remote add "$dev-remote" "ssh://$dev/path/to/repo" 2>/dev/null || true
    git fetch "$dev-remote" 2>/dev/null || echo "Could not fetch from $dev"
done

# Step 4: Create unified state
echo "3. Creating unified repository state..."
git merge-base --all HEAD > common-ancestors.txt

# Step 5: Validation
echo "4. Validating synchronized state..."
git fsck --full --strict

echo "✅ Team synchronization complete"
echo "Sync branch: $SYNC_BRANCH"
```

---

## 📊 **Crisis Management Metrics**

### **Response Time Tracking**
```bash
# crisis-metrics.sh
echo "Crisis Response Metrics" > crisis-metrics.txt
echo "======================" >> crisis-metrics.txt
echo "Detection Time: [TIME_TO_DETECT]" >> crisis-metrics.txt
echo "Response Time: [TIME_TO_RESPOND]" >> crisis-metrics.txt
echo "Resolution Time: [TIME_TO_RESOLVE]" >> crisis-metrics.txt
echo "Team Members Affected: [COUNT]" >> crisis-metrics.txt
echo "Commits Lost: [COUNT]" >> crisis-metrics.txt
echo "Commits Recovered: [COUNT]" >> crisis-metrics.txt
```

### **Post-Crisis Review Checklist**
- [ ] Root cause identified and documented
- [ ] Timeline of events recorded
- [ ] Team response effectiveness evaluated
- [ ] Prevention measures implemented
- [ ] Documentation updated
- [ ] Training needs identified
- [ ] Process improvements planned

---

## 🎯 **Team Crisis Preparedness Checklist**

### **Infrastructure Readiness**
- [ ] Emergency communication channels set up
- [ ] Backup repositories configured
- [ ] Recovery scripts tested and accessible
- [ ] Team contact information current
- [ ] Escalation procedures documented

### **Team Training**
- [ ] All team members trained on crisis procedures
- [ ] Regular crisis simulation exercises conducted
- [ ] Recovery tools and scripts familiar to team
- [ ] Roles and responsibilities clearly defined
- [ ] Communication protocols practiced

### **Documentation**
- [ ] Crisis response procedures documented
- [ ] Recovery scripts maintained and tested
- [ ] Team contact information up to date
- [ ] Escalation matrix current
- [ ] Post-mortem template prepared

---

**Remember**: The best crisis management is crisis prevention. Regular backups, good practices, and team training are your best defense against Git emergencies.

**Next**: [Repository Migration →](repository-migration.md)
