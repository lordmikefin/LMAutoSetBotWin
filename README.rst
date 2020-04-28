
LordMike's Automatic Setup Bot for Windows
==========================================


( Guide is under construction :)


This project contains tools to install and setup all application as you like them to be.

Quick installation quide.
This will get needed stuff under folder C:\\LM_ToyBox\\

The new install quide
---------------------

.. code-block:: batch

 C:
 
 mkdir C:\LM_ToyBox
 cd C:\LM_ToyBox
 
 mkdir C:\LM_ToyBox\temp
 cd C:\LM_ToyBox\temp
 
 PowerShell -Command "& {$client = new-object System.Net.WebClient; $client.DownloadFile('https://github.com/lordmikefin/LMAutoSetBotWin/releases/download/v0.0.1/LMAutoSetBotWin.zip','.\LMAutoSetBotWin.zip')}"
 PowerShell -Command "Expand-Archive '.\LMAutoSetBotWin.zip' '.\'"
 
 cd C:\LM_ToyBox\temp\LMAutoSetBotWin\
 
 UAC-Disable.bat
 :: Reboot !
 
 cd C:\LM_ToyBox\temp\LMAutoSetBotWin\
 init.bat
 
 cd C:\LM_ToyBox\temp\LMAutoSetBotWin\
 UAC-Enable.bat
 :: Reboot !


This is old one
---------------

Download this project master.zip_

.. _master.zip: https://github.com/lordmikefin/LMAutoSetBotWin/archive/master.zip

Also download needed submodule project sa-master.zip_

.. _sa-master.zip: https://github.com/lordmikefin/setup_apps/archive/master.zip

Extract and run file "init.bat".

Here is command line instructions to run the Bot :)

NOTE: UAC will be disabled. You should enable UAC at end.

.. code-block:: batch

 C:
 
 mkdir C:\LM_ToyBox
 cd C:\LM_ToyBox
 
 mkdir C:\LM_ToyBox\temp
 cd C:\LM_ToyBox\temp
 
 PowerShell -Command "& {$client = new-object System.Net.WebClient; $client.DownloadFile('https://github.com/lordmikefin/LMAutoSetBotWin/archive/master.zip','.\LMAutoSetBotWin-master.zip')}"
 PowerShell -Command "Expand-Archive '.\LMAutoSetBotWin-master.zip' '.\'"
 
 PowerShell -Command "& {$client = new-object System.Net.WebClient; $client.DownloadFile('https://github.com/lordmikefin/setup_apps/archive/master.zip','.\setup_apps-master.zip')}"
 PowerShell -Command "Expand-Archive '.\setup_apps-master.zip' '.\LMAutoSetBotWin-master\'"
 copy ".\LMAutoSetBotWin-master\setup_apps-master\*" ".\LMAutoSetBotWin-master\setup_apps\"
 
 cd C:\LM_ToyBox\temp\LMAutoSetBotWin-master\
 rmdir setup_apps
 
 UAC-Disable.bat
 :: Reboot !
 
 cd C:\LM_ToyBox\temp\LMAutoSetBotWin-master\
 init.bat
 
 cd C:\LM_ToyBox\temp\LMAutoSetBotWin-master\
 UAC-Enable.bat
 :: Reboot !

Clone the project using SSH.

.. code-block:: bash

 git clone git@github.com:lordmikefin/LMAutoSetBotWin.git
 
 cd LMAutoSetBotWin/
 
 git submodule init
 git submodule update
 
 cd setup_apps
 
 git checkout master
 git remote -v
 git remote set-url origin git@github.com:lordmikefin/setup_apps.git
