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



SET CURRENT_SCRIPT_VER=0.0.8
SET CURRENT_SCRIPT_DATE=2020-01-02
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


::set arg1=%1
SET USER=test
IF %1.==. (
	echo No argument given moving user 'test'
	echo.
	pause
) ELSE (
	SET USER=%1
)

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
ROBOCOPY C:\Users\%USER% D:\Users\%USER%\ /E /COPYALL /sl /XJ /R:1 /W:1 /LOG:robocopy_user.log
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
del /F /S /Q "C:\Users\%USER%"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Delete "C:\Users" folders
rmdir /S /Q "C:\Users\%USER%"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Link   "C:\Users"
mklink /J "C:\Users\%USER%" "D:\Users\%USER%\"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)


:: Recreate junction folders
mklink /J "D:\Users\%USER%\AppData\Local\Application Data" "D:\Users\%USER%\AppData\Local"
mklink /J "D:\Users\%USER%\AppData\Local\History" "D:\Users\%USER%\AppData\Local\Microsoft\Windows\History"
mklink /J "D:\Users\%USER%\AppData\Local\Temporary Internet Files" "D:\Users\%USER%\AppData\Local\Microsoft\Windows\INetCache"


:: Recreate junction folders
mklink /J "D:\Users\%USER%\AppData\Local\Microsoft\Windows\Temporary Internet Files" "D:\Users\%USER%\AppData\Local\Microsoft\Windows\INetCache"
mklink /J "D:\Users\%USER%\AppData\Local\Microsoft\Windows\INetCache\Content.IE5" "D:\Users\%USER%\AppData\Local\Microsoft\Windows\INetCache\IE"


:: Recreate junction folders
mklink /J "D:\Users\%USER%\Documents\My Music" "D:\Users\%USER%\Music"
mklink /J "D:\Users\%USER%\Documents\My Pictures" "D:\Users\%USER%\Pictures"
mklink /J "D:\Users\%USER%\Documents\My Videos" "D:\Users\%USER%\Videos"


:: Recreate junction folders
mklink /J "D:\Users\%USER%\Application Data" "D:\Users\%USER%\AppData\Roaming"
mklink /J "D:\Users\%USER%\Cookies" "D:\Users\%USER%\AppData\Local\Microsoft\Windows\INetCookies"
mklink /J "D:\Users\%USER%\Local Settings" "D:\Users\%USER%\AppData\Local"
mklink /J "D:\Users\%USER%\My Documents" "D:\Users\%USER%\Documents"
mklink /J "D:\Users\%USER%\NetHood" "D:\Users\%USER%\AppData\Roaming\Microsoft\Windows\Network Shortcuts"
mklink /J "D:\Users\%USER%\PrintHood" "D:\Users\%USER%\AppData\Roaming\Microsoft\Windows\Printer Shortcuts"
mklink /J "D:\Users\%USER%\Recent" "D:\Users\%USER%\AppData\Roaming\Microsoft\Windows\Recent"
mklink /J "D:\Users\%USER%\SendTo" "D:\Users\%USER%\AppData\Roaming\Microsoft\Windows\SendTo"
mklink /J "D:\Users\%USER%\Start Menu" "D:\Users\%USER%\AppData\Roaming\Microsoft\Windows\Start Menu"
mklink /J "D:\Users\%USER%\Templates" "D:\Users\%USER%\AppData\Roaming\Microsoft\Windows\Templates"




:END
echo.
echo End of script '%CURRENT_SCRIPT%'
pause

