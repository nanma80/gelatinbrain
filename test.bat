@echo off
set BASEDIR=%~dp0
cd %BASEDIR%

set "url=https://qjxkvbyz.000webhostapp.com/permuzzle/permuzzle.jar"
set "downloadedFile=./permuzzle_download_temp.jar"
curl --ssl-reqd -o "%downloadedFile%" "%url%"
