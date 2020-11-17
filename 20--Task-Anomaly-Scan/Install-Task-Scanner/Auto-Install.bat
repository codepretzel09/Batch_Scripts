@echo off
rem ***********************************************
rem
rem	SET INSTALLDRIVE VAR AND CREATE TASKANOM
rem	FOLDER
rem
rem ***********************************************
setlocal
set installdrive=%CD%
if not exist "%systemdrive%\Anomaly-Defense" md "%systemdrive%\Anomaly-Defense"
if not exist "%systemdrive%\Anomaly-Defense\TaskAnomScan-Network" md "%systemdrive%\Anomaly-Defense\TaskAnomScan-Network"
if not exist "%systemdrive%\Anomaly-Defense\TaskAnomScan-Network\Archive" md "%systemdrive%\Anomaly-Defense\TaskAnomScan-Network\Archive"
rem ***********************************************
rem
rem	COPY TASK BASELINE GENERATOR, DUPLICATE
rem	STRING EXTRACTION VBSCRIPT, AND PCLIST.TXT
rem	TO INSTALL FOLDER
rem
rem ***********************************************
copy "%installdrive%\GenTaskBaseline.bat" "%systemdrive%\Anomaly-Defense\TaskAnomScan-Network\GenTaskBaseline.bat"
copy "%installdrive%\find-dupl.vbs" "%systemdrive%\Anomaly-Defense\TaskAnomScan-Network\find-dupl.vbs"
copy "%installdrive%\pclist.txt" "%systemdrive%\Anomaly-Defense\TaskAnomScan-Network\pclist.txt"
rem ***********************************************
rem
rem	SCHEDULE THE ANOMALY SCAN TO RUN EVERY
rem	FOUR HOURS
rem
rem ***********************************************
echo.
echo.
schtasks /create /sc minute /mo 480 /tn "Tasklist Anomaly Scan-Network" /tr "%systemdrive%\Anomaly-Defense\TaskAnomScan-Network\TaskAnomScan.bat"
cls
rem ***********************************************
rem
rem	BLAT INSTALL STUFF
rem
rem ***********************************************
if not exist "%systemroot%\system32\blat.exe" goto INSTALLBLAT
goto NEXT
:INSTALLBLAT
copy "%installdrive%\blat.exe" "%systemroot%\system32\blat.exe"
cls
echo.
set /P smtphost=Enter the IP or FQDN Hostname of your Mail Server: 
echo.
blat -install %smtphost% %computername%@localhost.local
cls
:NEXT
cls
echo.
set /P recpt=Enter the e-mail address to send anomaly reports to: 
echo.
rem ***********************************************
rem
rem	BUILD SECOND HALF OF TASKANOMSCAN.BAT FILE
rem	AND CLEANUP TEMP FOLDER
rem
rem ***********************************************
echo blat Task-Anomaly-Results.txt -to %recpt% -s "%computername% Tasklist Anomaly Report">"%tmp%\TaskAnomScan-bottom.bat"
echo ) ELSE (>>"%tmp%\TaskAnomScan-bottom.bat"
echo goto EOF>>"%tmp%\TaskAnomScan-bottom.bat"
echo )>>"%tmp%\TaskAnomScan-bottom.bat"
echo :EOF>>"%tmp%\TaskAnomScan-bottom.bat"
echo exit>>"%tmp%\TaskAnomScan-bottom.bat"
copy "%installdrive%\TaskAnomScan-top.bat"+"%tmp%\TaskAnomScan-bottom.bat" "%systemdrive%\Anomaly-Defense\TaskAnomScan-Network\TaskAnomScan.bat"
if exist "%tmp%\TaskAnomScan-bottom.bat" del "%tmp%\TaskAnomScan-bottom.bat"
cls
echo.
set /p runbaseline=Would you like to generate a tasklist baseline now? (Y or N): 
IF %runbaseline%==y (
   goto GOBASELINE
)
IF %runbaseline%==Y (
   goto GOBASELINE
)
goto NEXT2
:GOBASELINE
%systemdrive%
cd "%systemdrive%\Anomaly-Defense\TaskAnomScan-Network"
call "%systemdrive%\Anomaly-Defense\TaskAnomScan-Network\GenTaskBaseline.bat"
:NEXT2
cls
echo.
echo Network Tasklist Anomaly Scan Install Complete
echo.
pause