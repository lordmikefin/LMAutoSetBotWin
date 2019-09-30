# -*- coding: UTF-8 -*-
"""
    setup_apps
    ~~~~~~~~~~

    Module for installing windows applictions.

    License of this script file:
       MIT License

    License is available online:
      https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/LICENSE

    Latest version of this script file:
      https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/setup_apps/__init__.py


    :copyright: (c) 2019, Mikko Niemelä a.k.a. Lord Mike (lordmike@iki.fi)
    :license: MIT License
"""

'''
These lines are copied from init.bat (2019-09-30)

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
'''


# Listing initialiazion (init.bat) phase paths.
# TODO: Are these needed?
INIT_PATH_TOY_BOX = 'C:\\LM_ToyBox\\'
INIT_PATH_INSTALLERS = INIT_PATH_TOY_BOX + 'temp'
INIT_PATH_APPS = INIT_PATH_TOY_BOX + 'apps'
INIT_PATH_APP_GIT = INIT_PATH_APPS + '\\Git'
INIT_PATH_APP_PY37 = INIT_PATH_APPS + '\\Python37'


# TODO: Get paths from config file.

# Using default paths for downloading and installing apps.
PATH_ROOT = 'D:\\'
PATH_TOY_BOX = PATH_ROOT + 'LM_ToyBox\\'
#PATH_INSTALLERS = PATH_TOY_BOX + 'temp'
PATH_INSTALLERS = PATH_TOY_BOX + 'download'
#PATH_APPS = PATH_TOY_BOX + 'apps'
PATH_APPS = PATH_ROOT + 'apps'

PATH_APP_GIT = PATH_APPS + '\\Git'
PATH_APP_PY37 = PATH_APPS + '\\Python37'
PATH_APP_NPP = PATH_APPS + '\\Notepad++'


from . import npp

