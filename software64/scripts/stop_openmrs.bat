runas /user:Administrator
@echo off

echo Stop OpenMRS Tomcat
net stop OpenmrsTomcat

echo Stop Mysql
net stop MySQL

echo OpenMRS is stopped

pause

exit