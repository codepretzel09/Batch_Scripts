Dim objFSO
Dim objStream

Const ForReading = 1

Set objDictionary = CreateObject("Scripting.Dictionary")
Set objFSO = CreateObject("Scripting.FileSystemObject")

outFile1 = CreateObject("Wscript.Shell").ExpandEnvironmentStrings("%SYSTEMDRIVE%")_
            & "\Anomaly-Defense\TaskAnomScan-Network\tasklist-baseline.txt"
outFile2 = CreateObject("Wscript.Shell").ExpandEnvironmentStrings("%SYSTEMDRIVE%")_
            & "\Anomaly-Defense\TaskAnomScan-Network\tasklist-baseline0.txt"


Set objStream = objFSO.CreateTextFile(outFile1, True)

Set objFile = objFSO.OpenTextFile _
    (outFile2, ForReading)

Do Until objFile.AtEndOfStream
    strName = objFile.ReadLine
    If Not objDictionary.Exists(strName) Then
        objDictionary.Add strName, strName
    End If
Loop

objFile.Close

For Each strKey in objDictionary.Keys
   objStream.Writeline strKey
Next





