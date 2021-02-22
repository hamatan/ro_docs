@(echo '> NUL
echo off)
if "%PROCESSOR_ARCHITECTURE%" NEQ "AMD64" (
   echo error:dont support 32bit OS
   echo error:32bit OS�ł͓��삵�܂���
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
# �Q�l
# https://vogel.at.webry.info/201707/article_9.html
# ���������� PowerShell�X�N���v�g���L�q����
#
#### ���`�F�b�N #########################################################
Add-Type -Assembly System.Windows.Forms

if( (Get-Culture | Select-Object -ExpandProperty Name) -match 'ja-JP' ){
   $ui_lang = 1
}
else{
   $ui_lang = 0
}

#���s�m�F
$set_roREG = [System.Windows.Forms.MessageBox]::Show('do u clear skill cache(SkillUseLevelInfo)?','check','YesNo','Question','Button2')
If($set_roREG -NE 'Yes'){
   exit
}

if( [Environment]::OSVersion.Version -LT (new-object 'Version' 10,0) ){
#   if( $ui_lang ){
#      [System.Windows.Forms.MessageBox]::Show('Windows 7/8/XP/Vista �ł͓��삵�܂���','�G���[')
#   }
#   else{
      [System.Windows.Forms.MessageBox]::Show('dont support Win7/8/XP/Vista','error')
#   }
   exit
}

#### �X�L���������N���A ###################################################

$reg_path = 'HKLM:\SOFTWARE\WOW6432Node\Gravity Soft\Ragnarok\SkillUseLevelInfo'
if( Test-Path $reg_path ){
   try{
      Get-Item -Path $reg_path -ErrorAction Stop
   }
   catch{
#      if( $ui_lang ){
#         [System.Windows.Forms.MessageBox]::Show('���W�X�g���L�[�͊��ɓǎ���p�ł�','�G���[')
#      }
#      else{
         [System.Windows.Forms.MessageBox]::Show('already ReadOnly Key','error')
#      }
      exit
   }

   try{
      Remove-ItemProperty -Path "$reg_path" -Name * -ErrorAction Stop
   }
   catch{
#      if( $ui_lang ){
#         [System.Windows.Forms.MessageBox]::Show('���W�X�g���L�[�͊��ɓǎ���p�ł�','�G���[')
#      }
#      else{
         [System.Windows.Forms.MessageBox]::Show('already ReadOnly Key','error')
#      }
      exit
   }
}
else{
#   if( $ui_lang ){
#      [System.Windows.Forms.MessageBox]::Show('RagnarokOnline�̃��W�X�g�������݂��܂���','�G���[')
#   }
#   else{
      [System.Windows.Forms.MessageBox]::Show('RO key not found','error')
#   }
   exit
}

#### �������ۂ�ݒ� #######################################################

if( Test-Path $reg_path ){
   $acl = Get-Acl "$reg_path" -ErrorAction Stop
   $acl.Access | foreach{ $acl.SetAccessRuleProtection($true,$true) }
   $acl | Set-Acl "$reg_path" -ErrorAction Stop

   $acl = Get-Acl "$reg_path" -ErrorAction Stop
   $ErrorActionPreference = "silentlycontinue"
   $acl.Access | foreach{
      $IdentityReference = $_ | Select-Object -ExpandProperty IdentityReference
      $AddACL = New-Object System.Security.AccessControl.RegistryAccessRule("$IdentityReference","WriteKey","ContainerInherit, ObjectInherit", "None","Deny")
      $acl.SetAccessRule($AddACL) 
   }
   $ErrorActionPreference = "Continue"
   $acl | Set-Acl "$reg_path" -ErrorAction Stop
}
else{
#   if( $ui_lang ){
#      [System.Windows.Forms.MessageBox]::Show('RagnarokOnline�̃��W�X�g�������݂��܂���','�G���[')
#   }
#   else{
      [System.Windows.Forms.MessageBox]::Show('RO key not found','error')
#   }
   exit
}

#### �I�� #################################################################

#if( $ui_lang ){
#   [System.Windows.Forms.MessageBox]::Show('Windows���ċN�����Ă�������','����')
#}
#else{
   [System.Windows.Forms.MessageBox]::Show('plz reboot ur windows','ok')
#}

