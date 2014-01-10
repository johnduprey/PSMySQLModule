#Requires -Version 3.0

# Private Module to load default configuration
function Import-PSMySQLModuleConfiguration
{

    [CmdletBinding()]
    param
    (
        [string]
        $configdir = $PSScriptRoot
    )

    $ErrorActionPreference = "Stop"

    $PSMySQLModuleConfigFilePath = (Join-Path $configdir $PSMySQLModule.defaultconfigurationfile)

    if (Test-Path $PSMySQLModuleConfigFilePath -pathType Leaf) 
    {
        try 
        {
            . $PSMySQLModuleConfigFilePath
        } 
        catch 
        {
            throw ("Error Loading Configuration from {0}: " -f $PSMySQLModule.defaultconfigurationfile) + $_
        }
    }
}



# contains default base configuration, may not be override without version update.
$Script:PSMySQLModule = @{}
$PSMySQLModule.modulePath = Split-Path -parent $MyInvocation.MyCommand.Definition
$PSMySQLModule.helpersPath = "\functions\*.ps1"
$PSMySQLModule.defaultconfigurationfile = "\config\PSMySQLModule-config.ps1" # default configuration file name within office365.psm1
$PSMySQLModule.context = New-Object System.Collections.Stack # holds onto the current state of all variables

$PSMySQLModule.originalErrorActionPreference = $ErrorActionPreference
$PSMySQLModule.errorPreference = "Stop"
$PSMySQLModule.originalDebugPreference = $DebugPreference
$PSMySQLModule.debugPreference = "SilentlyContinue"

#-- Public Loading Module Parameters (Recommend to use ($PSMySQLModule.defaultconfigurationfile) for customization)--#

# contains MySQL Connection information
$PSMySQLModule.Reference = New-Object psobject -property @{
    MySQLDataDll            = "\reference\MySQL.Data.dll";
}

# contains MySQL Connection information
$PSMySQLModule.Connection = New-Object psobject -property @{
    user                    = "hoge";
    password                = "fuga";
    port                    = 3306;
    hostAddress             = "localhost";
}

# contains MySQL Get Schema Query
$PSMySQLModule.GetScheme = New-Object psobject -property @{
    query                  = "SELECT TABLE_SCHEMA AS SchemaName,TABLE_NAME AS TableName FROM information_schema.`TABLES`;"
}

# contains MySQL Get Column Query
$PSMySQLModule.GetColumn = New-Object psobject -property @{
    query                  = "SELECT column_name AS COLUMNNAME, data_type AS DATATYPE, is_nullable AS IsNullable, column_default AS COLUMNDEFAULT, table_name AS TABLENAME, Table_schema AS SCHEMANAME, COLUMN_COMMENT FROM INFORMATION_SCHEMA.COLUMNS;"
}

# contains MySQL Get Function Query
$PSMySQLModule.GetFunction = New-Object psobject -property @{
    query                  = "SHOW FUNCTION STATUS;"
}

# contains MySQL Get Partition Query
$PSMySQLModule.GetPartition = New-Object psobject -property @{
    TableList              = @{
        query                  = "SELECT DISTINCT(TABLE_NAME) FROM information_schema.`PARTITIONS` WHERE NODEGROUP = 'default';"
    }
    PartitionStatus        = @{
        query                  = "SELECT * FROM information_schema.`PARTITIONS` WHERE TABLE_NAME = {0};"
    }
}

$PSMySQLModule.GetTrigger = New-Object psobject -property @{
    query                  = "SHOW TRIGGERS;"
}


# -- Export Modules when loading this module -- #
# grab functions from files

Resolve-Path (Join-Path $PSMySQLModule.modulePath $PSMySQLModule.helpersPath) | 
    where { -not ($_.ProviderPath.Contains(".Tests.")) } |
    % { . $_.ProviderPath }


# -- Import Default configuration file -- #
Import-PSMySQLModuleConfiguration

#-- Export Modules when loading this module --#
# You can check with following Command
# Import-Module PSMySQLModule -Verbose -Force; $PSMySQLModule

Export-ModuleMember `
    -Function `
        * `
    -Variable `
        * `
    -Alias *