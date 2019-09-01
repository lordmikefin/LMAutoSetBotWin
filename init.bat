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

SET CURRENT_SCRIPT_VER=0.0.1
SET CURRENT_SCRIPT_DATE=2019-09-01
SET CURRENT_SCRIPT=init.bat
echo CURRENT_SCRIPT_VER: %CURRENT_SCRIPT_VER% (%CURRENT_SCRIPT_DATE%)

:: TODO: Create directory for Installer and install path.
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

:: TODO: Download with PowerShell
::   https://superuser.com/questions/25538/how-to-download-files-from-command-line-in-windows-like-wget-or-curl
::$client = new-object System.Net.WebClient
::$client.DownloadFile("http://www.xyz.net/file.txt","C:\tmp\file.txt")

:: NOTE: PS commands can be only runned in PS
::   https://www.pdq.com/blog/writing-your-first-powershell-script/

:: NOTE: Running PS script will throw permission error.
:: In order to change the execution policy, we will need to reopen PowerShell as an Administrator 
:: (the command will fail otherwise) and run the following command:
::Set-ExecutionPolicy RemoteSigned

:: NOTE: Run PS as admin
::   https://www.top-password.com/blog/tag/open-windows-powershell-from-command-prompt/
::Start-Process powershell -Verb runAs
powershell -Command {Start-Process powershell -Verb runAs}
powershell -Command {Start-Process powershell -Verb runAs -File init.ps1}
powershell -File init.ps1


echo.
echo End of script '%CURRENT_SCRIPT%'
