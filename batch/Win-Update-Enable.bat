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
::   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/Win-Update-Enable.bat

:: Win-Update-Enable.bat
:: This script will Enable windows update service

SET CURRENT_SCRIPT_VER=0.0.1
SET CURRENT_SCRIPT_DATE=2019-11-18
SET CURRENT_SCRIPT=Win-Update-Enable.bat
echo CURRENT_SCRIPT_VER: %CURRENT_SCRIPT_VER% (%CURRENT_SCRIPT_DATE%)

SET SC_APP=%windir%\System32\sc.exe

:: https://www.partitionwizard.com/clone-disk/disable-windows-10-update.html
:: https://superuser.com/questions/460076/disable-a-windows-service-from-the-command-line
:: https://technet.microsoft.com/pt-br/library/cc990290(v=ws.11).aspx


:: Service name: "wuauserv"
:: Display name: "Windows Update"

:: Tell user about Enable "Windows Update". And give link to guide.
echo.
echo I will start and Enable "Windows Update".
echo This can be done manually from GUI:
echo   https://www.partitionwizard.com/clone-disk/disable-windows-10-update.html

:: Ask permission
echo.
echo Do you want to Enable the "Windows Update". Will open PowerShell to do this.
echo   Interupt with Ctrl + c
pause

:: Enable the "Windows Update"
echo Enable the "Windows Update"
::SET COM=%SC_APP% config "Windows Update" start= disabled
SET COM=%SC_APP% config "wuauserv" start= DELAYED-AUTO
:: Open PowerShell as Administrator
PowerShell -Command "& {Start-Process -FilePath PowerShell -Verb RunAs -Wait -ArgumentList '-Command %COM% ; pause'}"

:: Start the "Windows Update"
echo Start the "Windows Update"
::SET COM=%SC_APP% stop "Windows Update"
SET COM=%SC_APP% start "wuauserv"
:: Open PowerShell as Administrator
PowerShell -Command "& {Start-Process -FilePath PowerShell -Verb RunAs -Wait -ArgumentList '-Command %COM% ; pause'}"

::echo errorlevel %errorlevel%
if %errorlevel% neq 0 (
	:: Got error. Maybe Access is denied.
	echo Run this script as administrator
	:: TODO: how to do this from command line?
	echo   https://www.howtogeek.com/194041/how-to-open-the-command-prompt-as-administrator-in-windows-8.1/
)



echo.
echo End of script '%CURRENT_SCRIPT%'
pause
