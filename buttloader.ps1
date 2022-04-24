# House keeping script that downloads current version of buttboss from github and executes in memory instead of downloading to disk 

# Get creds to run as admin / warn a scrub 
Get-Credentials

# Create goofin/butts goofin/cuts and the seeds for grand plan
Mkdir "C:\Goofin\butts" -Force
Mkdir "C:\Goofin\cuts" 
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mellonaut/ButtBoss/main/buttseeds.txt" -O "C:\Goofin\butts\buttseeds.txt"


# Grab buttboss from github and execute in memory
powershell -exec bypass -c "(New-Object Net.WebClient).Proxy.Credentials=[Net.CredentialCache]::DefaultNetworkCredentials;iwr('http://github.com/mellonaut/buttboss/buttboss.ps1')|iex"

