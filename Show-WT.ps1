function Show-WT
{
    <#
    .Synopsis
        Shows Images in the Windows Terminal
    .Description
        Shows Images in the Windows Terminal.

        By default, .GIF files will play once, and non-GIFs will stay for 15 seconds.
    .Example
        Show-WT -ImagePath .\My.gif  # Shows My.gif in the current Windows Terminal profile.
    .Example
        Show-WT -ImagePath .\My.gif -Duration -1 # Shows My.gif
    .Link
        Get-WTProfile
    .Link
        Set-WTProfile
    #>
    [OutputType([Management.Automation.Job], [Nullable])]
    param(
    # The path to an image file.
    [Parameter(Mandatory,ParameterSetName='ImageFile',ValueFromPipelineByPropertyName,Position=0)]
    [ValidatePattern('\.(gif|jpg|jpeg|png)$')]
    [Alias('FullName','Image','BackgroundImage')]
    [string]
    $ImagePath,

    # If set, will display content in a given profile.
    # If not set, will attempt to auto-detect the profile.
    # If the profile cannot be automatically detected, content will be displayed using the default profile settings.
    # (this will not override an existing image)
    [string]
    $ProfileName,


    # Sets the alignment of the Image to draw over the window background.
    [Parameter(ParameterSetName='ImageFile',ValueFromPipelineByPropertyName)]
    [ValidateSet('bottom','bottomLeft','bottomRight','center','left','right','top','topLeft','topRight')]
    [Alias('BackgroundImageAlignment', 'ImageAlignment')]
    [string]
    $Alignment= 'center',

    # Sets the opacity of the Image to draw over the window background.
    [Parameter(ParameterSetName='ImageFile',ValueFromPipelineByPropertyName)]
    [Alias('BackgroundImageOpacity','ImageOpacity')]
    [float]
    $Opacity = .9,
    # Sets how the background image is resized to fill the window.

    [Parameter(ParameterSetName='ImageFile',ValueFromPipelineByPropertyName)]
    [ValidateSet('fill','none','uniform','uniformToFill')]
    [Alias('BackgroundImageStretchMode', 'ImageStretchMode')]
    [string]
    $StretchMode= 'uniformToFill',

    # Sets how long the image should be displayed.
    # If the duration is negative, the image will not be automatically cleared.
    [Parameter(ParameterSetName='ImageFile',ValueFromPipelineByPropertyName)]
    [Timespan]
    $Duration = '00:00:15',

    # If set, will wait for the duration to complete.
    # If the duration is negative, this parameter is ignored.
    [Parameter(ParameterSetName='ImageFile',ValueFromPipelineByPropertyName)]
    [switch]
    $Wait
    )


    begin {
        #region Prepare Background Job
        $jobCmd = $ExecutionContext.SessionState.InvokeCommand.GetCommand('Start-ThreadJob','Alias,Cmdlet,Function')
        if (-not $jobCmd) {
            $jobCmd = $ExecutionContext.SessionState.InvokeCommand.GetCommand('Start-Job','Alias,Cmdlet,Function')
        }

        $jobDef = [ScriptBlock]::Create(@"
param([Collections.IDictionary]`$parameters)
Import-Module '$($MyInvocation.MyCommand.Module.Path | Split-Path)'
$($MyInvocation.MyCommand.Name) @parameters
"@)
        #endregion Prepare Background Job
    }
    process {
        if ($PSCmdlet.ParameterSetName -eq 'ImageFile') {
            $resolvedPath = $ExecutionContext.SessionState.Path.GetResolvedPSPathFromPSPath($ImagePath)
            if (-not $resolvedPath) { return }

            if ($Wait) {

                $targetProfile =
                    if (-not $ProfileName) {
                        Get-WTProfile -Current
                    } else {
                        Get-WTProfile -ProfileName $ProfileName
                    }

                if (-not $targetProfile) {
                    $targetProfile = Get-WTProfile -Default
                }


                if (-not $targetProfile) {
                    "No target profile - $env:WT_PROFILE_ID" | Out-Host
                }



                if (-not $PSBoundParameters['Duration'] -and $ImagePath -like '*.gif') {
                    if (-not ('Drawing.Image' -as [type])) {
                        Add-Type -AssemblyName System.Drawing
                    }
                    $img = [Drawing.Image]::FromFile($resolvedPath)
                    $frameCount =
                        try {
                            $img.GetFrameCount([Drawing.Imaging.FrameDimension]::Time)
                        } catch {0}

                    $frameTimes = try { $img.GetPropertyItem(20736).Value } catch { 0 }
                    if ($frameTimes) {
                        $totalMS = 0
                        for ($i=0; $i -lt $frameCount; $i++) {
                            $totalMS+=[BitConverter]::ToInt32($frameTimes,$i * 4) * 10
                        }
                        $Duration = [Timespan]::FromMilliseconds($totalMS)
                    }
                    $img.Dispose()
                }

                $updatedProfile = $targetProfile |
                    Add-Member backgroundImage "$resolvedPath" -Force -PassThru |
                    Add-Member backgroundImageOpacity $Opacity -Force -PassThru |
                    Add-Member backgroundImageAlignment $Alignment -Force -PassThru |
                    Add-Member backgroundImageStrechMode $StretchMode -Force -PassThru |
                    Add-Member useAcrylic $true -Force -PassThru

                if ($targetProfile.guid) {
                    # $updatedProfile | Out-Host
                    Set-WTProfile -ProfileName $targetProfile.guid -Confirm:$false -InputObject $updatedProfile -PassThru | Out-Host
                } else {
                    $updatedProfile | Out-Host
                    Set-WTProfile -Default -Confirm:$false -InputObject $updatedProfile -PassThru
                }

                if ($Duration.TotalMilliseconds -ge 0) {
                    [Threading.Thread]::Sleep($Duration.TotalMilliseconds)

                    $blankImageFields = [PSCustomObject]@{
                        backgroundImage =''
                        backgroundImageOpacity = ''
                        backgroundImageAlignment = ''
                        backgroundImageStretchMode = ''
                        useAcrylic = $false
                    }
                    if ($targetProfile.guid) {
                        $blankImageFields |
                            Set-WTProfile -ProfileName $targetProfile.guid -Confirm:$false
                    } else {
                        $blankImageFields |
                            Set-WTProfile -Default -Confirm:$false
                    }
                }
            } else {
                $myParameters = @{Wait=$true} + $PSBoundParameters
                $myParameters['ImagePath'] = "$resolvedPath"
                if (-not $ProfileName -and $ENV:WT_PROFILE_ID) {
                    $myParameters['ProfileName'] = $ENV:WT_PROFILE_ID
                }
                & $jobCmd -ScriptBlock $jobDef -ArgumentList $MyParameters
            }
        }
    }
}
