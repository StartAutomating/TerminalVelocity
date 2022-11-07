function Set-WTProfile
{
    <#
    .Synopsis
        Sets the Windows Terminal profile
    .Description
        Changes the Windows Terminal profile.

        Use Get-Help Set-WTProfile -Parameter * to learn what you can change.
    .Link
        Get-WTProfile
    .Example
        Set-WTProfile -LaunchMode Maximized
    .Example
        Set-WTProfile
    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='Medium',DefaultParameterSetName='Current')]
    [OutputType([Nullable],[PSObject])]
    [RenameVariable(VariableRename={
        @{
            "GUID" = "NewGUID"
            "TabTitle" = "TabStartupTitle"
        }
    })]
    [JSONSchema(SchemaUri='https://aka.ms/terminal-profiles-schema#Profile',RemovePropertyPrefix='Experimental')]
    param(
    # The InputObject.  This is used to provide information to a specific tab profile.
    [Parameter(ValueFromPipeline,ParameterSetName='InputObject')]
    [Parameter(ValueFromPipeline,ParameterSetName='Default')]
    [Parameter(ValueFromPipeline,ParameterSetName='Current')]
    [PSObject]
    $InputObject,

    # The name or ID of the tab profile.  This is used to determine which profiles are changed by the -InputObject.
    [Parameter(ParameterSetName='InputObject',ValueFromPipelineByPropertyName)]
    [Alias('GUID')]
    [string]
    $ProfileName,

    # If set, will set profile defaults, instead of a particular profile.
    [Parameter(Mandatory,ParameterSetName='Default')]
    [Alias('Defaults')]
    [switch]
    $Default,

    # If set, will set the current profile (based off of ENV:WT_PROFILE_ID).
    [Parameter(Mandatory,ParameterSetName='Current')]
    [switch]
    $Current,

    # If set, changes will apply to the global profile.
    [Parameter(Mandatory,ParameterSetName='Global')]
    [switch]
    $Global,

    # Properties are specific to each color scheme.
    # ColorTool is a great tool you can use to create and explore new color schemes.
    # All colors use hex color format.
    [Parameter(ParameterSetName='Global')]
    [Alias('Schemes')]
    [PSObject[]]
    $ColorScheme,    

    # If provided, changes the launch mode.
    # Valid launch modes are 'Maximized' and 'Default'.
    [Parameter(ParameterSetName='Global')]
    [ValidateSet('Maximized','Default')]
    [string]
    $LaunchMode,

    # If provided, changes the tab width mode.
    # Valid modes are 'Equal' and 'TitleLength'.
    [Parameter(ParameterSetName='Global')]
    [ValidateSet('Equal','TitleLength')]
    [string]
    $TabWidthMode,

    # When set to true, tabs are always displayed.
    # When set to false and showTabsInTitlebar is set to false,
    # tabs only appear after opening a new tab.
    [Parameter(ParameterSetName='Global')]
    [Alias('AlwaysShowTabs')]
    [switch]
    $AlwaysShowTab,

    # When set to true, a selection is immediately copied to your clipboard upon creation.
    # When set to false, the selection persists and awaits further action.
    [Parameter(ParameterSetName='Global')]
    [Alias('QuickEdit')]
    [switch]
    $CopyOnSelect,

    # When set to true closing a window with multiple tabs open WILL require confirmation.
    # When set to false closing a window with multiple tabs open WILL NOT require confirmation.
    [Parameter(ParameterSetName='Global')]
    [switch]
    $ConfirmCloseAllTabs,

    # If set, will pass the updated objects back to the pipeline.
    [switch]
    $PassThru,

    # If set, will force reloading of profile information.
    # By default, the profile object will be cached to improve performance.
    [switch]
    $Force
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
        $wtProfile = Get-WTProfile -Global -Force:$force

        if (-not $wtProfile) {
            Write-Error "Could not load global profile"
            return
        }
        
        $myParameters = [Ordered]@{} + $PSBoundParameters
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

        $changed = $false

        #region Global Settings
        if ($LaunchMode -and $wtProfile.LaunchMode -ne $LaunchMode) {
            $LaunchMode = $LaunchMode.Substring(0,1).ToLower() + $LaunchMode.Substring(1)
            $wtProfile | Add-Member NoteProperty launchMode $LaunchMode -Force
            $changed = $true
        }

        if ($TabWidthMode -and $wtProfile.TabWidthMode -ne $TabWidthMode) {
            $TabWidthMode = $TabWidthMode.Substring(0,1).ToLower() + $TabWidthMode.Substring(1)
            $wtProfile | Add-Member NoteProperty tabWidthMode $TabWidthMode -Force
            $changed = $true
        }

        if ($MyParameters.Contains('AlwaysShowTab') -and $wtProfile.alwaysShowTabs -ne $AlwaysShowTab) {
            $wtProfile | Add-Member NoteProperty alwaysShowTabs ([bool]$AlwaysShowTab) -Force
            $changed = $true
        }

        if ($MyParameters.Contains('CopyOnSelect') -and $wtProfile.copyOnSelect -ne $CopyOnSelect) {
            $wtProfile | Add-Member NoteProperty copyOnSelect ([bool]$CopyOnSelect) -Force
            $changed = $true
        }

        if ($MyParameters.Contains('ConfirmCloseAllTabs') -and $wtProfile.confirmCloseAllTabs -ne $ConfirmCloseAllTabs) {
            $wtProfile | Add-Member NoteProperty confirmCloseAllTabs ([bool]$ConfirmCloseAllTabs) -Force
            $changed = $true
        }
        #endregion Global Settings

        if ($ColorScheme -and $PSCmdlet.ShouldProcess('Overwrite Color Schemes')) {

            $wtProfile | Add-Member NoteProperty schemes $ColorScheme -Force
            $changed = $true
        }

        #region Profile Specific Settings
        if ($Current) {
            if ($ENV:WT_PROFILE_ID) {
                $ProfileName = $ENV:WT_PROFILE_ID
            }
            else {
                Write-Error '$ENV:WT_PROFILE_ID not found'
                return
            }
        }

        if ($myProfileParameters.Count) {
            if (-not $InputObject) {
                $InputObject = [PSCustomObject]$myProfileParameters
            } else {
                foreach ($profileUpdate in $myProfileParameters.GetEnumerator()) {
                    Add-Member NoteProperty $profileUpdate.Key $profileUpdate.Value -Force -InputObject $InputObject
                }
            }
        }

        if ($InputObject -and -not $ProfileName -and $ENV:WT_PROFILE_ID) {
            $ProfileName = $ENV:WT_PROFILE_ID
        }

        if ($InputObject -and ($ProfileName -or $Default)) {
            $targetProfiles =
                if ($Default) {
                    $wtProfile.profiles.default
                } else {
                    @(foreach ($prof in $wtProfile.profiles.list) {
                        if ($prof.Name -eq $ProfileName -or
                            $prof.Guid -eq $ProfileName -or
                            $prof.Guid -eq "{$profileName}") {
                            $prof
                        }
                    })
                }

            if (-not $targetProfiles -and -not $Default) {
                Write-Error "Profile '$profileName' not found"
                return
            }

            if ($Default -and -not $targetProfiles) {
                if (-not $wtProfile.profiles.defaults) {
                    $wtProfile.profiles |
                        Add-Member NoteProperty defaults ([PSObject]::new()) -Force
                }
                $targetProfiles = @($wtProfile.profiles.defaults)
            }



            if ($targetProfiles) {
                foreach ($target in $targetProfiles) {
                    if ($InputObject -is [Collections.IDictionary]) {
                        foreach ($kv in $InputObject.GetEnumerator()) {
                            if ([String]::IsNullOrEmpty($kv.Value)) {
                                $target.psobject.properties.Remove($kv.Key)
                            } else {
                                $k = $kv.Key.ToString().Substring(0,1).ToLower() + $kv.Key.ToString().Substring(1)
                                $target |
                                    Add-Member NoteProperty $k $kv.Value -Force
                            }
                        }
                    } else {
                        foreach ($prop in $InputObject.psobject.properties) {
                            if ([String]::IsNullOrEmpty($prop.Value)) {
                                $target.psobject.properties.Remove($prop.Name)
                            } else {
                                $k = $prop.Name.Substring(0,1).ToLower() + $prop.Name.Substring(1)
                                $target | Add-Member NoteProperty $prop.Name $prop.Value -Force
                            }
                        }
                    }
                }
                $changed = $true
            } else {
                Write-Warning "No Target profiles!"
            }
        }
        #endregion Profile Specific Settings

        #region Write Profile
        if ($WhatIfPreference -or $PassThru) {
            if ($targetProfiles) {
                $targetProfiles
            } else {
                $wtProfile
            }
        }
        
        if ($changed -and $PSCmdlet.ShouldProcess("Update $($wtProfile.Path)")) {
            $script:cachedWTProfile = $wtProfile
            $wtPath = $wtProfile.Path
            $wtProfile.psobject.properties.Remove('Path')
            $json = $wtProfile | ConvertTo-Json -Depth 100
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

            $wtProfile.psobject.properties.add([PSNoteProperty]::new('Path', $wtPath))
        }

        
        #endregion Write Profile
    }
}
