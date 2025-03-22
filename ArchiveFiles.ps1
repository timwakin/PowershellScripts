$source = "C:\Users\Tim\OneDrive\Documents\*.xlsx"
$destination = "E:\ExcelArchive_$(Get-Date -Format 'yyyyMMdd').zip"

$compress = @{
  Path = $source
  CompressionLevel = "Fastest"
  DestinationPath =  $destination 
}


$Error.Clear()

try{
    Compress-Archive @compress
}
catch{
  write-host "An error occurred: $($_.Exception.Message)" -ForegroundColor Red 
} 

if(!$Error){
        Write-Host "files archived to $destination" -ForegroundColor Green 
    }
