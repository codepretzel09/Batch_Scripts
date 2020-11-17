@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
cls

:MENU01
color 06
MODE CON: COLS=90 LINES=30
echo.
echo ====================MENU01=========================
echo.
for /f "tokens=1,2,* delims=_ " %%a in ('"findstr /b /c:":MENU01_" "%~f0""') do echo. [%%b] %%c
echo.
echo ====================MENU01=========================
echo.
set /p item=Select Menu Item: || GOTO ERRSELECT1
cls
echo.
goto MENU01_%item%

:MENU01_A This is MENU Item "A"
cls
MODE CON: COLS=40 LINES=11
echo.
echo.
echo    ###    
echo   ## ##   
echo  ##   ##  
echo ##     ## 
echo ######### 
echo ##     ## 
echo ##     ## 
echo.
echo.
pause
cls
GOTO MENU01

:MENU01_H   This is MENU Item "H"
cls
MODE CON: COLS=40 LINES=10
echo.
echo  _    _ ______ _      _      ____  
echo ^| ^|  ^| ^|  ____^| ^|    ^| ^|    / __ \ 
echo ^| ^|__^| ^| ^|__  ^| ^|    ^| ^|   ^| ^|  ^| ^|
echo ^|  __  ^|  __^| ^| ^|    ^| ^|   ^| ^|  ^| ^|
echo ^| ^|  ^| ^| ^|____^| ^|____^| ^|___^| ^|__^| ^|
echo ^|_^|  ^|_^|______^|______^|______\____/ 
echo.
echo.
pause
cls
GOTO MENU01

:MENU01_N   Next MENU02
goto MENU02

:MENU01_Q   QUIT
goto :END

REM ##################################################

:MENU02
color 02
MODE CON: COLS=90 LINES=30
echo.
echo ====================MENU02=========================
echo.
for /f "tokens=1,2,* delims=_ " %%a in ('"findstr /b /c:":MENU02_" "%~f0""') do echo. [%%b] %%c
echo.
echo ====================MENU02=========================
echo.
set /p item=Select Menu Item: || GOTO ERRSELECT2
cls
echo.
goto MENU02_%item%

:MENU02_S   This is MENU Item "S"
cls
color FC
MODE CON: COLS=80 LINES=45
echo.
echo              MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM               
echo            ~MD                                                  MM             
echo           MM                                                     MM            
echo         MM~    MMMMMMM         MMMMMMMMMMM:        MMMMMM     M    MM          
echo        MM    MMMMMMI       MMMMMMMMMMMMMMMMMMM      ,MMMM     MM    MM         
echo      ZM?    MMMMMM      =MMMMMMMMMMMMMMMMMMMMMMM      MM      MMMZ    MM       
echo     MM    MMMMMM       MMMMMMMMMMMMMMMMMMMMMMMMMMM            MMMMM    MM:     
echo   MM.   .MMMMMM.       MMMMMMMMMMMMMMMMMMMMMMMMMMM:           MMMMMMM    MM    
echo  MM    MMMMMMM         MMMMMMMMMMMMMMMMMMMMMMMMMMMM           MMMMMMMM  . +MZ  
echo MM     MMMMMM.          MMMMMMMMMMMMMMMMMMMMMMMMMMMDDDDDDDDDDDMMMMMMMM$    MM  
echo   MM    MMMMM             +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    .MO   
echo    MM    :MM8                              .  ,IMMMMMMMMMMMMMMMMMMMM    MM     
echo     +M=    M~                                          MMMMMMMMMMM     MM.     
echo       MM    7                                             MMMMMMM .  ZM.       
echo        MM                                                  $MMMM    MM         
echo         ?M~                                                  M     MM          
echo           MM    Z                                                $M,           
echo            MM     MMMMMMNI:.                                    MM             
echo              MM    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMZ             MM.             
echo               MM    ?MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM        7M,               
echo                MM     MMMMM,  ,MMMMMMMMMMMMMMMMMMMMMMM    . MM                 
echo                  MN    MM          MMMMMMMMMMMMMMMMMM      MM                  
echo                   MM   .             MMMMMMMMMMMM+       MM.                   
echo                    OM.                                  MM                     
echo                      M8                                MM                      
echo                       MM     8        .       ~MD    MM                        
echo                        OM.    MMMMMMMMMMMMMMMMM     MM                         
echo                         .MM    .MMMMMMMMMMMMMM    ~M+                          
echo                           MM  .  MMMMMMMMMMM.    MM                            
echo                            NM     MMMMMMMMM     MM                             
echo                              MM     MMMMMM    :M?                              
echo                               MM     MMM     MM                                
echo                                :MI    7     MM                                 
echo                                  MM       DM                                   
echo                                   MM  .  MM                                    
echo                                    :M?  MM                                     
echo                                      MMM                                       
echo                                       M    
echo.
echo.
pause
cls
GOTO MENU02
                                    


:MENU02_R   This is MENU Item "R"
cls
MODE CON: COLS=40 LINES=10
echo.
echo  _____  
echo ^|  __ \ 
echo ^| ^|__) ^|
echo ^|  _  / 
echo ^| ^| \ \ 
echo ^|_^|  \_\
echo.
echo.
pause
cls
GOTO MENU02

:MENU02_P   Previous MENU01
goto MENU01

:MENU02_Q   QUIT
goto :END

REM ##################################################

:ERRSELECT1
cls
color 4F
echo.
echo.
echo MENU SELECTION NOT RECOGNIZED
echo.
echo PLEASE CHOOSE AGAIN
echo.
echo.
pause
color 07
cls
goto :MENU01

:ERRSELECT2
cls
color 4F
echo.
echo.
echo MENU SELECTION NOT RECOGNIZED
echo.
echo PLEASE CHOOSE AGAIN
echo.
echo.
pause
color 07
cls
goto :MENU02

:END
color 07
MODE CON: COLS=30 LINES=15
cls
for /l %%a in (5,-1,1) do (
	echo Quitting in... %%a
	timeout /T 1 /NOBREAK >nul
)
echo.
echo Goodbye
timeout /T 3 /NOBREAK >nul
goto :EOF


