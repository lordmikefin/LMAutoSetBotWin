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


:: WARNING: This script might broke Windows!

:: NOTE: <JUNCTION> can not be copied. They cause error.



SET CURRENT_SCRIPT_VER=0.0.7
SET CURRENT_SCRIPT_DATE=2020-01-02
SET CURRENT_SCRIPT=move_users.bat
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
SET DST_DRV=D
IF %1.==. (
	echo No argument given moving users into drive D:
	echo.
	pause
) ELSE (
	SET DST_DRV=%1
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
::xcopy /E /H "C:\Users" "D:\Users\" /EXCLUDE:move_users_exclude.txt
::ROBOCOPY "C:\Users" "D:\Users\" /E /COPYALL /sl /XJ
:: ROBOCOPY C:\Users D:\Users\ /E /COPYALL /sl /XJ
ROBOCOPY C:\Users %DST_DRV%:\Users\ /E /COPYALL /sl /XJ /R:1 /W:1 /LOG:robocopy_users.log
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
del /F /S /Q "C:\Users"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Delete "C:\Users" folders
rmdir /S /Q "C:\Users"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Link   "C:\Users"
mklink /J "C:\Users" "%DST_DRV%:\Users\"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)



:: Each user folder (example 'temp' user)
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



:: Recreate junction folders for each User
::   https://ss64.com/nt/for_d.html
:: Exclude 'All Users' and 'Default User'
::FOR /D [/r] %%parameter IN (folder_set) DO command
::FOR /D  %%G IN (D:\Users\*) DO echo Found %%G
FOR /D  %%G IN (%DST_DRV%:\Users\*) DO (
	echo Found %%G
	echo Creating junction folders
	echo.
	
	IF /I NOT "%%G"=="%DST_DRV%:\Users\All Users" (
		IF /I NOT "%%G"=="%DST_DRV%:\Users\Default User" (
			IF /I NOT "%%G"=="%DST_DRV%:\Users\Public" (
				mklink /J "%%G\AppData\Local\Application Data" "%%G\AppData\Local"
				mklink /J "%%G\AppData\Local\History" "%%G\AppData\Local\Microsoft\Windows\History"
				mklink /J "%%G\AppData\Local\Temporary Internet Files" "%%G\AppData\Local\Microsoft\Windows\INetCache"
				mklink /J "%%G\AppData\Local\Microsoft\Windows\Temporary Internet Files" "%%G\AppData\Local\Microsoft\Windows\INetCache"
				mklink /J "%%G\AppData\Local\Microsoft\Windows\INetCache\Content.IE5" "%%G\AppData\Local\Microsoft\Windows\INetCache\IE"
				mklink /J "%%G\Documents\My Music" "%%G\Music"
				mklink /J "%%G\Documents\My Pictures" "%%G\Pictures"
				mklink /J "%%G\Documents\My Videos" "%%G\Videos"
				mklink /J "%%G\Application Data" "%%G\AppData\Roaming"
				mklink /J "%%G\Cookies" "%%G\AppData\Local\Microsoft\Windows\INetCookies"
				mklink /J "%%G\Local Settings" "%%G\AppData\Local"
				mklink /J "%%G\My Documents" "%%G\Documents"
				mklink /J "%%G\NetHood" "%%G\AppData\Roaming\Microsoft\Windows\Network Shortcuts"
				mklink /J "%%G\PrintHood" "%%G\AppData\Roaming\Microsoft\Windows\Printer Shortcuts"
				mklink /J "%%G\Recent" "%%G\AppData\Roaming\Microsoft\Windows\Recent"
				mklink /J "%%G\SendTo" "%%G\AppData\Roaming\Microsoft\Windows\SendTo"
				mklink /J "%%G\Start Menu" "%%G\AppData\Roaming\Microsoft\Windows\Start Menu"
				mklink /J "%%G\Templates" "%%G\AppData\Roaming\Microsoft\Windows\Templates"
			)
		)
	)
)
::if %errorlevel% neq 0 exit /b %errorlevel%

:: 'Default' is not found by for loop
:: Recreate junction folders into Default
mklink /J "%DST_DRV%:\Users\Default\AppData\Local\Application Data" "%DST_DRV%:\Users\Default\AppData\Local"
mklink /J "%DST_DRV%:\Users\Default\AppData\Local\History" "%DST_DRV%:\Users\Default\AppData\Local\Microsoft\Windows\History"
mklink /J "%DST_DRV%:\Users\Default\AppData\Local\Temporary Internet Files" "%DST_DRV%:\Users\Default\AppData\Local\Microsoft\Windows\INetCache"
mklink /J "%DST_DRV%:\Users\Default\AppData\Local\Microsoft\Windows\Temporary Internet Files" "%DST_DRV%:\Users\Default\AppData\Local\Microsoft\Windows\INetCache"
::mklink /J "D:\Users\%USER%\AppData\Local\Microsoft\Windows\INetCache\Content.IE5" "D:\Users\%USER%\AppData\Local\Microsoft\Windows\INetCache\IE"
mklink /J "%DST_DRV%:\Users\Default\Documents\My Music" "%DST_DRV%:\Users\Default\Music"
mklink /J "%DST_DRV%:\Users\Default\Documents\My Pictures" "%DST_DRV%:\Users\Default\Pictures"
mklink /J "%DST_DRV%:\Users\Default\Documents\My Videos" "%DST_DRV%:\Users\Default\Videos"
mklink /J "%DST_DRV%:\Users\Default\Application Data" "%DST_DRV%:\Users\Default\AppData\Roaming"
mklink /J "%DST_DRV%:\Users\Default\Cookies" "%DST_DRV%:\Users\Default\AppData\Local\Microsoft\Windows\INetCookies"
mklink /J "%DST_DRV%:\Users\Default\Local Settings" "%DST_DRV%:\Users\Default\AppData\Local"
mklink /J "%DST_DRV%:\Users\Default\My Documents" "%DST_DRV%:\Users\Default\Documents"
mklink /J "%DST_DRV%:\Users\Default\NetHood" "%DST_DRV%:\Users\Default\AppData\Roaming\Microsoft\Windows\Network Shortcuts"
mklink /J "%DST_DRV%:\Users\Default\PrintHood" "%DST_DRV%:\Users\Default\AppData\Roaming\Microsoft\Windows\Printer Shortcuts"
mklink /J "%DST_DRV%:\Users\Default\Recent" "%DST_DRV%:\Users\Default\AppData\Roaming\Microsoft\Windows\Recent"
mklink /J "%DST_DRV%:\Users\Default\SendTo" "%DST_DRV%:\Users\Default\AppData\Roaming\Microsoft\Windows\SendTo"
mklink /J "%DST_DRV%:\Users\Default\Start Menu" "%DST_DRV%:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu"
mklink /J "%DST_DRV%:\Users\Default\Templates" "%DST_DRV%:\Users\Default\AppData\Roaming\Microsoft\Windows\Templates"


:: 'Public' is not found by for loop
:: Recreate junction folders into Public
mklink /J "%DST_DRV%:\Users\Public\Documents\My Music" "%DST_DRV%:\Users\Public\Music"
mklink /J "%DST_DRV%:\Users\Public\Documents\My Pictures" "%DST_DRV%:\Users\Public\Pictures"
mklink /J "%DST_DRV%:\Users\Public\Documents\My Videos" "%DST_DRV%:\Users\Public\Videos"


:: Users folder
::<SYMLINKD>     All Users [C:\ProgramData]
::<JUNCTION>     Default User [C:\Users\Default]

:: Recreate junction folders
mklink /J "C:\Users\All Users" "C:\ProgramData"
if %errorlevel% neq 0 exit /b %errorlevel%

mklink /J "C:\Users\Default User" "C:\Users\Default"
if %errorlevel% neq 0 exit /b %errorlevel%



:: (2020-01-02) If recreated things will break.
:: It is normal to get access denied error.
::  ***Recreate some junktion folders. It seems that move broke Junktions. :(
::rmdir "C:\Documents and Settings"
::mklink /J "C:\Documents and Settings" "C:\Users"
::if %errorlevel% neq 0 exit /b %errorlevel%

::rmdir "C:\ProgramData\Desktop"
::mklink /J "C:\ProgramData\Desktop" "C:\Users\Public\Desktop"
::if %errorlevel% neq 0 exit /b %errorlevel%

::rmdir "C:\ProgramData\Documents"
::mklink /J "C:\ProgramData\Documents" "C:\Users\Public\Documents"
::if %errorlevel% neq 0 exit /b %errorlevel%


:END
echo.
echo End of script '%CURRENT_SCRIPT%'
pause

