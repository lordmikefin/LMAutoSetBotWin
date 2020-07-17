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
__version__ = "0.0.9"
__revision__ = "setup_apps.py  v" + __version__ + " (2020-07-17)"

import sys
import os
import logging
from datetime import datetime
import traceback
import ctypes

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



def conf_root_logger():
    # Default log level.
    logging.basicConfig(level=logging.DEBUG)

def create_formatter(log_log_point: bool=True):
    #formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s: %(message)s')
    #formatter = logging.Formatter('%(name)-10s - %(levelname)-4s: %(message)s')
    f_str = '[%(name)-10s] %(levelname)-4s: %(message)s'
    if log_log_point:
        f_str += ' [%(pathname)s:%(lineno)d]'
    formatter = logging.Formatter(f_str)
    return formatter

def create_hand_file(log_file_name: str):
    hand = logging.FileHandler(log_file_name)
    hand.setLevel(logging.DEBUG)
    hand.setFormatter(create_formatter(log_log_point=False))
    return hand

def create_hand_stdout():
    hand_stdout = logging.StreamHandler(stream=sys.stdout)
    hand_stdout.setLevel(logging.DEBUG)
    hand_stdout.setFormatter(create_formatter())
    return hand_stdout

def create_hand_stderr():
    hand_stderr = logging.StreamHandler(stream=sys.stderr)
    hand_stderr.setLevel(logging.ERROR)
    #hand_stderr.setFormatter(create_formatter())
    f_str = '[%(name)-10s] %(levelname)-4s: %(message)s [%(pathname)s:%(lineno)d]'
    formatter = logging.Formatter(f_str)
    hand_stderr.setFormatter(formatter)
    return hand_stderr

def conf_setup_apps_logger(log_file_name: str=''):
    #logger_conf = setup_apps.logger
    logger_conf = logging.getLogger('setup_apps')
    logger_conf.addHandler(create_hand_stdout())
    logger_conf.addHandler(create_hand_stderr())
    if log_file_name:
        logger_conf.addHandler(create_hand_file(log_file_name))

def conf_app_source_handler_logger(log_file_name: str=''):
    logger_conf = logging.getLogger('app_source_handler')
    logger_conf.addHandler(create_hand_stdout())
    logger_conf.addHandler(create_hand_stderr())
    if log_file_name:
        logger_conf.addHandler(create_hand_file(log_file_name))

def conf_LMToyBoxPython_handler_logger(log_file_name: str=''):
    logger_conf = logging.getLogger('LMToyBoxPython')
    logger_conf.addHandler(create_hand_stdout())
    logger_conf.addHandler(create_hand_stderr())
    if log_file_name:
        logger_conf.addHandler(create_hand_file(log_file_name))

def create_logger(log_file_name: str=''):
    logger = logging.getLogger('setup_apps.py caller')
    logger.addHandler(create_hand_stdout())
    logger.addHandler(create_hand_stderr())
    if log_file_name:
        logger.addHandler(create_hand_file(log_file_name))
    logger.propagate = False
    return logger

def is_admin():
    # https://stackoverflow.com/questions/130763/request-uac-elevation-from-within-a-python-script
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False


# https://stackoverflow.com/questions/7791574/how-can-i-print-a-python-files-docstring-when-executing-it

# TODO: Import at top of this script.
# TODO: Activat 'setup_apps' module with function call !
import setup_apps

def main_process():
    # TODO: parameterise the log file name
    log_file_name = 'test.log'
    conf_root_logger()
    conf_setup_apps_logger(log_file_name)
    conf_app_source_handler_logger(log_file_name)
    conf_LMToyBoxPython_handler_logger(log_file_name)
    #LMToyBoxPython.logging_test()
    setup_apps.util.stop_urllib3_logger()

    logger = create_logger(log_file_name)
    logger.info('Start time: ' + str(datetime.now()))

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

    try:
        setup_apps.connect_samba_share()
        # TODO: xml config file should be generated separately
        # TODO: parameterise location of xml config file
        setup_apps.config.create_sample()
        setup_apps.config.print_sample()
        '''
        setup_apps.npp.run()
        setup_apps.java.run()
        setup_apps.eclipse.run()
        setup_apps.pydev.run()
        setup_apps.putty.run()
        setup_apps.git.run()
        setup_apps.python.run()
        '''
        setup_apps.config.parse()
        setup_apps.config.init()
        setup_apps.config.download()
        # TODO: got OSError: [WinError 740] The requested operation requires elevation
        # TODO: How to auto elevate console to admin?
        # TODO: check if we are a admin and notify the user
        # https://stackoverflow.com/questions/15039137/windowserror-error-740-the-requested-operation-requires-elevation-even-after
        # https://stackoverflow.com/questions/130763/request-uac-elevation-from-within-a-python-script
        setup_apps.config.install()
        setup_apps.config.configure()
    except:
        logger.error("Unexpected error: " + str(sys.exc_info()[0]))
        # print stck trace
        # https://docs.python.org/3/library/traceback.html
        #traceback.print_exc()
        formatted_lines = traceback.format_exc()
        logger.error(formatted_lines)

    logger.info('Stop time: ' + str(datetime.now()))
    setup_apps.util.pause()

if __name__ == '__main__':
    # https://stackoverflow.com/questions/130763/request-uac-elevation-from-within-a-python-script
    if is_admin():
        # Code of your program here
        main_process()
    else:
        # Re-run the program with admin rights
        ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, " ".join(sys.argv), None, 1)
        setup_apps.util.pause()
