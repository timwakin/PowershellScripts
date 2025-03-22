$source = "C:\Users\Tim\OneDrive\Documents"
$destination = "E:\Documents"

#Copy files to destination folder
Copy-Item -Path $source -Destination $destination -Recurse -Force 
   
 Write-Host "All files copied from $source to $destination"