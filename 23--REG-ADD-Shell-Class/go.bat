@echo off
for /f %%a in (pclist.txt) do (
	call :ADDREGKEY %%a
)
pause
goto :EOF

:ADDREGKEY
echo Adding Registry Key to %1
REG ADD "\\%1\HKLM\SOFTWARE\Classes\Folder\Shell\Open CMD Shell Here\command" /ve /t REG_SZ /d "%COMSPEC% /k pushd %%1" /f >>REG_ADD_Results.log 2>&1 
	if /i %errorlevel% equ 0 (
		echo REG ADD to %1 was a success %date:~4% %time%>>REG_ADD_Results.log
		echo. >>REG_ADD_Results.log
		echo SUCCESS
		echo.
		) else (
		echo FAILED!!! REG ADD to %1 %date:~4% %time%>>REG_ADD_Results.log
		echo. >>REG_ADD_Results.log
		echo FAILED!!!
		echo.
)
