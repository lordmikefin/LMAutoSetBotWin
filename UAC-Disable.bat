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

SET CURRENT_SCRIPT_VER=0.0.2
SET CURRENT_SCRIPT_DATE=2019-10-06
SET CURRENT_SCRIPT=UAC-Disable.bat
echo CURRENT_SCRIPT_VER: %CURRENT_SCRIPT_VER% (%CURRENT_SCRIPT_DATE%)

::SET CMD_APP=C:\Windows\System32\cmd.exe
SET CMD_APP=%windir%\System32\cmd.exe
SET REC_APP=%windir%\System32\reg.exe

:: https://www.howtogeek.com/howto/windows-vista/enable-or-disable-uac-from-the-windows-vista-command-line/
:: https://www.howtogeek.com/howto/windows-vista/disable-user-account-control-uac-the-easy-way-on-windows-vista/

:: Tell user about disabling UAC. And give link to guide "Disable User Account Control (UAC) the Easy Way on Win 7, 8, or 10"
echo.
echo I will disable User Account Control (UAC).
echo This can be done manually from GUI:
echo   https://www.howtogeek.com/howto/windows-vista/disable-user-account-control-uac-the-easy-way-on-windows-vista/

:: Ask permission
echo.
echo Do you want to disable the UAC. Will open PowerShell to do this.
echo   Interupt with Ctrl + c
pause

:: Disable the UAC
:: C:\Windows\System32\cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
::%CMD_APP% /k %REC_APP% ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
SET COM=%REC_APP% ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f 
:: %COM%
:: Open PowerShell as Administrator
::PowerShell -Command "& {Start-Process -FilePath PowerShell -Verb RunAs -Wait -ArgumentList '-Command %COM%'}"
PowerShell -Command "& {Start-Process -FilePath PowerShell -Verb RunAs -Wait -ArgumentList '-Command %COM% ; pause'}"

::echo errorlevel %errorlevel%
if %errorlevel% neq 0 (
	:: Got error. Maybe Access is denied.
	echo Run this script as administrator
	:: TODO: how to do this from command line?
	echo   https://www.howtogeek.com/194041/how-to-open-the-command-prompt-as-administrator-in-windows-8.1/
)


echo.
echo After you enable or disable UAC, you will have to reboot your computer for the changes to take effect.

echo.
echo End of script '%CURRENT_SCRIPT%'
pause
