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
echo Before you run this script make sure you are in "Safe Mode with Command Prompt"
echo Windows system folders can not be moved in normal state.
echo.
echo https://www.digitalcitizen.life/4-ways-boot-safe-mode-windows-10
pause



echo.
echo End of script '%CURRENT_SCRIPT%'
pause

