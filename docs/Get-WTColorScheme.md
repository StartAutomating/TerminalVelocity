Get-WTColorScheme
-----------------




### Synopsis
Gets Windows Terminal Color Schemes



---


### Description

Gets one or more Windows Terminal Color Schemes from the profile



---


### Related Links
* [Add-WTColorScheme](Add-WTColorScheme.md)



* [New-WTColorScheme](New-WTColorScheme.md)





---


### Examples
#### EXAMPLE 1
```PowerShell
Get-WTColorScheme # Gets all color schemes
```

#### EXAMPLE 2
```PowerShell
Get-WTColorScheme 'Jackie Brown' # Gets the color scheme 'Jackie Brown'
```



---


### Parameters
#### **ColorScheme**

The name of the color scheme.






|Type        |Required|Position|PipelineInput        |Aliases|
|------------|--------|--------|---------------------|-------|
|`[String[]]`|false   |1       |true (ByPropertyName)|Name   |





---


### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)






---


### Syntax
```PowerShell
Get-WTColorScheme [[-ColorScheme] <String[]>] [<CommonParameters>]
```
