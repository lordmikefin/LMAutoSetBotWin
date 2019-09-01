
LordMike's Automatic Setup Bot for Windows
==========================================


( Guide is under construction :)


This project contains tools to install and setup all application as you like them to be.

Quick installation quide.
This will get needed stuff under folder C:\\LM_ToyBox\\

Download this project master.zip_

.. _master.zip: https://github.com/lordmikefin/LMAutoSetBotWin/archive/master.zip

Extract and run file "init.bat"

.. code-block:: batch

 C:
 
 mkdir C:\LM_ToyBox
 cd C:\LM_ToyBox
 
 mkdir C:\LM_ToyBox\temp
 cd C:\LM_ToyBox\temp
 
 PowerShell -Command "& {$client = new-object System.Net.WebClient; $client.DownloadFile('https://github.com/lordmikefin/LMAutoSetBotWin/archive/master.zip','.\LMAutoSetBotWin-master.zip')}"
 PowerShell -Command "Expand-Archive '.\LMAutoSetBotWin-master.zip' '.\'"
 
 cd C:\LM_ToyBox\temp\LMAutoSetBotWin\
 init.bat
