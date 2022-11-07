function New-WTProfile {
<#
    .Synopsis
        Creates a new Windows Terminal profile
    .Description
        Creates a new Windows Terminal tab profile.
    .Link
        Add-WTProfile
    .Example
        New-WTProfile -Name DOS -CommandLine cmd
    .Example
        New-WTProfile -Name kali-linux-pwsh -CommandLine 'wsl -d kali-linux -e pwsh'
    .Example
        New-WTProfile -Default
    
#>
    
    [OutputType('WindowsTerminal.Profile')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseShouldProcessForStateChangingFunctions", "", Justification="Not changing state"
    )]
    param(
# [deprecated] Please use `opacity` instead.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('acrylicOpacity')]
[double]
$AcrylicOpacity,
# Controls how text is antialiased in the renderer. Possible values are "grayscale", "cleartype" and "aliased". Note that changing this setting will require starting a new terminal instance.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('antialiasingMode')]
[ValidateSet('grayscale','cleartype','aliased')]
[string]
$AntialiasingMode,
# Sets the background color of the text. Overrides "background" from the color scheme. Uses hex color format: "#rrggbb".
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('background')]
[ValidatePattern('^#[A-Fa-f0-9]{3}(?:[A-Fa-f0-9]{3})?$')]
[string]
$Background,
# Sets the appearance of the terminal when it is unfocused.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('unfocusedAppearance')]
[PSObject]
$UnfocusedAppearance,
# Sets the font options of the terminal.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('font')]
[PSObject]
$Font,
# Sets the file location of the image to draw over the window background.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('backgroundImage')]
[ValidateSet('desktopWallpaper','')]
$BackgroundImage,
# Sets how the background image aligns to the boundaries of the window. Possible values: "center", "left", "top", "right", "bottom", "topLeft", "topRight", "bottomLeft", "bottomRight"
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('backgroundImageAlignment')]
[ValidateSet('bottom','bottomLeft','bottomRight','center','left','right','top','topLeft','topRight')]
[string]
$BackgroundImageAlignment,
# Sets the transparency of the background image. Accepts floating point values from 0-1.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('backgroundImageOpacity')]
[double]
$BackgroundImageOpacity,
# Sets how the background image is resized to fill the window.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('backgroundImageStretchMode')]
[ValidateSet('fill','none','uniform','uniformToFill')]
[string]
$BackgroundImageStretchMode,
# Controls what happens when the application emits a BEL character. When set to "all", the Terminal will play a sound, flash the taskbar icon (if the terminal window is not in focus) and flash the window. An array of specific behaviors can also be used. Supported array values include `audible`, `window` and `taskbar`. When set to "none", nothing will happen.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('bellStyle')]
$BellStyle,
# Sets the sound played when the application emits a BEL. When set to an array, the terminal will pick one of those sounds at random.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('bellSound')]
$BellSound,
<#
    Sets how the profile reacts to termination or failure to launch. Possible values:
     -"graceful" (close when exit is typed or the process exits normally)
     -"always" (always close)
     -"automatic" (behave as "graceful" only for processes launched by terminal, behave as "always" otherwise)
     -"never" (never close).
    true and false are accepted as synonyms for "graceful" and "never" respectively.
    #>
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('closeOnExit')]
$CloseOnExit,
# Name of the terminal color scheme to use. Color schemes are defined under "schemes".
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('colorScheme')]
[string]
$ColorScheme,
# Executable used in the profile.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('commandline')]
[string]
$Commandline,
# Sets the color of the cursor. Overrides the cursor color from the color scheme. Uses hex color format: "#rrggbb".
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('cursorColor')]
[ValidatePattern('(?>^\s{0}$|^#[A-Fa-f0-9]{3}(?:[A-Fa-f0-9]{3})?$)')]
[string]
$CursorColor,
# Sets the percentage height of the cursor starting from the bottom. Only works when cursorShape is set to "vintage". Accepts values from 1-100.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('cursorHeight')]
[int]
$CursorHeight,
<#
    Sets the shape of the cursor. Possible values:
     -"bar" ( ┃, default )
     -"doubleUnderscore" ( ‗ )
     -"emptyBox" ( ▯ )
     -"filledBox" ( █ )
     -"underscore" ( ▁ )
     -"vintage" ( ▃ )
    #>
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('cursorShape')]
[ValidateSet('bar','doubleUnderscore','emptyBox','filledBox','underscore','vintage')]
[string]
$CursorShape,
# When true, this profile should always open in an elevated context. If the window isn't running as an Administrator, then a new elevated window will be created.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('elevate')]
[switch]
$Elevate,
# When set to true, directs the PTY for this connection to use pass-through mode instead of the original Conhost PTY simulation engine. This is an experimental feature, and its continued existence is not guaranteed.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('experimental.connection.passthroughMode')]
[switch]
$ConnectionPassthroughMode,
# When set to true, enable retro terminal effects. This is an experimental feature, and its continued existence is not guaranteed.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('experimental.retroTerminalEffect')]
[switch]
$RetroTerminalEffect,
# Use to set a path to a pixel shader to use with the Terminal. Overrides `experimental.retroTerminalEffect`. This is an experimental feature, and its continued existence is not guaranteed.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('experimental.pixelShaderPath')]
[string]
$PixelShaderPath,
# Enable using the experimental new rendering engine for this profile. This is an experimental feature, and its continued existence is not guaranteed.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('experimental.useAtlasEngine')]
[switch]
$UseAtlasEngine,
# [deprecated] Define 'face' within the 'font' object instead.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('fontFace')]
[string]
$FontFace,
# [deprecated] Define 'size' within the 'font' object instead.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('fontSize')]
[int]
$FontSize,
# [deprecated] Define 'weight' within the 'font' object instead.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('fontWeight')]
$FontWeight,
# Controls how 'intense' text is rendered. Values are "bold", "bright", "all" and "none"
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('intenseTextStyle')]
[ValidateSet('none','bold','bright','all')]
[string]
$IntenseTextStyle,
# Sets the text color. Overrides "foreground" from the color scheme. Uses hex color format: "#rrggbb".
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('foreground')]
[ValidatePattern('^#[A-Fa-f0-9]{3}(?:[A-Fa-f0-9]{3})?$')]
[string]
$Foreground,
# Unique identifier of the profile. Written in registry format: "{00000000-0000-0000-0000-000000000000}".
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('guid')]
[ValidatePattern('^\{[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\}$')]
[string]
$Guid,
# If set to true, the profile will not appear in the list of profiles. This can be used to hide default profiles and dynamically generated profiles, while leaving them in your settings file.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('hidden')]
[switch]
$Hidden,
# The number of lines above the ones displayed in the window you can scroll back to.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('historySize')]
[int]
$HistorySize,
# 
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('icon')]
[string]
$Icon,
# Name of the profile. Displays in the dropdown menu.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('name')]
[string]
$Name,
# Sets the opacity of the window for the profile. Accepts values from 0-100. Defaults to 50 when useAcrylic is set to true.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('opacity')]
[double]
$Opacity,
<#
    Sets the padding around the text within the window. Can have three different formats:
     -"#" sets the same padding for all sides 
     -"#, #" sets the same padding for left-right and top-bottom
     -"#, #, #, #" sets the padding individually for left, top, right, and bottom.
    #>
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('padding')]
$Padding,
# When set to true, we will (when necessary) adjust the foreground color to make it more visible, based on the background color.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('adjustIndistinguishableColors')]
[switch]
$AdjustIndistinguishableColors,
# Defines the visibility of the scrollbar.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('scrollbarState')]
[ValidateSet('visible','hidden')]
[string]
$ScrollbarState,
# Sets the background color of selected text. Overrides selectionBackground set in the color scheme. Uses hex color format: "#rrggbb".
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('selectionBackground')]
[ValidatePattern('(?>^\s{0}$|^#[A-Fa-f0-9]{3}(?:[A-Fa-f0-9]{3})?$)')]
[string]
$SelectionBackground,
# When set to true, the window will scroll to the command input line when typing. When set to false, the window will not scroll when you start typing.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('snapOnInput')]
[switch]
$SnapOnInput,
# By default Windows treats Ctrl+Alt as an alias for AltGr. When altGrAliasing is set to false, this behavior will be disabled.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('altGrAliasing')]
[switch]
$AltGrAliasing,
# Stores the name of the profile generator that originated this profile.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('source')]
[string]
$Source,
# The directory the shell starts in when it is loaded.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('startingDirectory')]
[string]
$StartingDirectory,
# When set to true, tabTitle overrides the default title of the tab and any title change messages from the application will be suppressed. When set to false, tabTitle behaves as normal.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('suppressApplicationTitle')]
[switch]
$SuppressApplicationTitle,
# Sets the color of the profile's tab. Using the tab color picker will override this color.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('tabColor')]
[ValidatePattern('^#[A-Fa-f0-9]{3}(?:[A-Fa-f0-9]{3})?$')]
[string]
$TabColor,
# If set, will replace the name as the title to pass to the shell on startup. Some shells (like bash) may choose to ignore this initial value, while others (cmd, powershell) may use this value over the lifetime of the application.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('tabTitle')]
[string]
$TabTitle,
# When set to true, the window will have an acrylic material background. When set to false, the window will have a plain, untextured background.
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('useAcrylic')]
[switch]
$UseAcrylic
    )
}

