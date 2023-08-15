@echo off
cd /D %~dp0..\..\..
echo %cd%
mklink /D %cd%\files\soft %cd%\boot\soft\