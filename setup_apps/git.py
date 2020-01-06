# -*- coding: UTF-8 -*-
"""
	git.py
	~~~~~~

	Install Putty and assosiated soft

	License of this script file:
	   MIT License

	License is available online:
	  https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/LICENSE

	Latest version of this script file:
	  https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/setup_apps/git.py


	:copyright: (c) 2019, Mikko Niemelä a.k.a. Lord Mike (lordmike@iki.fi)
	:license: MIT License
"""

from . import PATH_APP_GIT, PATH_INSTALLERS
from . import util


import os


_git_ver = ''
_installer_file_fullname = ''
_file_name = ''


def set_env_var():
	# TODO: make util from this
	#   https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/setx
	'''
	command = 'setx GIT_SSH ' + '"' + str(_plink) + '"'
	print(str(command))
	res = int(os.system(command))
	if res > 0:
		print('GIT_SSH is not set.')
		return False

	print('GIT_SSH is set.')
	return True
	'''
	pass


def is_installed():
	# TODO: how to test git exists
	# TODO: how to update if version is different
	command = '"' + str(PATH_APP_GIT) + '\\bin\\git" --version'
	print(str(command))
	res = int(os.system(command))
	if res > 0:
		print('git NOT installed.')
		return False

	print('git already installed.')
	return True


def is_download():
	# \\192.168.122.1\sambashare\windows\putty-0.73.tar.gz
	# By now \\192.168.122.1\sambashare\windows\ should be bind to W: drive
	#print(str(_installer_file_fullname))

	# https://stackabuse.com/python-check-if-a-file-or-directory-exists/
	return os.path.isfile(_installer_file_fullname)


def download():
	# https://stackoverflow.com/questions/7243750/download-file-from-web-in-python-3
	# TODO: download file from web
	#   Verify downloaded file is what we were downloading.

	# https://github.com/git-for-windows/git/releases/download/v2.23.0.windows.1/Git-2.23.0-64-bit.exe
	# https://github.com/git-for-windows/git/releases/download/v2.24.1.windows.2/Git-2.24.1.2-64-bit.exe
	# https://github.com/git-for-windows/git/releases/tag/v2.24.1.windows.2
	print('Download git installer.')
	
	if _file_name:
		url = 'https://github.com/git-for-windows/git/releases/download/v2.24.1.windows.2/' + str(_file_name)
		util.download(url, _installer_file_fullname)


def install():
	# Install git

	# https://stackoverflow.com/questions/14894993/running-windows-shell-commands-with-python

	# TODO: Silent (unattended) install

	command = _installer_file_fullname + ' /SILENT '
	command = command + ' /LOADINF="git.inf" '
	command = command + ' /LOG="git-install.log" '
	command = command + ' /DIR="' + PATH_APP_GIT + '"'
	print('Start git installer.')
	print(command)
	print('')
	print(' Installing ... wait ... wait ... ')
	print('')
	res = int(os.system(command))
	print('')
	if res > 0:
		# TODO: Installer may not throw error ?
		print('git installation FAILED.')
		#sys.exit(1)
		return False
	else:
		print('git installation done.')
		return True


def define_file():
	global _git_ver
	global _installer_file_fullname
	global _file_name

	# https://github.com/git-for-windows/git/releases/download/v2.23.0.windows.1/Git-2.23.0-64-bit.exe
	# https://github.com/git-for-windows/git/releases/download/v2.24.1.windows.2/Git-2.24.1.2-64-bit.exe
	# https://github.com/git-for-windows/git/releases/tag/v2.24.1.windows.2

	_git_ver = '2.24.1'
	installer_file = 'Git-' + _git_ver + '.2-64-bit.exe'
	_file_name = installer_file

	#installer_path = "W:/"
	installer_path = PATH_INSTALLERS
	_installer_file_fullname = str(installer_path) + str(installer_file)

	print(str(_installer_file_fullname))


def run():
	# TODO: Download Putty

	# TODO: Install Putty

	print('')
	print('Test comment from "git.py"')

	print('Value of variable "PATH_APP_GIT": ' + str(PATH_APP_GIT))
	print('Value of variable "PATH_INSTALLERS": ' + str(PATH_INSTALLERS))

	define_file()
	if not is_download():
		download()

	if not is_installed():
		install()

	#set_env_var()

