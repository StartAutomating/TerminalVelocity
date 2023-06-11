Set-WTProfile
-------------




### Synopsis
Sets the Windows Terminal profile



---


### Description

Changes the Windows Terminal profile.    
Use Get-Help Set-WTProfile -Parameter * to learn what you can change.



---


### Related Links
* [Get-WTProfile](Get-WTProfile.md)





---


### Examples
#### EXAMPLE 1
```PowerShell
Set-WTProfile -LaunchMode Maximized
```

#### EXAMPLE 2
```PowerShell
Set-WTProfile
```



---


### Parameters
#### **InputObject**

The InputObject.  This is used to provide information to a specific tab profile.






|Type        |Required|Position|PipelineInput |
|------------|--------|--------|--------------|
|`[PSObject]`|false   |named   |true (ByValue)|



#### **ProfileName**

The name or ID of the tab profile.  This is used to determine which profiles are changed by the -InputObject.






|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[String]`|false   |named   |true (ByPropertyName)|GUID   |



#### **Default**

If set, will set profile defaults, instead of a particular profile.






|Type      |Required|Position|PipelineInput|Aliases |
|----------|--------|--------|-------------|--------|
|`[Switch]`|true    |named   |false        |Defaults|



#### **Current**

If set, will set the current profile (based off of ENV:WT_PROFILE_ID).






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|true    |named   |false        |



#### **Global**

If set, changes will apply to the global profile.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|true    |named   |false        |



#### **ColorScheme**

Properties are specific to each color scheme.    
ColorTool is a great tool you can use to create and explore new color schemes.    
All colors use hex color format.






|Type          |Required|Position|PipelineInput|Aliases|
|--------------|--------|--------|-------------|-------|
|`[PSObject[]]`|false   |named   |false        |Schemes|



#### **LaunchMode**

If provided, changes the launch mode.    
Valid launch modes are 'Maximized' and 'Default'.



Valid Values:

* Maximized
* Default






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |false        |



#### **TabWidthMode**

If provided, changes the tab width mode.    
Valid modes are 'Equal' and 'TitleLength'.



Valid Values:

* Equal
* TitleLength






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |false        |



#### **AlwaysShowTab**

When set to true, tabs are always displayed.    
When set to false and showTabsInTitlebar is set to false,    
tabs only appear after opening a new tab.






|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[Switch]`|false   |named   |false        |AlwaysShowTabs|



#### **CopyOnSelect**

When set to true, a selection is immediately copied to your clipboard upon creation.    
When set to false, the selection persists and awaits further action.






|Type      |Required|Position|PipelineInput|Aliases  |
|----------|--------|--------|-------------|---------|
|`[Switch]`|false   |named   |false        |QuickEdit|



#### **ConfirmCloseAllTabs**

When set to true closing a window with multiple tabs open WILL require confirmation.    
When set to false closing a window with multiple tabs open WILL NOT require confirmation.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **PassThru**

If set, will pass the updated objects back to the pipeline.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **Force**

If set, will force reloading of profile information.    
By default, the profile object will be cached to improve performance.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **Overwrite**

By default, an -InputObject and any changes will be merged with the profile object    
If -Overwrite is set, Set-WTProfile will overwrite an existing profile object instead.    
Note: this should only be done with a complete profile object.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **AcrylicOpacity**

[deprecated] Please use `opacity` instead.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |named   |true (ByPropertyName)|



#### **AntialiasingMode**

Controls how text is antialiased in the renderer. Possible values are "grayscale", "cleartype" and "aliased". Note that changing this setting will require starting a new terminal instance.



Valid Values:

* grayscale
* cleartype
* aliased






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **Background**

Sets the background color of the text. Overrides "background" from the color scheme. Uses hex color format: "#rrggbb".






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **UnfocusedAppearance**

Sets the appearance of the terminal when it is unfocused.






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|false   |named   |true (ByPropertyName)|



#### **Font**

Sets the font options of the terminal.






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|false   |named   |true (ByPropertyName)|



#### **BackgroundImage**

Sets the file location of the image to draw over the window background.



Valid Values:

* desktopWallpaper
* 






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Object]`|false   |named   |true (ByPropertyName)|



#### **BackgroundImageAlignment**

Sets how the background image aligns to the boundaries of the window. Possible values: "center", "left", "top", "right", "bottom", "topLeft", "topRight", "bottomLeft", "bottomRight"



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






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **BackgroundImageOpacity**

Sets the transparency of the background image. Accepts floating point values from 0-1.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |named   |true (ByPropertyName)|



#### **BackgroundImageStretchMode**

Sets how the background image is resized to fill the window.



Valid Values:

* fill
* none
* uniform
* uniformToFill






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **BellStyle**

Controls what happens when the application emits a BEL character. When set to "all", the Terminal will play a sound, flash the taskbar icon (if the terminal window is not in focus) and flash the window. An array of specific behaviors can also be used. Supported array values include `audible`, `window` and `taskbar`. When set to "none", nothing will happen.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Object]`|false   |named   |true (ByPropertyName)|



#### **BellSound**

Sets the sound played when the application emits a BEL. When set to an array, the terminal will pick one of those sounds at random.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Object]`|false   |named   |true (ByPropertyName)|



#### **CloseOnExit**

Sets how the profile reacts to termination or failure to launch. Possible values:    
 -"graceful" (close when exit is typed or the process exits normally)    
 -"always" (always close)    
 -"automatic" (behave as "graceful" only for processes launched by terminal, behave as "always" otherwise)    
 -"never" (never close).    
true and false are accepted as synonyms for "graceful" and "never" respectively.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Object]`|false   |named   |true (ByPropertyName)|



#### **Commandline**

Executable used in the profile.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **CursorColor**

Sets the color of the cursor. Overrides the cursor color from the color scheme. Uses hex color format: "#rrggbb".






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **CursorHeight**

Sets the percentage height of the cursor starting from the bottom. Only works when cursorShape is set to "vintage". Accepts values from 1-100.






|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |named   |true (ByPropertyName)|



#### **CursorShape**

Sets the shape of the cursor. Possible values:    
 -"bar" ( ┃, default )    
 -"doubleUnderscore" ( ‗ )    
 -"emptyBox" ( ▯ )    
 -"filledBox" ( █ )    
 -"underscore" ( ▁ )    
 -"vintage" ( ▃ )



Valid Values:

* bar
* doubleUnderscore
* emptyBox
* filledBox
* underscore
* vintage






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **Elevate**

When true, this profile should always open in an elevated context. If the window isn't running as an Administrator, then a new elevated window will be created.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



#### **AutoMarkPrompts**

When set to true, prompts will automatically be marked.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



#### **ConnectionPassthroughMode**

When set to true, directs the PTY for this connection to use pass-through mode instead of the original Conhost PTY simulation engine. This is an experimental feature, and its continued existence is not guaranteed.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



#### **RetroTerminalEffect**

When set to true, enable retro terminal effects. This is an experimental feature, and its continued existence is not guaranteed.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



#### **ShowMarksOnScrollbar**

When set to true, marks added to the buffer via the addMark action will appear on the scrollbar.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



#### **PixelShaderPath**

Use to set a path to a pixel shader to use with the Terminal. Overrides `experimental.retroTerminalEffect`. This is an experimental feature, and its continued existence is not guaranteed.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **UseAtlasEngine**

Windows Terminal 1.16 and later ship with a new, performant text renderer. Set this to false to revert back to the old text renderer.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



#### **FontFace**

[deprecated] Define 'face' within the 'font' object instead.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **FontSize**

[deprecated] Define 'size' within the 'font' object instead.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |named   |true (ByPropertyName)|



#### **FontWeight**

[deprecated] Define 'weight' within the 'font' object instead.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Object]`|false   |named   |true (ByPropertyName)|



#### **IntenseTextStyle**

Controls how 'intense' text is rendered. Values are "bold", "bright", "all" and "none"



Valid Values:

* none
* bold
* bright
* all






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **Foreground**

Sets the text color. Overrides "foreground" from the color scheme. Uses hex color format: "#rrggbb".






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **NewGUID**

Unique identifier of the profile. Written in registry format: "{00000000-0000-0000-0000-000000000000}".






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **Hidden**

If set to true, the profile will not appear in the list of profiles. This can be used to hide default profiles and dynamically generated profiles, while leaving them in your settings file.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



#### **HistorySize**

The number of lines above the ones displayed in the window you can scroll back to.






|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |named   |true (ByPropertyName)|



#### **Icon**




|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **Name**

Name of the profile. Displays in the dropdown menu.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **Opacity**

Sets the opacity of the window for the profile. Accepts values from 0-100. Defaults to 50 when useAcrylic is set to true.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |named   |true (ByPropertyName)|



#### **Padding**

Sets the padding around the text within the window. Can have three different formats:    
 -"#" sets the same padding for all sides     
 -"#, #" sets the same padding for left-right and top-bottom    
 -"#, #, #, #" sets the padding individually for left, top, right, and bottom.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Object]`|false   |named   |true (ByPropertyName)|



#### **AdjustIndistinguishableColors**

Setting to adjust the foreground color to make it more visible, based on the background color. When set to "indexed", we will only adjust the colors if they came from the color scheme. Other possible values are "never" and "always".



Valid Values:

* never
* indexed
* always






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **ScrollbarState**

Defines the visibility of the scrollbar.



Valid Values:

* visible
* hidden






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **SelectionBackground**

Sets the background color of selected text. Overrides selectionBackground set in the color scheme. Uses hex color format: "#rrggbb".






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **SnapOnInput**

When set to true, the window will scroll to the command input line when typing. When set to false, the window will not scroll when you start typing.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



#### **AltGrAliasing**

By default Windows treats Ctrl+Alt as an alias for AltGr. When altGrAliasing is set to false, this behavior will be disabled.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



#### **Source**

Stores the name of the profile generator that originated this profile.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **StartingDirectory**

The directory the shell starts in when it is loaded.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **SuppressApplicationTitle**

When set to true, tabTitle overrides the default title of the tab and any title change messages from the application will be suppressed. When set to false, tabTitle behaves as normal.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



#### **TabColor**

Sets the color of the profile's tab. Using the tab color picker will override this color.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **TabStartupTitle**

If set, will replace the name as the title to pass to the shell on startup. Some shells (like bash) may choose to ignore this initial value, while others (cmd, powershell) may use this value over the lifetime of the application.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



#### **UseAcrylic**

When set to true, the window will have an acrylic material background. When set to false, the window will have a plain, untextured background.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



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


* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)






---


### Syntax
```PowerShell
Set-WTProfile [-InputObject <PSObject>] -Current [-PassThru] [-Force] [-Overwrite] [-AcrylicOpacity <Double>] [-AntialiasingMode <String>] [-Background <String>] [-UnfocusedAppearance <PSObject>] [-Font <PSObject>] [-BackgroundImage <Object>] [-BackgroundImageAlignment <String>] [-BackgroundImageOpacity <Double>] [-BackgroundImageStretchMode <String>] [-BellStyle <Object>] [-BellSound <Object>] [-CloseOnExit <Object>] [-Commandline <String>] [-CursorColor <String>] [-CursorHeight <Int32>] [-CursorShape <String>] [-Elevate] [-AutoMarkPrompts] [-ConnectionPassthroughMode] [-RetroTerminalEffect] [-ShowMarksOnScrollbar] [-PixelShaderPath <String>] [-UseAtlasEngine] [-FontFace <String>] [-FontSize <Double>] [-FontWeight <Object>] [-IntenseTextStyle <String>] [-Foreground <String>] [-NewGUID <String>] [-Hidden] [-HistorySize <Int32>] [-Icon <String>] [-Name <String>] [-Opacity <Double>] [-Padding <Object>] [-AdjustIndistinguishableColors <String>] [-ScrollbarState <String>] [-SelectionBackground <String>] [-SnapOnInput] [-AltGrAliasing] [-Source <String>] [-StartingDirectory <String>] [-SuppressApplicationTitle] [-TabColor <String>] [-TabStartupTitle <String>] [-UseAcrylic] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Set-WTProfile [-InputObject <PSObject>] -Default [-PassThru] [-Force] [-Overwrite] [-AcrylicOpacity <Double>] [-AntialiasingMode <String>] [-Background <String>] [-UnfocusedAppearance <PSObject>] [-Font <PSObject>] [-BackgroundImage <Object>] [-BackgroundImageAlignment <String>] [-BackgroundImageOpacity <Double>] [-BackgroundImageStretchMode <String>] [-BellStyle <Object>] [-BellSound <Object>] [-CloseOnExit <Object>] [-Commandline <String>] [-CursorColor <String>] [-CursorHeight <Int32>] [-CursorShape <String>] [-Elevate] [-AutoMarkPrompts] [-ConnectionPassthroughMode] [-RetroTerminalEffect] [-ShowMarksOnScrollbar] [-PixelShaderPath <String>] [-UseAtlasEngine] [-FontFace <String>] [-FontSize <Double>] [-FontWeight <Object>] [-IntenseTextStyle <String>] [-Foreground <String>] [-NewGUID <String>] [-Hidden] [-HistorySize <Int32>] [-Icon <String>] [-Name <String>] [-Opacity <Double>] [-Padding <Object>] [-AdjustIndistinguishableColors <String>] [-ScrollbarState <String>] [-SelectionBackground <String>] [-SnapOnInput] [-AltGrAliasing] [-Source <String>] [-StartingDirectory <String>] [-SuppressApplicationTitle] [-TabColor <String>] [-TabStartupTitle <String>] [-UseAcrylic] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Set-WTProfile [-InputObject <PSObject>] [-ProfileName <String>] [-PassThru] [-Force] [-Overwrite] [-AcrylicOpacity <Double>] [-AntialiasingMode <String>] [-Background <String>] [-UnfocusedAppearance <PSObject>] [-Font <PSObject>] [-BackgroundImage <Object>] [-BackgroundImageAlignment <String>] [-BackgroundImageOpacity <Double>] [-BackgroundImageStretchMode <String>] [-BellStyle <Object>] [-BellSound <Object>] [-CloseOnExit <Object>] [-Commandline <String>] [-CursorColor <String>] [-CursorHeight <Int32>] [-CursorShape <String>] [-Elevate] [-AutoMarkPrompts] [-ConnectionPassthroughMode] [-RetroTerminalEffect] [-ShowMarksOnScrollbar] [-PixelShaderPath <String>] [-UseAtlasEngine] [-FontFace <String>] [-FontSize <Double>] [-FontWeight <Object>] [-IntenseTextStyle <String>] [-Foreground <String>] [-NewGUID <String>] [-Hidden] [-HistorySize <Int32>] [-Icon <String>] [-Name <String>] [-Opacity <Double>] [-Padding <Object>] [-AdjustIndistinguishableColors <String>] [-ScrollbarState <String>] [-SelectionBackground <String>] [-SnapOnInput] [-AltGrAliasing] [-Source <String>] [-StartingDirectory <String>] [-SuppressApplicationTitle] [-TabColor <String>] [-TabStartupTitle <String>] [-UseAcrylic] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Set-WTProfile -Global [-ColorScheme <PSObject[]>] [-LaunchMode <String>] [-TabWidthMode <String>] [-AlwaysShowTab] [-CopyOnSelect] [-ConfirmCloseAllTabs] [-PassThru] [-Force] [-Overwrite] [-AcrylicOpacity <Double>] [-AntialiasingMode <String>] [-Background <String>] [-UnfocusedAppearance <PSObject>] [-Font <PSObject>] [-BackgroundImage <Object>] [-BackgroundImageAlignment <String>] [-BackgroundImageOpacity <Double>] [-BackgroundImageStretchMode <String>] [-BellStyle <Object>] [-BellSound <Object>] [-CloseOnExit <Object>] [-Commandline <String>] [-CursorColor <String>] [-CursorHeight <Int32>] [-CursorShape <String>] [-Elevate] [-AutoMarkPrompts] [-ConnectionPassthroughMode] [-RetroTerminalEffect] [-ShowMarksOnScrollbar] [-PixelShaderPath <String>] [-UseAtlasEngine] [-FontFace <String>] [-FontSize <Double>] [-FontWeight <Object>] [-IntenseTextStyle <String>] [-Foreground <String>] [-NewGUID <String>] [-Hidden] [-HistorySize <Int32>] [-Icon <String>] [-Name <String>] [-Opacity <Double>] [-Padding <Object>] [-AdjustIndistinguishableColors <String>] [-ScrollbarState <String>] [-SelectionBackground <String>] [-SnapOnInput] [-AltGrAliasing] [-Source <String>] [-StartingDirectory <String>] [-SuppressApplicationTitle] [-TabColor <String>] [-TabStartupTitle <String>] [-UseAcrylic] [-WhatIf] [-Confirm] [<CommonParameters>]
```
