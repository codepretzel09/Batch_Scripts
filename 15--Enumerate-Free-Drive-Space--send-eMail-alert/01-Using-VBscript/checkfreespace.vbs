'*************************************************************
' Dim and set WshArgs for command line argument/parameter
' Parameter will be the computername, FQDN, or IP of target
'*************************************************************
Dim WshArgs, FirstArg
Set WshArgs = WScript.Arguments
FirstArg = WshArgs.Item(0)

'*************************************************************
' Invoke WMI Query, Connect to Namespace, Select Class
' and Property Values
'*************************************************************
Set DiskSet = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & FirstArg & "\root\cimv2").ExecQuery ("select FreeSpace,Size,Name from Win32_LogicalDisk where DriveType=3")

'*************************************************************
' For Each Loop to parse DiskSet and round FreeSpace, if space
' is less than 20 percent then send e-mail
'*************************************************************
For each Disk in DiskSet
wscript.echo Disk.Name & round(Disk.FreeSpace/1073741824,0)
	If (Disk.FreeSpace/Disk.Size) < 0.20 Then
wscript.echo (Disk.FreeSpace/Disk.Size)
Set objEmail = CreateObject("CDO.Message")
objEmail.From = "scot@class.local"
objEmail.To = "user@class.local"
objEmail.Subject = "Low Drive Space on " & FirstArg
objEmail.Textbody = "Drive " + Disk.Name + " on " + FirstArg + " is low on disk space. " & round(Disk.FreeSpace/1073741824,0) & " GB remaining."
objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "10.10.200.2"
objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
objEmail.Configuration.Fields.Update
objEmail.Send
	End If
Next
