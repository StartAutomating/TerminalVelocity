foreach ($file in Get-ChildItem $PSScriptRoot -Filter *-*.ps1) {
    . $file.Fullname
}