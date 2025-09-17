#!/bin/bash

# 🚀 Git Setup Script
# This script helps you configure Git with best practices and useful aliases

set -e

echo "🚀 Git Setup Script"
echo "=================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
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

# Check if Git is installed
if ! command -v git &> /dev/null; then
    print_error "Git is not installed. Please install Git first."
    exit 1
fi

print_status "Git is installed: $(git --version)"

# Get user information
echo
echo "📝 User Configuration"
echo "===================="

# Check if user.name is already set
current_name=$(git config --global user.name 2>/dev/null || echo "")
if [ -n "$current_name" ]; then
    print_info "Current name: $current_name"
    read -p "Keep current name? (y/n): " keep_name
    if [[ $keep_name != "y" && $keep_name != "Y" ]]; then
        read -p "Enter your full name: " user_name
        git config --global user.name "$user_name"
        print_status "Name set to: $user_name"
    fi
else
    read -p "Enter your full name: " user_name
    git config --global user.name "$user_name"
    print_status "Name set to: $user_name"
fi

# Check if user.email is already set
current_email=$(git config --global user.email 2>/dev/null || echo "")
if [ -n "$current_email" ]; then
    print_info "Current email: $current_email"
    read -p "Keep current email? (y/n): " keep_email
    if [[ $keep_email != "y" && $keep_email != "Y" ]]; then
        read -p "Enter your email: " user_email
        git config --global user.email "$user_email"
        print_status "Email set to: $user_email"
    fi
else
    read -p "Enter your email: " user_email
    git config --global user.email "$user_email"
    print_status "Email set to: $user_email"
fi

# Set default branch name
echo
echo "🌿 Branch Configuration"
echo "======================"
git config --global init.defaultBranch main
print_status "Default branch set to 'main'"

# Configure editor
echo
echo "📝 Editor Configuration"
echo "======================"
echo "Choose your preferred editor:"
echo "1) VS Code (code --wait)"
echo "2) Vim"
echo "3) Nano"
echo "4) Sublime Text"
echo "5) Skip editor configuration"

read -p "Enter your choice (1-5): " editor_choice

case $editor_choice in
    1)
        if command -v code &> /dev/null; then
            git config --global core.editor "code --wait"
            print_status "Editor set to VS Code"
        else
            print_warning "VS Code not found in PATH. Skipping editor configuration."
        fi
        ;;
    2)
        git config --global core.editor "vim"
        print_status "Editor set to Vim"
        ;;
    3)
        git config --global core.editor "nano"
        print_status "Editor set to Nano"
        ;;
    4)
        if command -v subl &> /dev/null; then
            git config --global core.editor "subl -n -w"
            print_status "Editor set to Sublime Text"
        else
            print_warning "Sublime Text not found in PATH. Skipping editor configuration."
        fi
        ;;
    5)
        print_info "Skipping editor configuration"
        ;;
    *)
        print_warning "Invalid choice. Skipping editor configuration."
        ;;
esac

# Configure useful aliases
echo
echo "🔧 Setting up useful aliases"
echo "============================"

# Basic aliases
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

print_status "Aliases configured successfully"

# Configure additional settings
echo
echo "⚙️  Additional Configuration"
echo "============================"

# Line ending configuration
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    # Windows
    git config --global core.autocrlf true
    print_status "Line endings configured for Windows"
else
    # macOS/Linux
    git config --global core.autocrlf input
    print_status "Line endings configured for Unix/Linux"
fi

# Performance improvements
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

print_status "Performance and behavior settings configured"

# Create global .gitignore
echo
echo "📄 Global .gitignore"
echo "==================="

read -p "Create global .gitignore file? (y/n): " create_gitignore

if [[ $create_gitignore == "y" || $create_gitignore == "Y" ]]; then
    gitignore_path="$HOME/.gitignore_global"
    
    cat > "$gitignore_path" << 'EOF'
# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# Temporary files
*.tmp
*.temp
*.log

# Environment files
.env
.env.local
.env.production
.env.staging

# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/

# Build outputs
dist/
build/
*.exe
*.dll
*.so
*.dylib
EOF

    git config --global core.excludesfile "$gitignore_path"
    print_status "Global .gitignore created at $gitignore_path"
fi

# SSH key setup (optional)
echo
echo "🔐 SSH Key Setup"
echo "==============="

read -p "Generate SSH key for GitHub/GitLab? (y/n): " generate_ssh

if [[ $generate_ssh == "y" || $generate_ssh == "Y" ]]; then
    ssh_email=$(git config --global user.email)
    ssh_path="$HOME/.ssh/id_ed25519"
    
    if [ -f "$ssh_path" ]; then
        print_warning "SSH key already exists at $ssh_path"
        read -p "Generate new key anyway? (y/n): " overwrite_key
        if [[ $overwrite_key != "y" && $overwrite_key != "Y" ]]; then
            print_info "Skipping SSH key generation"
        else
            ssh-keygen -t ed25519 -C "$ssh_email" -f "$ssh_path"
            print_status "SSH key generated"
        fi
    else
        ssh-keygen -t ed25519 -C "$ssh_email" -f "$ssh_path"
        print_status "SSH key generated"
    fi
    
    if [ -f "$ssh_path" ]; then
        # Start SSH agent and add key
        eval "$(ssh-agent -s)" > /dev/null
        ssh-add "$ssh_path" 2>/dev/null
        
        print_status "SSH key added to agent"
        print_info "Your public key (copy this to GitHub/GitLab):"
        echo
        cat "$ssh_path.pub"
        echo
        print_info "Add this key to your GitHub/GitLab account in Settings > SSH Keys"
    fi
fi

# Display final configuration
echo
echo "📋 Final Configuration Summary"
echo "============================="
echo "Name: $(git config --global user.name)"
echo "Email: $(git config --global user.email)"
echo "Default Branch: $(git config --global init.defaultBranch)"
echo "Editor: $(git config --global core.editor || echo 'Not set')"
echo

print_status "Git setup completed successfully!"
print_info "You can view all settings with: git config --global --list"
print_info "Available aliases:"
echo "  git st       → git status"
echo "  git co       → git checkout"
echo "  git br       → git branch"
echo "  git ci       → git commit"
echo "  git lg       → git log --oneline --graph --all"
echo "  git amend    → git commit --amend --no-edit"
echo "  git wip      → git commit -am 'WIP: work in progress'"
echo "  git undo     → git reset --soft HEAD~1"
echo "  git cleanup  → delete merged branches"

echo
print_status "Happy coding! 🚀"
