@echo off

echo Start Tomcat
net start OpenmrsTomcat

echo Start MySQL
net start OpenmrsMySQL

echo OpenMRS is started

pause

exit