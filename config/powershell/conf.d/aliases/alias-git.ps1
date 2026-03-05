function gcmsg {
    git commit -m $Args
}

function gps {
    git push
}

function gpl {
    git pull
}

function gst {
    git status
}

function gco {
    git checkout $Args
}

function gcb {
    git checkout -b $Args
}

function ga {
    git add $Args
}

function grm {
    git rm $Args
}

function glog {
    git log --oneline --decorate --graph --all
}
