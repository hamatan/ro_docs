@(echo '> NUL
echo off)
setlocal enableextensions
set "THIS_PATH=%~f0"
set "PARAM_1=%~1"
PowerShell.exe -Command "iex -Command ((gc \"%THIS_PATH:`=``%\") -join \"`n\")"
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

foreach( $work in $map ){ `
   $map_id.Add($work.ID);
   $map_name.Add($work.MAP_NAME);
}

foreach( $work in $mob ){  `
   $i = [array]::IndexOf($map_id, $work.MAP); `
   if( $i -ne -1){
      $work.MAP = $map_name[$i]; `
   }
}

#############################################################
# ドロップ率をアイテム名に含める
Measure-Command{ `
$newtable = @()
foreach($work in $ro2){ `
#	$data = New-Object PSObject | Select-Object ID, NAME, MAP, ITEM1, ITEM2, ITEM3, ITEM4, ITEM5, ITEM6, ITEM7, ITEM8;

#	$data.ID   = $work.ID;
#	$data.NAME = $work.NAME;

	$newtable.add($work.ID   + ",");
	$newtable.add($work.NAME + ",");

	if($work.drop_per1 -ne 0){ $data.ITEM1 = $work.drop_item1 + " ("+ 0.01* $work.drop_per1 +"%)" }else{ $data.ITEM1 = $work.drop_item1	}; `
	if($work.drop_per2 -ne 0){ $data.ITEM2 = $work.drop_item2 + " ("+ 0.01* $work.drop_per2 +"%)" }else{ $data.ITEM2 = $work.drop_item2	}; `
	if($work.drop_per3 -ne 0){ $data.ITEM3 = $work.drop_item3 + " ("+ 0.01* $work.drop_per3 +"%)" }else{ $data.ITEM3 = $work.drop_item3	}; `
	if($work.drop_per4 -ne 0){ $data.ITEM4 = $work.drop_item4 + " ("+ 0.01* $work.drop_per4 +"%)" }else{ $data.ITEM4 = $work.drop_item4	}; `
	if($work.drop_per5 -ne 0){ $data.ITEM5 = $work.drop_item5 + " ("+ 0.01* $work.drop_per5 +"%)" }else{ $data.ITEM5 = $work.drop_item5	}; `
	if($work.drop_per6 -ne 0){ $data.ITEM6 = $work.drop_item6 + " ("+ 0.01* $work.drop_per6 +"%)" }else{ $data.ITEM6 = $work.drop_item6	}; `
	if($work.drop_per7 -ne 0){ $data.ITEM7 = $work.drop_item7 + " ("+ 0.01* $work.drop_per7 +"%)" }else{ $data.ITEM7 = $work.drop_item7	}; `
	if($work.drop_per8 -ne 0){ $data.ITEM8 = $work.drop_item8 + " ("+ 0.01* $work.drop_per8 +"%)" }else{ $data.ITEM8 = $work.drop_item8	}; `

# マップ名にモンスター名とドロップ率を追加
	$i = [array]::IndexOf($mob.ID, $work.ID); `
	if( $i -ne -1){
		$data.MAP = $mob[$i].MAP; `
	} `
	$newtable += $data;
}
}
#############################################################
# GUIで表示
#$newtable | select-object NAME,MAP, ITEM1, ITEM2, ITEM3, ITEM4, ITEM5, ITEM6, ITEM7, ITEM8 | Out-GridView -wait

$map_id,$map_name