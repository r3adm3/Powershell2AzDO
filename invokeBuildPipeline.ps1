$AzureDevOpsPAT = get-content .\credsfile.txt
$OrganizationName = "techfrontier"
$projectid = "dockerOrchestrationExperiment"
$definitionId = "13"

$AzureDevOpsAuthenticationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")); 'Content-Type' = 'application/json' }


write-output $AzureDevOpsAuthenticationHeader

$UriOrga = "https://dev.azure.com/$($OrganizationName)/$($projectid)/" 
$uriAccount = $UriOrga + "_apis/build/builds?definitionId=$($definitionId)&api-version=6.0"

write-output ""
write-output "calling: $uriAccount"

$output = Invoke-RestMethod -Uri $uriAccount -Method post -Headers $AzureDevOpsAuthenticationHeader 

write-output "build id: $($output.id)"
