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
::   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/init.bat

:: init.bat
:: This script will install software for my other scripts :)
:: Download and install.
::  - Git
::  - Python

SET CURRENT_SCRIPT_VER=0.0.2
SET CURRENT_SCRIPT_DATE=2019-09-02
SET CURRENT_SCRIPT=init.bat
echo CURRENT_SCRIPT_VER: %CURRENT_SCRIPT_VER% (%CURRENT_SCRIPT_DATE%)



:: Create directory for Installer and install path.
::   C:\LM_ToyBox\temp
::   C:\LM_ToyBox\apps
::   C:\LM_ToyBox\apps\Git
::   C:\LM_ToyBox\apps\Python\Python37
SET PATH_TOY_BOX=C:\LM_ToyBox\
SET PATH_INSTALLERS=%PATH_TOY_BOX%temp
SET PATH_APPS=%PATH_TOY_BOX%apps
SET PATH_APP_GIT=%PATH_APPS%\Git
SET PATH_APP_PY37=%PATH_APPS%\Python37
::echo PATH_APP_PY37: %PATH_APP_PY37%

mkdir %PATH_TOY_BOX%
mkdir %PATH_INSTALLERS%
mkdir %PATH_APPS%
mkdir %PATH_APP_GIT%
mkdir %PATH_APP_PY37%
::dir %PATH_INSTALLERS%


:: Download Git into temp folder
::   https://git-scm.com/download/win
::   
SET FILE_GIT=Git-2.23.0-64-bit.exe
SET URL_GIT=https://github.com/git-for-windows/git/releases/download/v2.23.0.windows.1/%FILE_GIT%
::echo URL_GIT: %URL_GIT%

:: Download Python into temp folder
::   https://www.python.org/downloads/windows/
SET FILE_PY37=python-3.7.4-amd64.exe
SET URL_PY37=https://www.python.org/ftp/python/3.7.4/%FILE_PY37%
::echo URL_PY37: %URL_PY37%

:: NOTE: Download with PowerShell
::   https://superuser.com/questions/25538/how-to-download-files-from-command-line-in-windows-like-wget-or-curl
::$client = new-object System.Net.WebClient
::$client.DownloadFile("http://www.xyz.net/file.txt","C:\tmp\file.txt")



:: NOTE: PS commands can be only runned in PS
::   https://www.pdq.com/blog/writing-your-first-powershell-script/

:: NOTE: Running PS script will throw permission error.
:: Restricted – Scripts won’t run. Period. (Default setting)
:: In order to change the execution policy, we will need to reopen PowerShell as an Administrator 
:: (the command will fail otherwise) and run the following command:
::Set-ExecutionPolicy RemoteSigned
::Set-ExecutionPolicy Restricted

:: NOTE: Run PS as admin
::   https://www.top-password.com/blog/tag/open-windows-powershell-from-command-prompt/
::   https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-6
::Start-Process powershell -Verb runAs
::PowerShell -Command "& {Write-Host "Hello, World!"}"
::PowerShell -Command "& {Set-ExecutionPolicy RemoteSigned}"
::PowerShell -Command "& {Start-Process PowerShell -Verb RunAs}"
::PowerShell -Command "& {Start-Process -FilePath PowerShell -Verb RunAs -ArgumentList "-File","init.ps1"}"
::PowerShell -Command "& {Start-Process -FilePath PowerShell -Verb RunAs -ArgumentList '-Command','HELLO'}"
::PowerShell -Command "& {Start-Process -FilePath PowerShell -Verb RunAs -ArgumentList '-Command pause'}"
::PowerShell -Command "& {Start-Process -FilePath PowerShell -Verb RunAs -ArgumentList '-Command Write-Host Hello; pause'}"
::PowerShell -Command "& {Start-Process -FilePath PowerShell -Verb RunAs -ArgumentList '-Command Set-ExecutionPolicy RemoteSigned; pause'}"
echo.
echo Next I will change PowerShell ExecutionPolicy into RemoteSigned.
echo With this permission I can execute my unsigened scrpit.
echo Windows will as you to give permission for me to make changes to this device.
pause
PowerShell -Command "& {Start-Process -FilePath PowerShell -Verb RunAs -Wait -ArgumentList '-Command Set-ExecutionPolicy RemoteSigned'}"

echo.
echo Now I will run my script 'init.ps1'.
pause
PowerShell -File init.ps1

:: Set ExecutionPolicy back to Restricted
echo.
echo Next I will change PowerShell ExecutionPolicy back to Restricted.
echo With this permission no one can execute unsigened scrpit.
echo Windows will as you to give permission for me to make changes to this device.
pause
PowerShell -Command "& {Start-Process -FilePath PowerShell -Verb RunAs -ArgumentList '-Command Set-ExecutionPolicy Restricted'}"


:: Install Git
call %PATH_APP_GIT%\bin\git.exe --version
::if %errorlevel% neq 0 exit /b %errorlevel%
:: Install only if not found.
if %errorlevel% neq 0 (
	:: Got error. Git is not yet installed.
	echo.
	echo Install Git
	:: TODO: This path is hard coded in git.inf file. Can we pass this as parameter?
	echo " $ call %PATH_INSTALLERS%\%FILE_GIT% /SILENT /LOADINF="git.inf" /LOG="%PATH_TOY_BOX%git.log""
	call %PATH_INSTALLERS%\%FILE_GIT% /SILENT /LOADINF="git.inf" /LOG="%PATH_TOY_BOX%git.log"
) else (
	echo.
	echo Git is already installed.
)


:: NOTE: Installer will just "repair" old installation if it is installed to other location!
:: TODO: Should we remove old installation and install again? Or something *sigh*

:: Install Python
call %PATH_APP_PY37%\python.exe --version
if %errorlevel% neq 0 (
	:: Got error. Git is not yet installed.
	echo.
	echo Install Python
	echo " $ call %PATH_INSTALLERS%\%FILE_PY37% /quiet InstallAllUsers=1 TargetDir=%PATH_APP_PY37%\ PrependPath=1"
	call %PATH_INSTALLERS%\%FILE_PY37% /quiet InstallAllUsers=1 TargetDir=%PATH_APP_PY37%\ PrependPath=1
) else (
	echo.
	echo Git is already installed.
)


:: TODO: How to update PATH variable within the console.
::       Python is added into environment variable PATH.
::       But console where this script is runned will still use the old PATH.
::       And the 'setup_python_venv.bat' script will complain about missing path :(
::
:: NOTE: 'C:\LM_ToyBox\apps\Python37\Scripts\mkvirtualenv ' script will throw error:
::         "'python.exe' is not recognized as an internal or external command"

:: Fake add paths into PATH  ;)
:: NOTE: This is added into PATH by Git
:: C:\LM_ToyBox\apps\Git\cmd
PATH=%PATH_APP_GIT%\cmd\;%PATH%

:: NOTE: This is added into PATH by Python
:: C:\LM_ToyBox\apps\Python37\
:: C:\LM_ToyBox\apps\Python37\Scripts\
PATH=%PATH_APP_PY37%\;%PATH_APP_PY37%\Scripts\;%PATH%


:: Create Python virtual environment 'venv-LMAutoSetBotWin'
CALL setup_python_venv.bat

:: Launch python script. Will install applications.
CALL setup_apps.bat

echo.
echo End of script '%CURRENT_SCRIPT%'
