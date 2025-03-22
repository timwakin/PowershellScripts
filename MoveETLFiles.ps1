# Source directory for ETL source files
$sourceDir = "C:\Users\Tim\OneDrive\Documents1"

# Archive directory where files will be moved
$archiveDir = "E:\Archive"

# Check if the source directory exists
if (!(Test-Path -Path $sourceDir -PathType Container)) {
    Write-Host "Source directory '$sourceDir' does not exist. Please check the directory name and try again." -ForegroundColor Red 
    exit
}

# Check if the archive directory exists, create if it doesn't
if (!(Test-Path -Path $archiveDir -PathType Container)) {
    New-Item -ItemType Directory -Path $archiveDir
}

# Get all files in the source directory
$files = Get-ChildItem -Path $sourceDir -File

# Move each file to the archive directory
foreach ($file in $files) {
    $destinationPath = Join-Path -Path $archiveDir -ChildPath $file.Name
    try {
        Move-Item -Path $file.FullName -Destination $destinationPath -Force
        Write-Host "Moved '$($file.Name)' to '$archiveDir'."
    } catch {
        Write-Error "Error moving '$($file.Name)': $($_.Exception.Message)"
    }
}

Write-Host "File moving process complete."