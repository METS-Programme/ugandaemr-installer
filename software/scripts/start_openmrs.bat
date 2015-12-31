runas /user:Administrator
@echo off

echo Start Tomcat
net start OpenmrsTomcat

echo Start MySQL
net start MySQL

echo OpenMRS is started

pause

exit