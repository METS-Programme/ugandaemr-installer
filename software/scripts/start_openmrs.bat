runas /user:Administrator
@echo off

echo Start UgandaEMR Tomcat
net start UgandaEMRTomcat

echo Start MySQL
net start MySQL

echo OpenMRS is started

pause

exit