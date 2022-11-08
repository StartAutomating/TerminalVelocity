Start-WT
--------
### Synopsis
Starts a new instance of Windows Terminal

---
### Description

Starts a new instance of Windows Terminal, and sends commands to it.

---
### Related Links
* [Get-WTProfile](Get-WTProfile.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Start-WT
```

#### EXAMPLE 2
```PowerShell
Start-WT -Profile PowerShell
```

#### EXAMPLE 3
```PowerShell
Start-WT -Profile 'Windows PowerShell' -CommandLine 'powershell -nologo'
```

#### EXAMPLE 4
```PowerShell
[PSCustomObject]@{
    Profile = 'Windows PowerShell'
    CommandLine = {powershell -nologo -noexit -command $psVersionTable}
},
[PSCustomObject]@{
    Profile = 'PowerShell'
    CommandLine = {%programFiles%\PowerShell\7\pwsh -nologo -noexit -command $psVersionTable}
} |
    Start-WT -Verbose
```

---
### Parameters
#### **ProfileName**

The name of the Windows Terminal Tab profile



> **Type**: ```[String]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **WorkingDirectory**

The working directory used by Windows Terminal



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **CommandLine**

The command line run by Windows Terminal



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **Split**

If set, will split the pane.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **SplitDirection**

If provided, will split the pane horizontally or veritcally



Valid Values:

* Horizontal
* H
* Vertical
* V



> **Type**: ```[String]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **FocusTabIndex**

If provided, will focus a given tab index.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **FocusNextTab**

If provided, will focus the next tab.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **FocusPreviousTab**

If provided, will focus the previous tab.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Passthru**

If set, will return the created process.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Elevated**

If set, will start the process elevated



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)


* [Diagnostics.Process](https://learn.microsoft.com/en-us/dotnet/api/System.Diagnostics.Process)




---
### Syntax
```PowerShell
Start-WT [[-ProfileName] <String>] [[-WorkingDirectory] <String>] [[-CommandLine] <String>] [-Split] [[-SplitDirection] <String>] [[-FocusTabIndex] <Int32>] [-FocusNextTab] [-FocusPreviousTab] [-Passthru] [-Elevated] [<CommonParameters>]
```
---
