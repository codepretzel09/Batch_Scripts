@ECHO OFF
SETLOCAL
SET INSTALLDRIVE=%CD%
REM ***********************************************
REM
REM	CHECK TO SEE IF THE GNUWIN32 FOLDER ALREADY
REM	EXISTS. SLASH NUL IS AN OLD DOS TECHNIQUE
REM	USED TO CHECK EXCLUSIVELY FOR A FOLDER
REM	INSTEAD OF A FILE.
REM
REM ***********************************************
IF EXIST %systemdrive%\gnuwin32\nul GOTO ERROR0

REM ***********************************************
REM
REM	INSTALL GNUWIN32 BINARIES BY EXTRACTING
REM	THEM TO THE GNUWIN32 FOLDER IN THE
REM	ROOT OF THE SYSTEM DRIVE.
REM
REM ***********************************************
CD /d "%INSTALLDRIVE%"
unzip gnuwin32.zip -d %systemdrive%\
IF NOT ERRORLEVEL 0 GOTO ERROR1

REM ***********************************************
REM
REM	USE SETX TO APPEND C:\GNUWIN32\BIN TO THE
REM	CURRENT PATH VARIABLE.
REM
REM ***********************************************
SETX PATH "%PATH%;C:\gnuwin32\bin" /M
IF NOT ERRORLEVEL 0 GOTO ERROR2
GOTO DONE

:ERROR0
ECHO.
ECHO.
ECHO It appears that %systemdrive%\gnuwin32 already
ECHO exists.
ECHO.
ECHO.
pause
goto :EOF

:ERROR1
ECHO.
ECHO.
ECHO Error extracting with: unzip gnuwin32.zip -d %systemdrive%\
ECHO Check source and destination
ECHO.
ECHO.
pause
goto :EOF

:ERROR2
ECHO.
ECHO.
ECHO Error adding C:\gnuwin32\bin to path statement. 
ECHO Check that SETX exists.
ECHO.
ECHO.
pause
goto :EOF

:DONE
ECHO.
ECHO.
ECHO. GNUWIN32 install completed.
ECHO.
ECHO.
pause

