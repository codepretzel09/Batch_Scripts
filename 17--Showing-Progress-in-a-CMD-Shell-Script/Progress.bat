@echo off
set prog=0
start /min "CUSTOMSCRIPT" cmd /c timeout /T 15 /NOBREAK>nul
:CHECKSTAT
tasklist /V | findstr "CUSTOMSCRIPT">nul
goto ANSWER%ERRORLEVEL%

:ANSWER0
cls
set newdot=.%newdot%
set /a prog+=1
title %prog% Seconds Elapsed
echo.
echo Running start /min "CUSTOMSCRIPT" cmd /c timeout /T 15 /NOBREAK
echo.
echo %newdot%%prog% Seconds Elapsed
timeout /T 1 /NOBREAK>nul
goto CHECKSTAT

:ANSWER1
echo.
echo All Done!
echo.
pause
