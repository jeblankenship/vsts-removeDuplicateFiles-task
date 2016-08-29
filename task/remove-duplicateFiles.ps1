[CmdletBinding()]
param(
    [string] $sourceFolder,
    [string] $destinationFolder
)

Import-Module "Microsoft.TeamFoundation.DistributedTask.Task.Internal"
Import-Module "Microsoft.TeamFoundation.DistributedTask.Task.Common"

Write-Verbose "Entering script $($MyInvocation.MyCommand.Name)"
Write-Verbose "Parameter Values"
$PSBoundParameters.Keys | % { Write-HOST "  ${_} = $($PSBoundParameters[$_])" }
if($sourceFolder -eq $destinationFolder){
    Write-Error "Source and Destination folders cannot be the same"
    return
}

$sourceFilenames = (Get-ChildItem $sourceFolder).Name
if(!$sourceFilenames){
   Write-Warning "No files found in source folder: $sourceFolder"
   return
}
$Matches = Get-ChildItem $destinationFolder\*.* -include $sourceFilenames
foreach ($File in $Matches){ write-host “Deleting File $File” -foregroundcolor “Red”; Remove-Item $File | out-null }