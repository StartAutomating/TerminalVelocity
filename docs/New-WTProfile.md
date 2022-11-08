New-WTProfile
-------------
### Synopsis
Creates a new Windows Terminal profile

---
### Description

Creates a new Windows Terminal tab profile.

---
### Related Links
* [Add-WTProfile](Add-WTProfile.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
New-WTProfile -Name DOS -CommandLine cmd
```

#### EXAMPLE 2
```PowerShell
New-WTProfile -Name kali-linux-pwsh -CommandLine 'wsl -d kali-linux -e pwsh'
```

#### EXAMPLE 3
```PowerShell
New-WTProfile -Default
```

---
### Parameters
#### **AcrylicOpacity**

[deprecated] Please use `opacity` instead.



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **AntialiasingMode**

Controls how text is antialiased in the renderer. Possible values are "grayscale", "cleartype" and "aliased". Note that changing this setting will require starting a new terminal instance.



Valid Values:

* grayscale
* cleartype
* aliased



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **Background**

Sets the background color of the text. Overrides "background" from the color scheme. Uses hex color format: "#rrggbb".



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **UnfocusedAppearance**

Sets the appearance of the terminal when it is unfocused.



> **Type**: ```[PSObject]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **Font**

Sets the font options of the terminal.



> **Type**: ```[PSObject]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **BackgroundImage**

Sets the file location of the image to draw over the window background.



Valid Values:

* desktopWallpaper
* 



> **Type**: ```[Object]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:true (ByPropertyName)



---
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



> **Type**: ```[String]```

> **Required**: false

> **Position**: 7

> **PipelineInput**:true (ByPropertyName)



---
#### **BackgroundImageOpacity**

Sets the transparency of the background image. Accepts floating point values from 0-1.



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 8

> **PipelineInput**:true (ByPropertyName)



---
#### **BackgroundImageStretchMode**

Sets how the background image is resized to fill the window.



Valid Values:

* fill
* none
* uniform
* uniformToFill



> **Type**: ```[String]```

> **Required**: false

> **Position**: 9

> **PipelineInput**:true (ByPropertyName)



---
#### **BellStyle**

Controls what happens when the application emits a BEL character. When set to "all", the Terminal will play a sound, flash the taskbar icon (if the terminal window is not in focus) and flash the window. An array of specific behaviors can also be used. Supported array values include `audible`, `window` and `taskbar`. When set to "none", nothing will happen.



> **Type**: ```[Object]```

> **Required**: false

> **Position**: 10

> **PipelineInput**:true (ByPropertyName)



---
#### **BellSound**

Sets the sound played when the application emits a BEL. When set to an array, the terminal will pick one of those sounds at random.



> **Type**: ```[Object]```

> **Required**: false

> **Position**: 11

> **PipelineInput**:true (ByPropertyName)



---
#### **CloseOnExit**

Sets how the profile reacts to termination or failure to launch. Possible values:
 -"graceful" (close when exit is typed or the process exits normally)
 -"always" (always close)
 -"automatic" (behave as "graceful" only for processes launched by terminal, behave as "always" otherwise)
 -"never" (never close).
true and false are accepted as synonyms for "graceful" and "never" respectively.



> **Type**: ```[Object]```

> **Required**: false

> **Position**: 12

> **PipelineInput**:true (ByPropertyName)



---
#### **ColorScheme**

Name of the terminal color scheme to use. Color schemes are defined under "schemes".



> **Type**: ```[String]```

> **Required**: false

> **Position**: 13

> **PipelineInput**:true (ByPropertyName)



---
#### **Commandline**

Executable used in the profile.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 14

> **PipelineInput**:true (ByPropertyName)



---
#### **CursorColor**

Sets the color of the cursor. Overrides the cursor color from the color scheme. Uses hex color format: "#rrggbb".



> **Type**: ```[String]```

> **Required**: false

> **Position**: 15

> **PipelineInput**:true (ByPropertyName)



---
#### **CursorHeight**

Sets the percentage height of the cursor starting from the bottom. Only works when cursorShape is set to "vintage". Accepts values from 1-100.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 16

> **PipelineInput**:true (ByPropertyName)



---
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



> **Type**: ```[String]```

> **Required**: false

> **Position**: 17

> **PipelineInput**:true (ByPropertyName)



---
#### **Elevate**

When true, this profile should always open in an elevated context. If the window isn't running as an Administrator, then a new elevated window will be created.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **ConnectionPassthroughMode**

When set to true, directs the PTY for this connection to use pass-through mode instead of the original Conhost PTY simulation engine. This is an experimental feature, and its continued existence is not guaranteed.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **RetroTerminalEffect**

When set to true, enable retro terminal effects. This is an experimental feature, and its continued existence is not guaranteed.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **PixelShaderPath**

Use to set a path to a pixel shader to use with the Terminal. Overrides `experimental.retroTerminalEffect`. This is an experimental feature, and its continued existence is not guaranteed.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 18

> **PipelineInput**:true (ByPropertyName)



---
#### **UseAtlasEngine**

Enable using the experimental new rendering engine for this profile. This is an experimental feature, and its continued existence is not guaranteed.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **FontFace**

[deprecated] Define 'face' within the 'font' object instead.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 19

> **PipelineInput**:true (ByPropertyName)



---
#### **FontSize**

[deprecated] Define 'size' within the 'font' object instead.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 20

> **PipelineInput**:true (ByPropertyName)



---
#### **FontWeight**

[deprecated] Define 'weight' within the 'font' object instead.



> **Type**: ```[Object]```

> **Required**: false

> **Position**: 21

> **PipelineInput**:true (ByPropertyName)



---
#### **IntenseTextStyle**

Controls how 'intense' text is rendered. Values are "bold", "bright", "all" and "none"



Valid Values:

* none
* bold
* bright
* all



> **Type**: ```[String]```

> **Required**: false

> **Position**: 22

> **PipelineInput**:true (ByPropertyName)



---
#### **Foreground**

Sets the text color. Overrides "foreground" from the color scheme. Uses hex color format: "#rrggbb".



> **Type**: ```[String]```

> **Required**: false

> **Position**: 23

> **PipelineInput**:true (ByPropertyName)



---
#### **Guid**

Unique identifier of the profile. Written in registry format: "{00000000-0000-0000-0000-000000000000}".



> **Type**: ```[String]```

> **Required**: false

> **Position**: 24

> **PipelineInput**:true (ByPropertyName)



---
#### **Hidden**

If set to true, the profile will not appear in the list of profiles. This can be used to hide default profiles and dynamically generated profiles, while leaving them in your settings file.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **HistorySize**

The number of lines above the ones displayed in the window you can scroll back to.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 25

> **PipelineInput**:true (ByPropertyName)



---
#### **Icon**

> **Type**: ```[String]```

> **Required**: false

> **Position**: 26

> **PipelineInput**:true (ByPropertyName)



---
#### **Name**

Name of the profile. Displays in the dropdown menu.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 27

> **PipelineInput**:true (ByPropertyName)



---
#### **Opacity**

Sets the opacity of the window for the profile. Accepts values from 0-100. Defaults to 50 when useAcrylic is set to true.



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 28

> **PipelineInput**:true (ByPropertyName)



---
#### **Padding**

Sets the padding around the text within the window. Can have three different formats:
 -"#" sets the same padding for all sides 
 -"#, #" sets the same padding for left-right and top-bottom
 -"#, #, #, #" sets the padding individually for left, top, right, and bottom.



> **Type**: ```[Object]```

> **Required**: false

> **Position**: 29

> **PipelineInput**:true (ByPropertyName)



---
#### **AdjustIndistinguishableColors**

When set to true, we will (when necessary) adjust the foreground color to make it more visible, based on the background color.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **ScrollbarState**

Defines the visibility of the scrollbar.



Valid Values:

* visible
* hidden



> **Type**: ```[String]```

> **Required**: false

> **Position**: 30

> **PipelineInput**:true (ByPropertyName)



---
#### **SelectionBackground**

Sets the background color of selected text. Overrides selectionBackground set in the color scheme. Uses hex color format: "#rrggbb".



> **Type**: ```[String]```

> **Required**: false

> **Position**: 31

> **PipelineInput**:true (ByPropertyName)



---
#### **SnapOnInput**

When set to true, the window will scroll to the command input line when typing. When set to false, the window will not scroll when you start typing.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **AltGrAliasing**

By default Windows treats Ctrl+Alt as an alias for AltGr. When altGrAliasing is set to false, this behavior will be disabled.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Source**

Stores the name of the profile generator that originated this profile.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 32

> **PipelineInput**:true (ByPropertyName)



---
#### **StartingDirectory**

The directory the shell starts in when it is loaded.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 33

> **PipelineInput**:true (ByPropertyName)



---
#### **SuppressApplicationTitle**

When set to true, tabTitle overrides the default title of the tab and any title change messages from the application will be suppressed. When set to false, tabTitle behaves as normal.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **TabColor**

Sets the color of the profile's tab. Using the tab color picker will override this color.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 34

> **PipelineInput**:true (ByPropertyName)



---
#### **TabTitle**

If set, will replace the name as the title to pass to the shell on startup. Some shells (like bash) may choose to ignore this initial value, while others (cmd, powershell) may use this value over the lifetime of the application.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 35

> **PipelineInput**:true (ByPropertyName)



---
#### **UseAcrylic**

When set to true, the window will have an acrylic material background. When set to false, the window will have a plain, untextured background.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Outputs
* WindowsTerminal.Profile




---
### Syntax
```PowerShell
New-WTProfile [[-AcrylicOpacity] <Double>] [[-AntialiasingMode] <String>] [[-Background] <String>] [[-UnfocusedAppearance] <PSObject>] [[-Font] <PSObject>] [[-BackgroundImage] <Object>] [[-BackgroundImageAlignment] <String>] [[-BackgroundImageOpacity] <Double>] [[-BackgroundImageStretchMode] <String>] [[-BellStyle] <Object>] [[-BellSound] <Object>] [[-CloseOnExit] <Object>] [[-ColorScheme] <String>] [[-Commandline] <String>] [[-CursorColor] <String>] [[-CursorHeight] <Int32>] [[-CursorShape] <String>] [-Elevate] [-ConnectionPassthroughMode] [-RetroTerminalEffect] [[-PixelShaderPath] <String>] [-UseAtlasEngine] [[-FontFace] <String>] [[-FontSize] <Int32>] [[-FontWeight] <Object>] [[-IntenseTextStyle] <String>] [[-Foreground] <String>] [[-Guid] <String>] [-Hidden] [[-HistorySize] <Int32>] [[-Icon] <String>] [[-Name] <String>] [[-Opacity] <Double>] [[-Padding] <Object>] [-AdjustIndistinguishableColors] [[-ScrollbarState] <String>] [[-SelectionBackground] <String>] [-SnapOnInput] [-AltGrAliasing] [[-Source] <String>] [[-StartingDirectory] <String>] [-SuppressApplicationTitle] [[-TabColor] <String>] [[-TabTitle] <String>] [-UseAcrylic] [<CommonParameters>]
```
---
