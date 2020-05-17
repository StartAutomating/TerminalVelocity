function Backup-WTProfile
{
    <#
    .Synopsis
        Backs up the Windows Terminal Profile
    .Description
        Backs up the Windows Terminal Profile.

        By default, backups will be placed in the same directory as $profile, and will include a datestamp.
    .Link
        Get-WTProfile
    .Example
        Backup-WTProfile
    #>
    param(
    # The destination path for the backup.
    # By default, this will be in the same directory as $profile, and will include a datestamp.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $DestinationPath
    )

    process {
        if (-not $DestinationPath) {
            $DestinationPath = $profile |
                Split-Path |
                Join-Path -ChildPath "WindowsTerminal.$([DateTime]::Now.ToString('yyyy-MM-dd')).backup.json"
            $null = New-Item -ItemType File -Path $DestinationPath -Force
        }

        $sourcePath =
            if (-not $script:WTProfilePath) {
                Get-WTProfile -Setting | Select-Object -ExpandProperty Path
            } else {
                $script:WTProfilePath.Fullname
            }
        if (-not $sourcePath) { return }


        Copy-Item -LiteralPath $sourcePath -Destination $DestinationPath -Force
    }
}