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
::   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/move_user.bat

:: move_users.bat
:: This script will move a user folder to drive D.

:: NOTE: For now this is hard coded for 'test' user !



:: WARNING: This script might broke Windows!

:: NOTE: <JUNCTION> can not be copied. They cause error.



SET CURRENT_SCRIPT_VER=0.0.4
SET CURRENT_SCRIPT_DATE=2019-12-31
SET CURRENT_SCRIPT=move_user.bat
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
::echo  - "Shift + Shut down"
echo  - "Shift + Restart"
echo  - "Troubleshoot"
echo  - "Advanced options"
echo  - "Command Prompt"
echo.
echo Read more:
echo   https://www.digitalcitizen.life/4-ways-boot-safe-mode-windows-10
::pause
echo.
echo WARNING: This script might broke Windows!
:PROMPT
::SET /P AREYOUSURE=Are you sure (Y/[N])?
SET /P AREYOUSURE=Do you wanna continue (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

:: TODO: verify destinati0n drive
:: TODO: verify destination folder should not exist
:: TODO: Parameterise the destination


:: C:
:: cd \


:: NOTE(2019-12-14): got error [1920 (0x00000780)] while copying file (robocopy)
:: C:\Users\lordmike\AppData\Local\Microsoft\WindowsApps\GameBarElevatedFT_Alias.exe
::  The file cannot be accessed by the system.
::  WTF !?!?!?!
::
:: this file is security context files for UWP app ???
::   https://stackoverflow.com/questions/58296925/what-is-zero-byte-executable-files-in-windows

:: NOTE: Now copy errors are "ignored" by /R:1 /W:1
:: It seems that file still copied !?!?!?!?

:: TODO: log copy process
:: TODO: Is there way to copy files which causes error [1920]



:: TODO: Use 'robocopy' instead of 'xcopy'
::   https://ss64.com/nt/robocopy.html


:: NOTE: Each user has multiple <JUNCTION> folders.
:: NOTE: 'sysprep' can be used to move Users. But it seems to break old users :(
:: Copy   "C:\Users"
::xcopy /E /H "C:\Users\test" "D:\Users\test\" /EXCLUDE:move_users_exclude.txt
::ROBOCOPY "C:\Users" "D:\Users\" /E /COPYALL /sl /XJ
:: ROBOCOPY C:\Users D:\Users\ /E /COPYALL /sl /XJ
ROBOCOPY C:\Users\test D:\Users\test\ /E /COPYALL /sl /XJ /R:1 /W:1 /LOG:robocopy.log
:: /E       : Copy Subfolders, including Empty Subfolders.
:: /COPYALL : Copy ALL file info (equivalent to /COPY:DATSOU)
:: /sl      : Copy file symbolic links instead of the target [see notes below].
:: /XJ      : eXclude Junction points from source. (included by default).
:: /R:n     : Number of Retries on failed copies - default is 1 million.
:: /W:n     : Wait time between retries - default is 30 seconds.
:: /LOG:file : Output status to LOG file (overwrite existing log).
if %errorlevel% neq 0 (
	echo.
	echo ERROR: copying files
	echo error [1920] will always rise error flag
	echo.
	echo NOTE: Now copy errors are "ignored" by /R:1 /W:1

	pause
)
	::call exit /b %errorlevel%

:: Delete "C:\Users" files
del /F /S /Q "C:\Users\test"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Delete "C:\Users" folders
rmdir /S /Q "C:\Users\test"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Link   "C:\Users"
mklink /J "C:\Users\test" "D:\Users\test\"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)


:: Recreate junction folders
mklink /J "D:\Users\test\AppData\Local\Application Data" "D:\Users\test\AppData\Local"
mklink /J "D:\Users\test\AppData\Local\History" "D:\Users\test\AppData\Local\Microsoft\Windows\History"
mklink /J "D:\Users\test\AppData\Local\Temporary Internet Files" "D:\Users\test\AppData\Local\Microsoft\Windows\INetCache"


:: Recreate junction folders
mklink /J "D:\Users\test\AppData\Local\Microsoft\Windows\Temporary Internet Files" "D:\Users\test\AppData\Local\Microsoft\Windows\INetCache"
mklink /J "D:\Users\test\AppData\Local\Microsoft\Windows\INetCache\Content.IE5" "D:\Users\test\AppData\Local\Microsoft\Windows\INetCache\IE"


:: Recreate junction folders
mklink /J "D:\Users\test\My Music" "D:\Users\test\Music"
mklink /J "D:\Users\test\My Pictures" "D:\Users\test\Pictures"
mklink /J "D:\Users\test\My Videos" "D:\Users\test\Videos"


:: Recreate junction folders
mklink /J "D:\Users\test\Application Data" "D:\Users\test\AppData\Roaming"
mklink /J "D:\Users\test\Cookies" "D:\Users\test\AppData\Local\Microsoft\Windows\INetCookies"
mklink /J "D:\Users\test\Local Settings" "D:\Users\test\AppData\Local"
mklink /J "D:\Users\test\My Documents" "D:\Users\test\Documents"
mklink /J "D:\Users\test\NetHood" "D:\Users\test\AppData\Roaming\Microsoft\Windows\Network Shortcuts"
mklink /J "D:\Users\test\PrintHood" "D:\Users\test\AppData\Roaming\Microsoft\Windows\Printer Shortcuts"
mklink /J "D:\Users\test\Recent" "D:\Users\test\AppData\Roaming\Microsoft\Windows\Recent"
mklink /J "D:\Users\test\SendTo" "D:\Users\test\AppData\Roaming\Microsoft\Windows\SendTo"
mklink /J "D:\Users\test\Start Menu" "D:\Users\test\AppData\Roaming\Microsoft\Windows\Start Menu"
mklink /J "D:\Users\test\Templates" "D:\Users\test\AppData\Roaming\Microsoft\Windows\Templates"




:END
echo.
echo End of script '%CURRENT_SCRIPT%'
pause

