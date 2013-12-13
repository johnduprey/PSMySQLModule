# you can override configuration value with simply add credential for each parameter.
$connection = New-PSMySQLModuleConnection -HostAddress "mysqlSample.hogehoge.ap-northeast-1.rds.amazonaws.com" -user hoge -Password fuga -Port 3306
Invoke-PSMySQLModuleReadQuery "show databases;" -connection $connection

# if you set configuration for "user, password, hostAddress, port" with PSMySQLModule-config.ps1, then you can omit it.
$connection = New-PSMySQLModuleConnection
Invoke-PSMySQLModuleReadQuery "show databases;" -connection $connection

# Dispose Connection
Disconnect-PSMySQLModuleConnection -connection $connection