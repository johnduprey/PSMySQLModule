#-- Public Loading Module Parameters (Recommend to use ($PSMySQLModule.defaultconfigurationfile) for customization)--#

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
