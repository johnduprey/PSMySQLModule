#Requires -Version 3.0

function Disconnect-PSMySQLModuleConnection
{

    param
    (
        [Parameter(
            Mandatory = 0,
            ValueFromPipeLinebyPropertyName,
            ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [MySql.Data.MySqlClient.MySqlConnection]
        $connection
    )
    
    begin
    {
        Write-Verbose ("Loading '{0}'." -f $PSCommandPath)
        $ErrorActionPreference = $PSMySQLModule.errorPreference
    }

    process
    {
        Write-Verbose "Disconnecting currenct mysql Connection."
        $connection.close()
        $connection.dispose()
    }
}
