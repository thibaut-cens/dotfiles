$conf_dir=$(Join-Path $PSScriptRoot 'conf.d')
echo "Loading PowerShell profile from $conf_dir"

Get-ChildItem -Recurse -Path $conf_dir -Filter *.ps1 | ForEach-Object {
    $path = $_.FullName
    Write-Host "Loading $path"
    . $path
}

