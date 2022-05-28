function Copy-Desktop
{
  # Set our current desktop and copy Desktop Contents to Goofin for safe keepin
  $desktop = [Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop)
  Copy-Item -Path $desktop -Destination "C:\Goofin\cuts"
}