@echo off
goto BEGIN

Use 7zip to create a compressed archive of the files in the c:\storage folder and assign an AES 256bit encrypted password to the archive.
Use string expansion and substring expansion.
Use ~ in string expansion to begin at the ## offset

:BEGIN
if not exist c:\archive md c:\archive
"c:\program files (x86)\7-Zip\7z" a -pstudent -tzip -mem=AES256 c:\archive\storage-%date:~4,2%-%date:~7,2%-%date:~10,4%_%time:~0,2%-%time:~3,2%-%time:~6,2%--%time:~9,2%.zip c:\storage
if %errorlevel% equ 0 goto CLEANUP
goto ERROR
:CLEANUP
cd /d c:\storage && del * /F /Q /S
call :CPYNREN
goto BEGIN
goto :EOF
:ERROR
echo 7z Archive Failure %date% %time% >>7z-Archive-err.txt
goto :EOF
pause

:CPYNREN
echo.
echo. 3 Second Nap
echo.
timeout /t 3 /nobreak>nul
if not exist c:\storage cd \ && mkdir storage
for /f "tokens=1,2,3,4,5,6,7,8,9* delims=/:\ " %%a in ('dir /q c:\inetpub\ftproot\*.* ^| findstr "bob jay tom"') do (
	copy "%systemdrive%\inetpub\ftproot\%%j" "c:\storage\%%i--%%j"
)
