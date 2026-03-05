Invoke-Expression (& { (zoxide init --cmd z powershell | Out-String) })

Set-Alias -Name cd -Value z -Force -Option AllScope
