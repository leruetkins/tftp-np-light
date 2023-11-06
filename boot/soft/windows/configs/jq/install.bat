@echo off
wpeinit
setlocal enabledelayedexpansion
color 0B
mode con:cols=32 lines=13
@echo Wait...

rem Считываете содержимое файла в переменную
set /p ip_json=<ip_json
echo %ip_json%

rem Используйте `jq` для извлечения значений ip и port
for /f %%A in ('echo !ip_json! ^| jq -r .ip') do set ip=%%A
for /f %%B in ('echo !ip_json! ^| jq -r .port') do set port=%%B
for /f %%C in ('echo !ip_json! ^| jq -r .share_login') do set share_login=%%C
for /f %%D in ('echo !ip_json! ^| jq -r .share_password') do set share_password=%%D

echo IP: !ip!
echo Port: !port!
echo Share Login: !share_login!
echo Share Password: !share_password!

:Line1
ping -n 2 !ip! | find /i "TTL=">nul
if %errorlevel%==1 (
ping -n 9 127.0.0.1>NUL
goto Line1
) else (
net use T: \\!ip!\tftp-np\windows /USER:!share_login! !share_password!
@cls
echo.
echo.
@echo ┌────┬───┬────┬───┐  ┌─┐ ┌┬───┐
@echo │┌┐┌┐│┌──┤┌┐┌┐│┌─┐│  ││└┐││┌─┐│
@echo └┘││└┤└──┼┘││└┤└─┘│  │┌┐└┘│└─┘│
@echo   ││ │┌──┘ ││ │┌──┼──┤│└┐││┌──┘
@echo   ││ ││    ││ ││  └──┤│ ││││
@echo   └┘ └┘    └┘ └┘     └┘ └─┴┘
@echo.
@echo        Created by Naben!
@echo.                           
@echo off
T:\configs\jq\win10_unattend.cmd
)
endlocal
