@echo off

if exist "%systemdrive%\Program Files\Log Parser 2.2\LogParser.exe" goto 32BIT
if exist "%systemdrive%\Program Files (x86)\Log Parser 2.2\LogParser.exe" goto 64BIT

:32BIT
for /f "usebackq" %%a in ("%systemdrive%\Anomaly-Defense\EVT Collector\pclist.txt") do (
	if not exist "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs\Application\%date:~4,2%-%date:~7,2%-%date:~10,4%" mkdir "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs\Application\%date:~4,2%-%date:~7,2%-%date:~10,4%"
	echo Retrieving Application log from %%a
	"%systemdrive%\Program Files\Log Parser 2.2\logparser.exe" "SELECT * FROM \\%%a\Application TO .\EVTLogs\Application\%date:~4,2%-%date:~7,2%-%date:~10,4%\Application_%%a.csv WHERE EventType IN (1;2;3;16)" -i:evt -iCheckpoint:.\lpc\App-CheckPoint-%%a.lpc -resolveSIDs:ON -o:csv >nul
)
for /f "usebackq" %%a in ("%systemdrive%\Anomaly-Defense\EVT Collector\pclist.txt") do (
	if not exist "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs\System\%date:~4,2%-%date:~7,2%-%date:~10,4%" mkdir "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs\System\%date:~4,2%-%date:~7,2%-%date:~10,4%"
	echo Retrieving System log from %%a
	"%systemdrive%\Program Files\Log Parser 2.2\logparser.exe" "SELECT * FROM \\%%a\System TO .\EVTLogs\System\%date:~4,2%-%date:~7,2%-%date:~10,4%\System_%%a.csv WHERE EventType IN (1;2;3;16)" -iCheckpoint:.\lpc\Sys-CheckPoint-%%a.lpc -i:evt -resolveSIDs:ON -o:csv >nul
)
for /f "usebackq" %%a in ("%systemdrive%\Anomaly-Defense\EVT Collector\pclist.txt") do (
	if not exist "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs\Security\%date:~4,2%-%date:~7,2%-%date:~10,4%" mkdir "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs\Security\%date:~4,2%-%date:~7,2%-%date:~10,4%"
	echo Retrieving Security log from %%a
	"%systemdrive%\Program Files\Log Parser 2.2\logparser.exe" "SELECT * FROM \\%%a\Security TO .\EVTLogs\Security\%date:~4,2%-%date:~7,2%-%date:~10,4%\Security_%%a.csv WHERE EventType IN (1;2;3;16)" -iCheckpoint:.\lpc\Sec-CheckPoint-%%a.lpc -i:evt -resolveSIDs:ON -o:csv >nul
)
pause
goto :EOF

:64BIT
for /f "usebackq" %%a in ("%systemdrive%\Anomaly-Defense\EVT Collector\pclist.txt") do (
	if not exist "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs\Application\%date:~4,2%-%date:~7,2%-%date:~10,4%" mkdir "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs\Application\%date:~4,2%-%date:~7,2%-%date:~10,4%"
	echo Retrieving Application log from %%a
	"%systemdrive%\Program Files (x86)\Log Parser 2.2\logparser.exe" "SELECT * FROM \\%%a\Application TO .\EVTLogs\Application\%date:~4,2%-%date:~7,2%-%date:~10,4%\Application_%%a.csv WHERE EventType IN (1;2;3;16)" -i:evt -iCheckpoint:.\lpc\App-CheckPoint-%%a.lpc -resolveSIDs:ON -o:csv >nul
)
for /f "usebackq" %%a in ("%systemdrive%\Anomaly-Defense\EVT Collector\pclist.txt") do (
	if not exist "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs\System\%date:~4,2%-%date:~7,2%-%date:~10,4%" mkdir "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs\System\%date:~4,2%-%date:~7,2%-%date:~10,4%"
	echo Retrieving System log from %%a
	"%systemdrive%\Program Files (x86)\Log Parser 2.2\logparser.exe" "SELECT * FROM \\%%a\System TO .\EVTLogs\System\%date:~4,2%-%date:~7,2%-%date:~10,4%\System_%%a.csv WHERE EventType IN (1;2;3;16)" -iCheckpoint:.\lpc\Sys-CheckPoint-%%a.lpc -i:evt -resolveSIDs:ON -o:csv >nul
)
for /f "usebackq" %%a in ("%systemdrive%\Anomaly-Defense\EVT Collector\pclist.txt") do (
	if not exist "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs\Security\%date:~4,2%-%date:~7,2%-%date:~10,4%" mkdir "%systemdrive%\Anomaly-Defense\EVT Collector\EVTLogs\Security\%date:~4,2%-%date:~7,2%-%date:~10,4%"
	echo Retrieving Security log from %%a
	"%systemdrive%\Program Files (x86)\Log Parser 2.2\logparser.exe" "SELECT * FROM \\%%a\Security TO .\EVTLogs\Security\%date:~4,2%-%date:~7,2%-%date:~10,4%\Security_%%a.csv WHERE EventType IN (1;2;3;16)" -iCheckpoint:.\lpc\Sec-CheckPoint-%%a.lpc -i:evt -resolveSIDs:ON -o:csv >nul
)
pause
goto :EOF
