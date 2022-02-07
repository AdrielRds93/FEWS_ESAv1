# Call this script in Azure Custom Script Extension for Virtual Machine Scale Set
# "variables": {
#        "env": {
#			"FEWS_MC_HOME_DIR=c:\fews
#			"FEWS_MC_MyMC_DATABASE_URL=jdbc:postgresql://192.168.99.100:6001/fewsdb01
#			"FEWS_MC_MyMC_DATABASE_USER=ffd
#			"FEWS_MC_MyMC_DATABASE_ENCRYPTED_PASSWORD=fdsfewqfaksdkja
#        }
#    },
#"commandToExecute": "[concat('powershell -ExecutionPolicy UnRestricted ', 
# 	'Start-BitsTransfer -Source "https://mystorage.blob.core.windows.net/builds/fews-stable-201802-87056-bin.zip" -Destination "d:\bin.zip";',
#   'Expand-Archive "d:\bin.zip" -DestinationPath "d:\bin";',
#	'Remove-Item -Path "d:\bin.zip";',
#   'd:\bin\windows\setEnvFromJsonBase64.ps1 ' base64(string(variables('env'))), ';',
#	'mcLauncherRegisterService.bat;',
#	'mcLauncherStartService.bat]"
param (
    [string]
    $base64_encoded
)

$json_string = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($base64_encoded))
$json_object = ConvertFrom-Json -InputObject $json_string

$json_object.PSObject.Properties | ForEach-Object {
	[Environment]::SetEnvironmentVariable($_.Name, $_.Value, "Machine")
}
