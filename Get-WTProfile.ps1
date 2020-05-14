function Get-WTProfile
{
    <#
    .Synopsis
        Gets a Windows Terminal Profiles
    .Description
        Gets Windows Terminal profiles.

        By default, Get-WTProfile gets all tab profiles.

        To get the global profile, use Get-WTProfile -Global

        To get color schemes, use Get-WTProfile -ColorScheme *
    .Link
        Set-WTProfile
    .Example
        Get-WTProfile
    .Example
        Get-WTProfile -Global
    #>
    [CmdletBinding(DefaultParameterSetName='Name')]
    [OutputType('WindowsTerminal.Profile','WindowsTerminal.ColorScheme')]
    param(
    # Returns Windows Terminal tab profiles, by name.
    [Parameter(ParameterSetName='Name',ValueFromPipelineByPropertyName)]
    [Alias('Name')]
    [string[]]
    $ProfileName,

    # Returns Windows Terminal tab profiles, by GUID.
    [Parameter(ParameterSetName='Guid',ValueFromPipelineByPropertyName)]
    [Guid[]]
    $Guid,

    # Returns Windows Terminal Color Schemes
    [Parameter(ParameterSetName='ColorScheme',ValueFromPipelineByPropertyName)]
    [string[]]
    $ColorScheme,

    # If -Global is present, Get-WTProfile returns the global profile.
    [Parameter(Mandatory,ParameterSetName='Global',ValueFromPipelineByPropertyName)]
    [Alias('Setting', 'Settings')]
    [switch]
    $Global,

    # If -Default is present, Get-WTProfile returns the default profile settings.
    [Parameter(Mandatory,ParameterSetName='Default',ValueFromPipelineByPropertyName)]
    [Alias('Defaults')]
    [switch]
    $Default,

    # If -Current is present, Get-WTProfile attempts to determine the current profile
    [Parameter(Mandatory,ParameterSetName='Current',ValueFromPipelineByPropertyName)]
    [switch]
    $Current
    )

    begin {
        #region Locate the Profile
        if (-not $script:WTProfilePath) {
            $script:WTProfilePath =
                if ($PSVersionTable.Platform -ne 'Windows' -and (Test-Path '/mnt')) {
                    Get-ChildItem '/mnt' |
                        Get-ChildItem -Filter Users -ErrorAction Ignore |
                        Get-ChildItem -Filter $env:USER |
                        Get-ChildItem -Filter AppData -Force |
                        Get-ChildItem -Filter Local -Force |
                        Get-ChildItem -Filter Packages  |
                        Get-ChildItem -Filter Microsoft.WindowsTerminal_* |
                        Get-ChildItem -Filter LocalState |
                        Get-ChildItem -Filter settings.json
                } elseif ($PSVersionTable.Platform -like 'Win*' -or -not $PSVersionTable.Platform) {
                    Resolve-Path "$env:APPDATA\..\Local\Packages" |
                        Get-ChildItem -Filter Microsoft.WindowsTerminal_* |
                        Get-ChildItem -Filter LocalState |
                        Get-ChildItem -Filter settings.json
                }
        }
        #endregion Locate the Profile

        if ($PSVersionTable.PSVersion -lt '7.0') {
# If we're using an older version of PowerShell, ConvertFrom-JSON won't handle comments.
# So override it.
function ConvertFrom-Json
{
    [CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=217031', RemotingCapability='None')]
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
        [AllowEmptyString()]
        [string]
        ${InputObject}
    )

    begin
    {
        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
            {
                $PSBoundParameters['OutBuffer'] = 1
            }
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\ConvertFrom-Json', [System.Management.Automation.CommandTypes]::Cmdlet)
            $scriptCmd = {& $wrappedCmd @PSBoundParameters }
            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
        } catch {
            $_ | Write-Error
        }

        $regexTimeout = [Timespan]'00:00:02.5'

        # This RegEx will match block comments in JSON.
    $JSONBlockComments = [Regex]::new('
/\*         # The open comment
(?<Block>   # capture the comment block.  It is:
(?:.|\s)+?  # anything until
(?=\z|\*/)  # the end of the string or the closing comment
)\*/        # Then match the close comment
', 'IgnoreCase, IgnorePatternWhitespace', $regexTimeout)
}

    process
    {
        try {
            if ($PSBoundParameters.InputObject) {
                $_ = $PSBoundParameters.InputObject
            }


            # First, strip block comments
            $inObj = $_
            $in =
                if ($InputObject.Contains('*/')) {
                    $JSONBlockComments.Replace($inObj,'')
                } else {
                    $InputObject
                }

            $hasComment = [regex]::new('(?:^|[^:])//','IgnoreCase',$regexTimeout)
            $CommentOrQuote = [Regex]::new("(?>(?<CommentStart>//)|(?<SingleQuote>(?<!')')|(?<DoubleQuote>(?<!\\)`"))", 'IgnoreCase', '00:00:15')

            $in = if (-not $hasComment.IsMatch($in)) { # If the JSON contained no comments, pass it directly down
                $in
            } else {
                $lines = $in -split "(?>\r\n|\n)"
                $newlines = foreach ($line in $lines) { # otherwise, go line by line looking for comments.
                    $lineHasComments = try { $hasComment.IsMatch($line) } catch {$false}
                    if (-not $lineHasComments) { $line;continue } # If the line didn't contain a comment, echo it.

                    $lineParts =
                        try { $CommentOrQuote.Matches($line) }
                        catch{ $null }
                    if (-not $lineParts) {
                        $line
                        continue
                    }
                    $trimAt = -1

                    $singleQuoteCounter = 0
                    $doubleQuoteCounter = 0
                    foreach ($lp in $lineParts) { # Count up thru the quotes.
                        if ($lp.Groups["SingleQuote"].Success) {
                            $singleQuoteCounter++
                        }
                        if ($lp.Groups["DoubleQuote"].Success) {
                            $doubleQuoteCounter++
                        }
                        if ($lp.Groups["CommentStart"].Success -and
                            -not ($singleQuoteCounter % 2) -and
                            -not ($doubleQuoteCounter % 2)) { # If the comment occurs while the quotes are balanced

                            $trimAt = $lp.Index # that's where we trim.
                            break
                        }
                    }
                    if ($trimAt -ne -1) { # If we know where to chop the line
                        $line.Substring(0, $trimAt) # get everything up until that point
                    } else { # otherwise,
                        $line  # echo the line.
                    }
                }
                $newlines -join [Environment]::NewLine
            }

            if ($PSBoundParameters.InputObject) {
                $PSBoundParameters.InputObject = $in
                $steppablePipeline.Process($PSBoundParameters.InputObject)
            } else {
                $steppablePipeline.Process(
                    $in
                )
            }

        } catch {
            $_ | Write-Error
        }
    }

    end
    {
        try {
            $steppablePipeline.End()
        } catch {
            $_ | Write-Error
        }
    }
}
        }
    }

    process {
        if (-not $script:WTProfilePath) # If we could not find the profile
        {
            Write-Error "Could not locate Windows Terminal profile"  # error and return.
            return
        }

        $paramSet = $PSCmdlet.ParameterSetName
        if ($_.Guid -as [guid] -and $_.Name) { # If we were passed an input object with a GUID
            $paramSet = 'Guid'                 # trick the parameter set so we match just that one.
            $guid = $_.Guid
        }

        $wtProfile =
            [IO.File]::ReadAllText($script:WTProfilePath.FullName) | # Read the profile
                ConvertFrom-Json                                     # convert it from JSON
        $wtProfile.pstypenames.clear()
        $wtProfile.pstypenames.add('WindowsTerminal.Settings')       # decorate it as a 'WindowsTerminal.Settings'
        $wtProfile |                                                 # and keep the path
            Add-Member NoteProperty Path $script:WTProfilePath.FullName -Force



        if ($paramSet -eq 'ColorScheme') {
            if (-not $ColorScheme) { $ColorScheme = '*' }
            :nextColorScheme foreach ($wtScheme in $wtProfile.schemes) {
                foreach ($cs in $ColorScheme) {
                    if ($wtScheme.Name -notlike $cs) { continue }
                    $wtScheme.pstypenames.clear()
                    $wtScheme.pstypenames.add('WindowsTerminal.ColorScheme')
                    $wtScheme
                    continue nextColorScheme
                }
            }
        }
        elseif ($paramSet -eq 'Name') {
            if (-not $ProfileName) { $ProfileName = '*' }
            :nextProfile foreach ($wtProf in $wtProfile.profiles.list) {
                foreach ($pn in $ProfileName) {
                    if ($wtProf.Name -notlike $pn -and $wtProf.guid -notlike $pn) { continue }
                    $wtProf.pstypenames.clear()
                    $wtProf.pstypenames.add('WindowsTerminal.Profile')
                    $wtProf
                    continue nextProfile

                }
            }
        }
        elseif ($paramSet -eq 'Guid') {
            foreach ($wtProf in $wtProfile.profiles.list) {
                if ($guid -notcontains $wtProf.guid) {continue }
                $wtProf.pstypenames.clear()
                $wtProf.pstypenames.add('WindowsTerminal.Profile')
                $wtProf
            }
        }
        elseif ($paramSet -eq 'Global') {
            $wtProfile
        }
        elseif ($paramSet -eq 'Default') {
            $defaultProf = $wtProfile.profiles.default
            if ($defaultProf) {
                $defaultProf.pstypenames.clear()
                $defaultProf.pstypenames.add('WindowsTerminal.Profile')
                $defaultProf
            }
        }
        elseif ($paramSet -eq 'Current') {
            if (-not $ENV:WT_PROFILE_ID) { return }
            foreach ($Prof in $wtProfile.profiles.list) {
                if ($prof.Guid -eq $ENV:WT_PROFILE_ID) {
                    $prof.pstypenames.clear()
                    $prof.pstypenames.add('WindowsTerminal.Profile')
                    $prof
                }
            }
        }
    }
}
