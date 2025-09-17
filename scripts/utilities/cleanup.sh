#!/bin/bash

# 🧹 Git Repository Cleanup Script
# Comprehensive repository maintenance and optimization

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_header() {
    echo -e "${PURPLE}🧹 $1${NC}"
    echo "$(printf '=%.0s' $(seq 1 ${#1}))"
}

# Check if we're in a Git repository
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a Git repository. Please run this script from within a Git repository."
        exit 1
    fi
}

# Show repository size before cleanup
show_repo_size() {
    local size_info
    size_info=$(git count-objects -vH 2>/dev/null || git count-objects -v)
    
    print_header "Repository Size Information"
    echo "$size_info"
    echo
}

# Clean up merged branches
cleanup_merged_branches() {
    print_header "Cleaning Up Merged Branches"
    
    local current_branch
    current_branch=$(git branch --show-current)
    
    # Get merged branches (excluding main, master, develop, and current)
    local merged_branches
    merged_branches=$(git branch --merged | grep -v "\*\|main\|master\|develop\|$current_branch" | sed 's/^[[:space:]]*//' | grep -v "^$" || true)
    
    if [ -z "$merged_branches" ]; then
        print_info "No merged branches to clean up"
        return 0
    fi
    
    print_info "Found merged branches:"
    echo "$merged_branches" | sed 's/^/  - /'
    echo
    
    if [ "$1" != "--auto" ]; then
        read -p "Delete these merged branches? (y/n): " confirm_delete
        if [[ $confirm_delete != "y" && $confirm_delete != "Y" ]]; then
            print_info "Skipping branch cleanup"
            return 0
        fi
    fi
    
    # Delete merged branches
    local deleted_count=0
    while IFS= read -r branch; do
        if [ -n "$branch" ]; then
            git branch -d "$branch" 2>/dev/null && {
                print_success "Deleted branch: $branch"
                ((deleted_count++))
            } || {
                print_warning "Could not delete branch: $branch"
            }
        fi
    done <<< "$merged_branches"
    
    print_success "Deleted $deleted_count merged branches"
}

# Clean up remote tracking branches
cleanup_remote_branches() {
    print_header "Cleaning Up Remote Tracking Branches"
    
    # Prune remote tracking branches
    git remote prune origin 2>/dev/null && {
        print_success "Pruned stale remote tracking branches"
    } || {
        print_info "No stale remote tracking branches found"
    }
    
    # Show remaining remote branches
    local remote_branches
    remote_branches=$(git branch -r | grep -v "HEAD" | wc -l)
    print_info "Remote tracking branches: $remote_branches"
}

# Clean up stashes
cleanup_stashes() {
    print_header "Cleaning Up Stashes"
    
    local stash_count
    stash_count=$(git stash list | wc -l)
    
    if [ "$stash_count" -eq 0 ]; then
        print_info "No stashes to clean up"
        return 0
    fi
    
    print_info "Found $stash_count stashes:"
    git stash list | head -10 | sed 's/^/  /'
    
    if [ "$stash_count" -gt 10 ]; then
        print_info "  ... and $((stash_count - 10)) more"
    fi
    echo
    
    if [ "$1" != "--auto" ]; then
        read -p "Clear all stashes? (y/n): " confirm_clear
        if [[ $confirm_clear != "y" && $confirm_clear != "Y" ]]; then
            print_info "Skipping stash cleanup"
            return 0
        fi
    fi
    
    git stash clear
    print_success "Cleared all stashes"
}

# Clean up reflog
cleanup_reflog() {
    print_header "Cleaning Up Reflog"
    
    # Expire reflog entries older than 30 days
    git reflog expire --expire=30.days refs/stash 2>/dev/null || true
    git reflog expire --expire-unreachable=30.days --all 2>/dev/null || true
    
    print_success "Cleaned up reflog entries older than 30 days"
}

# Remove untracked files
cleanup_untracked() {
    print_header "Cleaning Up Untracked Files"
    
    # Show what would be removed
    local untracked_files
    untracked_files=$(git clean -n -d 2>/dev/null || true)
    
    if [ -z "$untracked_files" ]; then
        print_info "No untracked files to clean up"
        return 0
    fi
    
    print_info "Untracked files and directories:"
    echo "$untracked_files" | sed 's/^/  /'
    echo
    
    if [ "$1" != "--auto" ]; then
        read -p "Remove these untracked files and directories? (y/n): " confirm_clean
        if [[ $confirm_clean != "y" && $confirm_clean != "Y" ]]; then
            print_info "Skipping untracked file cleanup"
            return 0
        fi
    fi
    
    git clean -f -d
    print_success "Removed untracked files and directories"
}

# Optimize repository
optimize_repo() {
    print_header "Optimizing Repository"
    
    print_info "Running garbage collection..."
    git gc --aggressive --prune=now
    print_success "Garbage collection completed"
    
    print_info "Repacking repository..."
    git repack -ad 2>/dev/null || true
    print_success "Repository repacked"
    
    print_info "Verifying repository integrity..."
    if git fsck --full --strict 2>/dev/null; then
        print_success "Repository integrity verified"
    else
        print_warning "Repository integrity check found issues (this may be normal)"
    fi
}

# Find and report large files
find_large_files() {
    print_header "Finding Large Files"
    
    print_info "Scanning for large files in repository history..."
    
    # Find large files in repository
    local large_files
    large_files=$(git rev-list --objects --all | \
        git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
        sed -n 's/^blob //p' | \
        sort --numeric-sort --key=2 | \
        tail -10 2>/dev/null || true)
    
    if [ -n "$large_files" ]; then
        print_warning "Top 10 largest files in repository:"
        echo "$large_files" | while read -r hash size path; do
            size_mb=$((size / 1024 / 1024))
            if [ "$size_mb" -gt 0 ]; then
                printf "  %3d MB  %s\n" "$size_mb" "$path"
            else
                size_kb=$((size / 1024))
                printf "  %3d KB  %s\n" "$size_kb" "$path"
            fi
        done
        echo
        print_info "Consider using Git LFS for files larger than 10MB"
    else
        print_success "No unusually large files found"
    fi
}

# Show cleanup summary
show_summary() {
    print_header "Cleanup Summary"
    
    # Show final repository size
    local size_info
    size_info=$(git count-objects -vH 2>/dev/null || git count-objects -v)
    
    echo "$size_info"
    echo
    
    # Show branch count
    local local_branches remote_branches
    local_branches=$(git branch | wc -l)
    remote_branches=$(git branch -r | grep -v "HEAD" | wc -l)
    
    print_info "Local branches: $local_branches"
    print_info "Remote tracking branches: $remote_branches"
    
    # Show stash count
    local stash_count
    stash_count=$(git stash list | wc -l)
    print_info "Stashes: $stash_count"
    
    print_success "Repository cleanup completed!"
}

# Show help
show_help() {
    echo "🧹 Git Repository Cleanup Script"
    echo "================================"
    echo
    echo "Usage: $0 [options]"
    echo
    echo "Options:"
    echo "  --auto          Run cleanup automatically without prompts"
    echo "  --branches      Clean up merged branches only"
    echo "  --remotes       Clean up remote tracking branches only"
    echo "  --stashes       Clean up stashes only"
    echo "  --untracked     Clean up untracked files only"
    echo "  --optimize      Optimize repository only"
    echo "  --large-files   Find large files only"
    echo "  --help          Show this help message"
    echo
    echo "Examples:"
    echo "  $0              # Interactive cleanup (recommended)"
    echo "  $0 --auto       # Automatic cleanup"
    echo "  $0 --branches   # Clean up branches only"
    echo "  $0 --optimize   # Optimize repository only"
}

# Main cleanup function
main_cleanup() {
    local auto_mode="$1"
    
    check_git_repo
    
    print_header "Git Repository Cleanup"
    print_info "Repository: $(basename "$(git rev-parse --show-toplevel)")"
    print_info "Current branch: $(git branch --show-current)"
    echo
    
    show_repo_size
    
    cleanup_merged_branches "$auto_mode"
    echo
    
    cleanup_remote_branches
    echo
    
    cleanup_stashes "$auto_mode"
    echo
    
    cleanup_reflog
    echo
    
    cleanup_untracked "$auto_mode"
    echo
    
    optimize_repo
    echo
    
    find_large_files
    echo
    
    show_summary
}

# Main script logic
case "${1:-}" in
    "--auto")
        main_cleanup "--auto"
        ;;
    "--branches")
        check_git_repo
        cleanup_merged_branches
        ;;
    "--remotes")
        check_git_repo
        cleanup_remote_branches
        ;;
    "--stashes")
        check_git_repo
        cleanup_stashes
        ;;
    "--untracked")
        check_git_repo
        cleanup_untracked
        ;;
    "--optimize")
        check_git_repo
        optimize_repo
        ;;
    "--large-files")
        check_git_repo
        find_large_files
        ;;
    "--help"|"-h")
        show_help
        ;;
    "")
        main_cleanup
        ;;
    *)
        print_error "Unknown option: $1"
        echo
        show_help
        exit 1
        ;;
esac
