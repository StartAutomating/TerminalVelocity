function Add-WTProfile
{
    <#
    .Synopsis
        Adds a new Windows Terminal profile
    .Description
        Adds a new Windows Terminal tab profile.
    .Link
        New-WTProfile
    .Example
        Add-WTProfile -Name kali-linux-pwsh -CommandLine 'wsl -d kali-linux -e pwsh'
    #>
    [OutputType('Nullable','WindowsTerminal.Profile')]
    [CmdletBinding(SupportsShouldProcess)]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSAvoidDefaultValueSwitchParameter", "", Justification="Needed by Schema"
    )]
    param(
    # Name of the profile. Displays in the dropdown menu.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('ProfileName')]
    [string]
    $Name,

    <#
    When useAcrylic is set to true, it sets the transparency of the window for the profile.
    Accepts floating point values from 0-1 (default 0.5).
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [float]
    $AcrylicOpacity=0.5,
    <#
    Controls how text is antialiased in the renderer.
    Possible values are "grayscale", "cleartype" and "aliased".
    Note that changing this setting will require starting a new terminal instance.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('grayscale','cleartype','aliased')]
    [string]
    $AntialiasingMode= 'grayscale',
    <#
    Sets the background color of the profile.
    Overrides background set in color scheme if colorscheme is set.
    Uses hex color format: "#rrggbb".
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Background= '#0c0c0c',
    # Sets the file location of the Image to draw over the window background.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $BackgroundImage,
    # Sets the alignment of the Image to draw over the window background.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('bottom','bottomLeft','bottomRight','center','left','right','top','topLeft','topRight')]
    [string]
    $BackgroundImageAlignment= 'center',
    # Sets the opacity of the Image to draw over the window background.
    [Parameter(ValueFromPipelineByPropertyName)]
    [float]
    $BackgroundImageOpacity,
    <#
    Sets how the background image is resized to fill the window.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('fill','none','uniform','uniformToFill')]
    [string]
    $BackgroundImageStretchMode= 'uniformToFill',
    <#
    Sets how the profile reacts to termination or failure to launch.
     Possible values: "graceful" (close when exit is typed or the process exits normally), "always" (always close) and "never" (never close).
     true and false are accepted as synonyms for "graceful" and "never" respectively.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('fill','none','uniform','uniformToFill')]
    $CloseOnExit,
    <#
    Name of the terminal color scheme to use.
     Color schemes are defined under "schemes".
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $ColorScheme= 'Campbell',
    <#
    Array of colors used in the profile if colorscheme is not set.
     Colors use hex color format: "#rrggbb".
     Ordering is as follows: [black, red, green, yellow, blue, magenta, cyan, white, bright black, bright red, bright green, bright yellow, bright blue, bright magenta, bright cyan, bright white]
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    $ColorTable,
    <#
    Executable used in the profile.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Commandline,
    <#
    A GUID reference to a connection type.
     Currently undocumented as of 0.
    3, this is used for Azure Cloud Shell
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^\{[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\}$')]
    [string]
    $ConnectionType= '{}',
    <#
    Sets the cursor color for the profile.
     Uses hex color format: "#rrggbb".
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $CursorColor= '#',
    <#
    Sets the percentage height of the cursor starting from the bottom.
     Only works when cursorShape is set to "vintage".
     Accepts values from 25-100.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateRange(25,100)]
    [int]
    $CursorHeight,
    <#
    Sets the cursor shape for the profile.
     Possible values: "vintage" ( ▃ ), "bar" ( ┃, default ), "underscore" ( ▁ ), "filledBox" ( █ ), "emptyBox" ( ▯ )
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('bar','emptyBox','filledBox','underscore','vintage')]
    [string]
    $CursorShape= 'bar',

    <#
    Name of the font face used in the profile.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $FontFace= 'Consolas',
    <#
    Sets the font size.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $FontSize=12,
    <#
    Sets the foreground color of the profile.
     Overrides foreground set in color scheme if colorscheme is set.
     Uses hex color format: "#rrggbb".
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Foreground= '#cccccc',
    <#
    Unique identifier of the profile.
     Written in registry format: "{00000000-0000-0000-0000-000000000000}".
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^\{[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\}$')]
    [string]
    $Guid= $("{$([GUID]::NewGuid())}"),
    <#
    If set to true, the profile will not appear in the list of profiles.
     This can be used to hide default profiles and dynamically generated profiles, while leaving them in your settings file.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Hidden,
    <#
    The number of lines above the ones displayed in the window you can scroll back to.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $HistorySize=9001,
    <#
    Image file location of the icon used in the profile.
     Displays within the tab and the dropdown menu.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Icon,
    <#
    Sets the padding around the text within the window.
     Can have three different formats: "#" sets the same padding for all sides, "#, #" sets the same padding for left-right and top-bottom, and "#, #, #, #" sets the padding individually for left, top, right, and bottom.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^-?[0-9]+(\.[0-9]+)?( *, *-?[0-9]+(\.[0-9]+)?|( *, *-?[0-9]+(\.[0-9]+)?){3})?$')]
    [string]
    $Padding= '8, 8, 8, 8',
    <#
    Defines the visibility of the scrollbar.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('visible','hidden')]
    [string]
    $ScrollbarState= 'visible',
    <#
    Sets the selection background color of the profile.
     Overrides selection background set in color scheme if colorscheme is set.
     Uses hex color format: "#rrggbb".
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $SelectionBackground= '#',
    <#
    When set to true, the window will scroll to the command input line when typing.
     When set to false, the window will not scroll when you start typing.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $SnapOnInput= $True,
    <#
    Stores the name of the profile generator that originated this profile.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Source,
    <#
    The directory the shell starts in when it is loaded.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $StartingDirectory,
    <#
    When set to true, tabTitle overrides the default title of the tab and any title change messages from the application will be suppressed.
     When set to false, tabTitle behaves as normal.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $SuppressApplicationTitle,
    <#
    If set, will replace the name as the title to pass to the shell on startup.
     Some shells (like bash) may choose to ignore this initial value, while others (cmd, powershell) may use this value over the lifetime of the application.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $TabTitle,
    <#
    When set to true, the window will have an acrylic background.
     When set to false, the window will have a plain, untextured background.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $UseAcrylic
    )
    process {
        #region Create Profile Object
        $newProfile = [Ordered]@{}
        if (-not $PSBoundParameters['GUID']) {
            $PSBoundParameters['GUID'] = $Guid
        }
        foreach ($p in $PSBoundParameters.Keys) {
            $k = $p.Substring(0,1).ToLower() + $p.Substring(1)
            $newProfile[$k] = $ExecutionContext.SessionState.PSVariable.Get($p).Value
            if ($null, '' -contains $newProfile[$k]) {
                $newProfile.Remove($k)
            }
            if ($newProfile[$k] -is [switch]) {
                $newProfile[$k] = $newProfile[$k] -as [bool]
            }
        }
        $newProfile = [PSCustomObject]$newProfile
        #endregion Profile Object


        #region Update Windows Terminal Profile
        $wtProfile = Get-WTProfile -Global          # Get our profile
        $wtProfile.profiles |                       # Add out new profile to the list,
            Add-Member NoteProperty list @(
                $newProfile
                foreach ($_ in $wtProfile.profiles.list) {
                    if ($guid -ne $_.Guid -and $name -ne $_.Name)          # and don't forget all of the other ones.
                    {
                        $_
                    }
                }
            ) -Force
        $wtPath = $wtProfile.Path
        if ($PSCmdlet.ShouldProcess("Add Profile $Name to $wtPath")) # If we ShouldProcess
        {
            $wtProfile.psobject.properties.Remove('Path')
            $wtProfile |                                 # turn the profile
                ConvertTo-Json -Depth 100 |              # back into JSON
                Set-Content -Path $wtPath -Encoding UTF8 # and write it to disk.
        }
        elseif ($WhatIfPreference) # if we wanted to know -WhatIf
        {
            return $wtProfile      # return the JSON object
        }
        #endregion Update Windows Terminal Profile
    }
}
