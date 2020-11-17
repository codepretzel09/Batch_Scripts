for /f %%a in (pclist.txt) do (
	if exist "\\%%a\c$\Program Files (x86)\7-Zip\7z.exe" (
		echo 7-Zip Installed on %%a %date% %time% >>7-Zip-Install-Success-Report.txt
		) ELSE (
		echo 7-Zip NOT Installed on %%a %date% %time% >>7-Zip-Install-Failure-Report.txt
	)
)
pause