$AzureDevOpsPAT = get-content .\credsfile.txt
$OrganizationName = "techfrontier"

$AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }

$UriOrga = "https://dev.azure.com/$($OrganizationName)/" 
$uriAccount = $UriOrga + "_apis/projects?api-version=5.1"

$output = Invoke-RestMethod -Uri $uriAccount -Method get -Headers $AzureDevOpsAuthenicationHeader 

$output.value | ForEach-Object {
    Write-Host $_.name
}