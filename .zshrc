# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Optional: Flutter and Android SDK paths
# export PATH="$PATH:$HOME/develop/flutter/bin"
# export ANDROID_SDK_ROOT=$HOME/Android/Sdk
# export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
# export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# ============================================================================
# ZSH CONFIGURATION
# ============================================================================

# History settings
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

# Completion system
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
unsetopt MENU_COMPLETE

# Directory navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

# Globbing
setopt EXTENDED_GLOB
setopt GLOB_DOTS

# Auto correction
setopt CORRECT
setopt CORRECT_ALL

# ============================================================================
# PLUGINS
# ============================================================================
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    z
    colored-man-pages
    command-not-found
    extract
    sudo
    copypath
    copyfile
)

source $ZSH/oh-my-zsh.sh

# ============================================================================
# FZF INTEGRATION
# ============================================================================

# Auto-install fzf if not present
if ! command -v fzf &> /dev/null; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# FZF configuration
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

# FZF previews
export FZF_CTRL_T_OPTS="--preview 'batcat --style=numbers --color=always {} 2>/dev/null || cat {}'"
export FZF_ALT_C_OPTS="--preview 'exa --tree --level=2 {} 2>/dev/null || ls -la {}'"

# ============================================================================
# ALIASES
# ============================================================================

# ls with exa if available
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

# cat with bat if available
if command -v batcat &> /dev/null; then
    alias cat='batcat'
elif command -v bat &> /dev/null; then
    alias cat='bat'
fi

# Git shortcuts
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

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# System
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

# Config
alias zshconfig='code ~/.zshrc'
alias zshreload='source ~/.zshrc'

# Tools
alias fd='fdfind'

# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================

# Quick open YouTube
youtube() {
    xdg-open https://www.youtube.com/
}

# System information dashboard
sysinfo() {
    echo "SYSTEM INFORMATION"
    echo "========================================="
    echo "Hostname: $(hostname)"
    echo "User: $(whoami)"
    echo "OS: $(lsb_release -d | cut -f2)"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"
    echo ""
    echo "HARDWARE"
    echo "-----------------------------------------"
    echo "CPU: $(lscpu | grep 'Model name' | cut -d: -f2 | xargs)"
    echo "Cores: $(nproc)"
    echo "CPU Usage: $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')"
    echo ""
    echo "MEMORY"
    echo "-----------------------------------------"
    free -h | awk '/^Mem:/ {print "Total: " $2}'
    free -h | awk '/^Mem:/ {print "Used: " $3}'
    free -h | awk '/^Mem:/ {print "Free: " $7}'
    free -h | awk '/^Swap:/ {if($2 != "0B") print "Swap: " $3 "/" $2}'
    echo ""
    echo "STORAGE"
    echo "-----------------------------------------"
    df -h | grep '^/dev' | awk '{print $1 ": " $3 "/" $2 " (" $5 " used)"}'
    echo ""
    echo "NETWORK"
    echo "-----------------------------------------"
    echo "Internal IP: $(hostname -I | awk '{print $1}')"
    if command -v curl &> /dev/null; then
        echo "External IP: $(curl -s ifconfig.me 2>/dev/null || echo 'Not available')"
    fi
    echo ""
    echo "UPTIME & LOAD"
    echo "-----------------------------------------"
    echo "Uptime: $(uptime -p)"
    echo "Load: $(uptime | awk -F'load average:' '{print $2}')"
    echo ""
    echo "PROCESSES"
    echo "-----------------------------------------"
    echo "Total: $(ps aux | wc -l)"
    echo "Running: $(ps aux | awk '$8 ~ /R/ {count++} END {print count+0}')"
    echo "Sleeping: $(ps aux | awk '$8 ~ /S/ {count++} END {print count+0}')"
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
# CUSTOM PATH FINDER & FILE BROWSER
# ============================================================================

# Quick path finder with clipboard copy
nayab() {
    local file
    file=$(fd . ~ 2>/dev/null | fzf \
        --height=80% \
        --layout=reverse \
        --border=rounded \
        --info=inline \
        --header="Path Finder | Enter: select | ESC: quit" \
        --no-preview)
    
    if [[ -n "$file" ]]; then
        echo "$file"
        echo -n "$file" | xclip -selection clipboard 2>/dev/null && echo "Path copied to clipboard"
    fi
}

# File browser with VS Code integration
sara() {
    local selection
    
    selection=$(fd . ~ 2>/dev/null | fzf \
        --height=90% \
        --layout=reverse \
        --border=rounded \
        --info=inline \
        --header="VS Code Launcher | Enter: open | Ctrl-O: system open | Ctrl-F: open folder" \
        --preview-window='right:50%:wrap' \
        --bind='ctrl-o:execute(xdg-open {} &)' \
        --bind='ctrl-f:execute(xdg-open "$(dirname {})" &)' \
        --bind='ctrl-r:reload(fd . ~ 2>/dev/null)' \
        --preview '
            if [[ -f {} ]]; then
                echo "FILE: $(basename {})"
                echo "Path: {}"
                echo "Size: $(du -h {} 2>/dev/null | cut -f1)"
                echo "Modified: $(stat -c %y {} 2>/dev/null | cut -d. -f1)"
                echo "Type: $(file -b {} 2>/dev/null)"
                echo "----------------------------------------"
                
                case {} in
                    *.md|*.txt|*.py|*.js|*.sh|*.json|*.yaml|*.yml|*.html|*.css|*.cpp|*.c|*.java|*.go|*.rs|*.php)
                        batcat --style=numbers --color=always --line-range=:30 {} 2>/dev/null || head -n 30 {}
                        ;;
                    *.pdf)
                        pdftotext {} - 2>/dev/null | head -n 20 || echo "PDF file"
                        ;;
                    *.zip|*.tar|*.tar.gz|*.tgz|*.rar|*.7z)
                        echo "ARCHIVE CONTENTS:"
                        case {} in
                            *.zip) zipinfo -1 {} 2>/dev/null | head -n 15 ;;
                            *.tar|*.tar.gz|*.tgz) tar -tf {} 2>/dev/null | head -n 15 ;;
                        esac
                        ;;
                    *)
                        file {} 2>/dev/null | grep -q "text" && head -n 20 {} || file {} 2>/dev/null
                        ;;
                esac
            elif [[ -d {} ]]; then
                echo "DIRECTORY: $(basename {})"
                echo "Path: {}"
                echo "Items: $(find {} -maxdepth 1 2>/dev/null | wc -l)"
                echo "Size: $(du -sh {} 2>/dev/null | cut -f1)"
                echo "----------------------------------------"
                ls -lah {} 2>/dev/null | head -n 20
            fi
        ')
    
    if [[ -n "$selection" ]]; then
        if ! command -v code &> /dev/null; then
            echo "VS Code not found. Opening with default application..."
            xdg-open "$selection" &
            return 1
        fi
        
        if [[ -f "$selection" ]]; then
            code "$selection"
            echo "$selection" >> ~/.sara_recent_files 2>/dev/null
        elif [[ -d "$selection" ]]; then
            code "$selection"
            echo "$selection" >> ~/.sara_recent_workspaces 2>/dev/null
        fi
    fi
}

# Recent files
nayab_recent() {
    if [[ -f ~/.sara_recent_files ]]; then
        local file
        file=$(tac ~/.sara_recent_files | head -n 20 | fzf --height=50% --border --header="Recent Files")
        if [[ -n "$file" && -f "$file" ]]; then
            echo "$file"
            echo -n "$file" | xclip -selection clipboard 2>/dev/null && echo "Path copied"
        fi
    else
        echo "No recent files found"
    fi
}

# Recent workspaces
sara_recent() {
    if [[ -f ~/.sara_recent_workspaces ]]; then
        local workspace
        workspace=$(tac ~/.sara_recent_workspaces | head -n 20 | fzf --height=50% --border --header="Recent Workspaces")
        if [[ -n "$workspace" && -d "$workspace" ]]; then
            code "$workspace"
            echo "Opened: $(basename "$workspace")"
        fi
    else
        echo "No recent workspaces found"
    fi
}

# System cleanup
weekly_cleanup() {
    echo "Running system cleanup..."
    
    sudo apt autoclean
    sudo apt autoremove -y
    sudo journalctl --vacuum-time=7d
    
    npm cache clean --force 2>/dev/null
    pnpm store prune 2>/dev/null
    pip3 cache purge 2>/dev/null
    
    rm -rf ~/.cache/thumbnails/*
    rm -rf ~/.cache/google-chrome/Default/Cache/* 2>/dev/null
    rm -rf ~/.cache/mozilla/firefox/*/cache2/* 2>/dev/null
    
    echo "Cleanup complete"
    df -h | grep -E '^/dev'
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

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
