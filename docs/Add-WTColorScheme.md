Add-WTColorScheme
-----------------
### Synopsis
Adds a Windows Terminal Color Scheme

---
### Description

Adds a Windows Terminal Color Scheme, including any scheme from https://iterm2colorschemes.com/

---
### Related Links
* [https://iterm2colorschemes.com/](https://iterm2colorschemes.com/)



---
### Examples
#### EXAMPLE 1
```PowerShell
Add-WTColorScheme -Name AdventureTime
```

---
### Parameters
#### **Name**

The name of the color scheme.
If the name exists on https://iterm2colorschemes.com/, then no other parameters are needed.



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Black**

The scheme's definition of the color Black.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **Red**

The scheme's definition of the color Red.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **Green**

The scheme's definition of the color Green.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **Yellow**

The scheme's definition of the color Yellow.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **Blue**

The scheme's definition of the color Blue.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:true (ByPropertyName)



---
#### **Cyan**

The scheme's definition of the color Cyan.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 7

> **PipelineInput**:true (ByPropertyName)



---
#### **Purple**

The scheme's definition of the color Purple.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 8

> **PipelineInput**:true (ByPropertyName)



---
#### **White**

The scheme's definition of the color White.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 9

> **PipelineInput**:true (ByPropertyName)



---
#### **BrightRed**

The scheme's definition of the color BrightRed.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 10

> **PipelineInput**:true (ByPropertyName)



---
#### **BrightGreen**

The scheme's definition of the color BrightGreen.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 11

> **PipelineInput**:true (ByPropertyName)



---
#### **BrightYellow**

The scheme's definition of the color BrightYellow.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 12

> **PipelineInput**:true (ByPropertyName)



---
#### **BrightBlue**

The scheme's definition of the color BrightBlue.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 13

> **PipelineInput**:true (ByPropertyName)



---
#### **BrightPurple**

The scheme's definition of the color BrightPurple.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 14

> **PipelineInput**:true (ByPropertyName)



---
#### **BrightCyan**

The scheme's definition of the color BrightCyan.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 15

> **PipelineInput**:true (ByPropertyName)



---
#### **BrightWhite**

The scheme's definition of the color BrightWhite.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 16

> **PipelineInput**:true (ByPropertyName)



---
#### **BrightBlack**

The scheme's definition of the color BrightBlack.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 17

> **PipelineInput**:true (ByPropertyName)



---
#### **Foreground**

The scheme's foreground color.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 18

> **PipelineInput**:true (ByPropertyName)



---
#### **Background**

The scheme's background color.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 19

> **PipelineInput**:true (ByPropertyName)



---
#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.
    
If you pass ```-Confirm:$false``` you will not be prompted.
    
    
If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---
### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)




---
### Syntax
```PowerShell
Add-WTColorScheme [-Name] <String> [[-Black] <String>] [[-Red] <String>] [[-Green] <String>] [[-Yellow] <String>] [[-Blue] <String>] [[-Cyan] <String>] [[-Purple] <String>] [[-White] <String>] [[-BrightRed] <String>] [[-BrightGreen] <String>] [[-BrightYellow] <String>] [[-BrightBlue] <String>] [[-BrightPurple] <String>] [[-BrightCyan] <String>] [[-BrightWhite] <String>] [[-BrightBlack] <String>] [[-Foreground] <String>] [[-Background] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
