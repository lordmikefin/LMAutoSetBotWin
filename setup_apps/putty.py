# -*- coding: UTF-8 -*-
"""
	npp.py
	~~~~~~

	Install Putty and assosiated soft

	License of this script file:
	   MIT License

	License is available online:
	  https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/LICENSE

	Latest version of this script file:
	  https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/setup_apps/putty.py


	:copyright: (c) 2019, Mikko Niemelä a.k.a. Lord Mike (lordmike@iki.fi)
	:license: MIT License
"""

from . import PATH_APP_PUTTY, PATH_INSTALLERS
from . import util


import os


_putty_ver = ''
_installer_file_fullname = ''
_file_name = ''


def is_installed():
	# TODO: how to test putty exists
	#   https://the.earth.li/~sgtatham/putty/0.73/htmldoc/Chapter3.html#using-cmdline
	command = str(PATH_APP_PUTTY) + '\\putty'
	print(str(command))
	res = int(os.system(command))
	if res > 0:
		print('Putty NOT installed.')
		return False

	print('Putty already installed.')
	return True


def is_download():
	# \\192.168.122.1\sambashare\windows\putty-0.73.tar.gz
	# By now \\192.168.122.1\sambashare\windows\ should be bind to W: drive
	print(str(_installer_file_fullname))

	# https://stackabuse.com/python-check-if-a-file-or-directory-exists/
	return os.path.isfile(_installer_file_fullname)


def download():
	# https://stackoverflow.com/questions/7243750/download-file-from-web-in-python-3
	# TODO: download file from web
	#   Verify downloaded file is what we were downloading.

	# https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
	# https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.73-installer.msi
	print('Download Putty installer.')
	
	if _file_name:
		url = 'https://the.earth.li/~sgtatham/putty/latest/w64/' + str(_file_name)
		## Download the file from `url` and save it locally under `file_name`
		#file_name, headers = urllib.request.urlretrieve(url, _installer_file_fullname)
		#print('file_name : ' + str(file_name))
		#print('headers   : ' + str(headers))
		util.download(url, _installer_file_fullname)


def install():
	# Install Putty

	# https://stackoverflow.com/questions/14894993/running-windows-shell-commands-with-python

	# Silent (unattended) install
	# http://www.silentinstall.org/msiexec
	# http://mylittlespotinthebigunknown.blogspot.com/2018/04/automating-putty-07-msi-install.html

	command = 'START "Putty Install" /WAIT msiexec /qb '
	command = command + ' /L*V PuttyInstall.log '
	command = command + ' /i ' + str(_installer_file_fullname)
	#command = command + ' INSTALLDIR="C:\Program Files\PuTTY\" '
	command = command + ' ACTION=INSTALL '
	command = command + ' ADDLOCAL=FilesFeature,DesktopFeature,PathFeature,PPKFeature '
	print('Start Putty installer.')
	print(command)
	print('')
	print(' Installing ... wait ... wait ... ')
	print('')
	res = int(os.system(command))
	print('')
	if res > 0:
		# TODO: Installer may not throw error ?
		print('Putty installation FAILED.')
		#sys.exit(1)
		return False
	else:
		print('Putty installation done.')
		return True


def define_file():
	global _putty_ver
	global _installer_file_fullname
	global _file_name

	_putty_ver = '0.73'
	installer_file = 'putty-64bit-' + _putty_ver + '-installer.msi'
	_file_name = installer_file

	#installer_path = "W:/"
	installer_path = PATH_INSTALLERS
	_installer_file_fullname = str(installer_path) + str(installer_file)

	print(str(_installer_file_fullname))


def run():
	# TODO: Download Putty

	# TODO: Install Putty

	print('Test comment from "putty.py"')

	print('Value of variable "PATH_APP_PUTTY": ' + str(PATH_APP_PUTTY))
	print('Value of variable "PATH_INSTALLERS": ' + str(PATH_INSTALLERS))

	define_file_npp()
	if not is_download():
		download()

	if not is_installed():
		install()

