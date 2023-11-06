@echo off

set "ip="
set "port="
set "user="
set "password="

for /f %%a in (ip) do (
    if not defined ip (
        set "ip=%%a"
    ) else if not defined port (
        set "port=%%a"
    ) else if not defined user (
        set "user=%%a"
    ) else if not defined password (
        set "password=%%a"
    )
)

if not defined user (
    set "address=http://%ip%:%port%/boot/soft/strelec/strelec.iso"
) else (
    set "address=http://%ip%:%port%/boot/soft/strelec/strelec.iso?user=%user%*password=%password%"
)

:Line1
ping -n 2 %ip% | find /i "TTL=">nul
if %errorlevel%==1 (
ping -n 2 127.0.0.1>NUL
goto Line1
) else (

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HttpDisk" /v "ErrorControl" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HttpDisk" /v "Start" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HttpDisk" /v "Type" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HttpDisk\Parameters" /v "NumberOfDevices" /t REG_DWORD /d "4" /f

sc create httpdisk binPath= X:\Windows\System32\httpdisk.sys type= kernel start= demand DisplayName= "HTTP image mounting";
sc query httpdisk
sc start httpdisk

start X:\Windows\System32\httpdisk.exe /mount 0  %address%  /cd p:

ping -n 2 127.0.0.1>NUL
FOR %%i IN ( c d e f g h i j k l m n o p q r s t u v w y z) DO IF EXIST %%i:\SSTR\WLANProfile SET strelec=%%i:
start /w WLANDRIVER.exe
start %windir%\system32\MInstLink.exe
netcfg.exe -c s -i MS_Server
netcfg.exe -c p -i MS_NDISWAN
netcfg.exe -c p -i MS_NDISWANLEGACY
netcfg.exe -c s -i MS_RASMAN
netcfg.exe -c p -i MS_PPPOE
netcfg.exe -c p -i MS_NDISUIO
netcfg.exe -c s -i ms_nativewifip
netcfg.exe -c s -i ms_vwifi
netcfg.exe -c p -i ms_lltdio
netcfg.exe -c p -i ms_rspndr
netcfg.exe -c p -i ms_lldp
Reg Add "HKLM\SYSTEM\Setup" /v "SystemSetupInProgress" /t REG_DWORD /d "0x0" /f
net start dhcp
net start wcmsvc
net start LanmanServer
net start netprofm
net start MpsSvc
net start Netman
net start nlasvc
net start Server
net start mpssvc
net start RasMan
net start RasAuto
net start wlansvc
net start fdPHost
Reg Add "HKLM\SYSTEM\Setup" /v "SystemSetupInProgress" /t REG_DWORD /d "0x1" /f
wpeutil DisableFirewall
rem wpeutil UpdateBootInfo
FOR /F "tokens=3* delims= " %%i in ('reg query HKLM\HARDWARE\DESCRIPTION\System\BIOS /v BaseBoardManufacturer') DO (SET BaseBoardManufacturer=%%i)
FOR /F "tokens=3* delims= " %%i in ('reg query HKLM\HARDWARE\DESCRIPTION\System\BIOS /v BaseBoardProduct') DO (SET BaseBoardProduct=%%i)
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /t REG_SZ /v Manufacturer /d "%BaseBoardManufacturer%" /f
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /t REG_SZ /v Model /d "%BaseBoardProduct%" /f
start /b /wait Reg Add "HKLM\SYSTEM\CurrentControlSet\Control\Windows" /v "ErrorMode" /t REG_DWORD /d "0x00000002" /f
start /b Reg Add "HKLM\SYSTEM\CurrentControlSet\Control\Windows" /v "ErrorMode" /t REG_DWORD /d "0x00000000" /f
cd /D "%strelec%\SSTR\WLANProfile"
for /f "tokens=*" %%i in ('dir /b') do netsh.exe wlan add profile filename="%%i" user=all
exit
)