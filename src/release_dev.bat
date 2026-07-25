setlocal enabledelayedexpansion
@echo off

set oldcd=%cd%

cd %~dp0

:: version.txt: line 1 = VERSION digits, line 2 = optional TAG (indev02/rc3)
set VERSION=
set TAG=
set VLINE=0
for /f "usebackq delims=" %%A in ("version.txt") do (
	set /a VLINE+=1
	if "!VLINE!"=="1" set VERSION=%%A
	if "!VLINE!"=="2" set TAG=%%A
)

:: pre-release variant of release.bat - folds TAG into the pak name and
:: description.txt instead of leaving them tag-free
set PK3_NAME=pak%VERSION%
if not "%TAG%"=="" set PK3_NAME=pak%VERSION%_%TAG%

:: Extract the first digit
set MAJOR=%VERSION:~0,1%
:: Extract the remaining digits
set MINOR=%VERSION:~1%

set DESC=Quake III Ultimate Arena %MAJOR%.%MINOR%
if not "%TAG%"=="" set DESC=%DESC% %TAG%

:DESCRIPTION_TXT
<nul set /p ="%DESC%" > ..\description.txt
GOTO MAKE_QVM

:MAKE_QVM
echo MAKE QVM
cmd /c code\game\game_ua.bat
cmd /c code\cgame\cgame_ua.bat
cmd /c code\ui\ui.bat

:COPYFILES_QVM
echo CREATE TEMP FOLDER AND COPY FILES
md _temp
cd _temp
md vm
cd vm
copy ..\..\code\game\vm\qagame.qvm .\
copy ..\..\code\cgame\vm\cgame.qvm .\
copy ..\..\code\ui\vm\ui.qvm .\
cd ..
md ui
cd ui
xcopy /S /E ..\..\ui .\
cd ..
xcopy /S /E ..\assets\* .\
echo ...Done!
GOTO PK3_MAIN

:PK3_MAIN
echo CREATE %PK3_NAME%.pk3
powershell Compress-Archive .\* %PK3_NAME%.zip
ren %PK3_NAME%.zip %PK3_NAME%.pk3
move %PK3_NAME%.pk3 ..\..\
cd ..
rd /S /Q _temp
echo ...Done!
GOTO QUIT

:QUIT
cd %oldcd%
endlocal
echo Press any key to exit . . .
pause > NUL
