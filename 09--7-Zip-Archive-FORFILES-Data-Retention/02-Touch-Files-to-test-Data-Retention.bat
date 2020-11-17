@echo off
goto BEGIN

using touch -t 201002101245.55 test.bob
for /l %%a in (1,1,9) do touch -t %date:~10,4%%date:~4,2%0%%a1245.55 file0%%a.txt
for /l %%a in (10,1,28) do touch -t %date:~10,4%%date:~4,2%%%a1245.55 file%%a.txt
forfiles /D -7 /M *.txt /S /C "cmd /c echo @file"


:BEGIN
if not exist C:\gnuwin32\bin\touch.EXE goto ERR%errorlevel%
if %date:~7,2% LEQ 8 goto GUARANTEE
if %date:~7,2% LEQ 9 (
  goto NINE
   ) else (
    goto TEN
)
:GUARANTEE
for /l %%a in (20,1,31) do touch -t 201301%%a1245.55 file%%a.txt
for /l %%a in (1,1,%date:~7,2%) do touch -t %date:~10,4%%date:~4,2%0%%a1245.55 file0%%a.txt
goto :EOF

:NINE
for /l %%a in (1,1,%date:~7,2%) do touch -t %date:~10,4%%date:~4,2%0%%a1245.55 file0%%a.txt
goto :EOF

:TEN
for /l %%a in (1,1,9) do touch -t %date:~10,4%%date:~4,2%0%%a1245.55 file0%%a.txt
for /l %%a in (10,1,%date:~7,2%) do touch -t %date:~10,4%%date:~4,2%%%a1245.55 file%%a.txt
goto :EOF

:ERR0
cls
echo.
echo C:\gnuwin32\bin\touch.EXE MISSING!
echo.
pause
goto :EOF