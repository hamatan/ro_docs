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
$csvfile1 = "./db/01_monster_drop_item.csv"
$csvfile2 = "./db/03_monster_map.csv"
$csvfile3 = "./db/06_map_portal.csv"

if( Test-Path $csvfile1 ) {
   $ro2 = import-csv $csvfile1 -Encoding UTF8 -Header "ID","NAME","drop_item1","drop_per1","drop_item2","drop_per2","drop_item3","drop_per3","drop_item4","drop_per4","drop_item5","drop_per5","drop_item6","drop_per6","drop_item7","drop_per7","drop_item8","drop_per8" | Select-Object -Skip 1
}
else{
   [System.Windows.Forms.MessageBox]::Show('cant open csv file','error')
   exit
}

if( Test-Path $csvfile2 ) {
   $mob = import-csv $csvfile2 -Encoding UTF8 -Header "ID","NAME","MAP","type","count","time","random","notes","subMAP_No","subMAP" | Select-Object -Skip 1
}
else{
   [System.Windows.Forms.MessageBox]::Show('cant open csv file','error')
   exit
}

if( Test-Path $csvfile3 ) {
   $map = import-csv $csvfile3 -Encoding UTF8 -Header "ID","MAP_NAME","KANA","city","portal","map_in","dun_in","Fld_Dun_MD","delete","BGM","BGM_title","country","area","pass","quest","party","zeny","time_limit","CT","re_Try","notes","short_NAME","sNAME_KANA" | Select-Object -Skip 1
}
else{
   [System.Windows.Forms.MessageBox]::Show('cant open csv file','error')
   exit
}

#############################################################
# マップ名を抽出
$map_id  = New-Object 'System.Collections.Generic.List[System.String]';
$map_name= New-Object 'System.Collections.Generic.List[System.String]';
$mob_cnt = New-Object 'System.Collections.Generic.List[System.String]';

foreach( $work in $map ){ `
   $map_id.Add($work.ID); `
   $map_name.Add($work.MAP_NAME);
}

foreach( $work in $mob ){  `
   $i = [array]::IndexOf($map_id, $work.MAP); `
   if( $i -ne -1){
      $work.MAP = $map_name[$i]; `
      $mob_cnt.Add($work.count);
   }
   else{
      $mob_cnt.Add( "" );
   }
}

#############################################################
#Measure-Command{ `
$newtable = New-Object 'System.Collections.Generic.List[System.String]';
foreach($work in $ro2){ `
#	$data = New-Object PSObject | Select-Object ID, NAME, MAP, ITEM1, ITEM2, ITEM3, ITEM4, ITEM5, ITEM6, ITEM7, ITEM8;

#	$data.ID   = $work.ID;
#	$data.NAME = $work.NAME;

# ドロップ率をアイテム名に含める
	if($work.drop_per1 -ne 0){ $item1 = $work.drop_item1 + " ("+ 0.01* $work.drop_per1 +"%)" }else{ $item1 = $work.drop_item1 }; `
	if($work.drop_per2 -ne 0){ $item2 = $work.drop_item2 + " ("+ 0.01* $work.drop_per2 +"%)" }else{ $item2 = $work.drop_item2 }; `
	if($work.drop_per3 -ne 0){ $item3 = $work.drop_item3 + " ("+ 0.01* $work.drop_per3 +"%)" }else{ $item3 = $work.drop_item3 }; `
	if($work.drop_per4 -ne 0){ $item4 = $work.drop_item4 + " ("+ 0.01* $work.drop_per4 +"%)" }else{ $item4 = $work.drop_item4 }; `
	if($work.drop_per5 -ne 0){ $item5 = $work.drop_item5 + " ("+ 0.01* $work.drop_per5 +"%)" }else{ $item5 = $work.drop_item5 }; `
	if($work.drop_per6 -ne 0){ $item6 = $work.drop_item6 + " ("+ 0.01* $work.drop_per6 +"%)" }else{ $item6 = $work.drop_item6 }; `
	if($work.drop_per7 -ne 0){ $item7 = $work.drop_item7 + " ("+ 0.01* $work.drop_per7 +"%)" }else{ $item7 = $work.drop_item7 }; `
	if($work.drop_per8 -ne 0){ $item8 = $work.drop_item8 + " ("+ 0.01* $work.drop_per8 +"%)" }else{ $item8 = $work.drop_item8 }; `

# マップ名にモンスター名とドロップ率を追加
	$i = [array]::IndexOf($mob.ID, $work.ID); `
	if( $i -ne -1){
		$newtable.add( $work.ID + "," + $work.NAME + "," + "["+ $mob_cnt[$i] +"] / " + $mob[$i].MAP + "," + $item1 + "," + $item2 + "," + $item3 + "," + $item4 + "," + $item5 + "," + $item6 + "," + $item7 + "," + $item8 );
	}
	else{
		$newtable.add( $work.ID + "," + $work.NAME + "," + ""                                       + "," + $item1 + "," + $item2 + "," + $item3 + "," + $item4 + "," + $item5 + "," + $item6 + "," + $item7 + "," + $item8 );
	}
#	$newtable += $data;
}
#}
#############################################################
# GUIで表示
$newtable | ConvertFrom-Csv -Header "ID", "NAME", "MAP", "ITEM1", "ITEM2", "ITEM3", "ITEM4", "ITEM5", "ITEM6", "ITEM7", "ITEM8" | Out-GridView -wait
