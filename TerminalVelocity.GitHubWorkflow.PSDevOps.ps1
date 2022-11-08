#requires -Module PSDevOps
New-GitHubWorkflow -Name "Analyze, Test, Tag, and Publish" -On Push, PullRequest, Demand -Job PowerShellStaticAnalysis, 
    TestPowerShellOnLinux, 
    TagReleaseAndPublish, 
    BuildModule -OutputPath (
        (Join-Path $PSScriptRoot .github\workflows\TestAndPublish.yml)
    )

Import-Module GitPub
Import-BuildStep -ModuleName GitPub

New-GitHubWorkflow -On Issue, Demand -Job RunGitPub -Name OnIssueChanged -OutputPath (
    Join-Path $PSScriptRoot .github\workflows\OnIssue.yml
)
