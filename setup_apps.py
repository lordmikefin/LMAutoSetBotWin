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
__version__ = "0.0.1"
__revision__ = "setup_apps.py  v" + __version__ + " (2019-09-23)"

import sys
import os

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


#print('PATH : ' + str(os.environ.get('PATH')))
print('VIRTUAL_ENV : ' + str(os.environ.get('VIRTUAL_ENV')))
print('')


print('Python version: ' + str(sys.version))
print('')
print('sys.prefix : ' + str(sys.prefix))
print('')

