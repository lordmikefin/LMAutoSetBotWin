# -*- coding: UTF-8 -*-
"""
	util.py
	~~~~~~~

	Usefull tools.

	License of this script file:
	   MIT License

	License is available online:
	  https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/LICENSE

	Latest version of this script file:
	  https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/setup_apps/util.py


	:copyright: (c) 2019, Mikko Niemelä a.k.a. Lord Mike (lordmike@iki.fi)
	:license: MIT License
"""

import os
import sys
import urllib.request

PWS='powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile'

def download(url: str, dst: str):
    # Download the file from `url` and save it locally under `file_name`
    file_name, headers = urllib.request.urlretrieve(url, dst)
    print('file_name : ' + str(file_name))
    print('headers   : ' + str(headers))

    # TODO: How to show the progress?


def pause():
    '''
    Pause the console app. Windows only!

    https://stackoverflow.com/questions/11552320/correct-way-to-pause-python-program
    '''
    os.system("pause")


def is_file(file: str) -> bool:
    '''
    Is given string pointing to file.
    '''
    return os.path.isfile(file)


def unzip(zip_file: str, dst: str):
    print('Unzip the file')
    command = 'PowerShell -Command "Expand-Archive \'' + str(zip_file) + '\' \'' + str(dst) + '\'"'
    res = int(os.system(command))
    # TODO: How to handle possible errors?

def shortcut(exe_file: str, dst_link_file: str, ico: str=''):
    '''
    Create shortcut file
    
    https://stackoverflow.com/questions/30028709/how-do-i-create-a-shortcut-via-command-line-in-windows
    https://superuser.com/questions/392061/how-to-make-a-shortcut-from-cmd/392066
    https://stackoverflow.com/questions/346107/creating-a-shortcut-for-a-exe-from-a-batch-file
    '''
    print('Creating the shortcut file')
    command = '$ws = New-Object -ComObject WScript.Shell; '
    command += '$s = $ws.CreateShortcut(\'' + dst_link_file + '\'); '
    command += '$s.TargetPath = \'' + exe_file + '\'; '
    #command += '$s.IconLocation = \'' + ico + '\'; '
    #command += '$s.Description = \'' + desc + '\'; '
    #command += '$s.WorkingDirectory = \'' + dir + '\'; '
    command += '$s.Save(); '
    command = PWS + ' -Command "' + command + '"'
    print(command)
    res = int(os.system(command))
    # TODO: How to handle possible errors?
