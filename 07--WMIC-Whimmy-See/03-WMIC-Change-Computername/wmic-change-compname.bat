@echo off
echo.
set /p thename=Please enter the new COMPUTERNAME: 
wmic.exe ComputerSystem Where Name="%ComputerName%" Rename Name="%thename%"
pause
choice /T 60 /D Y /C YC /M "Type Y to reboot, C to cancel."
if %errorlevel% EQU 1 goto SHUT
if %errorlevel% EQU 2 goto :EOF
:SHUT
shutdown /r /t 6 /c "Rebooting after COMPUTERNAME Change" /f /d p:2:4
