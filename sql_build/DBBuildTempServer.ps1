param
(
      [string]$packageVersion = '0.1',
      [string]$packageID = 'Stackoverflow',
      [string]$packagePath = '',
      [string]$TempServer = 'MyLocalSQLServer',
      [string]$User_id = '',
      [string]$Password = '',
      [string]$testPath = 'C:\testResults',
      [string]$targetServerInstance = '.',
      [string]$targetDatabase = $packageID
)

$errorActionPreference = "stop"

Import-Module SqlChangeAutomation -ErrorAction silentlycontinue -ErrorVariable +ImportErrors


"***** PARAMETERS *****
packageVersion is $packageVersion
packageID is $packageID
packagePath is $packagePath
testPath is $testPath
targetServerInstance is $targetServerInstance
targetDatabase is $targetDatabase
**********************" | write-output


# Searching in the parent directory for a state folder
$myDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$scriptsFolder = Join-Path -Path $myDir -ChildPath '..\state'
$scriptsFolder
if (-not (Test-Path -PathType Container $scriptsFolder))
{
      Write-error "$scriptsFolder could not be found"
}

if ($User_id -ne '') #if no login specified, then it was a windows login
{
      $credentials = "User ID=$User_id;Password=$password;Integrated Security=False"
}
else
{
      $credentials = "Integrated Security=False"
}

$TempconnectionString = "Data Source=$TempServer;Initial Catalog=master;$credentials;Application Name=""SQL Change Automation"""

#Using Redgate SCA to validate the code in the state directory
try
{
      $validatedScriptsFolder = Invoke-DatabaseBuild $scriptsFolder -TemporaryDatabaseServer $TempconnectionString -SQLCompareOptions 'NoTransactions'
}
catch #
{
      $_.Exception.Message
      "$($Database.Name;) of $Tempserver couldn't be validated because $($_.Exception.Message)" | Foreach{
            write-error $_
      }
}
<#
# Export NuGet package
 $databasePackage = New-DatabaseBuildArtifact $validatedScriptsFolder -PackageId $packageID -PackageVersion $packageVersion
 Export-DatabaseBuildArtifact $databasePackage -Path $packagePath

# Run tests
 $testResultsFile = "$testPath\$packageID.junit.$packageVersion.xml"
 $results = Invoke-DatabaseTests $databasePackage
 Export-DatabaseTestResults $results -OutputFile $testResultsFile

# Sync a test database
 $targetDB = New-DatabaseConnection -ServerInstance $targetServerInstance -Database $targetDatabase
 Test-DatabaseConnection $targetDB
 Sync-DatabaseSchema -Source $databasePackage -Target $targetDB
 #> 
