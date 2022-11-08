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
    [Alias('Name')]
    [string]
    $ColorScheme,

    # The name or ID of the tab profiles the color scheme will be applied to.
    # If this is not provided, it will attempt to auto-detect based off of the window title.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Profile','GUID')]
    [string[]]
    $ProfileName,

    # If set, will pass thru the changes.
    [switch]
    $PassThru
    )

    process {

        $prof = Get-WTProfile -Global

        if ($_.Name -and $_.Guid) { # If we've been piped in a profile
            $ProfileName = $_.Guid
        }

        #region Find the tab profile target
        if (-not $ProfileName -and $env:WT_PROFILE_ID) {
            $ProfileName = $env:WT_PROFILE_ID
            if (-not $ProfileName) {
                Write-Warning "Could not find Windows Terminal profile.  Changing default instead."
            }
        }
        #endregion Find the tab profile target

        #region Change Tab profile target
        $changed = @()
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
                $changed +=$tabProf | Add-Member NoteProperty colorScheme $ColorScheme -Force -PassThru
            }
        }
        if (-not $changed -and -not $ProfileName) {
            if ($prof.profiles.default.colorScheme -ne $ColorScheme) {
                $changed += $prof.profiles.default |
                    Add-Member NoteProperty colorScheme $ColorScheme -Force -PassThru
            }
        }
        #endregion Change Tab profile target

        #region Update File
        if ($changed -and $PSCmdlet.ShouldProcess("Update $($prof.Path)")) {
            $wtPath = $prof.Path
            $prof.psobject.properties.Remove('Path')
            $json = $prof | ConvertTo-Json -Depth 100
            $tries = 3
            do {
                try {
                    [IO.File]::WriteAllText($wtPath, $JSON, [Text.Encoding]::UTF8)
                    break
                } catch {
                    $tries--
                    Write-Warning "$_ : $tries Left"
                    [Threading.Thread]::Sleep(100)
                }
            } while ($tries)
            $prof.psobject.properties.add([PSNoteProperty]::new('Path', $wtPath))
        }

        if ($WhatIfPreference) {
            $changed
        }

        if ($PassThru) {
            $changedNames = $changed | Select-Object -ExpandProperty colorScheme -Unique
            $prof.schemes |
                Where-Object {$changedNames -contains $_.Name } |
                ForEach-Object {
                    $_.pstypenames.clear()
                    $_.pstypenames.add('WindowsTerminal.ColorScheme')
                    $_
                }

        }
        #endregion Update File
    }
}