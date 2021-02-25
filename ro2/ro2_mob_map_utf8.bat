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
#Measure-Command{ `

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
   switch($work.MAP){
      $map_id[0]{ $work.MAP = $map_name[0]; break }
      $map_id[1]{ $work.MAP = $map_name[1]; break }
      $map_id[2]{ $work.MAP = $map_name[2]; break }
      $map_id[3]{ $work.MAP = $map_name[3]; break }
      $map_id[4]{ $work.MAP = $map_name[4]; break }
      $map_id[5]{ $work.MAP = $map_name[5]; break }
      $map_id[6]{ $work.MAP = $map_name[6]; break }
      $map_id[7]{ $work.MAP = $map_name[7]; break }
      $map_id[8]{ $work.MAP = $map_name[8]; break }
      $map_id[9]{ $work.MAP = $map_name[9]; break }
      $map_id[10]{ $work.MAP = $map_name[10]; break }
      $map_id[11]{ $work.MAP = $map_name[11]; break }
      $map_id[12]{ $work.MAP = $map_name[12]; break }
      $map_id[13]{ $work.MAP = $map_name[13]; break }
      $map_id[14]{ $work.MAP = $map_name[14]; break }
      $map_id[15]{ $work.MAP = $map_name[15]; break }
      $map_id[16]{ $work.MAP = $map_name[16]; break }
      $map_id[17]{ $work.MAP = $map_name[17]; break }
      $map_id[18]{ $work.MAP = $map_name[18]; break }
      $map_id[19]{ $work.MAP = $map_name[19]; break }
      $map_id[20]{ $work.MAP = $map_name[20]; break }
      $map_id[21]{ $work.MAP = $map_name[21]; break }
      $map_id[22]{ $work.MAP = $map_name[22]; break }
      $map_id[23]{ $work.MAP = $map_name[23]; break }
      $map_id[24]{ $work.MAP = $map_name[24]; break }
      $map_id[25]{ $work.MAP = $map_name[25]; break }
      $map_id[26]{ $work.MAP = $map_name[26]; break }
      $map_id[27]{ $work.MAP = $map_name[27]; break }
      $map_id[28]{ $work.MAP = $map_name[28]; break }
      $map_id[29]{ $work.MAP = $map_name[29]; break }
      $map_id[30]{ $work.MAP = $map_name[30]; break }
      $map_id[31]{ $work.MAP = $map_name[31]; break }
      $map_id[32]{ $work.MAP = $map_name[32]; break }
      $map_id[33]{ $work.MAP = $map_name[33]; break }
      $map_id[34]{ $work.MAP = $map_name[34]; break }
      $map_id[35]{ $work.MAP = $map_name[35]; break }
      $map_id[36]{ $work.MAP = $map_name[36]; break }
      $map_id[37]{ $work.MAP = $map_name[37]; break }
      $map_id[38]{ $work.MAP = $map_name[38]; break }
      $map_id[39]{ $work.MAP = $map_name[39]; break }
      $map_id[40]{ $work.MAP = $map_name[40]; break }
      $map_id[41]{ $work.MAP = $map_name[41]; break }
      $map_id[42]{ $work.MAP = $map_name[42]; break }
      $map_id[43]{ $work.MAP = $map_name[43]; break }
      $map_id[44]{ $work.MAP = $map_name[44]; break }
      $map_id[45]{ $work.MAP = $map_name[45]; break }
      $map_id[46]{ $work.MAP = $map_name[46]; break }
      $map_id[47]{ $work.MAP = $map_name[47]; break }
      $map_id[48]{ $work.MAP = $map_name[48]; break }
      $map_id[49]{ $work.MAP = $map_name[49]; break }
      $map_id[50]{ $work.MAP = $map_name[50]; break }
      $map_id[51]{ $work.MAP = $map_name[51]; break }
      $map_id[52]{ $work.MAP = $map_name[52]; break }
      $map_id[53]{ $work.MAP = $map_name[53]; break }
      $map_id[54]{ $work.MAP = $map_name[54]; break }
      $map_id[55]{ $work.MAP = $map_name[55]; break }
      $map_id[56]{ $work.MAP = $map_name[56]; break }
      $map_id[57]{ $work.MAP = $map_name[57]; break }
      $map_id[58]{ $work.MAP = $map_name[58]; break }
      $map_id[59]{ $work.MAP = $map_name[59]; break }
      $map_id[60]{ $work.MAP = $map_name[60]; break }
      $map_id[61]{ $work.MAP = $map_name[61]; break }
      $map_id[62]{ $work.MAP = $map_name[62]; break }
      $map_id[63]{ $work.MAP = $map_name[63]; break }
      $map_id[64]{ $work.MAP = $map_name[64]; break }
      $map_id[65]{ $work.MAP = $map_name[65]; break }
      $map_id[66]{ $work.MAP = $map_name[66]; break }
      $map_id[67]{ $work.MAP = $map_name[67]; break }
      $map_id[68]{ $work.MAP = $map_name[68]; break }
      $map_id[69]{ $work.MAP = $map_name[69]; break }
      $map_id[70]{ $work.MAP = $map_name[70]; break }
      $map_id[71]{ $work.MAP = $map_name[71]; break }
      $map_id[72]{ $work.MAP = $map_name[72]; break }
      $map_id[73]{ $work.MAP = $map_name[73]; break }
      $map_id[74]{ $work.MAP = $map_name[74]; break }
      $map_id[75]{ $work.MAP = $map_name[75]; break }
      $map_id[76]{ $work.MAP = $map_name[76]; break }
      $map_id[77]{ $work.MAP = $map_name[77]; break }
      $map_id[78]{ $work.MAP = $map_name[78]; break }
      $map_id[79]{ $work.MAP = $map_name[79]; break }
      $map_id[80]{ $work.MAP = $map_name[80]; break }
      $map_id[81]{ $work.MAP = $map_name[81]; break }
      $map_id[82]{ $work.MAP = $map_name[82]; break }
      $map_id[83]{ $work.MAP = $map_name[83]; break }
      $map_id[84]{ $work.MAP = $map_name[84]; break }
      $map_id[85]{ $work.MAP = $map_name[85]; break }
      $map_id[86]{ $work.MAP = $map_name[86]; break }
      $map_id[87]{ $work.MAP = $map_name[87]; break }
      $map_id[88]{ $work.MAP = $map_name[88]; break }
      $map_id[89]{ $work.MAP = $map_name[89]; break }
      $map_id[90]{ $work.MAP = $map_name[90]; break }
      $map_id[91]{ $work.MAP = $map_name[91]; break }
      $map_id[92]{ $work.MAP = $map_name[92]; break }
      $map_id[93]{ $work.MAP = $map_name[93]; break }
      $map_id[94]{ $work.MAP = $map_name[94]; break }
      $map_id[95]{ $work.MAP = $map_name[95]; break }
      $map_id[96]{ $work.MAP = $map_name[96]; break }
      $map_id[97]{ $work.MAP = $map_name[97]; break }
      $map_id[98]{ $work.MAP = $map_name[98]; break }
      $map_id[99]{ $work.MAP = $map_name[99]; break }
      $map_id[100]{ $work.MAP = $map_name[100]; break }
      $map_id[101]{ $work.MAP = $map_name[101]; break }
      $map_id[102]{ $work.MAP = $map_name[102]; break }
      $map_id[103]{ $work.MAP = $map_name[103]; break }
      $map_id[104]{ $work.MAP = $map_name[104]; break }
      $map_id[105]{ $work.MAP = $map_name[105]; break }
      $map_id[106]{ $work.MAP = $map_name[106]; break }
      $map_id[107]{ $work.MAP = $map_name[107]; break }
      $map_id[108]{ $work.MAP = $map_name[108]; break }
      $map_id[109]{ $work.MAP = $map_name[109]; break }
      $map_id[110]{ $work.MAP = $map_name[110]; break }
      $map_id[111]{ $work.MAP = $map_name[111]; break }
      $map_id[112]{ $work.MAP = $map_name[112]; break }
      $map_id[113]{ $work.MAP = $map_name[113]; break }
      $map_id[114]{ $work.MAP = $map_name[114]; break }
      $map_id[115]{ $work.MAP = $map_name[115]; break }
      $map_id[116]{ $work.MAP = $map_name[116]; break }
      $map_id[117]{ $work.MAP = $map_name[117]; break }
      $map_id[118]{ $work.MAP = $map_name[118]; break }
      $map_id[119]{ $work.MAP = $map_name[119]; break }
      $map_id[120]{ $work.MAP = $map_name[120]; break }
      $map_id[121]{ $work.MAP = $map_name[121]; break }
      $map_id[122]{ $work.MAP = $map_name[122]; break }
      $map_id[123]{ $work.MAP = $map_name[123]; break }
      $map_id[124]{ $work.MAP = $map_name[124]; break }
      $map_id[125]{ $work.MAP = $map_name[125]; break }
      $map_id[126]{ $work.MAP = $map_name[126]; break }
      $map_id[127]{ $work.MAP = $map_name[127]; break }
      $map_id[128]{ $work.MAP = $map_name[128]; break }
      $map_id[129]{ $work.MAP = $map_name[129]; break }
      $map_id[130]{ $work.MAP = $map_name[130]; break }
      $map_id[131]{ $work.MAP = $map_name[131]; break }
      $map_id[132]{ $work.MAP = $map_name[132]; break }
      $map_id[133]{ $work.MAP = $map_name[133]; break }
      $map_id[134]{ $work.MAP = $map_name[134]; break }
      $map_id[135]{ $work.MAP = $map_name[135]; break }
      $map_id[136]{ $work.MAP = $map_name[136]; break }
      $map_id[137]{ $work.MAP = $map_name[137]; break }
      $map_id[138]{ $work.MAP = $map_name[138]; break }
      $map_id[139]{ $work.MAP = $map_name[139]; break }
      $map_id[140]{ $work.MAP = $map_name[140]; break }
      $map_id[141]{ $work.MAP = $map_name[141]; break }
      $map_id[142]{ $work.MAP = $map_name[142]; break }
      $map_id[143]{ $work.MAP = $map_name[143]; break }
      $map_id[144]{ $work.MAP = $map_name[144]; break }
      $map_id[145]{ $work.MAP = $map_name[145]; break }
      $map_id[146]{ $work.MAP = $map_name[146]; break }
      $map_id[147]{ $work.MAP = $map_name[147]; break }
      $map_id[148]{ $work.MAP = $map_name[148]; break }
      $map_id[149]{ $work.MAP = $map_name[149]; break }
      $map_id[150]{ $work.MAP = $map_name[150]; break }
      $map_id[151]{ $work.MAP = $map_name[151]; break }
      $map_id[152]{ $work.MAP = $map_name[152]; break }
      $map_id[153]{ $work.MAP = $map_name[153]; break }
      $map_id[154]{ $work.MAP = $map_name[154]; break }
      $map_id[155]{ $work.MAP = $map_name[155]; break }
      $map_id[156]{ $work.MAP = $map_name[156]; break }
      $map_id[157]{ $work.MAP = $map_name[157]; break }
      $map_id[158]{ $work.MAP = $map_name[158]; break }
      $map_id[159]{ $work.MAP = $map_name[159]; break }
      $map_id[160]{ $work.MAP = $map_name[160]; break }
      $map_id[161]{ $work.MAP = $map_name[161]; break }
      $map_id[162]{ $work.MAP = $map_name[162]; break }
      $map_id[163]{ $work.MAP = $map_name[163]; break }
      $map_id[164]{ $work.MAP = $map_name[164]; break }
      $map_id[165]{ $work.MAP = $map_name[165]; break }
      $map_id[166]{ $work.MAP = $map_name[166]; break }
      $map_id[167]{ $work.MAP = $map_name[167]; break }
      $map_id[168]{ $work.MAP = $map_name[168]; break }
      $map_id[169]{ $work.MAP = $map_name[169]; break }
      $map_id[170]{ $work.MAP = $map_name[170]; break }
      $map_id[171]{ $work.MAP = $map_name[171]; break }
      $map_id[172]{ $work.MAP = $map_name[172]; break }
      $map_id[173]{ $work.MAP = $map_name[173]; break }
      $map_id[174]{ $work.MAP = $map_name[174]; break }
      $map_id[175]{ $work.MAP = $map_name[175]; break }
      $map_id[176]{ $work.MAP = $map_name[176]; break }
      $map_id[177]{ $work.MAP = $map_name[177]; break }
      $map_id[178]{ $work.MAP = $map_name[178]; break }
      $map_id[179]{ $work.MAP = $map_name[179]; break }
      $map_id[180]{ $work.MAP = $map_name[180]; break }
      $map_id[181]{ $work.MAP = $map_name[181]; break }
      $map_id[182]{ $work.MAP = $map_name[182]; break }
      $map_id[183]{ $work.MAP = $map_name[183]; break }
      $map_id[184]{ $work.MAP = $map_name[184]; break }
      $map_id[185]{ $work.MAP = $map_name[185]; break }
      $map_id[186]{ $work.MAP = $map_name[186]; break }
      $map_id[187]{ $work.MAP = $map_name[187]; break }
      $map_id[188]{ $work.MAP = $map_name[188]; break }
      $map_id[189]{ $work.MAP = $map_name[189]; break }
      $map_id[190]{ $work.MAP = $map_name[190]; break }
      $map_id[191]{ $work.MAP = $map_name[191]; break }
      $map_id[192]{ $work.MAP = $map_name[192]; break }
      $map_id[193]{ $work.MAP = $map_name[193]; break }
      $map_id[194]{ $work.MAP = $map_name[194]; break }
      $map_id[195]{ $work.MAP = $map_name[195]; break }
      $map_id[196]{ $work.MAP = $map_name[196]; break }
      $map_id[197]{ $work.MAP = $map_name[197]; break }
      $map_id[198]{ $work.MAP = $map_name[198]; break }
      $map_id[199]{ $work.MAP = $map_name[199]; break }
      $map_id[200]{ $work.MAP = $map_name[200]; break }
      $map_id[201]{ $work.MAP = $map_name[201]; break }
      $map_id[202]{ $work.MAP = $map_name[202]; break }
      $map_id[203]{ $work.MAP = $map_name[203]; break }
      $map_id[204]{ $work.MAP = $map_name[204]; break }
      $map_id[205]{ $work.MAP = $map_name[205]; break }
      $map_id[206]{ $work.MAP = $map_name[206]; break }
      $map_id[207]{ $work.MAP = $map_name[207]; break }
      $map_id[208]{ $work.MAP = $map_name[208]; break }
      $map_id[209]{ $work.MAP = $map_name[209]; break }
      $map_id[210]{ $work.MAP = $map_name[210]; break }
      $map_id[211]{ $work.MAP = $map_name[211]; break }
      $map_id[212]{ $work.MAP = $map_name[212]; break }
      $map_id[213]{ $work.MAP = $map_name[213]; break }
      $map_id[214]{ $work.MAP = $map_name[214]; break }
      $map_id[215]{ $work.MAP = $map_name[215]; break }
      $map_id[216]{ $work.MAP = $map_name[216]; break }
      $map_id[217]{ $work.MAP = $map_name[217]; break }
      $map_id[218]{ $work.MAP = $map_name[218]; break }
      $map_id[219]{ $work.MAP = $map_name[219]; break }
      $map_id[220]{ $work.MAP = $map_name[220]; break }
      $map_id[221]{ $work.MAP = $map_name[221]; break }
      $map_id[222]{ $work.MAP = $map_name[222]; break }
      $map_id[223]{ $work.MAP = $map_name[223]; break }
      $map_id[224]{ $work.MAP = $map_name[224]; break }
      $map_id[225]{ $work.MAP = $map_name[225]; break }
      $map_id[226]{ $work.MAP = $map_name[226]; break }
      $map_id[227]{ $work.MAP = $map_name[227]; break }
      $map_id[228]{ $work.MAP = $map_name[228]; break }
      $map_id[229]{ $work.MAP = $map_name[229]; break }
      $map_id[230]{ $work.MAP = $map_name[230]; break }
      $map_id[231]{ $work.MAP = $map_name[231]; break }
      $map_id[232]{ $work.MAP = $map_name[232]; break }
      $map_id[233]{ $work.MAP = $map_name[233]; break }
      $map_id[234]{ $work.MAP = $map_name[234]; break }
      $map_id[235]{ $work.MAP = $map_name[235]; break }
      $map_id[236]{ $work.MAP = $map_name[236]; break }
      $map_id[237]{ $work.MAP = $map_name[237]; break }
      $map_id[238]{ $work.MAP = $map_name[238]; break }
      $map_id[239]{ $work.MAP = $map_name[239]; break }
      $map_id[240]{ $work.MAP = $map_name[240]; break }
      $map_id[241]{ $work.MAP = $map_name[241]; break }
      $map_id[242]{ $work.MAP = $map_name[242]; break }
      $map_id[243]{ $work.MAP = $map_name[243]; break }
      $map_id[244]{ $work.MAP = $map_name[244]; break }
      $map_id[245]{ $work.MAP = $map_name[245]; break }
      $map_id[246]{ $work.MAP = $map_name[246]; break }
      $map_id[247]{ $work.MAP = $map_name[247]; break }
      $map_id[248]{ $work.MAP = $map_name[248]; break }
      $map_id[249]{ $work.MAP = $map_name[249]; break }
      $map_id[250]{ $work.MAP = $map_name[250]; break }
      $map_id[251]{ $work.MAP = $map_name[251]; break }
      $map_id[252]{ $work.MAP = $map_name[252]; break }
      $map_id[253]{ $work.MAP = $map_name[253]; break }
      $map_id[254]{ $work.MAP = $map_name[254]; break }
      $map_id[255]{ $work.MAP = $map_name[255]; break }
      $map_id[256]{ $work.MAP = $map_name[256]; break }
      $map_id[257]{ $work.MAP = $map_name[257]; break }
      $map_id[258]{ $work.MAP = $map_name[258]; break }
      $map_id[259]{ $work.MAP = $map_name[259]; break }
      $map_id[260]{ $work.MAP = $map_name[260]; break }
      $map_id[261]{ $work.MAP = $map_name[261]; break }
      $map_id[262]{ $work.MAP = $map_name[262]; break }
      $map_id[263]{ $work.MAP = $map_name[263]; break }
      $map_id[264]{ $work.MAP = $map_name[264]; break }
      $map_id[265]{ $work.MAP = $map_name[265]; break }
      $map_id[266]{ $work.MAP = $map_name[266]; break }
      $map_id[267]{ $work.MAP = $map_name[267]; break }
      $map_id[268]{ $work.MAP = $map_name[268]; break }
      $map_id[269]{ $work.MAP = $map_name[269]; break }
      $map_id[270]{ $work.MAP = $map_name[270]; break }
      $map_id[271]{ $work.MAP = $map_name[271]; break }
      $map_id[272]{ $work.MAP = $map_name[272]; break }
      $map_id[273]{ $work.MAP = $map_name[273]; break }
      $map_id[274]{ $work.MAP = $map_name[274]; break }
      $map_id[275]{ $work.MAP = $map_name[275]; break }
      $map_id[276]{ $work.MAP = $map_name[276]; break }
      $map_id[277]{ $work.MAP = $map_name[277]; break }
      $map_id[278]{ $work.MAP = $map_name[278]; break }
      $map_id[279]{ $work.MAP = $map_name[279]; break }
      $map_id[280]{ $work.MAP = $map_name[280]; break }
      $map_id[281]{ $work.MAP = $map_name[281]; break }
      $map_id[282]{ $work.MAP = $map_name[282]; break }
      $map_id[283]{ $work.MAP = $map_name[283]; break }
      $map_id[284]{ $work.MAP = $map_name[284]; break }
      $map_id[285]{ $work.MAP = $map_name[285]; break }
      $map_id[286]{ $work.MAP = $map_name[286]; break }
      $map_id[287]{ $work.MAP = $map_name[287]; break }
      $map_id[288]{ $work.MAP = $map_name[288]; break }
      $map_id[289]{ $work.MAP = $map_name[289]; break }
      $map_id[290]{ $work.MAP = $map_name[290]; break }
      $map_id[291]{ $work.MAP = $map_name[291]; break }
      $map_id[292]{ $work.MAP = $map_name[292]; break }
      $map_id[293]{ $work.MAP = $map_name[293]; break }
      $map_id[294]{ $work.MAP = $map_name[294]; break }
      $map_id[295]{ $work.MAP = $map_name[295]; break }
      $map_id[296]{ $work.MAP = $map_name[296]; break }
      $map_id[297]{ $work.MAP = $map_name[297]; break }
      $map_id[298]{ $work.MAP = $map_name[298]; break }
      $map_id[299]{ $work.MAP = $map_name[299]; break }
      $map_id[300]{ $work.MAP = $map_name[300]; break }
      $map_id[301]{ $work.MAP = $map_name[301]; break }
      $map_id[302]{ $work.MAP = $map_name[302]; break }
      $map_id[303]{ $work.MAP = $map_name[303]; break }
      $map_id[304]{ $work.MAP = $map_name[304]; break }
      $map_id[305]{ $work.MAP = $map_name[305]; break }
      $map_id[306]{ $work.MAP = $map_name[306]; break }
      $map_id[307]{ $work.MAP = $map_name[307]; break }
      $map_id[308]{ $work.MAP = $map_name[308]; break }
      $map_id[309]{ $work.MAP = $map_name[309]; break }
      $map_id[310]{ $work.MAP = $map_name[310]; break }
      $map_id[311]{ $work.MAP = $map_name[311]; break }
      $map_id[312]{ $work.MAP = $map_name[312]; break }
      $map_id[313]{ $work.MAP = $map_name[313]; break }
      $map_id[314]{ $work.MAP = $map_name[314]; break }
      $map_id[315]{ $work.MAP = $map_name[315]; break }
      $map_id[316]{ $work.MAP = $map_name[316]; break }
      $map_id[317]{ $work.MAP = $map_name[317]; break }
      $map_id[318]{ $work.MAP = $map_name[318]; break }
      $map_id[319]{ $work.MAP = $map_name[319]; break }
      $map_id[320]{ $work.MAP = $map_name[320]; break }
      $map_id[321]{ $work.MAP = $map_name[321]; break }
      $map_id[322]{ $work.MAP = $map_name[322]; break }
      $map_id[323]{ $work.MAP = $map_name[323]; break }
      $map_id[324]{ $work.MAP = $map_name[324]; break }
      $map_id[325]{ $work.MAP = $map_name[325]; break }
      $map_id[326]{ $work.MAP = $map_name[326]; break }
      $map_id[327]{ $work.MAP = $map_name[327]; break }
      $map_id[328]{ $work.MAP = $map_name[328]; break }
      $map_id[329]{ $work.MAP = $map_name[329]; break }
      $map_id[330]{ $work.MAP = $map_name[330]; break }
      $map_id[331]{ $work.MAP = $map_name[331]; break }
      $map_id[332]{ $work.MAP = $map_name[332]; break }
      $map_id[333]{ $work.MAP = $map_name[333]; break }
      $map_id[334]{ $work.MAP = $map_name[334]; break }
      $map_id[335]{ $work.MAP = $map_name[335]; break }
      $map_id[336]{ $work.MAP = $map_name[336]; break }
      $map_id[337]{ $work.MAP = $map_name[337]; break }
      $map_id[338]{ $work.MAP = $map_name[338]; break }
      $map_id[339]{ $work.MAP = $map_name[339]; break }
      $map_id[340]{ $work.MAP = $map_name[340]; break }
      $map_id[341]{ $work.MAP = $map_name[341]; break }
      $map_id[342]{ $work.MAP = $map_name[342]; break }
      $map_id[343]{ $work.MAP = $map_name[343]; break }
      $map_id[344]{ $work.MAP = $map_name[344]; break }
      $map_id[345]{ $work.MAP = $map_name[345]; break }
      $map_id[346]{ $work.MAP = $map_name[346]; break }
      $map_id[347]{ $work.MAP = $map_name[347]; break }
      $map_id[348]{ $work.MAP = $map_name[348]; break }
      $map_id[349]{ $work.MAP = $map_name[349]; break }
      $map_id[350]{ $work.MAP = $map_name[350]; break }
      $map_id[351]{ $work.MAP = $map_name[351]; break }
      $map_id[352]{ $work.MAP = $map_name[352]; break }
      $map_id[353]{ $work.MAP = $map_name[353]; break }
      $map_id[354]{ $work.MAP = $map_name[354]; break }
      $map_id[355]{ $work.MAP = $map_name[355]; break }
      $map_id[356]{ $work.MAP = $map_name[356]; break }
      $map_id[357]{ $work.MAP = $map_name[357]; break }
      $map_id[358]{ $work.MAP = $map_name[358]; break }
      $map_id[359]{ $work.MAP = $map_name[359]; break }
      $map_id[360]{ $work.MAP = $map_name[360]; break }
      $map_id[361]{ $work.MAP = $map_name[361]; break }
      $map_id[362]{ $work.MAP = $map_name[362]; break }
      $map_id[363]{ $work.MAP = $map_name[363]; break }
      $map_id[364]{ $work.MAP = $map_name[364]; break }
      $map_id[365]{ $work.MAP = $map_name[365]; break }
      $map_id[366]{ $work.MAP = $map_name[366]; break }
      $map_id[367]{ $work.MAP = $map_name[367]; break }
      $map_id[368]{ $work.MAP = $map_name[368]; break }
      $map_id[369]{ $work.MAP = $map_name[369]; break }
      $map_id[370]{ $work.MAP = $map_name[370]; break }
      $map_id[371]{ $work.MAP = $map_name[371]; break }
      $map_id[372]{ $work.MAP = $map_name[372]; break }
      $map_id[373]{ $work.MAP = $map_name[373]; break }
      $map_id[374]{ $work.MAP = $map_name[374]; break }
      $map_id[375]{ $work.MAP = $map_name[375]; break }
      $map_id[376]{ $work.MAP = $map_name[376]; break }
      $map_id[377]{ $work.MAP = $map_name[377]; break }
      $map_id[378]{ $work.MAP = $map_name[378]; break }
      $map_id[379]{ $work.MAP = $map_name[379]; break }
      $map_id[380]{ $work.MAP = $map_name[380]; break }
      $map_id[381]{ $work.MAP = $map_name[381]; break }
      $map_id[382]{ $work.MAP = $map_name[382]; break }
      $map_id[383]{ $work.MAP = $map_name[383]; break }
      $map_id[384]{ $work.MAP = $map_name[384]; break }
      $map_id[385]{ $work.MAP = $map_name[385]; break }
      $map_id[386]{ $work.MAP = $map_name[386]; break }
      $map_id[387]{ $work.MAP = $map_name[387]; break }
      $map_id[388]{ $work.MAP = $map_name[388]; break }
      $map_id[389]{ $work.MAP = $map_name[389]; break }
      $map_id[390]{ $work.MAP = $map_name[390]; break }
      $map_id[391]{ $work.MAP = $map_name[391]; break }
      $map_id[392]{ $work.MAP = $map_name[392]; break }
      $map_id[393]{ $work.MAP = $map_name[393]; break }
      $map_id[394]{ $work.MAP = $map_name[394]; break }
      $map_id[395]{ $work.MAP = $map_name[395]; break }
      $map_id[396]{ $work.MAP = $map_name[396]; break }
      $map_id[397]{ $work.MAP = $map_name[397]; break }
      $map_id[398]{ $work.MAP = $map_name[398]; break }
      $map_id[399]{ $work.MAP = $map_name[399]; break }
      $map_id[400]{ $work.MAP = $map_name[400]; break }
      $map_id[401]{ $work.MAP = $map_name[401]; break }
      $map_id[402]{ $work.MAP = $map_name[402]; break }
      $map_id[403]{ $work.MAP = $map_name[403]; break }
      $map_id[404]{ $work.MAP = $map_name[404]; break }
      $map_id[405]{ $work.MAP = $map_name[405]; break }
      $map_id[406]{ $work.MAP = $map_name[406]; break }
      $map_id[407]{ $work.MAP = $map_name[407]; break }
      $map_id[408]{ $work.MAP = $map_name[408]; break }
      $map_id[409]{ $work.MAP = $map_name[409]; break }
      $map_id[410]{ $work.MAP = $map_name[410]; break }
      $map_id[411]{ $work.MAP = $map_name[411]; break }
      $map_id[412]{ $work.MAP = $map_name[412]; break }
      $map_id[413]{ $work.MAP = $map_name[413]; break }
      $map_id[414]{ $work.MAP = $map_name[414]; break }
      $map_id[415]{ $work.MAP = $map_name[415]; break }
      $map_id[416]{ $work.MAP = $map_name[416]; break }
      $map_id[417]{ $work.MAP = $map_name[417]; break }
      $map_id[418]{ $work.MAP = $map_name[418]; break }
      $map_id[419]{ $work.MAP = $map_name[419]; break }
      $map_id[420]{ $work.MAP = $map_name[420]; break }
      $map_id[421]{ $work.MAP = $map_name[421]; break }
      $map_id[422]{ $work.MAP = $map_name[422]; break }
      $map_id[423]{ $work.MAP = $map_name[423]; break }
      $map_id[424]{ $work.MAP = $map_name[424]; break }
      $map_id[425]{ $work.MAP = $map_name[425]; break }
      $map_id[426]{ $work.MAP = $map_name[426]; break }
      $map_id[427]{ $work.MAP = $map_name[427]; break }
      $map_id[428]{ $work.MAP = $map_name[428]; break }
      $map_id[429]{ $work.MAP = $map_name[429]; break }
      $map_id[430]{ $work.MAP = $map_name[430]; break }
      $map_id[431]{ $work.MAP = $map_name[431]; break }
      $map_id[432]{ $work.MAP = $map_name[432]; break }
      $map_id[433]{ $work.MAP = $map_name[433]; break }
      $map_id[434]{ $work.MAP = $map_name[434]; break }
      $map_id[435]{ $work.MAP = $map_name[435]; break }
      $map_id[436]{ $work.MAP = $map_name[436]; break }
      $map_id[437]{ $work.MAP = $map_name[437]; break }
      $map_id[438]{ $work.MAP = $map_name[438]; break }
      $map_id[439]{ $work.MAP = $map_name[439]; break }
      $map_id[440]{ $work.MAP = $map_name[440]; break }
      $map_id[441]{ $work.MAP = $map_name[441]; break }
      $map_id[442]{ $work.MAP = $map_name[442]; break }
      $map_id[443]{ $work.MAP = $map_name[443]; break }
      $map_id[444]{ $work.MAP = $map_name[444]; break }
      $map_id[445]{ $work.MAP = $map_name[445]; break }
      $map_id[446]{ $work.MAP = $map_name[446]; break }
      $map_id[447]{ $work.MAP = $map_name[447]; break }
      $map_id[448]{ $work.MAP = $map_name[448]; break }
      $map_id[449]{ $work.MAP = $map_name[449]; break }
      $map_id[450]{ $work.MAP = $map_name[450]; break }
      $map_id[451]{ $work.MAP = $map_name[451]; break }
      $map_id[452]{ $work.MAP = $map_name[452]; break }
      $map_id[453]{ $work.MAP = $map_name[453]; break }
      $map_id[454]{ $work.MAP = $map_name[454]; break }
      $map_id[455]{ $work.MAP = $map_name[455]; break }
      $map_id[456]{ $work.MAP = $map_name[456]; break }
      $map_id[457]{ $work.MAP = $map_name[457]; break }
      $map_id[458]{ $work.MAP = $map_name[458]; break }
      $map_id[459]{ $work.MAP = $map_name[459]; break }
      $map_id[460]{ $work.MAP = $map_name[460]; break }
      $map_id[461]{ $work.MAP = $map_name[461]; break }
      $map_id[462]{ $work.MAP = $map_name[462]; break }
      $map_id[463]{ $work.MAP = $map_name[463]; break }
      $map_id[464]{ $work.MAP = $map_name[464]; break }
      $map_id[465]{ $work.MAP = $map_name[465]; break }
      $map_id[466]{ $work.MAP = $map_name[466]; break }
      $map_id[467]{ $work.MAP = $map_name[467]; break }
      $map_id[468]{ $work.MAP = $map_name[468]; break }
      $map_id[469]{ $work.MAP = $map_name[469]; break }
      $map_id[470]{ $work.MAP = $map_name[470]; break }
      $map_id[471]{ $work.MAP = $map_name[471]; break }
      $map_id[472]{ $work.MAP = $map_name[472]; break }
      $map_id[473]{ $work.MAP = $map_name[473]; break }
      $map_id[474]{ $work.MAP = $map_name[474]; break }
      $map_id[475]{ $work.MAP = $map_name[475]; break }
      $map_id[476]{ $work.MAP = $map_name[476]; break }
      $map_id[477]{ $work.MAP = $map_name[477]; break }
      $map_id[478]{ $work.MAP = $map_name[478]; break }
      $map_id[479]{ $work.MAP = $map_name[479]; break }
      $map_id[480]{ $work.MAP = $map_name[480]; break }
      $map_id[481]{ $work.MAP = $map_name[481]; break }
      $map_id[482]{ $work.MAP = $map_name[482]; break }
      $map_id[483]{ $work.MAP = $map_name[483]; break }
      $map_id[484]{ $work.MAP = $map_name[484]; break }
      $map_id[485]{ $work.MAP = $map_name[485]; break }
      $map_id[486]{ $work.MAP = $map_name[486]; break }
      $map_id[487]{ $work.MAP = $map_name[487]; break }
      $map_id[488]{ $work.MAP = $map_name[488]; break }
      $map_id[489]{ $work.MAP = $map_name[489]; break }
      $map_id[490]{ $work.MAP = $map_name[490]; break }
      $map_id[491]{ $work.MAP = $map_name[491]; break }
      $map_id[492]{ $work.MAP = $map_name[492]; break }
      $map_id[493]{ $work.MAP = $map_name[493]; break }
      $map_id[494]{ $work.MAP = $map_name[494]; break }
      $map_id[495]{ $work.MAP = $map_name[495]; break }
      $map_id[496]{ $work.MAP = $map_name[496]; break }
      $map_id[497]{ $work.MAP = $map_name[497]; break }
      $map_id[498]{ $work.MAP = $map_name[498]; break }
      $map_id[499]{ $work.MAP = $map_name[499]; break }
      $map_id[500]{ $work.MAP = $map_name[500]; break }
      $map_id[501]{ $work.MAP = $map_name[501]; break }
      $map_id[502]{ $work.MAP = $map_name[502]; break }
      $map_id[503]{ $work.MAP = $map_name[503]; break }
      $map_id[504]{ $work.MAP = $map_name[504]; break }
      $map_id[505]{ $work.MAP = $map_name[505]; break }
      $map_id[506]{ $work.MAP = $map_name[506]; break }
      $map_id[507]{ $work.MAP = $map_name[507]; break }
      $map_id[508]{ $work.MAP = $map_name[508]; break }
      $map_id[509]{ $work.MAP = $map_name[509]; break }
      $map_id[510]{ $work.MAP = $map_name[510]; break }
      $map_id[511]{ $work.MAP = $map_name[511]; break }
      $map_id[512]{ $work.MAP = $map_name[512]; break }
      $map_id[513]{ $work.MAP = $map_name[513]; break }
      $map_id[514]{ $work.MAP = $map_name[514]; break }
      $map_id[515]{ $work.MAP = $map_name[515]; break }
      $map_id[516]{ $work.MAP = $map_name[516]; break }
      $map_id[517]{ $work.MAP = $map_name[517]; break }
      $map_id[518]{ $work.MAP = $map_name[518]; break }
      $map_id[519]{ $work.MAP = $map_name[519]; break }
      $map_id[520]{ $work.MAP = $map_name[520]; break }
      $map_id[521]{ $work.MAP = $map_name[521]; break }
      $map_id[522]{ $work.MAP = $map_name[522]; break }
      $map_id[523]{ $work.MAP = $map_name[523]; break }
      $map_id[524]{ $work.MAP = $map_name[524]; break }
      $map_id[525]{ $work.MAP = $map_name[525]; break }
      $map_id[526]{ $work.MAP = $map_name[526]; break }
      $map_id[527]{ $work.MAP = $map_name[527]; break }
      $map_id[528]{ $work.MAP = $map_name[528]; break }
      $map_id[529]{ $work.MAP = $map_name[529]; break }
      $map_id[530]{ $work.MAP = $map_name[530]; break }
      $map_id[531]{ $work.MAP = $map_name[531]; break }
      $map_id[532]{ $work.MAP = $map_name[532]; break }
      $map_id[533]{ $work.MAP = $map_name[533]; break }
      $map_id[534]{ $work.MAP = $map_name[534]; break }
      $map_id[535]{ $work.MAP = $map_name[535]; break }
      $map_id[536]{ $work.MAP = $map_name[536]; break }
      $map_id[537]{ $work.MAP = $map_name[537]; break }
      $map_id[538]{ $work.MAP = $map_name[538]; break }
      $map_id[539]{ $work.MAP = $map_name[539]; break }
      $map_id[540]{ $work.MAP = $map_name[540]; break }
      $map_id[541]{ $work.MAP = $map_name[541]; break }
      $map_id[542]{ $work.MAP = $map_name[542]; break }
      $map_id[543]{ $work.MAP = $map_name[543]; break }
      $map_id[544]{ $work.MAP = $map_name[544]; break }
      $map_id[545]{ $work.MAP = $map_name[545]; break }
      $map_id[546]{ $work.MAP = $map_name[546]; break }
      $map_id[547]{ $work.MAP = $map_name[547]; break }
      $map_id[548]{ $work.MAP = $map_name[548]; break }
      $map_id[549]{ $work.MAP = $map_name[549]; break }
      $map_id[550]{ $work.MAP = $map_name[550]; break }
      $map_id[551]{ $work.MAP = $map_name[551]; break }
      $map_id[552]{ $work.MAP = $map_name[552]; break }
      $map_id[553]{ $work.MAP = $map_name[553]; break }
      $map_id[554]{ $work.MAP = $map_name[554]; break }
      $map_id[555]{ $work.MAP = $map_name[555]; break }
      $map_id[556]{ $work.MAP = $map_name[556]; break }
      $map_id[557]{ $work.MAP = $map_name[557]; break }
      $map_id[558]{ $work.MAP = $map_name[558]; break }
      $map_id[559]{ $work.MAP = $map_name[559]; break }
      $map_id[560]{ $work.MAP = $map_name[560]; break }
      $map_id[561]{ $work.MAP = $map_name[561]; break }
      default { break; }
   }
} `
#}
#############################################################
# GUIで表示
$ro2 | select-object "NAME","count","time","random","MAP","subMAP" | Out-GridView -wait
