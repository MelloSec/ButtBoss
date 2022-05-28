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

