#!/bin/bash

# 🔄 Git Flow Automation Script
# Automates common Git workflows and operations

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
    echo -e "${PURPLE}🚀 $1${NC}"
    echo "$(printf '=%.0s' $(seq 1 ${#1}))"
}

# Check if we're in a Git repository
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a Git repository. Please run this script from within a Git repository."
        exit 1
    fi
}

# Get current branch name
get_current_branch() {
    git branch --show-current
}

# Check if branch exists
branch_exists() {
    git show-ref --verify --quiet refs/heads/"$1"
}

# Check if there are uncommitted changes
has_uncommitted_changes() {
    ! git diff-index --quiet HEAD --
}

# Start new feature branch
start_feature() {
    local feature_name="$1"
    
    if [ -z "$feature_name" ]; then
        read -p "Enter feature name (e.g., user-authentication): " feature_name
    fi
    
    if [ -z "$feature_name" ]; then
        print_error "Feature name cannot be empty"
        return 1
    fi
    
    local branch_name="feature/$feature_name"
    
    if branch_exists "$branch_name"; then
        print_error "Branch $branch_name already exists"
        return 1
    fi
    
    print_info "Starting new feature: $feature_name"
    
    # Switch to main/master and pull latest
    local main_branch
    if branch_exists "main"; then
        main_branch="main"
    elif branch_exists "master"; then
        main_branch="master"
    else
        print_error "Neither 'main' nor 'master' branch found"
        return 1
    fi
    
    git checkout "$main_branch"
    print_info "Switched to $main_branch branch"
    
    git pull origin "$main_branch"
    print_success "Pulled latest changes from origin/$main_branch"
    
    # Create and switch to feature branch
    git checkout -b "$branch_name"
    print_success "Created and switched to $branch_name"
    
    print_info "You can now start working on your feature!"
    print_info "When ready to push: git push -u origin $branch_name"
}

# Finish feature branch
finish_feature() {
    local current_branch
    current_branch=$(get_current_branch)
    
    if [[ ! $current_branch == feature/* ]]; then
        print_error "Not on a feature branch. Current branch: $current_branch"
        return 1
    fi
    
    if has_uncommitted_changes; then
        print_warning "You have uncommitted changes."
        read -p "Commit them now? (y/n): " commit_changes
        
        if [[ $commit_changes == "y" || $commit_changes == "Y" ]]; then
            git add .
            read -p "Enter commit message: " commit_msg
            git commit -m "$commit_msg"
            print_success "Changes committed"
        else
            print_error "Please commit or stash your changes before finishing the feature"
            return 1
        fi
    fi
    
    # Push feature branch if it has commits ahead
    local commits_ahead
    commits_ahead=$(git rev-list --count HEAD ^origin/"$current_branch" 2>/dev/null || echo "0")
    
    if [ "$commits_ahead" -gt 0 ]; then
        print_info "Pushing feature branch to origin..."
        git push origin "$current_branch"
        print_success "Feature branch pushed to origin"
    fi
    
    # Switch to main branch
    local main_branch
    if branch_exists "main"; then
        main_branch="main"
    elif branch_exists "master"; then
        main_branch="master"
    else
        print_error "Neither 'main' nor 'master' branch found"
        return 1
    fi
    
    git checkout "$main_branch"
    git pull origin "$main_branch"
    print_success "Switched to $main_branch and pulled latest changes"
    
    # Merge feature branch
    print_info "Merging $current_branch into $main_branch..."
    git merge --no-ff "$current_branch" -m "Merge branch '$current_branch'"
    print_success "Feature branch merged successfully"
    
    # Push merged changes
    git push origin "$main_branch"
    print_success "Changes pushed to origin/$main_branch"
    
    # Delete feature branch
    read -p "Delete feature branch $current_branch? (y/n): " delete_branch
    if [[ $delete_branch == "y" || $delete_branch == "Y" ]]; then
        git branch -d "$current_branch"
        git push origin --delete "$current_branch" 2>/dev/null || true
        print_success "Feature branch deleted locally and remotely"
    fi
    
    print_success "Feature workflow completed!"
}

# Create hotfix branch
start_hotfix() {
    local hotfix_name="$1"
    
    if [ -z "$hotfix_name" ]; then
        read -p "Enter hotfix name (e.g., critical-security-fix): " hotfix_name
    fi
    
    if [ -z "$hotfix_name" ]; then
        print_error "Hotfix name cannot be empty"
        return 1
    fi
    
    local branch_name="hotfix/$hotfix_name"
    
    if branch_exists "$branch_name"; then
        print_error "Branch $branch_name already exists"
        return 1
    fi
    
    print_info "Starting hotfix: $hotfix_name"
    
    # Switch to main/master and pull latest
    local main_branch
    if branch_exists "main"; then
        main_branch="main"
    elif branch_exists "master"; then
        main_branch="master"
    else
        print_error "Neither 'main' nor 'master' branch found"
        return 1
    fi
    
    git checkout "$main_branch"
    git pull origin "$main_branch"
    
    # Create hotfix branch
    git checkout -b "$branch_name"
    print_success "Created hotfix branch: $branch_name"
    
    print_info "Fix the issue and commit your changes"
    print_info "When ready: $0 finish-hotfix"
}

# Finish hotfix
finish_hotfix() {
    local current_branch
    current_branch=$(get_current_branch)
    
    if [[ ! $current_branch == hotfix/* ]]; then
        print_error "Not on a hotfix branch. Current branch: $current_branch"
        return 1
    fi
    
    if has_uncommitted_changes; then
        print_error "Please commit your hotfix changes first"
        return 1
    fi
    
    # Get main and develop branches
    local main_branch develop_branch
    if branch_exists "main"; then
        main_branch="main"
    elif branch_exists "master"; then
        main_branch="master"
    else
        print_error "Neither 'main' nor 'master' branch found"
        return 1
    fi
    
    if branch_exists "develop"; then
        develop_branch="develop"
    fi
    
    # Merge to main
    git checkout "$main_branch"
    git pull origin "$main_branch"
    git merge --no-ff "$current_branch" -m "Merge hotfix '$current_branch'"
    git push origin "$main_branch"
    print_success "Hotfix merged to $main_branch"
    
    # Merge to develop if it exists
    if [ -n "$develop_branch" ]; then
        git checkout "$develop_branch"
        git pull origin "$develop_branch"
        git merge --no-ff "$current_branch" -m "Merge hotfix '$current_branch'"
        git push origin "$develop_branch"
        print_success "Hotfix merged to $develop_branch"
    fi
    
    # Create tag for hotfix
    read -p "Create tag for this hotfix? (y/n): " create_tag
    if [[ $create_tag == "y" || $create_tag == "Y" ]]; then
        read -p "Enter tag name (e.g., v1.0.1): " tag_name
        if [ -n "$tag_name" ]; then
            git checkout "$main_branch"
            git tag -a "$tag_name" -m "Hotfix release $tag_name"
            git push origin "$tag_name"
            print_success "Tag $tag_name created and pushed"
        fi
    fi
    
    # Delete hotfix branch
    git branch -d "$current_branch"
    print_success "Hotfix branch deleted"
    
    print_success "Hotfix workflow completed!"
}

# Quick commit with conventional commit format
quick_commit() {
    if ! has_uncommitted_changes; then
        print_warning "No changes to commit"
        return 0
    fi
    
    echo "Select commit type:"
    echo "1) feat: New feature"
    echo "2) fix: Bug fix"
    echo "3) docs: Documentation"
    echo "4) style: Code style/formatting"
    echo "5) refactor: Code refactoring"
    echo "6) test: Adding tests"
    echo "7) chore: Maintenance"
    echo "8) perf: Performance improvement"
    
    read -p "Enter choice (1-8): " commit_type_choice
    
    local commit_type
    case $commit_type_choice in
        1) commit_type="feat" ;;
        2) commit_type="fix" ;;
        3) commit_type="docs" ;;
        4) commit_type="style" ;;
        5) commit_type="refactor" ;;
        6) commit_type="test" ;;
        7) commit_type="chore" ;;
        8) commit_type="perf" ;;
        *) print_error "Invalid choice"; return 1 ;;
    esac
    
    read -p "Enter scope (optional, e.g., auth, api): " scope
    read -p "Enter description: " description
    
    if [ -z "$description" ]; then
        print_error "Description cannot be empty"
        return 1
    fi
    
    local commit_msg="$commit_type"
    if [ -n "$scope" ]; then
        commit_msg="$commit_msg($scope)"
    fi
    commit_msg="$commit_msg: $description"
    
    git add .
    git commit -m "$commit_msg"
    print_success "Committed: $commit_msg"
}

# Sync with remote
sync_with_remote() {
    local current_branch
    current_branch=$(get_current_branch)
    
    print_info "Syncing $current_branch with remote..."
    
    # Stash changes if any
    local stashed=false
    if has_uncommitted_changes; then
        git stash push -m "Auto-stash before sync"
        stashed=true
        print_info "Stashed uncommitted changes"
    fi
    
    # Fetch and pull
    git fetch origin
    git pull origin "$current_branch"
    print_success "Synced with origin/$current_branch"
    
    # Pop stash if we stashed
    if [ "$stashed" = true ]; then
        git stash pop
        print_success "Restored stashed changes"
    fi
}

# Clean up merged branches
cleanup_branches() {
    print_info "Cleaning up merged branches..."
    
    # Get current branch
    local current_branch
    current_branch=$(get_current_branch)
    
    # Get merged branches (excluding main, master, develop, and current)
    local merged_branches
    merged_branches=$(git branch --merged | grep -v "\*\|main\|master\|develop\|$current_branch" | xargs -n 1 2>/dev/null || true)
    
    if [ -z "$merged_branches" ]; then
        print_info "No merged branches to clean up"
        return 0
    fi
    
    echo "Merged branches to delete:"
    echo "$merged_branches"
    
    read -p "Delete these branches? (y/n): " confirm_delete
    if [[ $confirm_delete == "y" || $confirm_delete == "Y" ]]; then
        echo "$merged_branches" | xargs -n 1 git branch -d
        print_success "Merged branches deleted"
    fi
}

# Show help
show_help() {
    echo "🔄 Git Flow Automation Script"
    echo "============================"
    echo
    echo "Usage: $0 <command> [options]"
    echo
    echo "Commands:"
    echo "  start-feature [name]    Start a new feature branch"
    echo "  finish-feature          Finish current feature branch"
    echo "  start-hotfix [name]     Start a hotfix branch"
    echo "  finish-hotfix           Finish current hotfix branch"
    echo "  quick-commit            Quick commit with conventional format"
    echo "  sync                    Sync current branch with remote"
    echo "  cleanup                 Clean up merged branches"
    echo "  help                    Show this help message"
    echo
    echo "Examples:"
    echo "  $0 start-feature user-auth"
    echo "  $0 finish-feature"
    echo "  $0 quick-commit"
    echo "  $0 sync"
}

# Main script logic
main() {
    check_git_repo
    
    case "${1:-help}" in
        "start-feature")
            start_feature "$2"
            ;;
        "finish-feature")
            finish_feature
            ;;
        "start-hotfix")
            start_hotfix "$2"
            ;;
        "finish-hotfix")
            finish_hotfix
            ;;
        "quick-commit")
            quick_commit
            ;;
        "sync")
            sync_with_remote
            ;;
        "cleanup")
            cleanup_branches
            ;;
        "help"|"--help"|"-h")
            show_help
            ;;
        *)
            print_error "Unknown command: $1"
            echo
            show_help
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
