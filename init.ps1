#C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe

# Copyright (c) 2019, Mikko Niemelä a.k.a. Lord Mike (lordmike@iki.fi)
# 
# License of this script file:
#   MIT License
# 
# License is available online:
#   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/LICENSE
# 
# Latest version of this script file:
#   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/init.ps1

# init.ps1
# This script will install software for my other scripts :)
# Download and install.
#  - Git
#  - Python

#URL_PY37
#Write-Host "URL_PY37: %URL_PY37%"
#$url_py37=Get-Item Env:URL_PY37
#$url_py37=& {Get-Item Env:URL_PY37}
#Write-Host "URL_PY37:" $url_py37

#Get-Variable *P*

# Get variable from outside of this script and print it.
Write-Host "URL_PY37:" ${Env:URL_PY37}
