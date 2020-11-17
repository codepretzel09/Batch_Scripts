for /f %%a in (pclist.txt) do (
	if exist "\\%%a\c$\Perl64\bin\perl.exe" (
		copy /y 03b-Auto-Configure-ftype2.bat \\%%a\c$\windows\temp
		psexec /accepteula \\%%a -d -h -s c:\windows\temp\03b-Auto-configure-ftype2.bat
		) ELSE (
		echo Perl not instaled on %%a %date% %time% >>Perl-Failure-Report.txt
	)
)
pause
