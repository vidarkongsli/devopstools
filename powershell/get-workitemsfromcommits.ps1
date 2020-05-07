
param(
    [Parameter(Mandatory)]
    $pat,
    [Parameter(Mandatory)]
    $organization,
    [Parameter(Mandatory)]
    $project,
    [Parameter(Mandatory)]
    $repositoryId,  
    [Parameter(Mandatory)]
    [array]$commits
)

$auth = [Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$pat"))
$headers = @{'Authorization'="Basic $auth"}

$commits | Select-Object -ExpandProperty workItems `
    | Sort-Object -Property id | Get-Unique -AsString `
    | ForEach-Object { Invoke-RestMethod -Uri $_.url -Method GET -Headers $headers }
