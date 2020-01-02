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
::   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/move_programs.bat

:: move_programs.bat
:: This script will move windows system folder to drive D.


:: WARNING: This script might broke Windows!

:: NOTE: <JUNCTION> can not be copied. They cause error.



SET CURRENT_SCRIPT_VER=0.0.7
SET CURRENT_SCRIPT_DATE=2020-01-02
SET CURRENT_SCRIPT=move_programs.bat
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
	echo No argument given moving programs into drive D:
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



:: Copy   "C:\Program Files"
xcopy /E /H "C:\Program Files" "%DST_DRV%:\Program Files\"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Copy   "C:\Program Files (x86)"
xcopy /E /H "C:\Program Files (x86)" "%DST_DRV%:\Program Files (x86)\"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)



:: Delete files "C:\Program Files"
del /F /S /Q "C:\Program Files"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)
:: Delete folders "C:\Program Files"
rmdir /S /Q "C:\Program Files"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Link   "C:\Program Files"
mklink /J "C:\Program Files" "%DST_DRV%:\Program Files\"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)



:: Delete files "C:\Program Files (x86)"
del /F /S /Q "C:\Program Files (x86)"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Delete folders "C:\Program Files (x86)"
rmdir /S /Q "C:\Program Files (x86)"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)

:: Link   "C:\Program Files (x86)"
mklink /J "C:\Program Files (x86)" "%DST_DRV%:\Program Files (x86)\"
if %errorlevel% neq 0 (
	echo.
	echo ERROR: will exit
	pause
	call exit /b %errorlevel%
)




:END
echo.
echo End of script '%CURRENT_SCRIPT%'
pause

