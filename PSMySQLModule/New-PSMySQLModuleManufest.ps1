$script:module = "PSMySQLModule"
$script:RequiredModules = @()

$script:moduleVersion = "1.0.0"
$script:functionToExport = @(
    "Disconnect-PSMySQLModuleConnection",
    "Edit-PSMySQLModuleConfig",
    "Invoke-PSMySQLModuleNonQuery",
    "Invoke-PSMySQLModuleReadQuery",
    "New-PSMySQLModuleConnection",
    "Show-PSMySQLModuleConfig"
)

$script:variableToExport = "PSMySQLModule"

$script:moduleManufest = @{
    Path = "$module.psd1";
    Author = "guitarrapc";
    CompanyName = "guitarrapc"
    Copyright = "15/May/2013 -"; 
    ModuleVersion = $moduleVersion
    description = "Wrap MySQL connection for PowerShell";
    PowerShellVersion = "3.0";
    DotNetFrameworkVersion = "4.0";
    ClrVersion = "4.0.30319.17929";
    RequiredModules = $RequiredModules;
    RootModule = "$module.psm1";
    CmdletsToExport = "*";
    FunctionsToExport = $functionToExport
    VariablesToExport = $variableToExport;
}

New-ModuleManifest @moduleManufest