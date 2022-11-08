foreach ($file in Get-ChildItem $PSScriptRoot -Filter *-*.ps1) {
    if ($file.Name -match '\.ps{0,1}\.ps1$') { continue }
    . $file.Fullname
}