@echo off

if not exist .\Archive md .\Archive
if exist .\Success_Log.txt move .\Success_Log.txt .\Archive\Success_log-%date:~4,2%-%date:~7,2%-%date:~10,4%_%time:~,2%-%time:~3,2%-%time:~6,2%.%time:~9,2%.txt
if exist .\Full_Log.txt move .\Full_Log.txt .\Archive\Full_log-%date:~4,2%-%date:~7,2%-%date:~10,4%_%time:~,2%-%time:~3,2%-%time:~6,2%.%time:~9,2%.txt
if exist .\Failure_Log.txt move .\Failure_Log.txt .\Archive\Failure_log-%date:~4,2%-%date:~7,2%-%date:~10,4%_%time:~,2%-%time:~3,2%-%time:~6,2%.%time:~9,2%.txt
if exist .\PingFail_Log.txt move .\PingFail_Log.txt .\Archive\PingFail_log-%date:~4,2%-%date:~7,2%-%date:~10,4%_%time:~,2%-%time:~3,2%-%time:~6,2%.%time:~9,2%.txt

set pword=Student99
for /f %%a in (pclist.txt) do (
	echo Running cscript //Nologo //T:5 Enum-Local-Administrator.vbs %%a
	for /f %%j in ('cscript //Nologo //T:5 Enum-Local-Administrator.vbs %%a') do (
		if not %%j=="" call :CHANGEPWD %%a %%j %pword%
	)
)
pause
goto :EOF
:CHANGEPWD
echo Running pspasswd.exe /accepteula \\%1 %2 %3
pspasswd.exe /accepteula \\%1 %2 %3 >>Full_Log.txt 2>&1
if /i %errorlevel% equ 0 echo %1\%2 account password changed to %3 on %date% %time% >>Success_Log.txt
if /i %errorlevel% neq 0 echo ERROR!!! %1\%2 account password was NOT changed to %3 on %date% %time% >>Failure_Log.txt
