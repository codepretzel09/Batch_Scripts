@echo off
setlocal enabledelayedexpansion
set installdrive=%CD%
if not exist "%systemroot%\system32\blat.exe" goto INSTALLBLAT
goto BEGIN
rem ***********************************************
rem
rem	BLAT INSTALL ROUTINE
rem
rem ***********************************************
:INSTALLBLAT
cls
copy "%installdrive%\blat.exe" "%systemroot%\system32\blat.exe"
echo.
set /P smtphost=Enter the IP or FQDN Hostname of your Mail Server: 
echo.
blat -install %smtphost% %computername%@class.local

goto BEGIN
rem ***********************************************
rem
rem	CHECK FREE DRIVE SPACE HACK
rem     USING WMIC, BC, and BLAT
rem
rem ***********************************************
:BEGIN
for /f %%a in (pclist.txt) do (
	for /f "skip=1 usebackq tokens=1,2,* delims= " %%i in (`"wmic /node:%%a LogicalDisk Where DeviceID="C:" Get DeviceID,FreeSpace,Size"`) do (
		set "comp=%%a"
		set "drive=%%i"
		set "free=%%j"
		set "size=%%k"
	call :REMOVECR
		if not "!free!"=="" (
			set "freespace=!free!"
			set "fullsize=!size!"
			set "thedrive=!drive!"
			echo !comp! !thedrive! !freespace! !fullsize!
			echo.
				for /f "usebackq tokens=*" %%s in (`"echo !freespace!/!fullsize! ^| bc -l"`) do (
					set "pct1=%%s"
					for /f "usebackq tokens=*" %%w in (`"echo !pct1!*100 ^| bc"`) do (
						set "pct2=%%w"
						call :EMAIL !pct2:~0,2!
						)
					echo There is !pct2:~0,5! percent of space left on the C: Drive of !comp!
				)
			)
		)
	)
echo.
pause
goto :EOF

:REMOVECR
set "free=%free%"
set "size=%size%"
goto :EOF

:EMAIL
if %1 LEQ 20 blat -to user@class.local -from scot@class.local -subject "Low Drive Space on !comp!" -body "There is %pct2:~0,5% percent of space left on the C: Drive of !comp!" -noh2
goto :EOF
