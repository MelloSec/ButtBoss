param(
[string]$targetFiles "replace.",
[string]$targetRename = "",
[string]$directory 
)

$filesToReplace = (Get-ChildItem -Path $directory -Filter *$targetFiles* -Recurse).Fullname

foreach($file in $filesToReplace)
{
    $originalFile = $file.replace("$($targetFiles)","$($targetRename)")
    remove-item $originalFile -Force  
    rename-item $file $originalFile -Force
}
