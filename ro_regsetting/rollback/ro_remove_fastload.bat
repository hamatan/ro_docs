@(echo '> NUL
echo off)
if "%PROCESSOR_ARCHITECTURE%" NEQ "AMD64" (
   echo error:dont support 32bit OS
   echo error:32bit OSでは動作しません
   pause
   exit
)
NET SESSION > NUL 2>&1
IF %ERRORLEVEL% neq 0 goto RESTART
setlocal enableextensions
set "THIS_PATH=%~f0"
set "PARAM_1=%~1"
PowerShell.exe -Command "iex -Command ((gc \"%THIS_PATH:`=``%\") -join \"`n\")"
exit /b %errorlevel%

:RESTART
powershell -NoProfile -ExecutionPolicy unrestricted -Command "Start-Process %~f0 -Verb runas"
exit
') | sv -Name TempVar
# 参考
# https://vogel.at.webry.info/201707/article_9.html
# ここから先に PowerShellスクリプトを記述する
#
#### 環境チェック #########################################################
Add-Type -Assembly System.Windows.Forms

if( (Get-Culture | Select-Object -ExpandProperty Name) -match 'ja-JP' ){
   $ui_lang = 1
}
else{
   $ui_lang = 0
}

#実行確認
$set_roREG = [System.Windows.Forms.MessageBox]::Show('do u rollback skill cache(SkillUseLevelInfo)?','check','YesNo','Question','Button2')
If($set_roREG -NE 'Yes'){
   exit
}

if( [Environment]::OSVersion.Version -LT (new-object 'Version' 10,0) ){
#   if( $ui_lang ){
#      [System.Windows.Forms.MessageBox]::Show('Windows 7/8/XP/Vista では動作しません','エラー')
#   }
#   else{
      [System.Windows.Forms.MessageBox]::Show('dont support Win7/8/XP/Vista','error')
#   }
   exit
}

#### レジストリを再作成 #############################################

$reg_drive = 'HKLM:SOFTWARE\WOW6432Node\Gravity Soft\Ragnarok\SkillUseLevelInfo'
$reg_path  = 'HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Gravity Soft\Ragnarok\SkillUseLevelInfo'

if( Test-Path $reg_drive ){

   $reg_perm = "[1 5 7 17]"
   $acl_file = "$Env:Temp\SkillUseLevelInfo.txt"

   #権限を取得
   "`"$reg_path`" $reg_perm" > $acl_file
   regini "$acl_file"

   #再作成
   write-host "re create SkillUseLevelInfo"
   Reg Delete "$reg_path" /f
   Reg Add "$reg_path"

   #権限を再設定
   regini "$acl_file"
   del "$acl_file"

}
else{
#   if( $ui_lang ){
#      [System.Windows.Forms.MessageBox]::Show('RagnarokOnlineのレジストリが存在しません','エラー')
#   }
#   else{
      [System.Windows.Forms.MessageBox]::Show('RO key not found','error')
#   }
   exit
}

#### 終了 #################################################################

#if( $ui_lang ){
#   [System.Windows.Forms.MessageBox]::Show('Windowsを再起動してください','成功')
#}
#else{
   [System.Windows.Forms.MessageBox]::Show('plz reboot ur windows','ok')
#}

