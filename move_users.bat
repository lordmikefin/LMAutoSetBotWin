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
::   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/move_users.bat

:: move_users.bat
:: This script will move windows Users folder to drive D.

:: NOTE: This can be done during Windows installation.

:: https://www.tenforums.com/tutorials/1964-move-users-folder-location-windows-10-a.html
:: https://github.com/cloudfoundry-incubator/bosh-windows-stemcell-builder/blob/master/bosh-psmodules/modules/BOSH.Sysprep/BOSH.Sysprep.psm1



:: WARNING: This script might broke Windows!

:: NOTE: <JUNCTION> can not be copied. They cause error.



SET CURRENT_SCRIPT_VER=0.0.1
SET CURRENT_SCRIPT_DATE=2019-12-13
SET CURRENT_SCRIPT=move_programs.bat
echo CURRENT_SCRIPT_VER: %CURRENT_SCRIPT_VER% (%CURRENT_SCRIPT_DATE%)





:: NOTE: This script will work only in "Safe Mode with Command Prompt"
:: https://www.digitalcitizen.life/4-ways-boot-safe-mode-windows-10
echo.
echo Run this script in "Elevated Command Prompt"
echo  => Run as Administrator
echo.
echo Read more:
echo   https://www.tenforums.com/tutorials/2790-open-elevated-command-prompt-windows-10-a.html
::pause
echo.
echo WARNING: This script might broke Windows!
:PROMPT
::SET /P AREYOUSURE=Are you sure (Y/[N])?
SET /P AREYOUSURE=Do you wanna continue (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END


:: TODO: verify destination drive
:: TODO: verify destination folder should not exist
:: TODO: Parameterise the destination


:: C:
:: cd \

:: ensure that WMP Network Sharing Service is stopped
::
:: NOTE(2019-12-13): got error:
::   The Windows Media Player Network Sharing Service service is not started.
::
:: When this is needed???
net stop wmpnetworksvc
pause
::if %errorlevel% neq 0 (
::	echo.
::	echo ERROR: will exit
::	pause
::	call exit /b %errorlevel%
::)

echo.
echo.
echo This sort of works. Well this works.
echo.
echo Sysprep will force you to create a new user.
echo New user works perfectly \o/
echo.
echo BUT damn it. Old users looks funky.
echo There is no <Junction> folder ???
echo.
echo.
echo.
echo.
pause
SET /P AREYOUSURE=Do you wanna continue (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END


:: <JUNCTION>     Application Data [D:\Users\temp\AppData\Roaming]
:: <JUNCTION>     Cookies [D:\Users\temp\AppData\Local\Microsoft\Windows\INetCookies]
:: <JUNCTION>     Local Settings [D:\Users\temp\AppData\Local]
:: <JUNCTION>     My Documents [D:\Users\temp\Documents]
:: <JUNCTION>     NetHood [D:\Users\temp\AppData\Roaming\Microsoft\Windows\Network Shortcuts]
:: <JUNCTION>     PrintHood [D:\Users\temp\AppData\Roaming\Microsoft\Windows\Printer Shortcuts]
:: <JUNCTION>     Recent [D:\Users\temp\AppData\Roaming\Microsoft\Windows\Recent]
:: <JUNCTION>     SendTo [D:\Users\temp\AppData\Roaming\Microsoft\Windows\SendTo]
:: <JUNCTION>     Start Menu [D:\Users\temp\AppData\Roaming\Microsoft\Windows\Start Menu]
:: <JUNCTION>     Templates [D:\Users\temp\AppData\Roaming\Microsoft\Windows\Templates]


:: Sysprep the windows
%windir%\system32\sysprep\sysprep.exe /oobe /reboot /unattend:move_users_unattend.xml


:END
echo.
echo End of script '%CURRENT_SCRIPT%'
pause

