function Set-WTColorScheme
{
    <#
    .Synopsis
        Sets the Windows Terminal Color Scheme
    .Description
        Sets the color scheme used by a given tab profile in Windows Terminal.

        If the tab profile is not provided, it will attempt to auto-detect based off of the window title.
    .Example
        Set-WTColorScheme -ColorScheme 'AdventureTime'
    .Example
        Get-WTProfile -Name 'PowerShell' |
            Set-WTColorScheme 'AdventureTime'
    .Link
        Add-WTColorScheme
    .Link
        Get-WTColorScheme
    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='Medium')]
    [OutputType([Nullable])]
    param(
    # The name of the color scheme
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [string]
    $ColorScheme,

    # The name or ID of the tab profiles the color scheme will be applied to.
    # If this is not provided, it will attempt to auto-detect based off of the window title.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Profile','GUID','Name')]
    [string[]]
    $ProfileName
    )

    process {

        $prof = Get-WTProfile -Global

        #region Find the tab profile target
        if (-not $ProfileName -and $env:WT_PROFILE_ID) {
            $ProfileName = $env:WT_PROFILE_ID
            if (-not $ProfileName) {
                Write-Warning "Could not find Windows Terminal profile.  Changing default instead."
            }
        }
        #endregion Find the tab profile target

        #region Change Tab profile target
        $changed = $false
        foreach ($tabProf in $prof.profiles.list) {
            if ($ProfileName) {
                $ok = $false
                foreach ($tp in $ProfileName) {
                    if ($tabProf.Name -like $tp -or
                        $tabProf.Guid -eq   $tp -or
                        $tabProf.Guid -eq "{$tp}"
                    )
                    {
                        $ok = $true
                        break
                    }
                }
            }

            if ($ok -and $tabProf.colorScheme -ne $ColorScheme) {
                $tabProf | Add-Member NoteProperty colorScheme $ColorScheme -Force
                $changed = $true
            }
        }
        if (-not $changed -and -not $ProfileName) {
            if ($prof.profiles.default.colorScheme -ne $ColorScheme) {
                $prof.profiles.default |
                    Add-Member NoteProperty colorScheme $ColorScheme -Force
                $changed = $true
            }
        }
        #endregion Change Tab profile target

        #region Update File
        if ($changed -and $PSCmdlet.ShouldProcess("Update $($prof.Path)")) {
            $wtPath = $prof.Path
            $prof.psobject.properties.Remove('Path')
            $prof |
                ConvertTo-Json -Depth 100 |
                Set-Content -LiteralPath $wtPath -Force -Encoding UTF8
        } elseif ($WhatIfPreference) {
            $prof
        }
        #endregion Update File
    }
}