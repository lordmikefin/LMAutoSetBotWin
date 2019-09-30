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
::  https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/setup_python_venv.bat

:: This script will setup Python virtual environment for my scripts :)


:: TODO: How to update PATH variable within the console.
::       Python is added into environment variable PATH by 'init.bat' script.
::       But console where that script is runned will still use the old PATH.
::       And the this script will complain about missing path :(
:: 
:: NOTE: For now 'init.bat' will add paths into local PATH variable!



SET CURRENT_SCRIPT=setup_python_venv.bat
SET CURRENT_SCRIPT_VER=0.0.4
SET CURRENT_SCRIPT_DATE=2019-09-30
echo CURRENT_SCRIPT_VER: %CURRENT_SCRIPT_VER% (%CURRENT_SCRIPT_DATE%)
echo.

:: TODO: These are copied from 'init.bar' script
:: Define path.
SET PATH_TOY_BOX=C:\LM_ToyBox\
SET PATH_VENV=%PATH_TOY_BOX%venv
SET PATH_INSTALLERS=%PATH_TOY_BOX%temp
SET PATH_APPS=%PATH_TOY_BOX%apps
SET PATH_APP_GIT=%PATH_APPS%\Git
SET PATH_APP_PY37=%PATH_APPS%\Python37

SET APP_PY37=%PATH_APP_PY37%\python.exe
SET APP_PIP37=%PATH_APP_PY37%\Scripts\pip
SET APP_MKVENV=%PATH_APP_PY37%\Scripts\mkvirtualenv
::python --version
CALL %APP_PY37% --version
echo.
if %errorlevel% neq 0 exit /b %errorlevel%

:: Make sure we are using the lates pip version.
echo.
echo Make sure we are using the lates pip version.
echo  $ CALL %APP_PY37% -m pip install --upgrade pip
CALL %APP_PY37% -m pip install --upgrade pip


echo.
echo Installing root environment (Python) modules.
echo.
::CALL pip install -U -r root_environment_requirements_win.txt
CALL %APP_PIP37% install -U -r root_environment_requirements_win.txt
echo.
echo.
if %errorlevel% neq 0 exit /b %errorlevel%


echo List of 'Root' environment modules
echo  $ pip list --format=columns
echo.
::pip list 
::call pip list --format=columns
call %APP_PIP37% list --format=columns
echo.
echo.
if %errorlevel% neq 0 exit /b %errorlevel%


:: TODO: list all virtual environments


echo.
echo I will try to use virtual environment 'venv-LMAutoSetBotWin'.
echo All my python scripts will use this environment.
echo.
::call %USERPROFILE%\Envs\venv-LMAutoSetBotWin\Scripts\activate.bat
::%PATH_VENV%
call workon venv-LMAutoSetBotWin
SET SUCCESS=0
if %errorlevel% neq 0 ( 
	SET SUCCESS=0
	
	:: clear the error level
	::cmd /c exit 0
	::call cmd /c "exit /b 0"
	::VERIFY > nul
	::echo errorlevel: %errorlevel%
	echo.
	echo Virtual environment 'venv-LMAutoSetBotWin' not found.
	echo Next I will create the venv.
	echo.
	pause
	
) else ( 
	SET SUCCESS=1
	echo.
	echo Virtual environment 'venv-LMAutoSetBotWin' already exists.
	echo Now workon venv-LMAutoSetBotWin
	echo.
)


:: clear the error level
::(call)
:: (call )
::VERIFY > nul
::set errorlevel=
echo SUCCESS: %SUCCESS%
::echo errorlevel: %errorlevel%
::exit /b 0

if %SUCCESS% neq 1 ( 
	echo errorlevel: %errorlevel%
	echo I will create a new virtual environment 'venv-LMAutoSetBotWin'
	echo  $ call %APP_MKVENV% --python=%APP_PY37% venv-LMAutoSetBotWin
	echo.
	
	:: TODO: Set venv into LM_toy_box folder. Now it is set under user folder.
	::%PATH_VENV%
	
	call %APP_MKVENV% --python=%APP_PY37% venv-LMAutoSetBotWin
	:: Batch will not catch the error within if statement?!?!?! WTF!
	::if %errorlevel% neq 0 ( 
	::	echo errorlevel: %errorlevel%
	::	pause
	::	exit /b %errorlevel%
	::)
)

echo errorlevel: %errorlevel%

:: Handle possible errors from 'call mkvirtualenv...'
if %errorlevel% neq 0 ( 
	echo errorlevel: %errorlevel%
	echo.
	echo Python 3.7 should be installed into %PATH_APP_PY37%
	echo   https://www.python.org/downloads/windows/
	echo   https://www.python.org/ftp/python/3.7.4/python-3.7.4-amd64.exe
	echo.
	echo Please run init.bat first. It should install Python in my way.
	echo.
	pause
	call exit /b %errorlevel%
)



:: http://virtualenvwrapper.readthedocs.io/en/latest/command_ref.html
echo. 
echo Current virtual environment:
echo %VIRTUAL_ENV%
echo. 


:: Make sure we are using the lates pip version.
echo.
echo Make sure we are using the lates pip version.
echo  $ CALL %APP_PY37% -m pip install --upgrade pip
CALL %APP_PY37% -m pip install --upgrade pip


echo. 
echo (venv) $ pip3 list --format=columns
echo.
call pip3 list --format=columns
echo.
echo.


echo. 
echo Install all needed Python modules into venv.
echo (venv) $ pip3 install -U -r requirements.txt
echo.
call pip3 install -U -r requirements.txt
echo.
echo.
if %errorlevel% neq 0 (
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
echo List all outdated modules.
echo (venv) $ pip3 list -o --format=columns 
echo.
call pip3 list -o --format=columns 
echo.
echo.
if %errorlevel% neq 0 exit /b %errorlevel%


echo.
echo Exit from virtual environment 'venv-LMAutoSetBotWin'.
echo  $ deactivate
echo.
::deactivate
::call %USERPROFILE%\Envs\venv-LMAutoSetBotWin\Scripts\deactivate.bat
call deactivate
if %errorlevel% neq 0 exit /b %errorlevel%
echo.


echo End of script %CURRENT_SCRIPT%
::echo Script DONE.
pause
