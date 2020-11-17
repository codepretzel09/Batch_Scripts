@echo off
REM
REM Place this batch file into the folder with the .JPG files you wish to convert
REM
@echo on
if not exist "%cd%\Watermarked" md "%cd%\Watermarked"
for %%a in (*.JPG) do C:\ImageMagick\composite.exe -gravity SouthEast western-watermark.png %%a "%cd%\Watermarked\Marked--%%a"
@echo off
echo.
pause
start "" "%cd%\Watermarked"