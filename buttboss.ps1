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

function Search-Flickr ([string]$tags, [int]$count = 1) 
{
    $api_key = "b7f795e33e775e9620fd16a6a7bc68ed"
    $secret = "6521d819f8202c52"
    $search = Invoke-RestMethod -Uri "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=$api_key&secret=$secret&tags=$tags&extras=url_z&content_type=1&per_page=$count&format=rest" -Method Get
    $search = [xml] $search

Write-Verbose $search.OuterXml

$url = $search.rsp.photos.photo.url_z
if ($url -eq $null -or $url[0] -eq $null) {
    return
	}
return $url
}

# seeds array from text file and  pulls an entry at random, converts to a string and returns
$seeds = Get-Content .\buttseeds.txt
$hash = @{}
foreach ($s in $seeds)
 {
  $hash.add($s,(Get-Random -Maximum $seeds.count))
 }
$hash.GetEnumerator() | Get-Random -OutVariable buttseed
$buttseed | out-string | echo


# Main method for obtaining sweet butt shots for grand plan  
$url = Search-Flickr $buttseed+(Get-Random -Maximum $seeds.count)



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