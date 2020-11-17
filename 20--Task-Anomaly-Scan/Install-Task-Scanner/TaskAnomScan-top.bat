@echo off
rem ***********************************************
rem
rem	FORFILES ROUTINE WILL EXTRACT THE DATE AND
rem	TIME, INCLUDING THE SECONDS, SET THEM AS
rem	VARIABLES IN THE TMP DIRECTORY AND USE THEM
rem	TO NAME THE ARCHIVE FILE BY THE LAST
rem	MODIFIED DATE.
rem
rem	TASKLIST WILL GENERATE A CURRENT TASKLIST
rem	AND USE FINDSTR TO DISPLAY ANY VALUES
rem	NOT PART OF BASELINE. IF THE RESULT FILE
rem	IS GEQ 1-BYTE, SEND E-MAIL ALERT.
rem
rem ***********************************************
if exist current-task-list.txt del current-task-list.txt
if exist %SystemDrive%\Anomaly-Defense\TaskAnomScan-Network\Task-Anomaly-Results.txt forfiles /m Task-Anomaly-Results.txt /C "cmd /c echo @file @fdate @ftime">%tmp%\taskanomnetwork1
if exist %SystemDrive%\Anomaly-Defense\TaskAnomScan-Network\Task-Anomaly-Results.txt for %%a in (%systemdrive%\Anomaly-Defense\TaskAnomScan-Network\Task-Anomaly-Results.txt) do if %%~za GEQ 1 for /f "tokens=1-11 delims=/:. " %%a in (%tmp%\taskanomnetwork1) do move /Y %SystemDrive%\Anomaly-Defense\TaskAnomScan-Network\Task-Anomaly-Results.txt %SystemDrive%\Anomaly-Defense\TaskAnomScan-Network\Archive\Task-Anomaly-Results_%%c-%%d-%%e__%%f-%%g-%%h%%i.txt
rem ***********************************************
rem
rem	SCRAP CLEANUP
rem
rem ***********************************************
if exist %SystemDrive%\Anomaly-Defense\TaskAnomScan-Network\pcavailable.txt del /Q %SystemDrive%\Anomaly-Defense\TaskAnomScan-Network\pcavailable.txt
rem ***********************************************
rem
rem	ENUMERATE AVAILABLE HOSTS
rem
rem ***********************************************
@echo off
for /f %%a in (pclist.txt) do call :PINGCHECK %%a
goto :TASKSCAN
:PINGCHECK
if "%1"=="" goto :PINGCHECKNEXT
echo Checking if %1 is up
ping -w 250 -n 2 -l 2 %1>>nul
if /i %errorlevel% EQU 0 (
echo %1>>pcavailable.txt & echo             %1 is up & echo. 
) else (
echo %time% %date% %1 not responding>>pcnotavailable.txt & echo             %1 is NOT responding & echo. 
)
exit /B
:PINGCHECKNEXT
echo null line detected, disregard this message
exit /B
:TASKSCAN
for /F %%a in (pcavailable.txt) do for /F %%j in ('tasklist /S %%a /NH') do echo %%j %%a>>current-task-list.txt
echo off
findstr /V /G:tasklist-baseline.txt current-task-list.txt >>Task-Anomaly-Results.txt
For %%a In ("Task-Anomaly-Results.txt") Do @Set TASK_ANOM_SIZE=%%~za
if %TASK_ANOM_SIZE% GEQ 1 (
