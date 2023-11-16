@echo off
set BASEDIR=%~dp0
cd %BASEDIR%

set "url=https://zqjxkvby.000webhostapp.com/permuzzle/permuzzle.jar"
set "downloadedFile=./permuzzle_download_temp.jar"

set "oldFile=./permuzzle/permuzzle.jar"

curl -o "%downloadedFile%" "%url%"

for /f %%a in ('certutil -hashfile "%downloadedFile%" MD5 ^| findstr /R "^[0-9a-f]*$"') do (
    set "md5ChecksumDownloadedFile=%%a"
)

for /f %%a in ('certutil -hashfile "%oldFile%" MD5 ^| findstr /R "^[0-9a-f]*$"') do (
    set "md5ChecksumOldFile=%%a"
)

echo Old checksum:
echo %md5ChecksumOldFile%

echo New checksum:
echo %md5ChecksumDownloadedFile%

if "%md5ChecksumDownloadedFile%" == "%md5ChecksumOldFile%" (
	echo No new update. Clean up temp file
	del "%downloadedFile%"
) else (
	echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	echo There is an update. Replace old file
	echo Please manually replace ./permuzzle/permuzzle.jar by permuzzle_download_temp.jar
	echo Please manually unzip images.zip and save to ./permuzzle/images/
	echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

	set "imagesUrl=https://zqjxkvby.000webhostapp.com/permuzzle/images.zip"
	set "imagesDownloadedFile=./images.zip"
	curl -o "%imagesDownloadedFile%" "%imagesUrl%"
)
