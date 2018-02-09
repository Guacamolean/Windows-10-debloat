$ErrorActionPreference = 'SilentlyContinue'

Write-Output "Uninstalling default apps"
$apps = @(
    "89006A2E.AutodeskSketchBook"
    "A278AB0D.DisneyMagicKingdoms"
    "A278AB0D.MarchofEmpires"
    "king.com.BubbleWitch3Saga"
    "king.com.CandyCrushSodaSaga"
    "Microsoft.BingNews"    
    "Microsoft.Office.OneNote"
    "Microsoft.SkypeApp"
    "Microsoft.XboxApp"
    "SpotifyAB.SpotifyMusic"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.Getstarted"
    "Microsoft.People"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsCamera"
    "Microsoft.windowscommunicationsapps"
    "Microsoft.OneConnect"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.BingWeather"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
)

foreach ($app in $apps) {
    Write-Output "Trying to remove $app"
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
    Get-AppxPackage -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -EQ $app | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue

}

# Prevents "Suggested Applications" returning
IF (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content")) {
    New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content"
}
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content" "DisableWindowsConsumerFeatures" 1

#Cortana
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -PropertyType DWORD
