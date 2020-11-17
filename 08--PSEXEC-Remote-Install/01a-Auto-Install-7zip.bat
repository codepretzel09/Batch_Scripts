for /f %%a in (pclist.txt) do (
	copy /y 7z920.exe \\%%a\c$\windows\temp
	psexec /accepteula \\%%a -d -h -s "c:\windows\temp\7z920.exe" /S
)
pause