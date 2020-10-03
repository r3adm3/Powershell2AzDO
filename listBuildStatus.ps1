$AzureDevOpsPAT = get-content .\credsfile.txt
$OrganizationName = "techfrontier"
$projectid = "dockerOrchestrationExperiment"
$buildId = "1629"

$AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }

$UriOrga = "https://dev.azure.com/$($OrganizationName)/$($projectid)/" 
$uriAccount = $UriOrga + "_apis/build/builds?api-version=6.0"

write-output $uriAccount

$output = Invoke-RestMethod -Uri $uriAccount -Method get -Headers $AzureDevOpsAuthenicationHeader 

write-output $output.Status

$output.value | where-object id -eq $buildId | ForEach-Object {
    Write-Host $_.id - $_.buildNumber - $_.status - $_.reason# - $_.definition - $_.url
}