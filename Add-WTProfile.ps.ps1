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
    [JSONSchema(SchemaUri='https://aka.ms/terminal-profiles-schema#Profile',RemovePropertyPrefix='Experimental')]
    param(
    # Name of the profile. Displays in the dropdown menu.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('ProfileName')]
    [ComponentModel.DefaultBindingProperty("name")]
    [string]
    $Name
    )

    begin {
        $myParameters = $MyInvocation.MyCommand.Parameters.Values
        $myProfileProperties = :nextParam foreach ($param in $myParameters) {
            foreach ($attr in $param.Attributes) {
                if ($attr -is [ComponentModel.DefaultBindingPropertyAttribute]) {
                    $param
                    continue nextParam
                }
            }
        }    
    }

    process {

        $myParameters = [Ordered]@{} + $PSBoundParameters
        if (-not $myParameters["Guid"]) {
            $myParameters["Guid"] = "{$([GUID]::NewGuid())}"
        }
        $myProfileParameters = [Ordered]@{}
        foreach ($myProfileProperty in $myProfileProperties) {
            if ($myParameters.Contains($myProfileProperty.Name)) {
                $propertyName = foreach ($attr in $myProfileProperty.Attributes) {
                    if ($attr -is [System.ComponentModel.DefaultBindingPropertyAttribute]) {
                        $attr.Name
                        break
                    }
                }
                $paramValue = $myParameters[$myProfileProperty.Name]                
                foreach ($attr in $myProfileProperty.Attributes) {
                    if ($attr -is [ComponentModel.AmbientValueAttribute] -and $attr.Value -is [scriptblock]) {
                        $_ = $this = $PSItem = $paramValue
                        $paramValue = & $attr.Value
                        break
                    }
                    if ($attr -is [ValidateSet]) {
                        foreach ($validValue in $attr.Validvalues) {
                            if ($paramValue -eq $validValue) {
                                $paramValue = $validValue
                            }
                        }
                    }
                }
                if ($paramValue -is [switch]) {
                    $paramValue = $paramValue -as [bool]
                }
                $myProfileParameters[$propertyName] = $paramValue
            }
        }
        #region Create Profile Object
        
        $newProfile = [PSCustomObject]$myProfileParameters
        #endregion Profile Object


        #region Update Windows Terminal Profile
        $wtProfile = Get-WTProfile -Global          # Get our profile
        $wtProfile.profiles |                       # Add out new profile to the list,
            Add-Member NoteProperty list @(
                foreach ($_ in $wtProfile.profiles.list) {
                    if ($guid -ne $_.Guid -and $name -ne $_.Name)          # and don't forget all of the other ones.
                    {
                        $_
                    }
                }
                $newProfile
            ) -Force
        $wtPath = $wtProfile.Path
        if ($PSCmdlet.ShouldProcess("Add Profile $Name to $wtPath")) # If we ShouldProcess
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
