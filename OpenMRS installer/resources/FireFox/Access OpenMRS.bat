@echo off

IF EXIST "%ProgramFiles%\Mozilla Firefox\Firefox.exe"  (
	"%ProgramFiles%\Mozilla Firefox\Firefox.exe" http://localhost:@tomcat.port@/openmrs
) ELSE (
	START http://localhost:@tomcat.port@/openmrs
)