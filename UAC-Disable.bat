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
::   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/UAC-Disable.bat

:: UAC-Disable.bat
:: This script will disable windows UAC

SET CURRENT_SCRIPT_VER=0.0.1
SET CURRENT_SCRIPT_DATE=2019-10-06
SET CURRENT_SCRIPT=UAC-Disable.bat
echo CURRENT_SCRIPT_VER: %CURRENT_SCRIPT_VER% (%CURRENT_SCRIPT_DATE%)

:: https://www.howtogeek.com/howto/windows-vista/enable-or-disable-uac-from-the-windows-vista-command-line/
:: https://www.howtogeek.com/howto/windows-vista/disable-user-account-control-uac-the-easy-way-on-windows-vista/

:: TODO: Tell user about disabling UAC. And give link to guide "Disable User Account Control (UAC) the Easy Way on Win 7, 8, or 10"

:: TODO: Ask permission

:: TODO: Disable the UAC

:: TODO: After you enable or disable UAC, you will have to reboot your computer for the changes to take effect.

echo.
echo End of script '%CURRENT_SCRIPT%'
