
LordMike's Automatic Setup Bot for Windows
==========================================


( Guide is under construction :)


This project contains tools to install and setup all application as you like them to be.

Quick installation quide.
This will get needed stuff under folder C:\\LM_ToyBox\\


Install guide
-------------

.. code-block:: batch

 C:
 
 mkdir C:\LM_ToyBox
 cd C:\LM_ToyBox
 
 mkdir C:\LM_ToyBox\temp
 cd C:\LM_ToyBox\temp
 
 PowerShell -Command "& {$client = new-object System.Net.WebClient; $client.DownloadFile('https://github.com/lordmikefin/LMAutoSetBotWin/releases/download/v0.0.11/LMAutoSetBotWin-v0.0.11.zip','.\LMAutoSetBotWin-v0.0.11.zip')}"
 PowerShell -Command "Expand-Archive '.\LMAutoSetBotWin-v0.0.11.zip' '.\LMAutoSetBotWin\'"
 
 cd C:\LM_ToyBox\temp\LMAutoSetBotWin\
 
 batch\UAC-Disable.bat
 :: Reboot !
 
 cd C:\LM_ToyBox\temp\LMAutoSetBotWin\
 init.bat
 
 cd C:\LM_ToyBox\temp\LMAutoSetBotWin\
 batch\UAC-Enable.bat
 :: Reboot !



Clone the project using SSH
---------------------------

.. code-block:: bash

 git clone git@github.com:lordmikefin/LMAutoSetBotWin.git
 
 cd LMAutoSetBotWin/
 
 git submodule init
 git submodule update
 
 # Set ssh urls for submodules
 cd setup_apps
 
 git checkout master
 git remote -v
 git remote set-url origin git@github.com:lordmikefin/setup_apps.git
 
 cd ../LMToyBoxPython
 git checkout master
 git remote -v
 git remote set-url origin git@github.com:lordmikefin/LMToyBoxPython.git
 
 cd ../app_source_handler
 git checkout master
 git remote -v
 git remote set-url origin git@github.com:lordmikefin/app_source_handler.git


Github action script
--------------------

zip package file is now auto created with Github action workflow script.

I have small project github-action-release_ where I have tested how to use Github actions.

.. _github-action-release: https://github.com/lordmikefin/github-action-release
