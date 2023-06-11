Remove-WTColorScheme
--------------------




### Synopsis
Removes color schemes from Windows Terminal.



---


### Description

Removes registered color schemes from Windows Terminal.



---


### Related Links
* [Add-WTColorScheme](Add-WTColorScheme.md)



* [Get-WTColorScheme](Get-WTColorScheme.md)



* [Set-WTColorScheme](Set-WTColorScheme.md)





---


### Examples
#### EXAMPLE 1
```PowerShell
Remove-WTColorScheme -Name "The Hulk"
```



---


### Parameters
#### **ColorScheme**

The name of the color scheme.






|Type        |Required|Position|PipelineInput        |Aliases|
|------------|--------|--------|---------------------|-------|
|`[String[]]`|true    |1       |true (ByPropertyName)|Name   |



#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.

If you pass ```-Confirm:$false``` you will not be prompted.


If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.



---


### Syntax
```PowerShell
Remove-WTColorScheme [-ColorScheme] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```
