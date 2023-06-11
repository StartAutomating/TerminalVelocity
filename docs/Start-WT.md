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



---


### Parameters
#### **ProfileName**

The name of the Windows Terminal Tab profile






|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[String]`|false   |1       |true (ByPropertyName)|Profile|



#### **WorkingDirectory**

The working directory used by Windows Terminal






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|



#### **CommandLine**

The command line run by Windows Terminal






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|



#### **Split**

If set, will split the pane.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



#### **SplitDirection**

If provided, will split the pane horizontally or veritcally



Valid Values:

* Horizontal
* H
* Vertical
* V






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |4       |true (ByPropertyName)|



#### **FocusTabIndex**

If provided, will focus a given tab index.






|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |5       |true (ByPropertyName)|



#### **FocusNextTab**

If provided, will focus the next tab.






|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Switch]`|false   |named   |true (ByPropertyName)|Next   |



#### **FocusPreviousTab**

If provided, will focus the previous tab.






|Type      |Required|Position|PipelineInput        |Aliases |
|----------|--------|--------|---------------------|--------|
|`[Switch]`|false   |named   |true (ByPropertyName)|Previous|



#### **Passthru**

If set, will return the created process.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **Elevated**

If set, will start the process elevated






|Type      |Required|Position|PipelineInput|Aliases           |
|----------|--------|--------|-------------|------------------|
|`[Switch]`|false   |named   |false        |RunAsAdministrator|





---


### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)


* [Diagnostics.Process](https://learn.microsoft.com/en-us/dotnet/api/System.Diagnostics.Process)






---


### Syntax
```PowerShell
Start-WT [[-ProfileName] <String>] [[-WorkingDirectory] <String>] [[-CommandLine] <String>] [-Split] [[-SplitDirection] <String>] [[-FocusTabIndex] <Int32>] [-FocusNextTab] [-FocusPreviousTab] [-Passthru] [-Elevated] [<CommonParameters>]
```
