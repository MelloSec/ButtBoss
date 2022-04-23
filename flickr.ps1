$tags = "butts"

function Search-Flickr ([string]$tags, [int]$count = 1) 
{
    $api_key = "b7f795e33e775e9620fd16a6a7bc68ed"
    $secret = "6521d819f8202c52"
    $search = Invoke-RestMethod -Uri "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=$api_key&secret=$secret&tags=$tags&extras=url_z&content_type=1&per_page=$count&format=rest" -Method Get
    $search = [xml] $search
}