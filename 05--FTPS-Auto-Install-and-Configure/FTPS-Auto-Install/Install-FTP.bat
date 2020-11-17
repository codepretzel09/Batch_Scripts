@echo off
cls
set installdrive=%CD%

START /WAIT DISM /Online /Enable-Feature /FeatureName:IIS-Metabase /FeatureName:IIS-WMICompatibility /FeatureName:IIS-LegacyScripts /FeatureName:IIS-IIS6ManagementCompatibility /FeatureName:IIS-ManagementScriptingTools /FeatureName:IIS-WebServerManagementTools /FeatureName:IIS-WebServerRole /FeatureName:IIS-FTPExtensibility /FeatureName:IIS-FTPServer /FeatureName:IIS-FTPSvc /FeatureName:IIS-ManagementConsole /FeatureName:IIS-ManagementService

netsh advfirewall firewall set rule group="FTP Server" new enable="yes"
netsh advfirewall firewall add rule name="FTP SSL" action=allow protocol=TCP dir=in localport=21
netsh advfirewall firewall add rule name="FTP for IIS7.5" service=ftpsvc action=allow protocol=TCP dir=in
netsh advfirewall set global StatefulFtp disable

net user bob Student99 /add /fullname:"Bob Boberson" /comment:"Field Agent" /times:M-Su,4-1
net user tom Student99 /add /fullname:"Tom Thompson" /comment:"Field Agent" /times:M-Su,4-1
net user jay Student99 /add /fullname:"Jay Jaquish" /comment:"Field Agent" /times:M-Su,4-1

c:\windows\system32\inetsrv\appcmd.exe add site /name:"Drop" /bindings:ftp://*:21 /physicalpath:c:\inetpub\ftproot
c:\windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/sites /[name='Drop'].ftpServer.security.ssl.controlChannelPolicy:"SslRequire"
c:\windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/sites /[name='Drop'].ftpServer.security.ssl.dataChannelPolicy:"SslRequire"
c:\windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/sites /[name='Drop'].ftpServer.security.authentication.basicAuthentication.enabled:true
c:\windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/sites /[name='Drop'].ftpServer.security.authentication.anonymousAuthentication.enabled:false
c:\windows\system32\inetsrv\appcmd.exe set config "Drop" -section:system.ftpServer/security/authorization /+"[accessType='Allow',users='bob',permissions='Read, Write']" /commit:apphost
c:\windows\system32\inetsrv\appcmd.exe set config "Drop" -section:system.ftpServer/security/authorization /+"[accessType='Allow',users='tom',permissions='Read, Write']" /commit:apphost
c:\windows\system32\inetsrv\appcmd.exe set config "Drop" -section:system.ftpServer/security/authorization /+"[accessType='Allow',users='jay',permissions='Read, Write']" /commit:apphost

echo Y | %installdrive%\SelfSSL7 /N:CN=%computername% /K 2048 /V 3600 /T
certutil -store my | findstr /C:"Cert Hash(sha1):" >%tmp%\mycerthash-tmp.txt
for /f "tokens=1-22 delims= " %%a in (%tmp%\mycerthash-tmp.txt) do (
   set mysslhash=%%c%%d%%e%%f%%g%%h%%i%%j%%k%%l%%m%%n%%o%%p%%q%%r%%s%%t%%u%%v
)
c:\windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/sites /[name='Drop'].ftpServer.security.ssl.serverCertHash:"%mysslhash%" /commit:apphost 

cacls c:\inetpub\ftproot /G Users:W /T /E
cacls c:\inetpub\ftproot /G Users:R /T /E

net stop ftpsvc
net start ftpsvc

echo.
echo When configuring FTPS clients, use Explicit FTP over SSL
echo.
pause
GOTO :EOF


REM cacls c:\inetpub\ftproot /G IUSR:W /T /E
REM cacls c:\inetpub\ftproot /G IUSR:R /T /E
REM netsh advfirewall set global StatefulFtp enable
REM netsh ftp add sslcert ipport=0.0.0.0:21 certhash=ed68f78ca62d979bec48102976da11cf147c615f appid={4dc3e181-e14b-4a21-b022-59fc669b0914}
REM c:\windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/sites /+"[name='Drop'].bindings.[protocol='ftp',bindingInformation='*:21:']" /commit:apphost
REM c:\windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/sites /[name='Drop'].ftpServer.security.ssl.controlChannelPolicy:"SslAllow"
REM c:\windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/sites /[name='Drop'].ftpServer.security.ssl.dataChannelPolicy:"SslAllow"
REM c:\windows\system32\inetsrv\appcmd.exe set config "Drop" -section:system.ftpServer/security/authorization /+"[accessType='Allow',roles='users',permissions='Read, Write']" /commit:apphost
