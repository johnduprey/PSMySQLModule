#Requires -Version 3.0

function Invoke-PSMySQLModuleNonQuery
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
            $Command = $connection.CreateCommand()

            Write-Verbose "Loading Query."
            $Command.CommandText = $query

            Write-Verbose "Executing Query."
            $Result = $Command.ExecuteNonQuery()

            if ($query -match "insert") {
                $Result = $Command.LastInsertedId
            }
        }
        catch 
        {
            Write-Host ("ERROR : Unable to run query : '{0}' `n{1}" -f $query, $_) -ForegroundColor Red
        }
        finally
        {
            Write-Verbose "Dispose Command."
            $Command.Dispose()
        }
    }
    end
    {
        return $Result
    }
}