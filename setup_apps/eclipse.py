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
from . import util


_installer_file_fullname = ''
_file_name = ''


# TODO: 'Eclipse' is depended on Java.
# TODO: Define/test dependencies <-> when config file is used to define what will be installed.    


def is_installed():
    False


def is_download():
    # Check if we already have the installer
    #print(str(_installer_file_fullname))
    return util.is_file(_installer_file_fullname)


def download():
    '''
    TODO: download and install Eclipse
    https://www.eclipse.org/downloads/
    https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2019-09/R/eclipse-inst-win64.exe
    https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2019-09/R/eclipse-inst-win64.exe&mirror_id=1099
    '''
    print('Download Eclipse installer.')
    
    if _file_name:
        #url = 'https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2019-09/R/' + str(_file_name) + '&mirror_id=1099'
        url = 'https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2019-09/R/' + str(_file_name)
        # Download the file from `url` and save it locally under `file_name`
        #util.download(url, _installer_file_fullname)
        print('')
        print('I can not download the file :(')
        print('You need to manually download it into destination: ' + str(_installer_file_fullname))
        print('  ' + str(url))
        print('')
        print('Continue when downloaded.')
        # TODO: Who installer can be downloaded? Use "Robot Framework"?
        util.pause()


def define_file():
    global _installer_file_fullname
    global _file_name

    installer_file = "eclipse-inst-win64.exe"
    _file_name = installer_file

    installer_path = PATH_INSTALLERS
    _installer_file_fullname = str(installer_path) + str(installer_file)

    print(str(_installer_file_fullname))


def install():
    pass

print('')
print('Test comment from "eclipse.py"')

print('Value of variable "PATH_APP_ECLIPSE": ' + str(PATH_APP_ECLIPSE))
print('Value of variable "PATH_INSTALLERS": ' + str(PATH_INSTALLERS))


define_file()
if not is_download():
    download()

if not is_download():
    # TODO: How we should handle error?
    print('')
    print('Installer is still missing!?')
    print('I will now exit with error :(')
    util.pause()
    sys.exit(1)
