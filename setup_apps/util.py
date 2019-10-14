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
import urllib.request


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

