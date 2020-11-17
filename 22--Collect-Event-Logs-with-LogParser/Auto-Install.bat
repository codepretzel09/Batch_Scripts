@echo off
set installdrive=%CD%
cls
echo.
rem ***********************************************
rem
rem	INSTALL LOGPARSER 2.2 IF NOT ALREADY
rem	INSTALLED
rem
rem ***********************************************
if not exist "%systemdrive%\Program Files (x86)\Log Parser 2.2\LogParser.exe" goto INSTALLLOGPARSER
goto NEXT
:INSTALLLOGPARSER
copy "%installdrive%\LogParser-2.2.msi" "%tmp%\LogParser-2.2.msi"
start /wait "LogParserInstall" msiexec /i "%tmp%\LogParser-2.2.msi" /passive
echo.
:NEXT
if not exist "%systemdrive%\Anomaly-Defense\EVT Collector" mkdir "%systemdrive%\Anomaly-Defense\EVT Collector"
if not exist "%systemdrive%\Anomaly-Defense\EVT Collector\lpc" mkdir "%systemdrive%\Anomaly-Defense\EVT Collector\lpc"
if not exist "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs" mkdir "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs"
if exist "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs" compact /c /s:"%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs"

xcopy %installdrive%\EVTCollect.bat "%systemdrive%\Anomaly-Defense\EVT Collector"
xcopy %installdrive%\pclist.txt "%systemdrive%\Anomaly-Defense\EVT Collector"

for /f %%a in (pclist.txt) do EVENTCREATE /S %%a /T ERROR /ID 1000 /L APPLICATION /D "Sample Entry for the Application Log"
for /f %%a in (pclist.txt) do EVENTCREATE /S %%a /T WARNING /ID 1000 /L SYSTEM /D "Sample Entry for the System Log"
for /f %%a in (pclist.txt) do tasklist /S %%a /U bob%random% /P password >nul
echo.
echo Sample Application, Security, and System Log entries created.
echo.
echo.
echo Calling EVT Collector
echo.
timeout /T 5 /NOBREAK>nul

cd /d "%systemdrive%\Anomaly-Defense\EVT Collector"
call EVTCollect.bat
echo.
echo EVT Collector Install Complete
echo.
pause