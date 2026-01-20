# Master ZSH Configuration

A powerful, clean, and well-organized ZSH configuration for developers. Created for the OS101 Event by ISTE HIT SC.

## Features

### Core Configuration
- Powerlevel10k theme with git integration
- 50,000 command history with smart deduplication
- Intelligent auto-completion with menu selection
- Auto-cd and directory stack navigation
- Real-time syntax highlighting
- Fish-like command auto-suggestions

### FZF Integration
- Lightning-fast fuzzy file and directory search
- File content preview with syntax highlighting
- `Ctrl+T` - Fuzzy file search
- `Ctrl+R` - Fuzzy history search
- `Alt+C` - Fuzzy directory navigation

### Git Shortcuts
```bash
gs      # git status
ga      # git add
gcm     # git commit -m
gp      # git push
gpl     # git pull
gl      # git log --oneline --graph
gd      # git diff
gb      # git branch
gco     # git checkout
gcb     # git checkout -b
gitnm   # add, commit, push to main (one command)
```

### Navigation Aliases
```bash
..      # cd ..
...     # cd ../..
....    # cd ../../..
~       # cd ~
-       # cd to previous directory
```

### System Aliases
```bash
update   # apt update && upgrade
install  # apt install
remove   # clean package cache
ll       # enhanced ls (with exa if available)
cat      # syntax-highlighted cat (with bat if available)
```

### Custom Functions

**File Management:**
- `nayab` - Quick path finder with FZF, copies path to clipboard
- `sara` - File browser with VS Code integration
  - File previews with syntax highlighting
  - Open in VS Code with Enter
  - System open with Ctrl+O
  - Open folder with Ctrl+F
- `nayab_recent` - Access recently used files
- `sara_recent` - Access recent workspaces

**System Tools:**
- `sysinfo` - System information dashboard (CPU, RAM, storage, network, processes)
- `extract` - Universal archive extraction (zip, tar, rar, 7z, etc.)
- `killp` - Interactive process killer with FZF
- `j` - Quick directory jump with FZF
- `hf` - Enhanced history search with FZF
- `weekly_cleanup` - Clean system cache, logs, and packages
- `youtube` - Quick YouTube launcher

### Plugins
- git - Git integration
- zsh-autosuggestions - Command suggestions
- zsh-syntax-highlighting - Syntax highlighting
- zsh-completions - Additional completions
- z - Jump to frequently used directories
- colored-man-pages - Colorized man pages
- command-not-found - Package suggestions
- extract - Universal extraction
- sudo - Press ESC twice to add sudo
- copypath - Copy current path
- copyfile - Copy file contents

## Prerequisites

### Required
- ZSH shell
- Oh My Zsh
- Git

### Optional (Enhanced Features)
- `fzf` - Fuzzy finder (auto-installed by config)
- `exa` - Modern ls replacement
- `bat` or `batcat` - Syntax-highlighted cat
- `fd` or `fdfind` - Fast find alternative
- `xclip` - Clipboard support
- VS Code - For sara() function

## Installation

### Quick Install

```bash
# Backup existing config
cp ~/.zshrc ~/.zshrc.backup

# Clone repository
git clone https://github.com/Nayab-Gauhar/master-zshrc.git
cd master-zshrc

# Run installer
chmod +x install.sh
./install.sh
```

### Manual Installation

1. Install Oh My Zsh:
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
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

4. Install optional tools (Ubuntu/Debian):
```bash
sudo apt update
sudo apt install -y fzf exa bat fd-find xclip
```

5. Apply configuration:
```bash
cp .zshrc ~/.zshrc
source ~/.zshrc
```

## Configuration

### Powerlevel10k Setup
```bash
p10k configure
```

### Optional Paths
Edit `.zshrc` to uncomment and configure:
- Flutter development paths (line 12-15)
- Android SDK paths (line 13-15)
- Custom search directories for nayab/sara functions

## Usage Examples

### File Navigation
```bash
nayab          # Find files, copy path
sara           # Browse and open in VS Code
j myproject    # Jump to directory
hf             # Search command history
```

### System Management
```bash
sysinfo         # View system info
update          # Update system
weekly_cleanup  # Clean caches
killp           # Kill process interactively
```

### Git Workflow
```bash
ga .
gcm "commit message"
gp

# Or one command:
gitnm
```

## Customization

The configuration is modular:
- **ALIASES** section - Add your shortcuts
- **CUSTOM FUNCTIONS** section - Add your functions
- **FZF settings** - Adjust preview styles
- **History settings** - Modify size and behavior

## Troubleshooting

**FZF not working:**
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
```

**Plugins not loading:**
```bash
ls ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/
```

**Powerlevel10k issues:**
```bash
p10k configure
```

## Contributing

Part of the OS101 event by ISTE HIT SC. Contributions welcome!

1. Fork the repository
2. Create feature branch (`git checkout -b feature/name`)
3. Commit changes (`git commit -m 'Add feature'`)
4. Push to branch (`git push origin feature/name`)
5. Open Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

MIT License - Free to use and modify.

## Credits

- ISTE HIT SC - OS101 Event
- [Oh My Zsh](https://ohmyz.sh/) community
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) by Roman Perepelitsa
- [FZF](https://github.com/junegunn/fzf) by Junegunn Choi
- ZSH plugin developers

## Author

Nayab Gauhar

Created for OS101 Event - ISTE HIT SC

---

Star this repo if you find it useful!
