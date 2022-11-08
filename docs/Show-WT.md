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
Show-WT -ImagePath .\My.gif -Wait -1 # Shows My.gif forever
```

---
### Parameters
#### **ImagePath**

The path to an image file.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **ProfileName**

If set, will display content in a given profile.
If not set, will attempt to auto-detect the profile.
If the profile cannot be automatically detected, content will be displayed using the default profile settings.
(this will not override an existing image)



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
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



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Opacity**

Sets the opacity of the Image to draw over the window background.



> **Type**: ```[Single]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **StretchMode**

Sets how the background image is resized to fill the window.



Valid Values:

* fill
* none
* uniform
* uniformToFill



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Wait**

How long to wait before making the change.
By default, the change will be as quick as possible.



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Duration**

Sets how long the image should be displayed.
If the duration is negative, the image will not be automatically cleared.



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **LoopCount**

Sets the number of times an animated .gif should be looped.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **AcrylicOpacity**

When useAcrylic is set to true, it sets the transparency of the window for the profile.
Accepts floating point values from 0-1 (default 0.5).



> **Type**: ```[Single]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **UseAcrylic**

When set to true, the window will have an acrylic background.
When set to false, the window will have a plain, untextured background.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **PixelShader**

If provided, will use a pixel shader.



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **AsJob**

If set, will run in a background job.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
### Outputs
* [Management.Automation.Job](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.Job)


* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)




---
### Syntax
```PowerShell
Show-WT [[-ImagePath] <String>] [-ProfileName <String>] [-Alignment <String>] [-Opacity <Single>] [-StretchMode <String>] [-Wait <TimeSpan>] [-Duration <TimeSpan>] [-LoopCount <Int32>] [-AcrylicOpacity <Single>] [-UseAcrylic] [-PixelShader <String>] [-AsJob] [<CommonParameters>]
```
---
