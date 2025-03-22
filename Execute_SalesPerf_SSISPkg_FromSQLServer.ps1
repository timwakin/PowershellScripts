#Variables
$SSISNamespace = "Microsoft.SqlServer.Management.IntegrationServices" 
$TargetServerName = "localhost"
$TargetFolderName = "SandboxPkgs"
$ProjectName = "SalesPerfUpload"
$PackageName = "DemoSalesPerf.dtsx" 

#Load the IntegrationServices assembly
$loadStatus = [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Management.IntegrationServices") | Out-Null 

#Create a connection to the server
$sqlConnectionString = 
    "Data Source= " + $TargetServerName + ";Initial Catalog=master; Integrated Security=SSPI;"
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $sqlConnectionString

#Create the Integration Services Object 
$integrationServices = New-Object $SSISNamespace".IntegrationServices" $sqlConnection

#Get the Ingetgration Servives catalog 
$catalog = $integrationServices.Catalogs["SSISDB"]

#Get the folder 
$folder = $catalog.Folders[$TargetFolderName]

#Get the project 
$project = $folder.Projects[$ProjectName] 

#Get the package 
$package = $project.Packages[$PackageName]

#Clear any error records
$Error.clear() 

#Try to run the package, notifying user of any errors  
try{
    Write-Host "Running " $PackageName "..." 

    $result = $package.Execute("false",$null) 
}
catch{
 write-host "An error occurred: $($_.Exception.Message)" -ForegroundColor Red 
}

#If no errors, notify user of package completion 
if(!$Error){
    Write-Host $PackageName " executed successfully." -ForegroundColor Green 
}