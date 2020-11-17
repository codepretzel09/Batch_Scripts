@ECHO OFF
SETLOCAL
SET INSTALLDRIVE=%CD%
REM ***********************************************
REM
REM	CHECK TO SEE IF THE IMAGEMAGIC FOLDER ALREADY
REM	EXISTS. SLASH NUL IS AN OLD DOS TECHNIQUE
REM	USED TO CHECK EXCLUSIVELY FOR A FOLDER
REM	INSTEAD OF A FILE.
REM
REM ***********************************************
IF EXIST %systemdrive%\ImageMagick\nul GOTO ERROR0

REM ***********************************************
REM
REM	INSTALL IMAGEMAGICK BINARIES BY EXTRACTING
REM	THEM TO THE IMAGEMAGICK FOLDER IN THE
REM	ROOT OF THE SYSTEM DRIVE.
REM
REM ***********************************************
CD /d "%INSTALLDRIVE%"
unzip ImageMagick.zip -d %systemdrive%\
IF NOT ERRORLEVEL 0 GOTO ERROR1
goto :DONE

:ERROR0
ECHO.
ECHO.
ECHO It appears that %systemdrive%\ImageMagick already
ECHO exists.
ECHO.
ECHO.
pause
goto :EOF

:ERROR1
ECHO.
ECHO.
ECHO Error extracting with: unzip ImageMagick.zip -d %systemdrive%\
ECHO Check source and destination
ECHO.
ECHO.
pause
goto :EOF

:DONE
ECHO.
ECHO.
ECHO. ImageMagick install/extraction completed.
ECHO.
ECHO.
pause

