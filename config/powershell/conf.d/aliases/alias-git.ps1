function Git-CommitMsg {
    git commit -m $Args
}
Set-Alias -Name gcm -Value Git-CommitMsg -Force
Set-Alias -Name gcmsg -Value Git-CommitMsg

function Git-Push {
    git push
}
Set-Alias -Name gps -Value Git-Push -Force

function Git-Pull {
    git pull
}
Set-Alias -Name gpl -Value Git-Pull

function Git-Status {
    git status
}
Set-Alias -Name gs -Value Git-Status
Set-Alias -Name gst -Value Git-Status

function Git-Checkout {
    git checkout $Args
}
Set-Alias -Name gco -Value Git-Checkout

function Git-CheckoutNewBranch {
    git checkout -b $Args
}
Set-Alias -Name gcb -Value Git-CheckoutNewBranch

function Git-Add {
    git add $Args
}
Set-Alias -Name ga -Value Git-Add

function Git-Remove {
    git rm $Args
}
Set-Alias -Name grm -Value Git-Remove

function Git-Log {
    git log --oneline --decorate --graph --all $Args
}
Set-Alias -Name gl -Value Git-Log -Force
Set-Alias -Name glog -Value Git-Log

