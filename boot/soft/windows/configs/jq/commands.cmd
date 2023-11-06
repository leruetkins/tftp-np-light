@ECHO OFF
color 0B
mode con:cols=86 lines=13
for %%A in ("%~dp0") do set "root=%%~dA\"
echo %root%
diskpart /s "%~dp0diskpart.dps"

@cls
echo.
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
%root%WinNTSetup\WinNTSetup_x64.exe NT6 -source:%root%sources\install.esd -WimIndex:4 -syspart:S: -tempdrive:W: -unattend:"%root%unattend.xml" -Sysletter:C -setup -reboot