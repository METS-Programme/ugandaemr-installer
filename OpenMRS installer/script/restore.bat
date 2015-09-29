@echo off

call "%CD%\openMRSEnv.bat"

SET BACKUPDIR=%DESTINATIONDIR%\backup

start javaw -jar "%INSTALLDIR%\lib\restore.jar"

exit