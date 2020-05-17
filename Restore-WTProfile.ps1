function Restore-WTProfile
{
    <#
    .Synopsis
        Restores a Windows Terminal Profile
    .Description
        Restores a Windows Terminal Profile backup.
    .Example
        Restore-WTProfile -SourcePath .\WindowsTerminal.2020-05-17.backup.json
    .Link
        Backup-WTProfile
    #>
    param(
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [ValidatePattern('\.json$')]
    [Alias('FullName')]
    [string]
    $SourcePath
    )

    process {
        $destPath =
            if (-not $script:WTProfilePath) {
                Get-WTProfile -Setting | Select-Object -ExpandProperty Path
            } else {
                $script:WTProfilePath.Fullname
            }

        if ((Test-Path $SourcePath) -and $destPath) {
            Copy-Item -Path $SourcePath -Destination $destPath
        }
    }
}
