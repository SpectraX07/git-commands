#!/bin/bash

# 💾 Git Repository Backup & Restore Utility
# Comprehensive backup solution for Git repositories

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Configuration
BACKUP_DIR="${GIT_BACKUP_DIR:-$HOME/.git-backups}"
COMPRESSION_LEVEL=6
MAX_BACKUPS=10

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
    echo -e "${PURPLE}💾 $1${NC}"
    echo "$(printf '=%.0s' $(seq 1 ${#1}))"
}

# Check if we're in a Git repository
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a Git repository"
        exit 1
    fi
}

# Get repository information
get_repo_info() {
    REPO_PATH=$(git rev-parse --show-toplevel)
    REPO_NAME=$(basename "$REPO_PATH")
    CURRENT_BRANCH=$(git branch --show-current)
    COMMIT_HASH=$(git rev-parse HEAD)
    COMMIT_COUNT=$(git rev-list --all --count)
}

# Create backup directory
create_backup_dir() {
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
        print_info "Created backup directory: $BACKUP_DIR"
    fi
}

# Generate backup filename
generate_backup_name() {
    local timestamp=$(date +"%Y%m%d-%H%M%S")
    local short_hash=$(echo "$COMMIT_HASH" | cut -c1-8)
    echo "${REPO_NAME}-${timestamp}-${short_hash}"
}

# Create full repository backup
create_full_backup() {
    print_header "Creating Full Repository Backup"
    
    get_repo_info
    create_backup_dir
    
    local backup_name=$(generate_backup_name)
    local backup_path="$BACKUP_DIR/${backup_name}"
    
    print_info "Repository: $REPO_NAME"
    print_info "Current Branch: $CURRENT_BRANCH"
    print_info "Commit: $COMMIT_HASH"
    print_info "Total Commits: $COMMIT_COUNT"
    print_info "Backup Location: $backup_path"
    echo
    
    # Create backup directory
    mkdir -p "$backup_path"
    
    # Copy entire repository
    print_info "Copying repository files..."
    cp -r "$REPO_PATH" "$backup_path/repository"
    
    # Create bundle (portable Git repository)
    print_info "Creating Git bundle..."
    git bundle create "$backup_path/repository.bundle" --all
    
    # Export repository metadata
    print_info "Exporting metadata..."
    {
        echo "# Git Repository Backup Metadata"
        echo "Backup Date: $(date -Iseconds)"
        echo "Repository Name: $REPO_NAME"
        echo "Repository Path: $REPO_PATH"
        echo "Current Branch: $CURRENT_BRANCH"
        echo "Current Commit: $COMMIT_HASH"
        echo "Total Commits: $COMMIT_COUNT"
        echo "Backup Type: Full"
        echo
        echo "## Branch Information"
        git branch -a
        echo
        echo "## Tag Information"
        git tag -l
        echo
        echo "## Remote Information"
        git remote -v
        echo
        echo "## Recent Commits"
        git log --oneline -10
    } > "$backup_path/metadata.txt"
    
    # Create compressed archive
    print_info "Compressing backup..."
    cd "$BACKUP_DIR"
    tar -czf "${backup_name}.tar.gz" "$backup_name"
    rm -rf "$backup_name"
    
    local backup_size=$(du -sh "${backup_name}.tar.gz" | cut -f1)
    print_success "Backup created: ${backup_name}.tar.gz ($backup_size)"
    
    # Clean up old backups
    cleanup_old_backups
}

# Create incremental backup (bundle only)
create_incremental_backup() {
    print_header "Creating Incremental Backup"
    
    get_repo_info
    create_backup_dir
    
    local backup_name=$(generate_backup_name)
    local bundle_path="$BACKUP_DIR/${backup_name}.bundle"
    
    print_info "Repository: $REPO_NAME"
    print_info "Creating incremental bundle..."
    
    # Find last backup to create incremental from
    local last_backup=$(ls -1 "$BACKUP_DIR"/${REPO_NAME}-*.bundle 2>/dev/null | tail -1 || echo "")
    
    if [ -n "$last_backup" ]; then
        # Extract commit hash from last backup
        local last_commit=$(basename "$last_backup" .bundle | grep -o '[a-f0-9]\{8\}$' || echo "")
        if [ -n "$last_commit" ] && git cat-file -e "${last_commit}" 2>/dev/null; then
            print_info "Creating incremental bundle since: $last_commit"
            git bundle create "$bundle_path" "${last_commit}..HEAD"
        else
            print_warning "Cannot create incremental backup, creating full bundle"
            git bundle create "$bundle_path" --all
        fi
    else
        print_info "No previous backup found, creating full bundle"
        git bundle create "$bundle_path" --all
    fi
    
    # Verify bundle
    if git bundle verify "$bundle_path" > /dev/null 2>&1; then
        local bundle_size=$(du -sh "$bundle_path" | cut -f1)
        print_success "Incremental backup created: $(basename "$bundle_path") ($bundle_size)"
    else
        print_error "Bundle verification failed"
        rm -f "$bundle_path"
        exit 1
    fi
}

# Create working directory backup
create_working_backup() {
    print_header "Creating Working Directory Backup"
    
    get_repo_info
    create_backup_dir
    
    local backup_name="${REPO_NAME}-working-$(date +%Y%m%d-%H%M%S)"
    local backup_path="$BACKUP_DIR/${backup_name}.tar.gz"
    
    print_info "Repository: $REPO_NAME"
    print_info "Including uncommitted changes..."
    
    # Create temporary directory
    local temp_dir=$(mktemp -d)
    
    # Copy working directory (excluding .git to save space)
    rsync -av --exclude='.git' "$REPO_PATH/" "$temp_dir/$REPO_NAME/"
    
    # Add Git status information
    {
        echo "# Working Directory Backup"
        echo "Backup Date: $(date -Iseconds)"
        echo "Repository: $REPO_NAME"
        echo "Current Branch: $CURRENT_BRANCH"
        echo "Current Commit: $COMMIT_HASH"
        echo
        echo "## Git Status"
        git status --porcelain
        echo
        echo "## Staged Changes"
        git diff --cached --stat
        echo
        echo "## Unstaged Changes"
        git diff --stat
    } > "$temp_dir/$REPO_NAME/BACKUP_INFO.txt"
    
    # Create compressed archive
    cd "$temp_dir"
    tar -czf "$backup_path" "$REPO_NAME"
    rm -rf "$temp_dir"
    
    local backup_size=$(du -sh "$backup_path" | cut -f1)
    print_success "Working directory backup created: $(basename "$backup_path") ($backup_size)"
}

# List available backups
list_backups() {
    print_header "Available Backups"
    
    if [ ! -d "$BACKUP_DIR" ]; then
        print_warning "No backup directory found: $BACKUP_DIR"
        return
    fi
    
    local repo_name=""
    if git rev-parse --git-dir > /dev/null 2>&1; then
        repo_name=$(basename "$(git rev-parse --show-toplevel)")
    fi
    
    echo "Backup Directory: $BACKUP_DIR"
    echo
    
    # List all backups
    local backups_found=false
    
    # Full backups
    if ls "$BACKUP_DIR"/*.tar.gz > /dev/null 2>&1; then
        echo "📦 Full Backups:"
        for backup in "$BACKUP_DIR"/*.tar.gz; do
            if [ -f "$backup" ]; then
                local name=$(basename "$backup" .tar.gz)
                local size=$(du -sh "$backup" | cut -f1)
                local date=$(stat -c %y "$backup" | cut -d' ' -f1)
                
                if [ -n "$repo_name" ] && [[ $name == $repo_name-* ]]; then
                    echo "  🎯 $name ($size) - $date"
                else
                    echo "     $name ($size) - $date"
                fi
                backups_found=true
            fi
        done
        echo
    fi
    
    # Bundle backups
    if ls "$BACKUP_DIR"/*.bundle > /dev/null 2>&1; then
        echo "📋 Bundle Backups:"
        for bundle in "$BACKUP_DIR"/*.bundle; do
            if [ -f "$bundle" ]; then
                local name=$(basename "$bundle" .bundle)
                local size=$(du -sh "$bundle" | cut -f1)
                local date=$(stat -c %y "$bundle" | cut -d' ' -f1)
                
                if [ -n "$repo_name" ] && [[ $name == $repo_name-* ]]; then
                    echo "  🎯 $name ($size) - $date"
                else
                    echo "     $name ($size) - $date"
                fi
                backups_found=true
            fi
        done
        echo
    fi
    
    if [ "$backups_found" = false ]; then
        print_info "No backups found in $BACKUP_DIR"
    fi
}

# Restore from backup
restore_backup() {
    local backup_name="$1"
    
    if [ -z "$backup_name" ]; then
        print_error "Please specify backup name to restore"
        list_backups
        exit 1
    fi
    
    print_header "Restoring from Backup"
    
    local backup_path=""
    
    # Check for full backup
    if [ -f "$BACKUP_DIR/${backup_name}.tar.gz" ]; then
        backup_path="$BACKUP_DIR/${backup_name}.tar.gz"
        restore_full_backup "$backup_path"
    # Check for bundle backup
    elif [ -f "$BACKUP_DIR/${backup_name}.bundle" ]; then
        backup_path="$BACKUP_DIR/${backup_name}.bundle"
        restore_bundle_backup "$backup_path"
    else
        print_error "Backup not found: $backup_name"
        print_info "Available backups:"
        list_backups
        exit 1
    fi
}

# Restore full backup
restore_full_backup() {
    local backup_path="$1"
    local restore_dir="./restored-$(date +%Y%m%d-%H%M%S)"
    
    print_info "Restoring full backup: $(basename "$backup_path")"
    print_info "Restore location: $restore_dir"
    
    # Extract backup
    mkdir -p "$restore_dir"
    cd "$restore_dir"
    tar -xzf "$backup_path"
    
    # Find repository directory
    local repo_dir=$(find . -name "repository" -type d | head -1)
    if [ -n "$repo_dir" ]; then
        print_success "Repository restored to: $restore_dir/$repo_dir"
        
        # Show metadata if available
        local metadata_file=$(find . -name "metadata.txt" | head -1)
        if [ -f "$metadata_file" ]; then
            echo
            print_info "Backup Metadata:"
            head -10 "$metadata_file"
        fi
    else
        print_error "Repository directory not found in backup"
    fi
}

# Restore bundle backup
restore_bundle_backup() {
    local bundle_path="$1"
    local restore_dir="./restored-$(date +%Y%m%d-%H%M%S)"
    
    print_info "Restoring bundle backup: $(basename "$bundle_path")"
    print_info "Restore location: $restore_dir"
    
    # Verify bundle first
    if ! git bundle verify "$bundle_path" > /dev/null 2>&1; then
        print_error "Bundle verification failed"
        exit 1
    fi
    
    # Clone from bundle
    git clone "$bundle_path" "$restore_dir"
    
    if [ -d "$restore_dir" ]; then
        print_success "Repository restored from bundle: $restore_dir"
        
        # Show repository info
        cd "$restore_dir"
        echo
        print_info "Restored Repository Info:"
        echo "  Branches: $(git branch -a | wc -l)"
        echo "  Tags: $(git tag | wc -l)"
        echo "  Commits: $(git rev-list --all --count)"
        echo "  Latest commit: $(git log --oneline -1)"
    else
        print_error "Failed to restore repository from bundle"
    fi
}

# Clean up old backups
cleanup_old_backups() {
    print_info "Cleaning up old backups (keeping $MAX_BACKUPS most recent)..."
    
    # Clean up full backups
    local full_backups=($(ls -1t "$BACKUP_DIR"/*.tar.gz 2>/dev/null || true))
    if [ ${#full_backups[@]} -gt $MAX_BACKUPS ]; then
        for ((i=$MAX_BACKUPS; i<${#full_backups[@]}; i++)); do
            rm -f "${full_backups[$i]}"
            print_info "Removed old backup: $(basename "${full_backups[$i]}")"
        done
    fi
    
    # Clean up bundle backups
    local bundle_backups=($(ls -1t "$BACKUP_DIR"/*.bundle 2>/dev/null || true))
    if [ ${#bundle_backups[@]} -gt $MAX_BACKUPS ]; then
        for ((i=$MAX_BACKUPS; i<${#bundle_backups[@]}; i++)); do
            rm -f "${bundle_backups[$i]}"
            print_info "Removed old bundle: $(basename "${bundle_backups[$i]}")"
        done
    fi
}

# Verify backup integrity
verify_backup() {
    local backup_name="$1"
    
    if [ -z "$backup_name" ]; then
        print_error "Please specify backup name to verify"
        exit 1
    fi
    
    print_header "Verifying Backup Integrity"
    
    # Check for bundle backup
    if [ -f "$BACKUP_DIR/${backup_name}.bundle" ]; then
        print_info "Verifying bundle: $backup_name"
        if git bundle verify "$BACKUP_DIR/${backup_name}.bundle"; then
            print_success "Bundle verification passed"
        else
            print_error "Bundle verification failed"
            exit 1
        fi
    # Check for full backup
    elif [ -f "$BACKUP_DIR/${backup_name}.tar.gz" ]; then
        print_info "Verifying archive: $backup_name"
        if tar -tzf "$BACKUP_DIR/${backup_name}.tar.gz" > /dev/null 2>&1; then
            print_success "Archive verification passed"
        else
            print_error "Archive verification failed"
            exit 1
        fi
    else
        print_error "Backup not found: $backup_name"
        exit 1
    fi
}

# Show backup statistics
show_stats() {
    print_header "Backup Statistics"
    
    if [ ! -d "$BACKUP_DIR" ]; then
        print_warning "No backup directory found"
        return
    fi
    
    local total_backups=0
    local total_size=0
    local full_backups=0
    local bundle_backups=0
    
    # Count full backups
    if ls "$BACKUP_DIR"/*.tar.gz > /dev/null 2>&1; then
        for backup in "$BACKUP_DIR"/*.tar.gz; do
            if [ -f "$backup" ]; then
                ((full_backups++))
                ((total_backups++))
                local size=$(du -sb "$backup" | cut -f1)
                total_size=$((total_size + size))
            fi
        done
    fi
    
    # Count bundle backups
    if ls "$BACKUP_DIR"/*.bundle > /dev/null 2>&1; then
        for bundle in "$BACKUP_DIR"/*.bundle; do
            if [ -f "$bundle" ]; then
                ((bundle_backups++))
                ((total_backups++))
                local size=$(du -sb "$bundle" | cut -f1)
                total_size=$((total_size + size))
            fi
        done
    fi
    
    echo "Backup Directory: $BACKUP_DIR"
    echo "Total Backups: $total_backups"
    echo "Full Backups: $full_backups"
    echo "Bundle Backups: $bundle_backups"
    echo "Total Size: $(numfmt --to=iec $total_size)"
    echo "Average Size: $(numfmt --to=iec $((total_backups > 0 ? total_size / total_backups : 0)))"
}

# Show help
show_help() {
    echo "💾 Git Repository Backup & Restore Utility"
    echo "=========================================="
    echo
    echo "Usage: $0 <command> [options]"
    echo
    echo "Commands:"
    echo "  backup [type]       Create backup (full|incremental|working)"
    echo "  list               List available backups"
    echo "  restore <name>     Restore from backup"
    echo "  verify <name>      Verify backup integrity"
    echo "  cleanup            Clean up old backups"
    echo "  stats              Show backup statistics"
    echo "  help               Show this help message"
    echo
    echo "Backup Types:"
    echo "  full               Complete repository backup (default)"
    echo "  incremental        Git bundle with recent changes"
    echo "  working            Working directory with uncommitted changes"
    echo
    echo "Environment Variables:"
    echo "  GIT_BACKUP_DIR     Backup directory (default: ~/.git-backups)"
    echo
    echo "Examples:"
    echo "  $0 backup                    # Create full backup"
    echo "  $0 backup incremental        # Create incremental backup"
    echo "  $0 list                      # List all backups"
    echo "  $0 restore myrepo-20231215   # Restore specific backup"
    echo "  $0 verify myrepo-20231215    # Verify backup integrity"
}

# Main function
main() {
    case "${1:-help}" in
        "backup")
            case "${2:-full}" in
                "full")
                    check_git_repo
                    create_full_backup
                    ;;
                "incremental")
                    check_git_repo
                    create_incremental_backup
                    ;;
                "working")
                    check_git_repo
                    create_working_backup
                    ;;
                *)
                    print_error "Unknown backup type: $2"
                    echo "Valid types: full, incremental, working"
                    exit 1
                    ;;
            esac
            ;;
        "list")
            list_backups
            ;;
        "restore")
            restore_backup "$2"
            ;;
        "verify")
            verify_backup "$2"
            ;;
        "cleanup")
            cleanup_old_backups
            ;;
        "stats")
            show_stats
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
