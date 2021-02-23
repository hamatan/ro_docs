@(echo '> NUL
echo off)
setlocal enableextensions
set "THIS_PATH=%~f0"
set "PARAM_1=%~1"
PowerShell.exe -windowstyle hidden -Command "iex -Command ((gc \"%THIS_PATH:`=``%\") -join \"`n\")"
exit /b %errorlevel%
-- この1つ上の行までバッチファイル
') | sv -Name TempVar
# 参考
# https://www.pg-fl.jp/program/tips/ps1bat.htm
# ここからPowerShellスクリプト
#
#############################################################
# csvファイルを開く
Add-Type -Assembly System.Windows.Forms
$csvfile = "./db/03_monster_map.csv"

if( Test-Path $csvfile ) {
   $ro2 = import-csv $csvfile -Encoding UTF8 -Header "モンスタID","モンスタ名","マップID","出現タイプ","出現数","出現時間","ランダム幅","備考","サブマップソートNo","サブマップ名" | Select-Object -Skip 1
}
else{
   [System.Windows.Forms.MessageBox]::Show('cant open csv file','error')
   exit
}

#############################################################
# GUIで表示
$ro2 | select-object "モンスタ名","出現数","出現時間","ランダム幅","マップID","サブマップ名" | Out-GridView -wait
