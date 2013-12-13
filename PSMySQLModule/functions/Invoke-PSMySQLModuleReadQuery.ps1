#Requires -Version 3.0

function Invoke-PSMySQLModuleReadQuery
{
    Param
    (
        [Parameter(
            Mandatory = 0,
            ValueFromPipeLinebyPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $query,

        [Parameter(
            Mandatory = 0,
            ValueFromPipeLinebyPropertyName)]
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
        try
        {
            Write-Verbose "Creating new object with passed 'Connection' and 'Query'."
            $command = New-Object MySql.Data.MySqlClient.MySqlCommand($query, $connection)
            $dataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($command)
        
            Write-Verbose "Creating new Dataset to Fill in returned table."
            $dataSet = New-Object System.Data.DataSet
        
            Write-Verbose "Filling returned data to dataset."
            $recordCount = $dataAdapter.Fill($dataSet, "data")

            Write-Verbose "Returing Table in Dataset to Result."
            $result = $dataSet.Tables[0]
        }
        catch 
        {
            Write-Host ("ERROR : Unable to run query : '{0}' `n{1}" -f $query, $_) -ForegroundColor Red
        }
        finally 
        {
            Write-Verbose "Command disposed."
            $Command.Dispose()
        }
    }
    end
    {
        return $Result
    }

}