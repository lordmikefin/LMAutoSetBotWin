::C:\Windows\SysWOW64\cmd.exe
@echo off

:: Copyright (c) 2019, Mikko Niemelä a.k.a. Lord Mike (lordmike@iki.fi)
:: 
:: License of this script file:
::   MIT License
:: 
:: License is available online:
::   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/LICENSE
:: 
:: Latest version of this script file:
::   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/move_programs.bat

:: move_programs.bat
:: This script will move windows system folder to drive D.


:: WARNING: This script might broke Windows!




SET CURRENT_SCRIPT_VER=0.0.1
SET CURRENT_SCRIPT_DATE=2019-12-09
SET CURRENT_SCRIPT=move_programs.bat
echo CURRENT_SCRIPT_VER: %CURRENT_SCRIPT_VER% (%CURRENT_SCRIPT_DATE%)

:: https://www.systoolsgroup.com/how-to/move-program-files-folder-to-another-drive/
:: https://www.ubackup.com/backup-restore/move-program-files-to-another-drive-windows-10.html


:: NOTE: This script will work only in "Safe Mode with Command Prompt"
:: https://www.digitalcitizen.life/4-ways-boot-safe-mode-windows-10
echo.
echo Before you run this script make sure you are in "Safe Mode"
echo Windows system folders can not be moved in normal state.
echo.
echo Short how to:
echo  - "Shift + Shut down"
echo  - "Troubleshoot"
echo  - "Advanced options"
echo  - "Command Prompt"
echo.
echo Read more:
echo   https://www.digitalcitizen.life/4-ways-boot-safe-mode-windows-10
pause


:: TODO: verify destinati0n drive
:: TODO: verify destination folder should not exist
:: TODO: Parameterise the destination


C:
cd \


:: Copy   "C:\Program Files"
xcopy /E /H "C:\Program Files" "D:\Program Files\"

:: Delete "C:\Program Files"
del /F /S /Q "C:\Program Files"
rmdir /S /Q "C:\Program Files"

:: Link   "C:\Program Files"
mklink /J mklink /J "Program Files" "D:\Program Files\"


:: Copy   "C:\Program Files (x86)"
xcopy /E /H "C:\Program Files (x86)" "D:\Program Files (x86)\"

:: Delete "C:\Program Files (x86)"
del /F /S /Q "C:\Program Files (x86)"
rmdir /S /Q "C:\Program Files (x86)"

:: Link   "C:\Program Files (x86)"
mklink /J mklink /J "Program Files (x86)" "D:\Program Files (x86)\"


:: Copy   "C:\ProgramData"
xcopy /E /H "C:\ProgramData" "D:\ProgramData\"

:: Delete "C:\ProgramData"
del /F /S /Q "C:\ProgramData"
rmdir /S /Q "C:\ProgramData"

:: Link   "C:\ProgramData"
mklink /J mklink /J "ProgramData" "D:\ProgramData\"


:: Copy   "C:\Users"
xcopy /E /H "C:\Users" "D:\Users\"

:: Delete "C:\Users"
del /F /S /Q "C:\Users"
rmdir /S /Q "C:\Users"

:: Link   "C:\Users"
mklink /J mklink /J "Users" "D:\Users\"


echo.
echo End of script '%CURRENT_SCRIPT%'
pause

