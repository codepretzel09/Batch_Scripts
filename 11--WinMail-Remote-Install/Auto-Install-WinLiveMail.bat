@echo off
for /f %%a in (pclist.txt) do (
	copy /Y wlsetup-all.exe \\%%a\c$\windows\temp
	psexec /accepteula \\%%a -d -h -s c:\windows\temp\wlsetup-all.exe /AppSelect:ALL!,Mail /q /NOhomepage /nolaunch /Nosearch /noMU
)
pause