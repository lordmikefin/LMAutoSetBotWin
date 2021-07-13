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
::   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/python/setup_apps.bat

:: setup_apps.bat
:: This script will start python script.
:: 
:: The python script will download and install.
::  - Notepad++

SET CURRENT_SCRIPT_VER=0.0.3
SET CURRENT_SCRIPT_DATE=2020-07-17
SET CURRENT_SCRIPT=setup_apps.bat
echo CURRENT_SCRIPT_VER: %CURRENT_SCRIPT_VER% (%CURRENT_SCRIPT_DATE%)

:: Is python installed?
python --version
echo.
if %errorlevel% neq 0 exit /b %errorlevel%

:: Activate python virtual environment 'venv-LMAutoSetBotWin'.
echo.
echo I will try to use virtual environment 'venv-LMAutoSetBotWin'.
echo All my python scripts will use this environment.
echo.
::call %USERPROFILE%\Envs\venv-LMAutoSetBotWin\Scripts\activate.bat
call workon venv-LMAutoSetBotWin
SET SUCCESS=0
if %errorlevel% neq 0 ( 
	SET SUCCESS=0
	
	echo.
	echo Virtual environment 'venv-LMAutoSetBotWin' not found.
	echo.
	echo Run 'setup_python_venv.bat' first.
	echo It will initialize every thing for you.
	echo.
	pause
	call exit /b %errorlevel%
	
) else ( 
	SET SUCCESS=1
	echo.
	echo Now workon 'venv-LMAutoSetBotWin'
	echo.
)


:: http://virtualenvwrapper.readthedocs.io/en/latest/command_ref.html
echo. 
echo Current virtual environment:
echo %VIRTUAL_ENV%
echo. 


echo. 
echo Current virtual variable PATH:
echo %PATH%
echo. 


:: Run the python script
echo.
echo Run script setup_apps.py
echo.
call python setup_apps.py
echo.
if %errorlevel% neq 0 (
	:: Deactivate python venv
	echo.
	echo Exit from virtual environment 'venv-LMAutoSetBotWin'.
	echo  $ deactivate
	echo.
	::deactivate
	::call %USERPROFILE%\Envs\venv-LMAutoSetBotWin\Scripts\deactivate.bat
	call deactivate
	
	pause
	exit /b %errorlevel%
)


echo. 
echo Current virtual variable PATH:
echo %PATH%
echo. 


:: Deactivate python venv
echo.
echo Exit from virtual environment 'venv-LMAutoSetBotWin'.
echo  $ deactivate
echo.
::deactivate
::call %USERPROFILE%\Envs\venv-LMAutoSetBotWin\Scripts\deactivate.bat
call deactivate
if %errorlevel% neq 0 (
	pause
	exit /b %errorlevel%
)
echo.


echo.
echo End of script '%CURRENT_SCRIPT%'
