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

