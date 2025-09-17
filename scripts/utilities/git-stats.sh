#!/bin/bash

# 📊 Git Repository Statistics Generator
# Comprehensive analysis and reporting for Git repositories

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_header() {
    echo -e "${PURPLE}📊 $1${NC}"
    echo "$(printf '=%.0s' $(seq 1 ${#1}))"
}

print_section() {
    echo -e "${BLUE}🔹 $1${NC}"
    echo "$(printf '-%.0s' $(seq 1 ${#1}))"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

# Check if we're in a Git repository
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${RED}❌ Not in a Git repository${NC}"
        exit 1
    fi
}

# Get repository information
get_repo_info() {
    print_header "Repository Information"
    
    local repo_path=$(git rev-parse --show-toplevel)
    local repo_name=$(basename "$repo_path")
    local current_branch=$(git branch --show-current)
    local remote_url=$(git remote get-url origin 2>/dev/null || echo "No remote configured")
    
    echo "Repository: $repo_name"
    echo "Path: $repo_path"
    echo "Current Branch: $current_branch"
    echo "Remote URL: $remote_url"
    echo
}

# Commit statistics
get_commit_stats() {
    print_section "Commit Statistics"
    
    local total_commits=$(git rev-list --all --count)
    local commits_this_week=$(git rev-list --since="1 week ago" --all --count)
    local commits_this_month=$(git rev-list --since="1 month ago" --all --count)
    local commits_this_year=$(git rev-list --since="1 year ago" --all --count)
    
    echo "Total Commits: $total_commits"
    echo "This Week: $commits_this_week"
    echo "This Month: $commits_this_month"
    echo "This Year: $commits_this_year"
    echo
    
    # First and last commit
    local first_commit=$(git log --reverse --format="%h %ci %s" | head -1)
    local last_commit=$(git log --format="%h %ci %s" -1)
    
    echo "First Commit: $first_commit"
    echo "Last Commit: $last_commit"
    echo
}

# Author statistics
get_author_stats() {
    print_section "Author Statistics"
    
    echo "Top 10 Contributors:"
    git shortlog -sn | head -10 | while read -r commits author; do
        printf "  %3d commits - %s\n" "$commits" "$author"
    done
    echo
    
    echo "Commits by Author (Last 30 Days):"
    git shortlog -sn --since="30 days ago" | head -5 | while read -r commits author; do
        printf "  %3d commits - %s\n" "$commits" "$author"
    done
    echo
}

# Branch statistics
get_branch_stats() {
    print_section "Branch Statistics"
    
    local local_branches=$(git branch | wc -l)
    local remote_branches=$(git branch -r | grep -v "HEAD" | wc -l)
    local total_branches=$((local_branches + remote_branches))
    
    echo "Local Branches: $local_branches"
    echo "Remote Branches: $remote_branches"
    echo "Total Branches: $total_branches"
    echo
    
    echo "Recent Branches (by last commit):"
    git for-each-ref --format='%(refname:short) %(committerdate:relative)' refs/heads/ | \
    sort -k2 | head -10 | while read -r branch date rest; do
        printf "  %-20s %s %s\n" "$branch" "$date" "$rest"
    done
    echo
}

# File statistics
get_file_stats() {
    print_section "File Statistics"
    
    local total_files=$(git ls-files | wc -l)
    local tracked_files=$(git ls-files | wc -l)
    local untracked_files=$(git ls-files --others --exclude-standard | wc -l)
    
    echo "Tracked Files: $tracked_files"
    echo "Untracked Files: $untracked_files"
    echo "Total Files: $total_files"
    echo
    
    echo "File Types:"
    git ls-files | sed 's/.*\.//' | sort | uniq -c | sort -nr | head -10 | \
    while read -r count ext; do
        printf "  %3d files - .%s\n" "$count" "$ext"
    done
    echo
    
    echo "Largest Files (tracked):"
    git ls-files | xargs -I {} find {} -type f -exec ls -la {} \; 2>/dev/null | \
    sort -k5 -nr | head -5 | while read -r perms links owner group size rest; do
        size_mb=$((size / 1024 / 1024))
        if [ $size_mb -gt 0 ]; then
            printf "  %3d MB - %s\n" "$size_mb" "$rest"
        else
            size_kb=$((size / 1024))
            printf "  %3d KB - %s\n" "$size_kb" "$rest"
        fi
    done
    echo
}

# Repository size and performance
get_repo_size() {
    print_section "Repository Size & Performance"
    
    local repo_size=$(du -sh .git | cut -f1)
    local working_tree_size=$(du -sh --exclude=.git . | cut -f1)
    
    echo "Repository (.git): $repo_size"
    echo "Working Tree: $working_tree_size"
    echo
    
    # Git object statistics
    echo "Git Objects:"
    git count-objects -v | while read -r key value; do
        case $key in
            "count") echo "  Loose Objects: $value" ;;
            "size") echo "  Loose Objects Size: ${value} KB" ;;
            "in-pack") echo "  Packed Objects: $value" ;;
            "size-pack") echo "  Pack Size: ${value} KB" ;;
            "prune-packable") echo "  Prune-packable: $value" ;;
            "garbage") echo "  Garbage: $value" ;;
        esac
    done
    echo
}

# Activity analysis
get_activity_analysis() {
    print_section "Activity Analysis"
    
    echo "Commits by Day of Week:"
    git log --format="%ad" --date=format:"%u" | sort | uniq -c | \
    while read -r count day; do
        case $day in
            1) day_name="Monday" ;;
            2) day_name="Tuesday" ;;
            3) day_name="Wednesday" ;;
            4) day_name="Thursday" ;;
            5) day_name="Friday" ;;
            6) day_name="Saturday" ;;
            7) day_name="Sunday" ;;
        esac
        printf "  %s: %d commits\n" "$day_name" "$count"
    done
    echo
    
    echo "Commits by Hour:"
    git log --format="%ad" --date=format:"%H" | sort -n | uniq -c | \
    while read -r count hour; do
        printf "  %02d:00 - %d commits\n" "$hour" "$count"
    done | head -10
    echo
}

# Code churn analysis
get_code_churn() {
    print_section "Code Churn Analysis"
    
    echo "Lines Added/Removed (Last 30 Days):"
    git log --since="30 days ago" --numstat --pretty=format:"" | \
    awk '{added+=$1; removed+=$2} END {printf "  Added: %d lines\n  Removed: %d lines\n  Net: %+d lines\n", added, removed, added-removed}'
    echo
    
    echo "Most Modified Files (Last 30 Days):"
    git log --since="30 days ago" --name-only --pretty=format:"" | \
    grep -v "^$" | sort | uniq -c | sort -nr | head -10 | \
    while read -r count file; do
        printf "  %3d changes - %s\n" "$count" "$file"
    done
    echo
}

# Tag and release information
get_tag_info() {
    print_section "Tags & Releases"
    
    local tag_count=$(git tag | wc -l)
    echo "Total Tags: $tag_count"
    
    if [ $tag_count -gt 0 ]; then
        echo
        echo "Recent Tags:"
        git tag --sort=-version:refname | head -5 | while read -r tag; do
            local tag_date=$(git log -1 --format="%ci" "$tag" 2>/dev/null || echo "Unknown date")
            echo "  $tag ($tag_date)"
        done
        echo
        
        echo "Latest Release:"
        local latest_tag=$(git tag --sort=-version:refname | head -1)
        if [ -n "$latest_tag" ]; then
            local commits_since=$(git rev-list "$latest_tag"..HEAD --count)
            echo "  Tag: $latest_tag"
            echo "  Commits Since: $commits_since"
        fi
    fi
    echo
}

# Health check
get_health_check() {
    print_section "Repository Health Check"
    
    # Check for issues
    local issues=0
    
    # Check for large files
    local large_files=$(git ls-files | xargs -I {} find {} -type f -size +10M 2>/dev/null | wc -l)
    if [ $large_files -gt 0 ]; then
        print_warning "Found $large_files files larger than 10MB"
        ((issues++))
    else
        print_success "No large files detected"
    fi
    
    # Check for binary files in Git
    local binary_files=$(git ls-files | xargs -I {} file {} 2>/dev/null | grep -v "text" | wc -l)
    if [ $binary_files -gt 10 ]; then
        print_warning "Found $binary_files binary files (consider Git LFS)"
        ((issues++))
    else
        print_success "Binary file count is reasonable"
    fi
    
    # Check repository integrity
    if git fsck --quiet 2>/dev/null; then
        print_success "Repository integrity check passed"
    else
        print_warning "Repository integrity issues detected"
        ((issues++))
    fi
    
    # Check for uncommitted changes
    if git diff-index --quiet HEAD --; then
        print_success "Working directory is clean"
    else
        print_info "Working directory has uncommitted changes"
    fi
    
    # Check for untracked files
    local untracked=$(git ls-files --others --exclude-standard | wc -l)
    if [ $untracked -gt 0 ]; then
        print_info "Found $untracked untracked files"
    else
        print_success "No untracked files"
    fi
    
    echo
    if [ $issues -eq 0 ]; then
        print_success "Repository health: EXCELLENT"
    elif [ $issues -le 2 ]; then
        print_warning "Repository health: GOOD (minor issues)"
    else
        print_warning "Repository health: NEEDS ATTENTION"
    fi
    echo
}

# Generate recommendations
get_recommendations() {
    print_section "Recommendations"
    
    local repo_size_mb=$(du -sm .git | cut -f1)
    local commit_count=$(git rev-list --all --count)
    local branch_count=$(git branch -a | wc -l)
    
    # Size recommendations
    if [ $repo_size_mb -gt 100 ]; then
        echo "🔧 Repository is large (${repo_size_mb}MB). Consider:"
        echo "   - Running 'git gc --aggressive'"
        echo "   - Using Git LFS for large files"
        echo "   - Cleaning up old branches"
    fi
    
    # Branch recommendations
    if [ $branch_count -gt 20 ]; then
        echo "🌿 Many branches detected ($branch_count). Consider:"
        echo "   - Cleaning up merged branches"
        echo "   - Implementing branch cleanup policies"
    fi
    
    # Commit recommendations
    local avg_commits_per_day=$((commit_count / 30))
    if [ $avg_commits_per_day -gt 10 ]; then
        echo "📝 High commit frequency. Consider:"
        echo "   - Squashing related commits"
        echo "   - Using conventional commit messages"
    fi
    
    # General recommendations
    echo "💡 General recommendations:"
    echo "   - Run 'git gc' regularly for performance"
    echo "   - Use .gitignore for build artifacts"
    echo "   - Tag releases for better tracking"
    echo "   - Set up Git hooks for quality control"
    echo
}

# Export data to JSON
export_json() {
    local output_file="git-stats-$(date +%Y%m%d-%H%M%S).json"
    
    print_section "Exporting Data"
    
    {
        echo "{"
        echo "  \"repository\": {"
        echo "    \"name\": \"$(basename "$(git rev-parse --show-toplevel)")\","
        echo "    \"path\": \"$(git rev-parse --show-toplevel)\","
        echo "    \"current_branch\": \"$(git branch --show-current)\","
        echo "    \"remote_url\": \"$(git remote get-url origin 2>/dev/null || echo 'none')\""
        echo "  },"
        echo "  \"commits\": {"
        echo "    \"total\": $(git rev-list --all --count),"
        echo "    \"this_week\": $(git rev-list --since='1 week ago' --all --count),"
        echo "    \"this_month\": $(git rev-list --since='1 month ago' --all --count),"
        echo "    \"this_year\": $(git rev-list --since='1 year ago' --all --count)"
        echo "  },"
        echo "  \"branches\": {"
        echo "    \"local\": $(git branch | wc -l),"
        echo "    \"remote\": $(git branch -r | grep -v 'HEAD' | wc -l)"
        echo "  },"
        echo "  \"files\": {"
        echo "    \"tracked\": $(git ls-files | wc -l),"
        echo "    \"untracked\": $(git ls-files --others --exclude-standard | wc -l)"
        echo "  },"
        echo "  \"size\": {"
        echo "    \"repository_mb\": $(du -sm .git | cut -f1),"
        echo "    \"working_tree_mb\": $(du -sm --exclude=.git . | cut -f1)"
        echo "  },"
        echo "  \"generated_at\": \"$(date -Iseconds)\""
        echo "}"
    } > "$output_file"
    
    print_success "Data exported to: $output_file"
    echo
}

# Show help
show_help() {
    echo "📊 Git Repository Statistics Generator"
    echo "====================================="
    echo
    echo "Usage: $0 [options]"
    echo
    echo "Options:"
    echo "  --basic         Show basic statistics only"
    echo "  --detailed      Show detailed analysis (default)"
    echo "  --export        Export data to JSON file"
    echo "  --health        Show health check only"
    echo "  --authors       Show author statistics only"
    echo "  --activity      Show activity analysis only"
    echo "  --help          Show this help message"
    echo
    echo "Examples:"
    echo "  $0              # Full detailed report"
    echo "  $0 --basic      # Quick overview"
    echo "  $0 --export     # Generate JSON export"
    echo "  $0 --health     # Repository health check"
}

# Main function
main() {
    check_git_repo
    
    case "${1:-detailed}" in
        "--basic")
            get_repo_info
            get_commit_stats
            get_branch_stats
            get_health_check
            ;;
        "--detailed"|"")
            get_repo_info
            get_commit_stats
            get_author_stats
            get_branch_stats
            get_file_stats
            get_repo_size
            get_activity_analysis
            get_code_churn
            get_tag_info
            get_health_check
            get_recommendations
            ;;
        "--export")
            export_json
            ;;
        "--health")
            get_repo_info
            get_health_check
            ;;
        "--authors")
            get_repo_info
            get_author_stats
            ;;
        "--activity")
            get_repo_info
            get_activity_analysis
            get_code_churn
            ;;
        "--help"|"-h")
            show_help
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
