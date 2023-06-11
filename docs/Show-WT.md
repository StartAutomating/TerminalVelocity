Show-WT
-------




### Synopsis
Shows Images in the Windows Terminal



---


### Description

Shows Images in the Windows Terminal.

By default, .GIF files will play once, and non-GIFs will stay for 15 seconds.



---


### Related Links
* [Get-WTProfile](Get-WTProfile.md)



* [Set-WTProfile](Set-WTProfile.md)





---


### Examples
#### EXAMPLE 1
```PowerShell
Show-WT -ImagePath .\My.gif  # Shows My.gif in the current Windows Terminal profile.
```

#### EXAMPLE 2
```PowerShell
Show-WT -ImagePath .\My.gif -Duration -1 # Shows My.gif forever
```



---


### Parameters
#### **ImagePath**

The path to an image file.






|Type      |Required|Position|PipelineInput        |Aliases                               |
|----------|--------|--------|---------------------|--------------------------------------|
|`[String]`|false   |1       |true (ByPropertyName)|FullName<br/>Image<br/>BackgroundImage|



#### **ProfileName**

If set, will display content in a given profile.
If not set, will attempt to auto-detect the profile.
If the profile cannot be automatically detected, content will be displayed using the default profile settings.
(this will not override an existing image)






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |false        |



#### **Alignment**

Sets the alignment of the Image to draw over the window background.



Valid Values:

* bottom
* bottomLeft
* bottomRight
* center
* left
* right
* top
* topLeft
* topRight






|Type      |Required|Position|PipelineInput        |Aliases                                    |
|----------|--------|--------|---------------------|-------------------------------------------|
|`[String]`|false   |named   |true (ByPropertyName)|BackgroundImageAlignment<br/>ImageAlignment|



#### **Opacity**

Sets the opacity of the Image to draw over the window background.






|Type      |Required|Position|PipelineInput        |Aliases                                |
|----------|--------|--------|---------------------|---------------------------------------|
|`[Single]`|false   |named   |true (ByPropertyName)|BackgroundImageOpacity<br/>ImageOpacity|



#### **StretchMode**

Sets how the background image is resized to fill the window.



Valid Values:

* fill
* none
* uniform
* uniformToFill






|Type      |Required|Position|PipelineInput        |Aliases                                        |
|----------|--------|--------|---------------------|-----------------------------------------------|
|`[String]`|false   |named   |true (ByPropertyName)|BackgroundImageStretchMode<br/>ImageStretchMode|



#### **Wait**

How long to wait before making the change.
By default, the change will be as quick as possible.






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |named   |true (ByPropertyName)|



#### **Duration**

Sets how long the image should be displayed.
If the duration is negative, the image will not be automatically cleared.






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |named   |true (ByPropertyName)|



#### **LoopCount**

Sets the number of times an animated .gif should be looped.






|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |named   |true (ByPropertyName)|



#### **AcrylicOpacity**

When useAcrylic is set to true, it sets the transparency of the window for the profile.
Accepts floating point values from 0-1 (default 0.5).






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Single]`|false   |named   |true (ByPropertyName)|



#### **UseAcrylic**

When set to true, the window will have an acrylic background.
When set to false, the window will have a plain, untextured background.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



#### **PixelShader**

If provided, will use a pixel shader.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **AsJob**

If set, will run in a background job.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |





---


### Outputs
* [Management.Automation.Job](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.Job)


* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)






---


### Syntax
```PowerShell
Show-WT [[-ImagePath] <String>] [-ProfileName <String>] [-Alignment <String>] [-Opacity <Single>] [-StretchMode <String>] [-Wait <TimeSpan>] [-Duration <TimeSpan>] [-LoopCount <Int32>] [-AcrylicOpacity <Single>] [-UseAcrylic] [-PixelShader <String>] [-AsJob] [<CommonParameters>]
```
