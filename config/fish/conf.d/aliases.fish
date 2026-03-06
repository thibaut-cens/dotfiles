# ==================== Eza ====================
alias eza='command eza --icons=auto'
alias ls='eza'

abbr --add l --position command -- ls -lh
abbr --add ll --position command -- ls -lha
abbr --add ld --position command -- ls -lhd
abbr --add lt --position command -- eza -lh --tree

# ==================== Git ====================
abbr --add --position command g -- git
abbr --add --position command ga -- git add
abbr --add --position command gps -- git push
abbr --add --position command gpl -- git pull
abbr --add --position command gcmsg -- git commit --message
abbr --add --position command gc -- git commit
abbr --add --position command gco -- git checkout
abbr --add --position command gb -- git branch
abbr --add --position command gcb -- git checkout --branch
abbr --add --position command gst -- git status
abbr --add --position command glog -- git log --oneline --decorate
abbr --add --position command gd -- git diff

# ==================== Gtrash ====================
alias gm='gtrash put'
abbr --add --position command rm -- gm

# ==================== Editor ====================
abbr --add --position command vim -- nvim

function mkcd
    mkdir -p $argv[1]; and cd $argv[1]
end
