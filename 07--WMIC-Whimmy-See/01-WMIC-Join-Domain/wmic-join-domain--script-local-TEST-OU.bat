wmic.exe /interactive:off ComputerSystem Where "name = '%computername%'" call JoinDomainOrWorkgroup "OU=test;DC=script;DC=local", 3, "script.local", "Student99", "administrator@script.local"
@choice /T 60 /D Y /C YC /M "Type Y to reboot, C to cancel."
@if %errorlevel% EQU 1 goto SHUT
@goto :EOF
:SHUT
shutdown /r /t 6 /c "Rebooting after Joining Domain" /f /d p:2:4