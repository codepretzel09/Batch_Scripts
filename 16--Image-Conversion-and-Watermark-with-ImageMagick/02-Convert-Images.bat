@echo off
REM
REM Place this batch file into the folder with the .JPG files you wish to convert
REM
@echo on
if not exist "%cd%\Converted" md "%cd%\converted"
for %%a in (*.JPG) do C:\ImageMagick\convert.exe -sample 638x479 %%a "%cd%\converted\638x479--%%a"
@echo off
echo.
pause
start "" "%cd%\converted"