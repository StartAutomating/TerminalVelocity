New-WTColorScheme
-----------------




### Synopsis
Creates Windows Terminal Color Schemes



---


### Description

Creates a new Windows Terminal Color Scheme



---


### Related Links
* [Add-WTColorScheme](Add-WTColorScheme.md)





---


### Examples
#### EXAMPLE 1
```PowerShell
New-WTColorScheme -Name MyColorScheme
```



---


### Parameters
#### **Name**

The name of the color scheme






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



#### **Black**

The scheme's definition of the color Black.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|



#### **Red**

The scheme's definition of the color Red.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|



#### **Green**

The scheme's definition of the color Green.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |4       |true (ByPropertyName)|



#### **Yellow**

The scheme's definition of the color Yellow.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |5       |true (ByPropertyName)|



#### **Blue**

The scheme's definition of the color Blue.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |6       |true (ByPropertyName)|



#### **Cyan**

The scheme's definition of the color Cyan.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |7       |true (ByPropertyName)|



#### **Purple**

The scheme's definition of the color Purple.






|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[String]`|false   |8       |true (ByPropertyName)|Magenta|



#### **White**

The scheme's definition of the color White.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |9       |true (ByPropertyName)|



#### **BrightRed**

The scheme's definition of the color BrightRed.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |10      |true (ByPropertyName)|



#### **BrightGreen**

The scheme's definition of the color BrightGreen.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |11      |true (ByPropertyName)|



#### **BrightYellow**

The scheme's definition of the color BrightYellow.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |12      |true (ByPropertyName)|



#### **BrightBlue**

The scheme's definition of the color BrightBlue.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |13      |true (ByPropertyName)|



#### **BrightPurple**

The scheme's definition of the color BrightPurple.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |14      |true (ByPropertyName)|



#### **BrightCyan**

The scheme's definition of the color BrightCyan.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |15      |true (ByPropertyName)|



#### **BrightWhite**

The scheme's definition of the color BrightWhite.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |16      |true (ByPropertyName)|



#### **BrightBlack**

The scheme's definition of the color BrightBlack.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |17      |true (ByPropertyName)|



#### **Foreground**

The scheme's foreground color.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |18      |true (ByPropertyName)|



#### **Background**

The scheme's background color.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |19      |true (ByPropertyName)|





---


### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)






---


### Syntax
```PowerShell
New-WTColorScheme [-Name] <String> [[-Black] <String>] [[-Red] <String>] [[-Green] <String>] [[-Yellow] <String>] [[-Blue] <String>] [[-Cyan] <String>] [[-Purple] <String>] [[-White] <String>] [[-BrightRed] <String>] [[-BrightGreen] <String>] [[-BrightYellow] <String>] [[-BrightBlue] <String>] [[-BrightPurple] <String>] [[-BrightCyan] <String>] [[-BrightWhite] <String>] [[-BrightBlack] <String>] [[-Foreground] <String>] [[-Background] <String>] [<CommonParameters>]
```
