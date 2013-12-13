PSMySQLModule
==========

# What is this?

Simple wrapper of MySQL.NET for PowerShell.
Just for Command send/receive from PowerShell host or ISE. 

# Cmdlets

Here's Cmdlets use in public

```text
CommandType     Name                                               ModuleName
-----------     ----                                               ----------
Function        Disconnect-PSMySQLModuleConnection                 PSMySQLModule
Function        Edit-PSMySQLModuleConfig                           PSMySQLModule
Function        Invoke-PSMySQLModuleNonQuery                       PSMySQLModule
Function        Invoke-PSMySQLModuleReadQuery                      PSMySQLModule
Function        New-PSMySQLModuleConnection                        PSMySQLModule
Function        Show-PSMySQLModuleConfig                           PSMySQLModule```
```

# Resolve MySql.Data.dll with NuGet

Project is developed by Visual Studio 2013 with "PowerShell Tools for Visual Studio". Thus you can use NuGet to load depending reference "MySql.Data.dll".

Just enable NuGet to resolve not referenced file and update it.

# Sample

You can find sample source in (sample)[https://github.com/guitarrapc/PSMySQLModule/tree/master/PSMySQLModule/Sample]

## Establish Connection

It's easy to carete connection. The only thing prerequisite is define credential information in ```PSMySQLModule-config.ps1```. 

### Prerequisite

You can define credentials inside configuration file ```PSMySQLModule-config.ps1```. 

```PowerShell
# contains MySQL Connection information
$PSMySQLModule.Connection = New-Object psobject -property @{
    user                    = "hoge";
    password                = "fuga";
    port                    = 3306;
    hostAddress             = "localhost";
}
```

So that each Cmndlet will use it in default.

### New-PSMySQLModuleConnection 

You can create connection in one line.

```PowerShell
# if you set configuration for "user, password, hostAddress, port" with PSMySQLModule-config.ps1, then you can omit it.
$connection = New-PSMySQLModuleConnection
```

### Override defined credential

Even if have defined credential inside ```PSMySQLModule-config.ps1```, you can override them by passing value for parameter.  

```PowerShell
# you can override configuration value with simply add credential for each parameter.
$connection = New-PSMySQLModuleConnection -HostAddress "mysqlSample.hogehoge.ap-northeast-1.rds.amazonaws.com" -user hoge -Password fuga -Port 3306
```

## Send Query

There are 2 types of Cmndlet you can use.

### Invoke-PSMySQLModuleReadQuery

This is for "Value returned query", something like "SELECT" and "SHOW". 

Just pass query strings and connection to the cmdlet. Then Cmdlet will execute it.

```PowerShell
# show query sample
Invoke-PSMySQLModuleReadQuery "show databases;" -connection $connection
```

```PowerShell
# select query sample
Invoke-PSMySQLModuleReadQuery "select * from hoge;" -connection $connection
```

### Invoke-PSMySQLModuleNonQuery

This is for "Value not returned query", something like "CREATE", "DELETE" or else. 

Just pass query strings and connection to the cmdlet. Then Cmdlet will execute it.

```PowerShell
# create function sample
DROP FUNCTION IF EXISTS samepl_function;
CREATE FUNCTION sameple_function()
 	RETURNS datetime
  	DETERMINISTIC
  	NO SQL
  	SQL SECURITY Definer
  	COMMENT 'sample function return current time + 1hours'
BEGIN	
    return CONVERT_TZ(CURRENT_TIMESTAMP(),'+00:00','+01:00');
END
```

## Remove Connection

After you finished use connection, then dispose it.
As PowerShell don't have (using) like C#, it requires explicit calls to Dispose() connection.

```PowerShell
# Dispose Connection
Disconnect-PSMySQLModuleConnection -connection $connection
```