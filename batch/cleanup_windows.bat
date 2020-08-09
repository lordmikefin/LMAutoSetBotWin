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
::   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/cleanup_windows.bat

:: cleanup_windows.bat
:: This script will cleanup windows shit that hogs your disk space


:: WARNING: This script might broke Windows!




SET CURRENT_SCRIPT_VER=0.0.1
SET CURRENT_SCRIPT_DATE=2020-01-03
SET CURRENT_SCRIPT=cleanup_windows.bat
echo CURRENT_SCRIPT_VER: %CURRENT_SCRIPT_VER% (%CURRENT_SCRIPT_DATE%)


:: https://www.laptopmag.com/articles/clean-winsxs-folder-to-save-space


SET DISM_APP=%windir%\System32\dism.exe


:::PROMPT
::SET /P AREYOUSURE=Are you sure (Y/[N])?
::SET /P AREYOUSURE=Do you wanna continue (Y/[N])?
::IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

SET COM=%DISM_APP% /online /Cleanup-Image /StartComponentCleanup
echo calling: %COM%
call %COM%
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	echo.
	echo Try launching the command prompt with admin priviledges.
	echo   https://www.howtogeek.com/194041/how-to-open-the-command-prompt-as-administrator-in-windows-8.1/
	pause
	call exit /b %errorlevel%
)


:END
echo.
echo End of script '%CURRENT_SCRIPT%'
pause

