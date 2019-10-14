# -*- coding: UTF-8 -*-
"""
	eclipse.py
	~~~~~~~~~~

	Install Eclipse.

	License of this script file:
	   MIT License

	License is available online:
	  https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/LICENSE

	Latest version of this script file:
	  https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/setup_apps/eclipse.py


	:copyright: (c) 2019, Mikko Niemelä a.k.a. Lord Mike (lordmike@iki.fi)
	:license: MIT License
"""

from . import PATH_APP_ECLIPSE, PATH_INSTALLERS

import os


_installer_file_fullname = ''
_file_name = ''


# TODO: 'Eclipse' is depended on Java.
# TODO: Define/test dependencies <-> when config file is used to define what will be installed.	


def is_installed():
	False

def is_download():
	# Check if we already have the installer
	print(str(_installer_file_fullname))
	return os.path.isfile(_installer_file_fullname)

	
def install():
	'''
	TODO: download and install Eclipse
	https://www.eclipse.org/downloads/
	https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2019-09/R/eclipse-inst-win64.exe
	https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2019-09/R/eclipse-inst-win64.exe&mirror_id=1099
	'''
	pass

print('')
print('Test comment from "eclipse.py"')


