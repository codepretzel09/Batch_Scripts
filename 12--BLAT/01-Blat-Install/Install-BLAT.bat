@echo off
set installdrive=%CD%
if not exist "%systemroot%\system32\blat.exe" goto INSTALLBLAT
goto INSTALLED
rem ***********************************************
rem
rem	BLAT INSTALL ROUTINE
rem
rem ***********************************************
:INSTALLBLAT
cls
copy "%installdrive%\blat.exe" "%systemroot%\system32\blat.exe"
echo.
set /P smtphost=Enter the IP or FQDN Hostname of your Mail Server: 
echo.
blat -install %smtphost% %computername%@class.local
pause
goto :EOF

:INSTALLED
echo.
echo Blat seems to be installed already.
echo.
dir "%systemroot%\system32\blat.exe"
echo.
pause
