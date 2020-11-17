@echo off
rem ***********************************************
rem
rem	PROMPT TO GENERATE A TASKLIST BASELINE
rem
rem ***********************************************
cls
echo.
set /p areyousure=Are you sure you want to generate a baseline? Any existing baseline will be replaced. (Y or N): 
IF %areyousure%==y (
   goto NEXT
)
IF %areyousure%==Y (
   goto NEXT
)
goto END
:NEXT
rem ***********************************************
rem
rem	SCRAP CLEANUP
rem
rem ***********************************************
if exist %SystemDrive%\Anomaly-Defense\TaskAnomScan-Network\pcavailable.txt del /Q %SystemDrive%\Anomaly-Defense\TaskAnomScan-Network\pcavailable.txt
if exist %SystemDrive%\Anomaly-Defense\TaskAnomScan-Network\tasklist-baseline.txt del /Q %SystemDrive%\Anomaly-Defense\TaskAnomScan-Network\tasklist-baseline.txt
if exist %SystemDrive%\Anomaly-Defense\TaskAnomScan-Network\tasklist-baseline0.txt del /Q %SystemDrive%\Anomaly-Defense\TaskAnomScan-Network\tasklist-baseline0.txt

rem ***********************************************
rem
rem	ENUMERATE AVAILABLE HOSTS
rem
rem ***********************************************
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
@echo on
@for /F %%a in (pcavailable.txt) do @for /F %%j in ('tasklist /S %%a /NH') do echo %%j %%a>>tasklist-baseline0.txt
@echo off
start /wait find-dupl.vbs
if exist tasklist-baseline0.txt del tasklist-baseline0.txt
:END