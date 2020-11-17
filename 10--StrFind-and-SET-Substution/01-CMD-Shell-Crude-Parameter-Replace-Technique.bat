@echo off
rem setlocal disabledelayedexpansion
goto BEGIN

Use batch.bat currentstring newstring filename.ext
Using find search for empty string and assign line number with /n
Using for loop read in string prior to ] as token 1 and the entirety of the remining string on the line as the second token
Using "if defined", check "str" variable for substance and then call variable substitution ability
Use tilde in final string expansion to remove surrounding quotation marks

:BEGIN
REM Use tilde to expand all three arguments and remove the surrounding quotation marks
REM Use tilde f to expand percent 0 to a fully qualified path name
if "%~1"=="" goto USAGE
if "%~2"=="" goto USAGE
if "%~3"=="" goto USAGE
REM Use find to generate line numbers then set the right bracket of the line numbers as a delim
for /f "tokens=1,* delims=]" %%a in ('"type %3 | find /n /v """') do (
    set "str=%%b"
    if defined str (
	REM Use the set commands environment variable substitution ability
        call set "str=echo.%%str:%~1=%~2%%"
	REM Parse the final output in one more for loop as a string to remove any surrounding quotation marks 
        for /f "delims=" %%c in ('"echo."%%str%%""') do %%~c
    ) else echo.
)
goto :EOF

:USAGE
echo.
echo -----------
echo ^|  USAGE  ^|
echo -----------
echo "%~f0" searchstring newstring filename.ext
