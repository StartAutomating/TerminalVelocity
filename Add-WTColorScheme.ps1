function Add-WTColorScheme
{
    <#
    .Synopsis
        Adds a Windows Terminal Color Scheme
    .Description
        Adds a Windows Terminal Color Scheme, including any scheme from https://iterm2colorschemes.com/
    .Example
        Add-WTColorScheme -Name AdventureTime
    .Link
        https://iterm2colorschemes.com/
    #>
    [OutputType([Nullable])]
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='Medium')]
    param(
    # The name of the color scheme.
    # If the name exists on https://iterm2colorschemes.com/, then no other parameters are needed.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [string]
    $Name,

    # The scheme's definition of the color Black.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Black = '#010101',

    # The scheme's definition of the color Red.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Red = '#dd0000',

    # The scheme's definition of the color Green.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Green = '#00dd00',

    # The scheme's definition of the color Yellow.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Yellow = '#dddd00',

    # The scheme's definition of the color Blue.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Blue = '#0000dd',

    # The scheme's definition of the color Cyan.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Cyan = '#00dddd',

    # The scheme's definition of the color Purple.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [Alias('Magenta')]
    [string]
    $Purple = '#dd00dd',

    # The scheme's definition of the color White.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $White = '#efefef',

    # The scheme's definition of the color BrightRed.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightRed = '#ff0000',

    # The scheme's definition of the color BrightGreen.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightGreen = '#00ff00',

    # The scheme's definition of the color BrightYellow.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightYellow = '#ffff00',

    # The scheme's definition of the color BrightBlue.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightBlue = '#0000ff',

    # The scheme's definition of the color BrightPurple.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightPurple = '#ff00ff',

    # The scheme's definition of the color BrightCyan.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightCyan = '#00ffff',

    # The scheme's definition of the color BrightWhite.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightWhite = '#ffffff',

    # The scheme's definition of the color BrightBlack.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightBlack = '#0d0d0d',

    # The scheme's foreground color.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Foreground = '#fefefe',

    # The scheme's background color.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Background = '#012456'
    )

    process {
        #region Download iTerm2 Theme

        $iTermRepo = 'mbadolato/iTerm2-Color-Schemes/master/windowsterminal'
        $iTermThemeExists =
            Invoke-RestMethod -Uri "https://raw.githubusercontent.com/$iTermRepo/$Name.json" -ErrorAction Ignore
        #endregion Download iTerm2 Theme

        #region Create Color Scheme Object
        $newScheme =
            if ($iTermThemeExists)
            {
                # If the theme exists, let them customize it.
                foreach ($k in $PSBoundParameters.Keys) {
                                                    # Any supplied parameter
                    if ($k -ne 'Name' -and          # except name
                        $iTermThemeExists.$k        # that exists in the theme
                    ) {
                        $iTermThemeExists.$k =      # will be overwritten
                            $PSBoundParameters[$k]  # with the supplied parameter.
                    }
                }
                $iTermThemeExists
            }
            else
            {
                # If the theme does not exist,
                if ($PSBoundParameters.Count -eq 1)
                {
                    # and no other parameters are supplied, warn them.
                    Write-Warning "Theme $Name does not exist on https://iterm2colorschemes.com/"
                }

                $myCmdMetaData  = [Management.Automation.CommandMetaData]$MyInvocation.MyCommand
                # Create a color scheme object
                $newColorScheme = [Ordered]@{}
                # by walking over each parameter in this command.
                foreach ($p in $myCmdMetaData.Parameters.Keys) {
                    # lowercase the first letter of the name, because JSON can be picky.
                    $k = $p.Substring(0,1).ToLower() + $p.Substring(1)
                    $newColorScheme[$k] = # and assign it to the variable value,
                        $ExecutionContext.SessionState.PSVariable.Get($p).Value # because this will handle defaults.
                }
                [PSCustomObject]$newColorScheme
            }
        #endregion Create Color Scheme Object


        #region Update Windows Terminal Profile

        $wtProfile = Get-WTProfile -Global # Get our profile
        $wtProfile |                       # Add out color scheme to the list,
            Add-Member NoteProperty schemes @(
                $newScheme
                foreach ($_ in $wtProfile.schemes) {
                    if ($_.Name -ne $Name) # and don't forget all of the other ones.
                    { $_ }
                }
            ) -Force
        $wtPath = $wtProfile.Path
        if ($PSCmdlet.ShouldProcess("Add ColorScheme $Name to $wtPath")) # If we ShouldProcess
        {

            $wtProfile.psobject.properties.Remove('Path')
            $wtProfile |                                 # turn the profile
                ConvertTo-Json -Depth 100 |              # back into JSON
                Set-Content -Path $wtPath -Encoding UTF8 # and write it to disk.
            $wtProfile.psobject.properties.add([PSNoteProperty]::new('Path', $wtPath))
        }
        elseif ($WhatIfPreference) # if we wanted to know -WhatIf
        {
            return $wtProfile      # return the JSON object
        }
        #endregion Update Windows Terminal Profile
    }
}