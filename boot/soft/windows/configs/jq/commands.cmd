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
@echo �����������������Ŀ  �Ŀ ����Ŀ         
@echo �ڿڿ���Ĵڿڿ��Ŀ�  �������Ŀ�         
@echo �ٳ�������ٳ�����ٳ  �ڿ�ٳ��ٳ         
@echo   �� ����� �� ������Ĵ���������         
@echo   �� ��    �� ��  ��Ĵ� ����            
@echo   �� ��    �� ��     �� ����            
@echo.
@echo        Created by Naben!
@echo.                           
@echo off
%root%WinNTSetup\WinNTSetup_x64.exe NT6 -source:%root%sources\install.esd -WimIndex:4 -syspart:S: -tempdrive:W: -unattend:"%root%unattend.xml" -Sysletter:C -setup -reboot