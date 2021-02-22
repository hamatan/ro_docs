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
$set_TAF = [System.Windows.Forms.MessageBox]::Show('do u Set TcpAckFrequency(TAF)?','check','YesNo','Question','Button2')
If($set_TAF -NE 'Yes'){
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

#### TcpAckFrequency (TAF)��ݒ� ##########################################

#wifi�A�_�v�^���L�邩�ǂ����m�F����
$wifi_adapter = netsh wlan show interface | select-string GUID | %{ ($_ -split ":")[-1].trim() }

#�����l�b�g���[�N�C���^�[�t�F�[�X����������
Get-WmiObject Win32_NetworkAdapter | foreach{
   if($_.PNPDeviceID -LIKE 'PCI\VEN_*'){
      $NIC_GUID = $_ | Select-Object -ExpandProperty GUID
      $NIC_NAME = $_ | Select-Object -ExpandProperty Name
      $ipv4_reg = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$NIC_GUID"
      $ipv6_reg = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\Interfaces\$NIC_GUID"

      if( $NIC_GUID -LIKE "{$wifi_adapter}" ){
         $set_TAF = [System.Windows.Forms.MessageBox]::Show("$NIC_NAME is wifi adapter!! do u set taf?",'check','YesNo','Question','Button2')

         if( $set_TAF -EQ 'Yes'){
            if( (Get-ItemProperty $ipv4_reg).PSObject.Properties.Name -contains "TcpAckFrequency" ){
              #TcpAckFrequency �����݂���ꍇ�̓��W�X�g���G���g�����Đݒ肷��
               write-host "Set-Item:$ipv4_reg"
               Set-ItemProperty -Path "$ipv4_reg" -Name "TcpAckFrequency" -Value 1
            }
            else{
              #TcpAckFrequency �����݂��Ȃ��ꍇ�̓��W�X�g���G���g�����쐬����
               write-host "New-Item:$ipv4_reg"
               New-ItemProperty -Path "$ipv4_reg" -Name "TcpAckFrequency" -PropertyType DWORD -Value 1
            }

            if( (Get-ItemProperty $ipv6_reg).PSObject.Properties.Name -contains "TcpAckFrequency" ){
              #TcpAckFrequency �����݂���ꍇ�̓��W�X�g���G���g�����Đݒ肷��(ipv6)
               write-host "Set-Item:$ipv6_reg"
               Set-ItemProperty -Path "$ipv6_reg" -Name "TcpAckFrequency" -Value 1
            }
            else{
              #TcpAckFrequency �����݂��Ȃ��ꍇ�̓��W�X�g���G���g�����쐬����(ipv6)
               write-host "New-Item:$ipv6_reg"
               New-ItemProperty -Path "$ipv6_reg" -Name "TcpAckFrequency" -PropertyType DWORD -Value 1
            }
         }
      }
      else{
        #$set_TAF = [System.Windows.Forms.MessageBox]::Show("$NIC_NAME is LAN adapter!! do u set taf?",'check','YesNo','Question','Button2')

        #if( $set_TAF -EQ 'Yes'){
            if( (Get-ItemProperty $ipv4_reg).PSObject.Properties.Name -contains "TcpAckFrequency" ){
              #TcpAckFrequency �����݂���ꍇ�̓��W�X�g���G���g�����Đݒ肷��
               write-host "Set-Item:$ipv4_reg"
               Set-ItemProperty -Path "$ipv4_reg" -Name "TcpAckFrequency" -Value 1
            }
            else{
              #TcpAckFrequency �����݂��Ȃ��ꍇ�̓��W�X�g���G���g�����쐬����
               write-host "New-Item:$ipv4_reg"
               New-ItemProperty -Path "$ipv4_reg" -Name "TcpAckFrequency" -PropertyType DWORD -Value 1
            }

            if( (Get-ItemProperty $ipv6_reg).PSObject.Properties.Name -contains "TcpAckFrequency" ){
              #TcpAckFrequency �����݂���ꍇ�̓��W�X�g���G���g�����Đݒ肷��(ipv6)
               write-host "Set-Item:$ipv6_reg"
               Set-ItemProperty -Path "$ipv6_reg" -Name "TcpAckFrequency" -Value 1
            }
            else{
              #TcpAckFrequency �����݂��Ȃ��ꍇ�̓��W�X�g���G���g�����쐬����(ipv6)
               write-host "New-Item:$ipv6_reg"
               New-ItemProperty -Path "$ipv6_reg" -Name "TcpAckFrequency" -PropertyType DWORD -Value 1
            }
        #}
      }
   }
}

#### �I�� #################################################################

#if( $ui_lang ){
#   [System.Windows.Forms.MessageBox]::Show('Windows���ċN�����Ă�������','����')
#}
#else{
   [System.Windows.Forms.MessageBox]::Show('plz reboot ur windows','ok')
#}



