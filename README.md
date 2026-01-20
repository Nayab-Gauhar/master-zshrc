# Master ZSH Configuration

A powerful, feature-rich, and well-organized ZSH configuration for developers. Created for the **OS101 Event by ISTE HIT SC**.

## Features

### Enhanced Shell Experience
- **Powerlevel10k Theme**: Beautiful and fast prompt with detailed git information
- **Smart History Management**: 50,000 command history with deduplication
- **Intelligent Auto-completion**: Context-aware completions with menu selection
- **Directory Navigation**: Auto-cd, directory stack, and smart navigation
- **Syntax Highlighting**: Real-time command syntax highlighting
- **Auto-suggestions**: Fish-like command suggestions as you type

### FZF Integration
- **Fuzzy Finding**: Lightning-fast file and directory search
- **Enhanced Previews**: File content preview with syntax highlighting
- **Smart Commands**: 
  - `Ctrl+T`: Fuzzy file search
  - `Ctrl+R`: Fuzzy history search
  - `Alt+C`: Fuzzy directory navigation

### Essential Aliases

#### Git Shortcuts
- `gs` - git status
- `ga` - git add
- `gcm` - git commit -m
- `gp` - git push
- `gpl` - git pull
- `gl` - pretty git log
- `gitnm` - add, commit, and push to main in one command

#### Directory Navigation
- `..`, `...`, `....` - Quick parent directory navigation
- `~` - Jump to home directory
- `-` - Jump to previous directory

#### System Utilities
- `update` - Update and upgrade system packages
- `install` - Install packages
- `remove` - Clean package cache
- `ll` - Enhanced listing with icons (using exa)
- `cat` - Better cat with syntax highlighting (using bat)

### Custom Functions

#### File Management
- **`nayab()`** - Path finder with FZF, copies path to clipboard
- **`sara()`** - Full-featured file browser with VS Code integration
  - Rich file previews
  - Open files/folders in VS Code
  - System integration with Ctrl+O
- **`nayab_recent()`** - Quick access to recently used files
- **`sara_recent()`** - Quick access to recent workspaces

#### System Utilities
- **`sysinfo()`** - Detailed system information dashboard
  - CPU, RAM, Storage metrics
  - Network information
  - Process statistics
- **`extract()`** - Universal archive extraction (supports zip, tar, rar, 7z, etc.)
- **`killp()`** - Interactive process killer with FZF
- **`j()`** - Quick directory jump with FZF
- **`hf()`** - Enhanced history search with FZF
- **`weekly_cleanup()`** - System cleanup (cache, logs, packages)
- **`youtube()`** - Quick YouTube launcher

### Plugins Included
- `git` - Git aliases and functions
- `zsh-autosuggestions` - Fish-like autosuggestions
- `zsh-syntax-highlighting` - Syntax highlighting
- `zsh-completions` - Additional completions
- `z` - Jump around directories
- `colored-man-pages` - Colorized man pages
- `command-not-found` - Package suggestions
- `extract` - Universal extract command
- `sudo` - Press ESC twice to add sudo
- `copypath` - Copy current path
- `copyfile` - Copy file contents

## Prerequisites

- ZSH shell
- Oh My Zsh
- Git

### Optional (for enhanced features)
- `fzf` - Fuzzy finder (auto-installed)
- `exa` - Modern ls replacement
- `bat` or `batcat` - Better cat with syntax highlighting
- `fd` or `fdfind` - Fast find alternative
- VS Code - For sara() function
- `xclip` - For clipboard functionality

## Installation

### Quick Install

```bash
# Backup your existing .zshrc
cp ~/.zshrc ~/.zshrc.backup

# Clone this repository
git clone https://github.com/Nayab-Gauhar/master-zshrc.git
cd master-zshrc

# Copy the configuration
cp .zshrc ~/.zshrc

# Reload your shell
source ~/.zshrc
```

### Manual Installation

1. Install Oh My Zsh (if not already installed):
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. Install Powerlevel10k theme:
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

3. Install plugins:
```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-completions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
```

4. Install optional tools (Ubuntu/Debian):
```bash
sudo apt update
sudo apt install -y fzf exa bat fd-find
```

5. Copy the .zshrc file:
```bash
cp .zshrc ~/.zshrc
source ~/.zshrc
```

## Configuration

### Powerlevel10k
Run the configuration wizard:
```bash
p10k configure
```

### Customize Paths
Edit the following lines in `.zshrc` to match your setup:
- Line 11: Flutter path (if using Flutter)
- Line 12-14: Android SDK paths (if using Android development)
- Line 294 & 314: Custom search paths for `nayab()` and `sara()` functions

## Usage Examples

### Quick File Navigation
```bash
# Find and copy path
nayab

# Open file/folder in VS Code
sara

# Jump to directory
j myproject

# Search command history
hf
```

### System Management
```bash
# View system info
sysinfo

# Update system
update

# Clean system
weekly_cleanup

# Kill process interactively
killp
```

### Git Workflow
```bash
# Quick commit and push
ga .
gcm "Your message"
gp

# Or use the shortcut (adds all, commits, and pushes)
gitnm
```

## Customization

Feel free to modify the configuration to suit your needs:
- Add your own aliases in the **ALIASES** section
- Create custom functions in the **CUSTOM FUNCTIONS** section
- Adjust FZF settings for different preview styles
- Modify history settings based on your preferences

## Contributing

Contributions are welcome! This project is part of the **OS101 event by ISTE HIT SC**. 

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details.

## Troubleshooting

### FZF not working
```bash
# Reinstall fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
```

### Plugins not loading
```bash
# Verify plugins are installed
ls ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/
```

### Powerlevel10k issues
```bash
# Reconfigure
p10k configure
```

## License

MIT License - Feel free to use and modify as you wish!

## Acknowledgments

- **ISTE HIT SC** for organizing the OS101 event
- [Oh My Zsh](https://ohmyz.sh/) community
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) by Roman Perepelitsa
- [FZF](https://github.com/junegunn/fzf) by Junegunn Choi
- All the amazing ZSH plugin developers

## Author

**Nayab Gauhar**

Created for OS101 Event - ISTE HIT SC

---

**Star this repo if you find it useful!**
