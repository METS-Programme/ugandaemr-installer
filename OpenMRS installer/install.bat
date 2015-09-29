@echo off

call "%CD%\script\openMRSEnv.bat"

REM ============================================================================
REM Checking required software are installed 
REM

SET SHOW_MISSING_SOFT_PAGE=0

SET INFOPATH_DAT_FILE=infopath.dat
SET FIREFOX_DAT_FILE=firefox.dat
SET ACROBAT_DAT_FILE=acrobatReader.dat

REM Removing last install files
IF EXIST "%TMP%\%INFOPATH_DAT_FILE%" (
	DEL /Q "%TMP%\%INFOPATH_DAT_FILE%"
)
IF EXIST "%TMP%\%FIREFOX_DAT_FILE%" (
	DEL /Q "%TMP%\%FIREFOX_DAT_FILE%"
)
IF EXIST "%TMP%\%ACROBAT_DAT_FILE%" (
	DEL /Q "%TMP%\%ACROBAT_DAT_FILE%"
)

REM Looking for Infopath
regedit /e %TMP%\%INFOPATH_DAT_FILE% "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Applications\infopath.exe"
regedit /e %TMP%\%INFOPATH_DAT_FILE% "HKEY_LOCAL_MACHINE\SOFTWARE\\Microsoft\Windows\CurrentVersion\App Paths\infopath.exe"

IF NOT EXIST "%TMP%\%INFOPATH_DAT_FILE%" (
	SET INFOPATH_DETECTED="Not Detected"
	SET SHOW_MISSING_SOFT_PAGE=1
) ELSE (
	SET INFOPATH_DETECTED="Detected"
)

REM Looking for FireFox
regedit /e %TMP%\%FIREFOX_DAT_FILE% "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Applications\firefox.exe"
regedit /e %TMP%\%FIREFOX_DAT_FILE% "HKEY_LOCAL_MACHINE\SOFTWARE\\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe"

IF NOT EXIST "%TMP%\%FIREFOX_DAT_FILE%" (
	SET FIREFOX_DETECTED="Not Detected"
	SET SHOW_MISSING_SOFT_PAGE=1
) ELSE (
	SET FIREFOX_DETECTED="Detected"
	SET FIREFOX_INSTALLED=1
)

REM Looking for Acrobat Reader
regedit /e %TMP%\%ACROBAT_DAT_FILE% "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Applications\AcroRD32.exe"
regedit /e %TMP%\%ACROBAT_DAT_FILE% "HKEY_LOCAL_MACHINE\SOFTWARE\\Microsoft\Windows\CurrentVersion\App Paths\AcroRd32.exe"

IF NOT EXIST "%TMP%\%ACROBAT_DAT_FILE%" (
	SET ACROBAT_DETECTED="Not Detected"
	SET SHOW_MISSING_SOFT_PAGE=1
) ELSE (
	SET ACROBAT_DETECTED="Detected"
)

REM Update license in the jar
call "%ANT_HOME%\bin\ant" -q -f "%INSTALLDIR%\script\updateInstaller.xml" -Dbasedir="%INSTALLDIR%"

REM ============================================================================
REM Check if OpenMRS is already installed
REM
IF EXIST "%OPENMRS_APPDATA%" (
	echo Detected %OPENMRS_APPDATA%
	GOTO UNINSTALL
)
IF EXIST "%PROGRAMFILES%\WHO\OpenMRS\%TOMCATDIR%" (
	echo Detected %PROGRAMFILES%\WHO\OpenMRS\%TOMCATDIR%
	GOTO UNINSTALL
)

echo Installing in %DESTINATIONDIR%
start javaw -jar "%INSTALLDIR%\lib\installer.jar"
GOTO END

:UNINSTALL
start javaw -jar "%INSTALLDIR%\lib\uninstaller.jar"

:END

