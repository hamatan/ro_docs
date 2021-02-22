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
$ro2 = import-csv ./db/03_monster_map.csv -Encoding UTF8 -Header "モンスタID","モンスタ名","マップID","出現タイプ","出現数","出現時間","ランダム幅","備考","サブマップソートNo","サブマップ名" | Select-Object -Skip 1

#############################################################
# GUIで表示
$ro2 | select-object "モンスタ名","出現数","出現時間","ランダム幅","マップID","サブマップ名" | Out-GridView -wait
