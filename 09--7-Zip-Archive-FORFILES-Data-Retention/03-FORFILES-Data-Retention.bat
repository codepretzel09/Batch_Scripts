@echo off
goto TESTIT

:TESTIT
forfiles /D -7 /M *.txt /S /C "cmd /c echo @file"
echo.
echo This was just a test. These are the files I
echo would have deleted.
echo.
pause
goto :EOF

:DOIT
forfiles /D -7 /M *.txt /S /C "cmd /c del /f /q @file"