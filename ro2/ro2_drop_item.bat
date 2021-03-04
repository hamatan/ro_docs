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
Add-Type -Assembly System.Windows.Forms
$csvfile1 = "./db/01_monster_drop_item.csv"
$csvfile2 = "./db/03_monster_map.csv"
$csvfile3 = "./db/06_map_portal.csv"
$csvfile99= "./db/99_newtable.csv"

# マージした新テーブルが有る場合
if( Test-Path $csvfile99 ) {
   $newtable = import-csv $csvfile99 -Encoding UTF8 -Header "ID", "MAPid","MAP", "subMAP", "NAME", "COUNT", "ITEM1", "ITEM2", "ITEM3", "ITEM4", "ITEM5", "ITEM6", "ITEM7", "ITEM8"

   # 生息数 降順でソートする場合
   $newtable = $newtable | sort-object {[int]$_.COUNT} , NAME -Descending

 #  foreach( $work in $newtable ){
      # ETと夢幻はサブマップ参照
      # UTF8だと日本語が化けてどうしようもない
      # if( $work.MAPid -like "*@tower*" ){ 
      #   $work.MAP = "エンドレスタワー " + $work.subMAP;
      # }
      # elseif( $work.MAPid -like "*@la*" ){
      #   $work.MAP = "試練の迷宮 " + $work.subMAP;
      # }
      # elseif( $work.MAPid -like "*@lb*" ){
      #   $work.MAP = "封印の迷宮 " + $work.subMAP;
      # }
      # elseif( $work.MAPid -like "*@lc*" ){
      #   $work.MAP = "異形の迷宮 " + $work.subMAP;
      # }
#   }

   # GUI で表示
   $newtable | select-object "MAP", "NAME", "COUNT", "ITEM1", "ITEM2", "ITEM3", "ITEM4", "ITEM5", "ITEM6", "ITEM7", "ITEM8" | Out-GridView -wait
}
else{
#############################################################
# マージした新テーブルが無い場合作成する

   # csvファイルを開く
   if( Test-Path $csvfile1 ) {
      $ro2 = import-csv $csvfile1 -Encoding UTF8 -Header "ID","NAME","item1","drop1","item2","drop2","item3","drop3","item4","drop4","item5","drop5","item6","drop6","item7","drop7","item8","drop8" | Select-Object -Skip 1
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
      $map = import-csv $csvfile3 -Encoding UTF8 -Header "MAP","MAP_NAME","KANA","city","portal","map_in","dun_in","Fld_Dun_MD","delete","BGM","BGM_title","country","area","pass","quest","party","zeny","time_limit","CT","re_Try","notes","short_NAME","sNAME_KANA" | Select-Object -Skip 1
   }
   else{
      [System.Windows.Forms.MessageBox]::Show('cant open csv file','error')
      exit
   }

   #############################################################
   # マップ名を抽出
   #Measure-Command{ `

   foreach( $work in $mob ){  `
      $i = [array]::IndexOf($map.MAP, $work.MAP); `
      if( $i -ne -1){         
         # $work.MAP = $map[$i].MAP_NAME;
         $work.MAP = $work.MAP + "," + $map[$i].MAP_NAME;
      }
      else{
         $work.MAP = $work.MAP + ",";
      }
   }
   #}
   #############################################################
   #Measure-Command{ `
   $newtable = New-Object 'System.Collections.Generic.List[System.String]';
   foreach($work in $mob){ `

   # 06_monster_drop_item.csv と 03_monster_map.csv の一致するIDを検索
      $i = [array]::IndexOf( $ro2.ID, $work.ID ); `
      if( $i -ne -1){

   # アイテム名にドロップ率を追加
         if($ro2[$i].drop1 -ne 0){ $item1 = $ro2[$i].item1 + " ("+ 0.01* $ro2[$i].drop1 +"%)" }else{ $item1 = $ro2[$i].item1 }; `
         if($ro2[$i].drop2 -ne 0){ $item2 = $ro2[$i].item2 + " ("+ 0.01* $ro2[$i].drop2 +"%)" }else{ $item2 = $ro2[$i].item2 }; `
         if($ro2[$i].drop3 -ne 0){ $item3 = $ro2[$i].item3 + " ("+ 0.01* $ro2[$i].drop3 +"%)" }else{ $item3 = $ro2[$i].item3 }; `
         if($ro2[$i].drop4 -ne 0){ $item4 = $ro2[$i].item4 + " ("+ 0.01* $ro2[$i].drop4 +"%)" }else{ $item4 = $ro2[$i].item4 }; `
         if($ro2[$i].drop5 -ne 0){ $item5 = $ro2[$i].item5 + " ("+ 0.01* $ro2[$i].drop5 +"%)" }else{ $item5 = $ro2[$i].item5 }; `
         if($ro2[$i].drop6 -ne 0){ $item6 = $ro2[$i].item6 + " ("+ 0.01* $ro2[$i].drop6 +"%)" }else{ $item6 = $ro2[$i].item6 }; `
         if($ro2[$i].drop7 -ne 0){ $item7 = $ro2[$i].item7 + " ("+ 0.01* $ro2[$i].drop7 +"%)" }else{ $item7 = $ro2[$i].item7 }; `
         if($ro2[$i].drop8 -ne 0){ $item8 = $ro2[$i].item8 + " ("+ 0.01* $ro2[$i].drop8 +"%)" }else{ $item8 = $ro2[$i].item8 }; `

   # マップ名にモンスター数を追加
   #		if( ($work.count -eq 0) -or ($work.count -eq "?") -or ($work.count -eq "") ){ 
   #			$mobmap = $work.MAP
   #		}
   #		else{
   #			$mobmap =  $work.MAP + "[" + $work.count + "]"
   #		}
 
   # 新しいテーブルに項目を追加
         $newtable.add( $work.ID + "," + $work.MAP  + "," + $work.subMAP + "," + $work.NAME + "," + $work.count + "," + $item1 + "," + $item2 + "," + $item3 + "," + $item4 + "," + $item5 + "," + $item6 + "," + $item7 + "," + $item8  );
      } `
   }
   #}

   # csv に変換
   $newtable = $newtable | ConvertFrom-Csv -Header "ID", "MAPid", "MAP", "subMAP", "NAME", "COUNT", "ITEM1", "ITEM2", "ITEM3", "ITEM4", "ITEM5", "ITEM6", "ITEM7", "ITEM8"
   
   # マップ順でソートする場合
   # $newtable = $newtable | sort-object MAPid,NAME

   # ファイルに出力
   $newtable | Export-Csv  -Encoding UTF8 -NoTypeInformation -Force -Path $csvfile99
 
   #############################################################
   # GUIで表示
   $newtable | select-object "MAP", "NAME", "COUNT", "ITEM1", "ITEM2", "ITEM3", "ITEM4", "ITEM5", "ITEM6", "ITEM7", "ITEM8" | Out-GridView -wait
}
