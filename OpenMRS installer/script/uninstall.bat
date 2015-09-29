@echo off

call "%CD%\openMRSEnv.bat"

REM Copy the uninstaller in the temp dir to be able to delete 
REM Copy the uninstaller in the temp dir to be able to delete 
IF NOT EXIST "%TMP%\OpenMRS_uninstaller" (
	mkdir "%TMP%\OpenMRS_uninstaller"
)	
COPY "%INSTALLDIR%\lib\uninstaller.jar" /B "%TMP%\OpenMRS_uninstaller" /Y  > NUL

cd "%TMP%\OpenMRS_uninstaller"

start javaw -jar uninstaller.jar

exit