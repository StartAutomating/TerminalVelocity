#requires -Module PSSVG

$assetsPath = Join-Path $PSScriptRoot Assets

if (-not (Test-Path $assetsPath)) {
    $null = New-Item -ItemType Directory -path $assetsPath -Force
}
=<svg> -content $(
    $commonParameters = @{
        Fill        = '#4488FF'
        Stroke      = 'black'
        StrokeWidth = '0.05'
    }

    =<svg.symbol> -Id psChevron -Content @(
        =<svg.polygon> -Points (@(
            "40,20"
            "45,20"
            "60,50"
            "35,80"
            "32.5,80"
            "55,50"
        ) -join ' ')
    ) -ViewBox 100, 100

    
    =<svg.use> -Href '#psChevron' -X -25% -Y 22.5% @commonParameters -Height 50% -Opacity .9
    # =<svg.text> -Text '>' -X 20 -Y 50 -FontSize 48 -Rotate -7 -FontFamily monospace @commonParameters
    =<svg.text> -X 50% -Y 50%  -FontSize 20 -FontFamily monospace @commonParameters -DominantBaseline 'middle' -TextAnchor 'middle' @(
        =<svg.tspan> -FontSize 18 -Content "Terminal" -Dx -.5em -Dy -.5em 
        =<svg.tspan> -FontSize 18 -Content "Velocity"  -Dy .75em -Dx -3.9em
    ) -FontStyle 'italic' -Rotate '1' -Transform 'skewX(-10)'
    =<svg.line> -X1 30% -x2 61% -y1 65% -y2 65% -Stroke '#4488ff' -StrokeWidth 0.5%
    
    
) -ViewBox 0, 0, 300, 100 -OutputPath $(    
    Join-Path (Join-Path $PSScriptRoot Assets) TerminalVelocity.svg
)