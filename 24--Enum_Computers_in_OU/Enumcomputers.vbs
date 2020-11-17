Option Explicit 
Dim objOU, objComputer 

' Bind to OU with Distinguished Name. 
Set objOU = GetObject("LDAP://ou=test,dc=script,dc=local") 


' Filter on objects of class computer. 
objOU.Filter = Array("computer") 


' Enumerate computer objects. 
For Each objComputer In objOU 
    ' Output Distinguished Name of computer. 
    Wscript.Echo objComputer.distinguishedName 
Next 
