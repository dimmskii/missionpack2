setlocal enabledelayedexpansion
@echo off

set oldcd=%cd%

cd %~dp0

:: Single source of truth for VERSION + the optional pre-release TAG,
:: shared with CMakeLists.txt's Q3_VERSION/Q3_VERSION_TAG parsing (see the
:: comment there) so the two build entry points can't drift out of sync.
:: Line 1 of version.txt = version digits (e.g. 061), line 2 = optional
:: tag (e.g. indev02, rc3) - either may be blank/absent.
set VERSION=
set TAG=
set VLINE=0
for /f "usebackq delims=" %%A in ("version.txt") do (
	set /a VLINE+=1
	if "!VLINE!"=="1" set VERSION=%%A
	if "!VLINE!"=="2" set TAG=%%A
)

:: TAG is read but intentionally NOT folded into PK3_NAME below - this
:: script is the dist/release path (mirrored by CMake's `release` target),
:: which always produces a tag-free pak%VERSION%.pk3. A future dev-build
:: script can consume %TAG% for a pak%VERSION%_indev02.pk3-style name
:: without touching this one.
set PK3_NAME=pak%VERSION%

:: Extract the first digit
set MAJOR=%VERSION:~0,1%
:: Extract the remaining digits
set MINOR=%VERSION:~1%

:DESCRIPTION_TXT
::echo Quake III Ultimate Arena %MAJOR%.%MINOR%>..\description.txt
<nul set /p ="Quake III Ultimate Arena %MAJOR%.%MINOR%" > ..\description.txt
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
::GOTO PK3_AUX
GOTO QUIT

:PK3_AUX
echo CREATE CONTENT PK3 FILES
md _temp
cd _temp
for /f "delims=" %%i in ('dir /ad/b ..\pk3\*') do (
echo %%i.pk3
powershell Compress-Archive ..\pk3\%%i\* %%i.zip
ren %%i.zip %%i.pk3
move %%i.pk3 ..\..\
echo ...Done!
)
cd ..
rd /S /Q _temp
goto QUIT


:QUIT
cd %oldcd%
endlocal
echo Press any key to exit . . .
pause > NUL
