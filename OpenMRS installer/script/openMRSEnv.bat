@echo off

REM
REM	Set application environment variable
REM

SET INSTALLDIR=%CD%
SET RESOURCEDIR=%INSTALLDIR%\..\OpenMRS and third party software
SET ANT_HOME=%RESOURCEDIR%\apache-ant-1.7.1
SET INSTALLERDIR=%INSTALLDIR%\..\OpenMRS installer
SET DOCDIR=%INSTALLDIR%\..\Documentation
SET TOMCATDIR=apache-tomcat-6.0.16
SET BIRTDIR=birt-runtime-2_3_2
SET MYSQLDIR=mysql-5.0.51a-win32
SET JRE=jre-6u5-windows-i586-p-s.exe
SET OPENMRSDIR=OpenMRS
REM SET OPENMRS_DUMP=OpenMRS_Lite_DB_Dec-10-2009.sql
SET OPENMRS_DUMP=OpenMRS_Lite_DB_Uganda_Mar-12-2010.sql
SET OPENMRS_WAR=openmrs.war
SET OPENMRS_ICON=openmrs.ico
SET OPENMRS_DB=openmrs
SET OPENMRS_APPDATA=%ALLUSERSPROFILE%\OpenMRS
SET OPENMRS_README=%INSTALLDIR%\..\README.htm
SET MYSQL_PASSWORD=test
SET MENUDIR=%ALLUSERSPROFILE%\Start Menu\Programs\OpenMRS
SET DESKTOPDIR=%ALLUSERSPROFILE%\Desktop
SET DEFAULT_TOMCAT_PORT=8079
SET DEFAULT_MYSQL_PORT=3307

REM ============================================================================
REM	Figure out which Program Files directory to use.  If we're 
REM	running a 64 bit version of windows, we need to use the directory for 32 bit apps.
REM

SET PROGRAMFILES=%ProgramFiles%

IF NOT EXIST "%ProgramFiles%" (
	SET PROGRAMFILES="c:\Program Files"
)

REM ============================================================================
REM	Check if Java has been installed.  If not, install the
REM	version included in this package
REM

IF EXIST "%PROGRAMFILES%\java\jre1.6.0_05\bin\java.exe" (
	echo Java 1.6.0_05 runtime already installed...
) ELSE (
	echo Installing Java 1.6.0_05 runtime in %PROGRAMFILES%...
	"%RESOURCEDIR%\%JRE%" /quiet /passive
)

SET JAVA_HOME = %PROGRAMFILES%\java\jre1.6.0_05
SET JRE_HOME = %PROGRAMFILES%\java\jre1.6.0_05

REM ============================================================================
REM Check for tools.jar, and copy it to not pop the warning message
REM
IF NOT EXIST "%PROGRAMFILES%\java\jre1.6.0_05\lib\tools.jar" (
	XCOPY "%RESOURCEDIR%\tools.jar" "%PROGRAMFILES%\java\jre1.6.0_05\lib\"
) 

REM ============================================================================
REM Figure out where to install OpenMRS
REM
set DESTINATIONDIR=%PROGRAMFILES%\WHO\OpenMRS
