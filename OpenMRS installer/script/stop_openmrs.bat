@echo off

echo Stop Tomcat
net stop OpenmrsTomcat

echo Stop Mysql
net stop OpenmrsMySQL

echo OpenMRS is stopped

pause

exit