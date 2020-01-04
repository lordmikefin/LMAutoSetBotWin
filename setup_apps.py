# -*- coding: UTF-8 -*-
"""
	setup_apps.py
	~~~~~~~~~~~~~

	This script will install all apps.

	License of this script file:
	   MIT License

	License is available online:
	  https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/LICENSE

	Latest version of this script file:
	  https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/setup_apps.py


	:copyright: (c) 2019, Mikko Niemelä a.k.a. Lord Mike (lordmike@iki.fi)
	:license: MIT License

"""

# https://thomas-cokelaer.info/tutorials/sphinx/docstring_python.html
# http://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html

#__revision__ = " $Id: actor.py 1586 2009-01-30 15:56:25Z cokelaer $ "
#__docformat__ = 'reStructuredText'

__license__ = "MIT License"
__version__ = "0.0.6"
__revision__ = "setup_apps.py  v" + __version__ + " (2019-09-30)"

import sys
import os


def print_python_enviroment_info():
	""" Print OS and system information into the console. """
	#print('PATH : ' + str(os.environ.get('PATH')))
	print('VIRTUAL_ENV    : ' + str(os.environ.get('VIRTUAL_ENV')))
	print('Python version : ' + str(sys.version))
	print('sys.prefix     : ' + str(sys.prefix))
	print('')


def activate_virtual_environment():
	""" Load Python virtual environment. """
	# http://virtualenvwrapper.readthedocs.io/en/latest/command_ref.html
	#os.system('lsvirtualenv')

	#https://docs.python.org/3/tutorial/venv.html
	#py_home = '/var/www/venv-lm-scripts/env'
	#activate_this = py_home + '/bin/activate_this.py'
	#py_home = 'C:/Users/lordmike/Envs/venv-LMAutoSetBotWin'
	py_home = os.environ.get('USERPROFILE') + '/Envs/venv-LMAutoSetBotWin'
	activate_this = py_home + '/Scripts/activate_this.py'

	with open(activate_this) as file_:
		exec(file_.read(), dict(__file__=activate_this))


# https://stackoverflow.com/questions/7791574/how-can-i-print-a-python-files-docstring-when-executing-it

if __name__ == '__main__':
	#print('main')
	#print(__doc__)
	#print(__docformat__)
	#import doctest
	#print(str(doctest.testmod()))

	print(__license__)
	print(__revision__)
	print(__version__)
	print('')

	from argparse import ArgumentParser
	parser = ArgumentParser(description=__doc__)
	# TODO: Add your arguments here
	'''
	parser.add_argument("-f", "--file", dest="myFilenameVariable",
						required=True,
						help="write report to FILE", metavar="FILE")
	'''
	args = parser.parse_args()
	#print(args.myFilenameVariable)

	print_python_enviroment_info()
	activate_virtual_environment()
	print_python_enviroment_info()

	# TODO: Import at top of this script.
	# TODO: Activat 'setup_apps' module with function call !
	import setup_apps

	setup_apps.connect_samba_share()
	setup_apps.npp.run()
	setup_apps.java.run()
	setup_apps.eclipse.run()
	setup_apps.pydev.run()
	setup_apps.putty.run()

