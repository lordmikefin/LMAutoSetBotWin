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
::   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/Hibernation-Disable.bat

:: Hibernation-Disable.bat
:: This script will disable windows hibernation

SET CURRENT_SCRIPT_VER=0.0.1
SET CURRENT_SCRIPT_DATE=2020-01-02
SET CURRENT_SCRIPT=Hibernation-Disable.bat
echo CURRENT_SCRIPT_VER: %CURRENT_SCRIPT_VER% (%CURRENT_SCRIPT_DATE%)

SET POWER_APP=%windir%\System32\powercfg.exe

:: http://www.acnodes.com/blog/disable-sleep-mode-hibernation-windows-10/

echo.
echo I will disable hibernation.
echo Read more:
echo   http://www.acnodes.com/blog/disable-sleep-mode-hibernation-windows-10/

:: Ask permission
:PROMPT
SET /P AREYOUSURE=Do you wanna continue (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END


:: Disable hibernation
SET COM=%POWER_APP% /h off
echo.
echo %COM%
echo.
call %COM%
if %errorlevel% neq 0 (
	:: Got error. Maybe Access is denied.
	echo Some thing failed.
)


:END
echo.
echo End of script '%CURRENT_SCRIPT%'
pause

