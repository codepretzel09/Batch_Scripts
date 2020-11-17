@echo off
:BEGIN
cls
echo.
echo.
echo Ethernet Adapters Detected
echo --------------------------
if exist %tmp%\tmpEthout del %tmp%\tmpEthout
for /f "tokens=1-2 delims=:" %%a in ('ipconfig ^| find "Ethernet"') do echo "%%a" >>%tmp%\tmpEthout
set count=0
for /f "tokens=1 delims=?" %%a in (%tmp%\tmpEthout) do call :ADAPTERENUM %%a
set count=
:NEXT
echo.
echo.
set /p num=Adapter to Configure (e.g. 1) : 
if %num%==1 set iface="%Adapter1:~18%
if %num%==2 set iface="%Adapter2:~18%
if %num%==3 set iface="%Adapter3:~18%
if %num%==4 set iface="%Adapter4:~18%
if %num%==5 set iface="%Adapter5:~18%
cls
echo.
echo.
:MENU
cls
echo -------------------------------------------------------
echo Configuring: %iface%
echo -------------------------------------------------------
echo.
echo.
echo Configuration Options
echo.
echo.
echo 1 - Set Interface to Use DHCP
echo 2 - Set Interface Using Static Values (One DNS Server)
echo 3 - Set Interface Using Static Values (Two DNS Servers)
echo.
echo.
set /p option=Enter Option Number: 
echo.
echo.
echo Configuring option %option%
echo.
echo.
if %option%==1 goto ONE
if %option%==2 goto TWO
if %option%==3 goto THREE
if %option% NEQ 1 goto ERR
:ONE
cls
echo.
echo.
echo Setting %iface% to DHCP
echo.
echo.
netsh interface ip set address %iface% dhcp
netsh interface ip set dns %iface% dhcp
cls
ping localhost >nul
ipconfig
pause
cls
echo.
echo.
set /p MOORE=Would you like to configure another interface? (Y or N) : 
echo.
echo.
IF %MOORE%==y (
   goto BEGIN
)
IF %MOORE%==Y (
   goto BEGIN
)
goto END
:TWO
cls
echo.
echo.
set /p ipaddr=Enter IP Address: 
set /p mask=Enter Mask Bits: 
set /p gate=Enter Gateway: 
set /p dns=Enter DNS Server: 
echo.
echo.
echo Configuring IP Address: %ipaddr%
echo Configuring Mask Bits: %mask%
echo Configuring Gateway: %gate%
echo Configuring DNS Server: %dns%
echo.
netsh interface ip set address %iface% static %ipaddr% %mask% %gate% 1 
netsh interface ip set dns %iface% static %dns%
cls
ipconfig
pause
cls
echo.
echo.
set /p MOORE=Would you like to configure another interface? (Y or N) : 
echo.
echo.
IF %MOORE%==y (
   goto BEGIN
)
IF %MOORE%==Y (
   goto BEGIN
)
goto END
:THREE
cls
echo.
echo.
set /p ipaddr=Enter IP Address: 
set /p mask=Enter Mask Bits: 
set /p gate=Enter Gateway: 
set /p dns=Enter Primary DNS Server: 
set /p dns2=Enter Secondary DNS Server: 
echo.
echo.
echo Configuring IP Address: %ipaddr%
echo Configuring Mask Bits: %mask%
echo Configuring Gateway: %gate%
echo Configuring Primary DNS Server: %dns%
echo Configuring Secondary DNS Server: %dns2%
echo.
echo.
netsh interface ip set address %iface% static %ipaddr% %mask% %gate% 1 
netsh interface ip set dns %iface% static %dns%
netsh interface ip add dns %iface% %dns2%
cls
ipconfig
pause
cls
echo.
echo.
set /p MOORE=Would you like to configure another interface? (Y or N) : 
echo.
echo.
IF %MOORE%==y (
   goto BEGIN
)
IF %MOORE%==Y (
   goto BEGIN
)
goto END
:ERR
echo.
echo.
echo Unknown Option Entered. Choose Option 1,2 or 3.
echo.
echo.
pause
cls
goto MENU
:END
exit

:ADAPTERENUM
set /a count+=1
set Adapter%count%=%1 && echo Adapter%count%=%1