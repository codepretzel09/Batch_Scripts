Dim WshArgs, FirstArg, colPingResults, objPingResult, strQuery
Set WshArgs = WScript.Arguments
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objLogFile = objFSO.OpenTextFile("PingFail_Log.txt", 8, True)
FirstArg = WshArgs.Item(0)

strQuery = "SELECT * FROM Win32_PingStatus WHERE Address = '" & FirstArg & "'"
Set colPingResults = GetObject("winmgmts://./root/cimv2").ExecQuery( strQuery )
    For Each objPingResult In colPingResults
        If Not IsObject( objPingResult ) Then
	    Wscript.Echo vbLF
	    objLogFile.Write "Error Pinging " & FirstArg & " " & Date & " " & Time & vbCRLF
	    objLogFile.Close
        ElseIf objPingResult.StatusCode = 0 Then
	    Set objWMIService = GetObject("winmgmts:\\" & FirstArg & "\root\cimv2")
	    Set colAccounts = objWMIService.ExecQuery ("Select * From Win32_UserAccount Where LocalAccount = TRUE")
		For Each objAccount in colAccounts
    			If Left (objAccount.SID, 6) = "S-1-5-" and Right(objAccount.SID, 4) = "-500" Then
        			Wscript.Echo objAccount.Name
			End If
		Next	
        Else
	    Wscript.Echo vbLF
	    objLogFile.Write "Error Pinging " & FirstArg & " " & Date & " " & Time & vbCRLF
	    objLogFile.Close
        End If
Next
