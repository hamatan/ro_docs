@(echo '> NUL
echo off)
if "%PROCESSOR_ARCHITECTURE%" NEQ "AMD64" (
   echo error:dont support 32bit OS
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

# 実行確認
$set_TAF = [System.Windows.Forms.MessageBox]::Show('do u Set TcpAckFrequency(TAF)?','check','YesNo','Question','Button2')
If($set_TAF -NE 'Yes'){
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

#### TcpAckFrequency (TAF)を設定 ##########################################

# wifiアダプタが有るかどうか確認する
$wifi_adapter = netsh wlan show interface | select-string GUID | %{ ($_ -split ":")[-1].trim() }

# 物理ネットワークインターフェースを検索する
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
              # TcpAckFrequency が存在する場合はレジストリエントリを再設定する
               write-host "Set-Item:$ipv4_reg"
               Set-ItemProperty -Path "$ipv4_reg" -Name "TcpAckFrequency" -Value 1
            }
            else{
              # TcpAckFrequency が存在しない場合はレジストリエントリを作成する
               write-host "New-Item:$ipv4_reg"
               New-ItemProperty -Path "$ipv4_reg" -Name "TcpAckFrequency" -PropertyType DWORD -Value 1
            }

            if( (Get-ItemProperty $ipv6_reg).PSObject.Properties.Name -contains "TcpAckFrequency" ){
              # TcpAckFrequency が存在する場合はレジストリエントリを再設定する(ipv6)
               write-host "Set-Item:$ipv6_reg"
               Set-ItemProperty -Path "$ipv6_reg" -Name "TcpAckFrequency" -Value 1
            }
            else{
              # TcpAckFrequency が存在しない場合はレジストリエントリを作成する(ipv6)
               write-host "New-Item:$ipv6_reg"
               New-ItemProperty -Path "$ipv6_reg" -Name "TcpAckFrequency" -PropertyType DWORD -Value 1
            }
         }
      }
      else{
        #$set_TAF = [System.Windows.Forms.MessageBox]::Show("$NIC_NAME is LAN adapter!! do u set taf?",'check','YesNo','Question','Button2')

        #if( $set_TAF -EQ 'Yes'){
            if( (Get-ItemProperty $ipv4_reg).PSObject.Properties.Name -contains "TcpAckFrequency" ){
              # TcpAckFrequency が存在する場合はレジストリエントリを再設定する
               write-host "Set-Item:$ipv4_reg"
               Set-ItemProperty -Path "$ipv4_reg" -Name "TcpAckFrequency" -Value 1
            }
            else{
              # TcpAckFrequency が存在しない場合はレジストリエントリを作成する
               write-host "New-Item:$ipv4_reg"
               New-ItemProperty -Path "$ipv4_reg" -Name "TcpAckFrequency" -PropertyType DWORD -Value 1
            }

            if( (Get-ItemProperty $ipv6_reg).PSObject.Properties.Name -contains "TcpAckFrequency" ){
              # TcpAckFrequency が存在する場合はレジストリエントリを再設定する(ipv6)
               write-host "Set-Item:$ipv6_reg"
               Set-ItemProperty -Path "$ipv6_reg" -Name "TcpAckFrequency" -Value 1
            }
            else{
              # TcpAckFrequency が存在しない場合はレジストリエントリを作成する(ipv6)
               write-host "New-Item:$ipv6_reg"
               New-ItemProperty -Path "$ipv6_reg" -Name "TcpAckFrequency" -PropertyType DWORD -Value 1
            }
        #}
      }
   }
}

#### 終了 #################################################################

#if( $ui_lang ){
#   [System.Windows.Forms.MessageBox]::Show('Windowsを再起動してください','成功')
#}
#else{
   [System.Windows.Forms.MessageBox]::Show('plz reboot ur windows','ok')
#}



