@echo off
cls
set installdrive=%CD%

rem ***********************************************
rem This command will install IIS on Win7
rem ***********************************************

START /WAIT DISM /Online /Enable-Feature /FeatureName:IIS-ApplicationDevelopment /FeatureName:IIS-ASP /FeatureName:IIS-ASPNET /FeatureName:IIS-BasicAuthentication /FeatureName:IIS-CGI /FeatureName:IIS-ClientCertificateMappingAuthentication /FeatureName:IIS-CommonHttpFeatures /FeatureName:IIS-CustomLogging /FeatureName:IIS-DefaultDocument /FeatureName:IIS-DigestAuthentication /FeatureName:IIS-DirectoryBrowsing /FeatureName:IIS-FTPExtensibility /FeatureName:IIS-FTPServer /FeatureName:IIS-FTPSvc /FeatureName:IIS-HealthAndDiagnostics /FeatureName:IIS-HostableWebCore /FeatureName:IIS-HttpCompressionDynamic /FeatureName:IIS-HttpCompressionStatic /FeatureName:IIS-HttpErrors /FeatureName:IIS-HttpLogging /FeatureName:IIS-HttpRedirect /FeatureName:IIS-HttpTracing /FeatureName:IIS-IIS6ManagementCompatibility /FeatureName:IIS-IISCertificateMappingAuthentication /FeatureName:IIS-IPSecurity /FeatureName:IIS-ISAPIExtensions /FeatureName:IIS-ISAPIFilter /FeatureName:IIS-LegacyScripts /FeatureName:IIS-LegacySnapIn /FeatureName:IIS-LoggingLibraries /FeatureName:IIS-ManagementConsole /FeatureName:IIS-ManagementScriptingTools /FeatureName:IIS-ManagementService /FeatureName:IIS-Metabase /FeatureName:IIS-NetFxExtensibility /FeatureName:IIS-ODBCLogging /FeatureName:IIS-Performance /FeatureName:IIS-RequestFiltering /FeatureName:IIS-RequestMonitor /FeatureName:IIS-Security /FeatureName:IIS-ServerSideIncludes /FeatureName:IIS-StaticContent /FeatureName:IIS-URLAuthorization /FeatureName:IIS-WebDAV /FeatureName:IIS-WebServer /FeatureName:IIS-WebServerManagementTools /FeatureName:IIS-WebServerRole /FeatureName:IIS-WindowsAuthentication /FeatureName:IIS-WMICompatibility /FeatureName:WAS-ConfigurationAPI /FeatureName:WAS-NetFxEnvironment /FeatureName:WAS-ProcessModel /FeatureName:WAS-WindowsActivationService

rem ***********************************************
rem Installing vcredist_x86
rem ***********************************************

vcredist_x86.exe /q

rem ***********************************************
rem If 64-bit, use the syswow64 odbc utility (below) to add the DSN connector, not the ODBC MMC in the Administrative Tools
rem c:\windows\syswow64\odbcad32.exe
rem ***********************************************

rem ***********************************************
rem Install PHP and phpMyAdmin
rem ***********************************************

if not exist c:\inetpub\wwwroot\PHPSite mkdir c:\inetpub\wwwroot\PHPSite
copy default.php c:\inetpub\wwwroot\PHPSite
unzip.exe phpMyAdmin.zip -d C:\inetpub\wwwroot\PHPSite
unzip.exe php.zip -d c:\

rem ***********************************************
rem Configure FastCGI 
rem ***********************************************

%windir%\system32\inetsrv\appcmd.exe set config /section:system.webServer/fastCGI /+[fullPath='c:\php\php-cgi.exe'] 
%windir%\system32\inetsrv\appcmd.exe set config /section:system.webServer/handlers /+[name='PHP_via_FastCGI',path='*.php',verb='*',modules='FastCgiModule',scriptProcessor='c:\php\php-cgi.exe',resourceType='Either'] 
%windir%\system32\inetsrv\appcmd.exe set config /section:system.webServer/fastCgi /[fullPath='c:\php\php-cgi.exe'].instanceMaxRequests:10000 
%windir%\system32\inetsrv\appcmd.exe set config /section:system.webServer/fastCgi /+"[fullPath='C:\php\php-cgi.exe'].environmentVariables.[name='PHP_FCGI_MAX_REQUESTS',value='10000']" 

rem ***********************************************
rem Create PHPApp Application Pool 
rem ***********************************************

%windir%\system32\inetsrv\appcmd.exe set config /section:system.applicationHost/applicationPools /+"[name='PHPApp',autoStart='True',managedPipelineMode='Integrated']" /commit:apphost 
%windir%\system32\inetsrv\appcmd.exe set config /section:applicationPools /[name='PHPApp'].processModel.identityType:LocalService 

rem ***********************************************
rem Create PHPApp Site 
rem ***********************************************

%windir%\system32\inetsrv\appcmd.exe stop SITE "Default Web Site" 
%windir%\system32\inetsrv\appcmd.exe delete SITE "PHPApp" 
%windir%\system32\inetsrv\appcmd.exe add SITE /name:PHPApp /id:100 /bindings:http/*:80: /physicalPath:c:\inetpub\wwwroot\PHPSite
%windir%\system32\inetsrv\appcmd.exe set site /site.name:PHPApp /applicationDefaults.applicationPool:PHPApp 
%windir%\system32\inetsrv\appcmd.exe start SITE "PHPApp" 

rem ***********************************************
rem Set Default Document to default.php
rem ***********************************************

%windir%\system32\inetsrv\appcmd.exe set config /section:system.webServer/defaultDocument /~files /commit:apphost 
%windir%\system32\inetsrv\appcmd.exe set config /section:system.webServer/defaultDocument /+"files.[value='default.php']" /commit:apphost 

rem ***********************************************
rem MySQL Install Stuff
rem ***********************************************

set mysql_msi="%installdrive%\mysql-5.5.22-win32.msi"
set mysql_svname=MySQL
set mysql_odbc="%installdrive%\mysql-connector-odbc-5.1.10-win32.msi"
set mysql_datadir="C:\Documents and Settings\All Users\Application Data\MySQL\MySQL Server 5.1\data"
set mysql_data2="C:\Program Files (x86)\MySQL\MySQL Server 5.1\data"
set mysql_cmd="GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'mysql' WITH GRANT OPTION;"
msiexec /i %mysql_msi% /qn INSTALLDIR="C:\Program Files (x86)\MySQL\MySQL Server 5.1\"
"C:\Program Files (x86)\MySQL\MySQL Server 5.1\bin\mysqlinstanceconfig.exe" -i -q ServiceName=MySQL RootPassword=mysql ServerType=DEVELOPMENT DatabaseType=MYISAM Port=3306 RootCurrentPassword=mysql

rem ***********************************************
rem comment next line to prevent root access from any pc...
rem "C:\Program Files (x86)\MySQL\MySQL Server 5.1\bin\mysql.exe" -uroot -pmysql -e %mysql_cmd%
rem ***********************************************

rem ***********************************************
rem MySQL ODBC Connector Install
rem ***********************************************

msiexec /qn /i %mysql_odbc%

rem ***********************************************
rem Create Link to 127.0.0.1 "default.php"
rem ***********************************************
echo [DEFAULT]>"%USERPROFILE%\Favorites\PHPSite.url"
echo BASEURL=http://127.0.0.1/default.php>>"%USERPROFILE%\Favorites\PHPSite.url"
echo [InternetShortcut]>>"%USERPROFILE%\Favorites\PHPSite.url"
echo URL=http://127.0.0.1/default.php>>"%USERPROFILE%\Favorites\PHPSite.url"

rem ***********************************************
rem Create Link to 127.0.0.1 phpMyAdmin\index.php"
rem ***********************************************
echo [DEFAULT]>"%USERPROFILE%\Favorites\phpMyAdmin.url"
echo BASEURL=http://127.0.0.1/phpMyAdmin\index.php>>"%USERPROFILE%\Favorites\phpMyAdmin.url"
echo [InternetShortcut]>>"%USERPROFILE%\Favorites\phpMyAdmin.url"
echo URL=http://127.0.0.1/phpMyAdmin\index.php>>"%USERPROFILE%\Favorites\phpMyAdmin.url"

rem ***********************************************
rem Install DSN Connector Stuff to Registry
rem ***********************************************

regedit /s %installdrive%\MySQL-DSN-64-64bit.reg
regedit /s %installdrive%\MySQL-DSN-WOW6432-64bit.reg

cls
@echo.
@echo Opening Default Browser now...
echo.
@ping localhost
start "" "C:\Program Files (x86)\Internet Explorer\iexplore.exe" http://127.0.0.1/default.php
start "" "C:\Program Files (x86)\Internet Explorer\iexplore.exe" http://127.0.0.1/phpMyAdmin/index.php
cls
echo.
echo The default username for your mysql database is: root
echo The default password for your mysql database is: mysql
echo.
pause
