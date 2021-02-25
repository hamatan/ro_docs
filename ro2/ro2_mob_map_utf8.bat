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
Measure-Command{ `

#$maplist = @();
$map_id  = @();
$map_name= @();

foreach( $temp in $map ){ `
#   $work      = New-Object PSObject | Select-Object ID, NAME; `
#   $work.ID   = $temp.ID; `
#   $work.NAME = $temp.MAP_NAME; `
#   $maplist  += $work; `
   $map_id   += $temp.ID;
   $map_name += $temp.MAP_NAME;
}

## 地獄のようなifブロック生成1 (文字列にしたらutf-8で文字化けしてダメだった、ANSIなら最速 0.8sec)
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
# 地獄のようなifブロック生成3 (1.4sec)
#$i=0;
#foreach( $temp in $maplist ){ `
#   "   elseif( `$work.MAP -eq `$map_id[{0}] ) {{ `$work.MAP = `$map_name[{0}] }}" -f $i >> cachemap.txt; `
#   $i++;  `
#}

# 地獄のようなifブロック
foreach( $work in $ro2 ){  `
       if( $work.MAP -eq $map_id[0] ) { $work.MAP = $map_name[0] }
   elseif( $work.MAP -eq $map_id[1] ) { $work.MAP = $map_name[1] }
   elseif( $work.MAP -eq $map_id[2] ) { $work.MAP = $map_name[2] }
   elseif( $work.MAP -eq $map_id[3] ) { $work.MAP = $map_name[3] }
   elseif( $work.MAP -eq $map_id[4] ) { $work.MAP = $map_name[4] }
   elseif( $work.MAP -eq $map_id[5] ) { $work.MAP = $map_name[5] }
   elseif( $work.MAP -eq $map_id[6] ) { $work.MAP = $map_name[6] }
   elseif( $work.MAP -eq $map_id[7] ) { $work.MAP = $map_name[7] }
   elseif( $work.MAP -eq $map_id[8] ) { $work.MAP = $map_name[8] }
   elseif( $work.MAP -eq $map_id[9] ) { $work.MAP = $map_name[9] }
   elseif( $work.MAP -eq $map_id[10] ) { $work.MAP = $map_name[10] }
   elseif( $work.MAP -eq $map_id[11] ) { $work.MAP = $map_name[11] }
   elseif( $work.MAP -eq $map_id[12] ) { $work.MAP = $map_name[12] }
   elseif( $work.MAP -eq $map_id[13] ) { $work.MAP = $map_name[13] }
   elseif( $work.MAP -eq $map_id[14] ) { $work.MAP = $map_name[14] }
   elseif( $work.MAP -eq $map_id[15] ) { $work.MAP = $map_name[15] }
   elseif( $work.MAP -eq $map_id[16] ) { $work.MAP = $map_name[16] }
   elseif( $work.MAP -eq $map_id[17] ) { $work.MAP = $map_name[17] }
   elseif( $work.MAP -eq $map_id[18] ) { $work.MAP = $map_name[18] }
   elseif( $work.MAP -eq $map_id[19] ) { $work.MAP = $map_name[19] }
   elseif( $work.MAP -eq $map_id[20] ) { $work.MAP = $map_name[20] }
   elseif( $work.MAP -eq $map_id[21] ) { $work.MAP = $map_name[21] }
   elseif( $work.MAP -eq $map_id[22] ) { $work.MAP = $map_name[22] }
   elseif( $work.MAP -eq $map_id[23] ) { $work.MAP = $map_name[23] }
   elseif( $work.MAP -eq $map_id[24] ) { $work.MAP = $map_name[24] }
   elseif( $work.MAP -eq $map_id[25] ) { $work.MAP = $map_name[25] }
   elseif( $work.MAP -eq $map_id[26] ) { $work.MAP = $map_name[26] }
   elseif( $work.MAP -eq $map_id[27] ) { $work.MAP = $map_name[27] }
   elseif( $work.MAP -eq $map_id[28] ) { $work.MAP = $map_name[28] }
   elseif( $work.MAP -eq $map_id[29] ) { $work.MAP = $map_name[29] }
   elseif( $work.MAP -eq $map_id[30] ) { $work.MAP = $map_name[30] }
   elseif( $work.MAP -eq $map_id[31] ) { $work.MAP = $map_name[31] }
   elseif( $work.MAP -eq $map_id[32] ) { $work.MAP = $map_name[32] }
   elseif( $work.MAP -eq $map_id[33] ) { $work.MAP = $map_name[33] }
   elseif( $work.MAP -eq $map_id[34] ) { $work.MAP = $map_name[34] }
   elseif( $work.MAP -eq $map_id[35] ) { $work.MAP = $map_name[35] }
   elseif( $work.MAP -eq $map_id[36] ) { $work.MAP = $map_name[36] }
   elseif( $work.MAP -eq $map_id[37] ) { $work.MAP = $map_name[37] }
   elseif( $work.MAP -eq $map_id[38] ) { $work.MAP = $map_name[38] }
   elseif( $work.MAP -eq $map_id[39] ) { $work.MAP = $map_name[39] }
   elseif( $work.MAP -eq $map_id[40] ) { $work.MAP = $map_name[40] }
   elseif( $work.MAP -eq $map_id[41] ) { $work.MAP = $map_name[41] }
   elseif( $work.MAP -eq $map_id[42] ) { $work.MAP = $map_name[42] }
   elseif( $work.MAP -eq $map_id[43] ) { $work.MAP = $map_name[43] }
   elseif( $work.MAP -eq $map_id[44] ) { $work.MAP = $map_name[44] }
   elseif( $work.MAP -eq $map_id[45] ) { $work.MAP = $map_name[45] }
   elseif( $work.MAP -eq $map_id[46] ) { $work.MAP = $map_name[46] }
   elseif( $work.MAP -eq $map_id[47] ) { $work.MAP = $map_name[47] }
   elseif( $work.MAP -eq $map_id[48] ) { $work.MAP = $map_name[48] }
   elseif( $work.MAP -eq $map_id[49] ) { $work.MAP = $map_name[49] }
   elseif( $work.MAP -eq $map_id[50] ) { $work.MAP = $map_name[50] }
   elseif( $work.MAP -eq $map_id[51] ) { $work.MAP = $map_name[51] }
   elseif( $work.MAP -eq $map_id[52] ) { $work.MAP = $map_name[52] }
   elseif( $work.MAP -eq $map_id[53] ) { $work.MAP = $map_name[53] }
   elseif( $work.MAP -eq $map_id[54] ) { $work.MAP = $map_name[54] }
   elseif( $work.MAP -eq $map_id[55] ) { $work.MAP = $map_name[55] }
   elseif( $work.MAP -eq $map_id[56] ) { $work.MAP = $map_name[56] }
   elseif( $work.MAP -eq $map_id[57] ) { $work.MAP = $map_name[57] }
   elseif( $work.MAP -eq $map_id[58] ) { $work.MAP = $map_name[58] }
   elseif( $work.MAP -eq $map_id[59] ) { $work.MAP = $map_name[59] }
   elseif( $work.MAP -eq $map_id[60] ) { $work.MAP = $map_name[60] }
   elseif( $work.MAP -eq $map_id[61] ) { $work.MAP = $map_name[61] }
   elseif( $work.MAP -eq $map_id[62] ) { $work.MAP = $map_name[62] }
   elseif( $work.MAP -eq $map_id[63] ) { $work.MAP = $map_name[63] }
   elseif( $work.MAP -eq $map_id[64] ) { $work.MAP = $map_name[64] }
   elseif( $work.MAP -eq $map_id[65] ) { $work.MAP = $map_name[65] }
   elseif( $work.MAP -eq $map_id[66] ) { $work.MAP = $map_name[66] }
   elseif( $work.MAP -eq $map_id[67] ) { $work.MAP = $map_name[67] }
   elseif( $work.MAP -eq $map_id[68] ) { $work.MAP = $map_name[68] }
   elseif( $work.MAP -eq $map_id[69] ) { $work.MAP = $map_name[69] }
   elseif( $work.MAP -eq $map_id[70] ) { $work.MAP = $map_name[70] }
   elseif( $work.MAP -eq $map_id[71] ) { $work.MAP = $map_name[71] }
   elseif( $work.MAP -eq $map_id[72] ) { $work.MAP = $map_name[72] }
   elseif( $work.MAP -eq $map_id[73] ) { $work.MAP = $map_name[73] }
   elseif( $work.MAP -eq $map_id[74] ) { $work.MAP = $map_name[74] }
   elseif( $work.MAP -eq $map_id[75] ) { $work.MAP = $map_name[75] }
   elseif( $work.MAP -eq $map_id[76] ) { $work.MAP = $map_name[76] }
   elseif( $work.MAP -eq $map_id[77] ) { $work.MAP = $map_name[77] }
   elseif( $work.MAP -eq $map_id[78] ) { $work.MAP = $map_name[78] }
   elseif( $work.MAP -eq $map_id[79] ) { $work.MAP = $map_name[79] }
   elseif( $work.MAP -eq $map_id[80] ) { $work.MAP = $map_name[80] }
   elseif( $work.MAP -eq $map_id[81] ) { $work.MAP = $map_name[81] }
   elseif( $work.MAP -eq $map_id[82] ) { $work.MAP = $map_name[82] }
   elseif( $work.MAP -eq $map_id[83] ) { $work.MAP = $map_name[83] }
   elseif( $work.MAP -eq $map_id[84] ) { $work.MAP = $map_name[84] }
   elseif( $work.MAP -eq $map_id[85] ) { $work.MAP = $map_name[85] }
   elseif( $work.MAP -eq $map_id[86] ) { $work.MAP = $map_name[86] }
   elseif( $work.MAP -eq $map_id[87] ) { $work.MAP = $map_name[87] }
   elseif( $work.MAP -eq $map_id[88] ) { $work.MAP = $map_name[88] }
   elseif( $work.MAP -eq $map_id[89] ) { $work.MAP = $map_name[89] }
   elseif( $work.MAP -eq $map_id[90] ) { $work.MAP = $map_name[90] }
   elseif( $work.MAP -eq $map_id[91] ) { $work.MAP = $map_name[91] }
   elseif( $work.MAP -eq $map_id[92] ) { $work.MAP = $map_name[92] }
   elseif( $work.MAP -eq $map_id[93] ) { $work.MAP = $map_name[93] }
   elseif( $work.MAP -eq $map_id[94] ) { $work.MAP = $map_name[94] }
   elseif( $work.MAP -eq $map_id[95] ) { $work.MAP = $map_name[95] }
   elseif( $work.MAP -eq $map_id[96] ) { $work.MAP = $map_name[96] }
   elseif( $work.MAP -eq $map_id[97] ) { $work.MAP = $map_name[97] }
   elseif( $work.MAP -eq $map_id[98] ) { $work.MAP = $map_name[98] }
   elseif( $work.MAP -eq $map_id[99] ) { $work.MAP = $map_name[99] }
   elseif( $work.MAP -eq $map_id[100] ) { $work.MAP = $map_name[100] }
   elseif( $work.MAP -eq $map_id[101] ) { $work.MAP = $map_name[101] }
   elseif( $work.MAP -eq $map_id[102] ) { $work.MAP = $map_name[102] }
   elseif( $work.MAP -eq $map_id[103] ) { $work.MAP = $map_name[103] }
   elseif( $work.MAP -eq $map_id[104] ) { $work.MAP = $map_name[104] }
   elseif( $work.MAP -eq $map_id[105] ) { $work.MAP = $map_name[105] }
   elseif( $work.MAP -eq $map_id[106] ) { $work.MAP = $map_name[106] }
   elseif( $work.MAP -eq $map_id[107] ) { $work.MAP = $map_name[107] }
   elseif( $work.MAP -eq $map_id[108] ) { $work.MAP = $map_name[108] }
   elseif( $work.MAP -eq $map_id[109] ) { $work.MAP = $map_name[109] }
   elseif( $work.MAP -eq $map_id[110] ) { $work.MAP = $map_name[110] }
   elseif( $work.MAP -eq $map_id[111] ) { $work.MAP = $map_name[111] }
   elseif( $work.MAP -eq $map_id[112] ) { $work.MAP = $map_name[112] }
   elseif( $work.MAP -eq $map_id[113] ) { $work.MAP = $map_name[113] }
   elseif( $work.MAP -eq $map_id[114] ) { $work.MAP = $map_name[114] }
   elseif( $work.MAP -eq $map_id[115] ) { $work.MAP = $map_name[115] }
   elseif( $work.MAP -eq $map_id[116] ) { $work.MAP = $map_name[116] }
   elseif( $work.MAP -eq $map_id[117] ) { $work.MAP = $map_name[117] }
   elseif( $work.MAP -eq $map_id[118] ) { $work.MAP = $map_name[118] }
   elseif( $work.MAP -eq $map_id[119] ) { $work.MAP = $map_name[119] }
   elseif( $work.MAP -eq $map_id[120] ) { $work.MAP = $map_name[120] }
   elseif( $work.MAP -eq $map_id[121] ) { $work.MAP = $map_name[121] }
   elseif( $work.MAP -eq $map_id[122] ) { $work.MAP = $map_name[122] }
   elseif( $work.MAP -eq $map_id[123] ) { $work.MAP = $map_name[123] }
   elseif( $work.MAP -eq $map_id[124] ) { $work.MAP = $map_name[124] }
   elseif( $work.MAP -eq $map_id[125] ) { $work.MAP = $map_name[125] }
   elseif( $work.MAP -eq $map_id[126] ) { $work.MAP = $map_name[126] }
   elseif( $work.MAP -eq $map_id[127] ) { $work.MAP = $map_name[127] }
   elseif( $work.MAP -eq $map_id[128] ) { $work.MAP = $map_name[128] }
   elseif( $work.MAP -eq $map_id[129] ) { $work.MAP = $map_name[129] }
   elseif( $work.MAP -eq $map_id[130] ) { $work.MAP = $map_name[130] }
   elseif( $work.MAP -eq $map_id[131] ) { $work.MAP = $map_name[131] }
   elseif( $work.MAP -eq $map_id[132] ) { $work.MAP = $map_name[132] }
   elseif( $work.MAP -eq $map_id[133] ) { $work.MAP = $map_name[133] }
   elseif( $work.MAP -eq $map_id[134] ) { $work.MAP = $map_name[134] }
   elseif( $work.MAP -eq $map_id[135] ) { $work.MAP = $map_name[135] }
   elseif( $work.MAP -eq $map_id[136] ) { $work.MAP = $map_name[136] }
   elseif( $work.MAP -eq $map_id[137] ) { $work.MAP = $map_name[137] }
   elseif( $work.MAP -eq $map_id[138] ) { $work.MAP = $map_name[138] }
   elseif( $work.MAP -eq $map_id[139] ) { $work.MAP = $map_name[139] }
   elseif( $work.MAP -eq $map_id[140] ) { $work.MAP = $map_name[140] }
   elseif( $work.MAP -eq $map_id[141] ) { $work.MAP = $map_name[141] }
   elseif( $work.MAP -eq $map_id[142] ) { $work.MAP = $map_name[142] }
   elseif( $work.MAP -eq $map_id[143] ) { $work.MAP = $map_name[143] }
   elseif( $work.MAP -eq $map_id[144] ) { $work.MAP = $map_name[144] }
   elseif( $work.MAP -eq $map_id[145] ) { $work.MAP = $map_name[145] }
   elseif( $work.MAP -eq $map_id[146] ) { $work.MAP = $map_name[146] }
   elseif( $work.MAP -eq $map_id[147] ) { $work.MAP = $map_name[147] }
   elseif( $work.MAP -eq $map_id[148] ) { $work.MAP = $map_name[148] }
   elseif( $work.MAP -eq $map_id[149] ) { $work.MAP = $map_name[149] }
   elseif( $work.MAP -eq $map_id[150] ) { $work.MAP = $map_name[150] }
   elseif( $work.MAP -eq $map_id[151] ) { $work.MAP = $map_name[151] }
   elseif( $work.MAP -eq $map_id[152] ) { $work.MAP = $map_name[152] }
   elseif( $work.MAP -eq $map_id[153] ) { $work.MAP = $map_name[153] }
   elseif( $work.MAP -eq $map_id[154] ) { $work.MAP = $map_name[154] }
   elseif( $work.MAP -eq $map_id[155] ) { $work.MAP = $map_name[155] }
   elseif( $work.MAP -eq $map_id[156] ) { $work.MAP = $map_name[156] }
   elseif( $work.MAP -eq $map_id[157] ) { $work.MAP = $map_name[157] }
   elseif( $work.MAP -eq $map_id[158] ) { $work.MAP = $map_name[158] }
   elseif( $work.MAP -eq $map_id[159] ) { $work.MAP = $map_name[159] }
   elseif( $work.MAP -eq $map_id[160] ) { $work.MAP = $map_name[160] }
   elseif( $work.MAP -eq $map_id[161] ) { $work.MAP = $map_name[161] }
   elseif( $work.MAP -eq $map_id[162] ) { $work.MAP = $map_name[162] }
   elseif( $work.MAP -eq $map_id[163] ) { $work.MAP = $map_name[163] }
   elseif( $work.MAP -eq $map_id[164] ) { $work.MAP = $map_name[164] }
   elseif( $work.MAP -eq $map_id[165] ) { $work.MAP = $map_name[165] }
   elseif( $work.MAP -eq $map_id[166] ) { $work.MAP = $map_name[166] }
   elseif( $work.MAP -eq $map_id[167] ) { $work.MAP = $map_name[167] }
   elseif( $work.MAP -eq $map_id[168] ) { $work.MAP = $map_name[168] }
   elseif( $work.MAP -eq $map_id[169] ) { $work.MAP = $map_name[169] }
   elseif( $work.MAP -eq $map_id[170] ) { $work.MAP = $map_name[170] }
   elseif( $work.MAP -eq $map_id[171] ) { $work.MAP = $map_name[171] }
   elseif( $work.MAP -eq $map_id[172] ) { $work.MAP = $map_name[172] }
   elseif( $work.MAP -eq $map_id[173] ) { $work.MAP = $map_name[173] }
   elseif( $work.MAP -eq $map_id[174] ) { $work.MAP = $map_name[174] }
   elseif( $work.MAP -eq $map_id[175] ) { $work.MAP = $map_name[175] }
   elseif( $work.MAP -eq $map_id[176] ) { $work.MAP = $map_name[176] }
   elseif( $work.MAP -eq $map_id[177] ) { $work.MAP = $map_name[177] }
   elseif( $work.MAP -eq $map_id[178] ) { $work.MAP = $map_name[178] }
   elseif( $work.MAP -eq $map_id[179] ) { $work.MAP = $map_name[179] }
   elseif( $work.MAP -eq $map_id[180] ) { $work.MAP = $map_name[180] }
   elseif( $work.MAP -eq $map_id[181] ) { $work.MAP = $map_name[181] }
   elseif( $work.MAP -eq $map_id[182] ) { $work.MAP = $map_name[182] }
   elseif( $work.MAP -eq $map_id[183] ) { $work.MAP = $map_name[183] }
   elseif( $work.MAP -eq $map_id[184] ) { $work.MAP = $map_name[184] }
   elseif( $work.MAP -eq $map_id[185] ) { $work.MAP = $map_name[185] }
   elseif( $work.MAP -eq $map_id[186] ) { $work.MAP = $map_name[186] }
   elseif( $work.MAP -eq $map_id[187] ) { $work.MAP = $map_name[187] }
   elseif( $work.MAP -eq $map_id[188] ) { $work.MAP = $map_name[188] }
   elseif( $work.MAP -eq $map_id[189] ) { $work.MAP = $map_name[189] }
   elseif( $work.MAP -eq $map_id[190] ) { $work.MAP = $map_name[190] }
   elseif( $work.MAP -eq $map_id[191] ) { $work.MAP = $map_name[191] }
   elseif( $work.MAP -eq $map_id[192] ) { $work.MAP = $map_name[192] }
   elseif( $work.MAP -eq $map_id[193] ) { $work.MAP = $map_name[193] }
   elseif( $work.MAP -eq $map_id[194] ) { $work.MAP = $map_name[194] }
   elseif( $work.MAP -eq $map_id[195] ) { $work.MAP = $map_name[195] }
   elseif( $work.MAP -eq $map_id[196] ) { $work.MAP = $map_name[196] }
   elseif( $work.MAP -eq $map_id[197] ) { $work.MAP = $map_name[197] }
   elseif( $work.MAP -eq $map_id[198] ) { $work.MAP = $map_name[198] }
   elseif( $work.MAP -eq $map_id[199] ) { $work.MAP = $map_name[199] }
   elseif( $work.MAP -eq $map_id[200] ) { $work.MAP = $map_name[200] }
   elseif( $work.MAP -eq $map_id[201] ) { $work.MAP = $map_name[201] }
   elseif( $work.MAP -eq $map_id[202] ) { $work.MAP = $map_name[202] }
   elseif( $work.MAP -eq $map_id[203] ) { $work.MAP = $map_name[203] }
   elseif( $work.MAP -eq $map_id[204] ) { $work.MAP = $map_name[204] }
   elseif( $work.MAP -eq $map_id[205] ) { $work.MAP = $map_name[205] }
   elseif( $work.MAP -eq $map_id[206] ) { $work.MAP = $map_name[206] }
   elseif( $work.MAP -eq $map_id[207] ) { $work.MAP = $map_name[207] }
   elseif( $work.MAP -eq $map_id[208] ) { $work.MAP = $map_name[208] }
   elseif( $work.MAP -eq $map_id[209] ) { $work.MAP = $map_name[209] }
   elseif( $work.MAP -eq $map_id[210] ) { $work.MAP = $map_name[210] }
   elseif( $work.MAP -eq $map_id[211] ) { $work.MAP = $map_name[211] }
   elseif( $work.MAP -eq $map_id[212] ) { $work.MAP = $map_name[212] }
   elseif( $work.MAP -eq $map_id[213] ) { $work.MAP = $map_name[213] }
   elseif( $work.MAP -eq $map_id[214] ) { $work.MAP = $map_name[214] }
   elseif( $work.MAP -eq $map_id[215] ) { $work.MAP = $map_name[215] }
   elseif( $work.MAP -eq $map_id[216] ) { $work.MAP = $map_name[216] }
   elseif( $work.MAP -eq $map_id[217] ) { $work.MAP = $map_name[217] }
   elseif( $work.MAP -eq $map_id[218] ) { $work.MAP = $map_name[218] }
   elseif( $work.MAP -eq $map_id[219] ) { $work.MAP = $map_name[219] }
   elseif( $work.MAP -eq $map_id[220] ) { $work.MAP = $map_name[220] }
   elseif( $work.MAP -eq $map_id[221] ) { $work.MAP = $map_name[221] }
   elseif( $work.MAP -eq $map_id[222] ) { $work.MAP = $map_name[222] }
   elseif( $work.MAP -eq $map_id[223] ) { $work.MAP = $map_name[223] }
   elseif( $work.MAP -eq $map_id[224] ) { $work.MAP = $map_name[224] }
   elseif( $work.MAP -eq $map_id[225] ) { $work.MAP = $map_name[225] }
   elseif( $work.MAP -eq $map_id[226] ) { $work.MAP = $map_name[226] }
   elseif( $work.MAP -eq $map_id[227] ) { $work.MAP = $map_name[227] }
   elseif( $work.MAP -eq $map_id[228] ) { $work.MAP = $map_name[228] }
   elseif( $work.MAP -eq $map_id[229] ) { $work.MAP = $map_name[229] }
   elseif( $work.MAP -eq $map_id[230] ) { $work.MAP = $map_name[230] }
   elseif( $work.MAP -eq $map_id[231] ) { $work.MAP = $map_name[231] }
   elseif( $work.MAP -eq $map_id[232] ) { $work.MAP = $map_name[232] }
   elseif( $work.MAP -eq $map_id[233] ) { $work.MAP = $map_name[233] }
   elseif( $work.MAP -eq $map_id[234] ) { $work.MAP = $map_name[234] }
   elseif( $work.MAP -eq $map_id[235] ) { $work.MAP = $map_name[235] }
   elseif( $work.MAP -eq $map_id[236] ) { $work.MAP = $map_name[236] }
   elseif( $work.MAP -eq $map_id[237] ) { $work.MAP = $map_name[237] }
   elseif( $work.MAP -eq $map_id[238] ) { $work.MAP = $map_name[238] }
   elseif( $work.MAP -eq $map_id[239] ) { $work.MAP = $map_name[239] }
   elseif( $work.MAP -eq $map_id[240] ) { $work.MAP = $map_name[240] }
   elseif( $work.MAP -eq $map_id[241] ) { $work.MAP = $map_name[241] }
   elseif( $work.MAP -eq $map_id[242] ) { $work.MAP = $map_name[242] }
   elseif( $work.MAP -eq $map_id[243] ) { $work.MAP = $map_name[243] }
   elseif( $work.MAP -eq $map_id[244] ) { $work.MAP = $map_name[244] }
   elseif( $work.MAP -eq $map_id[245] ) { $work.MAP = $map_name[245] }
   elseif( $work.MAP -eq $map_id[246] ) { $work.MAP = $map_name[246] }
   elseif( $work.MAP -eq $map_id[247] ) { $work.MAP = $map_name[247] }
   elseif( $work.MAP -eq $map_id[248] ) { $work.MAP = $map_name[248] }
   elseif( $work.MAP -eq $map_id[249] ) { $work.MAP = $map_name[249] }
   elseif( $work.MAP -eq $map_id[250] ) { $work.MAP = $map_name[250] }
   elseif( $work.MAP -eq $map_id[251] ) { $work.MAP = $map_name[251] }
   elseif( $work.MAP -eq $map_id[252] ) { $work.MAP = $map_name[252] }
   elseif( $work.MAP -eq $map_id[253] ) { $work.MAP = $map_name[253] }
   elseif( $work.MAP -eq $map_id[254] ) { $work.MAP = $map_name[254] }
   elseif( $work.MAP -eq $map_id[255] ) { $work.MAP = $map_name[255] }
   elseif( $work.MAP -eq $map_id[256] ) { $work.MAP = $map_name[256] }
   elseif( $work.MAP -eq $map_id[257] ) { $work.MAP = $map_name[257] }
   elseif( $work.MAP -eq $map_id[258] ) { $work.MAP = $map_name[258] }
   elseif( $work.MAP -eq $map_id[259] ) { $work.MAP = $map_name[259] }
   elseif( $work.MAP -eq $map_id[260] ) { $work.MAP = $map_name[260] }
   elseif( $work.MAP -eq $map_id[261] ) { $work.MAP = $map_name[261] }
   elseif( $work.MAP -eq $map_id[262] ) { $work.MAP = $map_name[262] }
   elseif( $work.MAP -eq $map_id[263] ) { $work.MAP = $map_name[263] }
   elseif( $work.MAP -eq $map_id[264] ) { $work.MAP = $map_name[264] }
   elseif( $work.MAP -eq $map_id[265] ) { $work.MAP = $map_name[265] }
   elseif( $work.MAP -eq $map_id[266] ) { $work.MAP = $map_name[266] }
   elseif( $work.MAP -eq $map_id[267] ) { $work.MAP = $map_name[267] }
   elseif( $work.MAP -eq $map_id[268] ) { $work.MAP = $map_name[268] }
   elseif( $work.MAP -eq $map_id[269] ) { $work.MAP = $map_name[269] }
   elseif( $work.MAP -eq $map_id[270] ) { $work.MAP = $map_name[270] }
   elseif( $work.MAP -eq $map_id[271] ) { $work.MAP = $map_name[271] }
   elseif( $work.MAP -eq $map_id[272] ) { $work.MAP = $map_name[272] }
   elseif( $work.MAP -eq $map_id[273] ) { $work.MAP = $map_name[273] }
   elseif( $work.MAP -eq $map_id[274] ) { $work.MAP = $map_name[274] }
   elseif( $work.MAP -eq $map_id[275] ) { $work.MAP = $map_name[275] }
   elseif( $work.MAP -eq $map_id[276] ) { $work.MAP = $map_name[276] }
   elseif( $work.MAP -eq $map_id[277] ) { $work.MAP = $map_name[277] }
   elseif( $work.MAP -eq $map_id[278] ) { $work.MAP = $map_name[278] }
   elseif( $work.MAP -eq $map_id[279] ) { $work.MAP = $map_name[279] }
   elseif( $work.MAP -eq $map_id[280] ) { $work.MAP = $map_name[280] }
   elseif( $work.MAP -eq $map_id[281] ) { $work.MAP = $map_name[281] }
   elseif( $work.MAP -eq $map_id[282] ) { $work.MAP = $map_name[282] }
   elseif( $work.MAP -eq $map_id[283] ) { $work.MAP = $map_name[283] }
   elseif( $work.MAP -eq $map_id[284] ) { $work.MAP = $map_name[284] }
   elseif( $work.MAP -eq $map_id[285] ) { $work.MAP = $map_name[285] }
   elseif( $work.MAP -eq $map_id[286] ) { $work.MAP = $map_name[286] }
   elseif( $work.MAP -eq $map_id[287] ) { $work.MAP = $map_name[287] }
   elseif( $work.MAP -eq $map_id[288] ) { $work.MAP = $map_name[288] }
   elseif( $work.MAP -eq $map_id[289] ) { $work.MAP = $map_name[289] }
   elseif( $work.MAP -eq $map_id[290] ) { $work.MAP = $map_name[290] }
   elseif( $work.MAP -eq $map_id[291] ) { $work.MAP = $map_name[291] }
   elseif( $work.MAP -eq $map_id[292] ) { $work.MAP = $map_name[292] }
   elseif( $work.MAP -eq $map_id[293] ) { $work.MAP = $map_name[293] }
   elseif( $work.MAP -eq $map_id[294] ) { $work.MAP = $map_name[294] }
   elseif( $work.MAP -eq $map_id[295] ) { $work.MAP = $map_name[295] }
   elseif( $work.MAP -eq $map_id[296] ) { $work.MAP = $map_name[296] }
   elseif( $work.MAP -eq $map_id[297] ) { $work.MAP = $map_name[297] }
   elseif( $work.MAP -eq $map_id[298] ) { $work.MAP = $map_name[298] }
   elseif( $work.MAP -eq $map_id[299] ) { $work.MAP = $map_name[299] }
   elseif( $work.MAP -eq $map_id[300] ) { $work.MAP = $map_name[300] }
   elseif( $work.MAP -eq $map_id[301] ) { $work.MAP = $map_name[301] }
   elseif( $work.MAP -eq $map_id[302] ) { $work.MAP = $map_name[302] }
   elseif( $work.MAP -eq $map_id[303] ) { $work.MAP = $map_name[303] }
   elseif( $work.MAP -eq $map_id[304] ) { $work.MAP = $map_name[304] }
   elseif( $work.MAP -eq $map_id[305] ) { $work.MAP = $map_name[305] }
   elseif( $work.MAP -eq $map_id[306] ) { $work.MAP = $map_name[306] }
   elseif( $work.MAP -eq $map_id[307] ) { $work.MAP = $map_name[307] }
   elseif( $work.MAP -eq $map_id[308] ) { $work.MAP = $map_name[308] }
   elseif( $work.MAP -eq $map_id[309] ) { $work.MAP = $map_name[309] }
   elseif( $work.MAP -eq $map_id[310] ) { $work.MAP = $map_name[310] }
   elseif( $work.MAP -eq $map_id[311] ) { $work.MAP = $map_name[311] }
   elseif( $work.MAP -eq $map_id[312] ) { $work.MAP = $map_name[312] }
   elseif( $work.MAP -eq $map_id[313] ) { $work.MAP = $map_name[313] }
   elseif( $work.MAP -eq $map_id[314] ) { $work.MAP = $map_name[314] }
   elseif( $work.MAP -eq $map_id[315] ) { $work.MAP = $map_name[315] }
   elseif( $work.MAP -eq $map_id[316] ) { $work.MAP = $map_name[316] }
   elseif( $work.MAP -eq $map_id[317] ) { $work.MAP = $map_name[317] }
   elseif( $work.MAP -eq $map_id[318] ) { $work.MAP = $map_name[318] }
   elseif( $work.MAP -eq $map_id[319] ) { $work.MAP = $map_name[319] }
   elseif( $work.MAP -eq $map_id[320] ) { $work.MAP = $map_name[320] }
   elseif( $work.MAP -eq $map_id[321] ) { $work.MAP = $map_name[321] }
   elseif( $work.MAP -eq $map_id[322] ) { $work.MAP = $map_name[322] }
   elseif( $work.MAP -eq $map_id[323] ) { $work.MAP = $map_name[323] }
   elseif( $work.MAP -eq $map_id[324] ) { $work.MAP = $map_name[324] }
   elseif( $work.MAP -eq $map_id[325] ) { $work.MAP = $map_name[325] }
   elseif( $work.MAP -eq $map_id[326] ) { $work.MAP = $map_name[326] }
   elseif( $work.MAP -eq $map_id[327] ) { $work.MAP = $map_name[327] }
   elseif( $work.MAP -eq $map_id[328] ) { $work.MAP = $map_name[328] }
   elseif( $work.MAP -eq $map_id[329] ) { $work.MAP = $map_name[329] }
   elseif( $work.MAP -eq $map_id[330] ) { $work.MAP = $map_name[330] }
   elseif( $work.MAP -eq $map_id[331] ) { $work.MAP = $map_name[331] }
   elseif( $work.MAP -eq $map_id[332] ) { $work.MAP = $map_name[332] }
   elseif( $work.MAP -eq $map_id[333] ) { $work.MAP = $map_name[333] }
   elseif( $work.MAP -eq $map_id[334] ) { $work.MAP = $map_name[334] }
   elseif( $work.MAP -eq $map_id[335] ) { $work.MAP = $map_name[335] }
   elseif( $work.MAP -eq $map_id[336] ) { $work.MAP = $map_name[336] }
   elseif( $work.MAP -eq $map_id[337] ) { $work.MAP = $map_name[337] }
   elseif( $work.MAP -eq $map_id[338] ) { $work.MAP = $map_name[338] }
   elseif( $work.MAP -eq $map_id[339] ) { $work.MAP = $map_name[339] }
   elseif( $work.MAP -eq $map_id[340] ) { $work.MAP = $map_name[340] }
   elseif( $work.MAP -eq $map_id[341] ) { $work.MAP = $map_name[341] }
   elseif( $work.MAP -eq $map_id[342] ) { $work.MAP = $map_name[342] }
   elseif( $work.MAP -eq $map_id[343] ) { $work.MAP = $map_name[343] }
   elseif( $work.MAP -eq $map_id[344] ) { $work.MAP = $map_name[344] }
   elseif( $work.MAP -eq $map_id[345] ) { $work.MAP = $map_name[345] }
   elseif( $work.MAP -eq $map_id[346] ) { $work.MAP = $map_name[346] }
   elseif( $work.MAP -eq $map_id[347] ) { $work.MAP = $map_name[347] }
   elseif( $work.MAP -eq $map_id[348] ) { $work.MAP = $map_name[348] }
   elseif( $work.MAP -eq $map_id[349] ) { $work.MAP = $map_name[349] }
   elseif( $work.MAP -eq $map_id[350] ) { $work.MAP = $map_name[350] }
   elseif( $work.MAP -eq $map_id[351] ) { $work.MAP = $map_name[351] }
   elseif( $work.MAP -eq $map_id[352] ) { $work.MAP = $map_name[352] }
   elseif( $work.MAP -eq $map_id[353] ) { $work.MAP = $map_name[353] }
   elseif( $work.MAP -eq $map_id[354] ) { $work.MAP = $map_name[354] }
   elseif( $work.MAP -eq $map_id[355] ) { $work.MAP = $map_name[355] }
   elseif( $work.MAP -eq $map_id[356] ) { $work.MAP = $map_name[356] }
   elseif( $work.MAP -eq $map_id[357] ) { $work.MAP = $map_name[357] }
   elseif( $work.MAP -eq $map_id[358] ) { $work.MAP = $map_name[358] }
   elseif( $work.MAP -eq $map_id[359] ) { $work.MAP = $map_name[359] }
   elseif( $work.MAP -eq $map_id[360] ) { $work.MAP = $map_name[360] }
   elseif( $work.MAP -eq $map_id[361] ) { $work.MAP = $map_name[361] }
   elseif( $work.MAP -eq $map_id[362] ) { $work.MAP = $map_name[362] }
   elseif( $work.MAP -eq $map_id[363] ) { $work.MAP = $map_name[363] }
   elseif( $work.MAP -eq $map_id[364] ) { $work.MAP = $map_name[364] }
   elseif( $work.MAP -eq $map_id[365] ) { $work.MAP = $map_name[365] }
   elseif( $work.MAP -eq $map_id[366] ) { $work.MAP = $map_name[366] }
   elseif( $work.MAP -eq $map_id[367] ) { $work.MAP = $map_name[367] }
   elseif( $work.MAP -eq $map_id[368] ) { $work.MAP = $map_name[368] }
   elseif( $work.MAP -eq $map_id[369] ) { $work.MAP = $map_name[369] }
   elseif( $work.MAP -eq $map_id[370] ) { $work.MAP = $map_name[370] }
   elseif( $work.MAP -eq $map_id[371] ) { $work.MAP = $map_name[371] }
   elseif( $work.MAP -eq $map_id[372] ) { $work.MAP = $map_name[372] }
   elseif( $work.MAP -eq $map_id[373] ) { $work.MAP = $map_name[373] }
   elseif( $work.MAP -eq $map_id[374] ) { $work.MAP = $map_name[374] }
   elseif( $work.MAP -eq $map_id[375] ) { $work.MAP = $map_name[375] }
   elseif( $work.MAP -eq $map_id[376] ) { $work.MAP = $map_name[376] }
   elseif( $work.MAP -eq $map_id[377] ) { $work.MAP = $map_name[377] }
   elseif( $work.MAP -eq $map_id[378] ) { $work.MAP = $map_name[378] }
   elseif( $work.MAP -eq $map_id[379] ) { $work.MAP = $map_name[379] }
   elseif( $work.MAP -eq $map_id[380] ) { $work.MAP = $map_name[380] }
   elseif( $work.MAP -eq $map_id[381] ) { $work.MAP = $map_name[381] }
   elseif( $work.MAP -eq $map_id[382] ) { $work.MAP = $map_name[382] }
   elseif( $work.MAP -eq $map_id[383] ) { $work.MAP = $map_name[383] }
   elseif( $work.MAP -eq $map_id[384] ) { $work.MAP = $map_name[384] }
   elseif( $work.MAP -eq $map_id[385] ) { $work.MAP = $map_name[385] }
   elseif( $work.MAP -eq $map_id[386] ) { $work.MAP = $map_name[386] }
   elseif( $work.MAP -eq $map_id[387] ) { $work.MAP = $map_name[387] }
   elseif( $work.MAP -eq $map_id[388] ) { $work.MAP = $map_name[388] }
   elseif( $work.MAP -eq $map_id[389] ) { $work.MAP = $map_name[389] }
   elseif( $work.MAP -eq $map_id[390] ) { $work.MAP = $map_name[390] }
   elseif( $work.MAP -eq $map_id[391] ) { $work.MAP = $map_name[391] }
   elseif( $work.MAP -eq $map_id[392] ) { $work.MAP = $map_name[392] }
   elseif( $work.MAP -eq $map_id[393] ) { $work.MAP = $map_name[393] }
   elseif( $work.MAP -eq $map_id[394] ) { $work.MAP = $map_name[394] }
   elseif( $work.MAP -eq $map_id[395] ) { $work.MAP = $map_name[395] }
   elseif( $work.MAP -eq $map_id[396] ) { $work.MAP = $map_name[396] }
   elseif( $work.MAP -eq $map_id[397] ) { $work.MAP = $map_name[397] }
   elseif( $work.MAP -eq $map_id[398] ) { $work.MAP = $map_name[398] }
   elseif( $work.MAP -eq $map_id[399] ) { $work.MAP = $map_name[399] }
   elseif( $work.MAP -eq $map_id[400] ) { $work.MAP = $map_name[400] }
   elseif( $work.MAP -eq $map_id[401] ) { $work.MAP = $map_name[401] }
   elseif( $work.MAP -eq $map_id[402] ) { $work.MAP = $map_name[402] }
   elseif( $work.MAP -eq $map_id[403] ) { $work.MAP = $map_name[403] }
   elseif( $work.MAP -eq $map_id[404] ) { $work.MAP = $map_name[404] }
   elseif( $work.MAP -eq $map_id[405] ) { $work.MAP = $map_name[405] }
   elseif( $work.MAP -eq $map_id[406] ) { $work.MAP = $map_name[406] }
   elseif( $work.MAP -eq $map_id[407] ) { $work.MAP = $map_name[407] }
   elseif( $work.MAP -eq $map_id[408] ) { $work.MAP = $map_name[408] }
   elseif( $work.MAP -eq $map_id[409] ) { $work.MAP = $map_name[409] }
   elseif( $work.MAP -eq $map_id[410] ) { $work.MAP = $map_name[410] }
   elseif( $work.MAP -eq $map_id[411] ) { $work.MAP = $map_name[411] }
   elseif( $work.MAP -eq $map_id[412] ) { $work.MAP = $map_name[412] }
   elseif( $work.MAP -eq $map_id[413] ) { $work.MAP = $map_name[413] }
   elseif( $work.MAP -eq $map_id[414] ) { $work.MAP = $map_name[414] }
   elseif( $work.MAP -eq $map_id[415] ) { $work.MAP = $map_name[415] }
   elseif( $work.MAP -eq $map_id[416] ) { $work.MAP = $map_name[416] }
   elseif( $work.MAP -eq $map_id[417] ) { $work.MAP = $map_name[417] }
   elseif( $work.MAP -eq $map_id[418] ) { $work.MAP = $map_name[418] }
   elseif( $work.MAP -eq $map_id[419] ) { $work.MAP = $map_name[419] }
   elseif( $work.MAP -eq $map_id[420] ) { $work.MAP = $map_name[420] }
   elseif( $work.MAP -eq $map_id[421] ) { $work.MAP = $map_name[421] }
   elseif( $work.MAP -eq $map_id[422] ) { $work.MAP = $map_name[422] }
   elseif( $work.MAP -eq $map_id[423] ) { $work.MAP = $map_name[423] }
   elseif( $work.MAP -eq $map_id[424] ) { $work.MAP = $map_name[424] }
   elseif( $work.MAP -eq $map_id[425] ) { $work.MAP = $map_name[425] }
   elseif( $work.MAP -eq $map_id[426] ) { $work.MAP = $map_name[426] }
   elseif( $work.MAP -eq $map_id[427] ) { $work.MAP = $map_name[427] }
   elseif( $work.MAP -eq $map_id[428] ) { $work.MAP = $map_name[428] }
   elseif( $work.MAP -eq $map_id[429] ) { $work.MAP = $map_name[429] }
   elseif( $work.MAP -eq $map_id[430] ) { $work.MAP = $map_name[430] }
   elseif( $work.MAP -eq $map_id[431] ) { $work.MAP = $map_name[431] }
   elseif( $work.MAP -eq $map_id[432] ) { $work.MAP = $map_name[432] }
   elseif( $work.MAP -eq $map_id[433] ) { $work.MAP = $map_name[433] }
   elseif( $work.MAP -eq $map_id[434] ) { $work.MAP = $map_name[434] }
   elseif( $work.MAP -eq $map_id[435] ) { $work.MAP = $map_name[435] }
   elseif( $work.MAP -eq $map_id[436] ) { $work.MAP = $map_name[436] }
   elseif( $work.MAP -eq $map_id[437] ) { $work.MAP = $map_name[437] }
   elseif( $work.MAP -eq $map_id[438] ) { $work.MAP = $map_name[438] }
   elseif( $work.MAP -eq $map_id[439] ) { $work.MAP = $map_name[439] }
   elseif( $work.MAP -eq $map_id[440] ) { $work.MAP = $map_name[440] }
   elseif( $work.MAP -eq $map_id[441] ) { $work.MAP = $map_name[441] }
   elseif( $work.MAP -eq $map_id[442] ) { $work.MAP = $map_name[442] }
   elseif( $work.MAP -eq $map_id[443] ) { $work.MAP = $map_name[443] }
   elseif( $work.MAP -eq $map_id[444] ) { $work.MAP = $map_name[444] }
   elseif( $work.MAP -eq $map_id[445] ) { $work.MAP = $map_name[445] }
   elseif( $work.MAP -eq $map_id[446] ) { $work.MAP = $map_name[446] }
   elseif( $work.MAP -eq $map_id[447] ) { $work.MAP = $map_name[447] }
   elseif( $work.MAP -eq $map_id[448] ) { $work.MAP = $map_name[448] }
   elseif( $work.MAP -eq $map_id[449] ) { $work.MAP = $map_name[449] }
   elseif( $work.MAP -eq $map_id[450] ) { $work.MAP = $map_name[450] }
   elseif( $work.MAP -eq $map_id[451] ) { $work.MAP = $map_name[451] }
   elseif( $work.MAP -eq $map_id[452] ) { $work.MAP = $map_name[452] }
   elseif( $work.MAP -eq $map_id[453] ) { $work.MAP = $map_name[453] }
   elseif( $work.MAP -eq $map_id[454] ) { $work.MAP = $map_name[454] }
   elseif( $work.MAP -eq $map_id[455] ) { $work.MAP = $map_name[455] }
   elseif( $work.MAP -eq $map_id[456] ) { $work.MAP = $map_name[456] }
   elseif( $work.MAP -eq $map_id[457] ) { $work.MAP = $map_name[457] }
   elseif( $work.MAP -eq $map_id[458] ) { $work.MAP = $map_name[458] }
   elseif( $work.MAP -eq $map_id[459] ) { $work.MAP = $map_name[459] }
   elseif( $work.MAP -eq $map_id[460] ) { $work.MAP = $map_name[460] }
   elseif( $work.MAP -eq $map_id[461] ) { $work.MAP = $map_name[461] }
   elseif( $work.MAP -eq $map_id[462] ) { $work.MAP = $map_name[462] }
   elseif( $work.MAP -eq $map_id[463] ) { $work.MAP = $map_name[463] }
   elseif( $work.MAP -eq $map_id[464] ) { $work.MAP = $map_name[464] }
   elseif( $work.MAP -eq $map_id[465] ) { $work.MAP = $map_name[465] }
   elseif( $work.MAP -eq $map_id[466] ) { $work.MAP = $map_name[466] }
   elseif( $work.MAP -eq $map_id[467] ) { $work.MAP = $map_name[467] }
   elseif( $work.MAP -eq $map_id[468] ) { $work.MAP = $map_name[468] }
   elseif( $work.MAP -eq $map_id[469] ) { $work.MAP = $map_name[469] }
   elseif( $work.MAP -eq $map_id[470] ) { $work.MAP = $map_name[470] }
   elseif( $work.MAP -eq $map_id[471] ) { $work.MAP = $map_name[471] }
   elseif( $work.MAP -eq $map_id[472] ) { $work.MAP = $map_name[472] }
   elseif( $work.MAP -eq $map_id[473] ) { $work.MAP = $map_name[473] }
   elseif( $work.MAP -eq $map_id[474] ) { $work.MAP = $map_name[474] }
   elseif( $work.MAP -eq $map_id[475] ) { $work.MAP = $map_name[475] }
   elseif( $work.MAP -eq $map_id[476] ) { $work.MAP = $map_name[476] }
   elseif( $work.MAP -eq $map_id[477] ) { $work.MAP = $map_name[477] }
   elseif( $work.MAP -eq $map_id[478] ) { $work.MAP = $map_name[478] }
   elseif( $work.MAP -eq $map_id[479] ) { $work.MAP = $map_name[479] }
   elseif( $work.MAP -eq $map_id[480] ) { $work.MAP = $map_name[480] }
   elseif( $work.MAP -eq $map_id[481] ) { $work.MAP = $map_name[481] }
   elseif( $work.MAP -eq $map_id[482] ) { $work.MAP = $map_name[482] }
   elseif( $work.MAP -eq $map_id[483] ) { $work.MAP = $map_name[483] }
   elseif( $work.MAP -eq $map_id[484] ) { $work.MAP = $map_name[484] }
   elseif( $work.MAP -eq $map_id[485] ) { $work.MAP = $map_name[485] }
   elseif( $work.MAP -eq $map_id[486] ) { $work.MAP = $map_name[486] }
   elseif( $work.MAP -eq $map_id[487] ) { $work.MAP = $map_name[487] }
   elseif( $work.MAP -eq $map_id[488] ) { $work.MAP = $map_name[488] }
   elseif( $work.MAP -eq $map_id[489] ) { $work.MAP = $map_name[489] }
   elseif( $work.MAP -eq $map_id[490] ) { $work.MAP = $map_name[490] }
   elseif( $work.MAP -eq $map_id[491] ) { $work.MAP = $map_name[491] }
   elseif( $work.MAP -eq $map_id[492] ) { $work.MAP = $map_name[492] }
   elseif( $work.MAP -eq $map_id[493] ) { $work.MAP = $map_name[493] }
   elseif( $work.MAP -eq $map_id[494] ) { $work.MAP = $map_name[494] }
   elseif( $work.MAP -eq $map_id[495] ) { $work.MAP = $map_name[495] }
   elseif( $work.MAP -eq $map_id[496] ) { $work.MAP = $map_name[496] }
   elseif( $work.MAP -eq $map_id[497] ) { $work.MAP = $map_name[497] }
   elseif( $work.MAP -eq $map_id[498] ) { $work.MAP = $map_name[498] }
   elseif( $work.MAP -eq $map_id[499] ) { $work.MAP = $map_name[499] }
   elseif( $work.MAP -eq $map_id[500] ) { $work.MAP = $map_name[500] }
   elseif( $work.MAP -eq $map_id[501] ) { $work.MAP = $map_name[501] }
   elseif( $work.MAP -eq $map_id[502] ) { $work.MAP = $map_name[502] }
   elseif( $work.MAP -eq $map_id[503] ) { $work.MAP = $map_name[503] }
   elseif( $work.MAP -eq $map_id[504] ) { $work.MAP = $map_name[504] }
   elseif( $work.MAP -eq $map_id[505] ) { $work.MAP = $map_name[505] }
   elseif( $work.MAP -eq $map_id[506] ) { $work.MAP = $map_name[506] }
   elseif( $work.MAP -eq $map_id[507] ) { $work.MAP = $map_name[507] }
   elseif( $work.MAP -eq $map_id[508] ) { $work.MAP = $map_name[508] }
   elseif( $work.MAP -eq $map_id[509] ) { $work.MAP = $map_name[509] }
   elseif( $work.MAP -eq $map_id[510] ) { $work.MAP = $map_name[510] }
   elseif( $work.MAP -eq $map_id[511] ) { $work.MAP = $map_name[511] }
   elseif( $work.MAP -eq $map_id[512] ) { $work.MAP = $map_name[512] }
   elseif( $work.MAP -eq $map_id[513] ) { $work.MAP = $map_name[513] }
   elseif( $work.MAP -eq $map_id[514] ) { $work.MAP = $map_name[514] }
   elseif( $work.MAP -eq $map_id[515] ) { $work.MAP = $map_name[515] }
   elseif( $work.MAP -eq $map_id[516] ) { $work.MAP = $map_name[516] }
   elseif( $work.MAP -eq $map_id[517] ) { $work.MAP = $map_name[517] }
   elseif( $work.MAP -eq $map_id[518] ) { $work.MAP = $map_name[518] }
   elseif( $work.MAP -eq $map_id[519] ) { $work.MAP = $map_name[519] }
   elseif( $work.MAP -eq $map_id[520] ) { $work.MAP = $map_name[520] }
   elseif( $work.MAP -eq $map_id[521] ) { $work.MAP = $map_name[521] }
   elseif( $work.MAP -eq $map_id[522] ) { $work.MAP = $map_name[522] }
   elseif( $work.MAP -eq $map_id[523] ) { $work.MAP = $map_name[523] }
   elseif( $work.MAP -eq $map_id[524] ) { $work.MAP = $map_name[524] }
   elseif( $work.MAP -eq $map_id[525] ) { $work.MAP = $map_name[525] }
   elseif( $work.MAP -eq $map_id[526] ) { $work.MAP = $map_name[526] }
   elseif( $work.MAP -eq $map_id[527] ) { $work.MAP = $map_name[527] }
   elseif( $work.MAP -eq $map_id[528] ) { $work.MAP = $map_name[528] }
   elseif( $work.MAP -eq $map_id[529] ) { $work.MAP = $map_name[529] }
   elseif( $work.MAP -eq $map_id[530] ) { $work.MAP = $map_name[530] }
   elseif( $work.MAP -eq $map_id[531] ) { $work.MAP = $map_name[531] }
   elseif( $work.MAP -eq $map_id[532] ) { $work.MAP = $map_name[532] }
   elseif( $work.MAP -eq $map_id[533] ) { $work.MAP = $map_name[533] }
   elseif( $work.MAP -eq $map_id[534] ) { $work.MAP = $map_name[534] }
   elseif( $work.MAP -eq $map_id[535] ) { $work.MAP = $map_name[535] }
   elseif( $work.MAP -eq $map_id[536] ) { $work.MAP = $map_name[536] }
   elseif( $work.MAP -eq $map_id[537] ) { $work.MAP = $map_name[537] }
   elseif( $work.MAP -eq $map_id[538] ) { $work.MAP = $map_name[538] }
   elseif( $work.MAP -eq $map_id[539] ) { $work.MAP = $map_name[539] }
   elseif( $work.MAP -eq $map_id[540] ) { $work.MAP = $map_name[540] }
   elseif( $work.MAP -eq $map_id[541] ) { $work.MAP = $map_name[541] }
   elseif( $work.MAP -eq $map_id[542] ) { $work.MAP = $map_name[542] }
   elseif( $work.MAP -eq $map_id[543] ) { $work.MAP = $map_name[543] }
   elseif( $work.MAP -eq $map_id[544] ) { $work.MAP = $map_name[544] }
   elseif( $work.MAP -eq $map_id[545] ) { $work.MAP = $map_name[545] }
   elseif( $work.MAP -eq $map_id[546] ) { $work.MAP = $map_name[546] }
   elseif( $work.MAP -eq $map_id[547] ) { $work.MAP = $map_name[547] }
   elseif( $work.MAP -eq $map_id[548] ) { $work.MAP = $map_name[548] }
   elseif( $work.MAP -eq $map_id[549] ) { $work.MAP = $map_name[549] }
   elseif( $work.MAP -eq $map_id[550] ) { $work.MAP = $map_name[550] }
   elseif( $work.MAP -eq $map_id[551] ) { $work.MAP = $map_name[551] }
   elseif( $work.MAP -eq $map_id[552] ) { $work.MAP = $map_name[552] }
   elseif( $work.MAP -eq $map_id[553] ) { $work.MAP = $map_name[553] }
   elseif( $work.MAP -eq $map_id[554] ) { $work.MAP = $map_name[554] }
   elseif( $work.MAP -eq $map_id[555] ) { $work.MAP = $map_name[555] }
   elseif( $work.MAP -eq $map_id[556] ) { $work.MAP = $map_name[556] }
   elseif( $work.MAP -eq $map_id[557] ) { $work.MAP = $map_name[557] }
   elseif( $work.MAP -eq $map_id[558] ) { $work.MAP = $map_name[558] }
   elseif( $work.MAP -eq $map_id[559] ) { $work.MAP = $map_name[559] }
   elseif( $work.MAP -eq $map_id[560] ) { $work.MAP = $map_name[560] }
   elseif( $work.MAP -eq $map_id[561] ) { $work.MAP = $map_name[561] }
} `
}
#############################################################
# GUIで表示
$ro2 | select-object "NAME","count","time","random","MAP","subMAP" | Out-GridView -wait
