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
$ro2 = import-csv ./db/03_monster_map.csv -Encoding UTF8 -Header "�����X�^ID","�����X�^��","�}�b�vID","�o���^�C�v","�o����","�o������","�����_����","���l","�T�u�}�b�v�\�[�gNo","�T�u�}�b�v��" | Select-Object -Skip 1

#############################################################
# GUI�ŕ\��
$ro2 | select-object "�����X�^��","�o����","�o������","�����_����","�}�b�vID","�T�u�}�b�v��" | Out-GridView -wait