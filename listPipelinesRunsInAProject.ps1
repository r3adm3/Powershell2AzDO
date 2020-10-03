$AzureDevOpsPAT = get-content .\credsfile.txt
$OrganizationName = "techfrontier"
$projectid = "dockerOrchestrationExperiment"

$AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }

$UriOrga = "https://dev.azure.com/$($OrganizationName)/$($projectid)/" 
$uriAccount = $UriOrga + "_apis/build/builds?api-version=5.0"

write-output $uriAccount

$output = Invoke-RestMethod -Uri $uriAccount -Method get -Headers $AzureDevOpsAuthenicationHeader 

$output.value | Sort-Object id -Descending|ForEach-Object {
    Write-Host $_.buildNumber - $_.status - $_.reason# - $_.definition - $_.url
}