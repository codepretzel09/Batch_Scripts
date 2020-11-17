goto TESTONLY

REM -k : Create backups for replaced files
REM -r : Finds and replaces strings (must include <replace string> argument) 

:TESTONLY
strfind.exe" "BARROWS, KIM" "SMITH, KIM  " *.txt
pause
goto :EOF

:DOIT
REM Add two extra spaces after KIM to account for the lost characters
strfind.exe -k -r "BARROWS, KIM" "SMITH, KIM  " *.txt