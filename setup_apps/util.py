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

import urllib.request


def download(url, dst):
    # Download the file from `url` and save it locally under `file_name`
    file_name, headers = urllib.request.urlretrieve(url, dst)
    print('file_name : ' + str(file_name))
    print('headers   : ' + str(headers))

    # TODO: How to show the progress?
