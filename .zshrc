# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
export PATH="$PATH:$HOME/develop/flutter/bin"
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# ============================================================================
# ZSH CONFIGURATION IMPROVEMENTS
# ============================================================================
#History settings - MUCH better history management
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY            # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS         # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS     # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS        # Do not display a line previously found
setopt HIST_IGNORE_SPACE        # Don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS        # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks before recording entry

# Better completion system
setopt AUTO_MENU                # Show completion menu on successive tab press
setopt COMPLETE_IN_WORD         # Allow completion from within a word/phrase
setopt ALWAYS_TO_END            # When completing from the middle of a word, move cursor to end
unsetopt MENU_COMPLETE          # Don't autoselect the first completion entry

# Directory navigation improvements
setopt AUTO_CD                  # If you type a directory name, cd to it
setopt AUTO_PUSHD               # Make cd push old directory onto the directory stack
setopt PUSHD_IGNORE_DUPS        # Don't push multiple copies of the same directory
setopt PUSHD_MINUS              # Exchanges meanings of +/- for pushd

# Better globbing
setopt EXTENDED_GLOB            # Extended globbing. Allows using regular expressions with *
setopt GLOB_DOTS               # Include dotfiles in glob matches

# Error correction
setopt CORRECT                  # Auto correct commands
setopt CORRECT_ALL             # Auto correct all arguments

# ============================================================================
# PLUGINS - Essential plugins only
# ============================================================================
plugins=(
    git                         # Git aliases and functions
    zsh-autosuggestions        # Fish-like autosuggestions
    zsh-syntax-highlighting    # Syntax highlighting
    zsh-completions            # Additional completions
    z                          # Jump around directories
    colored-man-pages          # Colorized man pages
    command-not-found          # Suggests packages when command not found
    extract                    # Universal extract command
    sudo                       # ESC ESC to add sudo
    copypath                   # Copy current path
    copyfile                   # Copy file contents
)

source $ZSH/oh-my-zsh.sh

# ============================================================================
# FZF INTEGRATION - Simple and clean
# ============================================================================

# Install fzf if not present
if ! command -v fzf &> /dev/null; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi

# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Clean FZF configuration
export FZF_DEFAULT_OPTS="
    --height=80%
    --layout=reverse
    --border=rounded
    --info=inline
    --preview-window='right:50%:wrap'
"

# Use fd for fzf if available
if command -v fdfind &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fdfind --type d --hidden --follow --exclude .git'
elif command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

# Enhanced fzf previews
export FZF_CTRL_T_OPTS="--preview 'batcat --style=numbers --color=always {} 2>/dev/null || cat {}'"
export FZF_ALT_C_OPTS="--preview 'exa --tree --level=2 {} 2>/dev/null || ls -la {}'"

# ============================================================================
# ALIASES - Essential aliases only
# ============================================================================

# Enhanced ls aliases (using exa if available)
if command -v exa &> /dev/null; then
    alias ls='exa --icons --group-directories-first'
    alias ll='exa -la --icons --group-directories-first --header'
    alias la='exa -la --icons --group-directories-first'
    alias lt='exa --tree --level=3 --icons'
else
    alias ll='ls -la --color=auto'
    alias la='ls -la --color=auto'
    alias l='ls -l --color=auto'
fi

# Better cat (using bat if available)
if command -v batcat &> /dev/null; then
    alias cat='batcat'
elif command -v bat &> /dev/null; then
    alias cat='bat'
fi

# Essential Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gitnm='git add . && git commit -m"Changes made" && git push -u origin main'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# System aliases
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps aux'
alias psg='ps aux | grep'
alias h='history'
alias hg='history | grep'

# Package management
alias update='sudo apt update && sudo apt upgrade'
alias install='sudo apt install'
alias search='apt search'
alias remove='sudo apt autoclean && sudo apt autoremove -y'
# File operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

# Quick edits
alias zshconfig='code ~/.zshrc'
alias zshreload='source ~/.zshrc'

# Use fdfind as fd
alias fd='fdfind'

# ============================================================================
# CUSTOM FUNCTIONS - Essential functions only
# ============================================================================

youtube(){
xdg-open https://www.youtube.com/
}



# Detailed system info
sysinfo() {
    echo "🖥️  SYSTEM INFORMATION"
    echo "════════════════════════════════════════"
    echo "🏷️  Hostname: $(hostname)"
    echo "👤 User: $(whoami)"
    echo "🐧 OS: $(lsb_release -d | cut -f2)"
    echo "🔧 Kernel: $(uname -r)"
    echo "🏗️  Architecture: $(uname -m)"
    echo ""
    echo "⚡ HARDWARE"
    echo "────────────────────────────────────────"
    echo "🧠 CPU: $(lscpu | grep 'Model name' | cut -d: -f2 | xargs)"
    echo "🔢 Cores: $(nproc) cores"
    echo "⚡ CPU Usage: $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')"
    echo ""
    echo "💾 MEMORY"
    echo "────────────────────────────────────────"
    free -h | awk '/^Mem:/ {print "🎯 Total RAM: " $2}'
    free -h | awk '/^Mem:/ {print "📊 Used RAM: " $3 " (" $3/$2*100 "%)"}'
    free -h | awk '/^Mem:/ {print "✅ Free RAM: " $7}'
    free -h | awk '/^Swap:/ {if($2 != "0B") print "🔄 Swap: " $3 "/" $2}'
    echo ""
    echo "💿 STORAGE"
    echo "────────────────────────────────────────"
    df -h | grep '^/dev' | awk '{print "📀 " $1 ": " $3 "/" $2 " (" $5 " used) - " $6}'
    echo ""
    echo "🌐 NETWORK"
    echo "────────────────────────────────────────"
    echo "🔗 Internal IP: $(hostname -I | awk '{print $1}')"
    if command -v curl &> /dev/null; then
        echo "🌍 External IP: $(curl -s ifconfig.me 2>/dev/null || echo 'Not available')"
    fi
    echo ""
    echo "⏰ UPTIME & LOAD"
    echo "────────────────────────────────────────"
    echo "⏱️  Uptime: $(uptime -p)"
    echo "📈 Load Average: $(uptime | awk -F'load average:' '{print $2}')"
    echo "🕐 Current Time: $(date)"
    echo ""
    echo "🔧 SYSTEM PROCESSES"
    echo "────────────────────────────────────────"
    echo "📊 Total Processes: $(ps aux | wc -l)"
    echo "🔴 Running Processes: $(ps aux | awk '$8 ~ /R/ {count++} END {print count+0}')"
    echo "😴 Sleeping Processes: $(ps aux | awk '$8 ~ /S/ {count++} END {print count+0}')"
}

# Enhanced extract function
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find and kill process
killp() {
    local pid
    pid=$(ps aux | fzf --header="Select process to kill" | awk '{print $2}')
    if [[ -n $pid ]]; then
        kill -TERM $pid
        echo "Process $pid terminated"
    fi
}

# Quick directory jump with fzf
j() {
    local dir
    dir=$(find ${1:-.} -type d 2>/dev/null | fzf --header="Jump to directory") && cd "$dir"
}

# Enhanced history search
hf() {
    local cmd
    cmd=$(history | fzf --tac --header="Search command history" | sed 's/^[ ]*[0-9]*[ ]*//')
    if [[ -n $cmd ]]; then
        print -z "$cmd"
    fi
}

# ============================================================================
# YOUR FUNCTIONS - Modified as requested
# ============================================================================

# NAYAB: Simple path finder - ONLY shows paths, no previews
nayab() {
  local file
  
  file=$(fd . ~ 2>/dev/null | fzf \
    --height=80% \
    --layout=reverse \
    --border=rounded \
    --info=inline \
    --header="📁 NAYAB - Path Finder | Enter: select | ESC: quit" \
    --no-preview)
  
  if [[ -n "$file" ]]; then
    echo "$file"
    # Copy to clipboard
    echo -n "$file" | xclip -selection clipboard 2>/dev/null
    echo "📋 Path copied to clipboard"
  fi
}

# SARA: Full-featured file/folder browser with rich previews and VS Code integration
sara() {
  local selection
  
  selection=$(fd . ~ 2>/dev/null | fzf \
    --height=90% \
    --layout=reverse \
    --border=rounded \
    --info=inline \
    --header="🚀 SARA - VS Code Launcher | Enter: open in VS Code | Ctrl-O: system open | Ctrl-F: open folder | ESC: quit" \
    --preview-window='right:50%:wrap' \
    --bind='ctrl-o:execute(xdg-open {} &)' \
    --bind='ctrl-f:execute(xdg-open "$(dirname {})" &)' \
    --bind='ctrl-r:reload(fd . ~ 2>/dev/null)' \
    --preview '
      if [[ -f {} ]]; then
        # File preview with detailed info
        echo "📄 FILE: $(basename {})"
        echo "📍 Path: {}"
        echo "📁 Directory: $(dirname {})"
        echo "📏 Size: $(du -h {} 2>/dev/null | cut -f1 || echo "Unknown")"
        echo "🕐 Modified: $(stat -c %y {} 2>/dev/null | cut -d. -f1 || echo "Unknown")"
        echo "🔐 Permissions: $(ls -la {} 2>/dev/null | cut -d" " -f1 || echo "Unknown")"
        echo "👤 Owner: $(ls -la {} 2>/dev/null | cut -d" " -f3-4 || echo "Unknown")"
        echo "🏷️  Type: $(file -b {} 2>/dev/null || echo "Unknown")"
        echo "─────────────────────────────────────────"
        
        # File content preview based on type
        case {} in
          *.md|*.txt|*.py|*.js|*.sh|*.json|*.yaml|*.yml|*.html|*.css|*.cpp|*.c|*.java|*.go|*.rs|*.php)
            echo "📝 CODE PREVIEW:"
            batcat --style=numbers --color=always --line-range=:30 {} 2>/dev/null || head -n 30 {}
            ;;
          *.pdf)
            echo "📑 PDF PREVIEW:"
            pdftotext {} - 2>/dev/null | head -n 20 || echo "Cannot preview PDF content"
            ;;
          *.jpg|*.jpeg|*.png|*.gif|*.bmp|*.webp)
            echo "🖼️  IMAGE INFO:"
            identify {} 2>/dev/null || echo "Image file - will open in VS Code"
            echo "Use Ctrl-O to open with default image viewer"
            ;;
          *.zip|*.tar|*.tar.gz|*.tgz|*.rar|*.7z)
            echo "📦 ARCHIVE CONTENTS:"
            case {} in
              *.zip) zipinfo -1 {} 2>/dev/null | head -n 15 || echo "Cannot read archive" ;;
              *.tar|*.tar.gz|*.tgz) tar -tf {} 2>/dev/null | head -n 15 || echo "Cannot read archive" ;;
              *.rar) unrar lb {} 2>/dev/null | head -n 15 || echo "Cannot read archive" ;;
              *.7z) 7z l {} 2>/dev/null | head -n 15 || echo "Cannot read archive" ;;
            esac
            ;;
          *)
            if file {} 2>/dev/null | grep -q "text"; then
              echo "📄 TEXT PREVIEW:"
              head -n 20 {} 2>/dev/null || echo "Cannot preview file"
            else
              echo "📄 Binary file - will open in VS Code if supported"
              file {} 2>/dev/null
            fi
            ;;
        esac
        
      elif [[ -d {} ]]; then
        # Directory preview with detailed info
        echo "📁 FOLDER: $(basename {})"
        echo "📍 Path: {}"
        echo "📊 Total Items: $(find {} -maxdepth 1 2>/dev/null | wc -l) items"
        echo "📄 Files: $(find {} -maxdepth 1 -type f 2>/dev/null | wc -l)"
        echo "📁 Subdirectories: $(find {} -maxdepth 1 -type d 2>/dev/null | wc -l)"
        echo "📏 Size: $(du -sh {} 2>/dev/null | cut -f1 || echo "Calculating...")"
        echo "🕐 Modified: $(stat -c %y {} 2>/dev/null | cut -d. -f1 || echo "Unknown")"
        echo "🔐 Permissions: $(ls -ld {} 2>/dev/null | cut -d" " -f1 || echo "Unknown")"
        echo "─────────────────────────────────────────"
        echo "📂 CONTENTS:"
        
        # Show directory contents with icons
        ls -la {} 2>/dev/null | head -n 15 | tail -n +2 | while read -r line; do
          if [[ $line == d* ]]; then
            echo "📁 $(echo "$line" | awk "{print \$NF}")"
          elif [[ $line == -* ]]; then
            filename=$(echo "$line" | awk "{print \$NF}")
            case $filename in
              *.py) echo "🐍 $filename" ;;
              *.js) echo "📜 $filename" ;;
              *.json) echo "📋 $filename" ;;
              *.md) echo "📝 $filename" ;;
              *.txt) echo "📄 $filename" ;;
              *.pdf) echo "📑 $filename" ;;
              *.jpg|*.jpeg|*.png|*.gif) echo "🖼️  $filename" ;;
              *) echo "📄 $filename" ;;
            esac
          else
            echo "$line"
          fi
        done
        
        echo ""
        echo "💡 This will open as VS Code workspace"
      else
        echo "❓ Item not found or inaccessible"
      fi
    ')
  
  if [[ -n "$selection" ]]; then
    # Check if VS Code is available
    if ! command -v code &> /dev/null; then
      echo "❌ VS Code not found. Install with: sudo snap install code --classic"
      echo "Opening with default application instead..."
      xdg-open "$selection" &
      return 1
    fi
    
    echo "Selected: $(basename "$selection")"
    
    if [[ -f "$selection" ]]; then
      echo "📄 Opening file in VS Code..."
      code "$selection"
      echo "$selection" >> ~/.nayab_recent_files 2>/dev/null
      
    elif [[ -d "$selection" ]]; then
      echo "📁 Opening folder as VS Code workspace..."
      code "$selection"
      echo "$selection" >> ~/.nayab_recent_workspaces 2>/dev/null
      
    else
      echo "❌ Selection no longer exists: $selection"
      return 1
    fi
    
    echo "✅ Opened successfully in VS Code!"
  fi
}

# Recent files function
nayab_recent() {
  if [[ -f ~/.nayab_recent_files ]]; then
    local file
    file=$(tac ~/.nayab_recent_files | head -n 20 | fzf --height=50% --border --header="📄 Recent Files")
    if [[ -n "$file" && -f "$file" ]]; then
      echo "$file"
      echo -n "$file" | xclip -selection clipboard 2>/dev/null
      echo "📋 Path copied to clipboard"
    fi
  else
    echo "No recent files found"
  fi
}

# Recent workspaces function  
sara_recent() {
  if [[ -f ~/.nayab_recent_workspaces ]]; then
    local workspace
    workspace=$(tac ~/.nayab_recent_workspaces | head -n 20 | fzf --height=50% --border --header="📁 Recent Workspaces")
    if [[ -n "$workspace" && -d "$workspace" ]]; then
      code "$workspace"
      echo "✅ Opened workspace: $(basename "$workspace")"
    fi
  else
    echo "No recent workspaces found"
  fi
}

weekly_cleanup() {
    echo "🧹 Running weekly cleanup..."
    
    # Clear package cache
    sudo apt autoclean
    sudo apt autoremove -y
    
    # Clear old logs
    sudo journalctl --vacuum-time=7d
    
    # Clear npm cache
    npm cache clean --force 2>/dev/null
    pnpm store prune 2>/dev/null
    
    # Clear pip cache
    pip3 cache purge
    
    # Clear thumbnail cache
    rm -rf ~/.cache/thumbnails/*
    
    # Clear browser cache (optional)
    rm -rf ~/.cache/google-chrome/Default/Cache/*
    rm -rf ~/.cache/mozilla/firefox/*/cache2/*
    
    echo "✅ Cleanup complete!"
    df -h | grep nvme0n1p9
}

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================

# Editor preferences
export EDITOR='code'
export VISUAL='code'
export PAGER='less'

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Path additions
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# ============================================================================
# FINAL SETUP
# ============================================================================

# Load Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# opencode
export PATH=/home/nayab-gauhar/.opencode/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
