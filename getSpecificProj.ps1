$AzureDevOpsPAT = get-content .\credsfile.txt
$OrganizationName = "techfrontier"

$AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }

$UriOrga = "https://dev.azure.com/$($OrganizationName)/" 
$uriAccount = $UriOrga + "_apis/projects/1348193c-3d50-468a-85af-11889bf26628?includeCapabilities=True&api-version=5.1"

$output = Invoke-RestMethod -Uri $uriAccount -Method get -Headers $AzureDevOpsAuthenicationHeader 

write-host "  ** Headers   : $($AzureDevOpsAuthenicationHeader['Authorization'])"
write-host "  ** uriAccout : $($uriAccount)"
write-host ""

$output