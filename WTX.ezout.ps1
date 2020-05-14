#requires -Module EZOut
#  Install-Module EZOut or https://github.com/StartAutomating/EZOut
$myFile = $MyInvocation.MyCommand.ScriptBlock.File
$myModuleName = $($myFile | Split-Path -Leaf) -replace '\.ezformat\.ps1', '' -replace '\.ezout\.ps1', ''
$myRoot = $myFile | Split-Path
Push-Location $myRoot
$formatting = @(
    # Add your own Write-FormatView here,
    # or put them in a Formatting or Views directory
    foreach ($potentialDirectory in 'Formatting','Views') {
        Join-Path $myRoot $potentialDirectory |
            Get-ChildItem -ea ignore |
            Import-FormatView -FilePath {$_.Fullname}
    }
)

$destinationRoot = $myRoot

if ($formatting) {
    $myFormatFile = Join-Path $destinationRoot "$myModuleName.format.ps1xml"
    $formatting | Out-FormatData -Module $MyModuleName | Set-Content $myFormatFile -Encoding UTF8
}

$types = @(
    # Add your own Write-TypeView statements here
    # or declare them in the 'Types' directory
    Join-Path $myRoot Types |
        Get-ChildItem -ea ignore |
        Import-TypeView

)

if ($types) {
    $myTypesFile = Join-Path $destinationRoot "$myModuleName.types.ps1xml"
    $types | Out-TypeData | Set-Content $myTypesFile -Encoding UTF8
}
Pop-Location
