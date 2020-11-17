for /f %%a in (pclist.txt) do (
	copy /y ActivePerl-5.16.2.1602-MSWin32-x64-296513.msi \\%%a\c$\windows\temp
	psexec /accepteula \\%%a -d -h -s msiexec /i "c:\windows\temp\ActivePerl-5.16.2.1602-MSWin32-x64-296513.msi" TARGETDIR="%systemdrive%\" PERL_PATH="Yes" /q 
)
pause