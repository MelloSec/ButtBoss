function Copy-Desktop
{
  # Set our current desktop and copy Desktop Contents to Goofin for safe keepin
  $desktop = [Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop)
  Copy-Item -Path $desktop -Destination "C:\Goofin\cuts"
}
Copy-Desktop
function Get-Targets
{
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory=$false, Position=0)]
    [Object]
    $targets = (Get-ChildItem $desktop)
  )
  
  $buttList = $targets
  $buttCount = $buttList.Count
}
Acquire-Targets

function Initialize-ButtSeeds
{
  # seed array from text file and pulls an entry at random, converts to a string and returns
  $seeds = Get-Content "C:\Goofin\buttseeds.txt"
  $hash = @{}
  foreach ($s in $seeds)
  {
    $hash.add($s,(Get-Random -Maximum $seeds.count))
  }
  $hash.GetEnumerator() | Get-Random -OutVariable buttSeed
  $buttSearch = $buttSeed.Name
}
Initialize-ButtSeeds

# create a WebClient instance that will handle Network communications 
$webClient = New-Object System.Net.WebClient

# load System.Web so we can use HttpUtility
Add-Type -AssemblyName System.Web

function Find-Butts
{
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory=$false, Position=0)]
    [System.String]
    $downloadFolder = "C:\Goofin\butts",
    
    [Parameter(Mandatory=$false, Position=1)]
    [System.Object]
    $searchFor = $buttSearch,
    
    [Parameter(Mandatory=$false, Position=2)]
    [System.Object]
    $numImages = $buttCount,
    
    [Parameter(Mandatory=$false, Position=3)]
    [Object]
    $searchQuery = [System.Web.HttpUtility]::UrlEncode($searchFor),
    
    [Parameter(Mandatory=$false, Position=4)]
    [Object]
    $url = "http://www.bing.com/images/search?q=$searchQuery&first=0&count=$numImages&qft=+filterui%3alicense-L2_L3_L4"
  )
  
  # URL encode our search query
  
  
  
  
  
  $webpage = $webclient.DownloadString($url)
}
Find-Butts

# regex Urls terminating with '.jpg' or '.png'
$regex = "[(http(s)?):\/\/(www\.)?a-z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-z0-9@:%_\+.~#?&//=]*)((.jpg(\/)?)|(.png(\/)?)){1}(?!([\w\/]+))"
$listImgUrls = $webpage | Select-String -pattern $regex -Allmatches | ForEach-Object {$_.Matches} | Select-Object $_.Value -Unique

