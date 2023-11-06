@echo off
wpeinit
color 0B
mode con:cols=32 lines=13
@echo Wait...
set /p ip=<ip
for /f "delims=" %%a in (ip) do (
    set "first_line=%%a"
    goto :Line1
)
:Line1
ping -n 2 %first_line% | find /i "TTL=">nul
if %errorlevel%==1 (
ping -n 9 127.0.0.1>NUL
goto Line1
) else (
net use T: \\%first_line%\tftp-np\windows /USER:PC\GUEST pass
@cls
echo.
echo.
@echo зддддбдддбддддбддд©  зд© збддд©
@echo Ёз©з©Ёздд╢з©з©Ёзд©Ё  ЁЁю©ЁЁзд©Ё
@echo юыЁЁю╢юддеыЁЁю╢юдыЁ  Ёз©юыЁюдыЁ
@echo   ЁЁ Ёздды ЁЁ Ёзддедд╢Ёю©ЁЁздды
@echo   ЁЁ ЁЁ    ЁЁ ЁЁ  юдд╢Ё ЁЁЁЁ
@echo   юы юы    юы юы     юы юдаы
@echo.
@echo        Created by Naben!
@echo.                           
@echo off
T:\setup.exe
)