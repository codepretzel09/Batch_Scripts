@echo off
setlocal
setlocal ENABLEDELAYEDEXPANSION
goto BEGIN

-from <addr>    : the RFC 822 From: statement
-subject <subj> : subject line, surround with quotes to include spaces(also -s)
-bodyF <file>   : file containing the message body
-ps <file>      : final message text, possibly for unsubscribe instructions
-noh2           : prevent X-Mailer header entirely

:BEGIN
for /f %%a in (to.txt) do  (
	echo Sending... %%a
	call :COUNTEM
	blat -to %%a -from user@class.local -subject "Notice from QR Inc." -bodyF body.txt -ps ps.txt -noh2 -q
)
goto :EOF

:COUNTEM
SET /a count+=1
if %count:~-1% equ 0 echo. && echo. Catching My Breath... && echo. && timeout /T 2 /NOBREAK >nul
if %count:~-1% equ 5 echo. && echo. Catching My Breath... && echo. && timeout /T 2 /NOBREAK >nul