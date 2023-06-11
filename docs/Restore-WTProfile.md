Restore-WTProfile
-----------------




### Synopsis
Restores a Windows Terminal Profile



---


### Description

Restores a Windows Terminal Profile backup.



---


### Related Links
* [Backup-WTProfile](Backup-WTProfile.md)





---


### Examples
#### EXAMPLE 1
```PowerShell
Restore-WTProfile -SourcePath .\WindowsTerminal.2020-05-17.backup.json
```



---


### Parameters
#### **SourcePath**




|Type      |Required|Position|PipelineInput        |Aliases |
|----------|--------|--------|---------------------|--------|
|`[String]`|true    |1       |true (ByPropertyName)|FullName|





---


### Syntax
```PowerShell
Restore-WTProfile [-SourcePath] <String> [<CommonParameters>]
```
