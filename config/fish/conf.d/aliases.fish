# ==================== Eza ====================
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'

# ==================== Git ====================
alias g='git'
alias ga='git add'
alias gps='git push'
alias gpl='git pull'
alias gcmsg='git commit --message'
alias gc='git commit'
alias gco='git checkout'
alias gb='git branch'
alias gcb='git checkout --branch'
alias gst='git status'
alias glog='git log --oneline --decorate'

# ==================== Gtrash ====================
alias gm='gtrash put'
alias rm='gtrash put'

# ==================== Editor ====================
alias vim="nvim"

function mkcd
    mkdir -p $argv[1]; and cd $argv[1]
end
