param(
    [Parameter(Mandatory)]
    $pat,
    [Parameter(Mandatory)]
    $organization,
    [Parameter(Mandatory)]
    $project,
    [Parameter(Mandatory)]
    $repositoryId  
)

$auth = [Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$pat"))
$headers = @{'Authorization'="Basic $auth"}

$result = Invoke-RestMethod `
    -Uri "https://dev.azure.com/$organization/$project/_apis/git/repositories/$repositoryId/refs?api-version=5.1&filter=tags/v" `
    -Headers $headers
$result.value | sort-object -Property name -Descending | Select-Object -First 1