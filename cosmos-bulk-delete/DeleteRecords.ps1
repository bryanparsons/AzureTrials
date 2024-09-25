Set-StrictMode -Version "latest"
Clear-Host
. $PSScriptRoot\common.ps1

Write-Host "Getting Cosmos context"
$CosmosContext=New-CosmosDbContext -Database $Global:CosmosDatabase -ResourceGroupName $Global:CosmosResourceGroup  -Account $Global:CosmosAccountName
Write-Host ("Got Cosmos context for Cosmos account: '{0}'  and database: '{1}'" -f $CosmosContext.Account, $CosmosContext.Database)


function GetAllDocuments {
    #Remember to include Partition key path in field list
    $allDocs = Get-CosmosDbDocument -CollectionId $Global:CosmosContainer -QueryEnableCrossPartition $true -Query "SELECT c.id, c.targetUserType FROM c WHERE c.deactivationDateTime < '2019-12-31T00:00:00'" -Context $CosmosContext
    if ($null -eq $allDocs)
    {
        return ,@()
    }
    return $allDocs
}

function  DeleteDocuments {
    param ($documents)
    foreach ($doc in $documents) {
        #Remember to specify Partition key
        Remove-CosmosDbDocument -Context $CosmosContext -CollectionId $Global:CosmosContainer -Database $Global:CosmosDatabase -Id $doc.id -PartitionKey $doc.targetUserType
    }
}
$documents=GetAllDocuments
Write-Host ("`nFound {0} documents in the Container {1} within Account {2}." -f $documents.length,$Global:CosmosContainer,$CosmosContext.Account)
# Check the account matches by using 'SELECT count(c.id) FROM c WHERE ******' in Cosmos, it should match the number returned here.
# If the count of files is very high, in excess of 45,000, you may get an inaccurate count from this script as the query will time out.

$confirmation = Read-Host "`nAre you sure you want to permanently delete them? (enter y to proceed)"
if ($confirmation -eq 'y') {
    DeleteDocuments -documents $documents
    Write-Host "Deletion complete"
}

