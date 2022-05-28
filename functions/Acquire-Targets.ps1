function Acquire-Targets
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