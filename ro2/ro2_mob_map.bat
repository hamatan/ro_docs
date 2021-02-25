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
$csvfile1 = "./db/03_monster_map.csv"
$csvfile2 = "./db/06_map_portal.csv"

if( Test-Path $csvfile1 ) {
   $ro2 = import-csv $csvfile1 -Encoding UTF8 -Header "ID","NAME","MAP","type","count","time","random","notes","subMAP_No","subMAP" | Select-Object -Skip 1
}
else{
   [System.Windows.Forms.MessageBox]::Show('cant open csv file','error')
   exit
}

if( Test-Path $csvfile2 ) {
   $map = import-csv $csvfile2 -Encoding UTF8 -Header "ID","MAP_NAME","KANA","city","portal","map_in","dun_in","Fld_Dun_MD","delete","BGM","BGM_title","country","area","pass","quest","party","zeny","time_limit","CT","re_Try","notes","short_NAME","sNAME_KANA" | Select-Object -Skip 1
}
else{
   [System.Windows.Forms.MessageBox]::Show('cant open csv file','error')
   exit
}

#############################################################
# マップ名を抽出
# やべえ位遅い、リアルに5秒位かかる
#foreach($work in $ro2){ `
#   foreach($work2 in $map){ `
#      if( $work.MAP -match $work2.ID ){ `
#          $work.MAP = $work2.MAP_NAME `
#      } `
#   } `
#} `
#
#############################################################
# ↑の高速化
Measure-Command{ `

#$maplist = @();
$map_id  = New-Object 'System.Collections.Generic.List[System.String]';
$map_name= New-Object 'System.Collections.Generic.List[System.String]';

foreach( $temp in $map ){ `
#   $work      = New-Object PSObject | Select-Object ID, NAME; `
#   $work.ID   = $temp.ID; `
#   $work.NAME = $temp.MAP_NAME; `
#   $maplist  += $work; `
   $map_id.Add($temp.ID);
   $map_name.Add($temp.MAP_NAME);
}
## 地獄のようなifブロック生成1 (文字列にしたらutf-8で文字化けした、ANSIなら最速 0.8sec)
##foreach( $temp in $maplist ){ `
##   "   elseif( `$work.MAP -eq `"{0}`" ) {{ `$work.MAP = `"{1}`" }}" -f $temp.ID,$temp.NAME >> cachemap.txt; `
##}
#
# 地獄のようなifブロック生成2 (1.8sec)
#$i=0;
#foreach( $temp in $maplist ){ `
#   "   elseif( `$work.MAP -eq `$maplist[{0}].ID ) {{ `$work.MAP = `$maplist[{0}].NAME }}" -f $i >> cachemap.txt; `
#   $i++;  `
#}
#
# 地獄のようなifブロック
foreach( $work in $ro2 ){  `
   $i = [array]::IndexOf($map_id, $work.MAP); `
   $work.MAP = $map_name[$i]; `
}
}
#############################################################
# GUIで表示
$ro2 | select-object "NAME","count","time","random","MAP","subMAP" | Out-GridView -wait
