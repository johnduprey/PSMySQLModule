#
# モジュール 'PSMySQLModule' のモジュール マニフェスト
#
# 生成者: guitarrapc
#
# 生成日: 2013/12/14
#

@{

# このマニフェストに関連付けられているスクリプト モジュール ファイルまたはバイナリ モジュール ファイル。
RootModule = 'PSMySQLModule.psm1'

# このモジュールのバージョン番号です。
ModuleVersion = '1.0.0'

# このモジュールを一意に識別するために使用される ID
GUID = 'd1c65a5f-bd20-4134-8053-60d02cc1c737'

# このモジュールの作成者
Author = 'guitarrapc'

# このモジュールの会社またはベンダー
CompanyName = 'guitarrapc'

# このモジュールの著作権情報
Copyright = '15/May/2013 -'

# このモジュールの機能の説明
Description = 'Wrap MySQL connection for PowerShell'

# このモジュールに必要な Windows PowerShell エンジンの最小バージョン
PowerShellVersion = '3.0'

# このモジュールに必要な Windows PowerShell ホストの名前
# PowerShellHostName = ''

# このモジュールに必要な Windows PowerShell ホストの最小バージョン
# PowerShellHostVersion = ''

# このモジュールに必要な Microsoft .NET Framework の最小バージョン
DotNetFrameworkVersion = '4.0'

# このモジュールに必要な共通言語ランタイム (CLR) の最小バージョン
CLRVersion = '4.0.30319.17929'

# このモジュールに必要なプロセッサ アーキテクチャ (なし、X86、Amd64)
# ProcessorArchitecture = ''

# このモジュールをインポートする前にグローバル環境にインポートされている必要があるモジュール
# RequiredModules = @()

# このモジュールをインポートする前に読み込まれている必要があるアセンブリ
# RequiredAssemblies = @()

# このモジュールをインポートする前に呼び出し元の環境で実行されるスクリプト ファイル (.ps1)。
# ScriptsToProcess = @()

# このモジュールをインポートするときに読み込まれる型ファイル (.ps1xml)
# TypesToProcess = @()

# このモジュールをインポートするときに読み込まれる書式ファイル (.ps1xml)
# FormatsToProcess = @()

# RootModule/ModuleToProcess に指定されているモジュールの入れ子になったモジュールとしてインポートするモジュール
# NestedModules = @()

# このモジュールからエクスポートする関数
FunctionsToExport = 'Disconnect-PSMySQLModuleConnection', 'Edit-PSMySQLModuleConfig', 
               'Invoke-PSMySQLModuleNonQuery', 'Invoke-PSMySQLModuleReadQuery', 
               'New-PSMySQLModuleConnection', 'Show-PSMySQLModuleConfig'

# このモジュールからエクスポートするコマンドレット
CmdletsToExport = '*'

# このモジュールからエクスポートする変数
VariablesToExport = 'PSMySQLModule'

# このモジュールからエクスポートするエイリアス
AliasesToExport = '*'

# このモジュールに同梱されているすべてのモジュールのリスト
# ModuleList = @()

# このモジュールに同梱されているすべてのファイルのリスト
# FileList = @()

# RootModule/ModuleToProcess に指定されているモジュールに渡すプライベート データ
# PrivateData = ''

# このモジュールの HelpInfo URI
# HelpInfoURI = ''

# このモジュールからエクスポートされたコマンドの既定のプレフィックス。既定のプレフィックスをオーバーライドする場合は、Import-Module -Prefix を使用します。
# DefaultCommandPrefix = ''

}

