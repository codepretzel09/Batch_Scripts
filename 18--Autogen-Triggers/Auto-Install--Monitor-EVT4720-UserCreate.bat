@echo off
rem ***********************************************
rem
rem	SET VARIABLES FOR MAILSERVER, TO, AND FROM
rem	FIELDS
rem
rem ***********************************************
set /p mailserver=Enter the IP or FQDN of your mail server: 
set /p toemail=Enter your e-mail address: 
set fromemail=%computername%@class.local
rem ***********************************************
rem
rem	FOR LOOP, SET TIME/DATE ROUTINE
rem
rem ***********************************************
for /F "tokens=1-3 delims=/" %%a in ("%date:~4%") do (
   set Month=%%a
   set #Day=%%b
   set Year=%%c
)
for /F "tokens=1-4 delims=:." %%a in ("%time%") do (
   set Hour=%%a
   set min=%%b
   set sec=%%c
   set milli=%%d
)
rem ***********************************************
rem
rem	AUTO GENERATE THE XML CONTENT FOR THE
rem	TRIGGER EVENT
rem
rem ***********************************************
echo ^<?xml version="1.0" encoding="UTF-16"?^>>%tmp%\Trig-Usr.xml
echo ^<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task"^>>>%tmp%\Trig-Usr.xml
echo   ^<RegistrationInfo^>>>%tmp%\Trig-Usr.xml
echo     ^<Date^>2013-02-22T09:11:23.946625^</Date^>>>%tmp%\Trig-Usr.xml
echo     ^<Author^>%computername%\%username%^</Author^>>>%tmp%\Trig-Usr.xml
echo   ^</RegistrationInfo^>>>%tmp%\Trig-Usr.xml
echo   ^<Triggers^>>>%tmp%\Trig-Usr.xml
echo     ^<EventTrigger^>>>%tmp%\Trig-Usr.xml
echo       ^<Enabled^>true^</Enabled^>>>%tmp%\Trig-Usr.xml
echo       ^<Subscription^>^&lt;QueryList^&gt;^&lt;Query Id="0" Path="Security"^&gt;^&lt;Select Path="Security"^&gt;*[System[Provider[@Name='Microsoft-Windows-Security-Auditing'] and EventID=4720]]^&lt;/Select^&gt;^&lt;/Query^&gt;^&lt;/QueryList^&gt;^</Subscription^>>>%tmp%\Trig-Usr.xml
echo     ^</EventTrigger^>>>%tmp%\Trig-Usr.xml
echo   ^</Triggers^>>>%tmp%\Trig-Usr.xml
echo   ^<Principals^>>>%tmp%\Trig-Usr.xml
echo     ^<Principal id="Author"^>>>%tmp%\Trig-Usr.xml
echo       ^<UserId^>%computername%\%username%^</UserId^>>>%tmp%\Trig-Usr.xml
echo       ^<LogonType^>S4U^</LogonType^>>>%tmp%\Trig-Usr.xml
echo       ^<RunLevel^>LeastPrivilege^</RunLevel^>>>%tmp%\Trig-Usr.xml
echo     ^</Principal^>>>%tmp%\Trig-Usr.xml
echo   ^</Principals^>>>%tmp%\Trig-Usr.xml
echo   ^<Settings^>>>%tmp%\Trig-Usr.xml
echo     ^<IdleSettings^>>>%tmp%\Trig-Usr.xml
echo      ^<Duration^>PT10M^</Duration^>>>%tmp%\Trig-Usr.xml
echo       ^<WaitTimeout^>PT1H^</WaitTimeout^>>>%tmp%\Trig-Usr.xml
echo       ^<StopOnIdleEnd^>true^</StopOnIdleEnd^>>>%tmp%\Trig-Usr.xml
echo       ^<RestartOnIdle^>false^</RestartOnIdle^>>>%tmp%\Trig-Usr.xml
echo     ^</IdleSettings^>>>%tmp%\Trig-Usr.xml
echo     ^<MultipleInstancesPolicy^>IgnoreNew^</MultipleInstancesPolicy^>>>%tmp%\Trig-Usr.xml
echo     ^<DisallowStartIfOnBatteries^>true^</DisallowStartIfOnBatteries^>>>%tmp%\Trig-Usr.xml
echo     ^<StopIfGoingOnBatteries^>true^</StopIfGoingOnBatteries^>>>%tmp%\Trig-Usr.xml
echo     ^<AllowHardTerminate^>true^</AllowHardTerminate^>>>%tmp%\Trig-Usr.xml
echo     ^<StartWhenAvailable^>false^</StartWhenAvailable^>>>%tmp%\Trig-Usr.xml
echo     ^<RunOnlyIfNetworkAvailable^>false^</RunOnlyIfNetworkAvailable^>>>%tmp%\Trig-Usr.xml
echo     ^<AllowStartOnDemand^>true^</AllowStartOnDemand^>>>%tmp%\Trig-Usr.xml
echo     ^<Enabled^>true^</Enabled^>>>%tmp%\Trig-Usr.xml
echo     ^<Hidden^>false^</Hidden^>>>%tmp%\Trig-Usr.xml
echo     ^<RunOnlyIfIdle^>false^</RunOnlyIfIdle^>>>%tmp%\Trig-Usr.xml
echo     ^<WakeToRun^>false^</WakeToRun^>>>%tmp%\Trig-Usr.xml
echo    ^<ExecutionTimeLimit^>P3D^</ExecutionTimeLimit^>>>%tmp%\Trig-Usr.xml
echo     ^<Priority^>7^</Priority^>>>%tmp%\Trig-Usr.xml
echo   ^</Settings^>>>%tmp%\Trig-Usr.xml
echo   ^<Actions Context="Author"^>>>%tmp%\Trig-Usr.xml
echo     ^<SendEmail^>>>%tmp%\Trig-Usr.xml
echo       ^<Server^>%mailserver%^</Server^>>>%tmp%\Trig-Usr.xml
echo       ^<Subject^>A User Account Was Created on %computername%^</Subject^>>>%tmp%\Trig-Usr.xml
echo       ^<To^>%toemail%^</To^>>>%tmp%\Trig-Usr.xml
echo       ^<From^>%fromemail%^</From^>>>%tmp%\Trig-Usr.xml
echo       ^<Body^>A User Account Was Created on %computername%^</Body^>>>%tmp%\Trig-Usr.xml
echo       ^<HeaderFields /^>>>%tmp%\Trig-Usr.xml
echo     ^</SendEmail^>>>%tmp%\Trig-Usr.xml
echo   ^</Actions^>>>%tmp%\Trig-Usr.xml
echo ^</Task^>>>%tmp%\Trig-Usr.xml
rem ***********************************************
rem
rem	USER SCHTASKS TO CREATE THE TRIGGER BY
rem	READING IN THE XML FILE
rem
rem ***********************************************
cls
echo.
schtasks /create /TN "Monitor Creation of User Accounts" /XML %tmp%\Trig-Usr.xml /RU SYSTEM
schtasks /query /TN "Monitor Creation of User Accounts"
echo.
pause
rem ***********************************************
rem
rem	TMP FILE CLEANUP
rem
rem ***********************************************
del /F /Q %tmp%\Trig-Usr.xml
rem ***********************************************
rem
rem	PROMPT USER TO AUTOMATICALLY CREATE A
rem	RANDOM USER ACCOUNT TO TEST THE TRIGGER
rem
rem ***********************************************
cls
echo.
set /p doyou=Would you like me to create a new user account to test your Trigger? (Y or N): 
IF %doyou%==y (
   goto CREATEACCOUNT
)
IF %doyou%==Y (
   goto CREATEACCOUNT
)
goto NEXT
:CREATEACCOUNT
cls
echo.
net user TESTUSER%random% StuDenT%random% /add
echo.
echo.
echo You may now check your E-Mail for the Trigger Event
echo.
echo.
pause
:NEXT
goto :EOF

REM schtasks /Create /TN MonitorEVT4720 /TR c:\windows\system32\calc.exe /RU "SYSTEM" /SC ONEVENT /EC Security /MO *[System/EventID=4720]




