# ==================== Eza ====================
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'

# ==================== Git ====================
alias g='git'

# ==================== Gtrash ====================
alias gm='gtrash put' # gtrash move (easy to change to rm)
alias rm='echo -e "If you want to use rm really, then use $(tput bold)gm$(tput sgr0) instead." && false'
