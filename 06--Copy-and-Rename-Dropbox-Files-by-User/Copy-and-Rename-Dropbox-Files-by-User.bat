REM
REM This assumes bob, tom, and jay have each uploaded a .txt file to the ftp server
REM
if not exist c:\storage cd \ && mkdir storage
for /f "tokens=1,2,3,4,5,6,7,8,9* delims=/:\ " %%a in ('dir /q c:\inetpub\ftproot\*.* ^| findstr "bob jay tom"') do (
	copy "%systemdrive%\inetpub\ftproot\%%j" "c:\storage\%%i--%%j"
)
pause