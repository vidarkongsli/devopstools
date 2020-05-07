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
  $tag
)

$auth = [Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$pat"))
$headers = @{'Authorization' = "Basic $auth"}

$body = @"
{
    "itemVersion": {
      "versionType": "tag",
      "version": "$($tag -replace 'refs/tags/','')"
    },
    "compareVersion": {
      "versionType": "branch",
      "version": "master"
    },
    "includeWorkItems":true
  }  
"@

$result = Invoke-RestMethod -Uri "https://dev.azure.com/$organization/$project/_apis/git/repositories/$repositoryId/commitsbatch?api-version=5.1" `
  -Headers $headers `
  -Body $body -ContentType 'application/json' -Method POST

$result.value | where-object {$_.workItems}