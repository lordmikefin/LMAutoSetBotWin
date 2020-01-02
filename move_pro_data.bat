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
::   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/move_pro_data.bat

:: move_pro_data.bat
:: This script will move windows system folder to drive D.


:: WARNING: This script might broke Windows!

:: NOTE: <JUNCTION> can not be copied. They cause error.



SET CURRENT_SCRIPT_VER=0.0.4
SET CURRENT_SCRIPT_DATE=2020-01-02
SET CURRENT_SCRIPT=move_pro_data.bat
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
echo.
echo Junktion folders are not created correctly!
echo "Templates" will break, becaus of this   !
echo.

::set arg1=%1
SET DST_DRV=D
IF %1.==. (
	echo No argument given moving program data into drive D:
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



:: NOTE(2020-01-02): xcopy exclude does not work as I expected.
:: NOTE: exclude <JUNCTION> folder and recreate.
:: Copy   "C:\ProgramData"
::xcopy /E /H "C:\ProgramData" "D:\ProgramData\" /EXCLUDE:exclude_pro_data.txt
ROBOCOPY C:\ProgramData %DST_DRV%:\ProgramData\ /E /COPYALL /sl /XJ /R:1 /W:1 /LOG:robocopy_pro_data.log
:: /E       : Copy Subfolders, including Empty Subfolders.
:: /COPYALL : Copy ALL file info (equivalent to /COPY:DATSOU)
:: /sl      : Copy file symbolic links instead of the target [see notes below].
:: /XJ      : eXclude Junction points from source. (included by default).
:: /R:n     : Number of Retries on failed copies - default is 1 million.
:: /W:n     : Wait time between retries - default is 30 seconds.
:: /LOG:file : Output status to LOG file (overwrite existing log).
::if %errorlevel% neq 0 (
::	echo.
::	echo ERROR: will exit
::	pause
::	call exit /b %errorlevel%
::)
if %errorlevel% neq 0 (
	echo.
	echo ERROR: copying files
	echo error [1920] will always rise error flag
	echo.
	echo NOTE: Now copy errors are "ignored" by /R:1 /W:1

	pause
)

::<JUNCTION>     Application Data [C:\ProgramData]
::<JUNCTION>     Desktop [C:\Users\Public\Desktop]
::<JUNCTION>     Documents [C:\Users\Public\Documents]
::<JUNCTION>     Start Menu [C:\ProgramData\Microsoft\Windows\Start Menu]
::<JUNCTION>     Templates [C:\ProgramData\Microsoft\Windows\Templates]



:: Delete files "C:\ProgramData"
del /F /S /Q "C:\ProgramData"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Delete folders "C:\ProgramData"
rmdir /S /Q "C:\ProgramData"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Link   "C:\ProgramData"
mklink /J "C:\ProgramData" "%DST_DRV%:\ProgramData\"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Recreate junction folders
::<JUNCTION>     Application Data [C:\ProgramData]
::<JUNCTION>     Desktop [C:\Users\Public\Desktop]
::<JUNCTION>     Documents [C:\Users\Public\Documents]
::<JUNCTION>     Start Menu [C:\ProgramData\Microsoft\Windows\Start Menu]
::<JUNCTION>     Templates [C:\ProgramData\Microsoft\Windows\Templates]

mklink /J "C:\ProgramData\Application Data" "C:\ProgramData"
if %errorlevel% neq 0 exit /b %errorlevel%

mklink /J "C:\ProgramData\Desktop" "C:\Users\Public\Desktop"
if %errorlevel% neq 0 exit /b %errorlevel%

mklink /J "C:\ProgramData\Documents" "C:\Users\Public\Documents"
if %errorlevel% neq 0 exit /b %errorlevel%

mklink /J "C:\ProgramData\Start Menu" "C:\ProgramData\Microsoft\Windows\Start Menu"
if %errorlevel% neq 0 exit /b %errorlevel%

mklink /J "C:\ProgramData\Templates" "C:\ProgramData\Microsoft\Windows\Templates"
if %errorlevel% neq 0 exit /b %errorlevel%




:: NOTE: Users has multiple <JUNCTION> folders (too many). Skip this one.
:: NOTE: 'sysprep' can be used to move Users.
:: Copy   "C:\Users"
::xcopy /E /H "C:\Users" "D:\Users\"

:: Delete "C:\Users"
::del /F /S /Q "C:\Users"
::rmdir /S /Q "C:\Users"

:: Link   "C:\Users"
::mklink /J "Users" "D:\Users\"


:END
echo.
echo End of script '%CURRENT_SCRIPT%'
pause

