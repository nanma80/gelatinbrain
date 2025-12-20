@echo off
set BASEDIR=%~dp0
cd %BASEDIR%

set "url=https://zqjxkvby.com/permuzzle/permuzzle.jar"
set "downloadedFile=./permuzzle_download_temp.jar"
set "imagesUrl=https://zqjxkvby.com/permuzzle/images.zip"
set "imagesDownloadedFile=./images_download_temp.zip"
set "oldFile=./permuzzle/permuzzle.jar"
set MIN_SIZE=1048576

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

for %%F in ("%downloadedFile%") do (
    set size=%%~zF
)

for %%F in ("%downloadedFile%") do (
    echo New file size: %%~zF bytes
    if %%~zF LSS %MIN_SIZE% (
        echo New file smaller than 1MB. Not real game file. Likely network issues. Clean up temp file and ignore
		del "%downloadedFile%"
    ) else if "%md5ChecksumDownloadedFile%" == "%md5ChecksumOldFile%" (
		echo No new update. Clean up temp file
		del "%downloadedFile%"
	) else (
		echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		echo There is an update. Replacing old file
		echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

		curl -o "%imagesDownloadedFile%" "%imagesUrl%"

		move /y "permuzzle_download_temp.jar" ".\permuzzle\permuzzle.jar"
		move /y "images_download_temp.zip" ".\permuzzle\images.zip"
	)
)

echo The current local date time is: %DATE% %TIME%