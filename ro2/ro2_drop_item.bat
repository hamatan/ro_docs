@(echo '> NUL
echo off)
setlocal enableextensions
set "THIS_PATH=%~f0"
set "PARAM_1=%~1"
PowerShell.exe -windowstyle hidden -Command "iex -Command ((gc \"%THIS_PATH:`=``%\") -join \"`n\")"
exit /b %errorlevel%
-- ����1��̍s�܂Ńo�b�`�t�@�C��
') | sv -Name TempVar
# �Q�l
# https://www.pg-fl.jp/program/tips/ps1bat.htm
# ��������PowerShell�X�N���v�g
#
#############################################################
# csv�t�@�C�����J��
$ro2 = import-csv ./db/01_monster_drop_item.csv -Encoding UTF8 -Header "ID","NAME","drop_item1","drop_per1","drop_item2","drop_per2","drop_item3","drop_per3","drop_item4","drop_per4","drop_item5","drop_per5","drop_item6","drop_per6","drop_item7","drop_per7","drop_item8","drop_per8" | Select-Object -Skip 1

#############################################################
# �h���b�v�����A�C�e�����Ɋ܂߂�
#
# �Ȃ񂩒x��
# foreach($work in $ro2){ `
#	for( $i=2; $i -lt 17; $i= $i+2 ){ `
#		if( @($work.PSObject.Properties)[$i+1].Value -ne 0){ `
#			@($work.PSObject.Properties)[$i].Value += " ("+ 0.01* @($work.PSObject.Properties)[$i+1].Value +"%)" `
#		} `
#	} `
# }
foreach($work in $ro2){ `
	if($work.drop_per1 -ne 0){ $work.drop_item1 += " ("+ 0.01* $work.drop_per1 +"%)" }; `
	if($work.drop_per2 -ne 0){ $work.drop_item2 += " ("+ 0.01* $work.drop_per2 +"%)" }; `
	if($work.drop_per3 -ne 0){ $work.drop_item3 += " ("+ 0.01* $work.drop_per3 +"%)" }; `
	if($work.drop_per4 -ne 0){ $work.drop_item4 += " ("+ 0.01* $work.drop_per4 +"%)" }; `
	if($work.drop_per5 -ne 0){ $work.drop_item5 += " ("+ 0.01* $work.drop_per5 +"%)" }; `
	if($work.drop_per6 -ne 0){ $work.drop_item6 += " ("+ 0.01* $work.drop_per6 +"%)" }; `
	if($work.drop_per7 -ne 0){ $work.drop_item7 += " ("+ 0.01* $work.drop_per7 +"%)" }; `
	if($work.drop_per8 -ne 0){ $work.drop_item8 += " ("+ 0.01* $work.drop_per8 +"%)" }`
}

#############################################################
# GUI�ŕ\��
$ro2 | select-object name,drop_item1,drop_item2,drop_item3,drop_item4,drop_item5,drop_item6,drop_item7,drop_item8 | Out-GridView -wait