setlocal
@echo on

set oldcd=%cd%

cd %~dp0
cd ..\..\bin\windows
set PATH=%cd%;%PATH%
cd ..\..\code\ui

rem make sure we have a safe environement
set LIBRARY=
set INCLUDE=

mkdir vm
cd vm

set cc=q3lcc -DQ3_VM -S -Wf-target=bytecode -Wf-g -I..\..\cgame -I..\..\game -I..\..\ui %1

%cc% ../ui_main.c
@if errorlevel 1 goto errorquit
%cc% ../../game/bg_misc.c
@if errorlevel 1 goto errorquit
%cc% ../../game/bg_newgame.c
@if errorlevel 1 goto errorquit
%cc% ../../game/bg_lib.c
@if errorlevel 1 goto errorquit
%cc% ../../game/q_math.c
@if errorlevel 1 goto errorquit
%cc% ../../game/q_shared.c
@if errorlevel 1 goto errorquit
%cc% ../ui_atoms.c
@if errorlevel 1 goto errorquit
%cc% ../ui_players.c
@if errorlevel 1 goto errorquit
%cc% ../ui_util.c
@if errorlevel 1 goto errorquit
%cc% ../ui_shared.c
@if errorlevel 1 goto errorquit
%cc% ../ui_gameinfo.c
@if errorlevel 1 goto errorquit

q3asm -vq3 -r -m -v -f ../ui

@echo off


@if errorlevel 1 goto errorquit

goto quit

:errorquit
echo ERROR!
echo Press any key to exit . . .
pause > nul
goto quit

:quit
cd %oldcd%
endlocal
