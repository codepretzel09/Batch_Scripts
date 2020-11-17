@echo off
REM HP LaserJet 4100 Series PCL6
REM
cscript c:\Windows\System32\Printing_Admin_Scripts\en-US\prnport.vbs -a -r IP_10.10.200.6 -h 10.10.200.6
timeout /T 2 /NOBREAK>NUL
rundll32 printui.dll,PrintUIEntry /if /b "HP LaserJet 4100 Series PCL6" /f %windir%\inf\prnhp002.inf /r "IP_10.10.200.6" /m "HP LaserJet 4100 Series PCL6" /Z
pause