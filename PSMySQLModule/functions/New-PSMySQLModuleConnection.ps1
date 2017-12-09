#Requires -Version 3.0

function New-PSMySQLModuleConnection
{
    Param
    (
        [Parameter(
            Mandatory = 0,
            position = 0,
            ValueFromPipeLinebyPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $User = $PSMySQLModule.Connection.user,

        [Parameter(
            Mandatory = 0,
            position = 1,
            ValueFromPipeLinebyPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Password = $PSMySQLModule.Connection.password,

        [Parameter(
            Mandatory = 0,
            position = 2,
            ValueFromPipeLinebyPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $HostAddress = $PSMySQLModule.Connection.hostAddress,

        [Parameter(
            Mandatory = 0,
            position = 3,
            ValueFromPipeLinebyPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Port = $PSMySQLModule.Connection.port,

        [Parameter(
            Mandatory = 0,
            position = 4,
            ValueFromPipeLinebyPropertyName)]
        [string]
        $SchemaName,

        [Parameter(
            Mandatory = 0,
            position = 5,
            ValueFromPipeLinebyPropertyName)]
        [string]
        $allow_zero_datetime = "True",

        [Parameter(
            Mandatory = 0,
            position = 6,
            ValueFromPipeLinebyPropertyName)]
        [string]
        $convert_zero_datetime = "True"
    )

    begin
    {
        Write-Verbose "Create Connection String"
        $ErrorActionPreference = $PSMySQLModule.errorPreference

        if ([string]::IsNullOrWhiteSpace($HostAddress) -or [string]::IsNullOrWhiteSpace($port) -or [string]::IsNullOrWhiteSpace($user) -or [string]::IsNullOrWhiteSpace($Password))
        {
            Write-Warning ("Input parameter detected as Null or WhiteSpace, please check followings. hostaddress : '{0}', port : '{1}', user : '{3}', password : '{4}'" -f $HostAddress, $port, $User, $Password)
        }
        else
        {
            $ConnectionString = "server={0};port={1};uid={2};pwd={3};database={4};Convert Zero Datetime=$convert_zero_datetime;Allow Zero Datetime=$allow_zero_datetime" -f $HostAddress, $port, $User, $Password, $SchemaName
        }
    }
    process
    {
        # Create Abolute path to MySQL.Data.dll
        $MySQLDataDll = Join-Path $PSMySQLModule.modulePath $PSMySQLModule.Reference.MySQLDataDll

        if (-not (Test-Path $MySQLDataDll))
        {
            throw ("Could not find MySQL.Data.dll from path '{0}'" -f $MySQLDataDll)
        }
        else
        {
            Try 
            {
                Write-Verbose ("Loading MySQL.Data.Dll from path {0}" -f $MySQLDataDll)
                Add-Type -Path $MySQLDataDll

                Write-Verbose "Create MySQL Connection Instance"
                $Connection = New-Object MySql.Data.MySqlClient.MySqlConnection

                Write-Verbose ("set Connection strings as '{0}'" -f $ConnectionString)
                $Connection.ConnectionString = $ConnectionString

                Write-Verbose "Opening new connection."
                $Connection.Open()
            }
            catch [System.Management.Automation.PSArgumentException] 
            {
                throw "Unable to connect to MySQL server, do you have the MySQL connector installed..?"
            }
            Catch 
            {
                throw ("ERROR : Unable to Open Connection : '{0}' `n{1}" -f $HostAddress, $_)
            }
            Finally 
            {
            }
        }
    }
    end
    {
        Write-Verbose "Connection Successfuly created."
        return $Connection
    }
}