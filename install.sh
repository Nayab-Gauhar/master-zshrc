#!/bin/bash

# Master ZSH Configuration Installer
# For OS101 Event - ISTE HIT SC
# Author: Nayab Gauhar

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Banner
echo -e "${BLUE}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║        Master ZSH Configuration Installer                ║
║        OS101 Event - ISTE HIT SC                         ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Check if ZSH is installed
print_info "Checking for ZSH..."
if ! command_exists zsh; then
    print_error "ZSH is not installed!"
    print_info "Installing ZSH..."
    sudo apt update
    sudo apt install -y zsh
    print_success "ZSH installed successfully!"
else
    print_success "ZSH is already installed"
fi

# Backup existing .zshrc
if [ -f "$HOME/.zshrc" ]; then
    print_warning "Existing .zshrc found"
    BACKUP_FILE="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    print_info "Creating backup at $BACKUP_FILE"
    cp "$HOME/.zshrc" "$BACKUP_FILE"
    print_success "Backup created successfully!"
fi

# Install Oh My Zsh
print_info "Checking for Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed successfully!"
else
    print_success "Oh My Zsh is already installed"
fi

# Install Powerlevel10k theme
print_info "Installing Powerlevel10k theme..."
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    print_success "Powerlevel10k installed successfully!"
else
    print_success "Powerlevel10k is already installed"
fi

# Install plugins
print_info "Installing ZSH plugins..."

# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    print_success "zsh-autosuggestions installed!"
else
    print_success "zsh-autosuggestions already installed"
fi

# zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    print_success "zsh-syntax-highlighting installed!"
else
    print_success "zsh-syntax-highlighting already installed"
fi

# zsh-completions
if [ ! -d "${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions \
        ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    print_success "zsh-completions installed!"
else
    print_success "zsh-completions already installed"
fi

# Install optional tools
print_info "Installing optional tools..."
print_warning "This will install: fzf, exa, bat, fd-find"
read -p "Do you want to install optional tools? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo apt update
    sudo apt install -y fzf exa bat fd-find
    print_success "Optional tools installed!"
else
    print_warning "Skipped optional tools installation"
fi

# Install FZF if not present
if ! command_exists fzf; then
    print_info "Installing FZF..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
    print_success "FZF installed!"
fi

# Copy .zshrc configuration
print_info "Installing master .zshrc configuration..."
cp .zshrc "$HOME/.zshrc"
print_success "Configuration installed successfully!"

# Set ZSH as default shell
print_info "Setting ZSH as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    print_success "ZSH set as default shell!"
else
    print_success "ZSH is already the default shell"
fi

# Final message
echo -e "\n${GREEN}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║          Installation completed successfully!            ║
║                                                           ║
║  Please log out and log back in for changes to take      ║
║  effect, or run: source ~/.zshrc                         ║
║                                                           ║
║  Run 'p10k configure' to customize your prompt           ║
║                                                           ║
║  Made with ❤️  for OS101 Event - ISTE HIT SC             ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

print_info "To apply changes immediately, run: source ~/.zshrc"
print_info "To configure Powerlevel10k, run: p10k configure"
