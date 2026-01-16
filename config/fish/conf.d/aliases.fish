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
alias gbr='git checkout --branch'
alias gst='git status'
alias glog='git log --oneline --decorate'

# ==================== Gtrash ====================
alias gm='gtrash put' # gtrash move (easy to change to rm)
alias rm='echo -e "If you want to use rm really, then use $(tput bold)gm$(tput sgr0) instead." && false'

# ==================== Editor ====================
alias vim="nvim"
